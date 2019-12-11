Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC5B11BED7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 22:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLKVLo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 16:11:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35139 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfLKVLn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 16:11:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so243954wro.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 13:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Anxrztkidu84QaCwRdDgeR9GC/EpOxuuPVnCKxK8UI=;
        b=V9jnpMFdlin1CFUBFcJYiMJm3EeDpCEQumbYnwFwHNa9FHg5OY7ULLJcvnw1TCXbSa
         430mR106lVcuKd/LKV1hU6LojNpxeF+H/KUNd1CkIkGDJQsyvytGKQtVqO8jkreu31OM
         IbphNoEWecB2iGBZ+Hua0dAoWOW1pXrSuu/gBRkrS/O7CacU//G14uJHKpR1LwuEeREb
         ILN75folD0WJKAT80rVTn8fqzEV6R6HyQ3N93nNGYZxQmujvqSASVIm4sk3ubVyPQS0j
         C1Jj4z/37ipnW8xKRTY6wMliN9MwWjXtLEenqibtkIF/18jjFMgsswIAVbg4/QICrO8g
         Xlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+Anxrztkidu84QaCwRdDgeR9GC/EpOxuuPVnCKxK8UI=;
        b=gxx4CI5VSJHgD/sMiAcR8pRwDxhjp2ANEJDDVLFEOJ9vNfAJJvwY4D7IxYF94vKHBu
         wPS5PscGmSLtoNaAd4ObNBvAfDqiqAxPGrUd8n488iv0hanDLe75SvkPkCsPWI0j0UV7
         JAXU4xayJXpmNdFpRDudevUSN1pOX0A0MPGuxV65efXkNCaUhQFD0RKWl3/fx02JHDi9
         HQ7A3znJInQe05d3uRYFX+W0ue5MWGRDaPZlbjh9IrytXYwIuA8spNr6gtC7UnFlT+yc
         K/Vk+kh/6OOV4a0myp3ayoN9pX1Ki1jmuuBM4ActOcyxculE0sv5X2AOc2XrM4VJAwQM
         Qg+Q==
X-Gm-Message-State: APjAAAXFrAoUC5J+U0wjOEhUe5zKB41x7Dj1D/p4HCOxzCJHtu4MrwXz
        Qg/VAmEW+tROqkV1uwWqIPdrsg==
X-Google-Smtp-Source: APXvYqy+daJofrsLcthdtlWmODPbxA25i3Gm3psoHa/j/a7pX9fmnGBhAeP3ZOEKueglVa1WuJ9AbA==
X-Received: by 2002:adf:a308:: with SMTP id c8mr1960289wrb.240.1576098700586;
        Wed, 11 Dec 2019 13:11:40 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:9048:8:c450:f5a0? ([2a01:e34:ed2f:f020:9048:8:c450:f5a0])
        by smtp.googlemail.com with ESMTPSA id i8sm3688944wro.47.2019.12.11.13.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 13:11:39 -0800 (PST)
Subject: Re: [PATCH v3 0/3] thermal: introduce by-name softlink
To:     Wei Wang <wvw@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wei Wang <wei.vince.wang@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20191205071953.121511-1-wvw@google.com>
 <69dd3a7a-c5fe-3ae7-8a4d-c3939870eed8@linaro.org>
 <CAGXk5yrsmvHK_xwvp_kFNmSqKOZ7Ef3HrVBHYDMBmDsCz0FNSQ@mail.gmail.com>
 <0603228e-5f0b-d335-30ce-67cf0626a489@linaro.org>
 <20191211085400.GB500800@kroah.com>
 <CAGXk5yrFp1eeeadhJar_qJqJ9G1q2mn+5m8JW4705ouQDLqzsw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f0ebc98d-25f2-6326-c0d8-8dda543c4091@linaro.org>
