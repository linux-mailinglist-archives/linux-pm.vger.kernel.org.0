Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0A43DA6D9
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 16:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbhG2Oum (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jul 2021 10:50:42 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:53056
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237757AbhG2Oum (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jul 2021 10:50:42 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 06D4B3F0A8
        for <linux-pm@vger.kernel.org>; Thu, 29 Jul 2021 14:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627570237;
        bh=bU3aJudrCBoWRfseckxJjEUGOPUyIi0wc73ZEH0TAIo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=jCu6Nj6KfmlmQBvAxBB0tSc0zp7GO8uycf4ZWlSDUuGSL2u/4Nb9mGSv6Q/NSjqog
         BKNsIkMQBJRLZ4QXOCir1TYW8Kx3V9YRWCz2kOX2xYVYGd+GNsDlqw5lNXwZYAubuw
         2tMt0QS521POL8tLul2FwXUHpxrZscGuDXbunq0lnQm7+cm/l+FOqIe3fs1wWmUCVm
         /z5K2wHDOSOJopp/k/pLZFfOu4LQhpkBQdG74Ri1bj3RGZnHtR1wJNbdHQr9bo58i5
         CdTR0pGOj3LVPL/LrOik0/gm08BWnOuVOOZ+rNCQkL0gmU+UUhgM7BN4rCCT9TXI8S
         lnzrRs56+L2DQ==
Received: by mail-ed1-f71.google.com with SMTP id k14-20020a05640212ceb02903bc50d32c17so3074632edx.12
        for <linux-pm@vger.kernel.org>; Thu, 29 Jul 2021 07:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bU3aJudrCBoWRfseckxJjEUGOPUyIi0wc73ZEH0TAIo=;
        b=Ni8W+Zkzko/Lb+xFK4h4h5kCWx/O5bR/T4oUT9kDW7hAzRHJbWX0KBJBxYsUo3ENvx
         U0fkqZaJm3U91qACTK45q9HT9FfhGGW3Bh1M53vmpnKADpCw1i4sXnMHjxN4HUUP+PUn
         QwM0mefPDPT8ffne2JhGGdoXB2cAzBvG10u4EbIE5wqSTKO21+WabOrUV4dQyx3n/8IS
         DZXp3EH8gUXMt27i0STCKT+dA5ai+k37a19KA97Hdniyi35EYBFI5XiIjDyawbCtb6aB
         MvB9SkPd4jtpsTLvdrUQeEpvWoXLc3Zco8siz/hKhGyIL0+RKiz1avXmw9OrGKJMGa6M
         PwOw==
X-Gm-Message-State: AOAM532AMxksnaRlQ12tN98jeUI1qMXokVohR/2WhnXbJOa0rklIU2ma
        JvAXgz8yWhjwBu0aGT+8S3dEvDxzO6B6mW+J3cj58SZvy5cg6E8hJ+JT/BJNZ4D2tPWmK5WANMv
        JlcLOeVv385x6D997fMKvFtYizLrk0JTRoDjDJsbOpYpjsaX239wt
X-Received: by 2002:a17:906:4e52:: with SMTP id g18mr5068694ejw.432.1627570231829;
        Thu, 29 Jul 2021 07:50:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLbaFtB4Oa0qb/cXYZ3tKM/1FAsoCdzWz2mqugcIj84Rzh8YIxhE0ygEpBqP7MTQZ+YfzXNAEBEeRHHsZ7qNk=
X-Received: by 2002:a17:906:4e52:: with SMTP id g18mr5068680ejw.432.1627570231539;
 Thu, 29 Jul 2021 07:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <bug-213873-41252@https.bugzilla.kernel.org/> <20210727155512.GA716431@bjorn-Precision-5520>
In-Reply-To: <20210727155512.GA716431@bjorn-Precision-5520>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 29 Jul 2021 22:50:16 +0800
Message-ID: <CAAd53p7PCP5uT8ZrM9yYBKmAR7bKcWszEqtq_htP13XzW5jLHg@mail.gmail.com>
Subject: Re: [Bug 213873] New: Hotplug ethernet cable to runtime suspended
 Realtek NIC doesn't raise PCIe PME IRQ on Intel ADL
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 27, 2021 at 11:55 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jul 27, 2021 at 06:10:13AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=213873
> >
> >             Bug ID: 213873
> >            Summary: Hotplug ethernet cable to runtime suspended Realtek
> >                     NIC doesn't raise PCIe PME IRQ on Intel ADL
> >            Product: Drivers
> >            Version: 2.5
> >     Kernel Version: mainline
> >           Hardware: All
> >                 OS: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: PCI
> >           Assignee: drivers_pci@kernel-bugs.osdl.org
> >           Reporter: kai.heng.feng@canonical.com
> >         Regression: No
> >
> > Both PCIe bridge and Realtek NIC are runtime suspended. When ethernet cable is
> > plugged, PMEStatus and PMEPending are marked:
> > RootSta: PME ReqID 0200, PMEStatus+ PMEPending+
> >
> > But the IRQ isn't raised:
> > $ cat /proc/interrupts  | grep PME
> >  145:          0          0          0          0          0          0
> >  0          0          0          0          0          0   VMD-MSI  126  PCIe
> > PME, aerdrv, pcie-dpc
> >
> > So the hotplug event isn't detected.
> >
> > --
>
> From the lspci after cable hotplug (comment #3):
>
>   0000:00:1c.0 PCI bridge ...
>     RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>     RootSta: PME ReqID 0200, PMEStatus+ PMEPending+
>
> So it looks like the root port is not enabled to generate a PME
> interrupt.  pcie_pme_interrupt_enable() looks like it *could* enable
> that.  From a quick look, my guess is that pme.c doesn't claim this
> root port because the platform says it doesn't support it:
>
>   acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME]
>   acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability LTR]
>
> Does booting with "pcie_ports=native" make it work?  That's not a very
> good solution, of course, because then both the firmware and Linux
> think they own this functionality.

Yes, thanks for spotting this.

>
> Is there a BIOS update that would fix this?

This platform is still under enablement so we'll get a BIOS fix.

Kai-Heng

>
> Bjorn
