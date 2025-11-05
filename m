Return-Path: <linux-pm+bounces-37425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39F1C34AA3
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 10:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA774562966
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 09:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55262F28FF;
	Wed,  5 Nov 2025 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQSpMrp5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2042F1FF6;
	Wed,  5 Nov 2025 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333217; cv=none; b=l54zp86arSGkjCC7mt+WbaO2FZW9BDGC/5MCmOVgQSIGBonUdf/IPv6WxMg71wvd+UML6DPTBX626oQqxYuc9un37403EvKZ1bIOSOaSfCm5ZSvpPz0i++a5IiLlS3/fT2qjcbt1eFbxkGy2OhZXQvlK00UY/WNehYjZssJa2DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333217; c=relaxed/simple;
	bh=mALZctJs/9dp1bCogwM4mpUTnfClhw7K46Gj7Mnbab4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=sSa7q+Y8oX0YYNZFAJsQAUCwUFfsKjMDQEQgPCwxzX39WIqXlGetQpVIRxsfGiyMav+zxBHzwYv8BGbSFxGHhuziDZLpUKk8fgBGS/vqashRGtNfxDSrjPzClEJ7Rmu8gWEJ/2wOr5fYvrWrXNKnlO2KrzAqnqLxOORqAszB3Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQSpMrp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C117C116B1;
	Wed,  5 Nov 2025 09:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762333217;
	bh=mALZctJs/9dp1bCogwM4mpUTnfClhw7K46Gj7Mnbab4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=qQSpMrp5d8GejVnUMCtTUq+S+CG7Fiy+dV9P8kLzL52NrEgebzlTCImpwXC0FVBK/
	 HZw6zZhvbi878frUBVJJAxMGpZIxejTFy0G5t7ebsJ7uRGoJ5PqqgRg9hBdvwZwTzY
	 9UXXwNmxqtCkYuRuqdd1MbHA+RUF/x3ww2zSLO7Kz6yEZQ8LzfPb6Bnn17TWs4mXgJ
	 y6psk5nuzGdNb2h5b5M7kEo+uUo7LONkzzjfMg4obPCT6fxidMc3CX/KkKnMnjJAWj
	 axrZg6zaQ7VU3KSl7t2dMYEL61fBRnNz+gAMlwlO1tz0rguRjaL2IbElUAHYwrK/MV
	 jdzFugz98u//Q==
Date: Wed, 05 Nov 2025 03:00:15 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 linux-clk@vger.kernel.org, Matti Vaittinen <mazziesaccount@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 linux-rtc@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Michael Turquette <mturquette@baylibre.com>, devicetree@vger.kernel.org, 
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Mark Brown <broonie@kernel.org>, 
 Andreas Kemnade <andreas@kemnade.info>, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
In-Reply-To: <4c7ea0c83f4bb4af65439a9b8951d50ee705d22c.1762327887.git.mazziesaccount@gmail.com>
References: <cover.1762327887.git.mazziesaccount@gmail.com>
 <4c7ea0c83f4bb4af65439a9b8951d50ee705d22c.1762327887.git.mazziesaccount@gmail.com>
Message-Id: <176233321210.143104.455177775703669783.robh@kernel.org>
Subject: Re: [PATCH v3 05/16] dt-bindings: mfd: ROHM BD72720


On Wed, 05 Nov 2025 09:37:05 +0200, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The ROHM BD72720 is a power management IC integrating regulators, GPIOs,
> charger, LEDs, RTC and a clock gate.
> 
> Add dt-binding doc for ROHM BD72720.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
>  v2 => v3:
>  - Styling
>  - Document all pin functions
>  - use pattern-properties
>  - re-use existing Rsense binding
>  - correct the example
> 
>  RFCv1 => v2:
>  - Typofixes
> ---
>  .../bindings/mfd/rohm,bd72720-pmic.yaml       | 273 ++++++++++++++++++
>  1 file changed, 273 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml: Unresolvable reference: /schemas/regulator/rohm,bd77270-regulator.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.example.dtb: pmic@4b (rohm,bd71828): 'rohm,pin-dvs0', 'rohm,pin-dvs1', 'rohm,pin-exten0', 'rohm,pin-exten1', 'rohm,pin-fault_b' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/mfd/rohm,bd71828-pmic.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/4c7ea0c83f4bb4af65439a9b8951d50ee705d22c.1762327887.git.mazziesaccount@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


