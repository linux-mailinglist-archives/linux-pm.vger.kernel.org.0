Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AFB399274
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 20:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhFBSWW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 14:22:22 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:53027 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhFBSWV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 14:22:21 -0400
Received: by mail-wm1-f46.google.com with SMTP id f17so1884486wmf.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Jun 2021 11:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LJescyDSFEAtxwhrRpXsY/OUBaA3CWiu6Pu9ogBgGJM=;
        b=P5avIvYvF2UaUss1jye3cQaQQEg/3JLN2vNdP1qPSGG7x6Xi/EFgl2O5cgqTerjrWU
         R9ICdRUNAGO2FblMsMZhkhlNOpzbsXqiaOwBVVuaIJbbwVJODwpCsZNep5d8bdT9jtq9
         9cuuh+Qp3grBX87M8E/Sd7UUkjFuD3TTnL8UxM9CojNkwK0i5CCG6S8VPhseCeJY5qjh
         IA30zDWToMl4/wz1Ww7noBszNsZG/PCByfjD9Vu7WaT8ohO3O+n+YKQ/HaInRAeefx5l
         q20DZG9GasaTkYMbdeaShbU01d5cGeVSLHXdcI8tYmew+i8+iZALyfD+pbev4EsFSn0z
         LFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LJescyDSFEAtxwhrRpXsY/OUBaA3CWiu6Pu9ogBgGJM=;
        b=bDjq4MugPojd3IzCDW+Z/3wf2gLvEdd7o9ajuCaCyOCfhOVX9B6mhXdgfLcapUEjtY
         0uyJOsz2OAAVbyvuk8060wyDj9bO7UUAPPm6CAcek1G2dEi70iunHoy9VsBThICFZVSF
         uQP9UIy6qYcskruj3xA5SWLC+Gu6tjq/rE+S2P4qJLPeokpHmZBOlwy+LAp5PYe5aykG
         zGoS/IBU4cVdwlZHgDvegzmE8jrYWbw2olTxffdjaktgNdqJg+E/stCHC+P+xsFjCRIF
         S5Mn533kxjlQl6F/7AYO4wbeXHRbviD+QkFbLKwkXiOvyyC4uLFbqGtTLuOhhww9i9KF
         1ADQ==
X-Gm-Message-State: AOAM532Ja1wWjYEtCxBi7B3258OH4sTHOVyGci8gjOE4ozPAV3nDTIr6
        A0MYwxsHFNn6E7/5toJEfb1Gaw==
X-Google-Smtp-Source: ABdhPJxxU/GUZC3JeUxzYmxwpVodI1HU5PE7dv8MtmhFfgCG7bD3VFVq28gBV/4gw5qV25o2Of2PsA==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr6399936wmc.93.1622657961572;
        Wed, 02 Jun 2021 11:19:21 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:70d3:6c26:978:999d? ([2a01:e34:ed2f:f020:70d3:6c26:978:999d])
        by smtp.googlemail.com with ESMTPSA id h46sm926063wrh.44.2021.06.02.11.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 11:19:21 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] thermal: qcom: tsens-v1: Add support for MSM8994
 TSENS
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210209195346.457803-1-konrad.dybcio@somainline.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a4b76d12-a659-da87-7d97-9b34e3cf7edf@linaro.org>
Date:   Wed, 2 Jun 2021 20:19:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210209195346.457803-1-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Konrad,


