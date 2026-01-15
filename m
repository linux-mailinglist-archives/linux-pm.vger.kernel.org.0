Return-Path: <linux-pm+bounces-40930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD71D24C14
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 14:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EBCC300FEE0
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5492C3A0E81;
	Thu, 15 Jan 2026 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvNex5q2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3107620C029;
	Thu, 15 Jan 2026 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768484164; cv=none; b=PxQMmPJ/X2mWDo9FgESV2NQMp9H+fP1ob8z6j8dI5PYX5CLG1MumlP9suISagt91gu5ZkQumsMia/5c3uSwUoBWLoTGAbLfNaOeVoYqCbEoTfDsKihuvp4vCujeryjPBjx4Yo6XTGpZEiC3Sx5DkzM5yRFhbAwOk01LfvsticBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768484164; c=relaxed/simple;
	bh=0W6V9fyTShLK7ULIIxW8FNo5OfRF3NXJTodFVN9ZRdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m68tbWH5xihp89EP9EW2eQjPoYO7LyAJFhu6jzEd+vRFaB20HTJAHhMp68wuqQB0FtH8erTb11sNI1uQH22qITu/hs8ojkJgWXYB2UpQm8hyPzqh/cEQp2S3kJpJAP5lpebpGGVGGc5Z6+LbVBt0VZQdRsIakxgZAktSroIaNJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvNex5q2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC40C16AAE;
	Thu, 15 Jan 2026 13:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768484163;
	bh=0W6V9fyTShLK7ULIIxW8FNo5OfRF3NXJTodFVN9ZRdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UvNex5q2V6dpcWncjXAuZswFgvOfUKB9y8VJ+T9KyiTvWPfqGe20p26fqk/KPKdCy
	 fC2w61TTrdGLFSrazUHLDWG8EIQf2mYn5yZfbB8r93Ln8Fxp3SwJE8NiFPHReq8BWZ
	 HuKz33cfCWzSTQLUjcBZW90t3pL5F1DXCVoka3Hwei35ATDkkqP6WnCLur1V6F+wnX
	 gEgU/xfdqJTaX/u9Tba9WHGjKOvHk32N3c2VEGD+OrwZHN5QV2hMhnQAuvzciZXDk8
	 9v3lzyqXTA4/OKcWVkYmldl+k7Ndb+ApMLf0hzt4zLmrvsgDjM7obnvfZgS9qVbLYx
	 Gpp78xR32pXiA==
Date: Thu, 15 Jan 2026 14:36:01 +0100
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
Subject: Re: [PATCH 3/8] dt-bindings: mfd: Add Google GS101 TMU Syscon
Message-ID: <20260115-slim-denim-potoo-cad9cb@quoll>
References: <20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org>
 <20260114-acpm-tmu-v1-3-cfe56d93e90f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114-acpm-tmu-v1-3-cfe56d93e90f@linaro.org>

On Wed, Jan 14, 2026 at 02:16:31PM +0000, Tudor Ambarus wrote:
> Document the bindings for the Thermal Management Unit (TMU) System
> Controller found on Google GS101 SoCs.
> 
> This memory-mapped block exposes the registers required for reading
> thermal interrupt status bits. It functions as a syscon provider,

I don't think this is syscon, but the actual TMU. Syscon is various,
unrelated system configuration registers.

> allowing the main thermal driver to access these registers while
> the firmware manages the core thermal logic.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  .../bindings/mfd/google,gs101-tmu-syscon.yaml      | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/google,gs101-tmu-syscon.yaml b/Documentation/devicetree/bindings/mfd/google,gs101-tmu-syscon.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..6a11e43abeaa23ee473be2153478436856277714
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/google,gs101-tmu-syscon.yaml

Not MFD either, but soc.

> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/google,gs101-tmu-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google GS101 TMU System Controller
> +
> +maintainers:
> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
> +
> +description: |

Drop |

> +  The TMU System Controller provides a memory-mapped interface for
> +  accessing the interrupt status registers of the Thermal Management
> +  Unit. It is used as a syscon provider for the main TMU driver.

No, it is not a syscon provider. Entire last sentence is incorrect. You
must describe here hardware and this hardware does not provide any sort
of syscon to any sort of driver.

Best regards,
Krzysztof


