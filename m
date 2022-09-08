Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B1C5B2801
	for <lists+linux-pm@lfdr.de>; Thu,  8 Sep 2022 22:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiIHU5r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Sep 2022 16:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIHU5q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Sep 2022 16:57:46 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91FDF10CF
        for <linux-pm@vger.kernel.org>; Thu,  8 Sep 2022 13:57:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u18so17507322lfo.8
        for <linux-pm@vger.kernel.org>; Thu, 08 Sep 2022 13:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=bDtEAaGq2iBf5yKh0rc6ZMk1xs6MJoWbJS5M17VY8fw=;
        b=jFPUTiNrslkoB59czkZHmJSjd9yqM0gJjjcm9VYqufpAO/kryAbRwLXSL4wmhVYlPZ
         ClefxYIZIpXiDf0gu+A6dmkWnZaOofmD8eTA/Vc2B4t0ZUTIcAIuhU5Hj9jyyZBiSOzw
         sOM8k7EKTuEixJaV74b5KefVR4RE+CNkubT8ZcWd/93/HjfMBtE5ps8BdWYb57wdqwPm
         JUh12NSTzqhXbpc0TCAkRphfW7/VJ9Et4R7cHpGJSxFcRBDEl0rD0CuFj9m3w/132+Nh
         /src0chM5S+pGEl1U00YspjuYiwntH7x1sQxt1E67COGM+gAH0A1H7qMjSxsdfkq6m4X
         c9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bDtEAaGq2iBf5yKh0rc6ZMk1xs6MJoWbJS5M17VY8fw=;
        b=vvWWaT4DtLtxqDIdD16UhITAhSizbM3Sa70Eo5Ug4aE+MOhv2Tr9QuUZUm56FOGa06
         IZNXab/eKjv1pyRCqA+TeV+Wt/aO8CvxAyBTFS0B5UTMCBfx+kUsUvnnSlqft51ptisn
         tpl7exqYwAb8oXEf0dTiuNXnsQr1l6W+aIzCXsF0X7M2Dt3CvqPprGm/j0EOMMj3VJdP
         X8rmfBG4XdM5RnuIqt5GPtxuOU96oms/rwUXyS1ONoL9tmh8zTXBjhNU5Lsme7kYsWHM
         3yjv/ndAmMPZij/TwfykmabOCf1y7Z0SpJGuSiH+xfSsLTHUhYnXp11mkiNWjzTVYnUj
         xgIw==
X-Gm-Message-State: ACgBeo2KDzvnn6Fa600AObiJet8iHctiyTacczIDdR5JXIYqTGGxoMin
        kp59laGhOzOSAGEONICS4NgL1w==
X-Google-Smtp-Source: AA6agR50bDBRTSgXh4T107H5OSWdITXKPounRYbBEgy7WIzNFf4UxwY04eX35+hwN7hnXQQK5CdMTg==
X-Received: by 2002:ac2:5a09:0:b0:495:79c7:f2f9 with SMTP id q9-20020ac25a09000000b0049579c7f2f9mr3121980lfn.422.1662670663103;
        Thu, 08 Sep 2022 13:57:43 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u29-20020ac25bdd000000b00492c549f845sm3176383lfn.1.2022.09.08.13.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 13:57:42 -0700 (PDT)
Message-ID: <e5c7b34e-2a1a-840a-7f3f-652d8027fa4d@linaro.org>
Date:   Thu, 8 Sep 2022 23:57:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 3/3] thermal: qcom: tsens: Add data for MSM8909
Content-Language: en-GB
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
References: <20220627131415.2868938-1-stephan.gerhold@kernkonzept.com>
 <20220627131415.2868938-4-stephan.gerhold@kernkonzept.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220627131415.2868938-4-stephan.gerhold@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/06/2022 16:14, Stephan Gerhold wrote:
