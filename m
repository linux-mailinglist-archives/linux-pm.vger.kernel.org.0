Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28599116C64
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 12:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfLILjG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 06:39:06 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42249 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfLILjG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 06:39:06 -0500
Received: by mail-oi1-f196.google.com with SMTP id j22so5985784oij.9;
        Mon, 09 Dec 2019 03:39:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mPM/hwSdd2dpR68KRDIRUCSfL+ZarPQKfGdIq8K3ckk=;
        b=Y4eQkSZOSr43h0aL45DzLMphxNKlD0BI/If9WdLqXzn7K7BUcBBmdQWzg2OVXb4AIS
         mcG+v3YF8MHn/CtlnPnh6i8gu7pWhSqNHchoBv9CEKFlM98Il5ciD86gFSuKGEGV4cCP
         wcx+BgXMzuryB89HBwFi5TMa2rH81MdNnFEcw7Q/ojylaNIVC1rju+Gh3ZzhlvVJ0Ac4
         D8DZCLeCps3Seh2zVQ1KcZ6Q6nV0v+OpPOetnwCpzNwkWdT3a6Bthk518s+WT+6ucx9W
         PXhCbUcQJPDOtYYXdsjjtb7RCLRT8M8ZfC1IIbxJLgqoESCMqiV10DGT6/ZtVXmY504T
         6glQ==
X-Gm-Message-State: APjAAAV9rYFSjXtWoAJrRMPjyMBuYCZwwg9K0JT3mvDHdXvgP1eV2t/e
        oNgLHHrmDria8Wd6GqVGVv81zn0bhsnhrNfZlLk=
X-Google-Smtp-Source: APXvYqzG8vwOM20aU3KzuzbhZ5+B1Tkp8z1UETWtoGf+LzRaBUX4n5P3Sb4ZJ2d9h2hcY0SF6eTRe0bkPN0OirKV+LE=
X-Received: by 2002:a05:6808:1c5:: with SMTP id x5mr17465882oic.57.1575891545016;
 Mon, 09 Dec 2019 03:39:05 -0800 (PST)
MIME-Version: 1.0
References: <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <CACO55ttXJgXG32HzYP_uJDfQ6T-d8zQaGjXK_AZD3kF0Rmft4g@mail.gmail.com>
 <CAJZ5v0ibzcLEm44udUxW2uVgaF9NapdNBF8Ag+RE++u7gi2yNA@mail.gmail.com>
 <CACO55ttBkZD9dm0Y_jT931NnzHHtDFyLz28aoo+ZG0pnLzPgbA@mail.gmail.com>
 <CAJZ5v0jbh7jz+YQcw-gC5ztmMOc4E9+KFBCy4VGRsRFxBw-gnw@mail.gmail.com>
 <e0eeddf4214f54dfac08e428dfb30cbd39f20680.camel@redhat.com>
 <20191127114856.GZ11621@lahna.fi.intel.com> <CACO55tt5SAf24vk0XrKguhh2J=WuKirDsdY7T+u7PsGFCpnFxg@mail.gmail.com>
 <e7aec10d789b322ca98f4b250923b0f14f2b8226.camel@redhat.com> <CACO55tu+hT1WGbBn_nxLR=A-X6YWmeuz-UztJKw0QAFQDDV_xg@mail.gmail.com>
In-Reply-To: <CACO55tu+hT1WGbBn_nxLR=A-X6YWmeuz-UztJKw0QAFQDDV_xg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Dec 2019 12:38:53 +0100
Message-ID: <CAJZ5v0hcONxiWD+jpBe62H1SZ-84iNxT+QCn8mcesB1C7SVWjw@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        Mika Westerberg <mika.westerberg@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 9, 2019 at 12:17 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> anybody any other ideas?

Not yet, but I'm trying to collect some more information.

> It seems that both patches don't really fix
> the issue and I have no idea left on my side to try out. The only
> thing left I could do to further investigate would be to reverse
> engineer the Nvidia driver as they support runpm on Turing+ GPUs now,
> but I've heard users having similar issues to the one Lyude told us
> about... and I couldn't verify that the patches help there either in a
> reliable way.

It looks like the newer (8+) versions of Windows expect the GPU driver
to prepare the GPU for power removal in some specific way and the
latter fails if the GPU has not been prepared as expected.

Because testing indicates that the Windows 7 path in the platform
firmware works, it may be worth trying to do what it does to the PCIe
link before invoking the _OFF method for the power resource
controlling the GPU power.

If the Mika's theory that the Win7 path simply turns the PCIe link off
is correct, then whatever the _OFF method tries to do to the link
after that should not matter.

> On Wed, Nov 27, 2019 at 8:55 PM Lyude Paul <lyude@redhat.com> wrote:
> >
> > On Wed, 2019-11-27 at 12:51 +0100, Karol Herbst wrote:
> > > On Wed, Nov 27, 2019 at 12:49 PM Mika Westerberg
> > > <mika.westerberg@intel.com> wrote:
> > > > On Tue, Nov 26, 2019 at 06:10:36PM -0500, Lyude Paul wrote:
> > > > > Hey-this is almost certainly not the right place in this thread to
> > > > > respond,
> > > > > but this thread has gotten so deep evolution can't push the subject
> > > > > further to
> > > > > the right, heh. So I'll just respond here.
> > > >
> > > > :)
> > > >
> > > > > I've been following this and helping out Karol with testing here and
> > > > > there.
> > > > > They had me test Bjorn's PCI branch on the X1 Extreme 2nd generation,
> > > > > which
> > > > > has a turing GPU and 8086:1901 PCI bridge.
> > > > >
> > > > > I was about to say "the patch fixed things, hooray!" but it seems that
> > > > > after
> > > > > trying runtime suspend/resume a couple times things fall apart again:
> > > >
> > > > You mean $subject patch, no?
> > > >
> > >
> > > no, I told Lyude to test the pci/pm branch as the runpm errors we saw
> > > on that machine looked different. Some BAR error the GPU reported
> > > after it got resumed, so I was wondering if the delays were helping
> > > with that. But after some cycles it still caused the same issue, that
> > > the GPU disappeared. Later testing also showed that my patch also
> > > didn't seem to help with this error sadly :/
> > >
> > > > > [  686.883247] nouveau 0000:01:00.0: DRM: suspending object tree...
> > > > > [  752.866484] ACPI Error: Aborting method \_SB.PCI0.PEG0.PEGP.NVPO due
> > > > > to previous error (AE_AML_LOOP_TIMEOUT) (20190816/psparse-529)
> > > > > [  752.866508] ACPI Error: Aborting method \_SB.PCI0.PGON due to
> > > > > previous error (AE_AML_LOOP_TIMEOUT) (20190816/psparse-529)
> > > > > [  752.866521] ACPI Error: Aborting method \_SB.PCI0.PEG0.PG00._ON due
> > > > > to previous error (AE_AML_LOOP_TIMEOUT) (20190816/psparse-529)
> > > >
> > > > This is probably the culprit. The same AML code fails to properly turn
> > > > on the device.
> > > >
> > > > Is acpidump from this system available somewhere?
> >
> > Attached it to this email
> >
> > > >
> > --
> > Cheers,
> >         Lyude Paul
>
