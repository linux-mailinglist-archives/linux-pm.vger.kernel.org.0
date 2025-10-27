Return-Path: <linux-pm+bounces-36928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F71C11779
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 22:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99B5402484
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 21:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B5831B83D;
	Mon, 27 Oct 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgmbakJX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2920C001;
	Mon, 27 Oct 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761599038; cv=none; b=fnyOnkXi9j15hgs+5pqCb/ArfiqKV9kfI8rpXaOAA9p0YMz/J2EUP6iBpF7llEuDCUFEbQvGEPrjS4Asx4BFxEgNJeI/wlblCZKCPYPPlzdskSU/ztMhe4EnsZEc1j5izvnD7q3eEkNBq60m1v5tUvhb7Q17/9yQC/tZvC0bO2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761599038; c=relaxed/simple;
	bh=mpQNWk6XE71LI74R1zJzlQ6C3OyQEWIlBGjFvd/bJBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7kXee6vJW/5gNOMKHn6LgzD4kGa/25aH73OM4SAhD84Qzs/582AZoQfpjpV/Nr+Eus0oCb1vOI6X3LqvBCJ5i6DQjUjMm/79E4RP+coYEWQKsAxqKQ3er0SQZBywyZPHWY5d+fAy1dWyADcpdhLfRqVz5DlqgWtlBwiSOQb/ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgmbakJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F4FC4CEF1;
	Mon, 27 Oct 2025 21:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761599038;
	bh=mpQNWk6XE71LI74R1zJzlQ6C3OyQEWIlBGjFvd/bJBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GgmbakJX40KJMFyfWwg7WTbIH9DKp1g/eL85iqD3u7ajE4AZS363DfOYZoGEsENe1
	 AjA7UBM1E2AVl6zrmOEABYAs9TvMGniM4ybNP+YHbFDrkAupYJmwqgaWNnoaGccwqA
	 lu94ZtK1P5RCc3LGP6mBLpQjN2adVMNiU5G/SxHPgZ5RMtmee60yJKHy+CcQqcb+Za
	 q8/yYUwu1LZ+fuX/jNlj/yOe/x6dPVxfKXyIJXZGKpi1WoWVhbGJpl5Si8YNRfKomD
	 +Au+KOCHpn2GPzUsxm5olRbV7pqSX498JiWb3W8Wu9ccvdBmK/RnU3f1J0/nqOt2WT
	 Wyv1CXfAB74LQ==
Date: Mon, 27 Oct 2025 16:03:56 -0500
From: Rob Herring <robh@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andreas Kemnade <andreas@kemnade.info>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 01/15] dt-bindings: regulator: ROHM BD72720
Message-ID: <20251027210356.GA1565353-robh@kernel.org>
References: <cover.1761564043.git.mazziesaccount@gmail.com>
 <25746d258ac57ae3eee82a20fa14a8a168f35e58.1761564043.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25746d258ac57ae3eee82a20fa14a8a168f35e58.1761564043.git.mazziesaccount@gmail.com>

On Mon, Oct 27, 2025 at 01:44:49PM +0200, Matti Vaittinen wrote:
> The ROHM BD72720 is a new PMIC with 10 BUCk and 11 LDO regulators.
> 
> The BD72720 is designed to support using the BUCK10 as a supply for
> the LDOs 1 to 4. When the BUCK10 is used for this, it can be set to a
> LDON_HEAD mode. In this mode, the BUCK10 voltage can't be controlled by
> software, but the voltage is adjusted by PMIC to match the LDO1 .. LDO4
> voltages with a given offset. Offset can be 50mV .. 300mV and is
> changeable at 50mV steps.
> 
> Add 'ldon-head-millivolt' property to denote a board which is designed
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
>  RFCv1 =>:
>  - No changes
> ---
>  .../regulator/rohm,bd72720-regulator.yaml     | 153 ++++++++++++++++++
>  1 file changed, 153 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd72720-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd72720-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd72720-regulator.yaml
> new file mode 100644
> index 000000000000..665086f56928
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/rohm,bd72720-regulator.yaml
> @@ -0,0 +1,153 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/rohm,bd72720-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROHM BD72720 Power Management Integrated Circuit regulators
> +
> +maintainers:
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
> +
> +description: |
> +  This module is part of the ROHM BD72720 MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml.
> +
> +  The regulator controller is represented as a sub-node of the PMIC node
> +  on the device tree.
> +
> +  Regulator nodes should be named to BUCK_<number> and LDO_<number>.
> +  The valid names for BD72720 regulator nodes are
> +  buck1, buck2, buck3, buck4, buck5, buck6, buck7, buck8, buck9, buck10
> +  ldo1, ldo2, ldo3, ldo4, ldo5, ldo6, ldo7, ldo8, ldo9, ldo10, ldo11
> +
> +patternProperties:
> +  "^ldo[1-11]$":
> +    type: object
> +    description:
> +      Properties for single LDO regulator.
> +    $ref: regulator.yaml#
> +
> +    properties:
> +      regulator-name:
> +        pattern: "^ldo[1-11]$"
> +        description:
> +          should be "ldo1", ..., "ldo11"

