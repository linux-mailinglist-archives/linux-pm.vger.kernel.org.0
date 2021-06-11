Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DFA3A4020
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 12:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFKKZu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Jun 2021 06:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFKKZu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jun 2021 06:25:50 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E587C0617AF
        for <linux-pm@vger.kernel.org>; Fri, 11 Jun 2021 03:23:52 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id f21so3490328vsl.4
        for <linux-pm@vger.kernel.org>; Fri, 11 Jun 2021 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BK5FSPAIVY7BHkqa7m1EZ7jj7bUTkuHalv8GCJ5Ni4s=;
        b=JmCUI9LxHn1plyMQFyPsw0EPm98tNnjsR+0gzYK0zeVAitU0BQSDb2gb+Liv5AusmV
         /i+75NEJbsybJrbJ6PnJwJ6s3qfk7huCB/m1TO17P43lekpDK0Eo7Ap8RwRMQHxnLfcL
         a0e24WAD0YqlHvTrR9NuQ3oC9KO38MZI/OSfXgweAmumesRVtYn72vEUeAsC6JSebNz4
         o3lUTv5C84pgLHPTdNtZPnZN8a8iDEnTdQyLJQnkAJXsxe2vRd7KVWeJhbphwa/SfWCE
         47HcBsj7QCrgP+YT0wggIQEWCgiwd9GH+ou1Uwi0We/CMxlXJ7IJOIL+j2va1rtNfiUb
         acFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BK5FSPAIVY7BHkqa7m1EZ7jj7bUTkuHalv8GCJ5Ni4s=;
        b=NDapXxLQJFxWNUNuOeGEYH2/7JmXX5O0hylinHEwA/VmLn6r+VVJVq8UVBRIhFEmAj
         P5fbfLc0Eqpm5c0OtluCh5oPl7A4TsN0+MBqhSvxXVUMQMNMUUB+acnQlsIH1kb/ARJI
         HmK4TpVP4IQGPBxr7658aOOkMnzFcbtHHKK51XYEgRvt9HJMSqqJFi1KDoURczrt1dYX
         bpAUF1Y4gRjYvF19DEZ3XwqIwzAh+GPsf4jsVGHCVgSg5WkXyyomqD3PBYX4Ccd8Iohs
         syI+AsLPPXpP2IuvZvcGpWQ+HNoAc3PSmhYOcPGN9eC5A4+JM59tsEsHNsRphyGf1lh9
         nT0g==
X-Gm-Message-State: AOAM531CXkcVrfvug2ZHoTKAEHul+/OfgKO+KZEjwd5y47QZ94P8GTAG
        1AQROvj9D8VjV6J57ufbgMHi63az7XROBQwQ+DIiMw==
X-Google-Smtp-Source: ABdhPJwLrnOX7GlrPp7cabVhPYtL5pRpAhcuytHfYlGIWjLqHCs4i2sESdPXlSwGa6TJNPUP94kxCrsWlgzuF7VbWTw=
X-Received: by 2002:a05:6102:386:: with SMTP id m6mr5780364vsq.48.1623407031441;
 Fri, 11 Jun 2021 03:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210602192758.38735-1-alcooperx@gmail.com> <20210602192758.38735-2-alcooperx@gmail.com>
 <CAPDyKFrynST66yA_T3iroiJsfmNuBOEiiBnb=vNoyP6QpvZ7aQ@mail.gmail.com>
 <fe956941-bb39-413e-f051-d9f353f64eda@gmail.com> <CAPDyKFpEtvjS1mWC68gRBWD64dq2M1LO84UWE5uDLTzbGz1g8Q@mail.gmail.com>
 <6acd480a-8928-89bb-0f40-d278294973a1@gmail.com> <CAPDyKFqk23xg5R2k9GwQrnamwWYbMkmrbWYsHPF9VBQTAbvQHw@mail.gmail.com>
 <a1199e99-eb29-125b-2bac-f0abb4803c9b@gmail.com>
In-Reply-To: <a1199e99-eb29-125b-2bac-f0abb4803c9b@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Jun 2021 12:23:14 +0200
Message-ID: <CAPDyKFq-rofbCyAhcQGt2xZykip6Le+CUDXgDwAisVOj=Tt-uA@mail.gmail.com>
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

