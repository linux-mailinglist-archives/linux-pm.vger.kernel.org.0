Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048C6651EF2
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 11:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiLTKie (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 05:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiLTKid (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 05:38:33 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAFB1705E
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:38:32 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id g13so1253440lfv.7
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X8lDT0GSqNcF7W4SzBZYBZGzP5QDgZ4E5/OYyv9cH/U=;
        b=Mi80BOv0JCeXWskhDI4ePQoB1zQ/LXMFtkuzPF1RtsaPanJqxsjLP4UcHA7LrRN3Ek
         i7ouFXM7PwOx5rpkCbE3ffPNXDVlLvyimIX6jfsw95l2X8TN8P7HEJsS/lwjfE1gOklm
         uJOxwGtEfDxZXBYTdjDS/8a04IVMpvSP8v8pCdAVCezoKWQR3wcjRCBhpbpUwHvsUXNb
         ccmAwSju34jSl5y1cxN8lnEjSoWWGe3/jgOWagoADfrJNy32g+hGztzxC50YAQweJioE
         kS7EvpHzpSx+xekqBhwgg/XfLbTYNyIC02ptIl3Y3XpneWhnSIz9vkq9Z2UHL9iRTzES
         N5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8lDT0GSqNcF7W4SzBZYBZGzP5QDgZ4E5/OYyv9cH/U=;
        b=KVJr69t3rLVSrp53MXO/3yUbGAbolmqfsIzrv2jhWI5zAKnfQHSsJKltaU0XHwDPKz
         F0rA9QsMtwuvYuzbbo4JZT7O3wov4U1f8nkrz71TtIsNzjxOljLdiFiEzdEqKs81zxm5
         epoPfiA7hT3j+ltTLDovY5uWKFHF5B63CEvYcbeydfbqQkOW0xOPuzcev7yGJKWri3BA
         PIYh9HKHXAn6GVgAVtUDUm/bMpL2x3yle0bo4Nordy9UIhPwajAArVb6/epawc1aP6ma
         BHtdcpBVUnErOLu+8yzO+kFDUZNpJ+1X/Xiq56lFglKNZWwRH/+1JqKe9oLQIaVf40DD
         oz3w==
X-Gm-Message-State: ANoB5pnbvH7+KLc03f2FeAoh/NYFVKhIVYLw+3yzynrsvayeIrxRsFb0
        C7k+Kf7f0TgGKCva1ZlNT2Jw4A==
X-Google-Smtp-Source: AA0mqf4B7EI4V7HkAz6of7L557MHtJvPBs4lluW4o6l2ocAM3HbyAK+oLId2oIe34SIFuL3BpZZ2nw==
X-Received: by 2002:a19:771d:0:b0:4b6:ebbc:3d3a with SMTP id s29-20020a19771d000000b004b6ebbc3d3amr9620212lfc.53.1671532710432;
        Tue, 20 Dec 2022 02:38:30 -0800 (PST)
Received: from [192.168.1.101] (abxh212.neoplus.adsl.tpnet.pl. [83.9.1.212])
        by smtp.gmail.com with ESMTPSA id v24-20020ac258f8000000b004947984b385sm1400681lfo.87.2022.12.20.02.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:38:29 -0800 (PST)
Message-ID: <5c59c651-2275-0159-7de2-ce496ce749af@linaro.org>
Date:   Tue, 20 Dec 2022 11:38:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 11/15] thermal/drivers/tsens: Support using nvmem cells
 for msm8974 calibration
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
 <20221220024721.947147-12-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221220024721.947147-12-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 20.12.2022 03:47, Dmitry Baryshkov wrote:
> MSM8974 has two sets of calibration data: main one and backup. Add
> support for parsing both sets of calibration data from nvmem cells.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/thermal/qcom/tsens-v0_1.c | 50 +++++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.c      | 39 +++++++++++++++++++-----
>  drivers/thermal/qcom/tsens.h      |  1 +
>  3 files changed, 82 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index caffcf9905b9..6a11b8b196b9 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2015, The Linux Foundation. All rights reserved.
>   */
>  
> +#include <linux/nvmem-consumer.h>
>  #include <linux/platform_device.h>
>  #include "tsens.h"
>  
> @@ -194,6 +195,50 @@ static int calibrate_8916(struct tsens_priv *priv)
>  	return 0;
>  }
>  
> +static int calibrate_8974_nvmem(struct tsens_priv *priv)
> +{
> +	int i, ret, mode;
> +	u32 p1[11], p2[11];
> +	u32 backup;
> +
> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, "use_backup", &backup);
> +	if (ret == -ENOENT)
> +		dev_warn(priv->dev, "Please migrate to separate nvmem cells for calibration data\n");
> +	if (ret < 0)
> +		return ret;
> +
> +	mode = tsens_read_calibration(priv, 2, p1, p2, backup == BKP_SEL);
> +	if (mode < 0)
> +		return mode;
> +
> +	if (mode == NO_PT_CALIB) {
> +		p1[0] += 2;
> +		p1[1] += 9;
> +		p1[2] += 3;
> +		p1[3] += 9;
> +		p1[4] += 5;
> +		p1[5] += 9;
> +		p1[6] += 7;
> +		p1[7] += 10;
> +		p1[8] += 8;
> +		p1[9] += 9;
> +		p1[10] += 8;
> +	} else {
> +		for (i = 0; i < priv->num_sensors; i++) {
> +			/*
> +			 * ONE_PT_CALIB requires using addition here instead of
> +			 * using OR operation.
> +			 */
> +			p1[i] += BIT_APPEND;
> +			p2[i] += BIT_APPEND;
> +		}
> +	}
> +
> +	compute_intercept_slope(priv, p1, p2, mode);
> +
> +	return 0;
> +}
> +
>  static int calibrate_8974(struct tsens_priv *priv)
>  {
>  	int base1 = 0, base2 = 0, i;
> @@ -201,6 +246,11 @@ static int calibrate_8974(struct tsens_priv *priv)
>  	int mode = 0;
>  	u32 *calib, *bkp;
>  	u32 calib_redun_sel;
> +	int ret;
> +
> +	ret = calibrate_8974_nvmem(priv);
> +	if (ret == 0)
> +		return 0;
>  
>  	calib = (u32 *)qfprom_read(priv->dev, "calib");
>  	if (IS_ERR(calib))
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 68aef0ed6182..83bf60fa9008 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -70,18 +70,21 @@ char *qfprom_read(struct device *dev, const char *cname)
>  	return ret;
>  }
>  
> -int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift)
> +int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2, bool backup)
>  {
>  	u32 mode;
>  	u32 base1, base2;
> -	u32 p1[MAX_SENSORS], p2[MAX_SENSORS];
> -	char name[] = "sXX_pY"; /* s10_p1 */
> +	char name[] = "sXX_pY_backup"; /* s10_p1_backup */
>  	int i, ret;
>  
>  	if (priv->num_sensors > MAX_SENSORS)
>  		return -EINVAL;
>  
> -	ret = nvmem_cell_read_variable_le_u32(priv->dev, "mode", &mode);
> +	ret = snprintf(name, sizeof(name), "mode%s", backup ? "_backup" : "");
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &mode);
>  	if (ret == -ENOENT)
>  		dev_warn(priv->dev, "Please migrate to separate nvmem cells for calibration data\n");
>  	if (ret < 0)
> @@ -89,16 +92,24 @@ int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift)
>  
>  	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
>  
> -	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base1", &base1);
> +	ret = snprintf(name, sizeof(name), "base1%s", backup ? "_backup" : "");
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &base1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snprintf(name, sizeof(name), "base2%s", backup ? "_backup" : "");
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base2", &base2);
> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &base2);
>  	if (ret < 0)
>  		return ret;
>  
>  	for (i = 0; i < priv->num_sensors; i++) {
> -		ret = snprintf(name, sizeof(name), "s%d_p1", i);
> +		ret = snprintf(name, sizeof(name), "s%d_p1%s", i, backup ? "_backup" : "");
>  		if (ret < 0)
>  			return ret;
>  
> @@ -106,7 +117,7 @@ int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift)
>  		if (ret)
>  			return ret;
>  
> -		ret = snprintf(name, sizeof(name), "s%d_p2", i);
> +		ret = snprintf(name, sizeof(name), "s%d_p2%s", i, backup ? "_backup" : "");
>  		if (ret < 0)
>  			return ret;
>  
> @@ -136,6 +147,18 @@ int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift)
>  		}
>  	}
>  
> +	return mode;
> +}
> +
> +int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift)
> +{
> +	u32 p1[MAX_SENSORS], p2[MAX_SENSORS];
> +	int mode;
> +
> +	mode = tsens_read_calibration(priv, shift, p1, p2, false);
> +	if (mode < 0)
> +		return mode;
> +
>  	compute_intercept_slope(priv, p1, p2, mode);
>  
>  	return 0;
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 645ae02438fa..a9ae8df9f810 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -585,6 +585,7 @@ struct tsens_priv {
>  };
>  
>  char *qfprom_read(struct device *dev, const char *cname);
> +int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2, bool backup);
>  int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift);
>  int tsens_calibrate_common(struct tsens_priv *priv);
>  void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
