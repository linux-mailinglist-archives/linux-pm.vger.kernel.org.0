Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18ACAD9A6B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 21:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391106AbfJPTrx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 15:47:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35471 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfJPTrx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 15:47:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id m7so12455lji.2;
        Wed, 16 Oct 2019 12:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bpj8pr3Mgx4MMAZoLFSS7XeyrL1d0H62rgGL89qcaw8=;
        b=P3MqtjHLyYM95wwcrmwuaS3NVH1m0zEpVEfrvKWw7SoYqD0e9Tc4yKY0En8OCTH0xa
         i7PSBV7UbCezaTmeJgULOF6AUGAxE6wWXFRNokvMZpXDcmQ+1+cjH0jmF2jts23sUP5W
         z/bJRMvo9ryufeWRBQsN2HroAs9uO4Do1wckQ6VzKz5/eyTeml7lFzxg3Z01nfinmcOd
         GUBHUvFP0BYjCoO1iHLf57zI5tjFvzrxW02uEZN+k3N1/TCsnlvU2lU3JcLmX8Vu5SUa
         uVowLnFBIqkiXpeCF3UoF65KNiGJ51Rtf3WAvsfD6rijEWZqPVrxvgsKIXZtrtWOHHhk
         /Rsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bpj8pr3Mgx4MMAZoLFSS7XeyrL1d0H62rgGL89qcaw8=;
        b=hlyPHr7PMwZZHCBGR+qsxwM6hH9IoFj3ety+RqL1T3E9oa1YP+ivKrg1oCwVytY5Ol
         uM8mBLpnX2pX4lJURnbTW+LZAr+68mQb/IXUAmjbev/3StnwJyQVmcNszpjBkSfzuNN5
         tvOvyQxP8w5adSTOvVDvuRjUE9t0ij7pX9q42zCdE1GkF0inFeGwhMYqRfRJdiUJB1Zi
         b0D8GjnOCj6SfkzLUMqd5kbeVs1I7P3yQuz0oLDiNmXtWjxaaox0ai+no18s3msr0j2x
         0Amnf5J8V5K32PLvadJFGjqOvDl3wIQeyEq5JqEy0OPpeD2xJBaFi4oKEbX71/IxwqB4
         Lysw==
X-Gm-Message-State: APjAAAXiCs8qxBY0vTYBrf4wPv62m3cnNTq5qq4Ha3hSzetP8rRnfzWu
        1DeeEuSy/sk1hcTz5U56ZIO/bGwg
X-Google-Smtp-Source: APXvYqxOCGP6190Q/1UHPUfMEncNeB8NPn+vi9vIPTzVdAfsQXgTO9RsiW7HtymOqNzTgb0UK2mhgg==
X-Received: by 2002:a2e:9890:: with SMTP id b16mr3378998ljj.181.1571255270162;
        Wed, 16 Oct 2019 12:47:50 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id z26sm6430601lji.79.2019.10.16.12.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 12:47:49 -0700 (PDT)
Subject: Re: [PATCH v6 00/18] Consolidate and improve NVIDIA Tegra CPUIDLE
 driver(s)
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191015170015.1135-1-digetx@gmail.com>
 <20191016192133.GB26038@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <72636eb3-5354-eea3-3a51-4975a04186b2@gmail.com>
