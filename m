Return-Path: <linux-pm+bounces-38804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2800FC8E5C4
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 14:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15C0C4E6752
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 13:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B2F265623;
	Thu, 27 Nov 2025 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bgu5tLRM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B80723A984;
	Thu, 27 Nov 2025 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764248408; cv=none; b=iKj6euHjzZd126LN3CWjZfPgNXXD0jcwjnmu+PQlswDWtIEv/LQ4DQ5jroD1D5vsMSJ3A9KZrRskzMvC9h1XSnDo0a98rS/h2ZA0eCxsH+yb/nTZcG4P4a/Rug+KCuDaERR/U5asLNJmQ9oc3wKZkRQWrRg4FdZqvKbE7CVwknQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764248408; c=relaxed/simple;
	bh=6LrJVzLjJp3Q+EaA05iUYg1t/kmAtnKEHrk0vSbRdfI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=MmHS12oPUyIDXnTfsCfdKipvxyrUAMU21tW+R2HffFMV5A41/TTQu70Ka9qDO4ItQO395On7c/WWOdLV9IMIyd1e418NMkiV7l/cS366ZnZAmeWrsegZbe49pDDRInqbF7+c8KFu8gN1Ld+1bUEqd7Nk4CC14vg9eDTxEpSv/Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bgu5tLRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2195C4CEF8;
	Thu, 27 Nov 2025 13:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764248408;
	bh=6LrJVzLjJp3Q+EaA05iUYg1t/kmAtnKEHrk0vSbRdfI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Bgu5tLRM8p3LGiPa1+Tciv4cbuelDjgjUOe8fkwlBz+rnAtJQt6LiTyVA2WcFAmIO
	 0/tMiZ220QT/crLXEVpjfQuiXc7sZNNO3wGYoSSpb62NEZtKvaPkCQmfPP1hosjekV
	 sVZYSr7hMR6ZK7dZTgkASDFvS+27O5AFMtXHvVETsxJiUUm3YQMdjC7cD4Gayeme0e
	 ZtG3ON2sfuI9qwkPV8fT4TXKTkSHdl6q56xjDkOf+TnBY87JLO42rgg6LZwggnIt0A
	 zKQm3ki5z/IZfi9+NuZ/mL5cSuNnYlzDLQkGCNMqYTkiotIv0kt7/zjIfyWZZikKom
	 nxyLZPp6rAA2w==
Date: Thu, 27 Nov 2025 07:00:06 -0600
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
 Mark Brown <broonie@kernel.org>, linux-leds@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pm@vger.kernel.org, 
 linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, 
 Lee Jones <lee@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Sebastian Reichel <sre@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Andreas Kemnade <andreas@kemnade.info>, 
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
In-Reply-To: <28726d1e0573a6efb6e70716a23ba27c4fc93c6d.1764241265.git.mazziesaccount@gmail.com>
References: <cover.1764241265.git.mazziesaccount@gmail.com>
 <28726d1e0573a6efb6e70716a23ba27c4fc93c6d.1764241265.git.mazziesaccount@gmail.com>
Message-Id: <176424840632.3926566.6121421598691420073.robh@kernel.org>
Subject: Re: [PATCH v6 01/17] dt-bindings: regulator: ROHM BD72720


On Thu, 27 Nov 2025 13:16:59 +0200, Matti Vaittinen wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/28726d1e0573a6efb6e70716a23ba27c4fc93c6d.1764241265.git.mazziesaccount@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


