Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627A466DC18
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jan 2023 12:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbjAQLRm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Jan 2023 06:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbjAQLQr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jan 2023 06:16:47 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D1A33459
        for <linux-pm@vger.kernel.org>; Tue, 17 Jan 2023 03:16:46 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so4437967wmb.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Jan 2023 03:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uvx0PBneh9iKbtx9q1janfRfqJS2S3RLZNTRDoy1mlI=;
        b=zmV9+HlMR9pHCaDSEq2FThDlVhumXypOqzeIrWRQEEmcWw1QMP4yADSmB9wPMmYswQ
         sO4TAn+lK6bLuMzpbhbOLtiH9hnvszIE2sQdtZQf/f94SjQDTxnkxYasiQS40V0wDjrn
         UHPA5UgFV9nmawdF/69wNDNv54nccNGlmjXtmEuNLLSswAkr2otMneK7m2Uptpz4wRl9
         2JW7riZ9j1kjlquYg9gDSrZGC0pa1lpUa/9Y6nfyQXTsTiOgd+Ajj4Cn7x0ndHYvgQ6t
         bvR1ahGBvbqR75+h4LLg5jzy9V7v11k9hyv9mmU+Pj9cJ+EfEQCKfhxErLzdWnaMfJvi
         cb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uvx0PBneh9iKbtx9q1janfRfqJS2S3RLZNTRDoy1mlI=;
        b=8RkOpcKthZ2MQBqGwwgdOCRj2nR/Q5i2B8yNYnA9wGt6k/otr3WvTEOe0PssvyBd18
         xFuwmAoYAlo2SaqF6Nrn6lJXtY7HH9WTzo7e0EcTKrurVUbKqTSa/P6jHHWaocbObE8R
         FUK/+1iBesEsOASM1AxDPSS6AXDr2sC0pA7/o8jp91ghgUmpxPOfHJvo2SXVVk5hRPxl
         DvZSzlY8wktXOBCf357byHAztz9cyT5c6m+dTphTCywi7U88gRYwfYfVuC/0br0lGq/R
         Tx6Q6SWoG2xnMyRMUyPHZz7iZBj2EyAuvX9QjXb1CtZRmZTc+8zD8QXdQ2SqelzpKJTy
         GTgQ==
X-Gm-Message-State: AFqh2koJ61yYIa4rlDd5dlDE7dfCAr1lDyE4goRpvw1kwzvp1mMRaMDe
        HdNcMrUgVVXw66yDqN1roGJIHQ==
X-Google-Smtp-Source: AMrXdXs5lM4FNJsLAYe1UJXOYQl5NMnJ6CDAHnniHyQ1Unhve2dTgTWnBstxOwfi5LtKC5ojLNX1aw==
X-Received: by 2002:a05:600c:5006:b0:3da:f92a:5446 with SMTP id n6-20020a05600c500600b003daf92a5446mr2846622wmr.27.1673954204841;
        Tue, 17 Jan 2023 03:16:44 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id q6-20020a05600c46c600b003cfd4e6400csm39224557wmo.19.2023.01.17.03.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 03:16:44 -0800 (PST)
Message-ID: <e2b1b18a-26c7-1a45-bad1-4233024062eb@linaro.org>
Date:   Tue, 17 Jan 2023 12:16:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 3/4] thermal/drivers/intel_powerclamp: Use powercap
 idle-inject framework
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, amitk@kernel.org,
        kernel test robot <lkp@intel.com>
References: <20230117020742.2760307-1-srinivas.pandruvada@linux.intel.com>
 <20230117020742.2760307-4-srinivas.pandruvada@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230117020742.2760307-4-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/01/2023 03:07, Srinivas Pandruvada wrote:

[ ... ]

> diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
> index f0c845679250..6c2a95f41c81 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -3,6 +3,8 @@ config INTEL_POWERCLAMP
>   	tristate "Intel PowerClamp idle injection driver"
>   	depends on X86
>   	depends on CPU_SUP_INTEL
> +	select POWERCAP
> +	select IDLE_INJECT

Just a question, not a comment. As IDLE_INJECT depends on POWERCAP, is 
it necessary to select POWERCAP also here ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

