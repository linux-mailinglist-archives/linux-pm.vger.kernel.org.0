Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17B5262249
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 00:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgIHWBf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 18:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729961AbgIHWBe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 18:01:34 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE36DC061573;
        Tue,  8 Sep 2020 15:01:33 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c2so838461ljj.12;
        Tue, 08 Sep 2020 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JCz8UqzZZXReRQPrCXAqn/MtSI4k6tdII/zQ2UmwoQk=;
        b=f1IIWICvOCg0UZtuYClNB9BcUCxsnWoE3xVpe4VpTp2B/FUfc9pUTiKKx/tE23IjIn
         J5KatTg+G7cERA60W7U2qwuLgFIxCy4WBKuXv5nE+jUwqShZEd0pK9DnWi0w1I9+DLpE
         3cchXtINfleeHFprtMfvD9TbAgVYUfs4JQq2hmyeDOPuR0pS4WvD6Dsi9x0Hbqb/bCzs
         NACqig3MVoh74UA1GAY3J72v5/P+lZXx5VkNwQeghvD42dUyvJgnrqmqVSi21DVvS5yv
         o/bM7+ONsVsHpb8WWV5QmPrgJzKbCf4SdxT8nt1rEXPS6sgJFKFIVub1i4Ei0SzVf1lX
         BAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JCz8UqzZZXReRQPrCXAqn/MtSI4k6tdII/zQ2UmwoQk=;
        b=gXKyHq12sVs397aEzZFadDI1ebdDlgWWW8CxJqR/cyhkWYoNfGPv7lQWRegmzr95ol
         sjdPtVCQLSnWCPZWd4X/JZcE3HDkiyxZXj0CQqVsIWVSKDCsNRU4hLCvUzwumN2N5cr6
         srO6T0r8x/cGTSPYy683+IeouQKH75utRphRnZAmk/NPighE2FrErXIl03clwXwlysKF
         QieGhV/ukBTzQyVx+NA3j8oxVA3NgEEH3c9xzT+Yq0LZi+iFEhowMweUVNoXN9TiNlqk
         33C04+aDkmy6UT0xCks5Z3j87DVtesIVExjmbJC/JZnhObjCjcYV2KjVA/149gXcIYME
         gQyA==
X-Gm-Message-State: AOAM5308hm1DVw4P0CqsQTsLFUEEAP2Mfxnh9sp3b739AfPJCNHueUEC
        4z273WqnZymQ7Oa3GnQEnnDMv+aLDCo=
X-Google-Smtp-Source: ABdhPJwnOgzNYoPB5eCE0GFByGdksNbNX/vvhO0BA9oM5XpFc+vQALNRgEuH0osDGTLkAca3I7wJKA==
X-Received: by 2002:a2e:9d04:: with SMTP id t4mr285589lji.293.1599602492166;
        Tue, 08 Sep 2020 15:01:32 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id n14sm162405lfi.50.2020.09.08.15.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 15:01:31 -0700 (PDT)
Subject: Re: [PATCH v1 4/6] dt-bindings: mfd: ene-kb3930: Add compatibles for
 KB930 and Acer A500
To:     Rob Herring <robh@kernel.org>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200823140846.19299-1-digetx@gmail.com>
 <20200823140846.19299-5-digetx@gmail.com>
 <20200823182050.GA210632@demiurge.local>
 <b91b96d2-89e1-feb7-a4d0-6fd19a173ab4@gmail.com>
 <20200823211629.GA240555@demiurge.local>
 <c536557c-de42-d6bd-890c-ef71ca0e3116@gmail.com>
 <20200908215352.GA989862@bogus>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3150618f-21db-1974-8e00-1024b6529914@gmail.com>
Date:   Wed, 9 Sep 2020 01:01:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908215352.GA989862@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.09.2020 00:53, Rob Herring пишет:
...
>> Alright, I don't mind to separate the bindings. Although, before doing
>> that, I'd want to get opinion from the device-tree experts, i.e. from
>> Rob Herring :)
>>
>> Rob, will it be fine to have separate bindings for each firmware version
>> of the ENE controller given that firmware is individual for every device
>> and given that FW has no compatibility with other devices?
> 
> Seems like separate bindings makes sense here.

Okay, thank you for the answers and for the review of the v3!
