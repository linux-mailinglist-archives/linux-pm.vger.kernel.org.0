Return-Path: <linux-pm+bounces-40929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F329D24C3E
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 14:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 201FC308790B
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CC13A1A2D;
	Thu, 15 Jan 2026 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUVFT4Pv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EE1395D8F;
	Thu, 15 Jan 2026 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483959; cv=none; b=Kkdck1gxT75GdwBxac8OPIwXYG3rFEEH0BNBb3QMGBJXnkT/rrwxNySTrpwjDVpubirhtG1IEgNM8zsYU6LcLm1ai7LeaJXtslKAfOd61NuIkLLCm5yLR02APHZRjefprLEfrxWOZrX4xosGbnG6QERYasIlya2UJ+pcPWFJfn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483959; c=relaxed/simple;
	bh=VHYL1nkOzjGIBxU6anuNNYGVykvMwehpUoJm26Swras=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQYZhxpOX/cGMeq5LhIzm55gS8noWreXSRnJKk/rHSObBaaxh6xnWTPh7bgIsvmzaHl/9ipg67BAgRiipb76zOApZ5EPOYcVfWDlRp8XEdc2q22g4cUO0OL9MBFT19bGgxnx+PBsfozCJFcsOhVHM0FHtPzmULeHMtk3D974Fqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUVFT4Pv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F833C116D0;
	Thu, 15 Jan 2026 13:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768483958;
	bh=VHYL1nkOzjGIBxU6anuNNYGVykvMwehpUoJm26Swras=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUVFT4Pv+GbNch5ybevpHXCZtTqQsFPxF/zCQoI92R853eUEEkPraTqmDBf8PFues
	 PBAT0N7DIFFZI+2V38qolM+jE95dcVW1dtt8Zi3RufdjUNm4249uwuoVAvPOWT32om
	 ElCvSXlvlCunrL+UGjScZyA3Kqyh1whgxN6RBVdU9sUR6ZiRAsG4UZyIWUJRtmiq9r
	 sSG6SiKXsem7/4gozdb/ihcZC9ZXMk8jxgOhwZMcpArGmXAP6ZMNycnSGaPFVbLV5o
	 pfl8Sk7Zd0mWyAJI8Od3SCrrgYTQ9thn096k7gyAkwE4Ixfhtq8T2zWSgps3bA/1/3
	 dt5tNSV+5L8iQ==
Date: Thu, 15 Jan 2026 14:32:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: thermal: Add Google GS101 TMU
Message-ID: <20260115-ultramarine-wildebeest-of-completion-ea1bc0@quoll>
References: <20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org>
 <20260114-acpm-tmu-v1-1-cfe56d93e90f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114-acpm-tmu-v1-1-cfe56d93e90f@linaro.org>

On Wed, Jan 14, 2026 at 02:16:29PM +0000, Tudor Ambarus wrote:
> Add device tree bindings for the Google GS101 Thermal Management Unit
> (TMU).
> 
> The GS101 TMU is a hybrid thermal solution:
> 1. Configuration (thresholds, hysteresis) is handled via the Alive
>    Clock and Power Manager (ACPM) firmware protocol.
> 2. Interrupt handling is handled by the kernel via direct register
>    access.
> 
> This binding documents the required resources, including the APB clock
> for register access and the phandle to the associated syscon node.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  .../bindings/thermal/google,gs101-tmu-top.yaml     | 64 ++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..ecf4a315ecf1ea0649c4e96a207d531c696282f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/google,gs101-tmu-top.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google GS101 Thermal Management Unit (TMU)
> +
> +maintainers:
> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
> +
> +description: |
> +  The Google GS101 TMU is a thermal sensor block managed via the ACPM
> +  (Active Core Power Management) firmware. While the firmware handles
> +  the thermal algorithm and thresholds, the kernel requires direct
> +  access to the interrupt pending registers via a syscon interface to
> +  acknowledge and clear thermal interrupts.
> +
> +properties:
> +  compatible:
> +    const: google,gs101-tmu-top
> +
> +  clocks:
> +    maxItems: 1
> +    description: |
> +      Phandle to the APB peripheral clock (PCLK) required to access
> +      the TMU registers.

Drop all the redundancies, so:
items:
 - description: APB peripheral clock (PCLK) for TMU register access


> +
> +  interrupts:
> +    maxItems: 1
> +    description: |
> +      The combined thermal interrupt signal (Level High).

Drop description

> +
> +  syscon:

I feel like suddenly you sent something completely different than what
have you been working for the past 4 years.

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      Phandle to the device node representing the TMU System Controller
> +      (compatible with "google,gs101-tmu-syscon"). This node provides the
> +      regmap for INTPEND and INTCLEAR registers.
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +

No supply?

Best regards,
Krzysztof


