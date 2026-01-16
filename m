Return-Path: <linux-pm+bounces-40981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0BFD2EA07
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 10:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA12030AFCEE
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 09:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C9233EB00;
	Fri, 16 Jan 2026 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNBgk0XQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB3B2D7DDF;
	Fri, 16 Jan 2026 09:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768555021; cv=none; b=rzd/xGOXBJoP5t0oi7qFRe0tf3Mr1pLsUc22CNSJSMz3Va+Iab78MtlzRsVRCHNICHHlUlNxC+7o+f5bA/We3oaxVGDH+ZIFVdrZ40Op4hzxTPVNFlYbaXVYB5/9rmnAbOHEMJr8/78CPLA2A0plFlWsVXQHGvgI/F0v6T2qD3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768555021; c=relaxed/simple;
	bh=yVX7441AwNWpwo7n7A35edDx9OckAgwgwNXHR/OVQZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ca7n4xjcrCFSkW/kCkZSBfp+mpDj/6qiOUmL9MGNO3y6Yoh3+0XfePgZzPMyFAKXdfTU+Irvy8ZWaWISiVYrTMOe7rercBTX/kXlz2nLhxeIbI+WjJn2L42xkOPTlEhzb0H8pmlaqa6RBr/AoeC4KZ9v6KXRwvi5iCSeUkFEUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNBgk0XQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620A9C116C6;
	Fri, 16 Jan 2026 09:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768555020;
	bh=yVX7441AwNWpwo7n7A35edDx9OckAgwgwNXHR/OVQZk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KNBgk0XQGXAxynsirvfB3jsyVKiqctWzYXwetbTMD8gLGWjrmXSRM0fD1rZGQYcxf
	 zyFdl6n7AKA9W4mKlXGJpDqArtoVFGim0AERe3kitaOMqv7eOybZVcaGl8OV16BuEr
	 9WBmX/5h7PsfZ8mUFeNU/Pdx5Q+iKYlOv32B+8IhlHyi3IutknIcKqE2gQwuSDTdPT
	 bFyDdmvicUMrrwFbLcHozLaon2SG2xQefobm2Bb/Q5aodQJU0KFpJX7BWqWffs3N3h
	 GB0j6lanOrx7GWRsC/PFXtSYDt6Pg88GgynojxtT+5TiJE9YbUQG5ANrA7eiwt//T+
	 9lQxX2uV4JWew==
Message-ID: <79d0f072-80f9-4757-b25d-84260551e217@kernel.org>
Date: Fri, 16 Jan 2026 10:16:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cpufreq: ti-cpufreq: add support for AM62L3 SoC
To: Dhruva Gole <d-gole@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>,
 Bryan Brattlof <bb@ti.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
References: <20260116-am62l-cpufreq-v1-0-63d062317ae9@ti.com>
 <20260116-am62l-cpufreq-v1-2-63d062317ae9@ti.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260116-am62l-cpufreq-v1-2-63d062317ae9@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2026 10:01, Dhruva Gole wrote:
> Add CPUFreq support for the AM62L3 SoC with the appropriate
> AM62L3 speed grade constants according to the datasheet [1].
> 
> This follows the same architecture-specific implementation pattern
> as other TI SoCs in the AM6x family.
> 
> [1] https://www.ti.com/lit/pdf/SPRSPA1
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 6ee76f5fe9c567b0b88797ddb51764a2a5606b16..8d8fdb068dcdc2caa0b656405f38a072c0700f71 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -48,6 +48,12 @@
>  #define AM625_SUPPORT_S_MPU_OPP			BIT(1)
>  #define AM625_SUPPORT_T_MPU_OPP			BIT(2)
>  
> +#define AM62L3_EFUSE_E_MPU_OPP			5
> +#define AM62L3_EFUSE_O_MPU_OPP			15
> +
> +#define AM62L3_SUPPORT_E_MPU_OPP		BIT(0)
> +#define AM62L3_SUPPORT_O_MPU_OPP		BIT(1)
> +
>  enum {
>  	AM62A7_EFUSE_M_MPU_OPP =		13,
>  	AM62A7_EFUSE_N_MPU_OPP,
> @@ -213,6 +219,22 @@ static unsigned long am625_efuse_xlate(struct ti_cpufreq_data *opp_data,
>  	return calculated_efuse;
>  }
>  
> +static unsigned long am62l3_efuse_xlate(struct ti_cpufreq_data *opp_data,
> +				       unsigned long efuse)
> +{
> +	unsigned long calculated_efuse = AM62L3_SUPPORT_E_MPU_OPP;
> +
> +	switch (efuse) {
> +	case AM62L3_EFUSE_O_MPU_OPP:
> +		calculated_efuse |= AM62L3_SUPPORT_O_MPU_OPP;
> +		fallthrough;
> +	case AM62L3_EFUSE_E_MPU_OPP:
> +		calculated_efuse |= AM62L3_SUPPORT_E_MPU_OPP;
> +	}
> +
> +	return calculated_efuse;
> +}
> +
>  static struct ti_cpufreq_soc_data am3x_soc_data = {
>  	.efuse_xlate = amx3_efuse_xlate,
>  	.efuse_fallback = AM33XX_800M_ARM_MPU_MAX_FREQ,
> @@ -315,6 +337,7 @@ static const struct soc_device_attribute k3_cpufreq_soc[] = {
>  	{ .family = "AM62AX", },
>  	{ .family = "AM62PX", },
>  	{ .family = "AM62DX", },
> +	{ .family = "AM62LX", },

So you just stuff at the end in every commit leading to unnecessary risk
of conflicts.

>  	{ /* sentinel */ }
>  };
>  
> @@ -327,6 +350,14 @@ static struct ti_cpufreq_soc_data am625_soc_data = {
>  	.quirks = TI_QUIRK_SYSCON_IS_SINGLE_REG,
>  };
>  
> +static struct ti_cpufreq_soc_data am62l3_soc_data = {
> +	.efuse_xlate = am62l3_efuse_xlate,
> +	.efuse_offset = 0x0,
> +	.efuse_mask = 0x07c0,
> +	.efuse_shift = 0x6,
> +	.multi_regulator = false,
> +};
> +
>  static struct ti_cpufreq_soc_data am62a7_soc_data = {
>  	.efuse_xlate = am62a7_efuse_xlate,
>  	.efuse_offset = 0x0,
> @@ -463,6 +494,7 @@ static const struct of_device_id ti_cpufreq_of_match[]  __maybe_unused = {
>  	{ .compatible = "ti,am625", .data = &am625_soc_data, },
>  	{ .compatible = "ti,am62a7", .data = &am62a7_soc_data, },
>  	{ .compatible = "ti,am62d2", .data = &am62a7_soc_data, },
> +	{ .compatible = "ti,am62l3", .data = &am62l3_soc_data, },

Oh no, here it is correct. Random choices?

>  	{ .compatible = "ti,am62p5", .data = &am62p5_soc_data, },
>  	/* legacy */
>  	{ .compatible = "ti,omap3430", .data = &omap34xx_soc_data, },
> 


Best regards,
Krzysztof

