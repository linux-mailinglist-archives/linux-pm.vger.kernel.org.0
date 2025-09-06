Return-Path: <linux-pm+bounces-34066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D95B4733B
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 17:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB6044E046A
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 15:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7170022538F;
	Sat,  6 Sep 2025 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUdzXkMf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA0F1F0E53;
	Sat,  6 Sep 2025 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757174323; cv=none; b=eCiKzVq8Gewac3NgwZhz/HZXx6sJ4ejaXAPrctD2Y+TUuVBjjI+ldovyaGlht9wcoc5mcaAmpTYOeB8dgVhF0L2DhLs3sH2xfsqyUmjdbSb3ZmKRJNTTTF8QchiLBtbjmHHQHkMncO2PzrToxYA6v0Qfw7IsRZ9ouXD+5wXaYjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757174323; c=relaxed/simple;
	bh=kOu2V13DpP0DgkH5FMlVknsj28v5htctw0amrZKKUhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qc9CKvFmOj/0/p/l0+XceFBRLt0/Rd2o5qfZ/Ta3zsh21AiOg5QhM9RAAhPxbe+03s7Xz/2AkphtyaiZL0MDROSkyHL4xMIxejgKvLOC6czuAsESsqbJZVXqhysUQCZk0gdOcnFxmqclCYa1lUgRSLedEpsW8KN9a+e/1uObPPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUdzXkMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5F2C4CEE7;
	Sat,  6 Sep 2025 15:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757174322;
	bh=kOu2V13DpP0DgkH5FMlVknsj28v5htctw0amrZKKUhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hUdzXkMfwnEQXFM/mH6V1ySgKTmwP0LD+uBz4vmTdWaeYGFTE4sg2vQ/OjHxAJBYi
	 KEAvoDi0+6aqRmiNh8HEfaLEg3eBWzpVcKhkAaMCT5ODInliDYe+vZKuEdXagoyIqO
	 U7DsmBXwLpuInj/9k/eLnIY5lYRgCpYMjX02mAJexNJv1PKNu6DhSC3t8cGMLOcHpw
	 64cP4Ado+OMcyCfdip01FweywhraRtoESZDHAQ9dS3xI5O7+/TRpvNcz7S32RHpM7J
	 7woRX2GQBr6HLf+jyhgEujycaQH11Z8zW8Nf6SmC3GYaVjibvyr9GLMIUvSioSIRIw
	 2uLkIPvGmQfdg==
Message-ID: <73c0a4e6-3153-45c4-a471-2af46792a032@kernel.org>
Date: Sun, 7 Sep 2025 00:58:37 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: devfreq: tegra30-actmon: Add Tegra124
 fallback for Tegra210
To: webgeek1234@gmail.com, Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
 <20250903-t210-actmon-v2-2-e0d534d4f8ea@gmail.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <20250903-t210-actmon-v2-2-e0d534d4f8ea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

25. 9. 4. 04:50에 Aaron Kling via B4 Relay 이(가) 쓴 글:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> The Tegra210 actmon is compatible with the existing Tegra124 driver.
> Describe the compatibles as such.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
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

Acked-by: Chanwoo Choi <cw00c.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


