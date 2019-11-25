Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09951109553
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 23:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfKYWBY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 17:01:24 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36316 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYWBY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 17:01:24 -0500
Received: by mail-oi1-f193.google.com with SMTP id j7so14690581oib.3
        for <linux-pm@vger.kernel.org>; Mon, 25 Nov 2019 14:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QfkXRmU9vvpHFOe7u7keWz0SRMT0LuebZTI1s8tgKEM=;
        b=GVXrCTHsZFQg2CaRGPSnivYjV/U5/QkOAe9a0rIKB6MHiSqFFpRR2gHWEdmIzrc3Pl
         u6eMGAL9A8qnhShU38iOgbhR82iMzQJXFzftFttZdQMPGRFXcAZAUskIn4P1s7OjM98P
         05T8awYLXXRISip+veQFJzkApoYiBfEyQsLZzHHe4Ji24VAXHE8/qYGAtedFHtEjAieZ
         Jz3hUVgFhAF8ZMqDvTvTmyAGWGb2a1PXUEPCnDCOhdAv4OrfMlbbLmWqOXY75SBUTCMN
         wYB+M/LHTiJmxnHNUDjbiZJ1iUic98edOpL2eQNt4EB6HhDpOEj/enuJi6nZtamGGp2T
         +ykQ==
X-Gm-Message-State: APjAAAXTWf+bLCsBpC01iRXd/ySMK1xGtvkXieyAtglW0Zup2MyUISQ4
        C1z0kkJK55GjsQjMVvF0COgHM92dvIKPOah63bA=
X-Google-Smtp-Source: APXvYqwSEA7VpuVJtvv4bKzUr+F3zmMULTNei5lhYJyVunuxx8nK8SDpD/jVcjeYihH1KdneN3OuMzRg9jM3JXp1qnY=
X-Received: by 2002:aca:d4c6:: with SMTP id l189mr868397oig.68.1574719281951;
 Mon, 25 Nov 2019 14:01:21 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <alpine.DEB.2.21.1911241929220.16116@hp-x360n>
 <CAJZ5v0ichG5N+yLyyX1BZhNf+Fk_xrvQ+9q4FeP3XVtxKp7yug@mail.gmail.com>
 <2977390.9qzeJo7xji@kreacher> <alpine.DEB.2.21.1911251019100.12067@hp-x360n> <alpine.DEB.2.21.1911251155440.2817@hp-x360n>
In-Reply-To: <alpine.DEB.2.21.1911251155440.2817@hp-x360n>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Nov 2019 23:01:10 +0100
Message-ID: <CAJZ5v0hMR8_i=oA1ovX0-xfa_w1x7nHhTwmmKRPu27ceFxpFow@mail.gmail.com>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep:
 Simplify suspend-to-idle control flow)
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 25, 2019 at 9:11 PM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> On Mon, 25 Nov 2019, Kenneth R. Crudup wrote:
>
> > I'll keep testing it (and the best way to get something to break is to
> > proclaim it's "fixed" :)
>
> ... grumble ...!
>
> So, put the laptop to sleep, put it in my bag[1], then head off to go work.
> Get to where I'm working, plug in the power meter, it's now drawing 150mA
> while idle ...  uh oh. Sure enough, open the lid, hit some keys, dead. Had
> to do a long- power-button reset to get it back up again. I note that it's
> now charging (I may not have allowed the battery to drain enough for the
> charging circuit think the battery's discharged enough to begin a charge
> cycle before).

It looks like the platform has problems with switching power between
AC and battery while suspended.  Also this appears to be related to
the EC.

Also I'm wondering if the problem is reproducible with ec_no_wakeup
and the last patch I posted applied.

