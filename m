Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A89241D88A
	for <lists+linux-pm@lfdr.de>; Thu, 30 Sep 2021 13:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350371AbhI3LUo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Sep 2021 07:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350266AbhI3LUj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Sep 2021 07:20:39 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887E9C06176C
        for <linux-pm@vger.kernel.org>; Thu, 30 Sep 2021 04:18:56 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id n6so3323124qvp.7
        for <linux-pm@vger.kernel.org>; Thu, 30 Sep 2021 04:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w3gLhNCF4ryp2DY3tzm+OjeL9I8VrLLU0Pj90xlnH10=;
        b=EDSJuP73fFtNL8g9tRkyAftI9lCLWEDsNZswn0UnEdsZPT2/7A17Q+mcKFClWaZnmB
         91S6r4Psx7W8sp89HNWv+lzKb066Z9R094IDwV8AJrJ+f9XVh0CClId3RGm+hyoSTw9u
         IcsTnKwjWMQR4xKV+A7Kva+4sTtlOwbD1TJNlRZ4srSYDkCCch6evg0XBK+RDHrqyvXB
         l9VNWTgm8f6l1T9QUEJ/AxvkKgBSMJjqHOce3tzAmT4+zbJf4t9JxvQj0PjnI46JI/fE
         J+jNylNelHJw2FZmdl4r5SoSMq4LeLZOqrD8sWqvdlIhhblSbbCAraXmGzQvplxhX2iH
         WtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w3gLhNCF4ryp2DY3tzm+OjeL9I8VrLLU0Pj90xlnH10=;
        b=3w/xWJ2XuqFc7oGG0naYk/RiwEB/IbKoL3H6HtBzqImoQ8Iop9Qjv/dWFePLTntX3v
         3RBqKmY71Zt7Wc2ZOkVk9u/oxeGWfW1omBPYAQn5y6O7YrDSlsKxoAn9wuSj0Fit6VCs
         3BzSq/S7YGy1szzJnTDVAa49USfw3MHQJf0F43JRho1UxBlh9WNdEWmttuISQ4mDWYwX
         VXJmZnhm2l4V2A2yUWiUuN2n24CJD1M9omRTEwKsrvNOBKShXVJuQDl1y5r2cE0FHz9G
         MWZVHO+gD+poq27C8Dd20Q2npa7AWy9ElRH037Trj+VB4cvdq8ijVMIlrQIH/y1Fu4H+
         pPog==
X-Gm-Message-State: AOAM533vgmpdjhMggH+SZ5cXohoD+8uOd0JgtEF1MQgsOxpkSyMkEQTB
        XZ7xlv2n6hHQnUK2Q4Pv80TRcg==
X-Google-Smtp-Source: ABdhPJxw4nMzQaesU/yuM5O8g7CsxXbZdRPFA7M3cf6u3GQLBgM6VsjxYO3LAdR1VURopvZfodTOpw==
X-Received: by 2002:a05:6214:2e2:: with SMTP id h2mr666827qvu.13.1633000735565;
        Thu, 30 Sep 2021 04:18:55 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id h5sm1315826qke.1.2021.09.30.04.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 04:18:55 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] thermal: qcom: tsens-v1: Add support for MSM8992/4
 TSENS
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210904211508.317560-1-konrad.dybcio@somainline.org>
 <20210904211508.317560-2-konrad.dybcio@somainline.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <089bc912-6f49-c4e6-5667-d4bcb83fed84@linaro.org>
