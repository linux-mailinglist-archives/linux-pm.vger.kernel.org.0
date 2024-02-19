Return-Path: <linux-pm+bounces-4068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EB385A0B5
	for <lists+linux-pm@lfdr.de>; Mon, 19 Feb 2024 11:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6201F212B7
	for <lists+linux-pm@lfdr.de>; Mon, 19 Feb 2024 10:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE722561F;
	Mon, 19 Feb 2024 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tzsdwsSQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF132560F
	for <linux-pm@vger.kernel.org>; Mon, 19 Feb 2024 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337687; cv=none; b=P+iQ2UQy9dPHSvdGorgK5cs6+PhN+DPxnfS8EjC+KWb0XjOjYQqROeV50hAoE2uR3ewkzyV+9YVPbm0Ssgm9p8q2ZAV8L7FgcEd9nuwd3QngKjb4rLBnpGHrGQsoq8D+E1gUEWlWEBSGBKTOHa0at3N1KkZvAiz7DmPNc2l+i34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337687; c=relaxed/simple;
	bh=/r+Sw8hg1vButQTUTMbULSa/k6wzvq6pq3Hs/SxGJjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIfeXZuQ4lYVe3Kon/Ck270SWsCuTQmdVBjhD44Tnffqubs1jKNI88VeXC4Jpa1OoALFcTonGVwiyqlQtKhHOjG/7xpGgxG0gvrT1ySLKnLfpvz2L9yaNBXOl8DEoVyhSfw+ExpZBTaU7jBkAcwWa2mkmwtSSTOdAwgfve+RunU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tzsdwsSQ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3e82664d53so103407666b.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Feb 2024 02:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708337684; x=1708942484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+VfvyMz4J9zOLt2R+IkpEvDhJZO2XVen/W32wenUqb0=;
        b=tzsdwsSQQbOtfSEmK3gWnzUto6z/CAvnGyV4pYLpEyFfsB71j/H7acfZuuCYo/bvoz
         F4s/sIZCjyq+PMT70/7E2uGMjnle6KaZVVay3F3OPNbYKeJHfgd+yRmCiC+T0xg8F53D
         K3Q8cCMxA1pHMFmKa/Cr7Gw8WukO0lywWjSkiECwaQB3iF/iTx6vxzMgH9gpNX54uerW
         deaXoJNJjskwVJitYS0SBQiKcbK6inrF6dDH3Txyf5ZO1MqmUv8W8dFhS3pisPP8fHsH
         /mNdPvukth2vYU0krmBEJ1qogOz7OHaSVjJE8DC/T3x4Yd5QcU3OOG1WegVszh+CjZKL
         n4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708337684; x=1708942484;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+VfvyMz4J9zOLt2R+IkpEvDhJZO2XVen/W32wenUqb0=;
        b=di/0HjgvsAEjlnusdNZ68IgH/rj9azDVlvz6lFF4mjba+YKfp7C7AN/jbQkFhfxm3m
         OS93lz0IZv+v1kINVE9Xc3k+l/N2iSk9Q/f06k6RWGS0I5lxPNR68EC4UqWQmXZT3m1j
         K37IFR90olxbPT2SXC5XJT7q4XFDJcGkG8xSjPTBLw5SkTtdhoYiB4FacVbokxCSjrA0
         FvV7sUZnVhk8sVvLhDQUWNit24p7whMk7n3nmeq041daupUs5rI9Tg0GYGMWBzxRgSU9
         Iq3BFMAtw45zatQjpmrsTB6wR8sY3Aa7isOb9aObR6+oYE9FUVyf2MgKYPaJxyDi770T
         Z3DA==
X-Forwarded-Encrypted: i=1; AJvYcCVcu/AZbGNx7TuUJTJGkwvsVufl7QflhTHhM3wkWntG2p7LuJTXjAxyDZicnNB6gHaT4zAxrIJ5vSXosUBtmg316f3/yoDZKos=
X-Gm-Message-State: AOJu0Ywy6uC17l0af8+dfiDcqX2v/9IiEeZ0p1L/sj3loS5RMsOQupDO
	5gavT8TERMtzK84LR488U/v7JM6aGhNdnOCzI0zpL7wjKn2xIBEvPVOk5oujKQI=
