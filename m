Return-Path: <linux-pm+bounces-5538-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD92388F0C2
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 22:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC72B213FD
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 21:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A5815250F;
	Wed, 27 Mar 2024 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="li7LvUgo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F694CB38;
	Wed, 27 Mar 2024 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711574380; cv=none; b=VR4qrsCAkZ6iZpSMFKdWdmSSF3TbG3m9xBSslzoHNf5QJNAwM5/mlpvFnqcfpzdvVEw4q5MHmn/1fkcCcHKOmqspouMamFpWM+bjUyJFogFcyDgvFHEHPG1/VPw4HGdZUmqHVr1XbJd6olrJiKw4WFkCeqt5YsqckQQlJT/RiZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711574380; c=relaxed/simple;
	bh=twiP8B6f3vLZHrr943odX6Yk/Kc6masytJv5vDdK5Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j78766Dq8gAGX3t2mzg3wzC98W309GA+hhgaw68eunBWjZliKjALIF7dJtEy4Svyw0mNp3QDQ5WVMyrfD/Uaby+pdakVaJQjGiyT5YH+vucz36U6yWXdLihS97PpUlvYGGgEBJeqsSxXAdDP+xc1p4hHtHXncJC/sCoatrC8Rg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=li7LvUgo; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a466e53f8c0so33077166b.1;
        Wed, 27 Mar 2024 14:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711574376; x=1712179176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNx42+cIO6IvI6CYL4IXG6mJqHn6Rg/EjQqC8SupC2Y=;
        b=li7LvUgoLN0LpHaWh2pmDO1OrVmqEGj46Su3lw0ruf7FMg7RaO7V57V/Qr1mT+Z7Pr
         ZVeGGwvuQo7DxZBvGRf1az5zdooTgqanWcYEiddbAxF5VwHs5fu/8DnbKp5Huo/6EgUb
         xLsF4hGiqkbiLGYzLgygnp111u8F8kiyUP3Xo3nFkU6UeGOqTwONFQ/xMwyYM/J2jSuR
         LJsytck3sOXTGVgdvEcxIpmqom2uFHRc4/H/dnpW4AyWpPey3ObqgrG7ABvbYnBoB3Oo
         zNbzlQ6/+XX8hpx9aKEzWXwEYwmwQvqo0BuZRDhHHg+EyQx748Xb1hrkGZC//SNNwQyb
         oSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711574376; x=1712179176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNx42+cIO6IvI6CYL4IXG6mJqHn6Rg/EjQqC8SupC2Y=;
        b=N1sVXLHpXEsMsmpwJjiu5cFe3tMv8VG0dFQWjoTCZ/ngfiYK2nZqYMl7/Lfu0tGU+z
         mWIou3mGn3am/O+xfCgtPKm7aSazAv/0mZSPkN5Hhr25MFeILKdZh4MlNVd9sBvBYcVG
         ES5rA1Sb6WfQkIgJ45gafYCHHmkwiLMcgL4WRtwFy+Ewm2Q9bhk2IXYp5ZOO3KrQqzF0
         9s+JkC7qr9pm3bTkHQAsSAFmsT4DMdw764J9FYALLfZYPRipwZXppQDybyxkbO2CJwbX
         dyjIrOdkyY0m7D8Aqy+9u56+OGf6lIcGHpMJ5aEo6zrCR3wWbybvlrJhwlZNBcYLZ5AR
         ezZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcdUFFl9cae4A9bxdxA06PCYRuOz46msGn4Rct6ASAO3UIzupDc48OnXDsqZxcyGRgyE7ogCp2tQAzmiJoGjgI7+daOMdpHF22xg==
X-Gm-Message-State: AOJu0YzwIYCrkyQ6l5NdmMhrnLeryP3DSzxTnwhZ1tDpBv5LJAwRhn5s
	f+4i9nw37L68nTH/vyzQQOJ1FtYvtlHStSOHPIKQhkgmANluY90z
X-Google-Smtp-Source: AGHT+IF/B2H4KrboR8kefyqZkwERsOjnhoaDXBWKE4J0pfvunYYrk/JmiIGNVxhTOFgtD+Mh7a9TNQ==
X-Received: by 2002:a17:906:fa16:b0:a47:34b2:ca4b with SMTP id lo22-20020a170906fa1600b00a4734b2ca4bmr366675ejb.50.1711574375890;
        Wed, 27 Mar 2024 14:19:35 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906171300b00a45be04f00fsm5982718eje.171.2024.03.27.14.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 14:19:35 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Brandon Cheo Fusi <fusibrandon13@gmail.com>,
 Martin Botka <martin.botka@somainline.org>,
 Martin Botka <martin.botka1@gmail.com>,
 Chris Morgan <macroalpha82@gmail.com>, Ryan Walklin <ryan@testtoast.com>
Subject: Re: [PATCH v3 4/8] cpufreq: sun50i: Refactor speed bin decoding
Date: Wed, 27 Mar 2024 22:19:34 +0100
Message-ID: <3738303.MHq7AAxBmi@jernej-laptop>
In-Reply-To: <20240326114743.712167-5-andre.przywara@arm.com>
References:
 <20240326114743.712167-1-andre.przywara@arm.com>
 <20240326114743.712167-5-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne torek, 26. marec 2024 ob 12:47:39 CET je Andre Przywara napisal(a):
