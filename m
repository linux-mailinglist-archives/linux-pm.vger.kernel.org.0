Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E726C66DC02
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jan 2023 12:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbjAQLOI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Jan 2023 06:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbjAQLNj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jan 2023 06:13:39 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5213B2B0B0
        for <linux-pm@vger.kernel.org>; Tue, 17 Jan 2023 03:13:36 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o17-20020a05600c511100b003db021ef437so2770171wms.4
        for <linux-pm@vger.kernel.org>; Tue, 17 Jan 2023 03:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6E73OKZGFC8KlEV5K+4dmiSqL5MeLnVsI9NufUq0/Qk=;
        b=deYr0LmgzrLFK1aoSsIg3H9oleKzD0u8Di4/Vk8ZfniLB0192jc9ZHGtpVO2HjSFzt
         sy94YCBcXYyiyd8MYK+BnKJmzpM8P6LHfKkFb/HH3fiw9sRCAf6BLvGtVRpsnbFcuGMU
         yaHmOsws+tmLy1/q9nS13EmAX1suDpPQQ80SOa6aQrtTDqr7vzliTdtX3t19ISKeVduR
         v1hCcoqHEM2pCANzroxa5obX1BczZOmDClKMcaqDHE9Rb+wg3QZKug9R5ZZNf42AZQPL
         cWoCMwASKolu7kh873RYf4WGm+pqcJPWUarKZAQlnHywf/BfGtUMpK2nlDMdub2y1nvb
         cEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6E73OKZGFC8KlEV5K+4dmiSqL5MeLnVsI9NufUq0/Qk=;
        b=ZgfD2EVBW3VJOxo/ezxuzyTht3aVbm5wuYQVAgHyR7UZTnJ3o9NZnz65el/BK84ePe
         /noeGmA91CXT0OulvCt/IM/W/325mYDTE8AJw2XRFk5ERbZ8fC/Twk3BSG6DkgnglBaY
         Y7xL9Rv51gbMV0eEjKM3MRI25Z3xwibP2hQeTpR5u5IyJMYt7zudfTsMwJIF+5mXFrHR
         JttUgfh0jyJlu0w9SLJQ6de7tlPhCNytCX1QUuTy9GYdcnSlJJxj6PGbGD6rBJJdOvm3
         ZgiXX4vqHeTKQl5/L1++33Q75I41c5oS60Hgc3VvJUiNpY48fI4CZseYUSN/iAsL/xzf
         ulMA==
X-Gm-Message-State: AFqh2kp2fKYSsBSBQSLNNorSsoUNLgg82yMlGHm1kwXYb7oG7h5zOd36
        WbwrqXLUm7N2/PUwbzT7XAwm6g==
X-Google-Smtp-Source: AMrXdXs5ZMgafBZZX2IEn9ljGfxmf4yKbG7WJzajhPYUrZMq7eopmS63raTaCM5nJwQ7o8SPJru50g==
X-Received: by 2002:a05:600c:348b:b0:3cf:7b8b:6521 with SMTP id a11-20020a05600c348b00b003cf7b8b6521mr2627992wmq.32.1673954014729;
        Tue, 17 Jan 2023 03:13:34 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f15-20020a7bcd0f000000b003d9a71ee54dsm35441612wmj.36.2023.01.17.03.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 03:13:34 -0800 (PST)
Message-ID: <c5167eb8-22d6-c230-5828-80e59154aeb0@linaro.org>
Date:   Tue, 17 Jan 2023 12:13:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/4] powercap: idle_inject: Add update callback
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, amitk@kernel.org
References: <20230117020742.2760307-1-srinivas.pandruvada@linux.intel.com>
 <20230117020742.2760307-3-srinivas.pandruvada@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230117020742.2760307-3-srinivas.pandruvada@linux.intel.com>
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

> +struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
> +{
> +	return idle_inject_register_full(cpumask, NULL);
> +}
>   EXPORT_SYMBOL_NS_GPL(idle_inject_register, IDLE_INJECT);

Why not just add the parameter to idle_inject_register() ?

There is only one user ATM


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