X-Google-Smtp-Source: AGHT+IHWZTCfeNUz+MEa50xtnI28rbL81sZDIymURuniBGN+xM/ptumUPnZs90a7TfVQcwwF9TB/Lw==
X-Received: by 2002:a17:907:11c2:b0:a3e:88fb:3e23 with SMTP id va2-20020a17090711c200b00a3e88fb3e23mr1886026ejb.7.1708337683999;
        Mon, 19 Feb 2024 02:14:43 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id x19-20020a1709065ad300b00a3e786d8729sm1284360ejs.168.2024.02.19.02.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 02:14:43 -0800 (PST)
Message-ID: <ca2c5b9c-6d8c-42a4-9f27-b60f024c95c2@linaro.org>
Date: Mon, 19 Feb 2024 11:14:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: Add SM7150 driver support
Content-Language: en-US
To: Danila Tikhonov <danila@jiaxyga.com>, andersson@kernel.org,
 djakov@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240218183239.85319-1-danila@jiaxyga.com>
 <20240218183239.85319-3-danila@jiaxyga.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240218183239.85319-3-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.02.2024 19:32, Danila Tikhonov wrote:
> Add a driver that handles the different NoCs found on SM7150, based on the
> downstream dtb.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---

Looks rather good, just 3 minor things:


> +
> +static const struct of_device_id qnoc_of_match[] = {
> +	{ .compatible = "qcom,sm7150-aggre1-noc",
> +	  .data = &sm7150_aggre1_noc},

Please unwrap these and add a space before the closing curly bracket

> +	{ .compatible = "qcom,sm7150-aggre2-noc",
> +	  .data = &sm7150_aggre2_noc},
> +	{ .compatible = "qcom,sm7150-camnoc-virt",
> +	  .data = &sm7150_camnoc_virt},
> +	{ .compatible = "qcom,sm7150-compute-noc",
> +	  .data = &sm7150_compute_noc},
> +	{ .compatible = "qcom,sm7150-config-noc",
> +	  .data = &sm7150_config_noc},
> +	{ .compatible = "qcom,sm7150-dc-noc",
> +	  .data = &sm7150_dc_noc},
> +	{ .compatible = "qcom,sm7150-gem-noc",
> +	  .data = &sm7150_gem_noc},
> +	{ .compatible = "qcom,sm7150-mc-virt",
> +	  .data = &sm7150_mc_virt},
> +	{ .compatible = "qcom,sm7150-mmss-noc",
> +	  .data = &sm7150_mmss_noc},
> +	{ .compatible = "qcom,sm7150-system-noc",
> +	  .data = &sm7150_system_noc},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
> +
> +static struct platform_driver qnoc_driver = {
> +	.probe = qcom_icc_rpmh_probe,
> +	.remove_new = qcom_icc_rpmh_remove,
> +	.driver = {
> +		.name = "qnoc-sm7150",
> +		.of_match_table = qnoc_of_match,
> +		.sync_state = icc_sync_state,
> +	},
> +};
> +module_platform_driver(qnoc_driver);

This is most certainly a bad choice, but at the same time it doesn't
matter for now.. It's going to be badly delayed anyway, I have some
fixes in the pipeline. Please change it to core_initcall (which may make
your boot slower as of torvalds/master, counter-intuitively.. but I will
surely forget to update this otherwise)

[...]

> +
> +MODULE_DESCRIPTION("Qualcomm SM7150 NoC driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/interconnect/qcom/sm7150.h b/drivers/interconnect/qcom/sm7150.h
> new file mode 100644
> index 000000000000..e00a9b0c1279
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sm7150.h
> @@ -0,0 +1,140 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

GPL2+BSD3?

Konrad

