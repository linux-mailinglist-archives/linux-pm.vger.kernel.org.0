Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3A5E7D96
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 01:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfJ2AsC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 20:48:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34909 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJ2AsB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 20:48:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id y6so9198476lfj.2;
        Mon, 28 Oct 2019 17:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Oh/OJ5hPhsq81kIBvC+sXtskfkbQfbT6/s+yrv+9eXo=;
        b=apgH1+FGot3BqmDg+26T+hWSxeNOqVfofnShuJiFlsBAyDnaBBpIXtNyl5DTjbV9F8
         SZZi10UhtwVaDLPVc+EmLTl3GlUfhHJP4Y/cVBxoievmiibUYrstMXuAGW4PqCBOV0gK
         oiU4A7l/ZHTgFZEskHmfWz2IlpexAGf4kZkx2ql3/Ib5yCzLkScBdjc+Abjt4SR316E0
         j6wQKwvql3ZV08y1/Gop5Odqw3d3kXJthA8xxozMAX6Rz8dQ54dmMlZIf+gXyUZ3t7qv
         Hyyjeiwf+MUJWs6AosbbiRzrGkZ+dkgVAjHJmjJb4Ng9YQ4FjEfFtGlmSqQD7G4cJrIZ
         AbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oh/OJ5hPhsq81kIBvC+sXtskfkbQfbT6/s+yrv+9eXo=;
        b=qMjF1oO2hvRyf37/B5a1PhPo5hGoRHDsizuZIfpl8KofxSc6Ic8N1JbCGnuNreLBrw
         2qZwMfEqpfU7iHMSW0hkTdyvivhy3fFWRz23TK5Tm5HXPFQd6WtnThk0/CdmZuNrobNK
         v6xrUY+y3EZMRwmejd/of0o2Ks1CXHrMIDxRaB/qLnNSGDAJFD93lup+h3AqaK0WrhKK
         orFuRLdLQibcSgUKUtwCEpEAE7awD8Nl9lgjNHotOOw8blzTuuNj7LfCc9YrEQuEDjwW
         KqsHL2EBLsJXDnd9IY8805OB3ne9Q8v58rx6ep4wUzUFEqm8LS79qTpu5MlybzcQhcUQ
         G8Fw==
X-Gm-Message-State: APjAAAWTL7Ng+848sN+q7COu+vEQIhHcf2L8j+tKvaPQAKJ7+LFsiQhd
        gEcKOup+CYzQQ5bjcyLDdDbUJ/R0
X-Google-Smtp-Source: APXvYqzvuJ05fvFMCQCSap8zPzMCmqR1b41PQuP/CHPYMCzmWMiHpKRoFseciyuaLC6sE5/52OPY2w==
X-Received: by 2002:a19:3f0a:: with SMTP id m10mr350872lfa.67.1572310078439;
        Mon, 28 Oct 2019 17:47:58 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id f22sm5347554lfk.56.2019.10.28.17.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2019 17:47:57 -0700 (PDT)
Subject: Re: [PATCH v6 00/18] Consolidate and improve NVIDIA Tegra CPUIDLE
 driver(s)
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191015170015.1135-1-digetx@gmail.com>
 <20191016192133.GB26038@pdeschrijver-desktop.Nvidia.com>
 <72636eb3-5354-eea3-3a51-4975a04186b2@gmail.com>
 <53ee8bd3-5c53-f0aa-175c-7fa3024d0af5@gmail.com>
 <20191028140443.GA27141@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <40de641f-c38e-51ee-ae27-c5db468c45b5@gmail.com>
Date:   Tue, 29 Oct 2019 03:47:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191028140443.GA27141@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

