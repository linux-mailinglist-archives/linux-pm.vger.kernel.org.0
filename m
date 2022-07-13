Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DF1572C9B
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jul 2022 06:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiGMEau (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jul 2022 00:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiGMEat (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2022 00:30:49 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B0726FD
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 21:30:48 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id t26-20020a9d775a000000b006168f7563daso7603978otl.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 21:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6N8ChIQx6pex81y/6RbqslzOiu4f4qETiQ5M4m/U06o=;
        b=ndBc7G7nHdfY9KsFXFOIc14lB0MciSnICKLcYwkT7Yxg7a7iZ5+wTHd7UlW0Vmafyp
         o48cUGAzBq6PyQ197/tEnmvHsxYXf2JTYGTxJw1PdywLdeS2QnFdZAvFu4KYEIdeCPyM
         VUoIgG4/s4xZNycYVEDBqBVNsQzj/EXEV+KnyZKRg/gdjeJAOE+XEvKsVPQUb6fysAwi
         VoelG78Hn72TqBqhRGiC+5yFloeUELMoLIZnxvuD0FWXRPKuTYkXL3y+FeR6gHH67ob4
         QHCFG69XcPK63cJM8u6x7xRTsV2HvN4If8G2+g9BgdxeicdqDdUVF1BnNimzgk2OEFDU
         27WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6N8ChIQx6pex81y/6RbqslzOiu4f4qETiQ5M4m/U06o=;
        b=QiigHVVyE3mJYmXqPW0XzSZKc5/IqLJKvOCzJCHKbHsJC2lGwZy+kOV2k8DbPg6Z/o
         lATUQQf92fD2+ZKKsQQiDuvsP8cuNKl+w1bN5KO6K4i6IRJxDndyNsySqRtW8Snlz+IU
         aUO1WLVnb6RoQkv3RUaDTXkqJLYOeoSHtqD6L0SWse0U16zEiB7hA6B/Eysy4ULv/Q7x
         69r47Rolsd2YRlHYsdoufeNAkMRd9a7WHxiHekjEz2EHZCCzeX5wKNoLEMKwOE1qjaUC
         viiqLvRHSUdG7Uukntrf+WlA2ppdoOqg2G4HVBqSKe+fZ2ZayxK0gZP6wIEpiW/aSmPO
         Tk5A==
X-Gm-Message-State: AJIora9Fct6tsg4ctkK0Va2RbvUGwIzA6e2m6sUKvs4B2M9p8kx3nUCS
        6ejjHC+9NKFECViv2ey+OrY/wA==
X-Google-Smtp-Source: AGRyM1uCPT3DbFnOwTexzPekAoU8MyeLpj7KIV0wLNIHENFle2jyFGffI0fzdIBQZb7goZ/namEHlw==
X-Received: by 2002:a9d:664a:0:b0:61c:312f:27d2 with SMTP id q10-20020a9d664a000000b0061c312f27d2mr584900otm.147.1657686647878;
        Tue, 12 Jul 2022 21:30:47 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t67-20020a4a5446000000b0042bd87fd123sm4497755ooa.19.2022.07.12.21.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:30:47 -0700 (PDT)
Date:   Tue, 12 Jul 2022 23:30:45 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     amitk@kernel.org, thara.gopinath@gmail.com, agross@kernel.org,
        david.brown@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu
Subject: Re: [PATCH] thermal/drivers/qcom: Code refactoring
Message-ID: <Ys5KdVQmA9YTmfCT@builder.lan>
References: <20220712173127.3677491-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712173127.3677491-1-carlos.bilbao@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 12 Jul 12:31 CDT 2022, Carlos Bilbao wrote:

> Some functions in tsens-8960.c can directly return ret instead of doing an
> extra check. In function calibrate_8960(), a second check for IS_ERR(data)
> can also be avoided in some cases. A constant could be used to represent
> the maximum number of sensors (11). Finally, function code_to_degc() can be
> simplified, avoiding using an extra variable.
> 

Thanks for the patch Carlos. These are rather small fixes, but it would
still be nice to keep them separate, so that in the even of there being
some unforseen regression it would be easy to track down and fix the
relevant patch.

> Include these small refactoring changes.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  drivers/thermal/qcom/tsens-8960.c   | 25 +++++++++----------------
>  drivers/thermal/qcom/tsens-common.c | 18 ++++++++----------
>  drivers/thermal/qcom/tsens-v0_1.c   |  6 +++---
>  drivers/thermal/qcom/tsens-v1.c     |  2 +-
>  drivers/thermal/qcom/tsens.h        |  1 +
>  5 files changed, 22 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
> index 8d9b721dadb6..576bca871655 100644
> --- a/drivers/thermal/qcom/tsens-8960.c
> +++ b/drivers/thermal/qcom/tsens-8960.c
> @@ -76,10 +76,8 @@ static int suspend_8960(struct tsens_priv *priv)
>  		mask = SLP_CLK_ENA_8660 | EN;
>  
>  	ret = regmap_update_bits(map, CNTL_ADDR, mask, 0);

Why not just do:

	return regmap_writen(...);

> -	if (ret)
> -		return ret;
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int resume_8960(struct tsens_priv *priv)
> @@ -106,10 +104,8 @@ static int resume_8960(struct tsens_priv *priv)
>  		return ret;
>  
>  	ret = regmap_write(map, CNTL_ADDR, priv->ctx.control);
> -	if (ret)
> -		return ret;
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int enable_8960(struct tsens_priv *priv, int id)
> @@ -132,10 +128,8 @@ static int enable_8960(struct tsens_priv *priv, int id)
>  		reg |= mask | SLP_CLK_ENA_8660 | EN;
>  
>  	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg);
> -	if (ret)
> -		return ret;
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static void disable_8960(struct tsens_priv *priv)
> @@ -206,10 +200,8 @@ static int init_8960(struct tsens_priv *priv)
>  
>  	reg_cntl |= EN;
>  	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
> -	if (ret)
> -		return ret;
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int calibrate_8960(struct tsens_priv *priv)
> @@ -221,10 +213,11 @@ static int calibrate_8960(struct tsens_priv *priv)
>  	struct tsens_sensor *s = priv->sensor;
>  
>  	data = qfprom_read(priv->dev, "calib");
> -	if (IS_ERR(data))
> +	if (IS_ERR(data)) {
>  		data = qfprom_read(priv->dev, "calib_backup");
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
> +		if (IS_ERR(data))
> +			return PTR_ERR(data);
> +	}
>  
>  	for (i = 0; i < num_read; i++, s++)
>  		s->offset = data[i];
> @@ -278,6 +271,6 @@ static const struct tsens_ops ops_8960 = {
>  };
>  
>  const struct tsens_plat_data data_8960 = {
> -	.num_sensors	= 11,
> +	.num_sensors	= MAX_NUM_SENSORS,
>  	.ops		= &ops_8960,
>  };
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 528df8801254..fe5f4459e1cc 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -66,19 +66,17 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
>  
>  static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
>  {
> -	int degc, num, den;
> +	int degc, den;
>  
> -	num = (adc_code * SLOPE_FACTOR) - s->offset;
> +	degc = (adc_code * SLOPE_FACTOR) - s->offset;

At this point the variable name is misleading, it's not until you have
reassigned degc below that it's value represent the temperature.

>  	den = s->slope;
>  
> -	if (num > 0)
> -		degc = num + (den / 2);
> -	else if (num < 0)
> -		degc = num - (den / 2);
> -	else
> -		degc = num;

So the main part of this change is to rework the else case, how about
just starting with:

	if (!num)
		return 0;

> -
> -	degc /= den;
> +	if (degc != 0) {
> +		if (degc > 0)
> +			degc = (degc + (den / 2)) / den;
> +		else
> +			degc = (degc - (den / 2)) / den;
> +	}
>  
>  	return degc;
>  }
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 6f26fadf4c27..42e897526345 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -188,7 +188,7 @@ static int calibrate_8916(struct tsens_priv *priv)
>  static int calibrate_8974(struct tsens_priv *priv)
>  {
>  	int base1 = 0, base2 = 0, i;
> -	u32 p1[11], p2[11];
> +	u32 p1[MAX_NUM_SENSORS], p2[MAX_NUM_SENSORS];
>  	int mode = 0;
>  	u32 *calib, *bkp;
>  	u32 calib_redun_sel;
> @@ -324,7 +324,7 @@ static const struct tsens_features tsens_v0_1_feat = {
>  	.crit_int	= 0,
>  	.adc		= 1,
>  	.srot_split	= 1,
> -	.max_sensors	= 11,
> +	.max_sensors	= MAX_NUM_SENSORS,
>  };
>  
>  static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
> @@ -374,7 +374,7 @@ static const struct tsens_ops ops_8974 = {
>  };
>  
>  const struct tsens_plat_data data_8974 = {
> -	.num_sensors	= 11,
> +	.num_sensors	= MAX_NUM_SENSORS,
>  	.ops		= &ops_8974,
>  	.feat		= &tsens_v0_1_feat,
>  	.fields	= tsens_v0_1_regfields,
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index 10b595d4f619..98acc9b64555 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -149,7 +149,7 @@ static const struct tsens_features tsens_v1_feat = {
>  	.crit_int	= 0,
>  	.adc		= 1,
>  	.srot_split	= 1,
> -	.max_sensors	= 11,
> +	.max_sensors	= MAX_NUM_SENSORS,
>  };
>  
>  static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 2fd94997245b..d2d78c7e20c8 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -6,6 +6,7 @@
>  #ifndef __QCOM_TSENS_H__
>  #define __QCOM_TSENS_H__
>  
> +#define MAX_NUM_SENSORS		11

This only seems to apply for the three cases you have listed here, e.g.
tsens-v2 (which also includes tsens.h) has max_sensors = 16.

Regards,
Bjorn

>  #define ONE_PT_CALIB		0x1
>  #define ONE_PT_CALIB2		0x2
>  #define TWO_PT_CALIB		0x3
> -- 
> 2.31.1
> 
