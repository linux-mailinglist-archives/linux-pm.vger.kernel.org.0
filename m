Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D05D46D7E1
	for <lists+linux-pm@lfdr.de>; Wed,  8 Dec 2021 17:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbhLHQT4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Dec 2021 11:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236677AbhLHQTz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Dec 2021 11:19:55 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4437BC0617A1
        for <linux-pm@vger.kernel.org>; Wed,  8 Dec 2021 08:16:23 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q3so4984090wru.5
        for <linux-pm@vger.kernel.org>; Wed, 08 Dec 2021 08:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s3S6Qu67tEui0DUsR7g/4/F35A73+SPBA+zRxkUhaG8=;
        b=MOtB1a6nj3/eQ3UtTDyQj1j+VVPdxYy6CedR8STiP6JvFUMlapTFPLi4UqGLNvsarp
         LBJcZFgfWEfjBSAAsypXx6MZtRZIkpUiNnsuhfbv/v8ov6rSYP/ZvOMQGqIat3nqxTUE
         sZT4IGJtCEQtYlnhi+uHHCl8gv/wD/2me2DEVJy3eYtdc4A+xHBTdxA1EjO3til/UDMm
         H/1edaw3ZvxzNZs7S/nWmnPAoIfTzxFkuQvzRY5Zg2TIP1/22hviuBUTchcYCqzkEiCs
         YLG2lwVRBbHfl0Z0TO8HEmsEIUF8y/l4xfS0BqKLlBXZ8DuHBBHsxnhYUoXSD5M9ohK7
         erVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s3S6Qu67tEui0DUsR7g/4/F35A73+SPBA+zRxkUhaG8=;
        b=5s9abUtTgpriBmw3NsjmCKWmHhQ60ltX+EGjJTfFDLdlzsWTEc1UcJt/CRlvIXNqya
         zQ3dgMWLdNAZ+Z24vNSwY6qgOiK/kAisXgY3viKmyT9Fvalb6saGhacPgHUVipIWXetk
         RY/qyArBf7h7RNkH1eOCIWYNwjY4PyNdHAgA5+jox8o8wpByBjqu7jdvpPus0naMn7IT
         /U8VdHmQuKJW1N5k0EWtuU6blFGAyEB8vsDbeYhqmQg1x3uiKA3D0V5yVC6Qmbsv0YWm
         l4S7spyXTk59sVu8aZqxq/eQmlU3NrZB0MrjD9TtyBRL4wlNBiF1hywn5OVbqStO0n4d
         MdjA==
X-Gm-Message-State: AOAM5338tdubJ7Xg8UAEtudIdb+M9v3GWcjGI+zCQyuT0kFm1txbdEvB
        KbNERr2cmzL0q3lQQC4/3UrMAg==
X-Google-Smtp-Source: ABdhPJyCcP3HTyvqGn8Z6fbCxuZdPjgKKEAI4N4Ibrf6Rk4KMeup+vzySvXG4xrGLqlNMeEqm37nlA==
X-Received: by 2002:a5d:48cf:: with SMTP id p15mr60128362wrs.277.1638980181213;
        Wed, 08 Dec 2021 08:16:21 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8ae8:ca1f:ff1a:a23d? ([2a01:e34:ed2f:f020:8ae8:ca1f:ff1a:a23d])
        by smtp.googlemail.com with ESMTPSA id r83sm6322557wma.22.2021.12.08.08.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 08:16:20 -0800 (PST)
Subject: Re: [PATCH v2 2/5] arm64: dts: rockchip: Add powerzones definition
 for rock960
To:     Rob Herring <robh@kernel.org>
Cc:     arnd@linaro.org, heiko@sntech.de, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Helen Koike <helen.koike@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
References: <20211126181500.3404129-1-daniel.lezcano@linaro.org>
 <20211126181500.3404129-2-daniel.lezcano@linaro.org>
 <CAL_JsqK1tsOqUYrLkZCo95BC=AXwZxai947x41zYpeHbodvwFg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <82ac88d2-5419-4c1f-e81a-154c65b39c1b@linaro.org>
Date:   Wed, 8 Dec 2021 17:16:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK1tsOqUYrLkZCo95BC=AXwZxai947x41zYpeHbodvwFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rob,

On 07/12/2021 19:41, Rob Herring wrote:

[ ... ]

>>         thermal_zones: thermal-zones {
>>                 cpu_thermal: cpu-thermal {
>>                         polling-delay-passive = <100>;
>> @@ -2027,6 +2050,8 @@ gpu: gpu@ff9a0000 {
>>                 clocks = <&cru ACLK_GPU>;
>>                 #cooling-cells = <2>;
>>                 power-domains = <&power RK3399_PD_GPU>;
>> +               #powerzone-cells = <0>;
>> +               powerzone = <&PKG_PZ>;
> 
> Every CPU and the GPU are in the same powerzone. What is the point? Do
> you really have to be told that CPUs and GPU are a source of heat and
> might need to be limited?

A powerzone ==> can read power && set power limit

Every CPU is a powerzone as well as the GPU.

They are all grouped under PKG_PZ.

That means we have:

 pkg
  |-- cpu0-3
  |
  |-- cpu4-7
  |
  `-- gpu

We can read the power consumption of cpu0-3, cpu4-7 or gpu and set their
power limit.

We can read the power consumption of pkg (which is the sum of the power
consumption of cpu0-3, cpu4-7 and gpu) and I can set the power limit
which will ensure powerof(cpu0-3 + cpu4-7 + gpu) <= powerof(pkg).



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
