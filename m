Return-Path: <linux-pm+bounces-22748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40051A40E6A
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 12:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3FCC7A838D
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 11:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DC1205505;
	Sun, 23 Feb 2025 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJ6VPz88"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F3B3D984;
	Sun, 23 Feb 2025 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740311007; cv=none; b=rOfdbS0vOWuN7qIT6ngymylblem7Qjokrr9LCXQ50JklE4EXZbhgJ20VGwfh+D4WNXrqiUl3Auv54pDiNNgDOos4uMfBBF+CApLhLr/dLQBUi8LVtnC1mkj4GNPuG/jDzQwhcVfs1g7mpN+8WAQ18iDsGDRZqUO7vZ8WiceuIAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740311007; c=relaxed/simple;
	bh=IKhhqryuBfV/Cv7HQRNKLiIF7nYqzYVmpwNqrbzEeS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iH0QZy1CpGAYYirRGAdgAHBZHEGvo/XQflwpwOPai7pn/cuEwpoWPZlALs+uAu0taUJA7tvC2cTAXHqsSv0iCWEv+eJnePog/i+DKTQ1L3pipsRyU4yqdqfCAQkioMI+UBkVHxT2e5eyaXFea5K5G4dhqP70Bc0Catv3dvG50j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJ6VPz88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFDCC4CEDD;
	Sun, 23 Feb 2025 11:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740311006;
	bh=IKhhqryuBfV/Cv7HQRNKLiIF7nYqzYVmpwNqrbzEeS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JJ6VPz88sURDWm2dRfdYqNEUv5+bqSCNLAp39DFxzosQTDbPtg9RIssS48opgme92
	 cZq4BTfAqOdP8UBXfMeNahtGXDlB299m4HB0RyJUGoLyNFiRzqT4yJlDo+9j+mn97e
	 zgx9FnbpcnQV5zy3XMEARJ2KMEvQkTiH3fTBta+eEUlg/qLy5zS61mJzs5kzbfbOZz
	 mOx89mfpErdbQb4IP2EvOyWx13jk7h3k1NaWe5NMnWTbv3gfFA+lDYuv8B+Plhe2ml
	 R4BP6bYiwBkWRCpgjh/eSeqQv2Y2kPPSC1Ah7Q2txOMF+IVgE0lPyoilahKtf38WfT
	 ccrymsct5H4MQ==
Date: Sun, 23 Feb 2025 12:43:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: power: supply: Document Maxim
 MAX8971 charger
Message-ID: <20250223-daft-amethyst-pogona-e9edcc@krzk-bin>
References: <20250221095943.57297-1-clamor95@gmail.com>
 <20250221095943.57297-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221095943.57297-2-clamor95@gmail.com>

On Fri, Feb 21, 2025 at 11:59:42AM +0200, Svyatoslav Ryhel wrote:
> Add bindings for Maxim MAX8971 charger.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/power/supply/maxim,max8971.yaml  | 133 ++++++++++++++++++
>  1 file changed, 133 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
> new file mode 100644
> index 000000000000..26b37e6f662f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
> @@ -0,0 +1,133 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/maxim,max8971.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX8971 IC charger
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +description:
> +  The MAX8971 is a compact, high-frequency, high-efficiency switch-mode
> +  charger for a one-cell lithium-ion (Li+) battery.
> +
> +properties:
> +  compatible:
> +    const: maxim,max8971
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  extcon:
> +    description:
> +      Special device used to detect type of plug.
> +    $ref: /schemas/types.yaml#/definitions/phandle

You rather miss proper connector or ports. Which device pins are
describbed here?


> +
> +  maxim,fcharge-current-limit-microamp:
> +    description:
> +      Fast-Charge current limit
> +    minimum: 250000
> +    default: 500000
> +    maximum: 1550000
> +
> +  maxim,fcharge-timer-hours:
> +    description: |
> +      Fast-Charge timer in hours. Setting this value 3 and lower or 11 and
> +      higher will disable Fast-Charge timer.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 5
> +
> +  maxim,fcharge-rst-threshold-high:
> +    description:
> +      Set Fast-Charge reset threshold to -100 mV
> +    type: boolean
> +
> +  maxim,in-current-limit-microamp:
> +    description:
> +      Input current limit
> +    minimum: 100000
> +    default: 500000
> +    maximum: 1500000
> +
> +  maxim,topoff-timer-minutes:
> +    description:
> +      Top-Off timer minutes
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 10, 20, 30, 40, 50, 60, 70]
> +    default: 30
> +
> +  maxim,topoff-current-threshold-microamp:
> +    description:
> +      Top-Off current threshold
> +    enum: [50000, 100000, 150000, 200000]
> +    default: 50000
> +
> +  maxim,fcharge-usb-current-limit-microamp:
> +    description:
> +      Fast-Charge USB current limit
> +    minimum: 100000
> +    default: 500000
> +    maximum: 1500000
> +
> +  maxim,fcharge-ac-current-limit-microamp:
> +    description:
> +      Fast-Charge AC current limit
> +    minimum: 100000
> +    default: 500000
> +    maximum: 1500000
> +
> +  maxim,usb-in-current-limit-microamp:
> +    description:
> +      USB Input current limit
> +    minimum: 100000
> +    default: 500000
> +    maximum: 1500000
> +
> +  maxim,ac-in-current-limit-microamp:
> +    description:
> +      AC Input current limit
> +    minimum: 100000
> +    default: 500000
> +    maximum: 1500000

For all or most of these you miss monitored batter.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +

Missing allOf with ref to power supply.

> +additionalProperties: false

unevaluatedProperties instead, see other bindings.

Best regards,
Krzysztof


