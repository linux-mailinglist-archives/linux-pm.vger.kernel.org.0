Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0B22F1892
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 15:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbhAKOoc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 09:44:32 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:34992 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730598AbhAKOob (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 09:44:31 -0500
Received: by mail-oo1-f42.google.com with SMTP id s19so4146011oos.2;
        Mon, 11 Jan 2021 06:44:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GdSctKqLQYmOUEK3R48DhANxukWX3Hs9jqc6NTFnbIo=;
        b=Hv147+YA8cO+4kSiysQju3VbErf0aBXerCumC5VJzDd3cGGmHUteBPMhqoKOgW2FjN
         XGlvE4ykmzhqPBHUukAMwLQ0Xw00ewYjUWqjuri9odbCX4gD+tKCRLdJAJbX2DtIj681
         k5VwfHB/rHix8+i7qpEFfhQgstF1mQacK7OpOOz2VuZoj/fKnlqTBdPGKTHfAKRXWa4V
         Kdzv6qUHjj8scrSQFSSeqpvyvvHf6sQIBB/gnlRVg/7Y8GCPByiV3loN35DIvCmWR4KQ
         gv+gvi00pSZlieiL8ngTJYiHgaNTgv405ilVQTGrqGHNgBMi3gqdoW63W31n18OOiOY+
         HgkA==
X-Gm-Message-State: AOAM532Ksicunxcu1/JDoRMuBm+/gaSBCjJj33PjgnECzs0je3N86SBN
        Jn+iJV2zT38vKG0jzPgnAeIJtmab/uSvyy/Wn/s=
X-Google-Smtp-Source: ABdhPJwbMuHt3X2HQWHZGi4W8x4mg5oqPgrAY37VBfIPt0PZZ2blpXzT9tiSbKGR7RsCV5O2icbJnUD/CcXPnhh/Po4=
X-Received: by 2002:a4a:bf14:: with SMTP id r20mr12064558oop.2.1610376230095;
 Mon, 11 Jan 2021 06:43:50 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2101102010200.25762@eggly.anvils> <X/xV7ZV5jzI7RvAe@ulmo>
In-Reply-To: <X/xV7ZV5jzI7RvAe@ulmo>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Jan 2021 15:43:38 +0100
Message-ID: <CAJZ5v0j76NEY12JBs1z47KLwBQr73XF-W58BzbwEECbh6j=Hww@mail.gmail.com>
Subject: Re: 5.11-rc device reordering breaks ThinkPad rmi4 suspend
To:     Thierry Reding <treding@nvidia.com>
Cc:     Hugh Dickins <hughd@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 11, 2021 at 2:43 PM Thierry Reding <treding@nvidia.com> wrote:
>
> On Sun, Jan 10, 2021 at 08:44:13PM -0800, Hugh Dickins wrote:
> > Hi Rafael,
> >
> > Synaptics RMI4 SMBus touchpad on ThinkPad X1 Carbon (5th generation)
> > fails to suspend when running 5.11-rc kernels: bisected to
> > 5b6164d3465f ("driver core: Reorder devices on successful probe"),
> > and reverting that fixes it.  dmesg.xz attached, but go ahead and ask
> > me to switch on a debug option to extract further info if that may help.
>
> Hi Hugh,
>
> Quoting what I think are the relevant parts of that log:

I'm not sure how I overlooked that part of the log.  Oh well.

> [   34.373742] printk: Suspending console(s) (use no_console_suspend to debug)
> [   34.429015] rmi4_physical rmi4-00: Failed to read irqs, code=-6

This is a transport device read operation failing, but I'm not sure
how it is related to suspend.

> [   34.474973] rmi4_f01 rmi4-00.fn01: Failed to write sleep mode: -6.

And this is the rmi_write() in rmi_f01_suspend() failing AFAICS.

> [   34.474994] rmi4_f01 rmi4-00.fn01: Suspend failed with code -6.
> [   34.475001] rmi4_physical rmi4-00: Failed to suspend functions: -6
> [   34.475105] rmi4_smbus 6-002c: Failed to suspend device: -6
> [   34.475113] PM: dpm_run_callback(): rmi_smb_suspend+0x0/0x3c returns -6

So the call chain is
rmi_smb_suspend()->rmi_driver_suspend()->rmi_suspend_functions()->suspend_one_function()->rmi_f01_suspend().

> [   34.475130] PM: Device 6-002c failed to suspend: error -6
> [   34.475187] PM: Some devices failed to suspend, or early wake event detected
> [   34.480324] rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to F03 TX register (-6).
> [   34.480748] rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to F03 TX register (-6).
> [   34.481558] rmi4_physical rmi4-00: rmi_driver_clear_irq_bits: Failed to change enabled interrupts!
> [   34.487935] acpi LNXPOWER:02: Turning OFF
> [   34.488707] acpi LNXPOWER:01: Turning OFF
> [   34.489554] rmi4_physical rmi4-00: rmi_driver_set_irq_bits: Failed to change enabled interrupts!
> [   34.489669] psmouse: probe of serio2 failed with error -1
> [   34.489882] OOM killer enabled.
> [   34.489891] Restarting tasks ... done.
> [   34.589183] PM: suspend exit
> [   34.589839] PM: suspend entry (s2idle)
> [   34.605884] Filesystems sync: 0.017 seconds
> [   34.607594] Freezing user space processes ... (elapsed 0.006 seconds) done.
> [   34.613645] OOM killer disabled.
> [   34.613650] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [   34.615482] printk: Suspending console(s) (use no_console_suspend to debug)
> [   34.653097] rmi4_f01 rmi4-00.fn01: Failed to write sleep mode: -6.
> [   34.653108] rmi4_f01 rmi4-00.fn01: Suspend failed with code -6.
> [   34.653115] rmi4_physical rmi4-00: Failed to suspend functions: -6
> [   34.653123] rmi4_smbus 6-002c: Failed to suspend device: -6
> [   34.653129] PM: dpm_run_callback(): rmi_smb_suspend+0x0/0x3c returns -6
> [   34.653160] PM: Device 6-002c failed to suspend: error -6
> [   34.653174] PM: Some devices failed to suspend, or early wake event detected
> [   34.660515] OOM killer enabled.
> [   34.660524] Restarting tasks ...
> [   34.661456] rmi4_physical rmi4-00: rmi_driver_set_irq_bits: Failed to change enabled interrupts!
> [   34.661591] psmouse: probe of serio2 failed with error -1
> [   34.669469] done.
> [   34.748386] PM: suspend exit
>
> I think what might be happening here is that the offending patch causes
> some devices to be reordered in a way different to how they were ordered
> originally and the rmi4 driver currently depends on that implicit order.

Yes, that's what appears to be happening.

> Interestingly one of the bugs that the offending patch fixes is similar
> in the failure mode but for the reverse reason: the implicit order
> causes suspend/resume to fail.
>
> I suspect that the underlying reason here is that rmi4 needs something
> in order to successfully suspend (i.e. read the IRQ status registers)
> that has already been suspended where it hadn't prior to the offending
> patch.

Definitely, something has been suspended prematurely.

> It can't be the I2C controller itself that has been suspended,
> because the parent/child relationship should prevent that from
> happening.

Well, assuming that there is such a parent-child dependency.

It looks like there is at least one level of indirection between i2c
and the affected device.

> I'm not familiar with how exactly rmi4 works, so I'll have to do
> some digging to hopefully pinpoint exactly what's going wrong here.
>
> In the meantime, it would be useful to know what exactly the I2C
> hierarchy looks like. For example, what's the I2C controller that the
> RMI4 device is hooked up to. According to the above, that's I2C bus 6,
> so you should be able to find out some details about it by inspecting
> the corresponding sysfs nodes:
>
>         $ ls -l /sys/class/i2c-adapter/i2c-6/
>         $ cat /sys/class/i2c-adapter/i2c-6/name
>         $ ls -l /sys/class/i2c-adapter/i2c-6/device/
>
> Thierry