> From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> 
> Make converting the speed bin value into a speed grade generic and
> determined by a platform specific callback. Also change the prototypes
> involved to encode the speed bin directly in the return value.
> 
> This allows to extend the driver more easily to support more SoCs.
> 
> Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> [Andre: merge output into return value]
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 74 +++++++++++++++++---------
>  1 file changed, 49 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index 32a9c88f8ff6d..7b44f3b13e7d2 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -25,19 +25,52 @@
>  
>  static struct platform_device *cpufreq_dt_pdev, *sun50i_cpufreq_pdev;
>  
> +struct sunxi_cpufreq_data {
> +	u32 (*efuse_xlate)(u32 speedbin);
> +};
> +
> +static u32 sun50i_h6_efuse_xlate(u32 speedbin)
> +{
> +	u32 efuse_value;
> +
> +	efuse_value = (speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
> +
> +	/*
> +	 * We treat unexpected efuse values as if the SoC was from
> +	 * the slowest bin. Expected efuse values are 1-3, slowest
> +	 * to fastest.
> +	 */
> +	if (efuse_value >= 1 && efuse_value <= 3)
> +		return efuse_value - 1;
> +	else
> +		return 0;
> +}
> +
> +static struct sunxi_cpufreq_data sun50i_h6_cpufreq_data = {
> +	.efuse_xlate = sun50i_h6_efuse_xlate,
> +};
> +
> +static const struct of_device_id cpu_opp_match_list[] = {
> +	{ .compatible = "allwinner,sun50i-h6-operating-points",
> +	  .data = &sun50i_h6_cpufreq_data,
> +	},
> +	{}
> +};
> +
>  /**
>   * sun50i_cpufreq_get_efuse() - Determine speed grade from efuse value
> - * @versions: Set to the value parsed from efuse
>   *
> - * Returns 0 if success.
> + * Returns non-negative speed bin index on success, a negative error
> + * value otherwise.
>   */
> -static int sun50i_cpufreq_get_efuse(u32 *versions)
> +static int sun50i_cpufreq_get_efuse(void)
>  {
>  	struct nvmem_cell *speedbin_nvmem;
>  	struct device_node *np;
>  	struct device *cpu_dev;
> -	u32 *speedbin, efuse_value;
> -	size_t len;
> +	const struct of_device_id *match;
> +	const struct sunxi_cpufreq_data *opp_data;
> +	u32 *speedbin;

nit: reverse christmas tree

Other than that,
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  	int ret;
>  
>  	cpu_dev = get_cpu_device(0);
> @@ -48,12 +81,12 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
>  	if (!np)
>  		return -ENOENT;
>  
> -	ret = of_device_is_compatible(np,
> -				      "allwinner,sun50i-h6-operating-points");
> -	if (!ret) {
> +	match = of_match_node(cpu_opp_match_list, np);
> +	if (!match) {
>  		of_node_put(np);
>  		return -ENOENT;
>  	}
> +	opp_data = match->data;
>  
>  	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
>  	of_node_put(np);
> @@ -61,25 +94,16 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
>  		return dev_err_probe(cpu_dev, PTR_ERR(speedbin_nvmem),
>  				     "Could not get nvmem cell\n");
>  
> -	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> +	speedbin = nvmem_cell_read(speedbin_nvmem, NULL);
>  	nvmem_cell_put(speedbin_nvmem);
>  	if (IS_ERR(speedbin))
>  		return PTR_ERR(speedbin);
>  
> -	efuse_value = (*speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
> -
> -	/*
> -	 * We treat unexpected efuse values as if the SoC was from
> -	 * the slowest bin. Expected efuse values are 1-3, slowest
> -	 * to fastest.
> -	 */
> -	if (efuse_value >= 1 && efuse_value <= 3)
> -		*versions = efuse_value - 1;
> -	else
> -		*versions = 0;
> +	ret = opp_data->efuse_xlate(*speedbin);
>  
>  	kfree(speedbin);
> -	return 0;
> +
> +	return ret;
>  };
>  
>  static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
> @@ -87,7 +111,7 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
>  	int *opp_tokens;
>  	char name[MAX_NAME_LEN];
>  	unsigned int cpu;
> -	u32 speed = 0;
> +	int speed;
>  	int ret;
>  
>  	opp_tokens = kcalloc(num_possible_cpus(), sizeof(*opp_tokens),
> @@ -95,10 +119,10 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
>  	if (!opp_tokens)
>  		return -ENOMEM;
>  
> -	ret = sun50i_cpufreq_get_efuse(&speed);
> -	if (ret) {
> +	speed = sun50i_cpufreq_get_efuse();
> +	if (speed < 0) {
>  		kfree(opp_tokens);
> -		return ret;
> +		return speed;
>  	}
>  
>  	snprintf(name, MAX_NAME_LEN, "speed%d", speed);
> 