Date:   Thu, 30 Sep 2021 07:18:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210904211508.317560-2-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/4/21 5:15 PM, Konrad Dybcio wrote:
> MSM8994, despite being heavily based on MSM8974, uses the
> 1.2 version of TSENS. Also, 8994 being 8994, it has a custom
> way of calculating the slope.
> 
> MSM8992 in turn is a cut-down version of MSM8994 and uses
> the same TSENS hardware, albeit with a different set of sensors.
> 
> Also tested on 8976 (by a person who didn't want to be named)
> to make sure the 11->16 max_sensors changes didn't break anything.

Hi Konrad,

Thanks for the patch and sorry for the delay. A few nits below.

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Changes since v1:
> - Squash the few lines of 8992 here
> - Add some informative comments
> - Adjust the slope definition for non-anglosaxon-school-system people
> - Change base0 and base1 into ints, no need for them to be arrays
> - Default p[] to the magic value and only overwrite it if need be
> - Use %u for u32 values
> 
>   drivers/thermal/qcom/tsens-v1.c | 299 ++++++++++++++++++++++++++++++--
>   drivers/thermal/qcom/tsens.c    |   6 +
>   drivers/thermal/qcom/tsens.h    |   2 +-
>   3 files changed, 294 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index 573e261ccca7..c207a63f8e88 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -142,6 +142,99 @@
>   #define CAL_SEL_MASK	7
>   #define CAL_SEL_SHIFT	0
>   
> +/* eeprom layout data for 8994 */
> +#define MSM8994_BASE0_MASK	0x3ff
> +#define MSM8994_BASE1_MASK	0xffc00
> +#define MSM8994_BASE0_SHIFT	0
> +#define MSM8994_BASE1_SHIFT	10
> +
> +#define MSM8994_S0_MASK	0xf00000
> +#define MSM8994_S1_MASK	0xf000000
> +#define MSM8994_S2_MASK	0xf0000000
> +#define MSM8994_S3_MASK	0xf
> +#define MSM8994_S4_MASK	0xf0
> +#define MSM8994_S5_MASK	0xf00
> +#define MSM8994_S6_MASK	0xf000
> +#define MSM8994_S7_MASK	0xf0000
> +#define MSM8994_S8_MASK	0xf00000
> +#define MSM8994_S9_MASK	0xf000000
> +#define MSM8994_S10_MASK	0xf0000000
> +#define MSM8994_S11_MASK	0xf
> +#define MSM8994_S12_MASK	0xf0
> +#define MSM8994_S13_MASK	0xf00
> +#define MSM8994_S14_MASK	0xf000
> +#define MSM8994_S15_MASK	0xf0000
> +
> +#define MSM8994_S0_SHIFT	20
> +#define MSM8994_S1_SHIFT	24
> +#define MSM8994_S2_SHIFT	28
> +#define MSM8994_S3_SHIFT	0
> +#define MSM8994_S4_SHIFT	4
> +#define MSM8994_S5_SHIFT	8
> +#define MSM8994_S6_SHIFT	12
> +#define MSM8994_S7_SHIFT	16
> +#define MSM8994_S8_SHIFT	20
> +#define MSM8994_S9_SHIFT	24
> +#define MSM8994_S10_SHIFT	28
> +#define MSM8994_S11_SHIFT	0
> +#define MSM8994_S12_SHIFT	4
> +#define MSM8994_S13_SHIFT	8
> +#define MSM8994_S14_SHIFT	12
> +#define MSM8994_S15_SHIFT	16
> +
> +#define MSM8994_CAL_SEL_MASK	0x700000
> +#define MSM8994_CAL_SEL_SHIFT	20
> +
> +#define MSM8994_BASE0_REDUN_MASK	0x7fe00000
> +#define MSM8994_BASE1_BIT0_REDUN_MASK	0x80000000
> +#define MSM8994_BASE1_BIT1_9_REDUN_MASK	0x1ff
> +#define MSM8994_BASE0_REDUN_SHIFT	21
> +#define MSM8994_BASE1_BIT0_REDUN_SHIFT_COMPUTE	31
> +
> +#define MSM8994_S0_REDUN_MASK	0x1e00
> +#define MSM8994_S1_REDUN_MASK	0x1e000
> +#define MSM8994_S2_REDUN_MASK	0x1e0000
> +#define MSM8994_S3_REDUN_MASK	0x1e00000
> +#define MSM8994_S4_REDUN_MASK	0x1e000000
> +#define MSM8994_S5_REDUN_MASK_BIT0_2	0xe0000000
> +#define MSM8994_S5_REDUN_MASK_BIT3	0x800000
> +#define MSM8994_S6_REDUN_MASK	0xf000000
> +#define MSM8994_S7_REDUN_MASK	0xf0000000
> +#define MSM8994_S8_REDUN_MASK	0xf
> +#define MSM8994_S9_REDUN_MASK	0xf0
> +#define MSM8994_S10_REDUN_MASK	0xf00
> +#define MSM8994_S11_REDUN_MASK	0xf000
> +#define MSM8994_S12_REDUN_MASK	0xf0000
> +#define MSM8994_S13_REDUN_MASK	0xf00000
> +#define MSM8994_S14_REDUN_MASK	0xf000000
> +#define MSM8994_S15_REDUN_MASK	0xf0000000
> +
> +#define MSM8994_S0_REDUN_SHIFT	9
> +#define MSM8994_S1_REDUN_SHIFT	13
> +#define MSM8994_S2_REDUN_SHIFT	17
> +#define MSM8994_S3_REDUN_SHIFT	21
> +#define MSM8994_S4_REDUN_SHIFT	25
> +#define MSM8994_S5_REDUN_SHIFT_BIT0_2	29
> +#define MSM8994_S5_REDUN_SHIFT_BIT3	23
> +#define MSM8994_S6_REDUN_SHIFT	24
> +#define MSM8994_S7_REDUN_SHIFT	28
> +#define MSM8994_S8_REDUN_SHIFT	0
> +#define MSM8994_S9_REDUN_SHIFT	4
> +#define MSM8994_S10_REDUN_SHIFT	8
> +#define MSM8994_S11_REDUN_SHIFT	12
> +#define MSM8994_S12_REDUN_SHIFT	16
> +#define MSM8994_S13_REDUN_SHIFT	20
> +#define MSM8994_S14_REDUN_SHIFT	24
> +#define MSM8994_S15_REDUN_SHIFT	28
> +
> +#define MSM8994_REDUN_SEL_MASK		0x7
> +#define MSM8994_CAL_SEL_REDUN_MASK	0xe0000000
> +#define MSM8994_CAL_SEL_REDUN_SHIFT	29
> +
> +#define BKP_SEL			0x3
> +#define BKP_REDUN_SEL		0xe0000000
> +#define BKP_REDUN_SHIFT		29
> +
>   static void compute_intercept_slope_8976(struct tsens_priv *priv,
>   			      u32 *p1, u32 *p2, u32 mode)
>   {
> @@ -166,6 +259,29 @@ static void compute_intercept_slope_8976(struct tsens_priv *priv,
>   	}
>   }
>   
> +/* HW-specific calculations forwardported from msm-3.10 kernel */
> +static void compute_intercept_slope_8994(struct tsens_priv *priv,
> +			      u32 base0, u32 base1, u32 *p, u32 mode)
> +{
> +	int adc_code_of_tempx, i, num, den, slope;
> +
> +	/* slope (m, dy/dx) = SLOPE_FACTOR * (adc_code2 - adc_code1)/(temp_120_degc - temp_30_degc) */
> +	num = base1 - base0;
> +	num *= SLOPE_FACTOR;

Combine into one line please. (base1 - base0) * SLOPE_FACTOR

> +	den = CAL_DEGC_PT2 - CAL_DEGC_PT1;
> +	slope = num / den;
> +
> +	for (i = 0; i < priv->num_sensors; i++) {
> +		adc_code_of_tempx = base0 + p[i];
> +		priv->sensor[i].offset = (adc_code_of_tempx * SLOPE_FACTOR) -
> +				(CAL_DEGC_PT1 *	priv->sensor[i].slope);

Is this intentional? To use priv->sensor[i].slope before computing it 
below ?

> +		priv->sensor[i].slope = (mode == TWO_PT_CALIB) ? slope : SLOPE_DEFAULT;
> +
> +		dev_dbg(priv->dev, "%s: offset:%d, slope:%d\n", __func__,
> +			priv->sensor[i].offset, priv->sensor[i].slope);
> +	}
> +}
> +
>   static int calibrate_v1(struct tsens_priv *priv)
>   {
>   	u32 base0 = 0, base1 = 0;
> @@ -297,14 +413,145 @@ static int calibrate_8976(struct tsens_priv *priv)
>   	return 0;
>   }
>   
> -/* v1.x: msm8956,8976,qcs404,405 */
> +static int calibrate_8994(struct tsens_priv *priv)
> +{
> +	int base0 = 0, base1 = 0, i;
> +	u32 p[16] = { [0 ... 15] = 532 }; /* HW-specific, undocumented magic value */

Maybe make 532 into a #define ?

> +	int mode = 0;
> +	u32 *calib0, *calib1, *calib2, *calib_mode, *calib_rsel;
> +	u32 calib_redun_sel;
> +
> +	/* 0x40d0-0x40dc */
> +	calib0 = (u32 *)qfprom_read(priv->dev, "calib");
> +	if (IS_ERR(calib0))
> +		return PTR_ERR(calib0);
> +
> +	dev_dbg(priv->dev, "%s: calib0: [0] = %u, [1] = %u, [2] = %u\n",
> +		__func__, calib0[0], calib0[1], calib0[2]);
> +
> +	/* 0x41c0-0x41c8 */
> +	calib1 = (u32 *)qfprom_read(priv->dev, "calib_redun1_2");
> +	if (IS_ERR(calib1))
> +		return PTR_ERR(calib1);
> +
> +	dev_dbg(priv->dev, "%s: calib1: [0] = %u, [1] = %u\n",
> +		__func__, calib1[0], calib1[1]);
> +
> +	/* 0x41cc-0x41d0 */
> +	calib2 = (u32 *)qfprom_read(priv->dev, "calib_redun3");
> +	if (IS_ERR(calib2))
> +		return PTR_ERR(calib2);
> +
> +	dev_dbg(priv->dev, "%s: calib2: [0] = %u\n", __func__, calib2[0]);
> +
> +	/* 0x4440-0x4448 */
> +	calib_mode = (u32 *)qfprom_read(priv->dev, "calib_redun4_5");
> +	if (IS_ERR(calib_mode))
> +		return PTR_ERR(calib_mode);
> +
> +	dev_dbg(priv->dev, "%s: calib_mode: [0] = %u, [1] = %u\n",
> +		__func__, calib1[0], calib1[1]);
> +
> +	/* 0x4464-0x4468 */
> +	calib_rsel = (u32 *)qfprom_read(priv->dev, "calib_rsel");
> +	if (IS_ERR(calib_mode))
> +		return PTR_ERR(calib_mode);
> +
> +	dev_dbg(priv->dev, "%s: calib_rsel: [0] = %u\n", __func__, calib_rsel[0]);
> +
> +	calib_redun_sel =  calib_rsel[0] & MSM8994_CAL_SEL_REDUN_MASK;
> +	calib_redun_sel >>= MSM8994_CAL_SEL_REDUN_SHIFT;

Again please look at combining the above into one line.

> +
> +	if (calib_redun_sel == BKP_SEL) {
> +		dev_dbg(priv->dev, "%s: Calibrating in REDUN mode, calib_redun_sel = %u",
> +			__func__, calib_redun_sel);
> +		mode = calib_mode[1] & MSM8994_REDUN_SEL_MASK;
> +
> +		if (mode == TWO_PT_CALIB) {
> +			dev_dbg(priv->dev, "%s: REDUN TWO_PT mode, mode = %u", __func__, mode);
> +			base0 = (calib1[0] & MSM8994_BASE0_REDUN_MASK) >> MSM8994_BASE0_REDUN_SHIFT;
> +			base1 = (calib1[0] & MSM8994_BASE1_BIT0_REDUN_MASK) >> MSM8994_BASE1_BIT0_REDUN_SHIFT_COMPUTE;
> +			base1 |= calib1[1] & MSM8994_BASE1_BIT1_9_REDUN_MASK;
> +			p[0] = (calib1[1] & MSM8994_S0_REDUN_MASK) >> MSM8994_S0_REDUN_SHIFT;
> +			p[1] = (calib1[1] & MSM8994_S1_REDUN_MASK) >> MSM8994_S1_REDUN_SHIFT;
> +			p[2] = (calib1[1] & MSM8994_S2_REDUN_MASK) >> MSM8994_S2_REDUN_SHIFT;
> +			p[3] = (calib1[1] & MSM8994_S3_REDUN_MASK) >> MSM8994_S3_REDUN_SHIFT;
> +			p[4] = (calib1[1] & MSM8994_S4_REDUN_MASK) >> MSM8994_S4_REDUN_SHIFT;
> +			p[5] = (calib1[1] & MSM8994_S5_REDUN_MASK_BIT0_2) >> MSM8994_S5_REDUN_SHIFT_BIT0_2;
> +			p[5] |= (calib2[0] & MSM8994_S5_REDUN_MASK_BIT3) >> MSM8994_S5_REDUN_SHIFT_BIT3;
> +			p[6] = (calib2[0] & MSM8994_S6_REDUN_MASK) >> MSM8994_S6_REDUN_SHIFT;
> +			p[7] = (calib2[0] & MSM8994_S7_REDUN_MASK) >> MSM8994_S7_REDUN_SHIFT;
> +			p[8] = (calib2[0] & MSM8994_S8_REDUN_MASK) >> MSM8994_S8_REDUN_SHIFT;
> +			p[9] = (calib2[0] & MSM8994_S9_REDUN_MASK) >> MSM8994_S9_REDUN_SHIFT;
> +			p[10] = (calib2[0] & MSM8994_S10_REDUN_MASK) >> MSM8994_S10_REDUN_SHIFT;
> +			p[11] = (calib2[0] & MSM8994_S11_REDUN_MASK) >> MSM8994_S11_REDUN_SHIFT;
> +			p[12] = (calib2[0] & MSM8994_S12_REDUN_MASK) >> MSM8994_S12_REDUN_SHIFT;
> +			p[13] = (calib2[0] & MSM8994_S13_REDUN_MASK) >> MSM8994_S13_REDUN_SHIFT;
> +			p[14] = (calib2[0] & MSM8994_S14_REDUN_MASK) >> MSM8994_S14_REDUN_SHIFT;
> +			p[15] = (calib2[0] & MSM8994_S15_REDUN_MASK) >> MSM8994_S15_REDUN_SHIFT;
> +		} else {
> +			dev_dbg(priv->dev, "%s: REDUN NON-TWO_PT mode, mode = %u", __func__, mode);
> +		}
> +	} else {
> +		dev_dbg(priv->dev, "%s: Calibrating in NOT-REDUN mode, calib_redun_sel = %u",
> +			__func__, calib_redun_sel);
> +		mode = (calib0[2] & MSM8994_CAL_SEL_MASK) >> MSM8994_CAL_SEL_SHIFT;
> +
> +		if (mode == TWO_PT_CALIB) {
> +			dev_dbg(priv->dev, "%s: NOT-REDUN TWO_PT mode, mode = %u", __func__, mode);
> +			base0 = (calib0[0] & MSM8994_BASE0_MASK) >> MSM8994_BASE0_SHIFT;
> +			base1 = (calib0[0] & MSM8994_BASE1_MASK) >> MSM8994_BASE1_SHIFT;
> +			p[0] = (calib0[0] & MSM8994_S0_MASK) >> MSM8994_S0_SHIFT;
> +			p[1] = (calib0[0] & MSM8994_S1_MASK) >> MSM8994_S1_SHIFT;
> +			p[2] = (calib0[1] & MSM8994_S2_MASK) >> MSM8994_S2_SHIFT;
> +			p[3] = (calib0[1] & MSM8994_S3_MASK) >> MSM8994_S3_SHIFT;
> +			p[4] = (calib0[1] & MSM8994_S4_MASK) >> MSM8994_S4_SHIFT;
> +			p[5] = (calib0[1] & MSM8994_S5_MASK) >> MSM8994_S5_SHIFT;
> +			p[6] = (calib0[1] & MSM8994_S6_MASK) >> MSM8994_S6_SHIFT;
> +			p[7] = (calib0[1] & MSM8994_S7_MASK) >> MSM8994_S7_SHIFT;
> +			p[8] = (calib0[1] & MSM8994_S8_MASK) >> MSM8994_S8_SHIFT;
> +			p[9] = (calib0[1] & MSM8994_S9_MASK) >> MSM8994_S9_SHIFT;
> +			p[10] = (calib0[1] & MSM8994_S10_MASK) >> MSM8994_S10_SHIFT;
> +			p[11] = (calib0[2] & MSM8994_S11_MASK) >> MSM8994_S11_SHIFT;
> +			p[12] = (calib0[2] & MSM8994_S12_MASK) >> MSM8994_S12_SHIFT;
> +			p[13] = (calib0[2] & MSM8994_S13_MASK) >> MSM8994_S13_SHIFT;
> +			p[14] = (calib0[2] & MSM8994_S14_MASK) >> MSM8994_S14_SHIFT;
> +			p[15] = (calib0[2] & MSM8994_S15_MASK) >> MSM8994_S15_SHIFT;
> +		} else {
> +			dev_dbg(priv->dev, "%s: NOT-REDUN NON-TWO_PT mode, mode = %u", __func__, mode);
> +			for (i = 0; i < 16; i++)
> +				p[i] = 532;

		You can drop the loop, right? Because you have initialized it above.

> +		}
> +	}
> +
> +	/* 8992 features less sensors and remaps some */
> +	if (priv->num_sensors == 13) {

I don't really like this check. But then there is no other way in 
tsens_priv to distinguish btw 8992 and 8994. So let us leave it as is.

> +		p[6] = p[7];
> +		p[7] = p[9];
> +		p[8] = p[10];
> +		p[9] = p[11];
> +		p[10] = p[12];
> +		p[11] = p[13];
> +		p[12] = p[14];
> +	}
> +
> +	compute_intercept_slope_8994(priv, base0, base1, p, mode);
> +	kfree(calib0);
> +	kfree(calib1);
> +	kfree(calib2);
> +	kfree(calib_mode);

free calib_rsel ??

> +
> +	return 0;
> +}
> +
> +/* v1.x: msm8956/8976, msm8994 (v1.2), qcs404/qcs405 */
>   
>   static struct tsens_features tsens_v1_feat = {
>   	.ver_major	= VER_1_X,
>   	.crit_int	= 0,
>   	.adc		= 1,
>   	.srot_split	= 1,
> -	.max_sensors	= 11,
> +	.max_sensors	= 16,
>   };
>   
>   static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
> @@ -323,12 +570,12 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>   	[INT_EN]     = REG_FIELD(TM_INT_EN_OFF, 0, 0),
>   
>   	/* UPPER/LOWER TEMPERATURE THRESHOLDS */
> -	REG_FIELD_FOR_EACH_SENSOR11(LOW_THRESH,    TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF,  0,  9),
> -	REG_FIELD_FOR_EACH_SENSOR11(UP_THRESH,     TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 10, 19),
> +	REG_FIELD_FOR_EACH_SENSOR16(LOW_THRESH,    TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF,  0,  9),
> +	REG_FIELD_FOR_EACH_SENSOR16(UP_THRESH,     TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 10, 19),
>   
>   	/* UPPER/LOWER INTERRUPTS [CLEAR/STATUS] */
> -	REG_FIELD_FOR_EACH_SENSOR11(LOW_INT_CLEAR, TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 20, 20),
> -	REG_FIELD_FOR_EACH_SENSOR11(UP_INT_CLEAR,  TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 21, 21),
> +	REG_FIELD_FOR_EACH_SENSOR16(LOW_INT_CLEAR, TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 20, 20),
> +	REG_FIELD_FOR_EACH_SENSOR16(UP_INT_CLEAR,  TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 21, 21),
>   	[LOW_INT_STATUS_0] = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF,  0,  0),
>   	[LOW_INT_STATUS_1] = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF,  1,  1),
>   	[LOW_INT_STATUS_2] = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF,  2,  2),
> @@ -349,14 +596,14 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>   	/* NO CRITICAL INTERRUPT SUPPORT on v1 */
>   
>   	/* Sn_STATUS */
> -	REG_FIELD_FOR_EACH_SENSOR11(LAST_TEMP,    TM_Sn_STATUS_OFF,  0,  9),
> -	REG_FIELD_FOR_EACH_SENSOR11(VALID,        TM_Sn_STATUS_OFF, 14, 14),
> +	REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,    TM_Sn_STATUS_OFF,  0,  9),
> +	REG_FIELD_FOR_EACH_SENSOR16(VALID,        TM_Sn_STATUS_OFF, 14, 14),
>   	/* xxx_STATUS bits: 1 == threshold violated */
> -	REG_FIELD_FOR_EACH_SENSOR11(MIN_STATUS,   TM_Sn_STATUS_OFF, 10, 10),
> -	REG_FIELD_FOR_EACH_SENSOR11(LOWER_STATUS, TM_Sn_STATUS_OFF, 11, 11),
> -	REG_FIELD_FOR_EACH_SENSOR11(UPPER_STATUS, TM_Sn_STATUS_OFF, 12, 12),
> +	REG_FIELD_FOR_EACH_SENSOR16(MIN_STATUS,   TM_Sn_STATUS_OFF, 10, 10),
> +	REG_FIELD_FOR_EACH_SENSOR16(LOWER_STATUS, TM_Sn_STATUS_OFF, 11, 11),
> +	REG_FIELD_FOR_EACH_SENSOR16(UPPER_STATUS, TM_Sn_STATUS_OFF, 12, 12),
>   	/* No CRITICAL field on v1.x */
> -	REG_FIELD_FOR_EACH_SENSOR11(MAX_STATUS,   TM_Sn_STATUS_OFF, 13, 13),
> +	REG_FIELD_FOR_EACH_SENSOR16(MAX_STATUS,   TM_Sn_STATUS_OFF, 13, 13),
>   
>   	/* TRDY: 1=ready, 0=in progress */
>   	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
> @@ -388,3 +635,31 @@ struct tsens_plat_data data_8976 = {
>   	.feat		= &tsens_v1_feat,
>   	.fields		= tsens_v1_regfields,
>   };
> +
> +static const struct tsens_ops ops_8992 = {
> +	.init		= init_common,
> +	.calibrate	= calibrate_8994,
> +	.get_temp	= get_temp_tsens_valid,
> +};
> +
> +struct tsens_plat_data data_8992 = {
> +	.num_sensors	= 13,
> +	.ops		= &ops_8992,
> +	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 4, 5, 7, 9, 10, 11, 12, 13, 14 },
> +	.feat		= &tsens_v1_feat,
> +	.fields	= tsens_v1_regfields,
> +};
> +
> +static const struct tsens_ops ops_8994 = {
> +	.init		= init_common,
> +	.calibrate	= calibrate_8994,
> +	.get_temp	= get_temp_tsens_valid,
> +};

