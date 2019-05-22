Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D46263DA
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2019 14:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfEVMaU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 May 2019 08:30:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35737 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbfEVMaU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 May 2019 08:30:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id q15so2030972wmj.0
        for <linux-pm@vger.kernel.org>; Wed, 22 May 2019 05:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bWFk7Dku220BSIRMzb9u9QC4G1aGkz5eeVURI5VAO6k=;
        b=g96lwHJ1ode6GDHOpCNuIGXm9CyJMyL30+7sF/XHZsGNh83VKrt4oHQElsVQcq3Px6
         BOLZCXg2OkSQeBvD3hxSeV4p2mhTpmNUGC5+Hk9dDKEZ2kCwnFtdO3vkgr14OreE2lST
         el4z4ZbLjBnZDmCh9cbIxr5CVw4rtQtIgsScMOQB7jjEHWklwSnumvckNFx9JoklMZdT
         Pagwhsw3cJsXOGpV22J+QEU5RyEKqs5w/+Nmh5uFkwv9vQ5LGI2FSuj3qYd/u0u6rlVC
         9YVaMPU1e9ul/YO63BYEVxcUJFXVRQjaOAlw1VdSX/bIM/KVJjpW9PCFv7aHz6XbHE2Z
         EysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bWFk7Dku220BSIRMzb9u9QC4G1aGkz5eeVURI5VAO6k=;
        b=KO98eifmFiP4qMqDQYKjrYUZNaPxVD50ffvVE+tqxX60sav+rblMBxSpI9Mf/9euYP
         JYxsBaLd/5F79vmRLH4prJxOELNvN2BRT+5yLDr+/W6u3pLZ8sVmkx3Pk0jwekzBjdAX
         Kg7zavjPSv5a4GaHI9d/cqco3hxVLitH+FIfPXR0vVFrgB4zO//1HNtDxvJeghz73G4v
         EHSYjIuc2uJVFqn9T15HUzMF0EACK1R/v/4BoPoW50GDH9ekZXqiOsRZCxXnAOev1lor
         81Lr8WvcoGJ+e0DCZT+1Vfo5xwI/fBiSQIpI9NYDO5pveqekOfOyoyK2gyVDMCW3vnKR
         O5/A==
X-Gm-Message-State: APjAAAX41GbevwOskwl0a6Q23Z7dG0y7MDwetQUEJePjaFf5iCRCrsOm
        AGf4Q+H8BTh09HATWTKm3Wnt2w==
X-Google-Smtp-Source: APXvYqwcEWVPtTAR2IKfdlPTMN56ztuBh3i4KBntxk3eiRbthNztynbpp3p0eM5amjYVUHiszLA3qQ==
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr7077335wmh.32.1558528218123;
        Wed, 22 May 2019 05:30:18 -0700 (PDT)
Received: from [10.1.203.87] (nat-wifi.sssup.it. [193.205.81.22])
        by smtp.googlemail.com with ESMTPSA id y4sm3952952wmj.20.2019.05.22.05.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 05:30:17 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] thermal: rockchip: fix up the tsadc pinctrl
 setting error
To:     Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        huangtao@rock-chips.com, Linux PM list <linux-pm@vger.kernel.org>,
        xxx@rock-chips.com, xf@rock-chips.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Doug Anderson <dianders@chromium.org>, vicencb@gmail.com
References: <1556618986-18923-1-git-send-email-zhangqing@rock-chips.com>
 <785392a0-282a-1e51-a4d6-a6d5ca478949@linaro.org>
 <CAFqH_53nbiwzQKctNa7MBzgCcsRFn1p8g31Xgvo3E9k6eA8AKw@mail.gmail.com>
 <2174314.1vfUlvne1O@phil>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f0581341-126a-5733-3c4b-8e6f67bfc32e@linaro.org>
Date:   Wed, 22 May 2019 14:30:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2174314.1vfUlvne1O@phil>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/05/2019 14:27, Heiko Stuebner wrote:

[ ... ]

>> As this change is now in mainline and is causing veyron to hang I'd
>> suggest reverting this change for now. Even fixing the root cause
>> (maybe the one I pointed above) after this patch we will have the
>> thermal driver to fail because "gpio" and "otpout" states are not
>> defined nor documented (a change on this will need some reviews and
>> acks and time I guess).
> 
> I definitly agree here. Handling + checking the binding change
> as well as needed fallback code is definitly not material for -rc-kernels
> so we should just revert for now and let Elaine fix the issues for 5.3.
> 
> Anyone volunteering for sending a revert-patch to Eduardo? :-)

I can't right now :/


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

