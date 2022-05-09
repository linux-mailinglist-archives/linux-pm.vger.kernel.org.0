Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A250E51F93B
	for <lists+linux-pm@lfdr.de>; Mon,  9 May 2022 12:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiEIKDa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 May 2022 06:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbiEIJ7n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2022 05:59:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155F6185CB4
        for <linux-pm@vger.kernel.org>; Mon,  9 May 2022 02:55:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m2-20020a1ca302000000b003943bc63f98so7936691wme.4
        for <linux-pm@vger.kernel.org>; Mon, 09 May 2022 02:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fTZl9li+x4E+ZMkb+1EuzQ5XqQ0uCYrgvF8zYcW0d0c=;
        b=mx/2R/N2sTVoK8Icso1pvqn09JW8GM4oAs6CqLC0JQxdqrC5QEuYMN5DZjNIeiSS3h
         XsgtH6KoOUK2nwsrbNVqbNaQuFSUtLoaslk10nlkbJ+iuDAmR9urL/SFo0JLZY5j60cY
         gV3D2K7YVLgpBlKdm25ahVMozs+cn9JccMGvG4frQi/SdWhNqDDojBoh5fJytCKvtL1s
         u4rmqoM2JNY31EweBnRtZ3HoQZQnNNtGkNwqlsvtvF+oFNZ4BMkABaEde1GR2iTDGXjt
         0JS0TIvm6OZK3wtI+gSee1C0qpjNe/Y1WpuNn8U5wHu8bYVoIeP3xKih5BAAAxh8Fdyl
         D7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fTZl9li+x4E+ZMkb+1EuzQ5XqQ0uCYrgvF8zYcW0d0c=;
        b=KrB3TRNIUrn1YBX5G068+gHgzU5Lg3XgmS8zx0KCQXlGpUrtAZXgRRMg5xCOL9QbI7
         MpI0iQ56Bi4wfdK6w2n369mREslHXG+s+fVzrWJYbfa0A1a13H6tJt90DOcPYP8Z7oqv
         L7yzoBINt6zjVBYJ2AZ0iojZikEj/r6TpwaNe6FO/b1mA+TrnUxnQTlUYsfDnfeA/WFl
         r//iXQCUY8X7m7ZiTkrybFbf9qh9L8ZDaa4UVXoZqU+syeWfufbOgocL2x4TaEowAl8d
         xqkIKLrwSf7KICQZcQ2YzEK+ESXBiojFAQZXboHdB+kBamNRErFbvjtyJw25IuFtVlvx
         8wSQ==
X-Gm-Message-State: AOAM533hLkYtt3CNHrrHiSuG3uHM4pj2IGupPsz8wq7AWaMs1EGl31m3
        7UnrqU0NkPxmRoGpJNvm9v+D5Q==
X-Google-Smtp-Source: ABdhPJwStJBEcYoQiKZt2Nkyd76Qkro0hDQeYTwRHF1MlLZDdv2o0spa5c2dIAxExr/EN9XfsuI4Xw==
X-Received: by 2002:a05:600c:154d:b0:394:8d64:9166 with SMTP id f13-20020a05600c154d00b003948d649166mr5682459wmg.102.1652090122532;
        Mon, 09 May 2022 02:55:22 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id l15-20020a05600012cf00b0020c547f75easm10906563wrx.101.2022.05.09.02.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 02:55:21 -0700 (PDT)
Message-ID: <486c5c72-812a-d4ea-0c5a-49783bdc4a1f@linaro.org>
Date:   Mon, 9 May 2022 11:55:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1] thermal: imx: Update critical temp threshold
Content-Language: en-US
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Amit Kucheria <amitk@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Tim Harvey <tharvey@gateworks.com>,
        Jon Nettleton <jon@solid-run.com>
References: <20220420091300.179753-1-francesco.dolcini@toradex.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220420091300.179753-1-francesco.dolcini@toradex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Francesco,


On 20/04/2022 11:13, Francesco Dolcini wrote:
> Increase the critical temperature threshold to the datasheet defined
> value according to the temperature grade of the SoC, increasing the
> actual critical temperature value of 5 degrees.
> 
> Without this change the emergency shutdown will trigger earlier then
> required affecting applications that are expected to be working on this
> close to the limit, but yet valid, temperature range.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> 
> Not sure if there is an alternative to this patch, the critical threshold seems
> to be read-only and it is not possible to just change it from user space that
> would be my preferred solution.
> 
> According to the original discussion [1] the reasoning was the following:
> 
> On Tue, Jul 28, 2015 at 4:50 PM, Tim Harvey <tharvey@gateworks.com> wrote:
>> Yes - the purpose of lowering the critical threshold from the hardware
>> default is to allow Linux to shutdown more cleanly.
> 
> But I do not understand it.

Shawn, Sascha ? any comment ?

> [1] https://lore.kernel.org/all/CAJ+vNU1PQZa9KoCU9o_ws6jAAjhGVJby-1P583SVejT5TrAFTQ@mail.gmail.com/
> 
> ---
>   drivers/thermal/imx_thermal.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 16663373b682..75a631a23e61 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -504,10 +504,10 @@ static void imx_init_temp_grade(struct platform_device *pdev, u32 ocotp_mem0)
>   	}
>   
>   	/*
> -	 * Set the critical trip point at 5 °C under max
> +	 * Set the critical trip point at max
>   	 * Set the passive trip point at 10 °C under max (changeable via sysfs)
>   	 */
> -	data->temp_critical = data->temp_max - (1000 * 5);
> +	data->temp_critical = data->temp_max;
>   	data->temp_passive = data->temp_max - (1000 * 10);
>   }
>   


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
