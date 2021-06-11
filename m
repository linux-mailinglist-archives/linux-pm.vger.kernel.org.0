Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC733A4713
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 18:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhFKQ57 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Jun 2021 12:57:59 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:34749 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFKQ57 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jun 2021 12:57:59 -0400
Received: by mail-pg1-f170.google.com with SMTP id l1so2967004pgm.1;
        Fri, 11 Jun 2021 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eOlkoTfGj5WVDhRnQCIRockeDZbW6gvXOn1hNr+Rd2g=;
        b=j+W9JDxX+UOqQOy1Rik3ezLT5/EwreVn5+ywE686P15vhF/BffKXoXFbwZiDEmcDJi
         sOY61C+BiW2e1xKMbHa4JcY2ItvGJ01q6u379JhYfarZuKrvCzZURJrG6Zkq9o30uy4i
         waP2xGRgt7ClLlo1ejFAsX/DEC+rIV8FZ8OKAcAk3VO4yk9iWotdOQ0nYcR67rLB1hkX
         zBZ5qY14X2G24UKU9gM8pksq7LqnaJPZIihJ/tltwqdNmXg2xEZB0V4fqP2EzW/2Wu4S
         TGABmAuxyGxc9TNkDuoXvaH6izjk0IXq65+QWFX708h0FHpLouv4us6O7NL/wwkWiqZi
         irsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eOlkoTfGj5WVDhRnQCIRockeDZbW6gvXOn1hNr+Rd2g=;
        b=qSaMOErsWzEL1wXIO3AQMLRSN65q6JefYkcQ7I5AKfw/hN+kx39sljNc0tpAmaAhzK
         2LjjKysw/o/KH2fwcgS33TwlTUK6HTKfVyHSDPJQhkdhoDz850b4qj8nGrydfNZYhlf9
         sMWimS9wEf9VL6N1g83/hWR9M5XCYzLfnsc6UcJXXoqlbotoEU/wMBknwb81MOQplZir
         Ea5tGF1i+Ojl0vqHiCFY8J1pHMrAENTC0D/Rfkp4BUUr6JPIA/gfq2sz+YcQkjEn+8xe
         RNqnuxglZQrhLuRQevwZpka63hfU/Y1BmMgTuwIEYnEXJRqbH/sexT43z664ffz+yshQ
         kb+g==
X-Gm-Message-State: AOAM532m/c7o5wRMujltARUfV/8xEbIkBDwvBh8eOwotw536cF17JKTh
        Dq9hu0vMWp6yJQPfwYBUJgg=
X-Google-Smtp-Source: ABdhPJz9kNGw9WY8PUrVoC4RNkOSJInnurD+RcgOjd2YX86UFEggs6C6s2CjLfa6jif3g9podQ29eA==
X-Received: by 2002:a63:5522:: with SMTP id j34mr4537401pgb.148.1623430489795;
        Fri, 11 Jun 2021 09:54:49 -0700 (PDT)
Received: from [192.168.1.67] (99-44-17-11.lightspeed.irvnca.sbcglobal.net. [99.44.17.11])
        by smtp.gmail.com with ESMTPSA id h12sm5829720pfq.72.2021.06.11.09.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 09:54:49 -0700 (PDT)
Subject: Re: [PATCH 2/2] mmc: sdhci-iproc: Add support for the legacy sdhci
 controller on the BCM7211
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
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
 <a1199e99-eb29-125b-2bac-f0abb4803c9b@gmail.com>
 <CAPDyKFq-rofbCyAhcQGt2xZykip6Le+CUDXgDwAisVOj=Tt-uA@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b4c36944-8f41-1f30-10b4-b3efe0aade01@gmail.com>