Date:   Wed, 16 Oct 2019 22:47:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016192133.GB26038@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.10.2019 22:21, Peter De Schrijver пишет:
> On Tue, Oct 15, 2019 at 07:59:57PM +0300, Dmitry Osipenko wrote:
>> Hello,
>>
>> This series does the following:
>>
>>   1. Unifies Tegra20/30/114 drivers into a single driver and moves it out
>>      into common drivers/cpuidle/ directory.
>>
>>   2. Enables CPU cluster power-down idling state on Tegra30.
>>
>> In the end there is a quite nice clean up of the Tegra CPUIDLE drivers
>> and of the Tegra's arch code in general. Please review, thanks!
>>
>> Changelog:
>>
>> v6: - Addressed request from Thierry Reding to change the way patches are
>>       organized by making changes in a more incremental manner.
>>
>>     - tegra_sleep_cpu() now checks for the secondary CPUs to be offline
>>       in the "Make outer_disable() open-coded" patch.
>>
>> v5: - Rebased on a recent linux-next, fixed one minor conflict in Kconfig.
>>
>>     - Improved commit's message of the "Support CPU cluster power-down state
>>       on Tegra30" patch.
>>
>>     - The "Support CPU cluster power-down state on Tegra30" patch is also
>>       got split and now there is additional "Make outer_disable() open-coded"
>>       patch.
>>
>>     - Made minor cosmetic changes to the "Introduce unified driver for
>>       NVIDIA Tegra SoCs" patch by improving error message and renaming
>>       one variable.
>>
>> v4: - Fixed compilation with !CONFIG_CACHE_L2X0 (and tested that it still
>>       works).
>>
>>     - Replaced ktime_compare() with ktime_before() in the new driver,
>>       for consistency.
>>
>> v3: - Addressed review comments that were made by Jon Hunter to v2 by
>>       splitting patches into smaller (and simpler) chunks, better
>>       documenting changes in the commit messages and using proper error
>>       codes in the code.
>>
>>       Warnings are replaced with a useful error messages in the code of
>>       "Introduce unified driver for NVIDIA Tegra SoCs" patch.
>>
>>       Secondary CPUs parking timeout increased to 100ms because I found
>>       that it actually may happen to take more than 1ms if CPU is running
>>       on a *very* low frequency.
>>
>>       Added diagnostic messages that are reporting Flow Controller state
>>       when CPU parking fails.
>>
>>       Further polished cpuidle driver's code.
>>
>>       The coupled state entering is now aborted if there is a pending SGI
>>       (Software Generated Interrupt) because it will be lost after GIC's
>>       power-cycling. Like it was done by the old Tegra20 CPUIDLE driver.
>>
>> v2: - Added patches to enable the new cpuidle driver in the defconfigs:
>>
>>         ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
>>         ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig
>>
>>     - Dropped patches that removed CPUIDLE_FLAG_TIMER_STOP from the idling
>>       states because that flag actually doesn't have any negative effects,
>>       but still is correct for the case of a local CPU timer on older Tegra
>>       SoCs:
>>
>>         cpuidle: tegra: Remove CPUIDLE_FLAG_TIMER_STOP from Tegra114/124 idle-state
>>         cpuidle: tegra: Remove CPUIDLE_FLAG_TIMER_STOP from all states
>>
>>     - The "Add unified driver for NVIDIA Tegra SoCs" patch got more polish.
>>       Tegra30 and Terga114 states are now squashed into a single common C7
>>       state (following Parker TRM terminology, see 17.2.2.2 Power Management
>>       States), more comments added, etc minor changes.
> 
> It would be useful to switch the power state terminology to the one used
> for later chips:
> 
> LP0 becomes SC7
> LP1 becomes C1
> LP2 becomes CC7
> 
> Meaning of these states is as follows
> 
> C is a core state:
> 
> C1 clock gating
> C2 not defined
> C3 not defined
> C4 not defined
> C5 not defined
> C6 not defined for ARM cores
> C7 power-gating
> 
> CC is a CPU cluster C state:
> 
> CC1 cluster clock gated
> CC2 not defined
> CC3 fmax@Vmin: not used prior to Tegra186
> CC4: cluster retention: no longer supported
> CC5: not defined
> CC6: cluster power gating
> CC7: cluster rail gating
> 
> SC is a System C state:
> 
> SC1: not defined
> SC2: not defined
> SC3: not defined
> SC4: not defined
> SC5: not defined
> SC6: not defined
> SC7: VDD_SOC off

Hello Peter,

But new "drivers/cpuidle/cpuidle-tegra.c" uses exactly that terminology,
please see "cpuidle: Refactor and move NVIDIA Tegra20 driver into
drivers/cpuidle/" and further patches. Am I missing something? Or do you
want the renaming to be a separate patch?
