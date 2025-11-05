Return-Path: <linux-pm+bounces-37424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7E5C34A94
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 10:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0917561F59
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 09:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247BE2F12B7;
	Wed,  5 Nov 2025 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkk/g2HF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC752F12A5;
	Wed,  5 Nov 2025 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333216; cv=none; b=hCbqhp9OrVVpcWxjyUhEO3+E41W0CrpYdtgirvGO0YuxLyKgO01RkM/gCoRXsTBlhUQie81l+9cSAj4e2pbii3rITBp6rDzNPg9kZmt4dBPkrh3rzcKamiLhlSurz64FQW1GOPMxtVXG8jbUZJZegqDwLxAEoz3k6l1qWU8srL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333216; c=relaxed/simple;
	bh=rEzwEs+yJAIoQExDfVRQ9vn4jFUd5q2ZMcOlcMimKqs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Q3FTkJhIFc5aTkUDq+1bTxwvKyzpBJvIvJ+bxpJwlKYJXHlKkRFw6p+89oe/1Ff6XZmnDI2UEPhLwh1xZN1DOfwp+AKYlmWkDLX16tzdl7Y/d45juoKU/lUhDtHMDBi48bxLGwDLqbUfd3yXm4FJJcBCGe8QH+It5F80nG2qi9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkk/g2HF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BABC116B1;
	Wed,  5 Nov 2025 09:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762333215;
	bh=rEzwEs+yJAIoQExDfVRQ9vn4jFUd5q2ZMcOlcMimKqs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=qkk/g2HFQsw36jgb+BG6+sHZFJCiPoiZr4OUOZjXtnFUgUL6rNzcUukcJio9Xx9Uq
	 aT0gljuWDVheRc1wULO3Fr2cLJvrqxbeDQ56b/GhcL0pdKtAT/uXdkt+gF+lM0LBas
	 m7e1FRGPEVCWHfL9WQFnUZeS5K7ZaOvFaDBXdFYbGc/Cmn4+tu5b3zqgjlsNi4A2Pq
	 8TVR9SJJ+gyTn4Lm7ro+cT8z4i8tLaBmu/JTTNVirrp1/lxGEx2sQbCV+SqGoEJihO
	 NtOtQLZmj8E/V0AJ+rZ7q5YYFJAZIqBVPu4843Dl9k1MatNFGjBCJ45S27w+s693E5
	 Cu4FtSzHzXDzg==
Date: Wed, 05 Nov 2025 03:00:14 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 linux-rtc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, 
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Pavel Machek <pavel@kernel.org>, linux-leds@vger.kernel.org, 
 Sebastian Reichel <sre@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Matti Vaittinen <mazziesaccount@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Andreas Kemnade <andreas@kemnade.info>, 
 Lee Jones <lee@kernel.org>, linux-clk@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
In-Reply-To: <a45e7230ecd08eed2081cbe7e7b4719d1fc8a581.1762327887.git.mazziesaccount@gmail.com>
References: <cover.1762327887.git.mazziesaccount@gmail.com>
 <a45e7230ecd08eed2081cbe7e7b4719d1fc8a581.1762327887.git.mazziesaccount@gmail.com>
Message-Id: <176233321101.143066.16817673032324313304.robh@kernel.org>
Subject: Re: [PATCH v3 04/16] dt-bindings: power: supply: BD72720 managed
 battery


On Wed, 05 Nov 2025 09:36:49 +0200, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The BD72720 PMIC has a battery charger + coulomb counter block. These
> can be used to manage charging of a lithium-ion battery and to do fuel
> gauging.
> 
> ROHM has developed a so called "zero-correction" -algorithm to improve
> the fuel-gauging accuracy close to the point where battery is depleted.
> This relies on battery specific "VDR" tables, which are measured from
> the battery, and which describe the voltage drop rate. More thorough
> explanation about the "zero correction" and "VDR" parameters is here:
> https://lore.kernel.org/all/676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohmeurope.com/
> 
> Document the VDR zero-correction specific battery properties used by the
> BD72720 and some other ROHM chargers.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> ---
> NOTE:
> Linus' rb-tag holds only if there's no further comments from Rob.
> 
> Revision history:
>  v2 => v3:
>  - Constrain VDR threshold voltage to 48V
>  - Use standard '-bp' -suffix for the rohm,volt-drop-soc
> 
>  RFCv1 => v2:
>  - Add units to rohm,volt-drop-soc (tenths of %)
>  - Give real temperatures matching the VDR tables, instead of vague
>    'high', 'normal', 'low', 'very low'. (Add table of temperatures and
>    use number matching the right temperature index in the VDR table name).
>  - Fix typoed 'algorithm' in commit message.
> 
> The parameters are describing the battery voltage drop rates - so they
> are properties of the battery, not the charger. Thus they do not belong
> in the charger node.
> 
> The right place for them is the battery node, which is described by the
> generic "battery.yaml". I was not comfortable with adding these
> properties to the generic battery.yaml because they are:
>   - Meaningful only for those charger drivers which have the VDR
>     algorithm implemented. (And even though the algorithm is not charger
>     specific, AFAICS, it is currently only used by some ROHM PMIC
>     drivers).
>   - Technique of measuring the VDR tables for a battery is not widely
>     known. AFAICS, only folks at ROHM are measuring those for some
>     customer products. We do have those tables available for some of the
>     products though (Kobo?).
> ---
>  .../power/supply/rohm,vdr-battery.yaml        | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,vdr-battery.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/rohm,vdr-battery.example.dtb: battery (simple-battery): 'degrade-cycle-microamp-hours', 'rohm,volt-drop-0-microvolt', 'rohm,volt-drop-1-microvolt', 'rohm,volt-drop-2-microvolt', 'rohm,volt-drop-3-temp-microvolt', 'rohm,volt-drop-soc-bp', 'rohm,volt-drop-temperatures-millicelsius', 'rohm,voltage-vdr-thresh-microvolt' do not match any of the regexes: '^ocv-capacity-table-[0-9]+$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/power/supply/battery.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/a45e7230ecd08eed2081cbe7e7b4719d1fc8a581.1762327887.git.mazziesaccount@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


