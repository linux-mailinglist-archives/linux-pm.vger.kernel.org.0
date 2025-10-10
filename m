Return-Path: <linux-pm+bounces-35918-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F529BCD66B
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 16:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7595E4E2952
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 14:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF33E2F1FC7;
	Fri, 10 Oct 2025 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sddgdCJy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA76036124;
	Fri, 10 Oct 2025 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105396; cv=none; b=QSbUbkIMFVkjuJzIoCknj3mV7ccpZf42I9X0Kd10qYvVksXrBkF0nbFiP4zAaqk622ILV3EkEP+gcxuXClfDQ7y9gdXSsnMedY5Y5MdiLBr3xMdQfkdm1spICLIMMdR/TO0aRQ0BtTzvUk3HwSCZ0Au1R/XfcjdzFeKZFJ2XC4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105396; c=relaxed/simple;
	bh=MJ/XTs/xRIZjpCaFnEFWN9AdmuOs8luescrHAQRcVDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9pJlHqIMCXOzBSC+6tGrfoi0YsQLYIIDx9SroVKgcYbI5bq/0ENlICQW92/7Ygp4lRdUJj7mrOInn+UfImgV5yYX/M7sRtxcSTCbYJGIj0h+Y6sauEypr+wIi3KF9LaR7BTWC6dJKw+noX3MEv+kyMlgCwdA3oc0Jz/jHKZbUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sddgdCJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2C7C4CEF1;
	Fri, 10 Oct 2025 14:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760105396;
	bh=MJ/XTs/xRIZjpCaFnEFWN9AdmuOs8luescrHAQRcVDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sddgdCJy4ffkyEWBzieZwW2GSxvSjAqL21K+ylmSi/0/m2z4bWsByIOxWJbzK+Yvs
	 O2X+j3QazvxML/91MmrnmJNv8MunlEe4RWdPhR+6OFRD3+eeMK9uKn6andO/nQaV7q
	 cd59zEqSpiYGKlSJRSKRQS1EiymgyJj4TGZeYh1ikMu6PA+Y6kUM6VVGacdz8boqT1
	 67D2nHhmomdC3AvW19VTfbXzpE9lGSsYURyWHd6JCji7nyxwyjx8dQP7fo+r6/qTlj
	 F96KcrVoOxjg0iCpqMz9HKMC1vvg2W5SOwGb/V67PHfGfW5v8bBMSBuYl3w+r3zgix
	 b2J+USz9rbGSw==
Date: Fri, 10 Oct 2025 09:09:54 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 02/10] dt-bindings: soc: samsung: exynos-pmu: move
 gs101-pmu into separate binding
Message-ID: <20251010140954.GA217599-robh@kernel.org>
References: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
 <20251009-gs101-pd-v2-2-3f4a6db2af39@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251009-gs101-pd-v2-2-3f4a6db2af39@linaro.org>

On Thu, Oct 09, 2025 at 04:25:04PM +0100, André Draszik wrote:
> The gs101-pmu binding is going to acquire various additional (pattern)
> properties that don't apply to other PMUs supported by this binding.
> 
> To enable this, move google,gs101-pmu into a separate binding.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>  .../bindings/soc/google/google,gs101-pmu.yaml      | 67 ++++++++++++++++++++++
>  .../bindings/soc/samsung/exynos-pmu.yaml           | 20 -------
>  MAINTAINERS                                        |  1 +
>  3 files changed, 68 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..209ee2f80d449c3eec568188898b3c6f7ae0ddd4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/samsung/google,gs101-pmu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google GS101 Power Management Unit (PMU)
> +
> +maintainers:
> +  - André Draszik <andre.draszik@linaro.org>
> +
> +# Custom select to avoid matching all nodes with 'syscon'

That's not necessary.

> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: google,gs101-pmu
> +  required:
> +    - compatible

