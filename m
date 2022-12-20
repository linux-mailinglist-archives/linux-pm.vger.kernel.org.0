Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FC0651EB0
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 11:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiLTKW2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 05:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiLTKW1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 05:22:27 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9C4958F
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:22:26 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b13so17911446lfo.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LfLSmCJXDgaEBQ0MXfrJ0jVOby0brI+wqGUbFxoWZmE=;
        b=bQ6BqTZpH0e68SHvkIz6AOfu70NJ8jQEmnlALIjxBZ6vZUCukO5le4ojOkANXueiZp
         oNjchzshxoLAg7ZVB8q7HQ0YX5We6D4/PXODZtBn6wjeB7ed3sWuBs6D34h3gP8dBygc
         mxB1ggu8+FrVVlmdX+WToP98RsVELKGVyXjRyYrOOwddJKb19Jnz1Sc5xLq6ODeYVMkN
         Gw4myWSDe9g0B8ayOIXjUs0483wpLaoP9lGf1qVIbTICC+E94IhMs/7idnJ5XWFlm1e/
         N1iSY5fR278gecJSJZP4pl1ZkfczlIRDPDmYTKWDo33q8Xm84CDCZQ5i/USMBaqATyrF
         LOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfLSmCJXDgaEBQ0MXfrJ0jVOby0brI+wqGUbFxoWZmE=;
        b=SsyFRqHuUHsOOQE+J+scpnbAE0ZQxnxAobKoA26LiLdPdcC0pxc4yVt7FpH8dO+1Zg
         GHUYRUnhGlcevw7wVoEOK3u80YAlyp/WR4LAJieWwwvcy4u35caTvUVUmVoE6Th9STzN
         fApm/L5GsLijMdWogJytoX7Bt3noaf8Re6RGD2tnuY4erB+SSywpAASFWVYnKSM7otlS
         EQ+QpwbYgXtjxpe4r48QtziKK26shA8QcwSfMU8LWfsRCTDaH9l8ipzIQcoTiu4WJJpY
         AjMy4kBOMjTvtsygVb5MKDGE9rqfgU3fRn9aCws/igydfPRAtoAhZ04yLreryrvfU01g
         Cnew==
X-Gm-Message-State: ANoB5plN1aODMDJU9sPzwxGHtGpvLfnMVroAPBk5Qvc+JRScYq7kPB0f
        pB+k1bL24eURmEuAJ6lJxTO4yA==
X-Google-Smtp-Source: AA0mqf4iftbcuZkwqolFuhr5cHTmB78dbgKyI2pUl/V8m9WfuqGIlfIBOax/CrVMLevWNUieA6WHvw==
X-Received: by 2002:a05:6512:2344:b0:4b5:a70f:8efc with SMTP id p4-20020a056512234400b004b5a70f8efcmr22614450lfu.64.1671531744491;
        Tue, 20 Dec 2022 02:22:24 -0800 (PST)
Received: from [192.168.1.101] (abxh212.neoplus.adsl.tpnet.pl. [83.9.1.212])
        by smtp.gmail.com with ESMTPSA id f11-20020a056512360b00b004b550c26949sm1401686lfs.290.2022.12.20.02.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:22:24 -0800 (PST)
