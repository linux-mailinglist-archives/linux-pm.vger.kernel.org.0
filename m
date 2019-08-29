Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 603DDA1C51
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2019 16:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfH2OFE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Aug 2019 10:05:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44328 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbfH2OFD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Aug 2019 10:05:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id b6so773136wrv.11
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2019 07:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5GyUYiNK1pxGFGVMqeQUMFAAek9A8tVckoOeF4bV32Q=;
        b=XA1DOwiB8cokG0MO/G4Rhedb2oX3Gvdu09OGfOjf37dcM1zTrBpBWcA2Zriw9sIzcJ
         2aZUM0TChUUUinQsSurkmbpcIvU2801OMN4B0kVQdDGLaBmRcYvVFrrgb/W0YXAswDJj
         kmkrQtdG+4LW36A+5t1k8JhsGlKzoWRWuzVJzrIgu1/WWyTz4Uu2uuR9SAyAO77iOuJ3
         1ab4wic+E+nfJZVUV4nc3Bo5CI3t6of2c3W1Hol38mjFEtpwtjT9dboa59eDpploLep3
         3fX0eFRD0rssbf8ZrcOu9oaRd6pKTDA/b5gRiCbk0zVrokgV/nsLBpwI2IYMjMYpYsxQ
         uW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5GyUYiNK1pxGFGVMqeQUMFAAek9A8tVckoOeF4bV32Q=;
        b=SsPkuyKzJM6m+20xyf1g0/GX5qvsiWzArCZz7FMtIDiTeP/zu2Q+KEi8aEVX1fz1IC
         0nyygi0w99TVAM8vTEBCHl/PJbdS+VjxhnXToAqXq389vGU/iRCrb3O0NCCuxMrKEJzR
         czsXychWd8QI1MqSj6oRxa80IpISuRNXtNN1NdiU1mjEOS5V1aD/RoeRm4PXLRoMHnLf
         9WG+q86n9xtCJRC3kifM4qRfiNSOHOzYb6wc/W9x/uokyFxAKS8NgbqCDeqRt9Uctfh3
         0sN1QL0kHjcTUEvses/oIEcaoq/w5mKp2CfRfK0s0y4GEiCSEq9Z7VG+zkG5majjIfFw
         rU1A==
X-Gm-Message-State: APjAAAWwknOEiKep+UmsECyZ5GiJJ9GE1i/aPQW4gl9qouFvqY8rm7pY
        lSBQGoP2KVzPbZM8mJjNN3LAWQ==
X-Google-Smtp-Source: APXvYqxNs6Pa/y99Xudu9UeOa/L61A1XlI/TzeOYtU/SmLGRegBBSp4WRkM/aYjODZFAj7xrjlVUVA==
X-Received: by 2002:adf:9e09:: with SMTP id u9mr11803588wre.169.1567087502052;
        Thu, 29 Aug 2019 07:05:02 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id k9sm3704025wrq.15.2019.08.29.07.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 07:05:01 -0700 (PDT)
Date:   Thu, 29 Aug 2019 15:04:59 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        sboyd@kernel.org, masneyb@onstation.org, marc.w.gonzalez@free.fr,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 03/15] drivers: thermal: tsens: Add __func__
 identifier to debug statements
Message-ID: <20190829140459.szauzhennltrwvg4@holly.lan>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
 <93fa782bde9c66845993ff883532b3f1f02d99e4.1566907161.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93fa782bde9c66845993ff883532b3f1f02d99e4.1566907161.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 27, 2019 at 05:43:59PM +0530, Amit Kucheria wrote:
> Printing the function name when enabling debugging makes logs easier to
> read.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

This should need to be manually added at each call site; it is already
built into the logging system (the f flag for dynamic debug)?


Daniel.

> ---
>  drivers/thermal/qcom/tsens-common.c | 8 ++++----
>  drivers/thermal/qcom/tsens.c        | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index c037bdf92c663..7437bfe196e50 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -42,8 +42,8 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
>  
>  	for (i = 0; i < priv->num_sensors; i++) {
>  		dev_dbg(priv->dev,
> -			"sensor%d - data_point1:%#x data_point2:%#x\n",
> -			i, p1[i], p2[i]);
> +			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
> +			__func__, i, p1[i], p2[i]);
>  
>  		priv->sensor[i].slope = SLOPE_DEFAULT;
>  		if (mode == TWO_PT_CALIB) {
> @@ -60,7 +60,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
>  		priv->sensor[i].offset = (p1[i] * SLOPE_FACTOR) -
>  				(CAL_DEGC_PT1 *
>  				priv->sensor[i].slope);
> -		dev_dbg(priv->dev, "offset:%d\n", priv->sensor[i].offset);
> +		dev_dbg(priv->dev, "%s: offset:%d\n", __func__, priv->sensor[i].offset);
>  	}
>  }
>  
> @@ -209,7 +209,7 @@ int __init init_common(struct tsens_priv *priv)
>  	if (ret)
>  		goto err_put_device;
>  	if (!enabled) {
> -		dev_err(dev, "tsens device is not enabled\n");
> +		dev_err(dev, "%s: device not enabled\n", __func__);
>  		ret = -ENODEV;
>  		goto err_put_device;
>  	}
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 542a7f8c3d962..06c6bbd69a1a7 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -127,7 +127,7 @@ static int tsens_probe(struct platform_device *pdev)
>  		of_property_read_u32(np, "#qcom,sensors", &num_sensors);
>  
>  	if (num_sensors <= 0) {
> -		dev_err(dev, "invalid number of sensors\n");
> +		dev_err(dev, "%s: invalid number of sensors\n", __func__);
>  		return -EINVAL;
>  	}
>  
> @@ -156,7 +156,7 @@ static int tsens_probe(struct platform_device *pdev)
>  
>  	ret = priv->ops->init(priv);
>  	if (ret < 0) {
> -		dev_err(dev, "tsens init failed\n");
> +		dev_err(dev, "%s: init failed\n", __func__);
>  		return ret;
>  	}
>  
> @@ -164,7 +164,7 @@ static int tsens_probe(struct platform_device *pdev)
>  		ret = priv->ops->calibrate(priv);
>  		if (ret < 0) {
>  			if (ret != -EPROBE_DEFER)
> -				dev_err(dev, "tsens calibration failed\n");
> +				dev_err(dev, "%s: calibration failed\n", __func__);
>  			return ret;
>  		}
>  	}
> -- 
> 2.17.1
> 
