Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0184651EB8
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 11:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbiLTKYV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 05:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiLTKYU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 05:24:20 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DD19FC2
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:24:19 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a19so12011721ljk.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2nWWYHSGV4/CK/gZwuFr3aoUab3hRgM8eOATcF9saOQ=;
        b=ZUvVIReECB03oLuPcI8hmKz24g5x74fKb3wW6gaJS+V6tm4eY3REJdbiK1sLNzojpI
         33xKUSmkFO3SMkWjwjlqb4cBmKh/rwCnni2JmsSVTnTAdOWP8WMj+kUjICDlE33aaKxn
         5o7lWteG8X4Xny8ctrFftoeR9pTEQv6VpJuxplnzsin5j8YlWvayhbEUUPnhu3mnTEE4
         tLC6KD7CeE8h4UYDVtL4mdzibftgsDlh3RnEZ59ydKYUrCY9dAhk8pagDMaFqwoz/0jD
         zU0nLwOQeNAfCbX4Ttx513SFpuOIFBt0YqFoMu8xBnMS2lAWnK2X2PT6p7t5GTXksaKj
         foSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nWWYHSGV4/CK/gZwuFr3aoUab3hRgM8eOATcF9saOQ=;
        b=JDuPrQv0aSeLrRZCBUScZmZCcFYtLGexxA+OYG9NPBo8zc1tj8bPh+HR2RtXoxfUUs
         8lNDra557B9d9OdDrzrGjPVpJ/c1NQfGQHKk5xyBvewzpJ+KbstSx8xRgQmxvg5ZVyCO
         1/3XTipyQKIaX2XljTOGsUanQHjPKDEs8vBgiVEhic1PvEEJvW89UT3hO8qM0MAm+BDG
         bxk/LI1KL3+cv9pDNAokNyAr9oliLfsTzrEpX34Ki/FG9QKQgYPh9gND39wxSLLdS3TG
         cnh72Rjyx2mYOB3hTSQWAHxrTwPx1p4c0QN5wGupvj9HI+vaOiZcgLVK0eLWS8E3FZMm
         /LaQ==
X-Gm-Message-State: ANoB5pmzRk5y4v5JMW01AQSqqYrAqM/uniKkB7YwYgywqBsAsZiLbiBf
        9lSPiz/5Z2A26svO5yjulklegg==
X-Google-Smtp-Source: AA0mqf6ouq14u4Q/aFuCYrqlFcYyotNruJNqQ/B9ddJ9kCLEEHBV0FCIl7wm5DZxEfMRfS3d0QfL6w==
X-Received: by 2002:a2e:880a:0:b0:27b:4a90:2b01 with SMTP id x10-20020a2e880a000000b0027b4a902b01mr9115666ljh.19.1671531857379;
        Tue, 20 Dec 2022 02:24:17 -0800 (PST)
Received: from [192.168.1.101] (abxh212.neoplus.adsl.tpnet.pl. [83.9.1.212])
        by smtp.gmail.com with ESMTPSA id y20-20020a05651c107400b002770a7e320esm977981ljm.81.2022.12.20.02.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:24:16 -0800 (PST)
Message-ID: <78a29328-a53b-7a09-c228-b7c373683ca4@linaro.org>
Date:   Tue, 20 Dec 2022 11:24:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 10/15] thermal/drivers/tsens: Drop single-cell code for
 msm8976/msm8956
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
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
 <20221220024721.947147-11-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221220024721.947147-11-dmitry.baryshkov@linaro.org>
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
> There is no dtsi file for msm8976 in the kernel sources.
This is not true :/

But it has just been merged, if we get there fast, we can get
this patch going *and* convert the node to use fuses..
Unless breaking a platform that's only in linux-next would be
an issue.. Maybe we could prettyplease ask Bjorn to send a
-fixes pull with a "remove tsens node from 8976" commit?
Not sure if it's too late or not...


