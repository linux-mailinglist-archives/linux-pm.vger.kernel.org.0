Return-Path: <linux-pm+bounces-24823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02299A7C011
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 16:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A973BDDE2
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 14:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317FE1F4C95;
	Fri,  4 Apr 2025 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYq0Ahwk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D769B1F4631;
	Fri,  4 Apr 2025 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743778566; cv=none; b=OWXEAmgpiSwmmpmIiML/lezMxcwNKfHMjh0cprm2+lSaCAu+kaMXf9IU6JASs4AIh0rZTwjzjshGUapMCSHjaBVi6j4GPvBJcbnK/Wt6NsqIzBAuWv6Y0k3h9CuOU+F4Elk9k5XsI3XkC2W1ax/f3zWwEufxqgL+a5nSPuRprCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743778566; c=relaxed/simple;
	bh=ZKC9yGDKP7ZL9SggbwEVntc6h66l9cUcpFwGsLIdwyU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=lKA+zS0UMD6zZOeNFxnjNMCj9R6nqI9DB9yYT46K135ebojv/CpfWMZZjyAm3PiM6tP++k5i0URBuAKoodnyryACCX2RV0QPeJmZYimrisqd+8cqOCQYHtIjC6dI27WYKYVA/atlrQ5DYc7oSJb8xA95dGU02h5EcLp8OMcrLWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYq0Ahwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F3BC4CEDD;
	Fri,  4 Apr 2025 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743778565;
	bh=ZKC9yGDKP7ZL9SggbwEVntc6h66l9cUcpFwGsLIdwyU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=lYq0AhwkZcTUWyVwicaZ1vvM7sdLhXVWb88uIIREKJeM4f4dFtPRR+5YtBnIQ3+8S
	 4rmWfDWxmKz8BkutmGYcsQCbqBKQsOpb3vKdZoOj3zlMzyIr63+JtEno2kDqBxKGaL
	 uSpnRzGTivLPzIQSa2vlGQgFkEoHK4Djr247EPkB1MI0mgoQqCboWVbZe1YDRxstNw
	 XL6TPr4SJ3ntriVvow1CY9ZhW/TaC9VWQaFtDYXQkEycuv4vNUekj/x3m4CmjcWhg8
	 J/6CXGfE842P8cqvOhDfI5vtBqXZj1W2sAP8ubZBZr4Jve8ltlaLGaw/5ccWSyVqKq
	 iX0gZX5BzPDSQ==
Date: Fri, 04 Apr 2025 09:56:03 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor@kernel.org>, linux-rockchip@lists.infradead.org, 
 Daniel Machon <daniel.machon@microchip.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 UNGLinuxDriver@microchip.com, Jerome Brunet <jbrunet@baylibre.com>, 
 Kevin Hilman <khilman@baylibre.com>, linux-sunxi@lists.linux.dev, 
 Liviu Dudau <liviu.dudau@arm.com>, linux-arm-kernel@lists.infradead.org, 
 Fabio Estevam <festevam@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 linux-renesas-soc@vger.kernel.org, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Viresh Kumar <vireshk@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, zhouyanjie@wanyeetech.com, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Heiko Stuebner <heiko@sntech.de>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, linux-pm@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, 
 linux-mips@vger.kernel.org, imx@lists.linux.dev, 
 Samuel Holland <samuel@sholland.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-arm-msm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, 
 linux-amlogic@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
In-Reply-To: <20250403-dt-cpu-schema-v1-14-076be7171a85@kernel.org>
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
 <20250403-dt-cpu-schema-v1-14-076be7171a85@kernel.org>
Message-Id: <174377856145.1313232.11316769002552655294.robh@kernel.org>
Subject: Re: [PATCH 14/19] dt-bindings: arm/cpus: Add schemas for
 "enable-method" dependencies


On Thu, 03 Apr 2025 21:59:35 -0500, Rob Herring (Arm) wrote:
> Replace the prose for properties dependent on specific "enable-method"
> values with schemas defining the same requirements.
> 
> Both "qcom,acc" and "qcom,saw" properties appear to be required for any
> of the Qualcomm enable-method values, so the schema is a bit simpler
> than what the text said. The references to arm/msm/qcom,saw2.txt and
> arm/msm/qcom,kpss-acc.txt are out of date, so just drop them.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 82 +++++++++++++++----------
>  1 file changed, 49 insertions(+), 33 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.example.dtb: cpu@0: 'qcom,acc' is a required property
	from schema $id: http://devicetree.org/schemas/arm/cpus.yaml#

doc reference errors (make refcheckdocs):
Warning: Documentation/translations/ja_JP/process/submit-checklist.rst references a file that doesn't exist: Documentation/translations/ja_JP/SubmitChecklist
Documentation/translations/ja_JP/process/submit-checklist.rst: Documentation/translations/ja_JP/SubmitChecklist

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250403-dt-cpu-schema-v1-14-076be7171a85@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


