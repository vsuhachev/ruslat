describe Ruslat::Core do
  before { extend described_class }

  describe '.lat_to_rus' do
    it { a = 'Zz'; expect { lat_to_rus(a) }.to_not(change { a }) }
    it { expect(lat_to_rus('Gadya Petrovich Xrenovo')).to eq('Гадя Петрович Хреново') }
  end

  describe '.rus_to_lat' do
    it { a = 'Ыы'; expect { rus_to_lat(a) }.to_not(change { a }) }
    it { expect(rus_to_lat('Примелькавшийся')).to eq('Primeljkavshijsya') }
  end

  describe '.case_correct' do
    it { a = 'ALYoShA'; expect { case_correct(a) }.to_not(change { a }) }

    it { expect(rus_to_lat('АЛЁША')).to eq('ALYoShA') }
    it { expect(case_correct(rus_to_lat('АЛЁША'))).to eq('ALYOSHA') }

    it { expect(rus_to_lat('Я КРЕВЕДКО')).to eq('Ja KREVEDKO') }
    it { expect(case_correct(rus_to_lat('Я КРЕВЕДКО'))).to eq('JA KREVEDKO') }
  end

  describe '.rus_typo_correct' do
    it { a = 'Capa'; expect { rus_typo_correct(a) }.to_not(change { a }) }
    it { expect(rus_typo_correct('Пpивeт')).to eq('Привет') }
  end

  describe '.lat_typo_correct' do
    it { a = 'Sаrа'; expect { lat_typo_correct(a) }.to_not(change { a }) }
    it { expect(lat_typo_correct('Sаrа')).to eq('Sara') }
  end
end
