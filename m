Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FB17AEE1D
	for <lists+linux-pm@lfdr.de>; Tue, 26 Sep 2023 15:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjIZNri (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Sep 2023 09:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjIZNrh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2023 09:47:37 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44F0101
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 06:47:29 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-405497850dbso69061125e9.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 06:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695736048; x=1696340848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUZoMLnKwsOq3aRDz3SQyOis9iaqsJSI3quNHiMxzyw=;
        b=zzVesboSwQ66H+eSPvGYQlKK+AxGLJu7YJm6g5ArfznDMTAU+lJ8YGkjX90cdKkW2M
         w6U9amZ+aGUJGAGvxsJZdvpTgLqKVg0N9hi1ynhEQPs8ibOsb8Pu1Ds5DhLeXjoAh6Uz
         7EgO+k9OxuqjmQ/91Lwd8pg1q8Z8SIeipsqyJCeSHzLv75XsrIOE9NRnThR20gLlwfBp
         Hcyx2Aa1fOLgEf6jAcCgd6i7BVvCCUXAAM15+5q9pNhX9eXrNZaEBM84AET27+7eKcZL
         daQ26suBm9JAkM39Un578FepC1Qe0jXIuN+MP3JO2z1gDRGAqkfk4Un0vaSHX/v/yzVW
         aa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695736048; x=1696340848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUZoMLnKwsOq3aRDz3SQyOis9iaqsJSI3quNHiMxzyw=;
        b=vSzQXGyyFVayul+SmjJJoHUebroVuDQiFaoGjo0xr8IvbUDHpaMtBfmYQZne/h/396
         55RZ5sMngMomZu1XwLRpvEv3XeS6KG7rb0fjMa9UcXVOcmRATkPeT8BNLL8FqCT9xRNY
         gjCrfqnftZXX07WPNfZ5vGrwiXsQc9Bfodh1jsVn5ehX0Y5fvNENFHFygOu8W42uyHkJ
         0SZ7Kfx5Gxfqhs5+4M7OEEzx6SpztNpneCMZyxhqf6xbsNw2jW5f4fbXK8+XHpi1r5Yk
         GIemExBdvj283fFgKScejfZXj8RkacRrvhBZ/Q+h94z9OSyFOocmkfKGOEp3W8/rCaGi
         vtgQ==
X-Gm-Message-State: AOJu0Yzk81YKrRUAmYiu+0iBPlOpkxkvyRGUl7WlfPL2URfUzu+ZXDIJ
        hoptpQPO1qny8R0+WFLZ+G8fng==
X-Google-Smtp-Source: AGHT+IFvaxin1673zlwprQP4SWnLVcctslXPms1at5HtCDaXdk2NYjuV3/YZ8ECXZqwv+B7HcAX/nw==
X-Received: by 2002:a05:6000:1d0:b0:319:7abf:d8e2 with SMTP id t16-20020a05600001d000b003197abfd8e2mr8005672wrx.24.1695736048279;
        Tue, 26 Sep 2023 06:47:28 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id l24-20020adfa398000000b003232e5de745sm4351819wrb.55.2023.09.26.06.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 06:47:27 -0700 (PDT)
Message-ID: <c5eb5bea-264b-0084-af6c-2d95580c8f33@linaro.org>
Date:   Tue, 26 Sep 2023 15:47:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 9/9] ACPI: thermal: Drop valid flag from struct
 acpi_thermal_trip
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <5708760.DvuYhMxLoT@kreacher> <9162925.CDJkKcVGEf@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <9162925.CDJkKcVGEf@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/09/2023 20:47, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that the valid flag in struct acpi_thermal_trip is in fact
> redundant, because the temperature field of invalid trips is always
> equal to THERMAL_TEMP_INVALID, so drop it from there and adjust the
> code accordingly.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

