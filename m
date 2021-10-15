Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DFF42E530
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 02:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhJOAWn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 20:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbhJOAWm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 20:22:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED20C061570
        for <linux-pm@vger.kernel.org>; Thu, 14 Oct 2021 17:20:36 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u18so33354953lfd.12
        for <linux-pm@vger.kernel.org>; Thu, 14 Oct 2021 17:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4vhitf+OB83J8FxwqIn9yUkbnWD0KiX07u4IYQ5OV/U=;
        b=xUmU3e+AN56evNuz4VZTGL6egGEFJoSWXOq7mTf/QievLJEK9IDj0ug7WLkMKBCo6q
         mtUUeoN0jb2sXlQSrwQ+HlKUPLFLWKvgmFVZ1WBurZl1DfIABIhb1BRQ0Hc1l9ut7En/
         ptulesDYXCV9NO+f71elALiwFgDS1Hk1Zozcdk9yp0JoVdMWiXi3ly+KsfUTxEV5x8LC
         9hMR5z+Wguj5h/SNjuvZmB9lM99hLG7ycHmHGfFgZJ1sOpNqM6Mna8Asx06sxnmI090U
         StG18anaC9n72pkBJNjEcAUUMnLtBuF2N73K2aEEiW8LfDDPZhalnKuhAq9UfNu2+e8T
         i8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4vhitf+OB83J8FxwqIn9yUkbnWD0KiX07u4IYQ5OV/U=;
        b=5OwDgoNYj8PKECF3b4iHjjg6AYAA31iaq0FyO0Aec5rfWGFak82VotGgDao5pvVuB9
         95HSDRD5oGn3ja3eQyGULw20bA366SvZ2iIwQQVIE5SHKyoy2EpYZhB0bU1j2rt+Grno
         nu4H+Klt6qi1YJ4gwstvb/LxHWA6/pVOosAiVb+L0qJSelIBI2TFW5Fue5iHpcfnPhLC
         j9Eo5anv854PBmLWDzBCcGbX+FiAQzBIBIHnfTHC02+TcgxDE2G42oqslBEzob0q3pmk
         l972pSJoftCyMFhWRDhm05/rsfFX5cYG9vB9EIEQYTfusLx0rehfj1tV4dm+S4+4V2/S
         KiPA==
X-Gm-Message-State: AOAM531hPXlb8sICMLthJXYBcNHLulXSLX6/5IPdERynJNEi0oO+Q2P4
        WZijWlNPuwmLWyfPrVU/QDZXiMLdER8/DA==
X-Google-Smtp-Source: ABdhPJx6x0dTEEVnYH4yVgOyMjDIvJKuYHi4fB7VV7o/4PmA1vJvYO0ins5SRxNn566R4asXHr2pOg==
X-Received: by 2002:a2e:7204:: with SMTP id n4mr10014059ljc.430.1634257234634;
        Thu, 14 Oct 2021 17:20:34 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s14sm355304lfe.14.2021.10.14.17.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 17:20:34 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] thermal/drivers/qcom/spmi-adc-tm5: Add support for
 HC variant
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211005032531.2251928-1-bjorn.andersson@linaro.org>
 <20211005032531.2251928-3-bjorn.andersson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <7142a85a-9bd6-015c-89c6-e7bbac5af534@linaro.org>
Date:   Fri, 15 Oct 2021 03:20:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211005032531.2251928-3-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/10/2021 06:25, Bjorn Andersson wrote:
> The variant of the ADC Thermal Monitor block found in e.g. PM8998 is
> "HC", add support for this variant to the ADC TM5 driver in order to
> support using VADC channels as thermal_zones on SDM845 et al.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> 
> Changes since v2:
> - Dropped conditional return ret right before unconditionatl return ret;
> 
>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 41 +++++++++++++++++++++++-
>   1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> index 8494cc04aa21..824671cf494a 100644
> --- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> @@ -82,6 +82,7 @@ struct adc_tm5_data {
>   	const u32	full_scale_code_volt;
>   	unsigned int	*decimation;
>   	unsigned int	*hw_settle;
> +	bool		is_hc;
>   };
>   
>   enum adc_tm5_cal_method {
> @@ -146,6 +147,14 @@ static const struct adc_tm5_data adc_tm5_data_pmic = {
>   					 64000, 128000 },
>   };
>   
> +static const struct adc_tm5_data adc_tm_hc_data_pmic = {
> +	.full_scale_code_volt = 0x70e4,
> +	.decimation = (unsigned int []) { 256, 512, 1024 },
> +	.hw_settle = (unsigned int []) { 0, 100, 200, 300, 400, 500, 600, 700,
> +					 1000, 2000, 4000, 6000, 8000, 10000 },
> +	.is_hc = true,
> +};
> +
>   static int adc_tm5_read(struct adc_tm5_chip *adc_tm, u16 offset, u8 *data, int len)
>   {
>   	return regmap_bulk_read(adc_tm->regmap, adc_tm->base + offset, data, len);
> @@ -375,6 +384,29 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
>   	return 0;
>   }
>   
> +static int adc_tm_hc_init(struct adc_tm5_chip *chip)
> +{
> +	unsigned int i;
> +	u8 buf[2];
> +	int ret;
> +
> +	for (i = 0; i < chip->nchannels; i++) {
> +		if (chip->channels[i].channel >= ADC_TM5_NUM_CHANNELS) {
> +			dev_err(chip->dev, "Invalid channel %d\n", chip->channels[i].channel);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	buf[0] = chip->decimation;
> +	buf[1] = chip->avg_samples | ADC_TM5_FAST_AVG_EN;
> +
> +	ret = adc_tm5_write(chip, ADC_TM5_ADC_DIG_PARAM, buf, sizeof(buf));
> +	if (ret)
> +		dev_err(chip->dev, "block write failed: %d\n", ret);
> +
> +	return ret;
> +}
> +
>   static int adc_tm5_init(struct adc_tm5_chip *chip)
>   {
>   	u8 buf[4], channels_available;
> @@ -591,7 +623,10 @@ static int adc_tm5_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	ret = adc_tm5_init(adc_tm);
> +	if (adc_tm->data->is_hc)
> +		ret = adc_tm_hc_init(adc_tm);
> +	else
> +		ret = adc_tm5_init(adc_tm);
>   	if (ret) {
>   		dev_err(dev, "adc-tm init failed\n");
>   		return ret;
> @@ -612,6 +647,10 @@ static const struct of_device_id adc_tm5_match_table[] = {
>   		.compatible = "qcom,spmi-adc-tm5",
>   		.data = &adc_tm5_data_pmic,
>   	},
> +	{
> +		.compatible = "qcom,spmi-adc-tm-hc",
> +		.data = &adc_tm_hc_data_pmic,
> +	},
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, adc_tm5_match_table);
> 


-- 
With best wishes
Dmitry
