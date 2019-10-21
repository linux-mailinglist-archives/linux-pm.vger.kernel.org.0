Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E8EDEE70
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 15:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfJUNyW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 09:54:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbfJUNyW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Oct 2019 09:54:22 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAF46859FE
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 13:54:21 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id g62so13486513qkb.20
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 06:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2G1xusxf4dns3pndHNTvCsxrH/ysqq3dgJVBnbwKIs=;
        b=Q3kqjcjNQFG9enS/NNYkprg4mURnfhS3XxmGm1YCCF+SLbP0nsXsLSeG9vAtlmCIkW
         LILTrucDuZnRaLfTkqk+VGG6jkxUYTfTEATYkCw5s/Zkqr7IvuYlelQkNs9ueICt9sqm
         EPyY9Cl7fAy8GJXhVUGD4agatDClPzLlo9MdVI/bCQhIc321rsRuOe/drnV7FzC5nJOt
         15do3axvHMDmrqky5iDRE3WfDS37f3RHcouiE9dm/7nxl+Iuadwl3xcSbdWyb+gi3Gnj
         F3mxxMLJfNM+Y6BTk5pQ8qx/P9beI5Wpsut1RaIAozJ4QJQ5kDvCXKx1ehmxIJYcQFwQ
         Dmjw==
X-Gm-Message-State: APjAAAV+coh0aAyBaCjLv/e5mY8PsvHnGfemif7Vbl/A1uTA4T5e9iFY
        mS+lQe0VZ3LGY+REmEc5N/4XhN58utboO42W1B5Lla3alSRIM7zEF/6wNIM5FvI/I7yF3MYBFVT
        K5f9AByB/AOidSH9V3Q0Tz4k7QnN7f+rehd8=
X-Received: by 2002:ac8:664b:: with SMTP id j11mr24827248qtp.137.1571666061243;
        Mon, 21 Oct 2019 06:54:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxkFGgGdHL5wN4wh/Zt1E39qBLM+0KoKUb4VD7Jy4sRN04D/L8vg7pR474/ZE01oLpPOfhqewZ/sebaQYyV838=
X-Received: by 2002:ac8:664b:: with SMTP id j11mr24827222qtp.137.1571666060943;
 Mon, 21 Oct 2019 06:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <CACO55ttOJaXKWmKQQbMAQRJHLXF-VtNn58n4BZhFKYmAdfiJjA@mail.gmail.com>
 <20191016213722.GA72810@google.com> <CACO55tuXck7vqGVLmMBGFg6A2pr3h8koRuvvWHLNDH8XvBVxew@mail.gmail.com>
 <20191021133328.GI2819@lahna.fi.intel.com>
In-Reply-To: <20191021133328.GI2819@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 21 Oct 2019 15:54:09 +0200
Message-ID: <CACO55tujUZr+rKkyrkfN+wkNOJWdNEVhVc-eZ3RCXJD+G1z=7A@mail.gmail.com>
Subject: Re: [PATCH v3] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 21, 2019 at 3:33 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Wed, Oct 16, 2019 at 11:48:22PM +0200, Karol Herbst wrote:
> > On Wed, Oct 16, 2019 at 11:37 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > [+cc linux-acpi]
> > >
> > > On Wed, Oct 16, 2019 at 09:18:32PM +0200, Karol Herbst wrote:
> > > > but setting the PCI_DEV_FLAGS_NO_D3 flag does prevent using the
> > > > platform means of putting the device into D3cold, right? That's
> > > > actually what should still happen, just the D3hot step should be
> > > > skipped.
> > >
> > > If I understand correctly, when we put a device in D3cold on an ACPI
> > > system, we do something like this:
> > >
> > >   pci_set_power_state(D3cold)
> > >     if (PCI_DEV_FLAGS_NO_D3)
> > >       return 0                                   <-- nothing at all if quirked
> > >     pci_raw_set_power_state
> > >       pci_write_config_word(PCI_PM_CTRL, D3hot)  <-- set to D3hot
> > >     __pci_complete_power_transition(D3cold)
> > >       pci_platform_power_transition(D3cold)
> > >         platform_pci_set_power_state(D3cold)
> > >           acpi_pci_set_power_state(D3cold)
> > >             acpi_device_set_power(ACPI_STATE_D3_COLD)
> > >               ...
> > >                 acpi_evaluate_object("_OFF")     <-- set to D3cold
> > >
> > > I did not understand the connection with platform (ACPI) power
> > > management from your patch.  It sounds like you want this entire path
> > > except that you want to skip the PCI_PM_CTRL write?
> > >
> >
> > exactly. I am running with this workaround for a while now and never
> > had any fails with it anymore. The GPU gets turned off correctly and I
> > see the same power savings, just that the GPU can be powered on again.
> >
> > > That seems like something Rafael should weigh in on.  I don't know
> > > why we set the device to D3hot with PCI_PM_CTRL before using the ACPI
> > > methods, and I don't know what the effect of skipping that is.  It
> > > seems a little messy to slice out this tiny piece from the middle, but
> > > maybe it makes sense.
> > >
> >
> > afaik when I was talking with others in the past about it, Windows is
> > doing that before using ACPI calls, but maybe they have some similar
> > workarounds for certain intel bridges as well? I am sure it affects
> > more than the one I am blacklisting here, but I rather want to check
> > each device before blacklisting all kabylake and sky lake bridges (as
> > those are the ones were this issue can be observed).
> >
> > Sadly we had no luck getting any information about such workaround out
> > of Nvidia or Intel.
>
> I really would like to provide you more information about such
> workaround but I'm not aware of any ;-) I have not seen any issues like
> this when D3cold is properly implemented in the platform.  That's why
> I'm bit skeptical that this has anything to do with specific Intel PCIe
> ports. More likely it is some power sequence in the _ON/_OFF() methods
> that is run differently on Windows.

yeah.. maybe. I really don't know what's the actual root cause. I just
know that with this workaround it works perfectly fine on my and some
other systems it was tested on. Do you know who would be best to
approach to get proper documentation about those methods and what are
the actual prerequisites of those methods?

We kind of tried with Nvidia, but maybe having a more specific
question would help here... I will try to bring that issue up the next
time with them.
