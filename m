Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAB9C1946BD
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 19:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCZSqG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 14:46:06 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36420 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgCZSqG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 14:46:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id l23so7042486otf.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2020 11:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSaPi1qX32z4R5hBNdjTSka9jPbPxfHe58KpVQ2pneg=;
        b=BYXAsHe9fDFiKQbkaEpYLrNdYpxCE2v5G6VFQHxCpBGHPCnN03bKIX0cr1VCAEu9Rg
         0u0HgwpXi3GMGR9xw+I0FW42IlN/vuGOf9rb7J7W1mod/M2cK7tigZBbXm1OrZVZ5nF5
         /ch76GZA+uxnx8Lv/5fIAE2nNlMg51xb2mLdTQV6oCrQ3rjG/1emnwYN5Ds+69xK8u6s
         0ZQsdzsKiK7YSCcC0K9lvBJW742xWWN0ONeh5y/5Sfjg8CpsPRwf27PTuXTfV5HFD+34
         l3TsxMQNM64kOstFhVSyTwfwxVG4Ux2OvdfP4KjKmtzL/f7ykX3qIRwtmt/hL+HXMQQM
         EdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSaPi1qX32z4R5hBNdjTSka9jPbPxfHe58KpVQ2pneg=;
        b=IVxfvZkDw+CR/AqE+xtJdvc3QAXwr7sVN2qeWrgcvGJ2IW94/g0dXoAWReX+3HmKmH
         rORwnRw1qgUaR1o5YLAxOUJkp4FhxQB2Mz0i/2JQhZTVM47kziSk2LEs2/BpNgK2n60T
         Wnllzgv/IhBDbe+6kDG8Jb+vUphoS7GBWmxLyFI4sF+4Xe6lL+PdYUaP+UvGX6zHaKam
         MIv6Up1t/iPILLs93lSshQYZZb08WgMMBAQXM7zPMU2+u2OfsJYxAg+cYW2O7O+iXYUr
         lr8duxe5SWDt9VzFnaAU6X6ejmhXOlhfJyc62kvTTLisFmIquvMNf+GPgqkYL9FhVgDM
         80Mg==
X-Gm-Message-State: ANhLgQ0fZ3o6ivHQ5L74p9Yxko6p0TrL4pWCnrP7MagL8VBsxuHSIGjB
        ocjdUZhtJFOMXzDGnGmj1wFWlGnvmJA9uKXFZ/Ukqw==
X-Google-Smtp-Source: ADFU+vtzg+a7ZQexHtE4pMNO2X9rdMsKebqldlLPwKcI7thZoZW5JdSClsEyMSIJZH29yvaoRdaCI/72/CgZLGRMZrE=
X-Received: by 2002:a9d:42f:: with SMTP id 44mr7376213otc.236.1585248364557;
 Thu, 26 Mar 2020 11:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
 <20200325032901.29551-1-saravanak@google.com> <20200325125120.GX1922688@smile.fi.intel.com>
 <CAGETcx_TGw24UqX7pXZePyskrao6zwnKTq8mBk9g_7jokqAqkA@mail.gmail.com> <CAJZ5v0jB1hqzYK8ezjf1_1yMCudNXNS-CsrUJQcmL4W5mBD6fQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jB1hqzYK8ezjf1_1yMCudNXNS-CsrUJQcmL4W5mBD6fQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 26 Mar 2020 11:45:28 -0700
