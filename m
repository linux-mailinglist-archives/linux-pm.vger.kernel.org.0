Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB963EC20C
	for <lists+linux-pm@lfdr.de>; Sat, 14 Aug 2021 12:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbhHNKiO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Aug 2021 06:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237953AbhHNKiN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Aug 2021 06:38:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F287BC0617AD
        for <linux-pm@vger.kernel.org>; Sat, 14 Aug 2021 03:37:44 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso11415265wmq.3
        for <linux-pm@vger.kernel.org>; Sat, 14 Aug 2021 03:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b/Qff+jgXrDhHuuoGtLAHrj3fuh4dTxu/3Q1oLK4n8Q=;
        b=HJL2l1Dpc/J4K4yfvomdt3qXLJ/QLhZOCgHm56mMldgkdC9wNqTT92qrGVVVmiA5E7
         s+eZ3UE+WSVMOV1JuU+RwFoQvSwAI4wAb2c25tFKcIKuJ3P4h3hQMaPjR55zVLF7yqc0
         olArDY5fQ8ls2HjtNV9K3pFVvGeiYr9P9/w9ZuTnEBBa33mkINm4kpD+rLbGNL7r29VG
         xQjtvgY/3wEkqTEpkxGlEF1agw0MtFLoy6fnNOLrQ/U3JjatLVdqQsbpiPxeEHyV5DSN
         s5hqTHCVkbUJ1zsWDacpRnzlBX86KLazem8prxJoxpNxxLs8nGQ4BIR3HDh52W+bmzZL
         hdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b/Qff+jgXrDhHuuoGtLAHrj3fuh4dTxu/3Q1oLK4n8Q=;
        b=po+3ZJED/qNcrCl0MNy2bCsM+vp5X5nFKBTJ9fpRZH/CYy+PcE1n/qQlW2TZyRV6+g
         ULnLWZ26Qh497gJ/JlaopQq25U2TX2GU/s6alFsnUYc+FXdhYBxrW1WMBlBwNwfUKCnW
         5eyVdaLwjB210JT/MyyjMtiMmzslK2kApfw2Q7XlM8PweD33b4uLr+fmtDNc3NFZVvll
         RkEba9TrvrGdeeM8HRZNTFYIJ02pPI0T9xpQWkaotZppODDSclQyWHF1GSKgY8y25QoD
         u/Pl40gC7LP3f/jk6qI1ShSF2SZqyin0GfxRUbXkjeKWPDbnFxF0z2QmB2YzCPQgw2Dp
         lcPw==
X-Gm-Message-State: AOAM53025OyJljoxWjolWg+Xo4uxCXtFZvlFtTIZr//hcXOv22E6k1IF
        h5KdCfN0HkJnwoh+L4Z4UeKKPA==
X-Google-Smtp-Source: ABdhPJzQ48slGMIdnfZowqGimrHWLTCgEUosGpoZOS695J9Vebr2A4e2oYVBp9dC0EG9L+eBMlpU4g==
X-Received: by 2002:a7b:cc8b:: with SMTP id p11mr6614718wma.25.1628937463289;
        Sat, 14 Aug 2021 03:37:43 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5df3:d0eb:3945:640d? ([2a01:e34:ed2f:f020:5df3:d0eb:3945:640d])
        by smtp.googlemail.com with ESMTPSA id e17sm4228437wru.7.2021.08.14.03.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 03:37:42 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] cpuidle: tegra: Check whether PMC is ready
To:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210718212706.21659-1-digetx@gmail.com>
 <20210718212706.21659-3-digetx@gmail.com> <YROdQXO4aVLQ8DkP@orome.fritz.box>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8d61d4d5-8e4b-5c18-923c-eceb954e8d5d@linaro.org>
Date:   Sat, 14 Aug 2021 12:37:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YROdQXO4aVLQ8DkP@orome.fritz.box>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/08/2021 11:49, Thierry Reding wrote:
> On Mon, Jul 19, 2021 at 12:27:06AM +0300, Dmitry Osipenko wrote:
>> Check whether PMC is ready before proceeding with the cpuidle registration.
>> This fixes racing with the PMC driver probe order, which results in a
>> disabled deepest CC6 idling state if cpuidle driver is probed before the
>> PMC.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/cpuidle/cpuidle-tegra.c | 3 +++
>>  1 file changed, 3 insertions(+)
> 
> Rafael, Daniel,
> 
> would you mind if I took this into the Tegra tree? It's got a dependency
> on the PMC driver, which usually goes via the Tegra tree already, and
> there's nothing cpuidle-specific in here, it's all Tegra-specific
> integration quirks.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
