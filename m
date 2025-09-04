Return-Path: <linux-pm+bounces-33810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BD0B4352D
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 10:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B927C41A2
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 08:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59E62D063C;
	Thu,  4 Sep 2025 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXM4WbWy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72142C08C8;
	Thu,  4 Sep 2025 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973514; cv=none; b=izRgkMheVfkTDYoqB1Rp1P4uGkt+sYcM41HFZZWA7NUNC9mVe1kD1AKEWvjqRsnFbKgzDH1XDxEJXHpXODHZWUjdDEPkkVVEXmABa35ZycwCG6nY2xzPiKBRK4Dk2XZwYDlYMH5rgxgdPDb4Dw5c04KZ1mxBkdhq4EHNoPmu4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973514; c=relaxed/simple;
	bh=AJEIP0itlyKLBAbKp6XsgUQ/BCGPNSMjOXvu7QHlYC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGo+/qXBmycncUbO+6HFMRTxwJ3NhkEX4uAYHJHvGlH/JXo3GzY1xWGGuDwjG6VAhP/g+AnwHfB60vzcd3CHYoKoenXszHL+1gnrMu3qkFiPlQDXf2RKPRFW64EBW0fzcFBrfb0C0DhREVYjuSIQfo7c6NMwQYsYV/4//6sw/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXM4WbWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C0BC4CEF0;
	Thu,  4 Sep 2025 08:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756973514;
	bh=AJEIP0itlyKLBAbKp6XsgUQ/BCGPNSMjOXvu7QHlYC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fXM4WbWyexUkCeB7TsU+u03sRw+NrHhqnJZhRb2e0dmqj8jmyfcZ1zvsbgfgeKa9n
	 ZMHnhgOjyYpLvyyBEztGCf0Odx0iYXbVSrejl0wX8WS8XEV5RirAYcISBCg6V5azTC
	 LU2ePPRoR0F8eqvBViXsqG1Nfw3BH7snnsGXgPJRfhDb0UYBpFRhgLvLcIWHVlrMzm
	 nhuy8cB+K8Yp5CCVKcNJt32uon0p7COUniy0sKzVv6Gmq1GpQdu+uo5YEVWZTrVz/J
	 /oN+xg+epnvTod124AqAIRt+x8CclyCxGGF4JWFMH00pvyloXYTf0nikyvDyEv23FO
	 NmYwaSLrzpzTA==
Date: Thu, 4 Sep 2025 10:11:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/8] dt-bindings: memory: tegra210: emc: Document OPP
 table and interconnect
Message-ID: <20250904-groovy-sheep-of-wizardry-ad0ae9@kuoka>
References: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
 <20250903-t210-actmon-v2-3-e0d534d4f8ea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903-t210-actmon-v2-3-e0d534d4f8ea@gmail.com>

On Wed, Sep 03, 2025 at 02:50:09PM -0500, Aaron Kling wrote:
> These are needed for dynamic frequency scaling of the EMC controller.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra210-emc.yaml    | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

I asked to order patches within patchset in some logical way. First
patch was memory, second other, third again memory.

There are no dependencies explained, so this looks like groupping
unrelated patches, therefore SPLIT finally the patchset per subsystem.

> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml
> index bc8477e7ab193b7880bb681037985f3fccebf02f..6cc1c7fc7a328bd18c7c0beb535c1ff918bcdb2a 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml
> @@ -33,6 +33,9 @@ properties:
>      items:
>        - description: EMC general interrupt
>  
> +  "#interconnect-cells":
> +    const: 0
> +
>    memory-region:
>      maxItems: 1
>      description:
> @@ -44,12 +47,19 @@ properties:
>      description:
>        phandle of the memory controller node
>  
> +  operating-points-v2:
> +    description:
> +      Should contain freqs and voltages and opp-supported-hw property, which
> +      is a bitfield indicating SoC speedo ID mask.
> +

No opp-table?

>  required:
>    - compatible
>    - reg
>    - clocks
>    - clock-names
> +  - "#interconnect-cells"

That's ABI break without explanation.

>    - nvidia,memory-controller
> +  - operating-points-v2

Best regards,
Krzysztof


