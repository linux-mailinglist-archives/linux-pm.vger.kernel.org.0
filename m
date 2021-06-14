Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969333A67AC
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 15:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhFNNXK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 09:23:10 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:44691 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbhFNNXK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 09:23:10 -0400
Received: by mail-vs1-f47.google.com with SMTP id x13so7743400vsf.11
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 06:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hznYiY/yIaLIQ43u53uPpsgJQvFToxlc5/LKCrV5tj4=;
        b=pSej7L+/yh7aHpv6cKak9q+IbtY9RGMVlvK97EenQ6HD7xsp5T2aRatHSgXKEpdtbP
         yzHCmiYa9ZVambvZ3DmtHHOf9OIJ8V4aLEPQ/0ELAwHy4J/1l7s6z2SXIGiuUetPrtBV
         Ii8dFN5p3Tvf/kjC8QFuUKl5jGzQN6i8vW0HbjGuoxenTeH/cQgGOjejuZHXHPxzM3uJ
         7YVyuAgbGtOtWqtPPDBFK9/r3CDPEzRmxe8QfBtGMlEeog/rvIpz2uMdCWsLDMEDtYhM
         gZHGVBVkpqGp7IfeS7V4Y/z3I+hQk/mH8ldymrL4Zq3udYAyPOZ+vpYKGDuw63cqei7+
         MWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hznYiY/yIaLIQ43u53uPpsgJQvFToxlc5/LKCrV5tj4=;
        b=fLjFwVl2s0ppGCUPkLVazhrnJJrEX9JBhn4bggL2BwcWfpGimrIrYao+smbrxgdAUU
         2As0ULmcDmAHcwj8FFz2rzdmjDoJfakITvlFYrVxeIHVHHJUr4KtGDh70Mr5fnqZoM9m
         Rdp6BfndIIi5mv3ULn9aUYrbNWsPfK7KTd3WA7flm1NSicCLCSHR+zkw4GC4V5GAvjmM
         L9mB8XcClsw4VF1bASQgD3A8FXghMHh3fbp8aA2wrgNc4EEV0WzkmEtD/tNO9D5R2aeL
         nJ1fxbdEVmIqBwdvhD7ChiLzvYhD4pTib36Mq6zp+5K+wn6Q42dxowHORwxc5FU5uhvX
         nLUQ==
X-Gm-Message-State: AOAM532Zw71aZDTArhX2fdn94kXbrAid2jU5K5YXeZsF2Ge3mXWACQy0
        XtOrW6PjiKBxKjZZukh+PbN11794OzJgrP8RGUrirA==
X-Google-Smtp-Source: ABdhPJyI0OLl9c6qznSTU52N5rNTrdJ8c9JnIs+9ZEOaxUDrCelrmpXu4s6Fk3Gylc+zmtGqoXFYqHYOs74dp6Gr9LI=
X-Received: by 2002:a67:e359:: with SMTP id s25mr16904297vsm.55.1623676802028;
 Mon, 14 Jun 2021 06:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210602192758.38735-1-alcooperx@gmail.com> <20210602192758.38735-2-alcooperx@gmail.com>
 <CAPDyKFrynST66yA_T3iroiJsfmNuBOEiiBnb=vNoyP6QpvZ7aQ@mail.gmail.com>
 <fe956941-bb39-413e-f051-d9f353f64eda@gmail.com> <CAPDyKFpEtvjS1mWC68gRBWD64dq2M1LO84UWE5uDLTzbGz1g8Q@mail.gmail.com>
 <6acd480a-8928-89bb-0f40-d278294973a1@gmail.com> <CAPDyKFqk23xg5R2k9GwQrnamwWYbMkmrbWYsHPF9VBQTAbvQHw@mail.gmail.com>
 <a1199e99-eb29-125b-2bac-f0abb4803c9b@gmail.com> <CAPDyKFq-rofbCyAhcQGt2xZykip6Le+CUDXgDwAisVOj=Tt-uA@mail.gmail.com>
 <b4c36944-8f41-1f30-10b4-b3efe0aade01@gmail.com>
