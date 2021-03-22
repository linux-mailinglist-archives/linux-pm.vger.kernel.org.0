Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AA834363A
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 02:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCVB3S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Mar 2021 21:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhCVB3R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Mar 2021 21:29:17 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE51C061574
        for <linux-pm@vger.kernel.org>; Sun, 21 Mar 2021 18:29:17 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id f12so11266608qtq.4
        for <linux-pm@vger.kernel.org>; Sun, 21 Mar 2021 18:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QCkQMrliopGIInkjcG1Hf8SDS+wFzIb56yNTm62AVEM=;
        b=zjTEsSL0tEU2BNXpZNm0qrrjHdEaJ1fv9ku26EGn6PxVQMADbt3bnDDBBcUsgy0x7r
         MqwgLD069bfWdAxpPHLw53bufpTwtv/dxlgu3cL/rKUEdcIbO+GPJma20n0bAIqbDC3M
         wIhEVP4TdA1OKpMLSdHLLqgJZGNVoP8z3eHUdg/Fnk7ll+vgfm6KxPLtmCPoDkq3WwSJ
         huX2AVu5KP6ahLrH1CgdR8Fu+dEuMrtxTJPJ2GzewnrSl2Bd9aYIKn+27R3Va8YfbSR+
         gPcL0kvjY5rB7IssSCEkkwqo2Yen6fzZ6jImzPLrt60Lkn2nUkfeNHroEdN9LshNqZ2A
         tdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QCkQMrliopGIInkjcG1Hf8SDS+wFzIb56yNTm62AVEM=;
        b=TA47UCXQ83Nd0Kbo106h2GITa5BB2oG6juG6kEulrtmcy2lMgdUsCoE4FWPjwnGbyS
         SFfvNrX7SNcKPkKvZsP9/82SQYGw+ZVr76JvED7KFauR+hGtb4WzlUShzNcvWRYYMlMf
         M5vqWPXjEtL48vQtActKfKg+1AFrg239n9PkSKqlZ7UkeZ5m+NViHBEpEGCu0nLJ/v8h
         Bj+44WmWXn6/uwZVsyy6+RFtzwSw5/iPpbNZDiY7ZtpQe0cjdGMRkcKS44aKI34trj+F
         mpU/n0S11qurHBWPVTFZ/d8X4npxb9mVnwhg+tM1k4lr6igmlQMzxDMUt2WW+awRdMPN
         DK6Q==
X-Gm-Message-State: AOAM533vkS1myCVR3sBL4Yeej0RRmwmBP3EaiflTarVHSgqQR5TgvqVI
        lxbKqMrgkWJKQly/vRwDYwPjBQ==
X-Google-Smtp-Source: ABdhPJza01BEBUaus7Kl6hzjXWdgTOFoq2A388SzYCjK3nVMqNJrUWc4Khf4xTU3VR9iLezecYUgtA==
X-Received: by 2002:aed:31e4:: with SMTP id 91mr7943207qth.9.1616376556560;
        Sun, 21 Mar 2021 18:29:16 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id a2sm8261304qtj.76.2021.03.21.18.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Mar 2021 18:29:15 -0700 (PDT)
Subject: Re: [RESEND PATCH v4 2/2] thermal: qcom: tsens-v0_1: Add support for
 MDM9607
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210319220802.198215-1-konrad.dybcio@somainline.org>
 <20210319220802.198215-2-konrad.dybcio@somainline.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <2ddf8635-3fb8-dba7-1f76-552755d41beb@linaro.org>
Date:   Sun, 21 Mar 2021 21:29:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210319220802.198215-2-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/19/21 6:08 PM, Konrad Dybcio wrote:
> MDM9607 TSENS IP is very similar to the one of MSM8916, with
> minor adjustments to various tuning values.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Acked-by: Thara Gopinath <thara.gopinath@linaro.org>

