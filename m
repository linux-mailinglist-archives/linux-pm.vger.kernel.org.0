Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5A7435C44
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 09:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhJUHpb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 03:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhJUHpI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 03:45:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856D5C06177A
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 00:41:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u18so2999645wrg.5
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 00:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2EAPuvHsPP3f5ClzSTyTYXJizxZDKs+jvkEQB91VoT0=;
        b=HIClI+abeSKf9gnRDN7jnJ7R0FBXnxZFRmtoxsyJb9TRKZBymfD/ytN2e2wqFczDSN
         qSg0neIJezM0z/WK599zBl7i1tzhzzF1AIX7lxzCuVxUVH32CqLY2eIwFT6comAVkmgh
         GDoSpBfSEY6S6PfZ5rvOyRVJ3xT05qqGM6xtAcJlxRi4M4xHYJ2jWjg2AsVndWcZ0WvU
         hkC/wIRdxIUL/tJ6B2kcAcm+85Z5uKcPpUeuCudNAssBL4Xn6CsGsOt2+z9/dCb0hCmg
         zj1FwL2jTgj/C26FXmPlStw0O43lgRjT1F7532vOQ4nZVbOstvrf4U2a1LLpAB84kGeW
         Jmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2EAPuvHsPP3f5ClzSTyTYXJizxZDKs+jvkEQB91VoT0=;
        b=HkAfhyeemedjcPfNhRNHPHqZ5TIZeYww9Utzaj9exP8ks+SqUyVXI+zQXnHdAqEULY
         pL3Wya05wkLiqYYDuScVT53bvY7O7J4CG1X24yWHwETId4QfeDRF7lTItXiUXz63ZTrT
         v0EjBxtQehI6jOn9F7lMz0vK7AUGoEzKU3KuUWLY3uTUZ+czvRenPAIwDvnIq3XsW2AE
         teWtHqBSWton0Nvn9mEynG2tWFWVh27gqYCzYcCkaBJwEXItb0iha1UsI1LyPrAIitXb
         KtGseOiBx5JOwp6cNCpFNa2unQpznpd+iIbMM2Qn3KaQ38InIrMzaQxMjWUv72JDycuG
         KTnA==
X-Gm-Message-State: AOAM530sxGbMnwxA7Wl45as/PRym/N5Rl7vRkE9Cely6ppUOrTHhcrWO
        HYJHAOvlPjB6FJApWWNKIazH3g==
X-Google-Smtp-Source: ABdhPJwCQNaCdT9E+tuFGpigx6aiaY6xJEUkDiW1KjnMSjauxDTvX5HeUvd7N9kW1ZClVucvY6PY+g==
X-Received: by 2002:adf:dc0d:: with SMTP id t13mr5233931wri.158.1634802096933;
        Thu, 21 Oct 2021 00:41:36 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2a2c:7ed:66a0:d637? ([2a01:e34:ed2f:f020:2a2c:7ed:66a0:d637])
        by smtp.googlemail.com with ESMTPSA id d128sm8364077wmd.2.2021.10.21.00.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 00:41:36 -0700 (PDT)
Subject: Re: [PATCH v2] thermal: imx: implement runtime PM support
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Petr Benes <petrben@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Amit Kucheria <amitk@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, David Jander <david@protonic.nl>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
References: <20211019130809.21281-1-o.rempel@pengutronix.de>
 <20211020050459.GE16320@pengutronix.de>
 <CAPwXO5b=z1nhQCo55A_XuK-Es2o7TrL2Vj6AkRSXa3Wxh0s8sA@mail.gmail.com>
 <20211021072000.GC2298@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <afeea08b-6130-3c7c-be03-52691d00be57@linaro.org>
Date:   Thu, 21 Oct 2021 09:41:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211021072000.GC2298@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/10/2021 09:20, Oleksij Rempel wrote:
> Hi Petr,
> 
> On Wed, Oct 20, 2021 at 05:53:03PM +0200, Petr Benes wrote:
>> On Wed, 20 Oct 2021 at 07:05, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>>>
>>> Hi Petr and Michal,
>>>
>>> I forgot to add you for v2 in CC. Please test/review this version.
>>
>> Hi Oleksij,
>>
>> It works good. with PM as well as without PM. The only minor issue I found is,
>> that the first temperature reading (when the driver probes) fails. That is
>> (val & soc_data->temp_valid_mask) == 0) holds true. How does
>> pm_runtime_resume_and_get() behave in imx_thermal_probe()?
>> Does it go through imx_thermal_runtime_resume() with usleep_range()?
> 
> On the first temperature reading, the PM and part of HW is not
> initialized. Current probe sequence is racy and has at least following
> issues:
> - thermal_zone_device_register is executed before HW init was completed.
>   It kind of worked before my patch, becaus part of reinit was done by
>   temperature init. It  worked, since the irq_enabled flag was not set,
>   but potentially would run enable_irq() two times if device is
>   overheated on probe.
> - the imx_thermal core is potentially disable after first race
>   condition:
>   CPU0					CPU1
>   thermal_zone_device_register()
> 					imx_get_temp()
>   					irq_enabled == false
> 						power_up
> 						read_temp
>   power_up
>   						power_down
>   irq_enabled = true;
> 
>   ... at this point imx_thermal is powered down for some amount of time,
>   over temperature IRQ will not be triggered for some amount of time.
> 
> - if some part after thermal_zone_device_register() would fail or
>   deferred, the worker polling temperature will run in to NULL pointer.
>   This issue already happened...
> 
> After migrating to runtime PM, one of issues started to be visible even
> on normal conditions.
> I'll send one more patch with reworking probe sequence.

Are you planning to send a v3 with this patch? Or a separate patch?

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
