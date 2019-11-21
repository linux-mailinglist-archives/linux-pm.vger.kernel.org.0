Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B869105679
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 17:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfKUQGZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 11:06:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31803 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726358AbfKUQGZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 11:06:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574352384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2bUmJw5NVvVVplfFLTrj0DWj0K1ssd2HaG6I0BvVfDc=;
        b=VZ1qDEaodViSDGiu4IZVwLGVcllu2AfAZB+V93m01oQXuRKKKIf2VDrTdABtnRkWNqFO2B
        D8xfusEjXTUE5auPvNxoZlwXR7N+LwtnYivg3K/SkoeYmrjRwv8ZNB+FqyjkawrHliZiu6
        q4RgSxsRs4U9LXzkPoYo79eZP6/utUc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-xPyNFv15OYyc1UtsGwGlDw-1; Thu, 21 Nov 2019 11:06:23 -0500
Received: by mail-qt1-f197.google.com with SMTP id m8so101708qta.20
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2019 08:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4u5SaUcnCKvjh6UsP+VC2r3Fd3UTQ4sI8vEm9p9IspQ=;
        b=lRJBVLWnRYEPbEA2xS/IUkaDD6IaFgldyCPaSvUXqUrz+ThEyARR7QS3oOMqt0uNsN
         qMGSc5fNpneL1OO3m98En629brYlGbbEsPqtqJypz2yrqATPrXrIe/fFzvF0RqToZppT
         ingbqydMH7XFUIjJ2IixnkbqZI59FC7y+W9Quylt8RavCruA+zb7vdqM/FhiBjAPyBzj
         +nkGnkpqM/xDkODAo4+jYFgCtkCKJV1/yD0MDjxYMHIFEn2QhmlTujy5YqfdzvxZe9md
         qW0dwWWNGZV5YLhEOYZxsASsWh9sr5OICC858iIYhhs5GUfSkt6tlhu9yC1eEkn6JrKj
         N6HQ==
X-Gm-Message-State: APjAAAX/nlDBXmyZKI0sLVYKsou4m2XC8ADSttJE7s1HIMMji+o1ltb2
        sX1lvLjJs6wtaPyqi25vaOShL09sNT84vqYG3ytmH7zbNdQ36ZAG59NP5CP6/fLogT6ueHdqerF
        /iTYU3bY9aqsie0mFEF01EH3ZAidMLyC9IoM=
X-Received: by 2002:ac8:73c6:: with SMTP id v6mr9366589qtp.137.1574352381576;
        Thu, 21 Nov 2019 08:06:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqyMWsnX6Oq8sVu9TbpGunjITLNboA1N6sHCOJjdw/pIhaC+MKSuuxVJFGx9BLlu7cQMJ12GJrcBaxUzBIiQcN8=
X-Received: by 2002:ac8:73c6:: with SMTP id v6mr9366479qtp.137.1574352380570;
 Thu, 21 Nov 2019 08:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20191120120913.GE11621@lahna.fi.intel.com> <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
 <20191120151542.GH11621@lahna.fi.intel.com> <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
 <20191120155301.GL11621@lahna.fi.intel.com> <CAJZ5v0hkT-fHFOQKzp2qYPyR+NUa4c-G-uGLPZuQxqsG454PiQ@mail.gmail.com>
 <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <CACO55ttXJgXG32HzYP_uJDfQ6T-d8zQaGjXK_AZD3kF0Rmft4g@mail.gmail.com>
 <CAJZ5v0ibzcLEm44udUxW2uVgaF9NapdNBF8Ag+RE++u7gi2yNA@mail.gmail.com>
In-Reply-To: <CAJZ5v0ibzcLEm44udUxW2uVgaF9NapdNBF8Ag+RE++u7gi2yNA@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 21 Nov 2019 17:06:09 +0100
Message-ID: <CACO55ttBkZD9dm0Y_jT931NnzHHtDFyLz28aoo+ZG0pnLzPgbA@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
X-MC-Unique: xPyNFv15OYyc1UtsGwGlDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 21, 2019 at 4:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote=
:
>
> On Thu, Nov 21, 2019 at 1:53 PM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > On Thu, Nov 21, 2019 at 12:46 PM Mika Westerberg
> > <mika.westerberg@intel.com> wrote:
> > >
> > > On Thu, Nov 21, 2019 at 12:34:22PM +0100, Rafael J. Wysocki wrote:
> > > > On Thu, Nov 21, 2019 at 12:28 PM Mika Westerberg
> > > > <mika.westerberg@intel.com> wrote:
> > > > >
> > > > > On Wed, Nov 20, 2019 at 11:29:33PM +0100, Rafael J. Wysocki wrote=
:
> > > > > > > last week or so I found systems where the GPU was under the "=
PCI
> > > > > > > Express Root Port" (name from lspci) and on those systems all=
 of that
> > > > > > > seems to work. So I am wondering if it's indeed just the 0x19=
01 one,
> > > > > > > which also explains Mikas case that Thunderbolt stuff works a=
s devices
> > > > > > > never get populated under this particular bridge controller, =
but under
> > > > > > > those "Root Port"s
> > > > > >
> > > > > > It always is a PCIe port, but its location within the SoC may m=
atter.
> > > > >
> > > > > Exactly. Intel hardware has PCIe ports on CPU side (these are cal=
led
> > > > > PEG, PCI Express Graphics, ports), and the PCH side. I think the =
IP is
> > > > > still the same.
> > > > >
> >
> > yeah, I meant the bridge controller with the ID 0x1901 is on the CPU
> > side. And if the Nvidia GPU is on a port on the PCH side it all seems
> > to work just fine.
>
> But that may involve different AML too, may it not?
>
> > > > > > Also some custom AML-based power management is involved and tha=
t may
> > > > > > be making specific assumptions on the configuration of the SoC =
and the
> > > > > > GPU at the time of its invocation which unfortunately are not k=
nown to
> > > > > > us.
> > > > > >
> > > > > > However, it looks like the AML invoked to power down the GPU fr=
om
> > > > > > acpi_pci_set_power_state() gets confused if it is not in PCI D0=
 at
> > > > > > that point, so it looks like that AML tries to access device me=
mory on
> > > > > > the GPU (beyond the PCI config space) or similar which is not
> > > > > > accessible in PCI power states below D0.
> > > > >
> > > > > Or the PCI config space of the GPU when the parent root port is i=
n D3hot
> > > > > (as it is the case here). Also then the GPU config space is not
> > > > > accessible.
> > > >
> > > > Why would the parent port be in D3hot at that point?  Wouldn't that=
 be
> > > > a suspend ordering violation?
> > >
> > > No. We put the GPU into D3hot first, then the root port and then turn
> > > off the power resource (which is attached to the root port) resulting
> > > the topology entering D3cold.
> > >
> >
> > If the kernel does a D0 -> D3hot -> D0 cycle this works as well, but
> > the power savings are way lower, so I kind of prefer skipping D3hot
> > instead of D3cold. Skipping D3hot doesn't seem to make any difference
> > in power savings in my testing.
>
> OK
>
> What exactly did you do to skip D3cold in your testing?
>

For that I poked into the PCI registers directly and skipped doing the
ACPI calls and simply checked for the idle power consumption on my
laptop. But I guess I should retest with calling pci_d3cold_disable
from nouveau instead? Or is there a different preferable way of
testing this?