Warm Regards
Thara
> ---
> v4: Remove unneeded braces and newline
> 
>   drivers/thermal/qcom/tsens-v0_1.c | 98 ++++++++++++++++++++++++++++++-
>   drivers/thermal/qcom/tsens.c      |  3 +
>   drivers/thermal/qcom/tsens.h      |  2 +-
>   3 files changed, 101 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 4ffa2e2c0145..f136cb350238 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -190,6 +190,39 @@
>   
>   #define BIT_APPEND		0x3
>   
> +/* eeprom layout data for mdm9607 */
> +#define MDM9607_BASE0_MASK	0x000000ff
> +#define MDM9607_BASE1_MASK	0x000ff000
> +#define MDM9607_BASE0_SHIFT	0
> +#define MDM9607_BASE1_SHIFT	12
> +
> +#define MDM9607_S0_P1_MASK	0x00003f00
> +#define MDM9607_S1_P1_MASK	0x03f00000
> +#define MDM9607_S2_P1_MASK	0x0000003f
> +#define MDM9607_S3_P1_MASK	0x0003f000
> +#define MDM9607_S4_P1_MASK	0x0000003f
> +
> +#define MDM9607_S0_P2_MASK	0x000fc000
> +#define MDM9607_S1_P2_MASK	0xfc000000
> +#define MDM9607_S2_P2_MASK	0x00000fc0
> +#define MDM9607_S3_P2_MASK	0x00fc0000
> +#define MDM9607_S4_P2_MASK	0x00000fc0
> +
> +#define MDM9607_S0_P1_SHIFT	8
> +#define MDM9607_S1_P1_SHIFT	20
> +#define MDM9607_S2_P1_SHIFT	0
> +#define MDM9607_S3_P1_SHIFT	12
> +#define MDM9607_S4_P1_SHIFT	0
> +
> +#define MDM9607_S0_P2_SHIFT	14
> +#define MDM9607_S1_P2_SHIFT	26
> +#define MDM9607_S2_P2_SHIFT	6
> +#define MDM9607_S3_P2_SHIFT	18
> +#define MDM9607_S4_P2_SHIFT	6
> +
> +#define MDM9607_CAL_SEL_MASK	0x00700000
> +#define MDM9607_CAL_SEL_SHIFT	20
> +
>   static int calibrate_8916(struct tsens_priv *priv)
>   {
>   	int base0 = 0, base1 = 0, i;
> @@ -452,7 +485,56 @@ static int calibrate_8974(struct tsens_priv *priv)
>   	return 0;
>   }
>   
> -/* v0.1: 8916, 8939, 8974 */
> +static int calibrate_9607(struct tsens_priv *priv)
> +{
> +	int base, i;
> +	u32 p1[5], p2[5];
> +	int mode = 0;
> +	u32 *qfprom_cdata;
> +
> +	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
> +	if (IS_ERR(qfprom_cdata))
> +		return PTR_ERR(qfprom_cdata);
> +
> +	mode = (qfprom_cdata[2] & MDM9607_CAL_SEL_MASK) >> MDM9607_CAL_SEL_SHIFT;
> +	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
> +
> +	switch (mode) {
> +	case TWO_PT_CALIB:
> +		base = (qfprom_cdata[2] & MDM9607_BASE1_MASK) >> MDM9607_BASE1_SHIFT;
> +		p2[0] = (qfprom_cdata[0] & MDM9607_S0_P2_MASK) >> MDM9607_S0_P2_SHIFT;
> +		p2[1] = (qfprom_cdata[0] & MDM9607_S1_P2_MASK) >> MDM9607_S1_P2_SHIFT;
> +		p2[2] = (qfprom_cdata[1] & MDM9607_S2_P2_MASK) >> MDM9607_S2_P2_SHIFT;
> +		p2[3] = (qfprom_cdata[1] & MDM9607_S3_P2_MASK) >> MDM9607_S3_P2_SHIFT;
> +		p2[4] = (qfprom_cdata[2] & MDM9607_S4_P2_MASK) >> MDM9607_S4_P2_SHIFT;
> +		for (i = 0; i < priv->num_sensors; i++)
> +			p2[i] = ((base + p2[i]) << 2);
> +		fallthrough;
> +	case ONE_PT_CALIB2:
> +		base = (qfprom_cdata[0] & MDM9607_BASE0_MASK);
> +		p1[0] = (qfprom_cdata[0] & MDM9607_S0_P1_MASK) >> MDM9607_S0_P1_SHIFT;
> +		p1[1] = (qfprom_cdata[0] & MDM9607_S1_P1_MASK) >> MDM9607_S1_P1_SHIFT;
> +		p1[2] = (qfprom_cdata[1] & MDM9607_S2_P1_MASK) >> MDM9607_S2_P1_SHIFT;
> +		p1[3] = (qfprom_cdata[1] & MDM9607_S3_P1_MASK) >> MDM9607_S3_P1_SHIFT;
> +		p1[4] = (qfprom_cdata[2] & MDM9607_S4_P1_MASK) >> MDM9607_S4_P1_SHIFT;
> +		for (i = 0; i < priv->num_sensors; i++)
> +			p1[i] = ((base + p1[i]) << 2);
> +		break;
> +	default:
> +		for (i = 0; i < priv->num_sensors; i++) {
> +			p1[i] = 500;
> +			p2[i] = 780;
> +		}
> +		break;
> +	}
> +
> +	compute_intercept_slope(priv, p1, p2, mode);
> +	kfree(qfprom_cdata);
> +
> +	return 0;
> +}
> +
> +/* v0.1: 8916, 8939, 8974, 9607 */
>   
>   static struct tsens_features tsens_v0_1_feat = {
>   	.ver_major	= VER_0_1,
> @@ -540,3 +622,17 @@ struct tsens_plat_data data_8974 = {
>   	.feat		= &tsens_v0_1_feat,
>   	.fields	= tsens_v0_1_regfields,
>   };
> +
> +static const struct tsens_ops ops_9607 = {
> +	.init		= init_common,
> +	.calibrate	= calibrate_9607,
> +	.get_temp	= get_temp_common,
> +};
> +
> +struct tsens_plat_data data_9607 = {
> +	.num_sensors	= 5,
> +	.ops		= &ops_9607,
> +	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 4 },
> +	.feat		= &tsens_v0_1_feat,
> +	.fields	= tsens_v0_1_regfields,
> +};
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index d8ce3a687b80..51c36b9e8e69 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -895,6 +895,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
>   
>   static const struct of_device_id tsens_table[] = {
>   	{
> +		.compatible = "qcom,mdm9607-tsens",
> +		.data = &data_9607,
> +	}, {
>   		.compatible = "qcom,msm8916-tsens",
>   		.data = &data_8916,
>   	}, {
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index f40b625f897e..cba64c33b4f9 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -585,7 +585,7 @@ int get_temp_common(const struct tsens_sensor *s, int *temp);
>   extern struct tsens_plat_data data_8960;
>   
>   /* TSENS v0.1 targets */
> -extern struct tsens_plat_data data_8916, data_8939, data_8974;
> +extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
>   
>   /* TSENS v1 targets */
>   extern struct tsens_plat_data data_tsens_v1, data_8976;
> 


