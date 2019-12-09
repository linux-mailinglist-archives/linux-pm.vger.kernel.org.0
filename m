Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3032117853
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 22:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfLIVWX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 16:22:23 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43509 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLIVWX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 16:22:23 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so17341201ljm.10;
        Mon, 09 Dec 2019 13:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hfN3ul6hjpl2dirTMlovPdIO/5/d4Exh0KyMwDDvy9s=;
        b=aUTP4Id4O4xbxCmkQMemUqwf+A6XD+HWrtRRDtNvHeAqGPYt2T8zoBr8af50sSF/oh
         xqCUEMME2zGnIDV506uYLvC+55NONJC2GZD3Y4rxe4Iz7tkTxtB2Za1zo36pWtR2UAEh
         gjx4z0BLc3W/F7zrsdBmgpOORCvU/ByXEicuBJyz0by+jfoRFmEuI9CFvOZ0Kj50qJQY
         jzcR+MEBiYLrFmGsfkRHKgFHtdCjdAuFy5AOMMmU6m4sd+r3xN+bJxRSQ5KIJHPkM4sg
         Jmk3qM7H5wgXEyw2LPRE+jZVBCP7JeQ8boLIcTXKq72tMPsQEkRuS5pzsfl7ezpKiHn2
         sD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hfN3ul6hjpl2dirTMlovPdIO/5/d4Exh0KyMwDDvy9s=;
        b=tVPAo+Zpo80nE29T3Y0EQnY1rc2uNgyxzOH2zqQPpStcA1dN7xD0k3GLWMpwpq/Ggq
         j8Oqe0/hTNCGICwJ3+pYuV08Pj5cqofM+yVMknK+2BDzp11plZRa4409a+YHmx/BR/U+
         2Gpd4Vj0pUd0ODG8chcx7JkCVKMEnexWRXBapo5/DumRaPIOR0Lgp3R69Upb/cdhGjHf
         wuz4LPqabsmfF93bClID4Xfqlrk5zmxz2XyoL4qHqpfYj67XsFhvb5UB0LoAg7IHqR2Y
         ajOqguVBaDdecWaYYuM/fQPAPOR2swZb/wYLaQxQ0v2mAsnaU4SFb1msRdMrecU5/h96
         bA9Q==
X-Gm-Message-State: APjAAAVm7bkayiwq6OgwQq7QjSEF5BPMhwzbofh3HPsp2Coedk11Vh9x
        YSMC6UxJVtJZ93T5U0LEXw46gE3G
X-Google-Smtp-Source: APXvYqzkedDuJ1mylj4K6QNH/bG8ZkXNM30pZ3tfzuwZ2lJA23WGf4luIwH5aJBrVQwHx+41Wuj0yg==
X-Received: by 2002:a2e:7e07:: with SMTP id z7mr16979405ljc.165.1575926540462;
        Mon, 09 Dec 2019 13:22:20 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id s16sm300639lfc.35.2019.12.09.13.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 13:22:19 -0800 (PST)
Subject: Re: [PATCH v8 00/19] Consolidate and improve NVIDIA Tegra CPUIDLE
 driver(s)
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191203004116.11771-1-digetx@gmail.com>
 <20191207215216.GA9561@qmqm.qmqm.pl>
 <0b3a861d-e5e8-ddca-ac60-0a3c61a9d9dc@gmail.com>
 <20191209160420.GA24097@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <323f5f70-5249-e75a-98cc-7fdca2d375c2@gmail.com>
Date:   Tue, 10 Dec 2019 00:22:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191209160420.GA24097@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.12.2019 19:04, Michał Mirosław пишет:
> On Sun, Dec 08, 2019 at 01:56:14AM +0300, Dmitry Osipenko wrote:
>> 08.12.2019 00:52, Michał Mirosław пишет:
>>> On Tue, Dec 03, 2019 at 03:40:57AM +0300, Dmitry Osipenko wrote:
>>>> Hello,
>>>>
>>>> This series does the following:
>>>>
>>>>   1. Unifies Tegra20/30/114 drivers into a single driver and moves it out
>>>>      into common drivers/cpuidle/ directory.
>>>>
>>>>   2. Enables CPU cluster power-down idling state on Tegra30.
>>>>
>>>> In the end there is a quite nice clean up of the Tegra CPUIDLE drivers
>>>> and of the Tegra's arch code in general. Please review, thanks!
>>>
>>> I did a quick smoke test for this series on top of Linus' master:
>>>  - rebuilding with the patches applied, CONFIG_ARM_TEGRA_CPUIDLE=n - works
>>>  - building with CONFIG_ARM_TEGRA_CPUIDLE=y - doesn't boot
>>>
>>> The hang is somewhere early in the boot process, before simplefb can
>>> take the console and show any logs. If I get BOOTFB to work again I might
>>> be able to get some more info.
>>
>> Thank you very much for trying these patches!
>>
>> Could you please try to make ARM_TEGRA_CPUIDLE "tristate" in the Kconfig
>> and compile it as a loadable module? That way you'll get framebuffer
>> shown before the hang happens.
>>
>> Does LP2 suspend/resume work for you? There should be
>> "nvidia,suspend-mode = <2>" in the PMC's node of device-tree.
> 
> Not at the moment. I also tried suspend-mode = <1> and <0>, but it
> made no difference.

If LP2 doesn't work, then it explains why you're getting the hang.

Are you using TF300T for the testing? I'm recalling that LP2 worked for
you sometime ago on TF300T, maybe some offending change was introduced
since then. Could you please try to do the git bisection or at least
find out what is the last good kernel version?

I rebased this series on a recent linux-next and you could find the
rebased patches here [1].

[1] https://github.com/grate-driver/linux/commits/master

With [1] you should be able to remove "nvidia,suspend-mode" property
from the device-tree to get cpuidle working with the disabled CC6 state
(LP2). Could you please check that at least disabled CC6 works for you?
