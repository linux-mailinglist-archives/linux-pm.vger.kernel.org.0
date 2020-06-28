Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB62520C6D1
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jun 2020 09:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgF1Hj3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Jun 2020 03:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgF1Hj2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jun 2020 03:39:28 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EB2C03E97B
        for <linux-pm@vger.kernel.org>; Sun, 28 Jun 2020 00:39:28 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b16so6532060pfi.13
        for <linux-pm@vger.kernel.org>; Sun, 28 Jun 2020 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2gZ3Ey9dnbKR3FNjM+7Zu1K55QA2gC3RfP+X2lu2GFQ=;
        b=hhjAkbPSZ2G+Ia6oYpc5FoYYq6gkyk5Rue08XBpliLylXFVSW8p9WbIy1C+KbV7v6h
         DEkqJIFeAZxe+ofRlnt4zIOP+16UQ9T8qAVTu4zMSHJMpyxt0oTPKxrUrS4EKtLD7TAu
         A8uHfZ6m08ZFxYtRUPaNAjS+b+rdKeFkaoxhCV/HK3sjD4MBtQ/BxT7lPcp0RhpUM2Q4
         JHx0HOFESIzGij43bWhP+///OE2770rvnSEj+w+/Lw0thN9yya1+FCAB5oVhteDR4t66
         FTBGyqVkcnbLIWc7UHHfKmtbHB8QbQ+W1e1kul6nK/D5ptuPCiHU4jRqRPQMjYbBFeuR
         mdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2gZ3Ey9dnbKR3FNjM+7Zu1K55QA2gC3RfP+X2lu2GFQ=;
        b=rbNC3BQrpoWZKA5Qkh8sxuDIXk1wzHokMfEzZ1nmGpdJLHaQLSvTgmCZTCuC9QiVkx
         ae/9Drv7OTpKAhT8PqPKAefEhUsqDvPPOylrmFat6zb+B/Zg4uiUu68sqtYDA2lyvltm
         yRoBzvd+5gOoJeaHXZp8XidbZtav+N4RNcUr9B4kzMRz9LD17+2inzfLUv63e/nKKDeS
         BEXlGb4TswS8htI2L1Vk/pTs/oV9CwkoqlWVT8XSk3PgrNGtx1nWS8vym7dea2Xb+gH0
         zCxTGixIbtVYnfBKi5wacU7g1YUvu8Z1/nwkyx84ZSbmOecOp7q6xLRLmNFeLxpV1sv0
         xZFQ==
X-Gm-Message-State: AOAM5303J6HSF9x11FUWXmm1xb+7Y3FwRg7e2OqnqkOQ5vdVHpbznvAZ
        GUBLY5tFbY8/deZwSyvYQ39Tww==
X-Google-Smtp-Source: ABdhPJyNaNhRqXdYQuKqkGHdNgpMFBF+e1dVuTwmHqBNi7WGek/K3vOZ0bjJq47xGjSCePRC2HITWw==
X-Received: by 2002:a63:af01:: with SMTP id w1mr5908957pge.23.1593329967820;
        Sun, 28 Jun 2020 00:39:27 -0700 (PDT)
Received: from dragon ([80.251.214.228])
        by smtp.gmail.com with ESMTPSA id f29sm24451394pga.59.2020.06.28.00.39.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Jun 2020 00:39:27 -0700 (PDT)
Date:   Sun, 28 Jun 2020 15:39:10 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] thermal: qcom: tsens-v0_1: Add support for MSM8939
Message-ID: <20200628073908.GA8343@dragon>
References: <20200501203311.143934-1-konradybcio@gmail.com>
 <20200501203311.143934-2-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501203311.143934-2-konradybcio@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 01, 2020 at 10:33:10PM +0200, Konrad Dybcio wrote:
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>

For the record, I'm working my version of msm8939 tsens driver support,
and I would highlight the things that differ from this patch.

> ---
>  drivers/thermal/qcom/tsens-v0_1.c | 142 +++++++++++++++++++++++++++++-
>  drivers/thermal/qcom/tsens.c      |   3 +
>  drivers/thermal/qcom/tsens.h      |   2 +-
>  3 files changed, 145 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 959a9371d205c..29b95886273b7 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -48,6 +48,64 @@
>  #define MSM8916_CAL_SEL_MASK	0xe0000000
>  #define MSM8916_CAL_SEL_SHIFT	29
>  
> +/* eeprom layout data for 8939 */
> +#define MSM8939_BASE0_MASK           0x000000ff

Tabs rather than spaces are used for indentation.

> +#define MSM8939_BASE1_MASK           0xff000000
> +#define MSM8939_BASE0_SHIFT

