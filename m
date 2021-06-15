Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A853A8401
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 17:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhFOPdX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 11:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhFOPdW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 11:33:22 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDD3C0617AF
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 08:31:17 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id n25so1061745vkl.8
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 08:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ugXKpj4LHdrdyG4UTDs7VBf4QAJNhOpaAQVCLfFAeJw=;
        b=J2VlRf6J4osy2PHigG6h59M178uVc3xlDfkFnJCqh43wYbiOesVkB/V0ZbK3cymc/q
         PiJPytY5WQmxpMKI5bqOCjErVxADBBlqmzzEnV5iKGdvWzgHRQIoCcdglRrob/KSA0fk
         cZ5AcJAWFT1ngmNWfYziwDSPoaRksFXrIxqEtURPVg0GOfOSDRUDI65uh5H4W488Elul
         owJ/F6CZ7dpUZvoMWYg/wAyUdGbyCLMUu3vjwi82d/7yuusYsotw+u48pNxlMlYVOlLo
         MjPAcRy0LVDhbxLLtV5YDTIJ8cR9US673/EP8Fw4ZmsUefZL8XEb7a8D1wm6sPYMUAF7
         5jHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugXKpj4LHdrdyG4UTDs7VBf4QAJNhOpaAQVCLfFAeJw=;
        b=eXOvQJ44dRxN0WVtEh52KPVdU6fYxCw1xQ8Y/mhfXSHiLfKCWgaw9IN0jIoGNLF/Vj
         RGrgBWEu7QxQpfcCr5EQZxMA0rqY5Q1oiTBB3nJHWiQWJguPXJdvsuwviU2EFiqdUl/U
         7EHiQcPoTraC8ON1SBFau9BVuSpXRsuKKXuHY6iI4B0Su6B8Xjz4imuQljhAZ5jiWJO7
         UgShejQFZSkR7V4VX6G+90XxjJbHcjxoLRvvscNznlW1YTNFlPX2pcGW+ReXVCqmDxZ9
         ijR1NCsekPD4qStmB4C+Pp5NlwLiVYaMwagjvfaMupl5TaZkQ4BKAQMsSF5VpwSdvoI8
         0jXw==
X-Gm-Message-State: AOAM531hroGQ6QUPTf0EWJKGn0YomyC/1rnhEToH5+py4G8KH7rfOjO9
        Z3bdVsFzsgabe9jzJxe5/nLJMmWKExohL1EvFPh6TA==
X-Google-Smtp-Source: ABdhPJza0EQ2TeCd6JjfNlVbN2ByJUzxeMD7nS/4Vzz5V2GthoFIZGFj77c+/UVrW9+fkmE/4Mf8Ei+A/+oKjy1gGQg=
X-Received: by 2002:a1f:9542:: with SMTP id x63mr5023349vkd.15.1623771075445;
 Tue, 15 Jun 2021 08:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210602192758.38735-1-alcooperx@gmail.com> <20210602192758.38735-2-alcooperx@gmail.com>
 <CAPDyKFrynST66yA_T3iroiJsfmNuBOEiiBnb=vNoyP6QpvZ7aQ@mail.gmail.com>
 <fe956941-bb39-413e-f051-d9f353f64eda@gmail.com> <CAPDyKFpEtvjS1mWC68gRBWD64dq2M1LO84UWE5uDLTzbGz1g8Q@mail.gmail.com>
 <6acd480a-8928-89bb-0f40-d278294973a1@gmail.com> <CAPDyKFqk23xg5R2k9GwQrnamwWYbMkmrbWYsHPF9VBQTAbvQHw@mail.gmail.com>
 <a1199e99-eb29-125b-2bac-f0abb4803c9b@gmail.com> <CAPDyKFq-rofbCyAhcQGt2xZykip6Le+CUDXgDwAisVOj=Tt-uA@mail.gmail.com>
 <b4c36944-8f41-1f30-10b4-b3efe0aade01@gmail.com> <CAPDyKFpR1GZcqCO5=-h7jvG0TysPLfJOP6rDJBagHvg9HFxnSQ@mail.gmail.com>
 <e25164b4-fa0c-b1c1-e40b-0f0c71641976@gmail.com>
In-Reply-To: <e25164b4-fa0c-b1c1-e40b-0f0c71641976@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Jun 2021 17:30:39 +0200
Message-ID: <CAPDyKFq92mp4CXj8-QHw=DEQ8bcAjtrmLyowrGKSJL2Fch1cJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-iproc: Add support for the legacy sdhci
 controller on the BCM7211
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

[...]

> >
> >>
> >> In all honesty, I am a bit surprised that the Linux device driver model
> >> does not try to default the absence of a ->shutdown() to a ->suspend()
> >> call since in most cases they are functionally equivalent, or should be,
> >> in that they need to save power and quiesce the hardware, or leave
> >> enough running to support a wake-up event.
> >
> > Well, the generall assumption is that the platform is going to be
> > entirely powered off, thus moving things into a low power state would
> > just be a waste of execution cycles. Of course, that's not the case
> > for your platform.
>
> That assumption may hold true for ACPI-enabled machines but power off is
> offered as a general function towards other more flexible and snowflaky
> systems (read embedded) as well.
>
> >
> > As I have stated earlier, to me it looks a bit questionable to use the
> > kernel_power_off() path to support the use case you describe. On the
> > other hand, we may not have a better option at this point.
>
> Correct, there is not really anything better and I am not sure what the
> semantics of something better could be anyway.
>
> >
> > Just a few things, from the top of my head, that we certainly are
> > missing to support your use case through kernel_power_off() path
> > (there are certainly more):
> > 1. In general, subsystems/drivers don't care about moving things into
> > lower power modes from their ->shutdown() callbacks.
> > 2. System wakeups and devices being affected in the wakeup path, needs
> > to be respected properly. Additionally, userspace should be able to
> > decide if system wakeups should be enabled or not.
> > 3. PM domains don't have ->shutdown() callbacks, thus it's likely that
> > they remain powered on.
> > 4. Etc...
>
> For the particular eMMC driver being discussed here this is a no-brainer
 > because  it is not a wake-up source, therefore there is no reason not to
> power if off if we can. It also seems proper to have it done by the
> kernel as opposed to firmware.

Okay, I have applied the $subject patch onto my next branch, along
with patch 1/2 (the DT doc change).

However, I still think we should look for a proper long term solution,
because the kernel_power_off() path does not currently support your
use case, with system wakeups etc.

I guess it could be a topic that is easier to bring up at the Linux
Plumbers Conf, for example.

Kind regards
Uffe
