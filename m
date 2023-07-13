Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E8675220E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jul 2023 15:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGMNA0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jul 2023 09:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjGMNAZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2023 09:00:25 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107C71BF2
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 06:00:21 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso5849025e9.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 06:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689253219; x=1691845219;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BlrjL2Qse3Qh0f0nxQtFO3PHH8HvzbeF2y5rIxOXdos=;
        b=UrH2359fSWdzvyfUZqVcgo6QwELKcnoSTo4ZyfHUcOl/8YTMeWPp0UKTGcBXNHDePv
         8ibW/AKfM3j3zr4lybJwxbPz5m+Of59qKvYAP9tEQMKzEE3z5tb14lTX6cZRHuAYcP8L
         GOz5NHfuM8TfPJX56GtaRelExnfN/Y0tLrZ9uN7im5wgt3SXD1qzGYfufHRR5chIhHKC
         gXB5FxHCCDMm/6DpcSaFt7IpTP5PpCnwFg9+JFvrSia12zvj7t01FLS1wRkcMWMzE4K1
         lfMXdKlQsYoljqEPP4yXdyMEKOoEenLBPbDKFT2uacGFKgia7PxflhfJfwJt7Q1GtEvY
         19eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689253219; x=1691845219;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlrjL2Qse3Qh0f0nxQtFO3PHH8HvzbeF2y5rIxOXdos=;
        b=GCR1vcx3QeBpbI9ZZCqfCjnSxogBwoWXJDhoPMg9iZClparkQh7xhMqdinGo+xKNK1
         ARzrZ2Gy1sOcSIzHz0Mo0XuHgeoZnl6zvi3UGd2sy3+uRxd3zUVAee6oDMLdhIII/fXu
         pj2x0Nh5AFQDUoprx3L723VCWEYtF0W7lu/wv1z4orZZNNIZckGqIFL74d9xqVXOc5st
         2RoboSKvompwckFdMPzs1pPAvf3638zjkjXhL5+lIGgVe/JQG2cinV6KC9hKi4/tswJS
         0883yKUpwvdkbylU5B0R4EWY8hmY/wkSTp0F4vYBfc82C54g1MX0xB5oWxrvFR4FBM2x
         tDTw==
X-Gm-Message-State: ABy/qLaXhUmJVfRLgK5Qt1GCAC8FTkanlJMQBY7rIB+o47GFiELuf+1/
        qu2l+386v38IQTXYG+CWJJuMQw==
X-Google-Smtp-Source: APBJJlGW4qBAshsKSJMXvfuhab1DNGBKrv8tQ12EQpoccoqOHZbA5T6z6/EJeQ0anX2QyFBgyPQqSQ==
X-Received: by 2002:a1c:f213:0:b0:3f9:b19c:aab4 with SMTP id s19-20020a1cf213000000b003f9b19caab4mr1235107wmc.6.1689253219433;
        Thu, 13 Jul 2023 06:00:19 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id o7-20020a5d6707000000b002c70ce264bfsm7924515wru.76.2023.07.13.06.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 06:00:19 -0700 (PDT)
Message-ID: <6e8b64f1-a285-227c-c335-c0dd0e683b50@linaro.org>
Date:   Thu, 13 Jul 2023 15:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] thermal/of: Add error information printing for
 devm_thermal_of_zone_register()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230711124513.47771-1-frank.li@vivo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230711124513.47771-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/07/2023 14:45, Yangtao Li wrote:
> Ensure that all error handling branches print error information. In this
> way, when this function fails, the upper-layer functions can directly
> return an error code without missing debugging information. Otherwise,
> the error message will be printed redundantly or missing.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   drivers/thermal/thermal_of.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 6fb14e521197..8ce231f7639a 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -583,11 +583,14 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
>   
>   	ptr = devres_alloc(devm_thermal_of_zone_release, sizeof(*ptr),
>   			   GFP_KERNEL);
> -	if (!ptr)
> +	if (!ptr) {
> +		dev_err(dev, "Failed to allocate device resource data\n");
>   		return ERR_PTR(-ENOMEM);
> +	}
>   
>   	tzd = thermal_of_zone_register(dev->of_node, sensor_id, data, ops);
>   	if (IS_ERR(tzd)) {
> +		dev_err(dev, "Failed to register thermal zone: %d\n", PTR_ERR(tzd));

Not sure if having this error is useful as we already have an error 
showing up with the thermal_of_zone_register() function

>   		devres_free(ptr);
>   		return tzd;
>   	}

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

