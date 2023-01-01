Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF4565AB8D
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jan 2023 21:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjAAU0X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Jan 2023 15:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjAAU0W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Jan 2023 15:26:22 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF088263D
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 12:26:20 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id fc4so62598836ejc.12
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 12:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TvLuMLYG5Lyi3eSpq/moHp/w6kLksJAaK/i2ILTJE14=;
        b=B51Jm9Q7/NgbCdlTnvK/u8ZITzOSWeMynDS2qj691R5fLIbFrrL0vOm+Kco3Xsc+FI
         UW5QPdLQYqKt5B/xJhnzgLmRQ8gVU5sZbDjwM301UYQCpWxcGO9lqvyaWq1xIeMJ/AQr
         JY1YVHvnrkqcujSjUsEwYR0w8pPYD/vKZ0cRyJ6Cvd0Dl+SlQ/4+KiWng+VvYmEPXhC/
         eSNdjvIvKkFZDI11N5jpCfN1KKKOWjYXe/NE4z6xJabJuLJxB+lGDBCeCeIFLOi2BzBa
         0xbb09UmCc38qzjRy1v76ATAlLf9Drkh/Py1m5uEGYtCk6uCQ1fwlRJFifWHKGjo/MXV
         AOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvLuMLYG5Lyi3eSpq/moHp/w6kLksJAaK/i2ILTJE14=;
        b=NppCPmMTE+VehuE2iKZ4tvo3SFPXHK12IuQKAjerdMtgb31W7itOq1i4ih8N8I39v4
         /xE/SEpkY/GiE6bHImGLhsdBGEv8XKzFS+bjGqaeVKG8aHcaNrH4v1igZYk7EgTQxrFs
         IWBJUvVLTL3W8FCBipBs3SMGGJGPeAj6pN3F90oaB+MYwbVkstDTuQKHnzruR8XN1qOU
         5TXN++rNmCVIIDGZ1XX8bNe3iDFNGotY0F7zHsQwJb+d2UDm6XuhuguhWLgYi2vddHSQ
         bmvigZ3n6Zk2YsIsHyscWSOFgNh3OUueUnTSmXVkb9D2fsGwzEk9r9nBm2NWLIujNU9M
         2FdQ==
X-Gm-Message-State: AFqh2krVUUSDf/8DpBFWGQD5BxtjVqfvvFdKTdulgVs+Ql9jyQ/faMw7
        kj2cdzQx91cEbTXuBrc6JpRNLA==
X-Google-Smtp-Source: AMrXdXtJcjaTSfVHu5GSdVjTUsJ3dGhzRjDjghQ1EuwL12kz2e0Yr6QQ17hyhSsf4ES6LWsH+JgOlg==
X-Received: by 2002:a17:906:944c:b0:7c0:bd68:ce30 with SMTP id z12-20020a170906944c00b007c0bd68ce30mr32903402ejx.54.1672604779538;
        Sun, 01 Jan 2023 12:26:19 -0800 (PST)
Received: from ?IPV6:2001:1c06:2302:5600:5825:7f8d:c381:cef4? (2001-1c06-2302-5600-5825-7f8d-c381-cef4.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:5825:7f8d:c381:cef4])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906319100b0084610118010sm12163168ejy.184.2023.01.01.12.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jan 2023 12:26:19 -0800 (PST)
Message-ID: <46045e89-e1c4-535d-7ed9-6727e90046f9@linaro.org>
Date:   Sun, 1 Jan 2023 20:26:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 13/20] thermal/drivers/tsens: Drop single-cell code for
 msm8939
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Shawn Guo <shawn.guo@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
 <20230101194034.831222-14-dmitry.baryshkov@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230101194034.831222-14-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/01/2023 19:40, Dmitry Baryshkov wrote:
> There is no dtsi file for msm8939 in the kernel sources. Drop the
> compatibility with unofficial dtsi and remove support for handling the
> single-cell calibration data on msm8939.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/thermal/qcom/tsens-v0_1.c | 26 +-------------------------
>   1 file changed, 1 insertion(+), 25 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 9488416b568c..e89c6f39a3ae 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -150,30 +150,6 @@ static int calibrate_8916(struct tsens_priv *priv)
>   	return 0;
>   }
>   
> -static int calibrate_8939(struct tsens_priv *priv)
> -{
> -	u32 p1[10], p2[10];
> -	u32 *qfprom_cdata;
> -	int mode, ret;
> -
> -	ret = tsens_calibrate_common(priv);
> -	if (!ret)
> -		return 0;
> -
> -	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
> -	if (IS_ERR(qfprom_cdata))
> -		return PTR_ERR(qfprom_cdata);
> -
> -	mode = tsens_read_calibration_legacy(priv, &tsens_8939_nvmem,
> -					     p1, p2,
> -					     qfprom_cdata, NULL);
> -
> -	compute_intercept_slope(priv, p1, p2, mode);
> -	kfree(qfprom_cdata);
> -
> -	return 0;
> -}
> -
>   static void fixup_8974_points(int mode, u32 *p1, u32 *p2)
>   {
>   	int i;
> @@ -354,7 +330,7 @@ struct tsens_plat_data data_8916 = {
>   
>   static const struct tsens_ops ops_8939 = {
>   	.init		= init_8939,
> -	.calibrate	= calibrate_8939,
> +	.calibrate	= tsens_calibrate_common,
>   	.get_temp	= get_temp_common,
>   };
>   

Thanks for sending me dtsi code to accompany this

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
