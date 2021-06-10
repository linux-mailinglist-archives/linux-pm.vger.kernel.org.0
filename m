Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E61A3A2FF9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 17:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhFJQB1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 12:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhFJQB1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 12:01:27 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4096DC061574;
        Thu, 10 Jun 2021 08:59:18 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id l184so119957pgd.8;
        Thu, 10 Jun 2021 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gEOhLn04ufSH/EYWeHJiDResBxu7Zjy3LEUOA404M9M=;
        b=MvNErbbuJgsYARWhegkk6WNOEMgQbvVcbR6iy+mrAf8t7qZEQVAxp85okAny4keJwX
         ktOiDfhx4YSPeOjaSjn/FAnDn1o1k0B1UQP3Pmrgpo6e9oiLdScB6ih72n/LORqPLHTx
         2VUoOZ01+qKFp/xpD7TNsWYLe9AQEWeB7x1mZurgDS0W90mzURpQcKdKnd5lc7XTjStO
         Y1TRsa3iOSUUbArQiTztEZzJ2UUUuih/Q2gM5x0OVoL9iH8CKLa2xlxm8qr0AgsOuW9B
         K0DFR3SSjqIVPPZ7TDp8Ok8JzMstH0xwBLoUeElcE+B7PNX1GB4APwxDOjjLyKrdtljF
         44xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gEOhLn04ufSH/EYWeHJiDResBxu7Zjy3LEUOA404M9M=;
        b=TNTkHt1N4yGdcNzVp26dIw6GlZs1UqX0iCA9APBeSK/P30n9o8z1+ZRRjDoU2lgkhf
         6SIOViogWuiVTuk/Qj+o+fDl/Qp7X7ldPJ19HVDos8GyfrGVhCQgW1VDrVpVRoors1u+
         6B/gnNXXaVlh97pSAYBorIqFFRXHXP8L/CWWqMWe0/8dx5m8JdusnWeLsarYmIJFgd8W
         QubgUKegnCk2vsYvkx1HaAnX4p5T5KZLa8CBzQeg7bSU30h3j1Fj7/iFT5JGQLfTKBbm
         INZjcDQ2ygtLVWg5CE/xgG3nC4f+As/Wx1xHWes2p3APkN11k+MOG4K0IDHUZzHSniyN
         tgoA==
X-Gm-Message-State: AOAM531DO0/FRlmzcoDacCGPZKaIDHpnbrBTlPeGFygqtMkXWxCBMyMB
        LjziUGkX386yMTADVX8C6xQ=
X-Google-Smtp-Source: ABdhPJx9vmsDtDTL4nbg98zKMRj7QHMyQ/zFV0vq4rlqsoMu8CSPycYkvg5HeWMzsT0A8Xewb8Gt3A==
X-Received: by 2002:a63:ff1f:: with SMTP id k31mr5482804pgi.315.1623340757631;
        Thu, 10 Jun 2021 08:59:17 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p20sm2708534pff.204.2021.06.10.08.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 08:59:17 -0700 (PDT)
Subject: Re: [PATCH 2/2] mmc: sdhci-iproc: Add support for the legacy sdhci
 controller on the BCM7211
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Al Cooper <alcooperx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Scott Branden <sbranden@broadcom.com>
References: <20210602192758.38735-1-alcooperx@gmail.com>
 <20210602192758.38735-2-alcooperx@gmail.com>
 <CAPDyKFrynST66yA_T3iroiJsfmNuBOEiiBnb=vNoyP6QpvZ7aQ@mail.gmail.com>
 <fe956941-bb39-413e-f051-d9f353f64eda@gmail.com>
 <CAPDyKFpEtvjS1mWC68gRBWD64dq2M1LO84UWE5uDLTzbGz1g8Q@mail.gmail.com>
 <6acd480a-8928-89bb-0f40-d278294973a1@gmail.com>
 <CAPDyKFqk23xg5R2k9GwQrnamwWYbMkmrbWYsHPF9VBQTAbvQHw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a1199e99-eb29-125b-2bac-f0abb4803c9b@gmail.com>