Please use one common tsens_ops for 8994 and 8992.

> +
> +struct tsens_plat_data data_8994 = {
> +	.num_sensors	= 16,
> +	.ops		= &ops_8994,
> +	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
> +	.feat		= &tsens_v1_feat,
> +	.fields	= tsens_v1_regfields,
> +};
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 4c7ebd1d3f9c..c3cd4425bbfd 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -982,6 +982,12 @@ static const struct of_device_id tsens_table[] = {
>   	}, {
>   		.compatible = "qcom,msm8974-tsens",
>   		.data = &data_8974,
> +	}, {
> +		.compatible = "qcom,msm8992-tsens",
> +		.data = &data_8992,
> +	}, {
> +		.compatible = "qcom,msm8994-tsens",
> +		.data = &data_8994,
>   	}, {
>   		.compatible = "qcom,msm8976-tsens",
>   		.data = &data_8976,
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 1471a2c00f15..ca2b0ac914c1 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -590,7 +590,7 @@ extern struct tsens_plat_data data_8960;
>   extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
>   
>   /* TSENS v1 targets */
> -extern struct tsens_plat_data data_tsens_v1, data_8976;
> +extern struct tsens_plat_data data_tsens_v1, data_8976, data_8992, data_8994;
>   
>   /* TSENS v2 targets */
>   extern struct tsens_plat_data data_8996, data_tsens_v2;
> 

-- 
Warm Regards
Thara (She/Her/Hers)