Message-ID: <2016987e-2496-20e3-5518-3be9d494dd3c@linaro.org>
Date:   Tue, 20 Dec 2022 11:22:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 09/15] thermal/drivers/tsens: Drop single-cell code for
 mdm9607
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
 <20221220024721.947147-10-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221220024721.947147-10-dmitry.baryshkov@linaro.org>
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
> There is no dtsi file for mdm9607 in the kernel sources. Drop the
> compatibility with unofficial dtsi and remove support for handling the
> single-cell calibration data on mdm9607.
> 
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/thermal/qcom/tsens-v0_1.c | 95 +------------------------------
>  1 file changed, 1 insertion(+), 94 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 8f1ea7075354..caffcf9905b9 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -133,39 +133,6 @@
>  
>  #define BIT_APPEND		0x3
>  
> -/* eeprom layout data for mdm9607 */
> -#define MDM9607_BASE0_MASK	0x000000ff
> -#define MDM9607_BASE1_MASK	0x000ff000
> -#define MDM9607_BASE0_SHIFT	0
> -#define MDM9607_BASE1_SHIFT	12
> -
> -#define MDM9607_S0_P1_MASK	0x00003f00
> -#define MDM9607_S1_P1_MASK	0x03f00000
> -#define MDM9607_S2_P1_MASK	0x0000003f
> -#define MDM9607_S3_P1_MASK	0x0003f000
> -#define MDM9607_S4_P1_MASK	0x0000003f
> -
> -#define MDM9607_S0_P2_MASK	0x000fc000
> -#define MDM9607_S1_P2_MASK	0xfc000000
> -#define MDM9607_S2_P2_MASK	0x00000fc0
> -#define MDM9607_S3_P2_MASK	0x00fc0000
> -#define MDM9607_S4_P2_MASK	0x00000fc0
> -
> -#define MDM9607_S0_P1_SHIFT	8
> -#define MDM9607_S1_P1_SHIFT	20
> -#define MDM9607_S2_P1_SHIFT	0
> -#define MDM9607_S3_P1_SHIFT	12
> -#define MDM9607_S4_P1_SHIFT	0
> -
> -#define MDM9607_S0_P2_SHIFT	14
> -#define MDM9607_S1_P2_SHIFT	26
> -#define MDM9607_S2_P2_SHIFT	6
> -#define MDM9607_S3_P2_SHIFT	18
> -#define MDM9607_S4_P2_SHIFT	6
> -
> -#define MDM9607_CAL_SEL_MASK	0x00700000
> -#define MDM9607_CAL_SEL_SHIFT	20
> -
>  static int calibrate_8916(struct tsens_priv *priv)
>  {
>  	int base0 = 0, base1 = 0, i;
> @@ -363,60 +330,6 @@ static int calibrate_8974(struct tsens_priv *priv)
>  	return 0;
>  }
>  
> -static int calibrate_9607(struct tsens_priv *priv)
> -{
> -	int base, i;
> -	u32 p1[5], p2[5];
> -	int mode = 0;
> -	u32 *qfprom_cdata;
> -	int ret;
> -
> -	ret = tsens_calibrate_common(priv);
> -	if (!ret)
> -		return 0;
> -
> -	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
> -	if (IS_ERR(qfprom_cdata))
> -		return PTR_ERR(qfprom_cdata);
> -
> -	mode = (qfprom_cdata[2] & MDM9607_CAL_SEL_MASK) >> MDM9607_CAL_SEL_SHIFT;
> -	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
> -
> -	switch (mode) {
> -	case TWO_PT_CALIB:
> -		base = (qfprom_cdata[2] & MDM9607_BASE1_MASK) >> MDM9607_BASE1_SHIFT;
> -		p2[0] = (qfprom_cdata[0] & MDM9607_S0_P2_MASK) >> MDM9607_S0_P2_SHIFT;
> -		p2[1] = (qfprom_cdata[0] & MDM9607_S1_P2_MASK) >> MDM9607_S1_P2_SHIFT;
> -		p2[2] = (qfprom_cdata[1] & MDM9607_S2_P2_MASK) >> MDM9607_S2_P2_SHIFT;
> -		p2[3] = (qfprom_cdata[1] & MDM9607_S3_P2_MASK) >> MDM9607_S3_P2_SHIFT;
> -		p2[4] = (qfprom_cdata[2] & MDM9607_S4_P2_MASK) >> MDM9607_S4_P2_SHIFT;
> -		for (i = 0; i < priv->num_sensors; i++)
> -			p2[i] = ((base + p2[i]) << 2);
> -		fallthrough;
> -	case ONE_PT_CALIB2:
> -		base = (qfprom_cdata[0] & MDM9607_BASE0_MASK);
> -		p1[0] = (qfprom_cdata[0] & MDM9607_S0_P1_MASK) >> MDM9607_S0_P1_SHIFT;
> -		p1[1] = (qfprom_cdata[0] & MDM9607_S1_P1_MASK) >> MDM9607_S1_P1_SHIFT;
> -		p1[2] = (qfprom_cdata[1] & MDM9607_S2_P1_MASK) >> MDM9607_S2_P1_SHIFT;
> -		p1[3] = (qfprom_cdata[1] & MDM9607_S3_P1_MASK) >> MDM9607_S3_P1_SHIFT;
> -		p1[4] = (qfprom_cdata[2] & MDM9607_S4_P1_MASK) >> MDM9607_S4_P1_SHIFT;
> -		for (i = 0; i < priv->num_sensors; i++)
> -			p1[i] = ((base + p1[i]) << 2);
> -		break;
> -	default:
> -		for (i = 0; i < priv->num_sensors; i++) {
> -			p1[i] = 500;
> -			p2[i] = 780;
> -		}
> -		break;
> -	}
> -
> -	compute_intercept_slope(priv, p1, p2, mode);
> -	kfree(qfprom_cdata);
> -
> -	return 0;
> -}
> -
>  /* v0.1: 8916, 8939, 8974, 9607 */
>  
>  static struct tsens_features tsens_v0_1_feat = {
> @@ -509,15 +422,9 @@ struct tsens_plat_data data_8974 = {
>  	.fields	= tsens_v0_1_regfields,
>  };
>  
> -static const struct tsens_ops ops_9607 = {
> -	.init		= init_common,
> -	.calibrate	= calibrate_9607,
> -	.get_temp	= get_temp_common,
> -};
> -
>  struct tsens_plat_data data_9607 = {
>  	.num_sensors	= 5,
> -	.ops		= &ops_9607,
> +	.ops		= &ops_v0_1,
>  	.feat		= &tsens_v0_1_feat,
>  	.fields	= tsens_v0_1_regfields,
>  };