Message-ID: <CAGETcx8kqBsqMLm4gqY83dd0mSxucVbk7VWGXu4dKqya9nsbsg@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
To:     "Rafael J. Wysocki" <rafael@kernel.org>
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
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 26, 2020 at 1:39 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Mar 25, 2020 at 11:09 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Wed, Mar 25, 2020 at 5:51 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
>
> [cut]
>
> > >
> > > Yes, it's (unlikely) possible (*), but it will give one more iteration per such
> > > case. It's definitely better than infinite loop. Do you agree?
> >
> > Sorry I wasn't being clear (I was in a rush). I'm saying this patch
> > can reintroduce the bug where the deferred probe isn't triggered when
> > it should be.
> >
> > Let's take a simple execution flow.
> >
> > probe_okay is at 10.
> >
> > Thread-A
> >   really_probe(Device-A)
> >     local_probe_okay_count = 10
> >     Device-A probe function is running...
> >
> > Thread-B
> >   really_probe(Device-B)
> >     Device-B probes successfully.
> >     probe_okay incremented to 11
> >
> > Thread-C
> >   Device-C (which had bound earlier) is unbound (say module is
> > unloaded or a million other reasons).
> >   probe_okay is decremented to 10.
> >
> > Thread-A continues
> >   Device-A probe function returns -EPROBE_DEFER
> >   driver_deferred_probe_add_trigger() doesn't do anything because
> >     local_probe_okay_count == probe_okay
> >   But Device-A might have deferred probe waiting on Device-B.
> >   Device-A never probes.
> >
> > > *) It means during probe you have _intensive_ removing, of course you may keep
> > > kernel busy with iterations, but it has no practical sense. DoS attacks more
> > > effective in different ways.
> >
> > I wasn't worried about DoS attacks. More of a functional correctness
> > issue what I explained above.
>
> The code is functionally incorrect as is already AFAICS.
>
> > Anyway, if your issue and similar issues can be handles in driver core
> > in a clean way without breaking other cases, I don't have any problem
> > with that. Just that, I think the current solution breaks other cases.
>
> OK, so the situation right now is that commit 58b116bce136 has
> introduced a regression and so it needs to be fixed or reverted.  The
> cases that were previously broken and were unbroken by that commit
> don't matter here, so you cannot argue that they would be "broken".
>
> It looks to me like the original issue fixed by the commit in question
> needs to be addressed differently, so I would vote for reverting it
> and starting over.

I'm fine with whatever approach. My only point is that code that's
been there for 5+ years might be preventing that race in a multitude
of platforms. So I'm just reviewing to make sure fixes aren't
introducing regressions. I'm all for anyone cleaning up/redoing
deferred probe.

> > As an alternate solution, assuming "linux,extcon-name" is coming
> > from some firmware, you might want to look into the fw_devlink
> > feature.
>
> That would be a workaround for a driver core issue, though, wouldn't it?

I'm not saying don't fix it in the driver core if it can be done
without adding regressions.

> > That feature allows driver core to add device links from firmware
> > information. If you can get that feature to create device links from
> > your dwc3.0.auto (or its parent pci_dev?) to the extcon supplier
> > device, all of this can be sidestepped and your dwc3.0.auto's (or the
> > dwc pci_dev's) probe will be triggered only after extcon is probed.
> >
> > I have very little familiarity with PCI/ACPI. I spent about an hour or
> > two poking at ACPI scan/property code. The relationship between a
> > pci_dev and an acpi_device is a bit confusing to me because I see:
> >
> > static int dwc3_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
> > {
> >         struct property_entry *p = (struct property_entry *)id->driver_data;
> >         struct dwc3_pci         *dwc;
> >         struct resource         res[2];
> >         int                     ret;
> >         struct device           *dev = &pci->dev;
> > ....
> >         dwc->dwc3 = platform_device_alloc("dwc3", PLATFORM_DEVID_AUTO);
> > ....
> >         ACPI_COMPANION_SET(&dwc->dwc3->dev, ACPI_COMPANION(dev));
> >
> > And ACPI_COMPANION returns an acpi_device by looking at dev->fwnode.
> > So how the heck is a pci_device.dev.fwnode pointing to an
> > acpi_device.fwnode?
>
> acpi_device is an of_node counterpart (or it is an fwnode itself if you will).

If I understand correctly, you are saying it's similar to struct
device_node for OF -- as in, a data struct that stores the unpacked
ACPI firmware data. That helps me understand what is going on with
ACPI_COMPANION_SET() in the PCI driver.

But then, why does it have a "struct device dev" field embedded in it?
Does the acpi_device.dev ever get registered with driver core?

Thanks,
Saravana
