Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93EE41045D3
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 22:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfKTVgq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 16:36:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23304 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725819AbfKTVgq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 16:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574285804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0pAJwOUYZlIukE0BbqgWGnjQga+s55dRnSCojvuuOg8=;
        b=WnYCpyrj2aGLa/LNN6Okn1S8iOzMMNmvquuG2JtT+CBMhvUrbgVCbCegIHZzOekGTE14Yk
        UtoLD/wjyetuhgDnO/goi9y8zvm69lceRC3rLfP0UItYE/I3o0UC+gHRk3dsKTjzLaOHJG
        qmeA5oUw9GP9y67PUSr11oLETKv60YY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-rwsUtdMEN3CZkyIVM7IXaw-1; Wed, 20 Nov 2019 16:36:43 -0500
Received: by mail-qv1-f70.google.com with SMTP id i16so762020qvm.14
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 13:36:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BEOpo1eAW+6WweEGc5o46P0sIScU4OqKVUN6KWPXGDE=;
        b=GEtOkLKcxB9cXB64uKhB+sB207WvI9rEixpldKOHt4+swDvZ/FesGVvGt1NJQ9Fb5C
         4qQ2cGh8bXT/ZYo+lDHU3tda3s9yh9qs6AJhvz0es/EqpaDef39+tjAIgqxDrLXcW6bT
         YPPfM89k3rAyqY8sONIHcPJ9EGIZzBPr7pXuagz2UaQjZoAP6SCe4tzmMJwHHzq5It2W
         a7zQLoUT+WwxJYRNkB69Gi8gejeY+3naRu4oCn3LuOUIWaZg5ha1UtcL2BS5hmW/ZyEg
         xGPqmfw2ojbeI89FKZz/wyWLXBJWFnrmpPwDSPIf//b4tF55t3d4Z04qg/Svi2FNcmRg
         XyEA==
X-Gm-Message-State: APjAAAUeO4lM1tH5+3K/UgsVHbThwPxl2a11SF9xaadKqV1KE2uXTuoW
        WOEPAL19MojD+QHxcvgOAmkxtOFjJkg3Xmb6TqlxfPhCa/ejtChXyLtcXn53LAP/w9diFGtCfNL
        dPapDUzkLMornrj6jJCmBUsCBJ6jl9B5L+Q4=
X-Received: by 2002:a0c:baad:: with SMTP id x45mr4716312qvf.230.1574285802804;
        Wed, 20 Nov 2019 13:36:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqyekfP3DQaxdB5Z3roInhLmB3w1CVawg+LlvI/EnwQJNFYBD1Fs7D2MZDTcOhlIQfBzDzvxUKzBQtFDGEGE1aM=
X-Received: by 2002:a0c:baad:: with SMTP id x45mr4716288qvf.230.1574285802452;
 Wed, 20 Nov 2019 13:36:42 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com> <20191120115127.GD11621@lahna.fi.intel.com>
 <CACO55tsfNOdtu5SZ-4HzO4Ji6gQtafvZ7Rm19nkPcJAgwUBFMw@mail.gmail.com>
 <CACO55tscD_96jUVts+MTAUsCt-fZx4O5kyhRKoo4mKoC84io8A@mail.gmail.com>
 <20191120120913.GE11621@lahna.fi.intel.com> <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
 <20191120151542.GH11621@lahna.fi.intel.com> <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
 <20191120155301.GL11621@lahna.fi.intel.com> <20191120162306.GM11621@lahna.fi.intel.com>
In-Reply-To: <20191120162306.GM11621@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 20 Nov 2019 22:36:31 +0100
Message-ID: <CACO55tsvTG2E7_3nn1sTdPQXzxaZA96k+gmSBBXjPvei6v=kxg@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
X-MC-Unique: rwsUtdMEN3CZkyIVM7IXaw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

with the branch and patch applied:
https://gist.githubusercontent.com/karolherbst/03c4c8141b0fa292d781badfa186=
479e/raw/5c62640afbc57d6e69ea924c338bd2836e770d02/gistfile1.txt

On Wed, Nov 20, 2019 at 5:23 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Wed, Nov 20, 2019 at 05:53:07PM +0200, Mika Westerberg wrote:
> > On Wed, Nov 20, 2019 at 04:37:14PM +0100, Karol Herbst wrote:
> > > On Wed, Nov 20, 2019 at 4:15 PM Mika Westerberg
> > > <mika.westerberg@intel.com> wrote:
> > > >
> > > > On Wed, Nov 20, 2019 at 01:11:52PM +0100, Karol Herbst wrote:
> > > > > On Wed, Nov 20, 2019 at 1:09 PM Mika Westerberg
> > > > > <mika.westerberg@intel.com> wrote:
> > > > > >
> > > > > > On Wed, Nov 20, 2019 at 12:58:00PM +0100, Karol Herbst wrote:
> > > > > > > overall, what I really want to know is, _why_ does it work on=
 windows?