28.10.2019 17:04, Peter De Schrijver пишет:
> On Wed, Oct 16, 2019 at 11:14:07PM +0300, Dmitry Osipenko wrote:
>> 16.10.2019 22:47, Dmitry Osipenko пишет:
>>> 16.10.2019 22:21, Peter De Schrijver пишет:
>>>> On Tue, Oct 15, 2019 at 07:59:57PM +0300, Dmitry Osipenko wrote:
>>>>> Hello,
>>>>>
>>>>> This series does the following:
>>>>>
>>>>>   1. Unifies Tegra20/30/114 drivers into a single driver and moves it out
>>>>>      into common drivers/cpuidle/ directory.
>>>>>
>>>>>   2. Enables CPU cluster power-down idling state on Tegra30.
>>>>>
>>>>> In the end there is a quite nice clean up of the Tegra CPUIDLE drivers
>>>>> and of the Tegra's arch code in general. Please review, thanks!
>>>>>
>>>>> Changelog:
>>>>>
>>>>> v6: - Addressed request from Thierry Reding to change the way patches are
>>>>>       organized by making changes in a more incremental manner.
>>>>>
>>>>>     - tegra_sleep_cpu() now checks for the secondary CPUs to be offline
>>>>>       in the "Make outer_disable() open-coded" patch.
>>>>>
>>>>> v5: - Rebased on a recent linux-next, fixed one minor conflict in Kconfig.
>>>>>
>>>>>     - Improved commit's message of the "Support CPU cluster power-down state
>>>>>       on Tegra30" patch.
>>>>>
>>>>>     - The "Support CPU cluster power-down state on Tegra30" patch is also
>>>>>       got split and now there is additional "Make outer_disable() open-coded"
>>>>>       patch.
>>>>>
>>>>>     - Made minor cosmetic changes to the "Introduce unified driver for
>>>>>       NVIDIA Tegra SoCs" patch by improving error message and renaming
>>>>>       one variable.
>>>>>
>>>>> v4: - Fixed compilation with !CONFIG_CACHE_L2X0 (and tested that it still
>>>>>       works).
>>>>>
>>>>>     - Replaced ktime_compare() with ktime_before() in the new driver,
>>>>>       for consistency.
>>>>>
>>>>> v3: - Addressed review comments that were made by Jon Hunter to v2 by
>>>>>       splitting patches into smaller (and simpler) chunks, better
>>>>>       documenting changes in the commit messages and using proper error
>>>>>       codes in the code.
>>>>>
>>>>>       Warnings are replaced with a useful error messages in the code of
>>>>>       "Introduce unified driver for NVIDIA Tegra SoCs" patch.
>>>>>
>>>>>       Secondary CPUs parking timeout increased to 100ms because I found
>>>>>       that it actually may happen to take more than 1ms if CPU is running
>>>>>       on a *very* low frequency.
>>>>>
>>>>>       Added diagnostic messages that are reporting Flow Controller state
>>>>>       when CPU parking fails.
>>>>>
>>>>>       Further polished cpuidle driver's code.
>>>>>
>>>>>       The coupled state entering is now aborted if there is a pending SGI
>>>>>       (Software Generated Interrupt) because it will be lost after GIC's
>>>>>       power-cycling. Like it was done by the old Tegra20 CPUIDLE driver.
>>>>>
>>>>> v2: - Added patches to enable the new cpuidle driver in the defconfigs:
>>>>>
>>>>>         ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
>>>>>         ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig
>>>>>
>>>>>     - Dropped patches that removed CPUIDLE_FLAG_TIMER_STOP from the idling
>>>>>       states because that flag actually doesn't have any negative effects,
>>>>>       but still is correct for the case of a local CPU timer on older Tegra
>>>>>       SoCs:
>>>>>
>>>>>         cpuidle: tegra: Remove CPUIDLE_FLAG_TIMER_STOP from Tegra114/124 idle-state
>>>>>         cpuidle: tegra: Remove CPUIDLE_FLAG_TIMER_STOP from all states
>>>>>
>>>>>     - The "Add unified driver for NVIDIA Tegra SoCs" patch got more polish.
>>>>>       Tegra30 and Terga114 states are now squashed into a single common C7
>>>>>       state (following Parker TRM terminology, see 17.2.2.2 Power Management
>>>>>       States), more comments added, etc minor changes.
>>>>
>>>> It would be useful to switch the power state terminology to the one used
>>>> for later chips:
>>>>
>>>> LP0 becomes SC7
>>>> LP1 becomes C1
>>>> LP2 becomes CC7
>>>>
>>>> Meaning of these states is as follows
>>>>
>>>> C is a core state:
>>>>
>>>> C1 clock gating
>>>> C2 not defined
>>>> C3 not defined
>>>> C4 not defined
>>>> C5 not defined
>>>> C6 not defined for ARM cores
>>>> C7 power-gating
>>>>
>>>> CC is a CPU cluster C state:
>>>>
>>>> CC1 cluster clock gated
>>>> CC2 not defined
>>>> CC3 fmax@Vmin: not used prior to Tegra186
>>>> CC4: cluster retention: no longer supported
>>>> CC5: not defined
>>>> CC6: cluster power gating
>>>> CC7: cluster rail gating
>>>>
>>>> SC is a System C state:
>>>>
>>>> SC1: not defined
>>>> SC2: not defined
>>>> SC3: not defined
>>>> SC4: not defined
>>>> SC5: not defined
>>>> SC6: not defined
>>>> SC7: VDD_SOC off
>>>
>>> Hello Peter,
>>>
>>> But new "drivers/cpuidle/cpuidle-tegra.c" uses exactly that terminology,
>>> please see "cpuidle: Refactor and move NVIDIA Tegra20 driver into
>>> drivers/cpuidle/" and further patches. Am I missing something? Or do you
>>> want the renaming to be a separate patch?
>>>
>>
>> Or maybe you're suggesting to change the names everywhere and not only
>> in the cpuidle driver? Please clarify :)
> 
> At least some of the variable and function names still say lp2?

The cpuidle driver uses LP2 terminology for everything that comes from
the external arch / firmware includes. But it says CC6 for everything
that is internal to the driver. So yes, there is a bit of new/old
terminology mixing in the code.

The arch code / PMC driver / TF firmware are all saying LP2. The LP2
naming is also a part of the device-tree binding.

It will be a lot of mess to rename the mach-tegra/pm.c code. I guess
eventually it could be moved to drivers/soc/, so maybe it will be better
to postpone the renaming until then?