Date:   Wed, 11 Dec 2019 22:11:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAGXk5yrFp1eeeadhJar_qJqJ9G1q2mn+5m8JW4705ouQDLqzsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/12/2019 21:11, Wei Wang wrote:
> On Wed, Dec 11, 2019 at 12:54 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> On Tue, Dec 10, 2019 at 09:54:11PM +0100, Daniel Lezcano wrote:
>>> On 10/12/2019 21:01, Wei Wang wrote:
>>>> On Tue, Dec 10, 2019 at 6:36 AM Daniel Lezcano
>>>> <daniel.lezcano@linaro.org> wrote:
>>>>>
>>>>> On 05/12/2019 08:19, Wei Wang wrote:
>>>>>> The paths thermal_zone%d and cooling_device%d are not intuitive and the
>>>>>> numbers are subject to change due to device tree change. This usually
>>>>>> leads to tree traversal in userspace code.
>>
>> tree traversal is supposed to be done in userspace code :)
>>
> Yes, that can be done in userspace, but given the amount of thermal
> zones we have in some mobile devices, this will bring a lot of
> convenience.

But usually all these thermal zones are fixed and building the name<->tz
association is just a question of a few lines of code from userspace,
no? What would be the benefit of adding more ABI?

If there is a thermal zone change, then a notification can be used, so
the userspace code rebuild the name<->tz, no?

> e.g. this is on Pixel 4 XL:
> coral:/ # ls  /sys/devices/virtual/thermal/
> cdev-by-name      cooling_device15  cooling_device22  cooling_device3
>  cooling_device9  thermal_zone15  thermal_zone22  thermal_zone3
> thermal_zone37  thermal_zone44  thermal_zone51  thermal_zone59
> thermal_zone66  thermal_zone73  thermal_zone80  thermal_zone88
> cooling_device0   cooling_device16  cooling_device23  cooling_device30
>  thermal_zone0    thermal_zone16  thermal_zone23  thermal_zone30
> thermal_zone38  thermal_zone45  thermal_zone52  thermal_zone6
> thermal_zone67  thermal_zone74  thermal_zone81  thermal_zone9
> cooling_device1   cooling_device17  cooling_device24  cooling_device31
>  thermal_zone1    thermal_zone17  thermal_zone24  thermal_zone31
> thermal_zone39  thermal_zone46  thermal_zone53  thermal_zone60
> thermal_zone68  thermal_zone75  thermal_zone82  tz-by-name
> cooling_device10  cooling_device18  cooling_device25  cooling_device4
>  thermal_zone10   thermal_zone18  thermal_zone25  thermal_zone32
> thermal_zone4   thermal_zone47  thermal_zone54  thermal_zone61
> thermal_zone69  thermal_zone76  thermal_zone83
> cooling_device11  cooling_device19  cooling_device26  cooling_device5
>  thermal_zone11   thermal_zone19  thermal_zone26  thermal_zone33
> thermal_zone40  thermal_zone48  thermal_zone55  thermal_zone62
> thermal_zone7   thermal_zone77  thermal_zone84
> cooling_device12  cooling_device2   cooling_device27  cooling_device6
>  thermal_zone12   thermal_zone2   thermal_zone27  thermal_zone34
> thermal_zone41  thermal_zone49  thermal_zone56  thermal_zone63
> thermal_zone70  thermal_zone78  thermal_zone85
> cooling_device13  cooling_device20  cooling_device28  cooling_device7
>  thermal_zone13   thermal_zone20  thermal_zone28  thermal_zone35
> thermal_zone42  thermal_zone5   thermal_zone57  thermal_zone64
> thermal_zone71  thermal_zone79  thermal_zone86
> cooling_device14  cooling_device21  cooling_device29  cooling_device8
>  thermal_zone14   thermal_zone21  thermal_zone29  thermal_zone36
> thermal_zone43  thermal_zone50  thermal_zone58  thermal_zone65
> thermal_zone72  thermal_zone8   thermal_zone87
> 
> 
>> But what userspace code needs to do this, and for what?
> In Android, thermal daemon and thermal HAL as well as some init.rc
> script would use those thermal paths for managing and monitoring
> thermal. The daemon/HAL could have logic pipled in, however Android's
> init.rc script would be really tricky.
> On a related note, we also create /dev/block/by-name links from userspace.
> 
> Thanks!
> -Wei
>>
>> thanks,
>>
>> greg k-h


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

