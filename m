Return-Path: <linux-pm+bounces-38290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C858C73561
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 10:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C38A44E2A5C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 09:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C264830E83D;
	Thu, 20 Nov 2025 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvpirHjJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ECD304BD7;
	Thu, 20 Nov 2025 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763632642; cv=none; b=Tcm6sTkT5bM14LzSobmJpuOXzGtBRZrfw3IpsNMTisnlAAtLvwHQqM0eiLRV7y0Kr365b+XtFv76q+A0GeR9NfIRbYxv/NtQwP2IonEU9mp6sy9I9HcnkN7l6vwBGU1AJVCs/pzj4X7moLb/7+QOLJyxM0YkS2Zo2RK202cG344=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763632642; c=relaxed/simple;
	bh=WWvza9V1Q2u8DbMFgQRM3aXZHjVB5evXtyFIWbL5gTc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=YwTTmzDfqUF6oYpTuL6mwJSKMi/IxwGfA68+L2H1Squ/Gw7fxCEHELLNdM3XwfGoe9bK7Xae/Jzrl1HMpa/r67/juF/hv5jgsR8+68iK58p21anUOAEgvyyaF07EGyk1yWpW7lNK59OBXEXA7xbD+yauC5q2oKCeBz++LzI2gr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvpirHjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D20C4CEF1;
	Thu, 20 Nov 2025 09:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763632642;
	bh=WWvza9V1Q2u8DbMFgQRM3aXZHjVB5evXtyFIWbL5gTc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=MvpirHjJ+ZIRqw3cN0N1IEkiTBhIqW96zK528S8uL1FQKZ0Pacm4NeuAghOlsmDgP
	 W5O0Sbo5s1e3d/JuFq3polCo8DgwC8S3yMjS2QOjkDPNyW/UwT5BZ9fM51kB41TMP3
	 Krjf+Yj8NrH7/hWmhp1x78WvqFZjgaeD2ylsnjm6gCFO1X12GSZqMWo1YnMEFnH3Du
	 WNO9RFitMK3ubzzObHcM8q8uSWICWKr1tX6JYR8WqB64IUcVyhUICJk9EecBGtojSK
	 0WBQmlNbZ+kENzw2VXKhrwpeZUOJ6AdP75eDAPqbKxs1wFITwMVKE/690YpewMTAmf
	 w4WWZ7HzL7m5g==
Date: Thu, 20 Nov 2025 03:57:20 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-gpio@vger.kernel.org, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Conor Dooley <conor+dt@kernel.org>, 
 linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, linux-clk@vger.kernel.org, 
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
 Andreas Kemnade <andreas@kemnade.info>, Lee Jones <lee@kernel.org>, 
 linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@linux.dev>
In-Reply-To: <28726d1e0573a6efb6e70716a23ba27c4fc93c6d.1763625920.git.mazziesaccount@gmail.com>
References: <cover.1763625920.git.mazziesaccount@gmail.com>
 <28726d1e0573a6efb6e70716a23ba27c4fc93c6d.1763625920.git.mazziesaccount@gmail.com>
Message-Id: <176363264051.648957.5833707932747052681.robh@kernel.org>
Subject: Re: [PATCH v5 01/16] dt-bindings: regulator: ROHM BD72720


On Thu, 20 Nov 2025 10:19:40 +0200, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The ROHM BD72720 is a new PMIC with 10 BUCk and 11 LDO regulators.
> 
> The BD72720 is designed to support using the BUCK10 as a supply for
> the LDOs 1 to 4. When the BUCK10 is used for this, it can be set to a
> LDON_HEAD mode. In this mode, the BUCK10 voltage can't be controlled by
> software, but the voltage is adjusted by PMIC to match the LDO1 .. LDO4
> voltages with a given offset. Offset can be 50mV .. 300mV and is
> changeable at 50mV steps.
> 
> Add 'ldon-head-microvolt' property to denote a board which is designed
> to utilize the LDON_HEAD mode.
> 
> All other properties are already existing.
> 
> Add dt-binding doc for ROHM BD72720 regulators to make it usable.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> 
> ---
> Revision history:
>  v4 =>
>  - No changes
> 
>  v3 => v4:
>  - Drop type from ldon-head
>  - Fix the name patterns for regulator nodes and names
> 
>  v2 => v3:
>  - drop unnecessary descriptions
>  - use microvolts for the 'ldon-head' dt-property
> 
>  RFCv1 => v2:
>  - No changes
> ---
>  .../regulator/rohm,bd72720-regulator.yaml     | 148 ++++++++++++++++++
>  1 file changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd72720-regulator.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/regulator/rohm,bd72720-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
Documentation/devicetree/bindings/regulator/rohm,bd72720-regulator.yaml: Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/28726d1e0573a6efb6e70716a23ba27c4fc93c6d.1763625920.git.mazziesaccount@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