> The MSM8909 SoC has 5 thermal sensors in a TSENS v0.1 block similar to
> MSM8916, except that the bit offsets in the qfprom were changed.
> Also, some fixed correction factors are needed as workaround because the
> factory calibration apparently was not reliable enough.
> 
> Add the defines and calibration function for MSM8909 in the existing
> tsens-v0_1.c driver to make the thermal sensors work on MSM8909.
> The changes are derived from the original msm-3.18 kernel [1] from
> Qualcomm but cleaned up and adapted to the driver in mainline.
> 
> [1]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.UM.7.7.c26-08600-8x09.0/drivers/thermal/msm-tsens.c
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
>   drivers/thermal/qcom/tsens-v0_1.c | 119 +++++++++++++++++++++++++++++-
>   drivers/thermal/qcom/tsens.c      |   3 +
>   drivers/thermal/qcom/tsens.h      |   2 +-
>   3 files changed, 122 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index f136cb350238..e17c4f9d9aa5 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -15,6 +15,48 @@
>   #define TM_Sn_STATUS_OFF			0x0030
>   #define TM_TRDY_OFF				0x005c
>   
> +/* eeprom layout data for 8909 */
> +#define MSM8909_CAL_SEL_MASK	0x00070000
> +#define MSM8909_CAL_SEL_SHIFT	16
> +
> +#define MSM8909_BASE0_MASK	0x000000ff
> +#define MSM8909_BASE1_MASK	0x0000ff00
> +#define MSM8909_BASE0_SHIFT	0
> +#define MSM8909_BASE1_SHIFT	8
> +
> +#define MSM8909_S0_P1_MASK	0x0000003f
> +#define MSM8909_S1_P1_MASK	0x0003f000
> +#define MSM8909_S2_P1_MASK	0x3f000000
> +#define MSM8909_S3_P1_MASK	0x000003f0
> +#define MSM8909_S4_P1_MASK	0x003f0000
> +
> +#define MSM8909_S0_P2_MASK	0x00000fc0
> +#define MSM8909_S1_P2_MASK	0x00fc0000
> +#define MSM8909_S2_P2_MASK_0_1	0xc0000000
> +#define MSM8909_S2_P2_MASK_2_5	0x0000000f
> +#define MSM8909_S3_P2_MASK	0x0000fc00
> +#define MSM8909_S4_P2_MASK	0x0fc00000
> +
> +#define MSM8909_S0_P1_SHIFT	0
> +#define MSM8909_S1_P1_SHIFT	12
> +#define MSM8909_S2_P1_SHIFT	24
> +#define MSM8909_S3_P1_SHIFT	4
> +#define MSM8909_S4_P1_SHIFT	16
> +
> +#define MSM8909_S0_P2_SHIFT	6
> +#define MSM8909_S1_P2_SHIFT	18
> +#define MSM8909_S2_P2_SHIFT_0_1	30
> +#define MSM8909_S2_P2_SHIFT_2_5	2
> +#define MSM8909_S3_P2_SHIFT	10
> +#define MSM8909_S4_P2_SHIFT	22
> +
> +#define MSM8909_D30_WA_S1	10
> +#define MSM8909_D30_WA_S3	9
> +#define MSM8909_D30_WA_S4	8
> +#define MSM8909_D120_WA_S1	6
> +#define MSM8909_D120_WA_S3	9
> +#define MSM8909_D120_WA_S4	10
> +
>   /* eeprom layout data for 8916 */
>   #define MSM8916_BASE0_MASK	0x0000007f
>   #define MSM8916_BASE1_MASK	0xfe000000
> @@ -223,6 +265,68 @@
>   #define MDM9607_CAL_SEL_MASK	0x00700000
>   #define MDM9607_CAL_SEL_SHIFT	20
>   
> +static int calibrate_8909(struct tsens_priv *priv)
> +{
> +	u32 *qfprom_cdata, *qfprom_csel;
> +	int base0, base1, mode, i;
> +	u32 p1[5], p2[5];
> +
> +	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
> +	if (IS_ERR(qfprom_cdata))
> +		return PTR_ERR(qfprom_cdata);
> +
> +	qfprom_csel = (u32 *)qfprom_read(priv->dev, "calib_sel");
> +	if (IS_ERR(qfprom_csel)) {
> +		kfree(qfprom_cdata);
> +		return PTR_ERR(qfprom_csel);
> +	}
> +
> +	mode = (qfprom_csel[0] & MSM8909_CAL_SEL_MASK) >> MSM8909_CAL_SEL_SHIFT;
> +	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
> +
> +	switch (mode) {
> +	case TWO_PT_CALIB:
> +		base1 = (qfprom_csel[0] & MSM8909_BASE1_MASK) >> MSM8909_BASE1_SHIFT;
> +		p2[0] = (qfprom_cdata[0] & MSM8909_S0_P2_MASK) >> MSM8909_S0_P2_SHIFT;
> +		p2[1] = (qfprom_cdata[0] & MSM8909_S1_P2_MASK) >> MSM8909_S1_P2_SHIFT;
> +		p2[2] = (qfprom_cdata[0] & MSM8909_S2_P2_MASK_0_1) >> MSM8909_S2_P2_SHIFT_0_1;
> +		p2[2] |= (qfprom_cdata[1] & MSM8909_S2_P2_MASK_2_5) << MSM8909_S2_P2_SHIFT_2_5;
> +		p2[3] = (qfprom_cdata[1] & MSM8909_S3_P2_MASK) >> MSM8909_S3_P2_SHIFT;
> +		p2[4] = (qfprom_cdata[1] & MSM8909_S4_P2_MASK) >> MSM8909_S4_P2_SHIFT;

Please use nvmem_cell_read_* to read these values. This would allow you 
to push all the possible si_pi definitions into the DT and use mode to 
switch between them. And mode can be read using the nvmem_cell_read_* too.

> +		for (i = 0; i < priv->num_sensors; i++)
> +			p2[i] = ((base1 + p2[i]) << 2);
> +		p2[1] -= MSM8909_D120_WA_S1;
> +		p2[3] -= MSM8909_D120_WA_S3;
> +		p2[4] -= MSM8909_D120_WA_S4;
> +		fallthrough;
> +	case ONE_PT_CALIB2:
> +		base0 = (qfprom_csel[0] & MSM8909_BASE0_MASK) >> MSM8909_BASE0_SHIFT;
> +		p1[0] = (qfprom_cdata[0] & MSM8909_S0_P1_MASK) >> MSM8909_S0_P1_SHIFT;
> +		p1[1] = (qfprom_cdata[0] & MSM8909_S1_P1_MASK) >> MSM8909_S1_P1_SHIFT;
> +		p1[2] = (qfprom_cdata[0] & MSM8909_S2_P1_MASK) >> MSM8909_S2_P1_SHIFT;
> +		p1[3] = (qfprom_cdata[1] & MSM8909_S3_P1_MASK) >> MSM8909_S3_P1_SHIFT;
> +		p1[4] = (qfprom_cdata[1] & MSM8909_S4_P1_MASK) >> MSM8909_S4_P1_SHIFT;
> +		for (i = 0; i < priv->num_sensors; i++)
> +			p1[i] = (((base0) + p1[i]) << 2);
> +		p1[1] -= MSM8909_D30_WA_S1;
> +		p1[3] -= MSM8909_D30_WA_S3;
> +		p1[4] -= MSM8909_D30_WA_S4;
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
> +	kfree(qfprom_csel);
> +
> +	return 0;
> +}
> +
>   static int calibrate_8916(struct tsens_priv *priv)
>   {
>   	int base0 = 0, base1 = 0, i;
> @@ -534,7 +638,7 @@ static int calibrate_9607(struct tsens_priv *priv)
>   	return 0;
>   }
>   
> -/* v0.1: 8916, 8939, 8974, 9607 */
> +/* v0.1: 8909, 8916, 8939, 8974, 9607 */
>   
>   static struct tsens_features tsens_v0_1_feat = {
>   	.ver_major	= VER_0_1,
> @@ -580,6 +684,19 @@ static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
>   	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>   };
>   
> +static const struct tsens_ops ops_8909 = {
> +	.init		= init_common,
> +	.calibrate	= calibrate_8909,
> +	.get_temp	= get_temp_common,
> +};
> +
> +struct tsens_plat_data data_8909 = {
> +	.num_sensors	= 5,
> +	.ops		= &ops_8909,
> +	.feat		= &tsens_v0_1_feat,
> +	.fields		= tsens_v0_1_regfields,
> +};
> +
>   static const struct tsens_ops ops_8916 = {
>   	.init		= init_common,
>   	.calibrate	= calibrate_8916,
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 7963ee33bf75..cb7bbaa72d89 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -973,6 +973,9 @@ static const struct of_device_id tsens_table[] = {
>   	}, {
>   		.compatible = "qcom,mdm9607-tsens",
>   		.data = &data_9607,
> +	}, {
> +		.compatible = "qcom,msm8909-tsens",
> +		.data = &data_8909,
>   	}, {
>   		.compatible = "qcom,msm8916-tsens",
>   		.data = &data_8916,
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 1471a2c00f15..752d4718f26e 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -587,7 +587,7 @@ int get_temp_common(const struct tsens_sensor *s, int *temp);
>   extern struct tsens_plat_data data_8960;
>   
>   /* TSENS v0.1 targets */
> -extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
> +extern struct tsens_plat_data data_8909, data_8916, data_8939, data_8974, data_9607;
>   
>   /* TSENS v1 targets */
>   extern struct tsens_plat_data data_tsens_v1, data_8976;

-- 
With best wishes
Dmitry

