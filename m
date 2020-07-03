Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBD621364A
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 10:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgGCIVI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 04:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGCIVI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2020 04:21:08 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EBDC08C5C1;
        Fri,  3 Jul 2020 01:21:07 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id o4so18004657lfi.7;
        Fri, 03 Jul 2020 01:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R3DXWe/7kffwAkZY5CuO0mg5y/MW32bQD7iUuOlWvjA=;
        b=T7sDBYf2EJVFVlZiG90k4/S+CPDEHBEarBT1uTJkaCGF3HVtF8eOi9CDQ+aHvlqnXQ
         nm7RzyBvtVL8kBGopKyQfcImX8Srzn4+ay+GPESM+pGPewRmwhZGW7Esvu9t0Sgkwpsx
         M146OX2cUdY43VYg30eK0+t7ggnx2vSKX/Whu0iArmHpPw0cs//ikzhcDHfOilaSQxFo
         AelddUCc+K7bnV20ZyBuEleNfdrd0uMKIFovW1IZmLx0TUKtwEQdeNwmJyPrTcoOWY0g
         orCeliygk/p6edAJVkTfy/39zO4RN0VBcSBCpJtzuq8gZ12vbPF8yYK4EYZQhB8RFW08
         cIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R3DXWe/7kffwAkZY5CuO0mg5y/MW32bQD7iUuOlWvjA=;
        b=GVLGt8j2HzIQrIKtTj3bSESbXcx2js6JYGuhqDEMeIsDgHGumNfmN23FxiRWqQustW
         xPHx6dIPU4vrDh262YmR5XmYbHmuAZ+fP9HQ9Z3T0Rv0m0ehtQpnjtDw/sY19uoUHQWj
         EPu1F+HBYhXR7oUwHGpJbxsWFjQgRYKYV3LNXM39nVqNOrYCk3j817JFu5R4v2mzrjv2
         9xjG7nIpuP+lIVagYwJSUzw8dYGdkbRzBCRkOGQE586pp3HYhoOJHQ1SNW14U5m7zQy7
         Qn0aIOwLGAvLFSuxA6n68+Ns598knKARKxq0ePZ25q37IyV9HCA7yxfBc4sZ8Isi0TYm
         CVhQ==
X-Gm-Message-State: AOAM533E2LTpR+0ml0DTSDelQXdtTabUaptSxsJLcuVWqLPPzxlpJmv4
        GjxZOgnlGTX9KXbWSZ3dWko+hpRZ4Z0=
X-Google-Smtp-Source: ABdhPJwPnozSkJ2XzdKc+tafvTvERFYy06y/KVN/pGEFisb8WeHehrR2cSDS/OOZ4LlJ6y23zfNkPg==
X-Received: by 2002:a05:6512:203b:: with SMTP id s27mr4115815lfs.158.1593764465014;
        Fri, 03 Jul 2020 01:21:05 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id 203sm4396573lfh.19.2020.07.03.01.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 01:21:04 -0700 (PDT)
Subject: Re: [PATCH v2] PM / devfreq: tegra: Add Dmitry as a maintainer
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CGME20200402222006epcas1p4027cd509b32ba2d2bdf90e9e84cf4bec@epcas1p4.samsung.com>
 <20200402221723.6064-1-digetx@gmail.com>
 <921abb5e-8c12-db8b-b345-fbe49080dc1c@samsung.com>
 <a08f16bc-df90-2199-91c8-f2acfe0f94ad@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <33a4df9d-7642-2f64-e073-ef6091f1ca33@gmail.com>
Date:   Fri, 3 Jul 2020 11:21:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a08f16bc-df90-2199-91c8-f2acfe0f94ad@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

03.07.2020 03:44, Chanwoo Choi пишет:
> Dear all,
> 
> On 5/8/20 1:04 PM, Chanwoo Choi wrote:
>> Hi Rafael,
>>
>> Could you please apply it to linux-pm directly?
>>
>> I think that it is better to be applied directly
>> for preventing the possible merge conflict of MAINTAINERS file.
>>
>> Best Regards,
>> Chanwoo Choi
>>
>> On 4/3/20 7:17 AM, Dmitry Osipenko wrote:
>>> I was contributing to the NVIDIA Tegra20+ devfreq drivers recently and
>>> want to help keep them working and evolving in the future.
>>>
>>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>
>>> Changelog:
>>>
>>> v2: - Addressed review comments made by Chanwoo Choi to v1 by correcting
>>>       git's address, making this patch standalone and adding Rafael Wysocki
>>>       to the list of email recipients.
>>>
>>>  MAINTAINERS | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 245a96316636..0a694e20ea19 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -10922,6 +10922,15 @@ F:	include/linux/memblock.h
>>>  F:	mm/memblock.c
>>>  F:	Documentation/core-api/boot-time-mm.rst
>>>  
>>> +MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA
>>> +M:	Dmitry Osipenko <digetx@gmail.com>
>>> +L:	linux-pm@vger.kernel.org
>>> +L:	linux-tegra@vger.kernel.org
>>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
>>> +S:	Maintained
>>> +F:	drivers/devfreq/tegra20-devfreq.c
>>> +F:	drivers/devfreq/tegra30-devfreq.c
>>> +
>>>  MEMORY MANAGEMENT
>>>  M:	Andrew Morton <akpm@linux-foundation.org>
>>>  L:	linux-mm@kvack.org
>>>
>>
>>
> 
> I applied it to devfreq-next branch. Thanks.

Hello, Chanwoo! Thank you very much! :)