On 09/02/2021 20:53, Konrad Dybcio wrote:
> MSM8994, despite being heavily based on MSM8974, uses the
> 1.2 version of TSENS. Also, 8994 being 8994, it has a custom
> way of calculating the slope.
> 
> Also tested on 8976 (by a person who didn't want to be named)
> to make sure the 11->16 max_sensors changes didn't break anything.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  .../bindings/thermal/qcom-tsens.yaml          |   1 +

Please split binding and code into two separate patches.

Without full understanding of the changes it is hard to comment the code
but, AFAICT, these changes should have a set of cleanups before (see below).

>  drivers/thermal/qcom/tsens-v1.c               | 291 +++++++++++++++++-
>  drivers/thermal/qcom/tsens.c                  |   3 +
>  drivers/thermal/qcom/tsens.h                  |   2 +-
>  4 files changed, 284 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 95462e071ab4..f194e914a62e 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -31,6 +31,7 @@ properties:
>          items:
>            - enum:
>                - qcom,msm8976-tsens
> +              - qcom,msm8994-tsens
>                - qcom,qcs404-tsens
>            - const: qcom,tsens-v1
>  
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index 3c19a3800c6d..2127b6edd1ae 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -142,6 +142,99 @@
>  #define CAL_SEL_MASK	7
>  #define CAL_SEL_SHIFT	0
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
>  static void compute_intercept_slope_8976(struct tsens_priv *priv,
>  			      u32 *p1, u32 *p2, u32 mode)
>  {
> @@ -166,6 +259,37 @@ static void compute_intercept_slope_8976(struct tsens_priv *priv,
>  	}
>  }
>  

That deserves a cartdrige with a good explanation of why this function
is doing all this. Without enough details, it is hard to review the code.

> +static void compute_intercept_slope_8994(struct tsens_priv *priv,
> +			      u32 *base0, u32 *base1, u32 *p, u32 mode)
> +{
> +	int adc_code_of_tempx, i, num, den;
> +
> +	for (i = 0; i < priv->num_sensors; i++) {
> +		dev_dbg(priv->dev,
> +			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
> +			__func__, i, base0[i], base1[i]);
> +
> +		priv->sensor[i].slope = SLOPE_DEFAULT;
> +		if (mode == TWO_PT_CALIB) {
> +			/*
> +			 * slope (m) = adc_code2 - adc_code1 (y2 - y1)/
> +			 *	temp_120_degc - temp_30_degc (x2 - x1)
> +			 */
> +			num = base1[i] - base0[i];

As the caller of the function is copying the value of base[0] to the
entire array, whatever 'i', base[i] == base[0], so the parameters can be
replaced by a single int.

Then the code becomes:

	num = base1 - base0;
	num *= SLOPE_FACTOR;
	den = CAL_DEGC_PT2 - CAL_DEGC_PT1;
	slope = num / den;

There is no change in the values, so 'slope' can be precomputed before
the loop. We end up with:

	int adc_code_of_tempx, i, num, den;
	int slope;

	/*
	 * slope (m) = adc_code2 - adc_code1 (y2 - y1)/
	 *	temp_120_degc - temp_30_degc (x2 - x1)
	 */
	num = base1 - base0;
	num *= SLOPE_FACTOR;
	den = CAL_DEGC_PT2 - CAL_DEGC_PT1;
	slope = num / den;

	for (i = 0; i < priv->num_sensors; i++) {

		priv->sensor[i].slope = mode == TWO_PT_CALIB ? slope :
			SLOPE_DEFAULT;


> +		adc_code_of_tempx = base0[i] + p[i];
> +
> +		priv->sensor[i].offset = (adc_code_of_tempx * SLOPE_FACTOR) -
> +				(CAL_DEGC_PT1 *	priv->sensor[i].slope);
> +		dev_dbg(priv->dev, "%s: offset:%d\n", __func__,
> +			priv->sensor[i].offset);
> +	}
> +}
> +
>  static int calibrate_v1(struct tsens_priv *priv)
>  {
>  	u32 base0 = 0, base1 = 0;
> @@ -297,14 +421,143 @@ static int calibrate_8976(struct tsens_priv *priv)
>  	return 0;
>  }

Same comment as above. The more the details, the easier for the people
to review the code.

> -/* v1.x: msm8956,8976,qcs404,405 */
> +static int calibrate_8994(struct tsens_priv *priv)
> +{
> +	int base0[16] = { 0 }, base1[16] = { 0 }, i;
> +	u32 p[16];

p stands for ?

> +	int mode = 0;
> +	u32 *calib0, *calib1, *calib2, *calib_mode, *calib_rsel;
> +	u32 calib_redun_sel;
> +
> +	/* 0x40d0-0x40dc */
> +	calib0 = (u32 *)qfprom_read(priv->dev, "calib");

Fix qfprom_read, by returning an int and using nvmem_cell_read_u32
(separate series).

It seems like all call sites are expecting an int.

> +	if (IS_ERR(calib0))
> +		return PTR_ERR(calib0);
> +
> +	dev_dbg(priv->dev, "%s: calib0: [0] = %i, [1] = %i, [2] = %i\n",
> +		__func__, calib0[0], calib0[1], calib0[2]);
> +
> +	/* 0x41c0-0x41c8 */
> +	calib1 = (u32 *)qfprom_read(priv->dev, "calib_redun1_2");> +	if (IS_ERR(calib1))
> +		return PTR_ERR(calib1);
> +
> +	dev_dbg(priv->dev, "%s: calib1: [0] = %i, [1] = %i\n",
> +		__func__, calib1[0], calib1[1]);
> +
> +	/* 0x41cc-0x41d0 */
> +	calib2 = (u32 *)qfprom_read(priv->dev, "calib_redun3");
> +	if (IS_ERR(calib2))
> +		return PTR_ERR(calib2);
> +
> +	dev_dbg(priv->dev, "%s: calib2: [0] = %i\n", __func__, calib2[0]);
> +
> +	/* 0x4440-0x4448 */
> +	calib_mode = (u32 *)qfprom_read(priv->dev, "calib_redun4_5");
> +	if (IS_ERR(calib_mode))
> +		return PTR_ERR(calib_mode);
> +
> +	dev_dbg(priv->dev, "%s: calib_mode: [0] = %i, [1] = %i\n",
> +		__func__, calib1[0], calib1[1]);
> +
> +	/* 0x4464-0x4468 */
> +	calib_rsel = (u32 *)qfprom_read(priv->dev, "calib_rsel");
> +	if (IS_ERR(calib_mode))
> +		return PTR_ERR(calib_mode);
> +
> +	dev_dbg(priv->dev, "%s: calib_rsel: [0] = %i\n", __func__, calib_rsel[0]);
> +
> +	calib_redun_sel =  calib_rsel[0] & MSM8994_CAL_SEL_REDUN_MASK;
> +	calib_redun_sel >>= MSM8994_CAL_SEL_REDUN_SHIFT;
> +
> +	if (calib_redun_sel == BKP_SEL) {
> +		dev_dbg(priv->dev, "%s: Calibrating in REDUN mode, calib_redun_sel = %i",
> +			__func__, calib_redun_sel);
> +		mode = calib_mode[1] & MSM8994_REDUN_SEL_MASK;
> +
> +		if (mode == TWO_PT_CALIB) {
> +			dev_dbg(priv->dev, "%s: REDUN TWO_PT mode, mode = %i", __func__, mode);
> +			base0[0] = (calib1[0] & MSM8994_BASE0_REDUN_MASK) >> MSM8994_BASE0_REDUN_SHIFT;
> +			base1[0] = (calib1[0] & MSM8994_BASE1_BIT0_REDUN_MASK) >> MSM8994_BASE1_BIT0_REDUN_SHIFT_COMPUTE;
> +			base1[0] |= calib1[1] & MSM8994_BASE1_BIT1_9_REDUN_MASK;
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

IMO, it is possible to do something simpler (probably bits.h could have
interesting helpers).

> +		} else {
> +			dev_dbg(priv->dev, "%s: REDUN NON-TWO_PT mode, mode = %i",
> +			__func__, mode);
> +			for (i = 0; i < 16; i++)
> +				p[i] = 532;

No litterals, macros please

And it would be simpler to iniatialize the array with the value.

u32 p[16] = { [ 0 ... 15 ] = MY_532_MACRO };

So no need to use this loop and the other one beliw.

What about replacing 16 by TSENS_SENSOR_MAX ?

> +		}
> +	} else {
> +		dev_dbg(priv->dev, "%s: Calibrating in NOT-REDUN mode, calib_redun_sel = %i",
> +			__func__, calib_redun_sel);
> +		mode = (calib0[2] & MSM8994_CAL_SEL_MASK) >> MSM8994_CAL_SEL_SHIFT;
> +
> +		if (mode == TWO_PT_CALIB) {
> +			dev_dbg(priv->dev, "%s: NOT-REDUN TWO_PT mode, mode = %i", __func__, mode);
> +			base0[0] = (calib0[0] & MSM8994_BASE0_MASK) >> MSM8994_BASE0_SHIFT;
> +			base1[0] = (calib0[0] & MSM8994_BASE1_MASK) >> MSM8994_BASE1_SHIFT;
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
> +			dev_dbg(priv->dev, "%s: NOT-REDUN NON-TWO_PT mode, mode = %i", __func__, mode);
> +			for (i = 0; i < 16; i++)
> +				p[i] = 532;
> +		}
> +	}
> +
> +	/* 8994 does the slope calc a bit differently than others. */
> +	for (i = 1; i < 16; i++) {
> +		base0[i] = base0[0];
> +		base1[i] = base1[0];
> +	}
> +
> +	compute_intercept_slope_8994(priv, base0, base1, p, mode);
> +	kfree(calib0);
> +	kfree(calib1);
> +	kfree(calib2);
> +	kfree(calib_mode);
> +
> +	return 0;
> +}
> +
> +/* v1.x: msm8956/8976, msm8994 (v1.2), qcs404/qcs405 */
>  
>  static struct tsens_features tsens_v1_feat = {
>  	.ver_major	= VER_1_X,
>  	.crit_int	= 0,
>  	.adc		= 1,
>  	.srot_split	= 1,
> -	.max_sensors	= 11,
> +	.max_sensors	= 16,
>  };
>  
>  static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
> @@ -323,12 +576,12 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>  	[INT_EN]     = REG_FIELD(TM_INT_EN_OFF, 0, 0),
>  
>  	/* UPPER/LOWER TEMPERATURE THRESHOLDS */
> -	REG_FIELD_FOR_EACH_SENSOR11(LOW_THRESH,    TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF,  0,  9),
> -	REG_FIELD_FOR_EACH_SENSOR11(UP_THRESH,     TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 10, 19),
> +	REG_FIELD_FOR_EACH_SENSOR16(LOW_THRESH,    TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF,  0,  9),
> +	REG_FIELD_FOR_EACH_SENSOR16(UP_THRESH,     TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 10, 19),
>  
>  	/* UPPER/LOWER INTERRUPTS [CLEAR/STATUS] */
> -	REG_FIELD_FOR_EACH_SENSOR11(LOW_INT_CLEAR, TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 20, 20),
> -	REG_FIELD_FOR_EACH_SENSOR11(UP_INT_CLEAR,  TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 21, 21),
> +	REG_FIELD_FOR_EACH_SENSOR16(LOW_INT_CLEAR, TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 20, 20),
> +	REG_FIELD_FOR_EACH_SENSOR16(UP_INT_CLEAR,  TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF, 21, 21),
>  	[LOW_INT_STATUS_0] = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF,  0,  0),
>  	[LOW_INT_STATUS_1] = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF,  1,  1),
>  	[LOW_INT_STATUS_2] = REG_FIELD(TM_HIGH_LOW_INT_STATUS_OFF,  2,  2),
> @@ -349,14 +602,14 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>  	/* NO CRITICAL INTERRUPT SUPPORT on v1 */
>  
>  	/* Sn_STATUS */
> -	REG_FIELD_FOR_EACH_SENSOR11(LAST_TEMP,    TM_Sn_STATUS_OFF,  0,  9),
> -	REG_FIELD_FOR_EACH_SENSOR11(VALID,        TM_Sn_STATUS_OFF, 14, 14),
> +	REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,    TM_Sn_STATUS_OFF,  0,  9),
> +	REG_FIELD_FOR_EACH_SENSOR16(VALID,        TM_Sn_STATUS_OFF, 14, 14),
>  	/* xxx_STATUS bits: 1 == threshold violated */
> -	REG_FIELD_FOR_EACH_SENSOR11(MIN_STATUS,   TM_Sn_STATUS_OFF, 10, 10),
> -	REG_FIELD_FOR_EACH_SENSOR11(LOWER_STATUS, TM_Sn_STATUS_OFF, 11, 11),
> -	REG_FIELD_FOR_EACH_SENSOR11(UPPER_STATUS, TM_Sn_STATUS_OFF, 12, 12),
> +	REG_FIELD_FOR_EACH_SENSOR16(MIN_STATUS,   TM_Sn_STATUS_OFF, 10, 10),
> +	REG_FIELD_FOR_EACH_SENSOR16(LOWER_STATUS, TM_Sn_STATUS_OFF, 11, 11),
> +	REG_FIELD_FOR_EACH_SENSOR16(UPPER_STATUS, TM_Sn_STATUS_OFF, 12, 12),
>  	/* No CRITICAL field on v1.x */
> -	REG_FIELD_FOR_EACH_SENSOR11(MAX_STATUS,   TM_Sn_STATUS_OFF, 13, 13),
> +	REG_FIELD_FOR_EACH_SENSOR16(MAX_STATUS,   TM_Sn_STATUS_OFF, 13, 13),
>  
>  	/* TRDY: 1=ready, 0=in progress */
>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
> @@ -388,3 +641,17 @@ struct tsens_plat_data data_8976 = {
>  	.feat		= &tsens_v1_feat,
>  	.fields		= tsens_v1_regfields,
>  };
> +
> +static const struct tsens_ops ops_8994 = {
> +	.init		= init_common,
> +	.calibrate	= calibrate_8994,
> +	.get_temp	= get_temp_tsens_valid,
> +};
> +
> +struct tsens_plat_data data_8994 = {
> +	.num_sensors	= 16,
> +	.ops		= &ops_8994,
> +	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },

If you have time, in another series, replace this by a single int used
as a bitmask and fix the hw_id loop in tsens.c.

> +	.feat		= &tsens_v1_feat,
> +	.fields	= tsens_v1_regfields,
> +};
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index d8ce3a687b80..96d17afe3460 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -903,6 +903,9 @@ static const struct of_device_id tsens_table[] = {
>  	}, {
>  		.compatible = "qcom,msm8974-tsens",
>  		.data = &data_8974,
> +	}, {
> +		.compatible = "qcom,msm8994-tsens",
> +		.data = &data_8994,
>  	}, {
>  		.compatible = "qcom,msm8976-tsens",
>  		.data = &data_8976,
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index f40b625f897e..dfbff7f6442c 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -588,7 +588,7 @@ extern struct tsens_plat_data data_8960;
>  extern struct tsens_plat_data data_8916, data_8939, data_8974;
>  
>  /* TSENS v1 targets */
> -extern struct tsens_plat_data data_tsens_v1, data_8976;
> +extern struct tsens_plat_data data_tsens_v1, data_8976, data_8994;
>  
>  /* TSENS v2 targets */
>  extern struct tsens_plat_data data_8996, data_tsens_v2;
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