Konrad
Drop the
> compatibility with unofficial dtsi and remove support for handling the
> single-cell calibration data on msm8976.
> 
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-v1.c | 126 +-------------------------------
>  1 file changed, 2 insertions(+), 124 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index 89955522041d..9151c1043a11 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -21,63 +21,6 @@
>  #define TM_HIGH_LOW_INT_STATUS_OFF		0x0088
>  #define TM_HIGH_LOW_Sn_INT_THRESHOLD_OFF	0x0090
>  
> -/* eeprom layout data for msm8956/76 (v1) */
> -#define MSM8976_BASE0_MASK	0xff
> -#define MSM8976_BASE1_MASK	0xff
> -#define MSM8976_BASE1_SHIFT	8
> -
> -#define MSM8976_S0_P1_MASK	0x3f00
> -#define MSM8976_S1_P1_MASK	0x3f00000
> -#define MSM8976_S2_P1_MASK	0x3f
> -#define MSM8976_S3_P1_MASK	0x3f000
> -#define MSM8976_S4_P1_MASK	0x3f00
> -#define MSM8976_S5_P1_MASK	0x3f00000
> -#define MSM8976_S6_P1_MASK	0x3f
> -#define MSM8976_S7_P1_MASK	0x3f000
> -#define MSM8976_S8_P1_MASK	0x1f8
> -#define MSM8976_S9_P1_MASK	0x1f8000
> -#define MSM8976_S10_P1_MASK	0xf8000000
> -#define MSM8976_S10_P1_MASK_1	0x1
> -
> -#define MSM8976_S0_P2_MASK	0xfc000
> -#define MSM8976_S1_P2_MASK	0xfc000000
> -#define MSM8976_S2_P2_MASK	0xfc0
> -#define MSM8976_S3_P2_MASK	0xfc0000
> -#define MSM8976_S4_P2_MASK	0xfc000
> -#define MSM8976_S5_P2_MASK	0xfc000000
> -#define MSM8976_S6_P2_MASK	0xfc0
> -#define MSM8976_S7_P2_MASK	0xfc0000
> -#define MSM8976_S8_P2_MASK	0x7e00
> -#define MSM8976_S9_P2_MASK	0x7e00000
> -#define MSM8976_S10_P2_MASK	0x7e
> -
> -#define MSM8976_S0_P1_SHIFT	8
> -#define MSM8976_S1_P1_SHIFT	20
> -#define MSM8976_S2_P1_SHIFT	0
> -#define MSM8976_S3_P1_SHIFT	12
> -#define MSM8976_S4_P1_SHIFT	8
> -#define MSM8976_S5_P1_SHIFT	20
> -#define MSM8976_S6_P1_SHIFT	0
> -#define MSM8976_S7_P1_SHIFT	12
> -#define MSM8976_S8_P1_SHIFT	3
> -#define MSM8976_S9_P1_SHIFT	15
> -#define MSM8976_S10_P1_SHIFT	27
> -#define MSM8976_S10_P1_SHIFT_1	0
> -
> -#define MSM8976_S0_P2_SHIFT	14
> -#define MSM8976_S1_P2_SHIFT	26
> -#define MSM8976_S2_P2_SHIFT	6
> -#define MSM8976_S3_P2_SHIFT	18
> -#define MSM8976_S4_P2_SHIFT	14
> -#define MSM8976_S5_P2_SHIFT	26
> -#define MSM8976_S6_P2_SHIFT	6
> -#define MSM8976_S7_P2_SHIFT	18
> -#define MSM8976_S8_P2_SHIFT	9
> -#define MSM8976_S9_P2_SHIFT	21
> -#define MSM8976_S10_P2_SHIFT	1
> -
> -#define MSM8976_CAL_SEL_MASK	0x3
> -
>  /* eeprom layout data for qcs404/405 (v1) */
>  #define BASE0_MASK	0x000007f8
>  #define BASE1_MASK	0x0007f800
> @@ -207,71 +150,6 @@ static int calibrate_v1(struct tsens_priv *priv)
>  	return 0;
>  }
>  
> -static int calibrate_8976(struct tsens_priv *priv)
> -{
> -	int base0 = 0, base1 = 0, i;
> -	u32 p1[11], p2[11];
> -	int mode = 0, tmp = 0;
> -	u32 *qfprom_cdata;
> -
> -	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
> -	if (IS_ERR(qfprom_cdata))
> -		return PTR_ERR(qfprom_cdata);
> -
> -	mode = (qfprom_cdata[4] & MSM8976_CAL_SEL_MASK);
> -	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
> -
> -	switch (mode) {
> -	case TWO_PT_CALIB:
> -		base1 = (qfprom_cdata[2] & MSM8976_BASE1_MASK) >> MSM8976_BASE1_SHIFT;
> -		p2[0] = (qfprom_cdata[0] & MSM8976_S0_P2_MASK) >> MSM8976_S0_P2_SHIFT;
> -		p2[1] = (qfprom_cdata[0] & MSM8976_S1_P2_MASK) >> MSM8976_S1_P2_SHIFT;
> -		p2[2] = (qfprom_cdata[1] & MSM8976_S2_P2_MASK) >> MSM8976_S2_P2_SHIFT;
> -		p2[3] = (qfprom_cdata[1] & MSM8976_S3_P2_MASK) >> MSM8976_S3_P2_SHIFT;
> -		p2[4] = (qfprom_cdata[2] & MSM8976_S4_P2_MASK) >> MSM8976_S4_P2_SHIFT;
> -		p2[5] = (qfprom_cdata[2] & MSM8976_S5_P2_MASK) >> MSM8976_S5_P2_SHIFT;
> -		p2[6] = (qfprom_cdata[3] & MSM8976_S6_P2_MASK) >> MSM8976_S6_P2_SHIFT;
> -		p2[7] = (qfprom_cdata[3] & MSM8976_S7_P2_MASK) >> MSM8976_S7_P2_SHIFT;
> -		p2[8] = (qfprom_cdata[4] & MSM8976_S8_P2_MASK) >> MSM8976_S8_P2_SHIFT;
> -		p2[9] = (qfprom_cdata[4] & MSM8976_S9_P2_MASK) >> MSM8976_S9_P2_SHIFT;
> -		p2[10] = (qfprom_cdata[5] & MSM8976_S10_P2_MASK) >> MSM8976_S10_P2_SHIFT;
> -
> -		for (i = 0; i < priv->num_sensors; i++)
> -			p2[i] = ((base1 + p2[i]) << 2);
> -		fallthrough;
> -	case ONE_PT_CALIB2:
> -		base0 = qfprom_cdata[0] & MSM8976_BASE0_MASK;
> -		p1[0] = (qfprom_cdata[0] & MSM8976_S0_P1_MASK) >> MSM8976_S0_P1_SHIFT;
> -		p1[1] = (qfprom_cdata[0] & MSM8976_S1_P1_MASK) >> MSM8976_S1_P1_SHIFT;
> -		p1[2] = (qfprom_cdata[1] & MSM8976_S2_P1_MASK) >> MSM8976_S2_P1_SHIFT;
> -		p1[3] = (qfprom_cdata[1] & MSM8976_S3_P1_MASK) >> MSM8976_S3_P1_SHIFT;
> -		p1[4] = (qfprom_cdata[2] & MSM8976_S4_P1_MASK) >> MSM8976_S4_P1_SHIFT;
> -		p1[5] = (qfprom_cdata[2] & MSM8976_S5_P1_MASK) >> MSM8976_S5_P1_SHIFT;
> -		p1[6] = (qfprom_cdata[3] & MSM8976_S6_P1_MASK) >> MSM8976_S6_P1_SHIFT;
> -		p1[7] = (qfprom_cdata[3] & MSM8976_S7_P1_MASK) >> MSM8976_S7_P1_SHIFT;
> -		p1[8] = (qfprom_cdata[4] & MSM8976_S8_P1_MASK) >> MSM8976_S8_P1_SHIFT;
> -		p1[9] = (qfprom_cdata[4] & MSM8976_S9_P1_MASK) >> MSM8976_S9_P1_SHIFT;
> -		p1[10] = (qfprom_cdata[4] & MSM8976_S10_P1_MASK) >> MSM8976_S10_P1_SHIFT;
> -		tmp = (qfprom_cdata[5] & MSM8976_S10_P1_MASK_1) << MSM8976_S10_P1_SHIFT_1;
> -		p1[10] |= tmp;
> -
> -		for (i = 0; i < priv->num_sensors; i++)
> -			p1[i] = (((base0) + p1[i]) << 2);
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
>  /* v1.x: msm8956,8976,qcs404,405 */
>  
>  static struct tsens_features tsens_v1_feat = {
> @@ -370,7 +248,7 @@ struct tsens_plat_data data_tsens_v1 = {
>  
>  static const struct tsens_ops ops_8956 = {
>  	.init		= init_8956,
> -	.calibrate	= calibrate_8976,
> +	.calibrate	= tsens_calibrate_common,
>  	.get_temp	= get_temp_tsens_valid,
>  };
>  
> @@ -383,7 +261,7 @@ struct tsens_plat_data data_8956 = {
>  
>  static const struct tsens_ops ops_8976 = {
>  	.init		= init_common,
> -	.calibrate	= calibrate_8976,
> +	.calibrate	= tsens_calibrate_common,
>  	.get_temp	= get_temp_tsens_valid,
>  };
>  