In-Reply-To: <b4c36944-8f41-1f30-10b4-b3efe0aade01@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Jun 2021 15:19:25 +0200
Message-ID: <CAPDyKFpR1GZcqCO5=-h7jvG0TysPLfJOP6rDJBagHvg9HFxnSQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-iproc: Add support for the legacy sdhci
 controller on the BCM7211
To:     Florian Fainelli <f.fainelli@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 11 Jun 2021 at 18:54, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 6/11/2021 3:23 AM, Ulf Hansson wrote:
> > On Thu, 10 Jun 2021 at 17:59, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >>
> >>
> >> On 6/10/2021 1:49 AM, Ulf Hansson wrote:
> >>> On Thu, 10 Jun 2021 at 01:59, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 6/9/2021 2:22 AM, Ulf Hansson wrote:
> >>>>> On Wed, 9 Jun 2021 at 05:07, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 6/8/2021 5:40 AM, Ulf Hansson wrote:
> >>>>>>> On Wed, 2 Jun 2021 at 21:28, Al Cooper <alcooperx@gmail.com> wrote:
> >>>>>>>>
> >>>>>>>> Add support for the legacy Arasan sdhci controller on the BCM7211 and
> >>>>>>>> related SoC's. This includes adding a .shutdown callback to increase
> >>>>>>>> the power savings during S5.
> >>>>>>>
> >>>>>>> Please split this into two separate changes.
> >>>>>>>
> >>>>>>> May I also ask about the ->shutdown() callback and in relation to S5.
> >>>>>>> What makes the ->shutdown callback only being invoked for S5?
> >>>>>>
> >>>>>> It is not only called for S5 (entered via poweroff on a prompt) but also
> >>>>>> during kexec or reboot. The poweroff path is via:
> >>>>>>
> >>>>>> kernel_power_off() -> kernel_shutdown_prepare() -> device_shutdown() ->
> >>>>>> .shutdown()
> >>>>>>
> >>>>>> For kexec or reboot we do not really care about power savings since we
> >>>>>> are about to load a new image anyway, however for S5/poweroff we do care
> >>>>>> about quiescing the eMMC controller in a way that its clocks and the
> >>>>>> eMMC device can be put into low power mode since we will stay in that
> >>>>>> mode for seconds/hours/days until someone presses a button on their
> >>>>>> remote (or other wake-up sources).
> >>>>>
> >>>>> Hmm, I am not sure I understand correctly. At shutdown we don't care
> >>>>> about wake-up sources from the kernel point of view, instead we treat
> >>>>> everything as if it will be powered off.
> >>>>
> >>>> The same .shutdown() path is used whether you kexec, reboot or poweroff,
> >>>> but for poweroff we do care about allowing specific wake-up sources
> >>>> configured as such to wake-up the system at a later time, like GPIOs,
> >>>> RTC, etc.
> >>>
> >>> That's true, but using the ->shutdown() callbacks in this way would
> >>> certainly be a new use case.
> >>>
> >>> Most subsystems/drivers don't care about power management in those
> >>> callbacks, but rather just about managing a graceful shutdown.
> >>>
> >>> It sounds to me like you should have a look at the hibernation
> >>> path/callbacks instead - or perhaps even the system suspend
> >>> path/callback. Normally, that's where we care about power management.
> >>
> >> The platforms we use do not support hibernation, keep in mind that these
> >> are embedded SoCs that support the S2 (standby), S3 (mem) and poweroff
> >> suspend states, hibernation is not something that we can support.
> >>
> >>>
> >>> I have looped in Rafael, to allow him to share his opinion on this.
> >>>
> >>>>
> >>>>>
> >>>>> We put devices into low power state at system suspend and potentially
> >>>>> also during some of the hibernation phases.
> >>>>>
> >>>>> Graceful shutdown of the eMMC is also managed by the mmc core.
> >>>>
> >>>> AFAICT that calls mmc_blk_shutdown() but that is pretty much it, the
> >>>> SDHCI platform_driver still needs to do something in order to conserve
> >>>> power including disabling host->clk, otherwise we would not have done
> >>>> that for sdhci-brcmstb.c.
> >>>
> >>> That's not entirely correct. When mmc_bus_shutdown() is called for the
> >>> struct device* that belongs to an eMMC card, two actions are taken.
> >>>
> >>> *) We call mmc_blk_shutdown(), to suspend the block device queue from
> >>> receiving new I/O requests.
> >>> **) We call host->bus_ops->shutdown(), which is an eMMC specific
> >>> callback set to mmc_shutdown(). In this step, we do a graceful
> >>> shutdown/power-off of the eMMC card.
> >>>
> >>> When it comes to controller specific resources, like clocks and PM
> >>> domains, for example, those may very well stay turned on. Do deal with
> >>> these, then yes, you would need to implement the ->shutdown()
> >>> callback. But as I said above, I am not sure it's the right thing to
> >>> do.
> >>
> >> As explained before, we can enter S5 for an indefinite amount of time
> >> until a wake-up source wakes us up so we must conserve power, even if we
> >> happen to wake up the next second, we don't know that ahead of time. The
> >> point of calling sdhci_pltfm_suspend() here is to ensure that host->clk
> >> is turned off which cuts the eMMC controller digital clock, I forgot how
> >> much power we save by doing so, but every 10s of mW counts for us.
> >
> > I fully understand that you want to avoid draining energy, every
> > single uA certainly counts in cases like these.
> >
> > What puzzles me, is that your platform seems to keep some resources
> > powered on (like device clocks) when entering the system wide low
> > power state, S5.
>
> More on that below.
>
> >
> > In principle, I am wondering if it would be possible to use S5 as the
> > system-wide low power state for the system suspend path, rather than
> > S3, for example? In this way, we would be able to re-use already
> > implemented ->suspend|resume callbacks from most subsystems/drivers, I
> > believe. Or is there a problem with that?
>
> The specific platform this driver is used on (BCM7211) is only capable
> of supporting S2 and S5. There is no S3 because we have no provision on
> the board to maintain the DRAM supplies on and preserve the DRAM
> contents. This is a design choice that is different from the other
> Broadcom STB platforms where we offer S2, S3 and S5 and we have an
> On/off domain which is shutdown by hardware upon S3 or S5 entry and a
> small always on domain which remains on to service wake-up sources
> (infrared, timer, gpio, UART, etc.). S2 on this platform is implemented
> entirely in software/firmware and does make use of the regular
> suspend/resume calls.
>
> S5 is implemented in part in software/firmware and with the help of the
> hardware that will turn off external board components. We do need the
> help of the various software drivers (PCIe, Ethernet, GPIO, USB, UART,
> RTC, eMMC, SPI, etc.) to do their job and conserve power when we enter
> S5, hence the reason why all of our drivers implement ->shutdown() (in
> addition to needing that for kexec and ensure no DMA is left running).
>
> >
> > I think we need an opinion from Rafel to move forward.
>
> There is already an identical change done for sdhci-brcmstb.c, and the
> exact same rationale applied there since both sdhci-iproc.c and
> sdhci-brcmstb.c are used on this BCM7211 platform.

Right, thanks for the pointer. Looks like we should have taken this
discussion back then, but better late than never.

>
> In all honesty, I am a bit surprised that the Linux device driver model
> does not try to default the absence of a ->shutdown() to a ->suspend()
> call since in most cases they are functionally equivalent, or should be,
> in that they need to save power and quiesce the hardware, or leave
> enough running to support a wake-up event.

Well, the generall assumption is that the platform is going to be
entirely powered off, thus moving things into a low power state would
just be a waste of execution cycles. Of course, that's not the case
for your platform.

As I have stated earlier, to me it looks a bit questionable to use the
kernel_power_off() path to support the use case you describe. On the
other hand, we may not have a better option at this point.

Just a few things, from the top of my head, that we certainly are
missing to support your use case through kernel_power_off() path
(there are certainly more):
1. In general, subsystems/drivers don't care about moving things into
lower power modes from their ->shutdown() callbacks.
2. System wakeups and devices being affected in the wakeup path, needs
to be respected properly. Additionally, userspace should be able to
decide if system wakeups should be enabled or not.
3. PM domains don't have ->shutdown() callbacks, thus it's likely that
they remain powered on.
4. Etc...

Kind regards
Uffe
