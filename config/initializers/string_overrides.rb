class String
	def correct
		WordCorrection.correct(self)
	end

  def humanize
    if self.only_have_numbers?
      self.to_i.humanize
    else
      self
    end
  end

  def only_have_numbers?
    self.scan(/\D/).empty?
  end
end