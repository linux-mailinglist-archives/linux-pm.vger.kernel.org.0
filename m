Return-Path: <linux-pm+bounces-22610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44782A3EFCB
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 10:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1A317D55D
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 09:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00CC200136;
	Fri, 21 Feb 2025 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VINOrWZ0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E6E1C3F02;
	Fri, 21 Feb 2025 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740129379; cv=none; b=GlS7C0b48g4GIH4KwzLfaJUa86lA611bTcW28LZ6RX8OV3QoqQXIphdYg6/8vL7kkcnikqYPhtPfgq24zFHRTvjFczMj91CLHM3OOklglMjA68hXUmSquPspvw2n8u/PKC9g8+PSJtueTQaPilKH17zuta9YeFF+iX0mV6ltcpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740129379; c=relaxed/simple;
	bh=v4duxCBt31nnMKSAT2iTqhqPuTqDH0EcdtbEtxT5aeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Om/tYB4wWQg64SVKeUKq4eFt3qtOAbExLDn3IjxfS9UqGGteATaA9tHrKr0Q2yqKmBmwvKPHSCbAW8BbuwpCA4PAKi/NvQKjhsQgFxvh7Kkj4n7mIRTMRd0lKaZVJVfK1wpB/S2L2h3XYs8J5o7GVHVgZErh1W3OfIb8TPqtYFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VINOrWZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC04C4CED6;
	Fri, 21 Feb 2025 09:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740129379;
	bh=v4duxCBt31nnMKSAT2iTqhqPuTqDH0EcdtbEtxT5aeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VINOrWZ0MlUK8m4ViqyGszczMyknnwNDy1cX7Of0w9PFryWoN6z7k0/JPV/1ysj75
	 iFXW2hjpcurfgMZtpyccXSeUa2fjzkvI4wxV0OwSjmr48Vkz8LCixF+LxySC+DdM1s
	 5LRKP1R8WgRkclg9lf5i1Sjb0pQS2npaJS7ltxBVZame8ZtZkBILQdlvdxjrCLuAYS
	 rEkcRctogB0dwhmdJ9jDXO+rcOd7qerQCf6FHAsHpMrp2dGwF0i+dlcTybyNDLas49
	 EURRBLSAPtBNQnQclY5NzJtmxLDFNcFB9UpKuF9a9oCseJajZGe0XPoPruGwH7pU+R
	 zV2aEAciRde8g==
Date: Fri, 21 Feb 2025 10:16:16 +0100
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
Subject: Re: [PATCH v5 15/21] dt-bindings: gpu: Add support for T-HEAD TH1520
 GPU
Message-ID: <20250221-adaptable-tamarin-of-variation-ad6dc6@krzk-bin>
References: <20250219140239.1378758-1-m.wilczynski@samsung.com>
 <CGME20250219140310eucas1p1297441a3da276569cd86b6b9e4544242@eucas1p1.samsung.com>
 <20250219140239.1378758-16-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219140239.1378758-16-m.wilczynski@samsung.com>

On Wed, Feb 19, 2025 at 03:02:33PM +0100, Michal Wilczynski wrote:
>    reg:
>      maxItems: 1
> @@ -60,6 +65,16 @@ allOf:
>          clocks:
>            maxItems: 1
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: thead,th1520-gpu
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3

Missing constraint for clock-names. They *always* go together.

Best regards,
Krzysztof


