Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFBF168656
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 19:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgBUSUh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 13:20:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36511 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgBUSUh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 13:20:37 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so3170973ljg.3;
        Fri, 21 Feb 2020 10:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C/E0xAjOCzonbvn0GhLbHdAipH5CVwsvYZUDR+hNQS4=;
        b=LKGAvzC9Qi31ga4E7gObDwA/wkunftsW36SXCKS+z3e2ryzms7/Kk1l7WHrD8SLY68
         zMGyCaAV/OjRq+1HlLtIAg/SFZsk531KCh2QvMVkykPPWYJO1nifmzxsfBKw8mmxPioj
         LoKGhkwkTB4uj6iIpnwCgYmN7Q2FDeV+TVxe9VIXg/ZqmbA3UNfpmyRsS1tXQUGlvUd2
         ZyHpZdYn4x+dFVYZaGCvQPQuv1lHbLRsibFJVqB7WX7yBNH0k2hU9NOC54j+cqlU5l+8
         vB6pZAVFuGDLVEvSV8dr2IPL9Ku47JjQAHWWulD0uVj2CAEHN/mXnFPadG3YF89LQ+ZS
         kwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C/E0xAjOCzonbvn0GhLbHdAipH5CVwsvYZUDR+hNQS4=;
        b=WptLRENIlGu+CHr38hduF2Ov3aX1oBvlg+wGileoEb0BPqoLbfI+Q7gHDzaCyvInHj
         0vMA7GfVkkgc22MgI/+RqsC66K5EImlFVgmz7Ra4c7FCCdAgvEYhp3XD7kTMUEgnWcSH
         S45S55zqmKpuf7SuCkjCjx638Bdiuo7WVMTsDixrvpYgDM3LENsxdyP6KipM94tjisIm
         K8rCA+rJhZzRnGib0Gt7lEXAgdlKVcfVRDMab5wZlG8+Ksuy7l+isUqZ5ytGNyJzZNXI
         KfPFvtmPsCwFatQPKjp11rybpcDa3vUaz0f9ZgMkAceNA2/Yu30NpHi3YdGgl/+Zn7ja
         IjzQ==
X-Gm-Message-State: APjAAAUH6eXWV2iOu6mWLn3Fd7fVH21CiRTZaRo9xfMuKEEkZJijPqsK
        ZPNX3pKzkTL5kcE5N8jHkXrRRed+
X-Google-Smtp-Source: APXvYqyOq+v4Eh6q5hcFWzhG0NPLOok3SvgWv8r5p2HWHU7QWWRYRDbO/750ZdsoHcCoZyDQdoKjOg==
X-Received: by 2002:a2e:844e:: with SMTP id u14mr22731544ljh.183.1582309234179;
        Fri, 21 Feb 2020 10:20:34 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id u22sm2084441lff.65.2020.02.21.10.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 10:20:33 -0800 (PST)
Subject: Re: [PATCH v9 13/17] cpuidle: tegra: Squash Tegra30 driver into the
 common driver
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-14-digetx@gmail.com>
 <20200221162951.GQ10516@linaro.org>
 <89a9838c-faf3-b890-cea2-aad53df1eac3@gmail.com>
 <20200221174128.GW10516@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9de1aad1-1926-db4d-73e3-d10f77bb8a36@gmail.com>
Date:   Fri, 21 Feb 2020 21:20:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200221174128.GW10516@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.02.2020 20:41, Daniel Lezcano пишет:
> On Fri, Feb 21, 2020 at 07:59:14PM +0300, Dmitry Osipenko wrote:
>> 21.02.2020 19:29, Daniel Lezcano пишет:
>>> On Thu, Feb 13, 2020 at 02:51:30AM +0300, Dmitry Osipenko wrote:
>>>> Tegra20 and Terga30 SoCs have common C1 and CC6 idling states and thus
>>>> share the same code paths, there is no point in having separate drivers
>>>> for a similar hardware. This patch merely moves functionality of the old
>>>> driver into the new, although the CC6 state is kept disabled for now since
>>>> old driver had a rudimentary support for this state (allowing to enter
>>>> into CC6 only when secondary CPUs are put offline), while new driver can
>>>> provide a full-featured support. The new feature will be enabled by
>>>> another patch.
>>>>
>>>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>>>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>>>> Tested-by: Jasper Korten <jja2000@gmail.com>
>>>> Tested-by: David Heidelberg <david@ixit.cz>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  arch/arm/mach-tegra/Makefile          |   3 -
>>>>  arch/arm/mach-tegra/cpuidle-tegra30.c | 123 --------------------------
>>>
>>> Add the -M option when resending please.
>>
>> Okay, thank you very much for taking a look at the patches!
> 
> Yeah, sorry for the delay. Nice cleanup BTW.

No problems, thank you :)
