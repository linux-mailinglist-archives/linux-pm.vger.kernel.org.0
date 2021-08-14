Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2710E3EC2F4
	for <lists+linux-pm@lfdr.de>; Sat, 14 Aug 2021 15:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbhHNNqP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Aug 2021 09:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhHNNqO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Aug 2021 09:46:14 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE622C061764;
        Sat, 14 Aug 2021 06:45:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x27so25427731lfu.5;
        Sat, 14 Aug 2021 06:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a7ih3Ugr+LdH4vNrW5pl7goeomz6g/rG+9i20GBpsA0=;
        b=ftd5lAhuQQOBUq+IRvbwAVyohLpNhHTDwDGeba1phOLDwYzp6DfgwXjqyzOOa4QSHs
         28SzgiQjn4SkwPekOMa5N5OXqFnAThklIFNIk/tn8n9k+Ur6QCom2CUGhRvwnFSLj2pM
         NmyfdgswrsKGiGmoLu2jH9QETcs9lFnOw3EIxwMPJEOVppVlhrvwukVDpGvavK5KWGOM
         4hcxkoSknLph6kPva/NZKfhuZykMngzXzR/OI2ejD9Ey7eR3SbRwgdeNiEKoyuY11IY4
         f1J0azPtg/3e5xyQpgcdyZ2Sar+EKruZneoSXEhBq8pvUMe+PBTRYFWDkQrO28iCCExR
         s+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a7ih3Ugr+LdH4vNrW5pl7goeomz6g/rG+9i20GBpsA0=;
        b=cy8ZcoE7ezm5+z0/Xi+p4mB5W4Isp852cNoYRqo5ihKMkJS3gCwUcESMnIowqMswP4
         TdOeiKP8hZTLM7b5W1LQKAe+27/HgcrstUHrb0WYTPTVpDxfw8gZ8oSnQjS1w13wLdQQ
         rcZlzqFvbB9HSBeIjsz8gdANXiVvCMd1JFRjv5C5KrTF8H1l4yepdWUALnM/nMREprl4
         6rXleQnB+/9DkLqviYM04EwP/23MNhlJq3k4QydqU9lfxnXCh/As3xnbOrjojqlRyfsq
         DvmxCsJjqVa1/TTv3T32V7cczpRUYGHvY3/sJO68ZHqE0gJVLYKtn7Ft+Qy6sM8LzKU5
         YO7A==
X-Gm-Message-State: AOAM530zbqfk7aunBzX5oFJ81j8jE7aSOHRlffp85OFI9HdsaLRImjeD
        aDlcWfXVF9+h4RTxVXKVnZy3MUX2cdU=
X-Google-Smtp-Source: ABdhPJxvQHlYAKv77KEMcXdT1XGKk7zadvDQOTW2/xSLT0/jZhb2jYoFVwya11JegyHBUF2ksbMGrw==
X-Received: by 2002:a05:6512:3c8f:: with SMTP id h15mr5368079lfv.440.1628948744181;
        Sat, 14 Aug 2021 06:45:44 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id y11sm421460lfh.185.2021.08.14.06.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 06:45:43 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] cpuidle: tegra: Check whether PMC is ready
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210718212706.21659-1-digetx@gmail.com>
 <20210718212706.21659-3-digetx@gmail.com> <YROdQXO4aVLQ8DkP@orome.fritz.box>
 <8d61d4d5-8e4b-5c18-923c-eceb954e8d5d@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8f22c97d-63f7-6d2a-7b1e-92b0b80a5275@gmail.com>
Date:   Sat, 14 Aug 2021 16:45:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8d61d4d5-8e4b-5c18-923c-eceb954e8d5d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

14.08.2021 13:37, Daniel Lezcano пишет:
> On 11/08/2021 11:49, Thierry Reding wrote:
>> On Mon, Jul 19, 2021 at 12:27:06AM +0300, Dmitry Osipenko wrote:
>>> Check whether PMC is ready before proceeding with the cpuidle registration.
>>> This fixes racing with the PMC driver probe order, which results in a
>>> disabled deepest CC6 idling state if cpuidle driver is probed before the
>>> PMC.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/cpuidle/cpuidle-tegra.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>
>> Rafael, Daniel,
>>
>> would you mind if I took this into the Tegra tree? It's got a dependency
>> on the PMC driver, which usually goes via the Tegra tree already, and
>> there's nothing cpuidle-specific in here, it's all Tegra-specific
>> integration quirks.
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I got another thought about how it could be solved. We could move the
creation of the cpuidle platform device into the PMC driver. Thierry,
what do you think?
