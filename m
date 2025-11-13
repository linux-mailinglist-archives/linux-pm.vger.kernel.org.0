Return-Path: <linux-pm+bounces-37937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F06C57099
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 11:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C89D84E775F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 10:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30DD33373C;
	Thu, 13 Nov 2025 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHVI44/b"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C02D0607;
	Thu, 13 Nov 2025 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031198; cv=none; b=DsrZNXgCqQa7vTTQjr2Qibn+VlqZlzV7VCp0ddE23MpwY3V/lb+H5U3X6OXwchnta1AODMOxXM1Vjes+7vBy4E1UKkOys6Q2wmXznjuXB34IfOt8EuNJK7NxGYOc8OvDRBp89QqAbCJh/vhhPht/5duqTYSASTjomjQKl7XrD0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031198; c=relaxed/simple;
	bh=uZaV1bT4pX7S0mVXWQg2NY2WW48TO3+pI6FV4aqde3g=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=TVX53YnLpn33UhIl7JZ0+NdD0UFzlKJcDM470dNf/3aU9BTPk3kDorIOq5iTK88gF0YxdUiGB/2851s9vlwhJF1pFR6GZyvP4o6kEWAq4Gx5cXTiBNOJaj57sL1OudDCwPrKSUzro09d3swV88vhklCRWlppVVQFnVI7GrOePIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHVI44/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF2EC19421;
	Thu, 13 Nov 2025 10:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763031198;
	bh=uZaV1bT4pX7S0mVXWQg2NY2WW48TO3+pI6FV4aqde3g=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=vHVI44/bxvYiWMxRd2Jooqjkzq4L7OQSas3WhcHmG4a3qXW+tmKa1QeHirmFs+0MD
	 odMs3KEsFKJNTSYeqeuxJ27KycIjF204xubaqLgDrLBf8z0WNSa7IVUvckDhNNcttC
	 nhhlWT14KXJxCj/M3ibmI5m5ax+SiPIxI7c6X0ZfWBrDzKBG0UeKMXAHVb66wNpy+e
	 NMDQfx0RElwZgSKKoUQ+XlDIdMpGgAvRX8rtMSzwkmFnhYNmzBDCaaKJxiJfSNnn+z
	 NG6Lg/RTsEl71OI71OieC5ywrb/An+i3A3Xw9BLF86y5PJ3e7bp6XuvDCnfu5bkDq0
	 p5IYQ1+TLlxdg==
Date: Thu, 13 Nov 2025 04:53:16 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, devicetree@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, 
 linux-clk@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>, 
 Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org, 
 Matti Vaittinen <mazziesaccount@gmail.com>, linux-leds@vger.kernel.org, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-rtc@vger.kernel.org, 
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
In-Reply-To: <21e83fccf2d2422f4bea1c482dcd3cb1aeda4085.1763022807.git.mazziesaccount@gmail.com>
References: <cover.1763022807.git.mazziesaccount@gmail.com>
 <21e83fccf2d2422f4bea1c482dcd3cb1aeda4085.1763022807.git.mazziesaccount@gmail.com>
Message-Id: <176303119577.3716534.8630343707123370979.robh@kernel.org>
Subject: Re: [PATCH v4 01/16] dt-bindings: regulator: ROHM BD72720


On Thu, 13 Nov 2025 10:51:32 +0200, Matti Vaittinen wrote:
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
> 
> ---
> Revision history:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/21e83fccf2d2422f4bea1c482dcd3cb1aeda4085.1763022807.git.mazziesaccount@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


