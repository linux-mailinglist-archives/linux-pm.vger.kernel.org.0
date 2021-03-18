Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D4D340F9D
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 22:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhCRVPk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 17:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbhCRVP1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 17:15:27 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC2EC061760
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 14:15:27 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id by2so3960442qvb.11
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 14:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HYhA/Avxif7UVkJ1m3UFS73y0g6klPudmFWqm569zA8=;
        b=OMbqwavsnVSV2vYPZiASlzWN8o//XQLD4CChuQ7tbMCjGkPkgaoNHV24sz6pGgjvg5
         /UN/HSTFtmsns40G8EjstezXn/vss0THaraH9AOqJIIR95wlmhtcwSN4A6ivoJxFzapg
         BDJ2Sl+0AOwJhKkum7qlCuGFdueTYBUqBTMlj1Pn0eTtlKiNQJy3b8wcz3QdAiN/5GZC
         aOPxvQkqPPVBskbW7uKGZPjDS96ycI494HhG0mPcLAsg5+ZBP9g19CZ6E9QS0P4GkPJ6
         OxPtM7Jlkrl1ML6Uol7xTPj9DMzyKq3cHaefZwW/MZx/HvvhskpECpLDq4TxJWK7qrZy
         p/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HYhA/Avxif7UVkJ1m3UFS73y0g6klPudmFWqm569zA8=;
        b=jYCt3PBK7qJR0qE7c5g13LjZ5ooi21fVOiM3HSiWW3UQ91TIy7CjF0yUJHnBwuk3Ka
         0N+m4F00Snew26kITYxBA0B37gRLYeRgugwlSWc0SQM7Y9unBBObYWwBXLmBhmokrWTS
         7nI++mSEbJqFMbrv85iDmoC5d6LkkcHAvl3RfbRxeJ4dZhYvThn0s9k4lwjQEY1/r1+C
         SKa9wMzFJxEebjKDF3Jk/4tK9S4VI5iV38dYJdbj5mtExKmZVQt+gVy9KEoepRq64CKx
         NoB3t2gTulfVDMe0m7iUr03UfV3hnje7hH8nw8Wa7yBmIF4Z+D3D6TtRvt4nlsXu7HnC
         a0Yw==
X-Gm-Message-State: AOAM532qAnGdilkxwxo6rRIO9Pb6G7uq/KMEdGLnQ6DfnmNb7HyzVDm/
        X0bJj2hZr/H5ZhtXL6Tt2b1qqQ==
X-Google-Smtp-Source: ABdhPJxdhfVQ0eUYGFxP2S41ybtIv0oD+KlcLqtXrFyk7IRg/qQ2DFYYVLyrNIbYIRCTKi9bHOYlog==
X-Received: by 2002:ad4:470c:: with SMTP id k12mr6344143qvz.9.1616102126412;
        Thu, 18 Mar 2021 14:15:26 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id v5sm2298048qtq.26.2021.03.18.14.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 14:15:26 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH v10 3/8] drivers: thermal: tsens: Convert msm8960 to
 reg_field
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210217194011.22649-1-ansuelsmth@gmail.com>
 <20210217194011.22649-4-ansuelsmth@gmail.com>
Message-ID: <01aab17f-3e02-41ae-e420-ad752d15d61f@linaro.org>
Date:   Thu, 18 Mar 2021 17:15:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210217194011.22649-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/17/21 2:40 PM, Ansuel Smith wrote:
> Convert msm9860 driver to reg_field to use the init_common
> function.

Hi!

Now that you have done this, you should clean up the unused 
bitmasks/offsets etc in
tsens-8960.c file as well as a separate patch. I only see the
need to maintain SLP_CLK_ENA_8660 and SLP_CLK_ENA. Everything else can 
be removed and the s/w can use priv->rf[_field_] for access.
Otherwise for this patch

Acked-by: Thara Gopinath <thara.gopinath@linaro.org>

