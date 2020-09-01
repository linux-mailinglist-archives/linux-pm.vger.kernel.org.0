Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEBD258F02
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 15:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgIANWK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 09:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgIANVt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 09:21:49 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64BAC061245;
        Tue,  1 Sep 2020 06:21:33 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e11so1485029ljn.6;
        Tue, 01 Sep 2020 06:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AAwGBH9Pl98e0MOBgKPdwEfXEzau8aeh454hPp/x1WM=;
        b=hNonOjx0uNrzojH5Oetsx+QHjTKAlpn1u2xckZp/ImUX4M2eLMKEYKM/LQ1i9kfL88
         3blZngUlF6oxiiWlvBLRlbGEW90fjo5kyoOiKoBY/WYfYPPtZbu60eXGxqAo8naxQxIW
         oRhNB5QlIz/2rhg4Q7DnOQJpJwc3BG4ooIZJngPUpLzPgq6BduCgtK60wXchlz9UQqCD
         ADxKMgik/rt4rL6x0QyfP7dAOBTLrqAmex+6+ZhEoIIqAn/xqM2OHNHt3NlsNmk8TX9n
         BnLoh3FFpBOL5w35kY1tNAlqDI1MXqUGeL7fl7IEFddXjHwAv0BZ5vQfBKXoUCeXZO/5
         uA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AAwGBH9Pl98e0MOBgKPdwEfXEzau8aeh454hPp/x1WM=;
        b=ijozEiVsIx8JS5SLjvborTV/OdD9iWM1IQzbjRAP83vII/O+NRJqGtTyLtKtoATcIJ
         Fzhy/PiR64N0bz5Kocthmztd0V2My4wtB68AAb5DUmGrGwREYqWMq5dn9KBZzRnYangE
         xYq47laF580ndsUrgqNoEWAjpdgYYVXuh8kcreygJQJIQaNaAdKf5M5K0VR6mqts3Q7+
         vnVVvU0wy2ZJx/0pZfrYQDXblbLV7nNHEok3MTwhMw098u2w2xCFS+2h5q0yrnDliNq/
         DzsuZvTGEN2GT4tmwI4Xx+9GA2GRbmTqBthUr8jFSd8tzY+HNxFos5lCACkmGxKUZYcZ
         WtCA==
X-Gm-Message-State: AOAM5313NI7VDNAxIOgXPEaTQzXrfPWNoL+9fqs9SCEU97Ov481wwvmY
        RlrraogarXImL/WRmMSI/tC8J4vwa3s=
X-Google-Smtp-Source: ABdhPJyLxzIU+wmLlGsYIuh2GuFRSkigyBrqYDTRhDWzCG5tIEBTHurrOVD70DACcy6C/77sL3D56g==
X-Received: by 2002:a05:651c:106f:: with SMTP id y15mr627124ljm.170.1598966491976;
        Tue, 01 Sep 2020 06:21:31 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id f24sm49863lja.104.2020.09.01.06.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 06:21:31 -0700 (PDT)
Subject: Re: [PATCH 3/3] ARM: tegra: Pass multiple versions in
 opp-supported-hw property
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1598442485.git.viresh.kumar@linaro.org>
 <b13f1b112532fe0189d1f7bbb50903d9e1defb07.1598442485.git.viresh.kumar@linaro.org>
 <b0763074-859f-fccb-dde4-03d1a50ea021@gmail.com>
 <20200831043908.mtw4dglybcmcabjb@vireshk-i7>
 <0da380c2-9161-d450-afd2-4b159c8cfb7d@gmail.com>
 <20200831084111.6udzvrdonxgzju4l@vireshk-i7>
 <cbfa012b-8f50-e460-972c-c51fa52bb858@gmail.com>
 <20200831110408.a6lwivim4w4jtkdc@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <603071ec-6ae4-7e34-26e4-f64065b01ee0@gmail.com>
Date:   Tue, 1 Sep 2020 16:21:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831110408.a6lwivim4w4jtkdc@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

31.08.2020 14:04, Viresh Kumar пишет:
> On 31-08-20, 12:54, Dmitry Osipenko wrote:
>> It's not clear to me how it could be applicable to the Tegra CPU OPP
>> because Tegra depends on a combination of SPEEDO + PROCESS versions.
>>
>> It's not like all voltages are the same for all OPPs that have the same
>> PROCESS ID, otherwise it indeed would be nice to have
>> "opp-microvolt-process0", but unfortunately this variant is not suitable
>> for Tegra because some freqs have different voltages using the same
>> PROCESS ID and the same applies to the SPEEDO ID.
> 
> How exactly do you know what voltage belongs to a particular OPP ?

From these tables:

https://nv-tegra.nvidia.com/gitweb/?p=linux-2.6.git;a=blob;f=arch/arm/mach-tegra/tegra2_dvfs.c;hb=l4t/l4t-r16-r2#l157

https://nv-tegra.nvidia.com/gitweb/?p=linux-2.6.git;a=blob;f=arch/arm/mach-tegra/tegra3_dvfs.c;hb=l4t/l4t-r16-r2#l148

> 		opp@216000000 {
> 			clock-latency-ns = <400000>;
> 			opp-supported-hw = <0x0F 0x0003>;
> 			opp-hz = /bits/ 64 <216000000>;
> 			opp-microvolt-fast-process0 = <750000 750000 1125000>;
> 			opp-microvolt-slow-process0 = <750000 850000 1125000>;
> 
> 		};
> 
> 		opp@312000000 {
> 			clock-latency-ns = <400000>;
> 			opp-supported-hw = <0x0F 0x0003>;
> 			opp-hz = /bits/ 64 <312000000>;
> 			opp-microvolt-fast-process0 = <750000 750000 1125000>;
> 			opp-microvolt-slow-process0 = <750000 850000 1125000>;
> 		};
> 
> You can make any combinations of such names that come from speedo,
> process, or something else. If you can get this done as a fixed
> formula then it is workable.
> 

IIUC, there is no fixed formula for Tegra, at least I don't see it. For
example, if you'll take a look at the 1300MHz OPP of Tegra30, then you
could see that this freq has a lot of voltages each depending on
specific combination of SPEEDO+PROCESS versions.
