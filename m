Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE90528120
	for <lists+linux-pm@lfdr.de>; Mon, 16 May 2022 11:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiEPJ66 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 May 2022 05:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiEPJ65 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 May 2022 05:58:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548C126C5
        for <linux-pm@vger.kernel.org>; Mon, 16 May 2022 02:58:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t6so19773785wra.4
        for <linux-pm@vger.kernel.org>; Mon, 16 May 2022 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=awMikNuwzVLC+pmZZU3cfGp/NS4iflwUhbb4vdr1BwU=;
        b=TGkJGxkuZAfVOWbjyHTHXuRlzDFJ/R/VFXCAEzftXtlyUp9DvQKtq6YhoD14PyEI5f
         YQxuyM/gkfWDE18Jwy5tcdp+9E6kGKsAQS4D5yUI3k1eSSdwPxs0fOUtpmCNqUiRyHNd
         xPm5qxLUKT7QFJ+UmxHZ44NYuFIrLD4jgj9TtbZBuanEzqkfRA5So8Ri/69zGst1OjAN
         Bnx1VTUKSiZVNcL0bEjj1/vAgrLQVdr++gN2Uz3hI1MBUv6QesxshBj020Lg4TA0XDMm
         PB2VtQgKAcDKmP7AZLIsjnDpVM1fjopxboadRalpbuQXarNcdhast8vJT4uS6YOeFbQN
         Vogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=awMikNuwzVLC+pmZZU3cfGp/NS4iflwUhbb4vdr1BwU=;
        b=szmbrq7JOKaxYE2LTKFYTYabgxEad6WsaW+S6flPM8RBV1jZqkTJtQc8xXXpeL2yGv
         1B/DpjvoLTa2zC5R+jlwyC4CybhkRb+DIxgff1GcaNgL28w7mGq4hp17pXK5ziBhgYRs
         lC59kC5Pa0z3drBBsWWbqghTRITjtXW3zMGkqeLuiRlY6vJFgoelr70G242dUII0jlaS
         uEDaDsDNpvYZZN9jBSncHOPV2jT8nfZjcqfCrCW8+4gPzsyulc53V9k8B0ttS1e5FhzJ
         uZ5SRBLejDV5KmxXQAWZryxe++dDhboj8cijGO5vBrQTsiknaxta/h1fMtgtZOEd6uGU
         lSYQ==
X-Gm-Message-State: AOAM530S4p8n86Nz/YtuxOBqE/0SRSAjVTeqcYlIuWeGV6VpwdZwfTG4
        loSyRr0SF0H65Lajnp8AOnDmlQ==
X-Google-Smtp-Source: ABdhPJxKlfFTUQWpLCHDwKBtfdXNaL6242t1PprpAeei/WKMmBWjox0VQEBz/nuIn6pjuYl3HMJ2sg==
X-Received: by 2002:a05:6000:1acd:b0:20c:7201:9267 with SMTP id i13-20020a0560001acd00b0020c72019267mr13455532wry.41.1652695131910;
        Mon, 16 May 2022 02:58:51 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:b464:e524:6a1d:33d0? ([2a01:e34:ed2f:f020:b464:e524:6a1d:33d0])
        by smtp.googlemail.com with ESMTPSA id g9-20020adfbc89000000b0020c5253d909sm9676582wrh.85.2022.05.16.02.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 02:58:51 -0700 (PDT)
Message-ID: <af322b93-fd61-fed6-7880-75b5ad0cb65b@linaro.org>
Date:   Mon, 16 May 2022 11:58:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] thermal: imx_sc_thermal: Fix refcount leak in
 imx_sc_thermal_probe
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220516073151.25918-1-linmq006@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220516073151.25918-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/05/2022 09:31, Miaoqian Lin wrote:
> of_find_node_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: e20db70dba1c ("thermal: imx_sc: add i.MX system controller thermal support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   drivers/thermal/imx_sc_thermal.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> index 8d76dbfde6a9..1ab854c228e5 100644
> --- a/drivers/thermal/imx_sc_thermal.c
> +++ b/drivers/thermal/imx_sc_thermal.c
> @@ -95,6 +95,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
>   		if (!sensor) {
>   			of_node_put(child);
>   			of_node_put(sensor_np);
> +			of_node_put(np);
>   			return -ENOMEM;
>   		}


Please use goto statement

> @@ -125,6 +126,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
>   	}
>   
>   	of_node_put(sensor_np);
> +	of_node_put(np);
>   
>   	return ret;
>   }


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