Warm Regards
Thara
>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>   drivers/thermal/qcom/tsens-8960.c | 80 ++++++++++++++++++++++++++++++-
>   1 file changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
> index 2a28a5af209e..3f4fc1ffe679 100644
> --- a/drivers/thermal/qcom/tsens-8960.c
> +++ b/drivers/thermal/qcom/tsens-8960.c
> @@ -51,11 +51,22 @@
>   #define MIN_LIMIT_TH		0x0
>   #define MAX_LIMIT_TH		0xff
>   
> -#define S0_STATUS_ADDR		0x3628
>   #define INT_STATUS_ADDR		0x363c
>   #define TRDY_MASK		BIT(7)
>   #define TIMEOUT_US		100
>   
> +#define S0_STATUS_OFF		0x3628
> +#define S1_STATUS_OFF		0x362c
> +#define S2_STATUS_OFF		0x3630
> +#define S3_STATUS_OFF		0x3634
> +#define S4_STATUS_OFF		0x3638
> +#define S5_STATUS_OFF		0x3664  /* Sensors 5-10 found on apq8064/msm8960 */
> +#define S6_STATUS_OFF		0x3668
> +#define S7_STATUS_OFF		0x366c
> +#define S8_STATUS_OFF		0x3670
> +#define S9_STATUS_OFF		0x3674
> +#define S10_STATUS_OFF		0x3678
> +
>   static int suspend_8960(struct tsens_priv *priv)
>   {
>   	int ret;
> @@ -269,6 +280,71 @@ static int get_temp_8960(const struct tsens_sensor *s, int *temp)
>   	return -ETIMEDOUT;
>   }
>   
> +static struct tsens_features tsens_8960_feat = {
> +	.ver_major	= VER_0,
> +	.crit_int	= 0,
> +	.adc		= 1,
> +	.srot_split	= 0,
> +	.max_sensors	= 11,
> +};
> +
> +static const struct reg_field tsens_8960_regfields[MAX_REGFIELDS] = {
> +	/* ----- SROT ------ */
> +	/* No VERSION information */
> +
> +	/* CNTL */
> +	[TSENS_EN]     = REG_FIELD(CNTL_ADDR,  0, 0),
> +	[TSENS_SW_RST] = REG_FIELD(CNTL_ADDR,  1, 1),
> +	/* 8960 has 5 sensors, 8660 has 11, we only handle 5 */
> +	[SENSOR_EN]    = REG_FIELD(CNTL_ADDR,  3, 7),
> +
> +	/* ----- TM ------ */
> +	/* INTERRUPT ENABLE */
> +	/* NO INTERRUPT ENABLE */
> +
> +	/* Single UPPER/LOWER TEMPERATURE THRESHOLD for all sensors */
> +	[LOW_THRESH_0]   = REG_FIELD(THRESHOLD_ADDR,  0,  7),
> +	[UP_THRESH_0]    = REG_FIELD(THRESHOLD_ADDR,  8, 15),
> +	/* MIN_THRESH_0 and MAX_THRESH_0 are not present in the regfield
> +	 * Recycle CRIT_THRESH_0 and 1 to set the required regs to hardcoded temp
> +	 * MIN_THRESH_0 -> CRIT_THRESH_1
> +	 * MAX_THRESH_0 -> CRIT_THRESH_0
> +	 */
> +	[CRIT_THRESH_1]   = REG_FIELD(THRESHOLD_ADDR, 16, 23),
> +	[CRIT_THRESH_0]   = REG_FIELD(THRESHOLD_ADDR, 24, 31),
> +
> +	/* UPPER/LOWER INTERRUPT [CLEAR/STATUS] */
> +	/* 1 == clear, 0 == normal operation */
> +	[LOW_INT_CLEAR_0]   = REG_FIELD(CNTL_ADDR,  9,  9),
> +	[UP_INT_CLEAR_0]    = REG_FIELD(CNTL_ADDR, 10, 10),
> +
> +	/* NO CRITICAL INTERRUPT SUPPORT on 8960 */
> +
> +	/* Sn_STATUS */
> +	[LAST_TEMP_0]  = REG_FIELD(S0_STATUS_OFF,  0,  7),
> +	[LAST_TEMP_1]  = REG_FIELD(S1_STATUS_OFF,  0,  7),
> +	[LAST_TEMP_2]  = REG_FIELD(S2_STATUS_OFF,  0,  7),
> +	[LAST_TEMP_3]  = REG_FIELD(S3_STATUS_OFF,  0,  7),
> +	[LAST_TEMP_4]  = REG_FIELD(S4_STATUS_OFF,  0,  7),
> +	[LAST_TEMP_5]  = REG_FIELD(S5_STATUS_OFF,  0,  7),
> +	[LAST_TEMP_6]  = REG_FIELD(S6_STATUS_OFF,  0,  7),
> +	[LAST_TEMP_7]  = REG_FIELD(S7_STATUS_OFF,  0,  7),
> +	[LAST_TEMP_8]  = REG_FIELD(S8_STATUS_OFF,  0,  7),
> +	[LAST_TEMP_9]  = REG_FIELD(S9_STATUS_OFF,  0,  7),
> +	[LAST_TEMP_10] = REG_FIELD(S10_STATUS_OFF, 0,  7),
> +
> +	/* No VALID field on 8960 */
> +	/* TSENS_INT_STATUS bits: 1 == threshold violated */
> +	[MIN_STATUS_0] = REG_FIELD(INT_STATUS_ADDR, 0, 0),
> +	[LOWER_STATUS_0] = REG_FIELD(INT_STATUS_ADDR, 1, 1),
> +	[UPPER_STATUS_0] = REG_FIELD(INT_STATUS_ADDR, 2, 2),
> +	/* No CRITICAL field on 8960 */
> +	[MAX_STATUS_0] = REG_FIELD(INT_STATUS_ADDR, 3, 3),
> +
> +	/* TRDY: 1=ready, 0=in progress */
> +	[TRDY] = REG_FIELD(INT_STATUS_ADDR, 7, 7),
> +};
> +
>   static const struct tsens_ops ops_8960 = {
>   	.init		= init_8960,
>   	.calibrate	= calibrate_8960,
> @@ -282,4 +358,6 @@ static const struct tsens_ops ops_8960 = {
>   struct tsens_plat_data data_8960 = {
>   	.num_sensors	= 11,
>   	.ops		= &ops_8960,
> +	.feat		= &tsens_8960_feat,
> +	.fields		= tsens_8960_regfields,
>   };
> 

