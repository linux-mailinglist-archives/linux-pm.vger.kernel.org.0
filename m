Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBB66FC20B
	for <lists+linux-pm@lfdr.de>; Tue,  9 May 2023 10:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbjEIIwK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 May 2023 04:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbjEIIwA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2023 04:52:00 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C645C40E4
        for <linux-pm@vger.kernel.org>; Tue,  9 May 2023 01:51:56 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ad9f2926adso7324921fa.1
        for <linux-pm@vger.kernel.org>; Tue, 09 May 2023 01:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683622315; x=1686214315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=19BwZJ3ObJn7Z1ZOsURLi5l7RicvRJrnIuipsz3tVTw=;
        b=l3021InFTflg/94FVtizfc1fmPQdPA7orZ1VMO4zPSRk18gauIf4O9Cw3SQgqJqN+a
         HOk4wqHsANSLrcqoTG538zDKYnrj5+mgex5w3AlN11CM0hbbEzqpkEsaMeZHCL4ti7/O
         0lmhf/RMQ6fceJtqoGYjReEc5tYFVgeFZiR0C4C3gU+hqcL25MOVvihavnlD0xn4dd6b
         e6dJWwXYmFqveRdabmj2FywMRTa8AmzWOfi97ojZMMDMQJt9/TNxik/2ysN6TMDInnIg
         wtN2UnkDUTV/5QDbpZG7ekqkxnn4SmOw0dqg+V8+NjKSJkoAjUlxl+FX3IiD8qdmxkrY
         amhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683622315; x=1686214315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19BwZJ3ObJn7Z1ZOsURLi5l7RicvRJrnIuipsz3tVTw=;
        b=Kea8INBEWS17+F8+8JWJp/qVVny23Hk+qqoO+/mb9yn+AZ6SCfE97Z+JUdKPWD0QUT
         4EIEU8BCETA0qxs9xCySwswQWlGQafYATFZGnEycCENFuzZBn7GgB3bJJ0fuM2H0aisG
         bJxUrUnWJYNk2QNf5vm03yqurQVC0ch2d04fbc69tbuDMgHzRYOxVQD/fyh/VnSumLG0
         D+Lf+/1wdifxmiY5eT1ZqS+HynZ5C4QNQklW3ePTzHrj975YSqzGf7eqydMOlydubu3Z
         nKcsa20KKYYqBjrNORSnBw0WwlOSF+z8PWKYQoWQdjUM4A/tAs33eF/V+KkOFzMAVrEy
         wRgQ==
X-Gm-Message-State: AC+VfDzJGHOyTxdF/+d8RoPSNQay1bHSH5dOObVBbmj7uBUzIKfYk+Vp
        8qQ9CKPOyh0jfr6RB01hxjH3QQ==
X-Google-Smtp-Source: ACHHUZ7yUzlGRD99w8NcouR9YVMZW9unlqvDyFHM+B6cmW3rsbhc9VmE1imaUwH37cOf3qL+6AQ5aQ==
X-Received: by 2002:a2e:8696:0:b0:2ac:8bc1:9cb1 with SMTP id l22-20020a2e8696000000b002ac8bc19cb1mr586856lji.42.1683622315006;
        Tue, 09 May 2023 01:51:55 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id u21-20020a2ea175000000b002adab10a1fdsm34284ljl.117.2023.05.09.01.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 01:51:54 -0700 (PDT)
Message-ID: <27693873-8993-38a0-19bd-7696c5974932@linaro.org>
Date:   Tue, 9 May 2023 10:51:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/6] power: reset: qcom-pon: add support for pm8941-pon
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230508160446.2374438-1-dmitry.baryshkov@linaro.org>
 <20230508160446.2374438-3-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230508160446.2374438-3-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8.05.2023 18:04, Dmitry Baryshkov wrote:
> For PM8941 we don't have a defined field to store the reset reason.
> Support wrapping pwrkey and resin, but without writing the reset
> reason.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/power/reset/qcom-pon.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
> index 16bc01738be9..d42475bc0ee6 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -17,6 +17,8 @@
>  #define GEN1_REASON_SHIFT		2
>  #define GEN2_REASON_SHIFT		1
>  
> +#define NO_REASON_SHIFT			0
> +
>  struct pm8916_pon {
>  	struct device *dev;
>  	struct regmap *regmap;
> @@ -45,6 +47,7 @@ static int pm8916_reboot_mode_write(struct reboot_mode_driver *reboot,
>  static int pm8916_pon_probe(struct platform_device *pdev)
>  {
>  	struct pm8916_pon *pon;
> +	long reason_shift;
>  	int error;
>  
>  	pon = devm_kzalloc(&pdev->dev, sizeof(*pon), GFP_KERNEL);
> @@ -64,13 +67,17 @@ static int pm8916_pon_probe(struct platform_device *pdev)
>  	if (error)
>  		return error;
>  
> -	pon->reboot_mode.dev = &pdev->dev;
> -	pon->reason_shift = (long)of_device_get_match_data(&pdev->dev);
> -	pon->reboot_mode.write = pm8916_reboot_mode_write;
> -	error = devm_reboot_mode_register(&pdev->dev, &pon->reboot_mode);
> -	if (error) {
> -		dev_err(&pdev->dev, "can't register reboot mode\n");
> -		return error;
> +	reason_shift = (long)of_device_get_match_data(&pdev->dev);
> +
> +	if (reason_shift != NO_REASON_SHIFT) {
> +		pon->reboot_mode.dev = &pdev->dev;
> +		pon->reason_shift = reason_shift;
> +		pon->reboot_mode.write = pm8916_reboot_mode_write;
> +		error = devm_reboot_mode_register(&pdev->dev, &pon->reboot_mode);
> +		if (error) {
> +			dev_err(&pdev->dev, "can't register reboot mode\n");
> +			return error;
> +		}
>  	}
>  
>  	platform_set_drvdata(pdev, pon);
> @@ -80,6 +87,7 @@ static int pm8916_pon_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id pm8916_pon_id_table[] = {
>  	{ .compatible = "qcom,pm8916-pon", .data = (void *)GEN1_REASON_SHIFT },
> +	{ .compatible = "qcom,pm8941-pon", .data = (void *)NO_REASON_SHIFT },
>  	{ .compatible = "qcom,pms405-pon", .data = (void *)GEN1_REASON_SHIFT },
>  	{ .compatible = "qcom,pm8998-pon", .data = (void *)GEN2_REASON_SHIFT },
>  	{ .compatible = "qcom,pmk8350-pon", .data = (void *)GEN2_REASON_SHIFT },
