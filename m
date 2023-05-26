Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD3171222A
	for <lists+linux-pm@lfdr.de>; Fri, 26 May 2023 10:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbjEZI1o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 May 2023 04:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjEZI1n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 May 2023 04:27:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE44D8
        for <linux-pm@vger.kernel.org>; Fri, 26 May 2023 01:27:42 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f603d4bc5bso5267705e9.3
        for <linux-pm@vger.kernel.org>; Fri, 26 May 2023 01:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685089660; x=1687681660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gN48o2+p7aZtsqqZOKCgJkMAQgtVzXUNifpR/gjpQl4=;
        b=Fmhd+P0G9VuCh0HKkc2052Qu7/LE0E4TvU6tby4vDzZoZZfYs3EELfOpDGbETeXefY
         BnTvqu0+SHsNir45oP7a12v9Bs3ypK6KWmVgKx6zZnqE0wlipWd9VuSLeiuN3H2glBwM
         r1m0MX74of2mX5k1vyDq8BHVfsGcz73w1BnwR8FTxIfTRD0z8Z0CZwlhwXCt8SmN3a68
         /Gg7mgz3tHIykqXhr+FiGEWFN9jpeddjhRzDJamLLiFcPryMIPiIu+tep2KGMrFNNtZe
         0rxO87/Zj2SSI5iMqd0aCQOmw4E6LG4Xlvx/NR9dpWJC/isQsADz+EjATk9QD3HGSSCJ
         0qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685089660; x=1687681660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gN48o2+p7aZtsqqZOKCgJkMAQgtVzXUNifpR/gjpQl4=;
        b=MThFokCpI6Mt7QmNMcg9NPkjFqnU2HNiDOO1J/UsJZq0fCF19a5y01QMz5wpr8Jb21
         hXqpthe4U/+XRuRvItnnF6MLSpPtfli2CqrP6WXQUxWyWva9CkPu448PjJQqY+GVV1FH
         SFWpul3pKUmbt5wcKCnJNmUvO3BKq4WgnjWzLxmoBCEEi2TRD4gDFK0N5yiQjh3S9doM
         5somLkY8QZiiNeERydN/rzWqwagiQBFxuYz46fgscNO/QhMmjDnogxXRB6AdLS9ZCGas
         EjS8Qi+es1yx6jvULA1ZxwzwAA6iR3P9SkrqlYmw6NMZzH3mYnEG1iyugUhy/EHPyMO4
         uFgA==
X-Gm-Message-State: AC+VfDyi8thtjRQvIN0RMNTz/VmNjZUoFuxtl/82f1Pb6MuW9FgzVrws
        aJb9shUAC6N5uC06l975wMMsZz7aKDCm1PGVFnU=
X-Google-Smtp-Source: ACHHUZ6Z1cK32XZ3gr8PVujnMwDDsDSJja39N9auJcm/ggfYKYDFTMBwx7+H/NmqmTDZX1+P93lJQQ==
X-Received: by 2002:a5d:4851:0:b0:306:4273:9efc with SMTP id n17-20020a5d4851000000b0030642739efcmr714329wrs.40.1685089660523;
        Fri, 26 May 2023 01:27:40 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5aef:8608:89d7:7961? ([2a05:6e02:1041:c10:5aef:8608:89d7:7961])
        by smtp.googlemail.com with ESMTPSA id z16-20020adfe550000000b003063a92bbf5sm4357978wrm.70.2023.05.26.01.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 01:27:40 -0700 (PDT)
Message-ID: <fb558491-9906-fb3a-60c5-349cb4210695@linaro.org>
Date:   Fri, 26 May 2023 10:27:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/3] thermal: hook in with reboot and crash
Content-Language: en-US
To:     Eduardo Valentin <evalenti@kernel.org>, rafael@kernel.org,
        linux-pm@vger.kernel.org
Cc:     Eduardo Valentin <eduval@amazon.com>
References: <20230525211655.627415-1-evalenti@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230525211655.627415-1-evalenti@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi,

On 25/05/2023 23:16, Eduardo Valentin wrote:
> From: Eduardo Valentin <eduval@amazon.com>
> 
> Hello,
> 
> This small series of changes teaches thermal core about
> reboot and crash callbacks. The intention is to have the core
> to get notified and the pass in the event to thermal governors
> that are willing to perform actions during reboot or crash events.
> The thermal workers will be teared down in the process too.

What problem does it solve?


> There is no code dependency this series was built on top of:
> https://lkml.org/lkml/2023/5/18/1207
> 
> Separate governor changes will be sent in another series.
> 
> BR,
> 
> Eduardo Valentin (3):
>    thermal: core: introduce governor .reboot_prepare()
>    thermal: core: register reboot nb
>    thermal: core: register a crash callback
> 
>   drivers/thermal/thermal_core.c | 54 ++++++++++++++++++++++++++++++++++
>   include/linux/thermal.h        |  4 +++
>   2 files changed, 58 insertions(+)
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

