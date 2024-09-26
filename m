Return-Path: <linux-pm+bounces-14835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D40098792E
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 20:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39D71F226B2
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 18:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FB91714B3;
	Thu, 26 Sep 2024 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWf169OI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB971D5AD0;
	Thu, 26 Sep 2024 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727375940; cv=none; b=XQaIvPMo4EBIr9uh9aiBrFyJqFwzxIBrBHcwzCcvhM4rh0VoLL6OOD0/2pHNUO4CyjNb4Q855Yv5QH78v9xCAWU0ZoxkdZgeP5NjHQjPf/O+3pwpdvnYTLOyEJpdyVNYXXxJnHaHrY9d2Nt855VrR+7/Ml4j4qQ4dg8PrkIwU7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727375940; c=relaxed/simple;
	bh=bqWGoAaO8nHvHaEKFlHMhxU2QHht9Hj9OjVvaSdtHig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJiVdFo/oc3Pk/kqmqdQnTB694gm4fBT7/LVpb0co+1gQ9ksWlluEGyCrKmVW9sUxphKwsjcjdUI1FzgLcU8whWC22NFgLl1C9SFgiRjPFribQXU1XlKPabqPahPOjCxZWdyXIGgM+1mXKNPR9LetqnptGnylAIFlDPzk3mN1xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWf169OI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B59C4CEC5;
	Thu, 26 Sep 2024 18:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727375939;
	bh=bqWGoAaO8nHvHaEKFlHMhxU2QHht9Hj9OjVvaSdtHig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tWf169OIK42LOs7v6xZBQ6TML/HPur+151d1OlRy1ckW8IleLofNaXQzFzsgOPZXM
	 ATvRZZbqOHwzmdJNtoYa+m1Hy8uAFSxvT+3e5axvVoWmQ7FcpF1wzG0GQ3Xicza6t0
	 yrugHX7dsLPzGmNxOBjEH17HNcBPciL2x/2TYqC+mFfwKxomtJt+yRYP95jl8rHYsE
	 /fqkwAbX/y0NBOW6o3J+a5fkS4PTLXVPZTjLPc5Qf3fW47CJc+3Lynj8VFJJBDNrns
	 u+7Xy2Zl8herudyztpaUYiGO3GiF13P7fOjTD/cjDng7VMFT9AZ8STclBWo5zoav4V
	 FTC6weepR4hUA==
Date: Thu, 26 Sep 2024 13:38:58 -0500
From: Rob Herring <robh@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 2/7] dt-bindings: mfd: add maxim,max77705
Message-ID: <20240926183858.GA2718844-robh@kernel.org>
References: <20240617-starqltechn_integration_upstream-v5-0-e0033f141d17@gmail.com>
 <20240617-starqltechn_integration_upstream-v5-2-e0033f141d17@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-starqltechn_integration_upstream-v5-2-e0033f141d17@gmail.com>

On Thu, Sep 26, 2024 at 01:20:19PM +0300, Dzmitry Sankouski wrote:
> Add maxim,max77705 core binding part.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 
> ---
> Changes in v5:
> - formatting changes
> - add unevaluatedProperties: false for nodes referencing
>   common schemas
> - remove additionalProperties on nodes with
>   unevaluatedProperties: false
> - add min and max to led index
> Changes in v4:
> - change dts example intendation from tabs
>  to spaces
> - remove interrupt-names property
> - remove obvious reg description
> - split long(>80) lines
> ---
>  Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 177 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS                                               |   1 +
>  2 files changed, 178 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
> new file mode 100644
> index 000000000000..214515f84c85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
> @@ -0,0 +1,177 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/maxim,max77705.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX77705 Companion Power Management IC and USB Type-C interface IC
> +
> +maintainers:
> +  - Dzmitry Sankouski <dsankouski@gmail.com>
> +
> +description: |
> +  This is a part of device tree bindings for Maxim MAX77705 multi functional
> +  device.

Drop this sentence. Just describe the device.

> +
> +  The Maxim MAX77705 is a Companion Power Management and Type-C
> +  interface IC which includes charger, fuelgauge, LED, haptic motor driver and
> +  Type-C management IC.
> +
> +properties:
> +  compatible:
> +    const: maxim,max77705
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  charger:
> +    $ref: /schemas/power/supply/power-supply.yaml
> +    unevaluatedProperties: true

Must be false.

> +    properties:
> +      compatible:
> +        const: maxim,max77705-charger
> +
> +    required:
> +      - compatible
> +      - monitored-battery
> +
> +  fuel-gauge:
> +    $ref: /schemas/power/supply/power-supply.yaml
> +    type: object
> +    unevaluatedProperties: true

Must be false.

Rob