Date:   Thu, 10 Jun 2021 08:59:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqk23xg5R2k9GwQrnamwWYbMkmrbWYsHPF9VBQTAbvQHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/10/2021 1:49 AM, Ulf Hansson wrote:
> On Thu, 10 Jun 2021 at 01:59, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>>
>>
>> On 6/9/2021 2:22 AM, Ulf Hansson wrote:
>>> On Wed, 9 Jun 2021 at 05:07, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 6/8/2021 5:40 AM, Ulf Hansson wrote:
>>>>> On Wed, 2 Jun 2021 at 21:28, Al Cooper <alcooperx@gmail.com> wrote:
>>>>>>
>>>>>> Add support for the legacy Arasan sdhci controller on the BCM7211 and
>>>>>> related SoC's. This includes adding a .shutdown callback to increase
>>>>>> the power savings during S5.
>>>>>
>>>>> Please split this into two separate changes.
>>>>>
>>>>> May I also ask about the ->shutdown() callback and in relation to S5.
>>>>> What makes the ->shutdown callback only being invoked for S5?
>>>>
>>>> It is not only called for S5 (entered via poweroff on a prompt) but also
>>>> during kexec or reboot. The poweroff path is via:
>>>>
>>>> kernel_power_off() -> kernel_shutdown_prepare() -> device_shutdown() ->
>>>> .shutdown()
>>>>
>>>> For kexec or reboot we do not really care about power savings since we
>>>> are about to load a new image anyway, however for S5/poweroff we do care
>>>> about quiescing the eMMC controller in a way that its clocks and the
>>>> eMMC device can be put into low power mode since we will stay in that
>>>> mode for seconds/hours/days until someone presses a button on their
>>>> remote (or other wake-up sources).
>>>
>>> Hmm, I am not sure I understand correctly. At shutdown we don't care
>>> about wake-up sources from the kernel point of view, instead we treat
>>> everything as if it will be powered off.
>>
>> The same .shutdown() path is used whether you kexec, reboot or poweroff,
>> but for poweroff we do care about allowing specific wake-up sources
>> configured as such to wake-up the system at a later time, like GPIOs,
>> RTC, etc.
> 
> That's true, but using the ->shutdown() callbacks in this way would
> certainly be a new use case.
> 
> Most subsystems/drivers don't care about power management in those
> callbacks, but rather just about managing a graceful shutdown.
> 
> It sounds to me like you should have a look at the hibernation
> path/callbacks instead - or perhaps even the system suspend
> path/callback. Normally, that's where we care about power management.

The platforms we use do not support hibernation, keep in mind that these
are embedded SoCs that support the S2 (standby), S3 (mem) and poweroff
suspend states, hibernation is not something that we can support.

> 
> I have looped in Rafael, to allow him to share his opinion on this.
> 
>>
>>>
>>> We put devices into low power state at system suspend and potentially
>>> also during some of the hibernation phases.
>>>
>>> Graceful shutdown of the eMMC is also managed by the mmc core.
>>
>> AFAICT that calls mmc_blk_shutdown() but that is pretty much it, the
>> SDHCI platform_driver still needs to do something in order to conserve
>> power including disabling host->clk, otherwise we would not have done
>> that for sdhci-brcmstb.c.
> 
> That's not entirely correct. When mmc_bus_shutdown() is called for the
> struct device* that belongs to an eMMC card, two actions are taken.
> 
> *) We call mmc_blk_shutdown(), to suspend the block device queue from
> receiving new I/O requests.
> **) We call host->bus_ops->shutdown(), which is an eMMC specific
> callback set to mmc_shutdown(). In this step, we do a graceful
> shutdown/power-off of the eMMC card.
> 
> When it comes to controller specific resources, like clocks and PM
> domains, for example, those may very well stay turned on. Do deal with
> these, then yes, you would need to implement the ->shutdown()
> callback. But as I said above, I am not sure it's the right thing to
> do.

As explained before, we can enter S5 for an indefinite amount of time
until a wake-up source wakes us up so we must conserve power, even if we
happen to wake up the next second, we don't know that ahead of time. The
point of calling sdhci_pltfm_suspend() here is to ensure that host->clk
is turned off which cuts the eMMC controller digital clock, I forgot how
much power we save by doing so, but every 10s of mW counts for us.
-- 
Florian
