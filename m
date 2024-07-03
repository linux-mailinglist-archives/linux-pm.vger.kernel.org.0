Return-Path: <linux-pm+bounces-10535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46108925C55
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 13:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2170B29A75F
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 11:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C54117A592;
	Wed,  3 Jul 2024 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oFAdw+/f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8575D13A27E
	for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2024 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004582; cv=none; b=G1rqFLUSsEgeTRdx3EcXsjPjf+sKJL49ikSJ4O00ARezzYKxwAb9Ct1QawQbQdc37gJZUVh1PKFLecawJXLqJwRevg/a1Oq2PwezBKlTLzgMZimsZmhnQH8iSAzbsrEXisFgmSgzNFDsQuosX128LkNWET6QCF69m1uPKgjtCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004582; c=relaxed/simple;
	bh=LvSBtxEWxuVYS7CxvKWKkwY51EhpTRzSAwu7h7K0Wqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgGr/K4mKRkXwVAlG0DtiTgjIMZ2Dzrt4d7kO6fgL5gUjLfkq7ljY5++5wAeiSzpqWAVqZ80j4yEk9PD+1UKc+Ou/WQaiLgrbjrP9mhy9je9+sZUbKnly2J+WADTw1qx2dMZ3NFYC+g8U/7zbif9c+HOwsz4iE6OHQ11pUZhtB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oFAdw+/f; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e98087e32so604529e87.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 04:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720004579; x=1720609379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=im1b/RxdrHSt8wujFjtbUuQ9aPQyW+sjarxKVIwXx4I=;
        b=oFAdw+/f1idHUvfxWukDmGGg4gwyh24US0VfGO7j+l48Wsciwtpcyl9gfIT+oY4XZi
         bNfuqTtLMMklH42qRUkw175u8tCjZ+qv0WN4m2iGcg+fx2Af8B/WxryD4WlgBV8S5KN1
         lWR5YPfAFYpWaFJCbnkXERJsdyB+aIVNjqYbi3NM0F7vy0XfYm1V6mYIYemiI6Ib8Apw
         GGoTCGXt02+6bwwZ/kivtH/GbK1dPnvpSfHD/OssU33PPb0eUMjkD2moPb2rxBUV/s6M
         /GnyGww6hSz87qNLZ8dogFRUMUYEpl43XbYUvIstrpUEclVB+/VkrC1WOaOwmxvK8imX
         RM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720004579; x=1720609379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=im1b/RxdrHSt8wujFjtbUuQ9aPQyW+sjarxKVIwXx4I=;
        b=vVTXSDRKjhl7GbLXnFNR3r09Os5euTTncjeXxWF+7PHGubUdesc1mQfImzkXKjgd+m
         3zm9VhcdcdmHACNLm0UzdE6Pr1Of9s8OgOUaqByLrHttfpbz/tghISqwAyM8kdA7Ym3R
         3XFq0yym75S9Ji7vzpdKbnThNHlWiLtjC7XGdQjyR/8dnEb1+QXtcwvEDbWHi0mNVOKC
         NZD4CRUemH44hKv+VMuQcYKoiE/wjf1oYs2NvQ4SKXaImeMJjpK8iL/5rxc+7ocbcxTZ
         Tjyxq7de3DMckSExHyv/xxS4Dp7UICoE6+hLnsgUZqhgFVxhivAXDvyF2KUEDgYztWsd
         eZNw==
X-Forwarded-Encrypted: i=1; AJvYcCUIt6YNGsK9EdCIKPdVdIng5KV3iMguJW0DEn3gTW2Nb8qvVMb//4O8l+BhOB4X8eJ0ryG6YmxAzfv75pfM0jUmXf4r+d72S7g=
X-Gm-Message-State: AOJu0Yxg2Noh4w0DGs/dylWXLisJk07zHGWdZYNkyp7AzPd3sJ9odUF7
	mxgCDJkzpcDQbyGvwkqEFNRDjr4HJzjy6Bkb3xzkbZ/qu5E5ssTXLNxAg4SmAwc=
X-Google-Smtp-Source: AGHT+IEDg1CPm96hk7pBzbU18xhMMyXjzJowHnqih7mx71cOA9L6GtsgW5xU8ZTdE5oORxO75UsBvw==
X-Received: by 2002:a05:6512:b14:b0:52c:db80:d694 with SMTP id 2adb3069b0e04-52e82679565mr7964235e87.20.1720004578743;
        Wed, 03 Jul 2024 04:02:58 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab101c5sm2110487e87.79.2024.07.03.04.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 04:02:58 -0700 (PDT)
Date: Wed, 3 Jul 2024 14:02:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, angelogioacchino.delregno@collabora.com, 
	andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	ilia.lin@kernel.org, rafael@kernel.org, ulf.hansson@linaro.org, 
	quic_sibis@quicinc.com, quic_rjendra@quicinc.com, quic_rohiagar@quicinc.com, 
	abel.vesa@linaro.org, otto.pflueger@abscue.de, danila@jiaxyga.com, 
	quic_ipkumar@quicinc.com, luca@z3ntu.xyz, stephan.gerhold@kernkonzept.com, nks@flawful.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 02/10] cpufreq: qcom-nvmem: Add support for IPQ9574
Message-ID: <lhpdxlbmjsfgmsr5edjg4io3bwb6rkp7xz6ztvphdb4cme264e@j7mr6wp7bmnq>
References: <20240703091651.2820236-1-quic_varada@quicinc.com>
 <20240703091651.2820236-3-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703091651.2820236-3-quic_varada@quicinc.com>

On Wed, Jul 03, 2024 at 02:46:43PM GMT, Varadarajan Narayanan wrote:
> Add qcom_cpufreq_match_data for IPQ9574. This is used for tying
> up the cpu@N nodes with the power domains. match_data_kryo is not
> used since it doesn't set genpd_names. If genpd_names is not set,
> 'cat /sys/kernel/debug/qcom_cpr3/thread0' causes cpr3_debug_info_show()
> to crash while trying to read thread->corner->last_uV as
> thread->corner is NULL.
> 
> 	Call trace:
> 		cpr3_debug_info_show
> 		seq_read_iter
> 		seq_read

I'd say, the commit message might be simpler:

IPQ9574 uses CPR4 power domain to manage core supplies. Use
device-specific match data for this platform that includes genpd_names
configuration.

Anyway:

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v4: Update commit log to include stack trace
>     Introduce qcom_cpufreq_match_data for IPQ9574
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 939702dfa73f..95558586c2e6 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -428,6 +428,11 @@ static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
>  	.get_version = qcom_cpufreq_ipq8074_name_version,
>  };
>  
> +static const struct qcom_cpufreq_match_data match_data_ipq9574 = {
> +	.get_version = qcom_cpufreq_kryo_name_version,
> +	.genpd_names = generic_genpd_names,
> +};
> +
>  static void qcom_cpufreq_suspend_virt_devs(struct qcom_cpufreq_drv *drv, unsigned int cpu)
>  {
>  	const char * const *name = drv->data->genpd_names;
> @@ -621,7 +626,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
>  	{ .compatible = "qcom,ipq8064", .data = &match_data_ipq8064 },
>  	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
>  	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
> -	{ .compatible = "qcom,ipq9574", .data = &match_data_kryo },
> +	{ .compatible = "qcom,ipq9574", .data = &match_data_ipq9574 },
>  	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
>  	{ .compatible = "qcom,msm8960", .data = &match_data_krait },
>  	{},
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

