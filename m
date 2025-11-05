Return-Path: <linux-pm+bounces-37423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AFBC34ABB
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 10:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADA174FC25C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 09:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73962F066A;
	Wed,  5 Nov 2025 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/KPLMib"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F1F2D948F;
	Wed,  5 Nov 2025 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333214; cv=none; b=VUKYo2ZXWM52f0468T7qTXYE9CPfDHbAV7ub72dd2t8c6bBeDEPWmirj03D+SNMKN3csl+eolWAKGarGoLgdjk/xS5WL1xF6+CMpvt0j6cT2nx+YAa2nxFti4/ftdIqqKkJzkYvcTQMfJCiReYkgQBhUWUUC+82UJtNJZqzOzqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333214; c=relaxed/simple;
	bh=yKua4EFf/iQ9wqQ49OIZDbWZGZXzrKwgI56kqg8U9bI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=K6SA7ZJH5J7h8nm6rYCRxDzELqlc57STgrLLN9Oc1H5DmzaH4/qiNAuGtln5GQSyR1NLXCnevvAJtlvHrpVZkaUG02Q9PJ3/bVnVBHf3MqXsE+Hh6JrwkCpG7P3DDvUeRFQB+p3S9skMVxdRfgWRKsRWL1bUuGwCX2nlLQw29Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/KPLMib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79F8C4CEFB;
	Wed,  5 Nov 2025 09:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762333214;
	bh=yKua4EFf/iQ9wqQ49OIZDbWZGZXzrKwgI56kqg8U9bI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=A/KPLMibnINLMRVsLQd1DDnNoe1f70o5j/npukAxp624gpaLMEFr1GG5t5Qr6yMG3
	 4lPC2a/HqEEgJZl5V7ejjH6R1BA7k5VGLp7OQ3vV47Rcr3QX87SdMomgh51/beWmla
	 KPgFroOOHq8IDKVSwIaWt0YYmgLoFNaO5hsYvp3eUjFDoGBWGbb45v/729t6Kg0xF3
	 vK/fbHBOfS/NdiBlqUN5uFz7zBwiN+0+gbVc2l22YXjn63HvMcRWjdNQPV+1aiv6qR
	 Jv1zMzDA75P4njxJqP1ESuKho+8bvsIgWb3CHRTOouEFgIP3VzO2jGSD3O9LDIK9W2
	 hm4fSJ+7Y7/sA==
Date: Wed, 05 Nov 2025 03:00:12 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, Andreas Kemnade <andreas@kemnade.info>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, Stephen Boyd <sboyd@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-leds@vger.kernel.org, 
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
 Michael Turquette <mturquette@baylibre.com>, linux-rtc@vger.kernel.org, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
In-Reply-To: <48fe6e2642db4484640b173cd71be1b245929122.1762327887.git.mazziesaccount@gmail.com>
References: <cover.1762327887.git.mazziesaccount@gmail.com>
 <48fe6e2642db4484640b173cd71be1b245929122.1762327887.git.mazziesaccount@gmail.com>
Message-Id: <176233320981.143013.4115240062372455834.robh@kernel.org>
Subject: Re: [PATCH v3 01/16] dt-bindings: regulator: ROHM BD72720


On Wed, 05 Nov 2025 09:35:59 +0200, Matti Vaittinen wrote:
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
>  v2 => v3:
>  - drop unnecessary descriptions
>  - use microvolts for the 'ldon-head' dt-property
> 
>  RFCv1 => v2:
>  - No changes
> ---
>  .../regulator/rohm,bd72720-regulator.yaml     | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd72720-regulator.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/rohm,bd72720-regulator.yaml: patternProperties:^buck[1-10]$:properties:rohm,ldon-head-microvolt: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml

doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/regulator/rohm,bd72720-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
Documentation/devicetree/bindings/regulator/rohm,bd72720-regulator.yaml: Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/48fe6e2642db4484640b173cd71be1b245929122.1762327887.git.mazziesaccount@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


