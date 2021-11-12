Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C23944EF33
	for <lists+linux-pm@lfdr.de>; Fri, 12 Nov 2021 23:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbhKLW0B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Nov 2021 17:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbhKLWZ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Nov 2021 17:25:59 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33398C0613F5;
        Fri, 12 Nov 2021 14:23:07 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u22so14411543lju.7;
        Fri, 12 Nov 2021 14:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=sHuXcLTY5647faexK9OlG8EHfh48fYgFYf3fLcgzRuY=;
        b=JI6rQu93d2N9j4ZYC/czPcD/wE2/XOexxI7ERZiLyFNCvoMJ9pOi//gSu6tOuNsqhH
         Whcuw8sinjq2WK3KyxZ1D2dVWDCdIZHdoUimezGROaYa/wiCneWr0CCJ7s5MJMpxXQat
         KFCS3bCUOXZGxw8V6Rt/o5jQG3Z5rnx1pOyZuPKWeqy35382N/yN9ffbz6MAi8hUOx4P
         LLgDDHB7m28MHHU/QQBWZ2EQZWn9PyLlLBY2f09GGbxZ64lhv+gD9KjEMJwz71rDCqxY
         rQTCBYzQSV+uAFHHEZ7MOllVzPaKSR5LMz07W/PL1aAF+kMFWXjRCJzgmgS23UzFBqXU
         +UHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sHuXcLTY5647faexK9OlG8EHfh48fYgFYf3fLcgzRuY=;
        b=7CoDoQqbHbOhWZqQQyOwApHDolqSts4v5Sokdr0KBlYApNc6t8yyOF/MHyXsMxgMoh
         AimPeqI8WDUUes49iLKMGKz5zbdy52x9lA9AJHb+Vrjsf0NOsd2f/40BlAYEmWweakIT
         0zTtNqJgZAP6kmGC6pGkZKbzg5N0RTYzdpRZuPjuQgLJ7SUPypZDB0dbxE7rWItjMKVG
         zkW07icGs79CDqhWynpuq2vA5Xa5d27FUWC3NYfszfCXcLNF687+uqcuZGs+hl0kZlHB
         8zHi9lhrKcqGndE8+p/pXbWLKFlwLMb3EETHLLRalBN4gxmGOIanzVQKpDBBOxMpODPl
         UNbw==
X-Gm-Message-State: AOAM533Oz0S5sdnx5tbORKfwnPEGyG6ptbrRne75y/27OvvZJUjSB8KO
        J640wtHsM4uxVmk8y/aLmmE=
X-Google-Smtp-Source: ABdhPJyMV8Wd461AqStzxN8lAEXB9n+ZzrL0E2XKFoUFwArA6UmhCgEYAZnAfZpwZekICaMSbuHoVQ==
X-Received: by 2002:a2e:7616:: with SMTP id r22mr18232557ljc.391.1636755785541;
        Fri, 12 Nov 2021 14:23:05 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id j21sm671081lji.88.2021.11.12.14.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 14:23:05 -0800 (PST)
Message-ID: <8f02af47-d9dc-a29d-b839-e10969a448d0@gmail.com>
Date:   Fri, 12 Nov 2021 23:23:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:95.0) Gecko/20100101
 Thunderbird/95.0
Subject: Re: [PATCH RFC 0/3] reset: syscon-reboot: add "reg" property support
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20211102152207.11891-1-zajec5@gmail.com>
 <CAL_JsqL5qJZz8K7330cOhV8x86097LUE7oFNx5Qu3M4XLL+gMg@mail.gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <CAL_JsqL5qJZz8K7330cOhV8x86097LUE7oFNx5Qu3M4XLL+gMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12.11.2021 23:18, Rob Herring wrote:
> On Tue, Nov 2, 2021 at 10:22 AM Rafał Miłecki <zajec5@gmail.com> wrote:
>>
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> During my work on MFD binding for Broadcom's TWD block I received
>> comment from Rob saying that "syscon-reboot" should use "reg" property.
>> I'm not sure if my understanding & implementation are correct so I'm
>> sending this RFC.
>>
>> What bothers me is non-standard "reg" property usage. Treating it as a
>> simple (unsigned) integer number means different logic when it comes to
>> ranges.
> 
> It shouldn't be. The idea is that 'reg' works like normal. See below.
> 
>> Consider this example:
>>
>> timer@400 {
>>          compatible = "simple-mfd", "syscon";
>>          reg = <0x400 0x3c>;
>>          ranges;
> 
> ranges = <0 0x400 0x100>; // Just guessing for size
> 
>>
>>          #address-cells = <1>;
>>          #size-cells = <1>;
>>
>>          reboot@434 {
> 
> reboot@34
> 
> Just reading 'reg' is fine, but really, Linux should be either getting
> the translated address or have a function to get the offset from the
> parent base. IOW, it should also work if you just changed 'reg' to
> '<0x434 0x4>'.

Are you aware of anyone working on support for getting translated
address? Do you recall any efforts on implementing such a helper?

Thanks a lot for commenting on this concern explicitly.
