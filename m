Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C89C2AEC89
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 10:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgKKJBt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 04:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgKKJBs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 04:01:48 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A2DC0613D1;
        Wed, 11 Nov 2020 01:01:48 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id d17so2116984lfq.10;
        Wed, 11 Nov 2020 01:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dF1XDJ7ZODBxc6x3qPKL/KXM2fUXOq3zx9bPFuRUXO4=;
        b=Okv7oV92Vzop5e10q4xGtyON8UStnGOatV7C6Rc1rswtvL8Mhvbx7aaT1jngShXIHC
         Osz6VLgrGitnho0/V3S1MlvG0Qqar+FgDTzgtlI6P6H9SrP/1XEUoW2sn1AbHotu/J5g
         gQY9PXvceBWtVpemh1+D95K+cGYUZ3Nx/zY1ZNQytZ+DqlH/VUFv6E9LcpD2cQVahn1y
         ZCbVvr3ReZIJb07NtKjo1veri8UhTMBeV2CtHwKGljl8RwjWZmaCqckVwVF2g8Z6K/Ue
         Pt+QrfQpyYF81qUGAm+rEy7pgm/uAP934PYsV7c0GekE16eJzHBdYXzYrMaIeG507054
         ry4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dF1XDJ7ZODBxc6x3qPKL/KXM2fUXOq3zx9bPFuRUXO4=;
        b=AA4yqhbC6x97L2fazycGcw9rSG8E88xcUFKQALwFVYvUYYNuh6CVOv8NiBDr0GkUHA
         P4GQMC4QxC1cIKUQBT46DZyWHFuZgIkBQqZtsVjnFn2kuOtXA8i2KSf+J/xiCPj4QqIm
         lzWmriOojRaok/yd81eFjYoviFoJzqiH0T+wAWCKlDarB01PiZ11kXoJiFRWsHjkAcCz
         OZMtQTyy+HYh2+FN+E0lBTq28vObKx0tkYNp498ZlCv0hH/cbHTrYcgJvyAvEtKp9CRS
         5AUDTV8GZokctreGnQcPLlGn+L/umC73h1Pk18wFTD4BKNdQBbSZUzsRNLBXhTPeISkw
         3Nzg==
X-Gm-Message-State: AOAM532jVBTnnReyVs6unwi2Sl0bE+jlpstREcrr1j8YnNdAVVGQLafD
        AmItizTlEahkZLI7Ifx53n0=
X-Google-Smtp-Source: ABdhPJz6z3fUroQjNCVUQQmKeJpEYmQgvxFXJUBP4BbdvF5B4gMgXPhnWK/hACZZS1Hc4HkkoiMbAA==
X-Received: by 2002:ac2:43cf:: with SMTP id u15mr2352182lfl.382.1605085306963;
        Wed, 11 Nov 2020 01:01:46 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id o7sm163393ljg.41.2020.11.11.01.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 01:01:46 -0800 (PST)
Subject: Re: [PATCH v8 10/26] memory: tegra30-emc: Factor out clk
 initialization
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-11-digetx@gmail.com> <20201111085115.GA4050@kozik-lap>
 <20201111085250.GA11589@kozik-lap>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0b9fd887-fd57-f948-19b0-d629ed4aa2e7@gmail.com>
Date:   Wed, 11 Nov 2020 12:01:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201111085250.GA11589@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.11.2020 11:52, Krzysztof Kozlowski пишет:
>> You added this code in patch #8, so adding-and-removing a piece of code
> Correction: you added this in patch #9.
> 
> Best regards,
> Krzysztof
> 
> 
>> is a nice hint that this patch should be before. Don't add new code
>> which later you simplify. Move all bugfixes and all simplifications to
>> beginning of patchset.
>>
>> That's quite similar case to v6 where you put bugfixes in the middle
>> of patchset.
>>

Indeed, I squashed a similar change in the T124 patch #13, but forgot to
squash it for the T30.
