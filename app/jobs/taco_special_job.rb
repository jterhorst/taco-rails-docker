class TacoSpecialJob < ApplicationJob

    class_attribute :cron_expression

    class << self

        def schedule
            set(cron: cron_expression).perform_later unless scheduled?
        end

        def remove
            delayed_job.destroy if scheduled?
        end

        def scheduled?
            delayed_job.present?
        end

        def delayed_job
            Delayed::Job
                .where('handler LIKE ?', "%job_class: #{name}%")
                .first
        end

    end

    def perform
        name = Faker::Food.dish
        description = Faker::Food.description
        price = Faker::Number.decimal(l_digits: 1, r_digits: 2)
        meat = Faker::Boolean.boolean ? "beef" : "chicken"
        Taco.create(name: name, price: price, description: description, cheese: Faker::Boolean.boolean, lettuce: Faker::Boolean.boolean, meat: meat, tortilla: Faker::Boolean.boolean, beans: Faker::Boolean.boolean)
    end

end