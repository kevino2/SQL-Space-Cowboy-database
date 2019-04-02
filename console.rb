require('pry-byebug')
require_relative('models/bounty_class.rb')

wanted1 = Bounty.new ({ 'name' => 'Gregor',
                        'species' => 'Wookie',
                        'bounty_value' => '1000',
                        'last_known_location' => 'Endor'
                        })

wanted1.save()


wanted2 = Bounty.new ({ 'name' => 'Bobby',
                        'species' => 'Moonman',
                        'bounty_value' => '20000',
                        'last_known_location' => 'Jupiter'
                         })
wanted2.save()

wanted3 = Bounty.new ({ 'name' => 'Jeff',
                        'species' => 'Zenomorph',
                        'bounty_value' => '80000',
                        'last_known_location' => 'C-132'
                         })
# wanted3.save()
# Bounty.delete_all()
wanted3.name = 'Geoff'
wanted3.save()
wanted2.delete()
# Bounty.find_by_name('Gregor')