No need to repeat in prose what the schema says.

> +
> +      rohm,dvs-run-voltage:
> +        description:
> +          PMIC default "RUN" state voltage in uV. See below table for
> +          LDOs which support this. 0 means disabled.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 3300000
> +
> +      rohm,dvs-idle-voltage:
> +        description:
> +          PMIC default "IDLE" state voltage in uV. See below table for
> +          LDOs which support this. 0 means disabled.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 3300000
> +
> +      rohm,dvs-suspend-voltage:
> +        description:
> +          PMIC default "SUSPEND" state voltage in uV. See below table for
> +          LDOs which support this. 0 means disabled.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 3300000
> +
> +      rohm,dvs-lpsr-voltage:
> +        description:
> +          PMIC default "deep-idle" state voltage in uV. See below table for
> +          LDOs which support this. 0 means disabled.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 3300000
> +
> +        # Supported default DVS states:
> +        #     ldo        |    run     |   idle    | suspend   | lpsr
> +        # --------------------------------------------------------------
> +        # 1, 2, 3, and 4 | supported  | supported | supported | supported
> +        # --------------------------------------------------------------
> +        # 5 - 11         |                    supported (*)
> +        # --------------------------------------------------------------
> +        #
> +        # (*) All states use same voltage but have own enable / disable
> +        #      settings. Voltage 0 can be specified for a state to make
> +        #      regulator disabled on that state.
> +
> +    unevaluatedProperties: false
> +
> +  "^buck[1-10]$":
> +    type: object
> +    description:
> +      Properties for single BUCK regulator.
> +    $ref: regulator.yaml#
> +
> +    properties:
> +      regulator-name:
> +        pattern: "^buck[1-10]$"
> +        description:
> +          should be "buck1", ..., "buck10"

Same here.

> +
> +      rohm,ldon-head-millivolt:

Use standard unit-suffixes. (-microvolt)

> +        description:
> +          Set this on boards where BUCK10 is used to supply LDOs 1-4. The bucki
> +          voltage will be changed by the PMIC to follow the LDO output voltages
> +          with the offset voltage given here. This will improve the LDO efficiency.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 50
> +        maximum: 300
> +
> +      rohm,dvs-run-voltage:
> +        description:
> +          PMIC default "RUN" state voltage in uV. See below table for
> +          bucks which support this. 0 means disabled.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 3300000
> +
> +      rohm,dvs-idle-voltage:
> +        description:
> +          PMIC default "IDLE" state voltage in uV. See below table for
> +          bucks which support this. 0 means disabled.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 3300000
> +
> +      rohm,dvs-suspend-voltage:
> +        description:
> +          PMIC default "SUSPEND" state voltage in uV. See below table for
> +          bucks which support this. 0 means disabled.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 3300000
> +
> +      rohm,dvs-lpsr-voltage:
> +        description:
> +          PMIC default "deep-idle" state voltage in uV. See below table for
> +          bucks which support this. 0 means disabled.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 3300000
> +
> +        # Supported default DVS states:
> +        #     buck       |    run     |   idle    | suspend   | lpsr
> +        # --------------------------------------------------------------
> +        # 1, 2, 3, and 4 | supported  | supported | supported | supported
> +        # --------------------------------------------------------------
> +        # 5 - 10    |                    supported (*)
> +        # --------------------------------------------------------------
> +        #
> +        # (*) All states use same voltage but have own enable / disable
> +        #      settings. Voltage 0 can be specified for a state to make
> +        #      regulator disabled on that state.
> +
> +    required:
> +      - regulator-name
> +
> +    unevaluatedProperties: false
> +
> +additionalProperties: false
> -- 
> 2.51.0
> 



