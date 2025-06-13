module StaticPagesHelper
  def gossips_post_it
    @gossips = Gossip.order("RANDOM()").limit(5)
    @gossips.each_with_index.map do |gossip, index|
      {
        gossip: gossip,
        color: [ "#fffd82", "#ffc9de", "#c9f2ff", "#d1ffc9", "#ffe0ac" ].sample,
        rotation: [ -5, 3, -2, 4, -4 ].sample,
        top: index * 40,
        left: 50,
        z: 10 - index
      }
    end
  end

  def render_post_its
    gossips_post_it.each_with_index.map do |data, i|
      content_tag(:div,
        style: "width: 200px;
                background-color: #{data[:color]};
                transform: rotate(#{data[:rotation]}deg);
                top: #{data[:top]}px;
                left: #{data[:left]}px;
                z-index: #{data[:z]};
                border: 1px solid #ccc;
                border-radius: 10px;",
        class: "postit-card shadow position-absolute p-3") do
          content_tag(:h5, truncate(data[:gossip].title, length: 25), class: "fw-bold") +
          content_tag(:p, truncate(data[:gossip].content, length: 100), class: "small") +
          link_to("Lire", Rails.application.routes.url_helpers.gossip_path(data[:gossip]), class: "btn btn-sm btn-outline-dark")
      end
    end.join.html_safe
  end


  def team
    @team_members = [
      { name: "Mathieu",     quote: "Qui sème le vent récolte la tempête.",        image: "avatar1.png" },
      { name: "Rosa",      quote: "La curiosité est un vilain défaut.",          image: "avatar2.png" },
      { name: "Bernadette",    quote: "Rien ne sert de courir, il faut partir à point.", image: "avatar3.png" },
      { name: "Florian",   quote: "Mieux vaut tard que jamais.",                 image: "avatar4.png" },
      { name: "Théo",    quote: "L’union fait la force.",                      image: "avatar5.png" },
      { name: "Melody",    quote: "On ne change pas une équipe qui gagne.",     image: "avatar6.png" }
    ]
  end
end
