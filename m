Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840EA1DED91
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 18:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbgEVQoq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 12:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbgEVQoo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 12:44:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E92C061A0E
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 09:44:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so5415810wrp.2
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 09:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jD3qtCbQBfxkGztEcewlFtFpSycVMkWT5K4Cw3TN4rk=;
        b=rj4s/cH9LimVn2JVzIq9fCumTNw917XQ/+Y5qPVhj6ff1QiCqfh7oa8SvU9bNx+bn2
         4yA0enZBjJRl/l9pgiQ2Xud3NnPGZeqGKj5H2AdYkMDHwqFsdnEkU6tvpN4KcwPj93c+
         P6OgDMHaJSM1UrLfFyGNI9V+fOc6bBMA5Z6etJwu8m19lOW/3MV5kHnwxvRQCyOERv38
         /8QYAn1kSOlEAWzo2E5r3PvngIwAv8ksx9yqUbfiFRfClp/qlJeAxOt9zhZ0QEIO9A//
         F2zhXcqPkx9CIi14YLcYnVcflSOsMIEzZN6OW14rncrxYyADaajQgvhSaNgvo2mc5lrO
         ohyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jD3qtCbQBfxkGztEcewlFtFpSycVMkWT5K4Cw3TN4rk=;
        b=M8rG0+ZoplBMXyfzv+rphoz9BKZtVHwoDrnqHqlLewY6EOX9/NMab8aLEK8vc0X6R/
         PEdtj5ajLlYUryAgLnXNOCdZs+3v2RAxyk5YF5TTq1y+CE40iqGkUnljMTGeoZjTxS7L
         IfEJFuur1p1urR8Vh8Smgq1z3VEV50VntGG699SDxon0o/NkQaj16YVWptSrpUKIxNHj
         rF25pKRPFk+rYUgQ8TwRR2EJvHW/OkdJrkICmPqFJovdtt5gCGKhakeSezA2zG1wroOF
         b85Ek2akj4AjLHfMehPhnoluuSz/tzSfenYAwCJ1uOzm+WQfhkxVbF+GfATU9ZkxD1xY
         I17w==
X-Gm-Message-State: AOAM533frha0tNM9K8yZkmK9X028pRyKzkUUbW7NPGJAKPfXW4GfK08y
        gT+5hgsiGD2fl3uGwjEF635Kdw==
X-Google-Smtp-Source: ABdhPJwdyoxgDONWtdqkOGyQhEcgpc7Y2fAWk4C27dWlQ6JsTIkNK4sjU0bO71T2XZ5tU8e4R8oE1w==
X-Received: by 2002:a5d:6943:: with SMTP id r3mr3966974wrw.113.1590165881375;
        Fri, 22 May 2020 09:44:41 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a82f:eaec:3c49:875a? ([2a01:e34:ed2f:f020:a82f:eaec:3c49:875a])
        by smtp.googlemail.com with ESMTPSA id n4sm9346454wmc.31.2020.05.22.09.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 09:44:40 -0700 (PDT)
Subject: Re: [PATCH v2] thermal: qoriq: Update the settings for TMUv2
To:     Yuantian Tang <andy.tang@nxp.com>, rui.zhang@intel.com,
        edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200416093940.34371-1-andy.tang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7fa1d7c2-e967-926b-772a-a2025a391aab@linaro.org>
Date:   Fri, 22 May 2020 18:44:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416093940.34371-1-andy.tang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/04/2020 11:39, Yuantian Tang wrote:
> For TMU v2, TMSAR registers need to be set properly to get the
> accurate temperature values.
> Also temperature reading needs to convert to degree Celsius
> since it is in degrees Kelvin.

Please have a look at units.h for celsius <-> kelvin conversion

> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---
> v2:
> 	- change the temp in millicelsius
> 
>  drivers/thermal/qoriq_thermal.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 028a6bbf75dc..f6371127f707 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -23,6 +23,7 @@
>  #define TMTMIR_DEFAULT	0x0000000f
>  #define TIER_DISABLE	0x0
>  #define TEUMR0_V2		0x51009c00
> +#define TMSARA_V2		0xe
>  #define TMU_VER1		0x1
>  #define TMU_VER2		0x2
>  
> @@ -50,6 +51,9 @@
>  					    * Site Register
>  					    */
>  #define TRITSR_V	BIT(31)
> +#define REGS_V2_TMSAR(n)	(0x304 + 16 * (n))	/* TMU monitoring
> +						* site adjustment register
> +						*/
>  #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
>  					   * Control Register
>  					   */
> @@ -100,7 +104,11 @@ static int tmu_get_temp(void *p, int *temp)
>  				     10 * USEC_PER_MSEC))
>  		return -ENODATA;
>  
> -	*temp = (val & 0xff) * 1000;
> +	/* For TMUv2, temperature reading in degrees Kelvin */
> +	if (qdata->ver == TMU_VER1)
> +		*temp = (val & 0xff) * 1000;
> +	else
> +		*temp = ((val & 0x1ff) - 273) * 1000;
>  
>  	return 0;
>  }
> @@ -192,6 +200,8 @@ static int qoriq_tmu_calibration(struct device *dev,
>  
>  static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
>  {
> +	int i;
> +
>  	/* Disable interrupt, using polling instead */
>  	regmap_write(data->regmap, REGS_TIER, TIER_DISABLE);
>  
> @@ -202,6 +212,8 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
>  	} else {
>  		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
>  		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
> +		for (i = 0; i < 7; i++)
> +			regmap_write(data->regmap, REGS_V2_TMSAR(i), TMSARA_V2);
>  	}
>  
>  	/* Disable monitoring */
> @@ -212,6 +224,7 @@ static const struct regmap_range qoriq_yes_ranges[] = {
>  	regmap_reg_range(REGS_TMR, REGS_TSCFGR),
>  	regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(3)),
>  	regmap_reg_range(REGS_V2_TEUMR(0), REGS_V2_TEUMR(2)),
> +	regmap_reg_range(REGS_V2_TMSAR(0), REGS_V2_TMSAR(15)),
>  	regmap_reg_range(REGS_IPBRR(0), REGS_IPBRR(1)),
>  	/* Read only registers below */
>  	regmap_reg_range(REGS_TRITSR(0), REGS_TRITSR(15)),
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
