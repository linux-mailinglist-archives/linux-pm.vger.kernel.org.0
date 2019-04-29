Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE1DEAB
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 11:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfD2JIt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 29 Apr 2019 05:08:49 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:41463 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfD2JIt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 05:08:49 -0400
Received: by mail-ot1-f51.google.com with SMTP id g8so6947996otl.8;
        Mon, 29 Apr 2019 02:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2VWJO2MGiduBgVwh+y0rSMdiohlU2hlJmSsmX8IMxNI=;
        b=pww6gR7/FFx58uqOHMPRm/UwRKXc/rfqKnGchkdRp/Fz5G05Nz9aHQU55dUSaRytIo
         Oy90OaYP4gAuP92vI8zfYooRTXRjNjGyH4v97+zU/62PVChvo1uGVXLWMoQMRlseLwr/
         J0AXAsn+xf+3JNZpR/mTBOxb5+WgmUnQNc1VfXQF7BncupKyB6ngKNHvQemcVMyYHXIG
         AsTfvI2Ya7+QqvRTk3nfrsvu96nOlnP0fBjGuryygj0XtX4utjWkdHLGuFcjocFV5cs8
         Dzb2oUE+L83gzFJs8T2RhfV3jFCZIFGSYJGUDMwdXTRR2KVzgTFreZeZxjA0iuzkfWE2
         Pakw==
X-Gm-Message-State: APjAAAXrOo1D1uwy8qPJqe8YKuh6c0OZflMXWUhJqMrYY/OHVJvI57lV
        hk7g0G2WDFA8KTy0ypqf4JQYJDcIeIEYL+sc3bU=
X-Google-Smtp-Source: APXvYqxhvgorRjOjGR5KwL0tVgrlRLyMivMC1DNNtT60AWmSWUv/MAR76xN6ZmJSFy/scEaQioWysRLnEkElcaBCY80=
X-Received: by 2002:a9d:6e17:: with SMTP id e23mr7531429otr.65.1556528928156;
 Mon, 29 Apr 2019 02:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <5fdabbb9-0a62-4802-f1ca-f83584f935fa@molgen.mpg.de>
 <CAJZ5v0gobp60Pn5cdh0CohGAXSBs-EvntNqKc_dj_UTnOiogkQ@mail.gmail.com> <c4c2f89f-9af7-01de-9144-9f11a8dafd58@molgen.mpg.de>
In-Reply-To: <c4c2f89f-9af7-01de-9144-9f11a8dafd58@molgen.mpg.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 29 Apr 2019 11:08:37 +0200
Message-ID: <CAJZ5v0jhrtaRmb9_n_=hpqZU0iFvEsV8FKoZ1v7QANXq-dWVFQ@mail.gmail.com>
Subject: Re: Why is suspend with s2idle available on POWER8 systems?
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 29, 2019 at 10:50 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Rafael,
>
>
> On 04/29/2019 09:17 AM, Rafael J. Wysocki wrote:
> > On Sat, Apr 27, 2019 at 12:54 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> >> Updating an IBM S822LC from Ubuntu 18.10 to 19.04 some user space stuff
> >> seems to have changed, so that going into sleep/suspend is enabled.
> >>
> >> That raises two questions.
> >>
> >> 1.  Is suspend actually supported on a POWER8 processor?
> >
> > Suspend-to-idle is a special variant of system suspend that does not
> > depend on any special platform support.  It works by suspending
> > devices and letting all of the CPUs in the system go idle (hence the
> > name).
> >
> > Also see https://www.kernel.org/doc/html/latest/admin-guide/pm/sleep-states.html#suspend-to-idle
>
> Thanks. I guess I mixed it up with the new S0ix-states [1].

Those can be entered via suspend-to-idle, if supported and actually
reachable on a given platform, but suspend-to-idle is more general
than that.

> >>> Apr 27 10:18:13 power NetworkManager[7534]: <info>  [1556353093.7224] manager: sleep: sleep requested (sleeping: no  e
> >>> Apr 27 10:18:13 power systemd[1]: Reached target Sleep.
> >>> Apr 27 10:18:13 power systemd[1]: Starting Suspend...
> >>> Apr 27 10:18:13 power systemd-sleep[82190]: Suspending system...
> >>> Apr 27 10:18:13 power kernel: PM: suspend entry (s2idle)
> >>> -- Reboot --
> >>
> >>> $ uname -m
> >>> ppc64le
> >>> $ more /proc/version
> >>> Linux version 5.1.0-rc6+ (joey@power) (gcc version 8.3.0 (Ubuntu 8.3.0-6ubuntu1)) #1 SMP Sat Apr 27 10:01:48 CEST 2019
> >>> $ more /sys/power/mem_sleep
> >>> [s2idle]
> >>> $ more /sys/power/state
> >>> freeze mem
> >>> $ grep _SUSPEND /boot/config-5.0.0-14-generic # also enabled in Ubuntu’s configuration
> >>> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> >>> CONFIG_SUSPEND=y
> >>> CONFIG_SUSPEND_FREEZER=y
> >>> # CONFIG_SUSPEND_SKIP_SYNC is not set
> >>> # CONFIG_PM_TEST_SUSPEND is not set
> >>
> >> Should the Kconfig symbol `SUSPEND` be selectable? If yes, should their
> >> be some detection during runtime?
> >>
> >> 2.  If it is supported, what are the ways to getting it to resume? What
> >> would the IPMI command be?
> >
> > That would depend on the distribution.
> >
> > Generally, you need to set up at least one device to generate wakeup
> > interrupts.
> >
> > The interface to do that are the /sys/devices/.../power/wakeup files,
> > but that has to cause enble_irq_wake() to be called for the given IRQ,
> > so some support in the underlying drivers need to be present for it to
> > work.
> >
> > USB devices generally work as wakeup sources if the controllers reside
> > on a PCI bus, for example.
>
> ```
> $ find /sys/devices/ -name wakeup | xargs grep enabled
> /sys/devices/pci0021:00/0021:00:00.0/0021:01:00.0/0021:02:09.0/0021:0d:00.0/usb1/1-3/1-3.4/power/wakeup:enabled
> /sys/devices/pci0021:00/0021:00:00.0/0021:01:00.0/0021:02:09.0/0021:0d:00.0/power/wakeup:enabled
> $ lsusb -t
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 480M
>     |__ Port 3: Dev 2, If 0, Class=Hub, Driver=hub/5p, 480M
>         |__ Port 1: Dev 3, If 0, Class=Mass Storage, Driver=usb-storage, 480M
>         |__ Port 2: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
>         |__ Port 3: Dev 5, If 0, Class=Mass Storage, Driver=usb-storage, 480M
>         |__ Port 4: Dev 6, If 0, Class=Human Interface Device, Driver=usbhid, 1.5M
>         |__ Port 4: Dev 6, If 1, Class=Human Interface Device, Driver=usbhid, 1.5M
> $ lsusb
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 001 Device 006: ID 046b:ff10 American Megatrends, Inc. Virtual Keyboard and Mouse
> Bus 001 Device 005: ID 046b:ff31 American Megatrends, Inc.
> Bus 001 Device 004: ID 046b:ff40 American Megatrends, Inc.
> Bus 001 Device 003: ID 046b:ff20 American Megatrends, Inc.
> Bus 001 Device 002: ID 046b:ff01 American Megatrends, Inc.
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> ```

I'm not really sure what you wanted to say here, but it looks like
system wakeup is not enabled for device 6 on bus 1 which is probably
what you want.