This shift is 0.

> +#define MSM8939_BASE1_SHIFT          24
> +
> +#define MSM8939_S0_P1_MASK         0x000001f8
> +#define MSM8939_S1_P1_MASK         0x001f8000
> +#define MSM8939_S2_P1_MASK_0_4     0xf8000000
> +#define MSM8939_S2_P1_MASK_5       0x00000001

This mask define is contradicting to MSM8939_S2_P1_SHIFT_5, and needs to
be confirmed.

> +#define MSM8939_S3_P1_MASK         0x00001f80
> +#define MSM8939_S4_P1_MASK         0x01f80000
> +#define MSM8939_S5_P1_MASK         0x00003f00
> +#define MSM8939_S6_P1_MASK         0x03f00000
> +#define MSM8939_S7_P1_MASK         0x0000003f
> +#define MSM8939_S8_P1_MASK         0x0003f000
> +#define MSM8939_S9_P1_MASK         0x07e00000
> +
> +#define MSM8939_S0_P2_MASK         0x00007e00
> +#define MSM8939_S1_P2_MASK         0x07e00000
> +#define MSM8939_S2_P2_MASK         0x0000007e
> +#define MSM8939_S3_P2_MASK         0x0007e000
> +#define MSM8939_S4_P2_MASK         0x7e000000
> +#define MSM8939_S5_P2_MASK         0x000fc000
> +#define MSM8939_S6_P2_MASK         0xfc000000
> +#define MSM8939_S7_P2_MASK         0x00000fc0
> +#define MSM8939_S8_P2_MASK         0x00fc0000
> +#define MSM8939_S9_P2_MASK_0_4     0xf8000000
> +#define MSM8939_S9_P2_MASK_5       0x00002000

It's contradicting to MSM8939_S9_P2_SHIFT_5, and needs to be confirmed.

> +
> +#define MSM8939_CAL_SEL_MASK	0xc0000000

Per downstream kernel, this mask is 0x7.

https://source.codeaurora.org/quic/la/kernel/msm-3.10/tree/drivers/thermal/msm8974-tsens.c?h=LA.BR.1.2.9.1_rb1.5#n370

> +#define MSM8939_CAL_SEL_SHIFT	0
> +
> +
> +#define MSM8939_S0_P1_SHIFT        3
> +#define MSM8939_S1_P1_SHIFT        15
> +#define MSM8939_S2_P1_SHIFT_0_4    27
> +#define MSM8939_S2_P1_SHIFT_5      5
> +#define MSM8939_S3_P1_SHIFT        7
> +#define MSM8939_S4_P1_SHIFT        19
> +#define MSM8939_S5_P1_SHIFT        8
> +#define MSM8939_S6_P1_SHIFT        20
> +//yes, 7 is missing in downstream

The shift is not missing but just 0.

