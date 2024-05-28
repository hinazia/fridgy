class ChatService
  def initialize(ingredients, meal_type, category)
    @ingredients = ingredients
    @meal_type = meal_type
    @category = category
  end

  def get_title_and_content
    build_prompt
    send_prompt_to_api
    set_title_and_content
  end

  def build_prompt
    ingredients = ''
    @ingredients.each do |ingredient|
      ingredients += "#{ingredient.amount} #{ingredient.measurement} of #{ingredient.name},"
    end
    # Build a string to send to ChatGPT with ingredients, meal_type and category
    @prompt = "Hello ChatGPT!! Please, Can you give me the Recipe based on these #{ingredients} , for a #{@meal_type} meal, of the  #{@category} cuisine"
  end

  def send_prompt_to_api
    client = OpenAI::Client.new
    chaptgpt_response = client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: @prompt}]
    })
    @response =  chaptgpt_response["choices"][0]["message"]["content"]

  end

  def set_title_and_content
  end
end
