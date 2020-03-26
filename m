Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15352193B35
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 09:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgCZIjw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 04:39:52 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34513 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgCZIjw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 04:39:52 -0400
Received: by mail-oi1-f196.google.com with SMTP id d3so215719oic.1;
        Thu, 26 Mar 2020 01:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRX7PLl1mEjB6H0fmMXyLD2J+FG3OvK9KawnS67f2j8=;
        b=N1V1c2BsEqE7WYM3otZ/2it1bHYCJx2zxNtIMek1oeYGeSbL3BXxtPiPMjp2ec3Ya1
         bim+QIZn8+JbEAJ+P5duvJEWGsDApXxZkwYdPQuJ9nPL2WPiCfbbD47yBKnz55la9nj6
         tuRUdNaIoZ/BM/x20E9NaAE0188Qr/J/esNxAtT4EPc/V/IqIbBfWLq+U6++HD60EPIE
         3UyeccSSgHn3FH1eRJIRH+J9cckzXjKrvYWYqWH64BgRhipOco51EyEwKBI9cv9jwGrP
         b0egJgwiKhcGaPklDn4oYZo9LTEghY55IHTGSIEkEcQYWbCAkLxuHM+TdAh0qTpnw0ap
         6u6A==
X-Gm-Message-State: ANhLgQ25nwdBWQ8RjzeDgf8nIOeVe7MxOhrnnc2IbyYzdVKu/yZoBg/Y
        eeuP/b6guGdixCb763ctgl6yF9lCwkM6dXH0VmQ=
X-Google-Smtp-Source: ADFU+vsFeJkfPdBQXQpadxQd3zK1Np02OpHncJ5FVmppX4AHFdLoVJeQj3CcEqmMCkuJRnVthKUJM1QSY979jFx3uew=
X-Received: by 2002:aca:5155:: with SMTP id f82mr1082932oib.103.1585211991269;
 Thu, 26 Mar 2020 01:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
 <20200325032901.29551-1-saravanak@google.com> <20200325125120.GX1922688@smile.fi.intel.com>
 <CAGETcx_TGw24UqX7pXZePyskrao6zwnKTq8mBk9g_7jokqAqkA@mail.gmail.com>
In-Reply-To: <CAGETcx_TGw24UqX7pXZePyskrao6zwnKTq8mBk9g_7jokqAqkA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Mar 2020 09:39:40 +0100
Message-ID: <CAJZ5v0jB1hqzYK8ezjf1_1yMCudNXNS-CsrUJQcmL4W5mBD6fQ@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
To:     Saravana Kannan <saravanak@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mark Brown <broonie@kernel.org>, Ferry Toth <fntoth@gmail.com>,
        grant.likely@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 25, 2020 at 11:09 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Mar 25, 2020 at 5:51 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >

[cut]

> >
> > Yes, it's (unlikely) possible (*), but it will give one more iteration per such
> > case. It's definitely better than infinite loop. Do you agree?
>
> Sorry I wasn't being clear (I was in a rush). I'm saying this patch
> can reintroduce the bug where the deferred probe isn't triggered when
> it should be.
>
> Let's take a simple execution flow.
>
> probe_okay is at 10.
>
> Thread-A
>   really_probe(Device-A)
>     local_probe_okay_count = 10
>     Device-A probe function is running...
>
> Thread-B
>   really_probe(Device-B)
>     Device-B probes successfully.
>     probe_okay incremented to 11
>
> Thread-C
>   Device-C (which had bound earlier) is unbound (say module is
> unloaded or a million other reasons).
>   probe_okay is decremented to 10.
>
> Thread-A continues
>   Device-A probe function returns -EPROBE_DEFER
>   driver_deferred_probe_add_trigger() doesn't do anything because
>     local_probe_okay_count == probe_okay
>   But Device-A might have deferred probe waiting on Device-B.
>   Device-A never probes.
>
> > *) It means during probe you have _intensive_ removing, of course you may keep
> > kernel busy with iterations, but it has no practical sense. DoS attacks more
> > effective in different ways.
>
> I wasn't worried about DoS attacks. More of a functional correctness
> issue what I explained above.

The code is functionally incorrect as is already AFAICS.

> Anyway, if your issue and similar issues can be handles in driver core
> in a clean way without breaking other cases, I don't have any problem
> with that. Just that, I think the current solution breaks other cases.

OK, so the situation right now is that commit 58b116bce136 has
introduced a regression and so it needs to be fixed or reverted.  The
cases that were previously broken and were unbroken by that commit
don't matter here, so you cannot argue that they would be "broken".

It looks to me like the original issue fixed by the commit in question
needs to be addressed differently, so I would vote for reverting it
and starting over.

> As an alternate solution, assuming "linux,extcon-name" is coming
> from some firmware, you might want to look into the fw_devlink
> feature.

That would be a workaround for a driver core issue, though, wouldn't it?

> That feature allows driver core to add device links from firmware
> information. If you can get that feature to create device links from
> your dwc3.0.auto (or its parent pci_dev?) to the extcon supplier
> device, all of this can be sidestepped and your dwc3.0.auto's (or the
> dwc pci_dev's) probe will be triggered only after extcon is probed.
>
> I have very little familiarity with PCI/ACPI. I spent about an hour or
> two poking at ACPI scan/property code. The relationship between a
> pci_dev and an acpi_device is a bit confusing to me because I see:
>
> static int dwc3_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
> {
>         struct property_entry *p = (struct property_entry *)id->driver_data;
>         struct dwc3_pci         *dwc;
>         struct resource         res[2];
>         int                     ret;
>         struct device           *dev = &pci->dev;
> ....
>         dwc->dwc3 = platform_device_alloc("dwc3", PLATFORM_DEVID_AUTO);
> ....
>         ACPI_COMPANION_SET(&dwc->dwc3->dev, ACPI_COMPANION(dev));
>
> And ACPI_COMPANION returns an acpi_device by looking at dev->fwnode.
> So how the heck is a pci_device.dev.fwnode pointing to an
> acpi_device.fwnode?

acpi_device is an of_node counterpart (or it is an fwnode itself if you will).

Thanks!
