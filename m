Return-Path: <linux-pm+bounces-38418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B52C7E230
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 16:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 816E63491F5
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 15:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541342D3724;
	Sun, 23 Nov 2025 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Njt/2r2D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2297F2882B6;
	Sun, 23 Nov 2025 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763910413; cv=none; b=Z2zTihMOQZ5OieVnFTrcuzvqOLKtwbTDXyFaGh1FmmFPYdXMne80P1qqViOWL3H3bYkTyX/EkXUJ/ExeR6me+nzyBcRtBFNxbgsnc5VoTOmEptNpbQABYCUz1QZGNMD7He5GZuE9Ht20MMjyp6rtGATD11JlISYmGgjSvJGy6K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763910413; c=relaxed/simple;
	bh=OJvKpMF3u3QTpsswtdDBYiHfYAs3W3wX8WBoyI4FZwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xc8gmntvXWm5MPGxpLt86r1OHLnChavTNHQ53IRTJNGNOLdVg4NhVykWAQho6nWXDy7sbNAludWzhi9w0eARK5RRWfP7TsS9ETejpi6V9OK30OztCz+1n5fq97gq8TI31lQ8l1h3FhdnJV40Rg7uJd03Rm8I6XfKNWsmE2eKszI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Njt/2r2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043B3C113D0;
	Sun, 23 Nov 2025 15:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763910412;
	bh=OJvKpMF3u3QTpsswtdDBYiHfYAs3W3wX8WBoyI4FZwg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Njt/2r2DZc2n+eoMPRJeMp/j6VZEMXsb0I9TsBs3h1P9ZhRTTfmTE8mnTcFI1NXMC
	 AVT4I9ORAnHhrsqtNN7diaSw0CHJtQJyTqS++5TUVjDAzhYraGjZnpJxjK9rUlx7uW
	 GmtI5Wd6tmcsZmw9zSats8RtvF3sMq/LuQVWFLTFsloNsm98C9fS6O6p4zfX4byP7y
	 4uwRfXMBCRZH3yfjG3g56LfiI2Z44/g3LX5PiLspkcvH/IKooxGXTP3LT55wDmT40j
	 SKRkZ1OSr3v6v+pn0whDBBBj6C2l40lraQV7LH8E/mdxp9+zbT6PC6b4EoDBtjYo1G
	 x9CXmx3qRe0QQ==
Message-ID: <f449d702-0e7c-4a79-b299-2d09a6d325b1@kernel.org>
Date: Mon, 24 Nov 2025 00:06:48 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] dt-bindings: devfreq: tegra30-actmon: Add Tegra124
 fallback for Tegra210
To: webgeek1234@gmail.com, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chanwoo Choi <cw00c.choi@samsung.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20251021-t210-actmon-p1-v5-1-1bc8f9221917@gmail.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <20251021-t210-actmon-p1-v5-1-1bc8f9221917@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Applied it. Thanks

25. 10. 22. 12:09에 Aaron Kling via B4 Relay 이(가) 쓴 글:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> The Tegra210 actmon is compatible with the existing Tegra124 driver.
> Describe the compatibles as such.
> 
> Acked-by: Chanwoo Choi <cw00c.choi@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> Changes in v5:
> - Split series
> - Link to v4: https://lore.kernel.org/r/20250923-t210-actmon-v4-0-442d1eb6377c@gmail.com
> 
> Changes in v4:
> - Various cleanups in patch 5 as requested by review
> - Fix a couple typos in patch 4
> - Link to v3: https://lore.kernel.org/r/20250906-t210-actmon-v3-0-1403365d571e@gmail.com
> 
> Changes in v3:
> - In patch 5, don't fail mc probe if opp tables are missing
> - Add more mc bindings to patch 1
> - Add patch to use tegra210-mc bindings in the mc driver
> - Re-order series to align patches within a subsystem to each other
> - Link to v2: https://lore.kernel.org/r/20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com
> 
> Changes in v2:
> - Assume 64-bit dram bus width in patch 4
> - Add dt-bindings patch to document the new properties on the
>   tegra210-emc node.
> - Link to v1: https://lore.kernel.org/r/20250828-t210-actmon-v1-0-aeb19ec1f244@gmail.com
> ---
>  .../devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml  | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
> index e3379d1067283e36d1bee303187c0205b410f610..ea1dc86bc31f635f91a0e36f908f5c0c4f9a804c 100644
> --- a/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
> +++ b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
> @@ -19,11 +19,14 @@ description: |
>  
>  properties:
>    compatible:
> -    enum:
> -      - nvidia,tegra30-actmon
> -      - nvidia,tegra114-actmon
> -      - nvidia,tegra124-actmon
> -      - nvidia,tegra210-actmon
> +    oneOf:
> +      - enum:
> +          - nvidia,tegra30-actmon
> +          - nvidia,tegra114-actmon
> +          - nvidia,tegra124-actmon
> +      - items:
> +          - const: nvidia,tegra210-actmon
> +          - const: nvidia,tegra124-actmon
>  
>    reg:
>      maxItems: 1
> 
> ---
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
> change-id: 20251021-t210-actmon-p1-ef2b9164005d
> 
> Best regards,

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