Date:   Fri, 11 Jun 2021 09:54:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq-rofbCyAhcQGt2xZykip6Le+CUDXgDwAisVOj=Tt-uA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/11/2021 3:23 AM, Ulf Hansson wrote:
> On Thu, 10 Jun 2021 at 17:59, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>>
>>
>> On 6/10/2021 1:49 AM, Ulf Hansson wrote:
>>> On Thu, 10 Jun 2021 at 01:59, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 6/9/2021 2:22 AM, Ulf Hansson wrote:
>>>>> On Wed, 9 Jun 2021 at 05:07, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 6/8/2021 5:40 AM, Ulf Hansson wrote:
>>>>>>> On Wed, 2 Jun 2021 at 21:28, Al Cooper <alcooperx@gmail.com> wrote:
>>>>>>>>
>>>>>>>> Add support for the legacy Arasan sdhci controller on the BCM7211 and
>>>>>>>> related SoC's. This includes adding a .shutdown callback to increase
>>>>>>>> the power savings during S5.
>>>>>>>
>>>>>>> Please split this into two separate changes.
>>>>>>>
>>>>>>> May I also ask about the ->shutdown() callback and in relation to S5.
>>>>>>> What makes the ->shutdown callback only being invoked for S5?
>>>>>>
>>>>>> It is not only called for S5 (entered via poweroff on a prompt) but also
>>>>>> during kexec or reboot. The poweroff path is via:
>>>>>>
>>>>>> kernel_power_off() -> kernel_shutdown_prepare() -> device_shutdown() ->
>>>>>> .shutdown()
>>>>>>
>>>>>> For kexec or reboot we do not really care about power savings since we
>>>>>> are about to load a new image anyway, however for S5/poweroff we do care
>>>>>> about quiescing the eMMC controller in a way that its clocks and the
>>>>>> eMMC device can be put into low power mode since we will stay in that
>>>>>> mode for seconds/hours/days until someone presses a button on their
>>>>>> remote (or other wake-up sources).
>>>>>
>>>>> Hmm, I am not sure I understand correctly. At shutdown we don't care
>>>>> about wake-up sources from the kernel point of view, instead we treat
>>>>> everything as if it will be powered off.
>>>>
>>>> The same .shutdown() path is used whether you kexec, reboot or poweroff,
>>>> but for poweroff we do care about allowing specific wake-up sources
>>>> configured as such to wake-up the system at a later time, like GPIOs,
>>>> RTC, etc.
>>>
>>> That's true, but using the ->shutdown() callbacks in this way would
>>> certainly be a new use case.
>>>
>>> Most subsystems/drivers don't care about power management in those
>>> callbacks, but rather just about managing a graceful shutdown.
>>>
>>> It sounds to me like you should have a look at the hibernation
>>> path/callbacks instead - or perhaps even the system suspend
>>> path/callback. Normally, that's where we care about power management.
>>
>> The platforms we use do not support hibernation, keep in mind that these
>> are embedded SoCs that support the S2 (standby), S3 (mem) and poweroff
>> suspend states, hibernation is not something that we can support.
>>
>>>
>>> I have looped in Rafael, to allow him to share his opinion on this.
>>>
>>>>
>>>>>
>>>>> We put devices into low power state at system suspend and potentially
>>>>> also during some of the hibernation phases.
>>>>>
>>>>> Graceful shutdown of the eMMC is also managed by the mmc core.
>>>>
>>>> AFAICT that calls mmc_blk_shutdown() but that is pretty much it, the
>>>> SDHCI platform_driver still needs to do something in order to conserve
>>>> power including disabling host->clk, otherwise we would not have done
>>>> that for sdhci-brcmstb.c.
>>>
>>> That's not entirely correct. When mmc_bus_shutdown() is called for the
>>> struct device* that belongs to an eMMC card, two actions are taken.
>>>
>>> *) We call mmc_blk_shutdown(), to suspend the block device queue from
>>> receiving new I/O requests.
>>> **) We call host->bus_ops->shutdown(), which is an eMMC specific
>>> callback set to mmc_shutdown(). In this step, we do a graceful
>>> shutdown/power-off of the eMMC card.
>>>
>>> When it comes to controller specific resources, like clocks and PM
>>> domains, for example, those may very well stay turned on. Do deal with
>>> these, then yes, you would need to implement the ->shutdown()
>>> callback. But as I said above, I am not sure it's the right thing to
>>> do.
>>
>> As explained before, we can enter S5 for an indefinite amount of time
>> until a wake-up source wakes us up so we must conserve power, even if we
>> happen to wake up the next second, we don't know that ahead of time. The
>> point of calling sdhci_pltfm_suspend() here is to ensure that host->clk
>> is turned off which cuts the eMMC controller digital clock, I forgot how
>> much power we save by doing so, but every 10s of mW counts for us.
> 
> I fully understand that you want to avoid draining energy, every
> single uA certainly counts in cases like these.
> 
> What puzzles me, is that your platform seems to keep some resources
> powered on (like device clocks) when entering the system wide low
> power state, S5.

More on that below.

> 
> In principle, I am wondering if it would be possible to use S5 as the
> system-wide low power state for the system suspend path, rather than
> S3, for example? In this way, we would be able to re-use already
> implemented ->suspend|resume callbacks from most subsystems/drivers, I
> believe. Or is there a problem with that?

The specific platform this driver is used on (BCM7211) is only capable
of supporting S2 and S5. There is no S3 because we have no provision on
the board to maintain the DRAM supplies on and preserve the DRAM
contents. This is a design choice that is different from the other
Broadcom STB platforms where we offer S2, S3 and S5 and we have an
On/off domain which is shutdown by hardware upon S3 or S5 entry and a
small always on domain which remains on to service wake-up sources
(infrared, timer, gpio, UART, etc.). S2 on this platform is implemented
entirely in software/firmware and does make use of the regular
suspend/resume calls.

S5 is implemented in part in software/firmware and with the help of the
hardware that will turn off external board components. We do need the
help of the various software drivers (PCIe, Ethernet, GPIO, USB, UART,
RTC, eMMC, SPI, etc.) to do their job and conserve power when we enter
S5, hence the reason why all of our drivers implement ->shutdown() (in
addition to needing that for kexec and ensure no DMA is left running).

> 
> I think we need an opinion from Rafel to move forward.

There is already an identical change done for sdhci-brcmstb.c, and the
exact same rationale applied there since both sdhci-iproc.c and
sdhci-brcmstb.c are used on this BCM7211 platform.

In all honesty, I am a bit surprised that the Linux device driver model
does not try to default the absence of a ->shutdown() to a ->suspend()
call since in most cases they are functionally equivalent, or should be,
in that they need to save power and quiesce the hardware, or leave
enough running to support a wake-up event.

Cheers
-- 
Florian
