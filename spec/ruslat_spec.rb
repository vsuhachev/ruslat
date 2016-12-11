require 'spec_helper'

describe Ruslat do
  before { extend Ruslat::Core }

  describe '.lat_to_rus' do
    it { expect(lat_to_rus('Gadya Petrovich Xrenovo')).to eq('Гадя Петрович Хреново') }
  end

  describe '.rus_to_lat' do
    it { expect(rus_to_lat('Примелькавшийся')).to eq('Primeljkavshijsya') }
  end

  describe '.case_correct' do
    it { expect(rus_to_lat('АЛЁША')).to eq('ALYoShA') }
    it { expect(case_correct(rus_to_lat('АЛЁША'))).to eq('ALYOSHA') }

    it { expect(rus_to_lat('Я КРЕВЕДКО')).to eq('Ja KREVEDKO') }
    it { expect(case_correct(rus_to_lat('Я КРЕВЕДКО'))).to eq('JA KREVEDKO') }
  end

  describe '.typo_correct' do
    it { expect(typo_correct('Пpивeт')).to eq('Привет') }
  end
end
