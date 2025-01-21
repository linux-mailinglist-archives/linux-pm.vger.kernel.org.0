Return-Path: <linux-pm+bounces-20763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00656A17B08
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 11:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ECDF161330
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 10:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF201E7C07;
	Tue, 21 Jan 2025 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCRBH20s"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBFF1B87C2;
	Tue, 21 Jan 2025 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737454121; cv=none; b=XdwrmmEzm/4eUqJR4KXmeDkl97scKryLxYEro8B13go4P/VsqkS5NEEplYE8wV7yskp7x5uuSvN1A5mtj5o8uOZ/XbvbzBFqSo/V6B/5pq7YVZbXg6wuoOvSe39Jnxyt3vCmDV6CwUz7PRUvyJkRnaHKx5Z94B0JEvI7Sr9zeoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737454121; c=relaxed/simple;
	bh=ENLFzy2bE8WWpAn62FWGklWq2J5NXPzsV7mwFUV66PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWK3MA2pE12ZvUy8hlgZeXcU3tZP99+AZMh1iQXFh8+Luiv3gzMmgjuO/6Fj8kbq7kv724k8CRlPsmjAteL/ARVE3wa0uXtYSTjprFtgtXZp4aAIcKylzBb3am2lKVv7w/68dJ/Onu1xxG7JNWrKFzvqJOCNtCa800QgKKebIVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCRBH20s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB28C4CEDF;
	Tue, 21 Jan 2025 10:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737454120;
	bh=ENLFzy2bE8WWpAn62FWGklWq2J5NXPzsV7mwFUV66PY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JCRBH20svciWwvTa1Did37XrBO0s064B/DTFoypK1t6MGJT27w12BeFGtHmYxV/as
	 Odlu0WA8tRCdm7psEPen+TsZFqLn0UeVZYRUxEio7Yk6Kq1cjB0Vtx80OibDX0Y4wE
	 AaRb+IxQGAJYbrccGynrYdSQLoKxXr6U2MoveJsF/FpyAcclzvOvwegFdDJmPtLOrc
	 XmWBTm9SghFul+y1OV88u+wVxBQ7i2HdSjwhPpkDwOcI6FrfIcW2EKdhIIkQU7V/4U
	 DLy0MOxumGpT8ESf4cG1G+R+BJqMIcOWJsah9f6MrNTdT/CVR7kSBZ/EGBVRxBZaTx
	 l1CsnM4qWBSZg==
Date: Tue, 21 Jan 2025 11:08:38 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org, 
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com, 
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, ulf.hansson@linaro.org, 
	jszhang@kernel.org, p.zabel@pengutronix.de, m.szyprowski@samsung.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [RFC v3 11/18] dt-bindings: gpu: Add compatibles for T-HEAD
 TH1520 GPU
Message-ID: <20250121-tiny-crazy-goshawk-dce1dc@krzk-bin>
References: <20250120172111.3492708-1-m.wilczynski@samsung.com>
 <CGME20250120172134eucas1p18cbf29a4ade281df10efce210cc8893e@eucas1p1.samsung.com>
 <20250120172111.3492708-12-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250120172111.3492708-12-m.wilczynski@samsung.com>

On Mon, Jan 20, 2025 at 06:21:04PM +0100, Michal Wilczynski wrote:
>    reg:
>      maxItems: 1
> @@ -25,11 +30,8 @@ properties:
>      maxItems: 3
>  
>    clock-names:
> -    items:
> -      - const: core
> -      - const: mem
> -      - const: sys
>      minItems: 1
> +    maxItems: 3

So what is the third item? It cannot be anything, but must be
constrained.

I understand that you clean it up and maybe the cleaning is correct, but
it should be separate commit with its own explanation.

>  
>    interrupts:
>      maxItems: 1
> @@ -47,8 +49,6 @@ required:
>    - clock-names
>    - interrupts
>  
> -additionalProperties: false
> -
>  allOf:
>    - if:
>        properties:
> @@ -58,7 +58,28 @@ allOf:
>      then:
>        properties:
>          clocks:
> +          minItems: 1

Drop minItems here.

>            maxItems: 1
> +        clock-names:
> +          items:
> +            - const: core
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: thead,th1520-gpu
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: core
> +            - const: sys
> +
> +unevaluatedProperties: false

That's not explained. Does not look correct, either, unless you fix some
issue, but then again: separate commit.

Best regards,
Krzysztof


