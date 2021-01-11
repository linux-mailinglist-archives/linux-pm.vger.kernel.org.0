Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1671D2F18FA
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 15:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbhAKO6a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 09:58:30 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:42583 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbhAKO63 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 09:58:29 -0500
Received: by mail-ot1-f52.google.com with SMTP id 11so17100812oty.9;
        Mon, 11 Jan 2021 06:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7t35NkDKfW6AJAxopDvtvnjqNf+LDF0wYVO4JWwW3k=;
        b=NBHbal7YLIXwkRZ+F0yBC0iXsf/VDxFTdWgROPpLJThgF2ENs0Hico0EoA6m+fBm9t
         XGIE2Ra3mEv00iKyzwHM8QqCr+daWRzEKZQYSzwHVn1Gg6YnCX/4xhhtt/vdrAfbIQHW
         gR3k2bCMRzus02qg2Sa+cGEsgcVx6ijbmUyirtQ7ON/vWp6l9Kx9O2EySlhStJN6XF/k
         BJVwff6O9BXqIPrnbkLpt8tEn3tjri31Ne3qrlQcyT9gN58u8g16K6Xz1e6hS+c23Z5+
         CR0aPGWEUbxIS9UsAnrzLn9ZfVGH7U0hb2rUTgrUacCgH+ZQ0TEx7ziE8DY49Mwy+Wf5
         xJhA==
X-Gm-Message-State: AOAM532YMe16C7EiQ5xP1QS55opgTRoyLQGeYWyqCZnZ9isAAGjLYKJk
        6HpgPpex250TxQIBEa4FdcUpmGwSpWsJvvcyGHE=
X-Google-Smtp-Source: ABdhPJzFuSTDnqMMfBrV+MaNHGkqEHhQbvoD7ET4N8z1jcqX9D14iVLIXpgXJsOUjHyh94OVxLMJuOQsdw7RRieQsWU=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr11525956otk.206.1610377068634;
 Mon, 11 Jan 2021 06:57:48 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2101102010200.25762@eggly.anvils> <X/xV7ZV5jzI7RvAe@ulmo>
In-Reply-To: <X/xV7ZV5jzI7RvAe@ulmo>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Jan 2021 15:57:37 +0100
Message-ID: <CAJZ5v0iriRkEN8dVJ9gE3+Wyn_96=SNhav1QaQ59i9O0genTNQ@mail.gmail.com>
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
>
> [   34.373742] printk: Suspending console(s) (use no_console_suspend to debug)
> [   34.429015] rmi4_physical rmi4-00: Failed to read irqs, code=-6
> [   34.474973] rmi4_f01 rmi4-00.fn01: Failed to write sleep mode: -6.
> [   34.474994] rmi4_f01 rmi4-00.fn01: Suspend failed with code -6.
> [   34.475001] rmi4_physical rmi4-00: Failed to suspend functions: -6
> [   34.475105] rmi4_smbus 6-002c: Failed to suspend device: -6
> [   34.475113] PM: dpm_run_callback(): rmi_smb_suspend+0x0/0x3c returns -6
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

Actually, the only possible case in which the commit in question can
introduce suspend failures like this is when some dependency
information is missing and so the reordering causes the ordering to
change from the (working) implicit one.

> Interestingly one of the bugs that the offending patch fixes is similar
> in the failure mode but for the reverse reason: the implicit order
> causes suspend/resume to fail.

And that happens because some dependency information is missing.

So we have failing cases when dependency information is missing, so
instead of fixing those we have tried to make the core change the
ordering after every successful probe in the hope that this will take
care of the problem without introducing new breakage.

However, it evidently has introduced new breakage and in order to fix
it we need to figure out what dependency information is missing in the
failing cases and put that information in, but we may as well do the
same for the cases that are failing without the offending change.

So why don't we revert the commit in question and do just that?
