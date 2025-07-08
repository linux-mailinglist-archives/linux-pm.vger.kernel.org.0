Return-Path: <linux-pm+bounces-30348-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C66AFC612
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 10:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060533B8A4B
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 08:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EE129AAF5;
	Tue,  8 Jul 2025 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhBy+/LR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F32218845;
	Tue,  8 Jul 2025 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964453; cv=none; b=mLCtPPvlwQUI80OjslQ0KeY0zcktbt4kvPd/5yDmps8JdgWZiDpE7A6K1ODEhL5j3keeb5en41GsCuTrwZmQUrI4xDJ2EzSJO5RutjmjvMs/uiWLnPrrz/HRwNcxx2z3nnY9UME564WGt3+K/i7rCq1wpmK/L0/AJ5DzWJvqIZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964453; c=relaxed/simple;
	bh=k+zfhW6ZJvXzA7urDGHSqxbfp1IKiol29GpPHOu53ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6ievKDeiD6r2n/Ca4WnGxknRZJiBegAIxNHm7islcMvdIQgQI/jCvozQEY8ey5pYiPC1LEie+BBHnYDZ4wT2AfjcDqWYriqcQLxzltXSCcGqPJeIJQ/AJ/9b+A/6qaQ7vGryD/QQGjI18MmjbuKGXYX00TlPBZYzWgG3pvKB4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhBy+/LR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B14C4CEED;
	Tue,  8 Jul 2025 08:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751964452;
	bh=k+zfhW6ZJvXzA7urDGHSqxbfp1IKiol29GpPHOu53ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LhBy+/LRHkzOMGB2nHTqWWpOZ7AE7/BhmnFLXpVu8tCkHu7cHPUjaH292KTDHLqQp
	 4dI/1IpKz1xBP0EP1V+0BnsZzJJ9OA5SMVXJTWHfpH+/3LDTcT4icA0thJbNb0Mx3C
	 HKr0SxKXFpiUTo7NpMHgI+jBzoKl9gcXdUbM/jKU1GHte1SOqkafxr2IIRdBmatcPL
	 8yXUjgbJfYY5qsmOPlLC9Nbo8Rvv5RmQJjCAjJXve7p7lXPiqeLFB/JnzPWetTsCPH
	 QmuLXJKO6rVq2VWpZRVPXkuZD63veHbNwxVkarHCh/q/oR/zWhSVJiYLGl0QbnXBQ4
	 V1saidESCzsSA==
Date: Tue, 8 Jul 2025 10:47:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andre Przywara <andre.przywara@arm.com>, 
	linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: power: Add A523 PPU and PCK600 power
 controllers
Message-ID: <20250708-capable-caiman-of-feminism-9dfef2@krzk-bin>
References: <20250627152918.2606728-1-wens@kernel.org>
 <20250627152918.2606728-2-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250627152918.2606728-2-wens@kernel.org>

On Fri, Jun 27, 2025 at 11:29:15PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The A523 PPU is likely the same kind of hardware seen on previous SoCs.
> 
> The A523 PCK600, as the name suggests, is likely a customized version
> of ARM's PCK-600 power controller. Comparing the BSP driver against
> ARM's PPU datasheet shows that the basic registers line up, but
> Allwinner's hardware has some additional delay controls in the reserved
> register range. As such it is likely not fully compatible with the
> standard ARM version.
> 
> Document A523 PPU and PCK600 compatibles.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../bindings/power/allwinner,sun20i-d1-ppu.yaml   |  2 ++
>  .../power/allwinner,sun55i-a523-pck600.h          | 15 +++++++++++++++
>  .../dt-bindings/power/allwinner,sun55i-a523-ppu.h | 12 ++++++++++++
>  3 files changed, 29 insertions(+)
>  create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-pck600.h
>  create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-ppu.h
> 
> diff --git a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
> index f578be6a3bc8..b9f550994512 100644
> --- a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
> +++ b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
> @@ -18,6 +18,8 @@ properties:
>      enum:
>        - allwinner,sun20i-d1-ppu
>        - allwinner,sun8i-v853-ppu
> +      - allwinner,sun55i-a523-ppu
> +      - allwinner,sun55i-a523-pck-600

Don't add items at the end, but placed in alphabetical order. Could be
natural sort if you insist, but binding does not use it.

>  
>    reg:
>      maxItems: 1
> diff --git a/include/dt-bindings/power/allwinner,sun55i-a523-pck600.h b/include/dt-bindings/power/allwinner,sun55i-a523-pck600.h
> new file mode 100644
> index 000000000000..6b3d8ea7bb69
> --- /dev/null
> +++ b/include/dt-bindings/power/allwinner,sun55i-a523-pck600.h

Filename matching compatible (which ever one is correct).

Best regards,
Krzysztof