> > > > > >
> > > > > > So do I ;-)
> > > > > >
> > > > > > > Or what are we doing differently on Linux so that it doesn't =
work? If
> > > > > > > anybody has any idea on how we could dig into this and figure=
 it out
> > > > > > > on this level, this would probably allow us to get closer to =
the root
> > > > > > > cause? no?
> > > > > >
> > > > > > Have you tried to use the acpi_rev_override parameter in your s=
ystem and
> > > > > > does it have any effect?
> > > > > >
> > > > > > Also did you try to trace the ACPI _ON/_OFF() methods? I think =
that
> > > > > > should hopefully reveal something.
> > > > > >
> > > > >
> > > > > I think I did in the past and it seemed to have worked, there is =
just
> > > > > one big issue with this: it's a Dell specific workaround afaik, a=
nd
> > > > > this issue plagues not just Dell, but we've seen it on HP and Len=
ovo
> > > > > laptops as well, and I've heard about users having the same issue=
s on
> > > > > Asus and MSI laptops as well.
> > > >
> > > > Maybe it is not a workaround at all but instead it simply determine=
s
> > > > whether the system supports RTD3 or something like that (IIRC Windo=
ws 8
> > > > started supporting it). Maybe Dell added check for Linux because at=
 that
> > > > time Linux did not support it.
> > > >
> > >
> > > the point is, it's not checking it by default, so by default you stil=
l
> > > run into the windows 8 codepath.
> >
> > Well you can add the quirk to acpi_rev_dmi_table[] so it goes to that
> > path by default. There are a bunch of similar entries for Dell machines=
.
> >
> > Of course this does not help the non-Dell users so we would still need
> > to figure out the root cause.
>
> I think I asked you to test the PCIe delay patch and it did not help but
> I wonder if it helps if we increase the delay. As an experiment could
> you try Bjorn's pci/pm branch. The last two commits are for the delay.
>
> If you could pull that branch and apply the following patch on top and
> give it a try? Then post the dmesg somewhere so we can see whether it
> did the delay at all.
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 1f319b1175da..1ad6f1372ed5 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4697,12 +4697,7 @@ void pci_bridge_wait_for_secondary_bus(struct pci_=
dev *dev)
>                 return;
>         }
>
> -       /* Take d3cold_delay requirements into account */
> -       delay =3D pci_bus_max_d3cold_delay(dev->subordinate);
> -       if (!delay) {
> -               up_read(&pci_bus_sem);
> -               return;
> -       }
> +       delay =3D 500;
>
>         child =3D list_first_entry(&dev->subordinate->devices, struct pci=
_dev,
>                                  bus_list);
> @@ -4715,7 +4710,7 @@ void pci_bridge_wait_for_secondary_bus(struct pci_d=
ev *dev)
>          * management for them (see pci_bridge_d3_possible()).
>          */
>         if (!pci_is_pcie(dev)) {
> -               pci_dbg(dev, "waiting %d ms for secondary bus\n", 1000 + =
delay);
> +               pci_info(dev, "waiting %d ms for secondary bus\n", 1000 +=
 delay);
>                 msleep(1000 + delay);
>                 return;
>         }
> @@ -4741,10 +4736,10 @@ void pci_bridge_wait_for_secondary_bus(struct pci=
_dev *dev)
>                 return;
>
>         if (pcie_get_speed_cap(dev) <=3D PCIE_SPEED_5_0GT) {
> -               pci_dbg(dev, "waiting %d ms for downstream link\n", delay=
);
> +               pci_info(dev, "waiting %d ms for downstream link\n", dela=
y);
>                 msleep(delay);
>         } else {
> -               pci_dbg(dev, "waiting %d ms for downstream link, after ac=
tivation\n",
> +               pci_info(dev, "waiting %d ms for downstream link, after a=
ctivation\n",
>                         delay);
>                 if (!pcie_wait_for_link_delay(dev, true, delay)) {
>                         /* Did not train, no need to wait any further */
> @@ -4753,7 +4748,7 @@ void pci_bridge_wait_for_secondary_bus(struct pci_d=
ev *dev)
>         }
>
>         if (!pci_device_is_present(child)) {
> -               pci_dbg(child, "waiting additional %d ms to become access=
ible\n", delay);
> +               pci_info(child, "waiting additional %d ms to become acces=
sible\n", delay);
>                 msleep(delay);
>         }
>  }
>