> I'm going to go back to the original patch (the three removed lines) for now
> (which may not do any better long-term, but I'll have to at least try.

The last patch I posted is orthogonal to this.  It actually should be
entirely transparent on systems without any issues.

But with that patch applied, please try to comment out the
acpi_s2idle_sync() in acpi_s2idle_wake() and retest.

> [1] - I can let it sit idle at home and it'll be OK, but when I put it in
> my bag and go somewhere it always seems to be the trigger for failed resumes
> I have no idea why.
>
> BTW, what was different about your 2nd patch (the addition of acpi_s2idle_sync()
> to the resume cycle) was I was getting WMI power events captured during
> resume in the EC blocked/unblocked path, which hadn't happened before:

That's because of the added ACPI events flushing in acpi_s2idle_restore().

> -----
> Nov 25 10:16:56 hp-x360n kernel: [ 4418.792164] PM: suspend entry (s2idle)
> Nov 25 10:16:56 hp-x360n kernel: [ 4418.801869] Filesystems sync: 0.009 seconds
> Nov 25 10:17:29 hp-x360n kernel: [ 4418.802615] Freezing user space processes ... (elapsed 0.002 seconds) done.
> Nov 25 10:17:29 hp-x360n kernel: [ 4418.805200] OOM killer disabled.
> Nov 25 10:17:29 hp-x360n kernel: [ 4418.805201] Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
> Nov 25 10:17:29 hp-x360n kernel: [ 4418.806127] printk: Suspending console(s) (use no_console_suspend to debug)
> Nov 25 10:17:29 hp-x360n kernel: [ 4418.817183] [drm] GuC communication disabled
> Nov 25 10:17:29 hp-x360n kernel: [ 4419.296506] ACPI: EC: interrupt blocked
> *** Nov 25 10:17:29 hp-x360n kernel: [ 4440.111494] hp_wmi_notify(): event_id 0x20001, event_data 0x00000000
> *** Nov 25 10:17:29 hp-x360n kernel: [ 4440.111496] hp_wmi: Unknown event_id - 131073 - 0x0

This looks kind of weird.

Do you get similar "unknown" events during normal operation too?

Anyway, hp_wmi is involved and I'm quite unsure if it is ready to
handle events during acpi_s2idle_wake(), so that's why it may not work
every time with the last patch applied.

> *** Nov 25 10:17:29 hp-x360n kernel: [ 4440.198013] hp_wmi_notify(): event_id 0x03, event_data 0x00000000
> Nov 25 10:17:29 hp-x360n kernel: [ 4449.527844] ACPI: EC: interrupt unblocked
> Nov 25 10:17:29 hp-x360n kernel: [ 4451.118846] intel_pmc_core INT33A1:00: CPU did not enter SLP_S0!!! (S0ix cnt=0)
> Nov 25 10:17:29 hp-x360n kernel: [ 4451.126383] usb usb3: root hub lost power or was reset
> Nov 25 10:17:29 hp-x360n kernel: [ 4451.126384] usb usb4: root hub lost power or was reset
> Nov 25 10:17:29 hp-x360n kernel: [ 4451.127298] [drm] GuC communication enabled
> Nov 25 10:17:29 hp-x360n kernel: [ 4451.127400] i915 0000:00:02.0: GuC firmware i915/kbl_guc_33.0.0.bin version 33.0 subm
> ission:disabled
> Nov 25 10:17:29 hp-x360n kernel: [ 4451.127401] i915 0000:00:02.0: HuC firmware i915/kbl_huc_ver02_00_1810.bin version 2.
> 0 authenticated:yes
> Nov 25 10:17:29 hp-x360n kernel: [ 4452.229576] OOM killer enabled.
> Nov 25 10:17:29 hp-x360n kernel: [ 4452.229577] Restarting tasks ... done.
> Nov 25 10:17:29 hp-x360n auto-rotate[15448]: normal
> Nov 25 10:17:29 hp-x360n kernel: [ 4452.256340] thermal thermal_zone7: failed to read out thermal zone (-61)
> Nov 25 10:17:29 hp-x360n systemd-udevd[18777]: Process '/usr/sbin/tlp auto' failed with exit code 4.
> Nov 25 10:17:29 hp-x360n systemd-udevd[18777]: Process '/usr/sbin/tlp auto' failed with exit code 4.
> Nov 25 10:17:29 hp-x360n systemd-sleep[18673]: System resumed.
> Nov 25 10:17:29 hp-x360n kernel: [ 4452.313345] PM: suspend exit
> ----
>
> (best I can tell, event_id 0x20001 is a charger unplug event and event_id 0x03 is a charger plug event).
>
> BTW, is ther any way to determine if this is an issue with some other driver? I'd think I'd be getting BUG_ON()s
> if that were it, though.

Not necessarily.

It appears to be related to hp_wmi as mentioned above.