On Thu, 10 Jun 2021 at 17:59, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 6/10/2021 1:49 AM, Ulf Hansson wrote:
> > On Thu, 10 Jun 2021 at 01:59, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >>
> >>
> >> On 6/9/2021 2:22 AM, Ulf Hansson wrote:
> >>> On Wed, 9 Jun 2021 at 05:07, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 6/8/2021 5:40 AM, Ulf Hansson wrote:
> >>>>> On Wed, 2 Jun 2021 at 21:28, Al Cooper <alcooperx@gmail.com> wrote:
> >>>>>>
> >>>>>> Add support for the legacy Arasan sdhci controller on the BCM7211 and
> >>>>>> related SoC's. This includes adding a .shutdown callback to increase
> >>>>>> the power savings during S5.
> >>>>>
> >>>>> Please split this into two separate changes.
> >>>>>
> >>>>> May I also ask about the ->shutdown() callback and in relation to S5.
> >>>>> What makes the ->shutdown callback only being invoked for S5?
> >>>>
> >>>> It is not only called for S5 (entered via poweroff on a prompt) but also
> >>>> during kexec or reboot. The poweroff path is via:
> >>>>
> >>>> kernel_power_off() -> kernel_shutdown_prepare() -> device_shutdown() ->
> >>>> .shutdown()
> >>>>
> >>>> For kexec or reboot we do not really care about power savings since we
> >>>> are about to load a new image anyway, however for S5/poweroff we do care
> >>>> about quiescing the eMMC controller in a way that its clocks and the
> >>>> eMMC device can be put into low power mode since we will stay in that
> >>>> mode for seconds/hours/days until someone presses a button on their
> >>>> remote (or other wake-up sources).
> >>>
> >>> Hmm, I am not sure I understand correctly. At shutdown we don't care
> >>> about wake-up sources from the kernel point of view, instead we treat
> >>> everything as if it will be powered off.
> >>
> >> The same .shutdown() path is used whether you kexec, reboot or poweroff,
> >> but for poweroff we do care about allowing specific wake-up sources
> >> configured as such to wake-up the system at a later time, like GPIOs,
> >> RTC, etc.
> >
> > That's true, but using the ->shutdown() callbacks in this way would
> > certainly be a new use case.
> >
> > Most subsystems/drivers don't care about power management in those
> > callbacks, but rather just about managing a graceful shutdown.
> >
> > It sounds to me like you should have a look at the hibernation
> > path/callbacks instead - or perhaps even the system suspend
> > path/callback. Normally, that's where we care about power management.
>
> The platforms we use do not support hibernation, keep in mind that these
> are embedded SoCs that support the S2 (standby), S3 (mem) and poweroff
> suspend states, hibernation is not something that we can support.
>
> >
> > I have looped in Rafael, to allow him to share his opinion on this.
> >
> >>
> >>>
> >>> We put devices into low power state at system suspend and potentially
> >>> also during some of the hibernation phases.
> >>>
> >>> Graceful shutdown of the eMMC is also managed by the mmc core.
> >>
> >> AFAICT that calls mmc_blk_shutdown() but that is pretty much it, the
> >> SDHCI platform_driver still needs to do something in order to conserve
> >> power including disabling host->clk, otherwise we would not have done
> >> that for sdhci-brcmstb.c.
> >
> > That's not entirely correct. When mmc_bus_shutdown() is called for the
> > struct device* that belongs to an eMMC card, two actions are taken.
> >
> > *) We call mmc_blk_shutdown(), to suspend the block device queue from
> > receiving new I/O requests.
> > **) We call host->bus_ops->shutdown(), which is an eMMC specific
> > callback set to mmc_shutdown(). In this step, we do a graceful
> > shutdown/power-off of the eMMC card.
> >
> > When it comes to controller specific resources, like clocks and PM
> > domains, for example, those may very well stay turned on. Do deal with
> > these, then yes, you would need to implement the ->shutdown()
> > callback. But as I said above, I am not sure it's the right thing to
> > do.
>
> As explained before, we can enter S5 for an indefinite amount of time
> until a wake-up source wakes us up so we must conserve power, even if we
> happen to wake up the next second, we don't know that ahead of time. The
> point of calling sdhci_pltfm_suspend() here is to ensure that host->clk
> is turned off which cuts the eMMC controller digital clock, I forgot how
> much power we save by doing so, but every 10s of mW counts for us.

I fully understand that you want to avoid draining energy, every
single uA certainly counts in cases like these.

What puzzles me, is that your platform seems to keep some resources
powered on (like device clocks) when entering the system wide low
power state, S5.

In principle, I am wondering if it would be possible to use S5 as the
system-wide low power state for the system suspend path, rather than
S3, for example? In this way, we would be able to re-use already
implemented ->suspend|resume callbacks from most subsystems/drivers, I
believe. Or is there a problem with that?

I think we need an opinion from Rafel to move forward.

Kind regards
Uffe
