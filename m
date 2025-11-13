Return-Path: <linux-pm+bounces-37938-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8793FC570D5
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 11:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2971E3BF0EE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 10:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82753375DC;
	Thu, 13 Nov 2025 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4uxktny"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A855133557B;
	Thu, 13 Nov 2025 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031200; cv=none; b=bUx/D5HbEnsni/ysqJXhnhAXhUnywPNzkfy2+EiWy6GCFWv9/RasSHVfZP4TAXchYoTb3RNf5o1urpvLRQ5HmHQElS+jV2qYsPo/bvdbC6RqeYNMbYO96hzKnGfFTIIpxZdotAB1C81WeTQd9YdHBI4pjcIDqgaVU/IbRBzbpGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031200; c=relaxed/simple;
	bh=WD1eHRZg/E1iJWZJQuMrmEB9JmiKlqDDuLkhtxtaeuw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=FTOTsrVUAjKbNoRmcEDBZpP+Wwv8RYojyY8G7tr9y62kwI/zFcbrw2PIvhFxuUvqGSz6/pLJPrXpnvfvJlP4uQh6ymNHGLf4cuWIMafYU+fZZPSm7ZIKJRBVUOCtu1Fwjm0GnIc/LQUvS2jRUocWIhHb2rlDmCXtzeO5h1cf5LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4uxktny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1729C4CEFB;
	Thu, 13 Nov 2025 10:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763031200;
	bh=WD1eHRZg/E1iJWZJQuMrmEB9JmiKlqDDuLkhtxtaeuw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=K4uxktny044y2ZRoFpjOdAB6w7+q0Fr+beZ1F5hnO8pf0gmE1ty6LpOOPW8KScZ5w
	 zcZVqGvEp+52b07jnKtmqfSP2wQhWL/a/BR19cE7A2AvOu4dPBlh1/nSNHYzlWuyYF
	 XFOZOliXPWJbsln6oD/2grEEgG0cvSqv3tEULNntfgbRPnRFGpZJdFFKMQGdS1nECq
	 srwaF232nN5blJmoz71ftmp2jmIJjOGgxFfCyrTn3NTEx+IrU7+zQQK3usm5qEgVYW
	 XcDQlpCWN2e0EmsPhv9imzlIm09XU1WtCNJEEVBQdCf0FiNHsbtQ1ztgNTRVEyvtK/
	 mMH93ZCtamiBw==
Date: Thu, 13 Nov 2025 04:53:18 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, 
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
 linux-leds@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-gpio@vger.kernel.org, 
 linux-pm@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-rtc@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
In-Reply-To: <ac5a4e992e4fb9c7bffb1e641a7cd61f74af4cba.1763022807.git.mazziesaccount@gmail.com>
References: <cover.1763022807.git.mazziesaccount@gmail.com>
 <ac5a4e992e4fb9c7bffb1e641a7cd61f74af4cba.1763022807.git.mazziesaccount@gmail.com>
Message-Id: <176303119683.3716572.16868393928566655866.robh@kernel.org>
Subject: Re: [PATCH v4 04/16] dt-bindings: power: supply: BD72720 managed
 battery


On Thu, 13 Nov 2025 10:52:19 +0200, Matti Vaittinen wrote:
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
>  v3 =>:
>  - No changes
> 
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/ac5a4e992e4fb9c7bffb1e641a7cd61f74af4cba.1763022807.git.mazziesaccount@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