> +#define MSM8939_S8_P1_SHIFT        12
> +#define MSM8939_S9_P1_SHIFT        21
> +
> +#define MSM8939_S0_P2_SHIFT        9
> +#define MSM8939_S1_P2_SHIFT        21
> +#define MSM8939_S2_P2_SHIFT        1
> +#define MSM8939_S3_P2_SHIFT        13
> +#define MSM8939_S4_P2_SHIFT        25
> +#define MSM8939_S5_P2_SHIFT        14
> +#define MSM8939_S6_P2_SHIFT        26
> +#define MSM8939_S7_P2_SHIFT        6
> +#define MSM8939_S8_P2_SHIFT        18
> +#define MSM8939_S9_P2_SHIFT_0_4    27
> +#define MSM8939_S9_P2_SHIFT_5      8
> +
>  /* eeprom layout data for 8974 */
>  #define BASE1_MASK		0xff
>  #define S0_P1_MASK		0x3f00
> @@ -189,6 +247,73 @@ static int calibrate_8916(struct tsens_priv *priv)
>  	return 0;
>  }
>  
> +static int calibrate_8939(struct tsens_priv *priv)
> +{
> +	int base0 = 0, base1 = 0, i;
> +	u32 p1[11], p2[11];

MSM8939 gets 10 sensors, so the arrays should be [10].

> +	int mode = 0;
> +	u32 *qfprom_cdata, *qfprom_csel;
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

'calib_sel' is not separate from 'calib' bits on MSM8939.  I chose to
read nvmem out as one go and map them to calibration data as below, per
downstream kernel.

	/* Mapping between qfprom nvmem and calibration data */
	cdata[0] = qfprom_cdata[12];
	cdata[1] = qfprom_cdata[13];
	cdata[2] = qfprom_cdata[0];
	cdata[3] = qfprom_cdata[1];
	cdata[4] = qfprom_cdata[22];
	cdata[5] = qfprom_cdata[21];

	mode = (cdata[0] & MSM8939_CAL_SEL_MASK) >> MSM8939_CAL_SEL_SHIFT;

https://source.codeaurora.org/quic/la/kernel/msm-3.10/tree/drivers/thermal/msm8974-tsens.c?h=LA.BR.1.2.9.1_rb1.5#n1286

We should support MSM8939 v3, as that's the mass production revision.

> +
> +	mode = (qfprom_csel[0] & MSM8939_CAL_SEL_MASK) >> MSM8939_CAL_SEL_SHIFT;
> +	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
> +	switch (mode) {
> +	case TWO_PT_CALIB:
> +		base1 = (qfprom_cdata[1] & MSM8939_BASE1_MASK) >> MSM8939_BASE1_SHIFT;
> +		p2[0] = (qfprom_cdata[0] & MSM8939_S0_P2_MASK) >> MSM8939_S0_P2_SHIFT;
> +		p2[1] = (qfprom_cdata[0] & MSM8939_S1_P2_MASK) >> MSM8939_S1_P2_SHIFT;
> +		p2[2] = (qfprom_cdata[1] & MSM8939_S2_P2_MASK) >> MSM8939_S2_P2_SHIFT;
> +		p2[3] = (qfprom_cdata[1] & MSM8939_S3_P2_MASK) >> MSM8939_S3_P2_SHIFT;
> +		p2[4] = (qfprom_cdata[1] & MSM8939_S4_P2_MASK) >> MSM8939_S4_P2_SHIFT;
> +		p2[5] = (qfprom_cdata[1] & MSM8939_S5_P2_MASK) >> MSM8939_S5_P2_SHIFT;
> +		p2[6] = (qfprom_cdata[1] & MSM8939_S6_P2_MASK) >> MSM8939_S6_P2_SHIFT;
> +		p2[7] = (qfprom_cdata[1] & MSM8939_S7_P2_MASK) >> MSM8939_S7_P2_SHIFT;
> +		p2[8] = (qfprom_cdata[1] & MSM8939_S8_P2_MASK) >> MSM8939_S8_P2_SHIFT;
> +		p2[9] = (qfprom_cdata[1] & MSM8939_S9_P2_MASK_0_4) >> MSM8939_S9_P2_SHIFT_0_4;
> +		p2[10] = (qfprom_cdata[1] & MSM8939_S9_P2_MASK_5) >> MSM8939_S9_P2_SHIFT_5;

These do not really match downstream kernel.  My version look like:

		base1 = (cdata[3] & MSM8939_BASE1_MASK) >> MSM8939_BASE1_SHIFT;
		p2[0] = (cdata[0] & MSM8939_S0_P2_MASK) >> MSM8939_S0_P2_SHIFT;
		p2[1] = (cdata[0] & MSM8939_S1_P2_MASK) >> MSM8939_S1_P2_SHIFT;
		p2[2] = (cdata[1] & MSM8939_S2_P2_MASK) >> MSM8939_S2_P2_SHIFT;
		p2[3] = (cdata[1] & MSM8939_S3_P2_MASK) >> MSM8939_S3_P2_SHIFT;
		p2[4] = (cdata[1] & MSM8939_S4_P2_MASK) >> MSM8939_S4_P2_SHIFT;
		p2[5] = (cdata[2] & MSM8939_S5_P2_MASK) >> MSM8939_S5_P2_SHIFT;
		p2[6] = (cdata[2] & MSM8939_S6_P2_MASK) >> MSM8939_S6_P2_SHIFT;
		p2[7] = (cdata[3] & MSM8939_S7_P2_MASK) >> MSM8939_S7_P2_SHIFT;
		p2[8] = (cdata[3] & MSM8939_S8_P2_MASK) >> MSM8939_S8_P2_SHIFT;
		p2[9] = (cdata[4] & MSM8939_S9_P2_MASK_0_4) >> MSM8939_S9_P2_SHIFT_0_4;
		p2[9] |= (cdata[5] & MSM8939_S9_P2_MASK_5) >> MSM8939_S9_P2_SHIFT_5;

> +		for (i = 0; i < priv->num_sensors; i++)
> +			p2[i] = ((base1 + p2[i]) << 3);

The left shift should be 2 per downstream kernel.

https://source.codeaurora.org/quic/la/kernel/msm-3.10/tree/drivers/thermal/msm8974-tsens.c?h=LA.BR.1.2.9.1_rb1.5#n1407

> +		/* Fall through */
> +	case ONE_PT_CALIB2:
> +		base0 = (qfprom_cdata[0] & MSM8939_BASE0_MASK);
> +		p1[0] = (qfprom_cdata[0] & MSM8939_S0_P1_MASK) >> MSM8939_S0_P1_SHIFT;
> +		p1[1] = (qfprom_cdata[0] & MSM8939_S1_P1_MASK) >> MSM8939_S1_P1_SHIFT;
> +		p1[2] = (qfprom_cdata[0] & MSM8939_S2_P1_MASK_0_4) >> MSM8939_S2_P1_SHIFT_0_4;
> +		p1[3] = (qfprom_cdata[0] & MSM8939_S2_P1_MASK_5) >> MSM8939_S2_P1_SHIFT_5;
> +		p1[4] = (qfprom_cdata[1] & MSM8939_S3_P1_MASK) >> MSM8939_S3_P1_SHIFT;
> +		p1[5] = (qfprom_cdata[1] & MSM8939_S4_P1_MASK) >> MSM8939_S4_P1_SHIFT;
> +		p1[6] = (qfprom_cdata[1] & MSM8939_S5_P1_MASK) >> MSM8939_S5_P1_SHIFT;
> +		p1[7] = (qfprom_cdata[1] & MSM8939_S6_P1_MASK) >> MSM8939_S6_P1_SHIFT;
> +		//yes, 7 is missing in downstream

Not really.

https://source.codeaurora.org/quic/la/kernel/msm-3.10/tree/drivers/thermal/msm8974-tsens.c?h=LA.BR.1.2.9.1_rb1.5#n1331

> +		p1[8] = (qfprom_cdata[1] & MSM8939_S8_P1_MASK) >> MSM8939_S8_P1_SHIFT;
> +		p1[9] = (qfprom_cdata[1] & MSM8939_S9_P1_MASK) >> MSM8939_S9_P1_SHIFT;
> +		for (i = 0; i < priv->num_sensors; i++)
> +			p1[i] = (((base0) + p1[i]) << 3);
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
>  static int calibrate_8974(struct tsens_priv *priv)
>  {
>  	int base1 = 0, base2 = 0, i;
> @@ -325,7 +450,7 @@ static int calibrate_8974(struct tsens_priv *priv)
>  	return 0;
>  }
>  
> -/* v0.1: 8916, 8974 */
> +/* v0.1: 8916, 8939, 8974 */
>  
>  static struct tsens_features tsens_v0_1_feat = {
>  	.ver_major	= VER_0_1,
> @@ -386,6 +511,21 @@ struct tsens_plat_data data_8916 = {
>  	.fields	= tsens_v0_1_regfields,
>  };
>  
> +static const struct tsens_ops ops_8939 = {
> +	.init		= init_common,
> +	.calibrate	= calibrate_8939,
> +	.get_temp	= get_temp_common,
> +};
> +
> +struct tsens_plat_data data_8939 = {
> +	.num_sensors	= 10,
> +	.ops		= &ops_8939,
> +	.hw_ids		= (unsigned int []){0, 1, 2, 4, 5, 6, 7, 8, 9 },

Should be { 0, 1, 2, 4, 5, 6, 7, 8, 9, 10 }.

https://source.codeaurora.org/quic/la/kernel/msm-3.10/tree/arch/arm/boot/dts/qcom/msm8939-v3.0.dtsi?h=LA.BR.1.2.9.1_rb1.5#n670

Shawn

> +
> +	.feat		= &tsens_v0_1_feat,
> +	.fields	= tsens_v0_1_regfields,
> +};
> +
>  static const struct tsens_ops ops_8974 = {
>  	.init		= init_common,
>  	.calibrate	= calibrate_8974,
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 2f77d235cf735..f654057e96ae1 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -59,6 +59,9 @@ static const struct of_device_id tsens_table[] = {
>  	{
>  		.compatible = "qcom,msm8916-tsens",
>  		.data = &data_8916,
> +	}, {
> +		.compatible = "qcom,msm8939-tsens",
> +		.data = &data_8939,
>  	}, {
>  		.compatible = "qcom,msm8974-tsens",
>  		.data = &data_8974,
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 502acf0e68285..403b15546f648 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -590,7 +590,7 @@ irqreturn_t tsens_critical_irq_thread(int irq, void *data);
>  extern struct tsens_plat_data data_8960;
>  
>  /* TSENS v0.1 targets */
> -extern struct tsens_plat_data data_8916, data_8974;
> +extern struct tsens_plat_data data_8916, data_8939, data_8974;
>  
>  /* TSENS v1 targets */
>  extern struct tsens_plat_data data_tsens_v1, data_8976;
> -- 
> 2.26.1
> 
