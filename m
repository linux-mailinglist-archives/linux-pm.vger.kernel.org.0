Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A96E607E42
	for <lists+linux-pm@lfdr.de>; Fri, 21 Oct 2022 20:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJUS2r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Oct 2022 14:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiJUS2p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2022 14:28:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90EF285B5C
        for <linux-pm@vger.kernel.org>; Fri, 21 Oct 2022 11:28:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t16so9069612edd.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Oct 2022 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMTJgtnYeK5/Y6Namaf3IIdsfnio66yHLVROtRxsJ8E=;
        b=Dk1E3ocdbXqDwZRpA+L8NihMfxZNkhVOuZEN2gRi5+fvZDLCvoGsVgac6dRVJVrWBx
         mLsJ+ZhnTHH/ekJsrsFuN3mkQSu5QjSlywIRgDNJBnkBVRGwbt0xz/wwm8yjxHav+Hjv
         MOlrNh4Vgb93vRP/Bg+yLJWPeG4xXSwiUEphNFU0lpvaRuPsXVib0crtdmGnKkukTWey
         01Dnb8ns/9V6O6kkXfOh/Nv8ei3oU++vAOb55TBCkhjLWq7+AYO6SzuBL6bdTioOSUVJ
         mHA5cpkMO9vHf4K7OoJiEqLQAcLRAw+4IwcrO6/umFObPbxLw/aVy4C3OCrMIrp//7I1
         Bw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMTJgtnYeK5/Y6Namaf3IIdsfnio66yHLVROtRxsJ8E=;
        b=dID4kUKPj8ynU2c5DHf7zP8C4vxoK24FQ8OCSw0NzeRTE6hA17N14r0BRMcmf1p8B4
         UGZTtaiolk9PhcJeofUnRzqH51xPx/wtoY6g9n6RyDDUYOMsHNwBd//NPvy4oU7d8k4J
         lfmu5hCUg1xyie4T19na7Rs5uHCN6NXNi0nOO0jiQjyAs0dEIVH/TeV4Cvm1q9v7B/0w
         hF/MgRoXqElJQSQcuzhMnQT9KFlxBKBpuk+9xC6HMYmCR63axPrHGdKSKczsbezwhvjn
         DiytFYaxfLoEWnf7EInB+SEFn9mlpgYOtbliQ6Ikd61fOkZgA7oWh/6nPRgBgMvDiY8S
         QJEA==
X-Gm-Message-State: ACrzQf0F3iOoNxt2giIUsdMC4+ZjaWa+rSMiXnjjUESwvCjg11BxKy6f
        9pvc/9XEqLZ6b+exzJtHAIxfwg==
X-Google-Smtp-Source: AMsMyM7/9n1jVn2Dq1Tehgwu6CuK76iZQUV1L5MQwXAkI3GqLxbvuy1I6Aj4V4XmIRLcizSgBKqXug==
X-Received: by 2002:a17:907:7250:b0:791:9093:47f7 with SMTP id ds16-20020a170907725000b00791909347f7mr16698780ejc.278.1666376918211;
        Fri, 21 Oct 2022 11:28:38 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:25b:e73e:85eb:ae6e? ([2a05:6e02:1041:c10:25b:e73e:85eb:ae6e])
        by smtp.googlemail.com with ESMTPSA id n26-20020a056402061a00b0045c010d0584sm13886137edv.47.2022.10.21.11.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 11:28:37 -0700 (PDT)
Message-ID: <53c5bd41-ccd0-c964-ef23-cb86f8f32de4@linaro.org>
Date:   Fri, 21 Oct 2022 20:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH 1/2] thermal: qcom: tsens: init debugfs only with
 successful probe
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thara Gopinath <thara.gopinath@linaro.org>
References: <20221021181906.16647-1-ansuelsmth@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221021181906.16647-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/10/2022 20:19, Christian Marangi wrote:
> calibrate and tsens_register can fail or PROBE_DEFER. This will cause a
> double or a wrong init of the debugfs information. Init debugfs only
> with successful probe fixing warning about directory already present.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Acked-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>   drivers/thermal/qcom/tsens.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index b1b10005fb28..cc2965b8d409 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -918,8 +918,6 @@ int __init init_common(struct tsens_priv *priv)
>   	if (tsens_version(priv) >= VER_0_1)
>   		tsens_enable_irq(priv);
>   
> -	tsens_debug_init(op);
> -
>   err_put_device:
>   	put_device(&op->dev);
>   	return ret;
> @@ -1153,7 +1151,12 @@ static int tsens_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> -	return tsens_register(priv);
> +	ret = tsens_register(priv);
> +

extra line

> +	if (!ret)
> +		tsens_debug_init(pdev);
> +
> +	return ret;
>   }
>   
>   static int tsens_remove(struct platform_device *pdev)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
