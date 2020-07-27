Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FD922EBF1
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 14:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgG0MUL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 08:20:11 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36707 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgG0MUK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 08:20:10 -0400
Received: by mail-oi1-f195.google.com with SMTP id s144so4207085oie.3;
        Mon, 27 Jul 2020 05:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VYdNJKGJtndbhOIlB1kpCwUiNVjH+51o2Mmpgcq8fg8=;
        b=oVmhMJgcuva+Z2pRZEeBuVUBn+M8cuVfC05UMl5+WYQfIbybGD1w+uYg5rl2Rq0AJ+
         OPPP/FW8xohoppIOHqj8UuNeveuBJhjYz2tYuDIOhqsN/cr4ThZUkVWLlCQrZwtwHY6L
         a1NHwB3OULdLcdlsllFYRqUZCUAdHSkRI2pXIuiDdQ+O6UvnM+thVr3xDFdPPxYMIh43
         BbU2qQ7BhofwjZb0/wNgWV7rDVyB31x/504MzjSrAda5srhC34tkMoRKYf/Vwn7MeOFs
         E/1Tvt0x2V2ZqV7nXKO0vtiFlaESWJqt1AcjH7q3CxVFxOBVfNY+uYGHo+RY2BxQhDXp
         Y5YQ==
X-Gm-Message-State: AOAM531qz/ui9ZnDMcZ0mZuFZLa62mGsc9d6JSJcEFeCceIVZZejia6f
        sQLg5bZBnMbDzY4Q7a8nC8i8LCcYHrhlPOWvWTs=
X-Google-Smtp-Source: ABdhPJzESE2uHUqdDkzrQl8akjB+yPlCH6ucxF6MZ8U6NcVwVphYWXUbyfgNtAl73OF/Rb45GhRPevNJ/DK2nyFBJDo=
X-Received: by 2002:a05:6808:34e:: with SMTP id j14mr18551226oie.110.1595852409614;
 Mon, 27 Jul 2020 05:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <1594921495-519-1-git-send-email-sumeet.r.pawnikar@intel.com>
 <CAJZ5v0jQp2sHyzFKZu4ZL2HyN+kVax960+n2epTxBZbbZuZo8Q@mail.gmail.com> <20200727121316.GS3703480@smile.fi.intel.com>
In-Reply-To: <20200727121316.GS3703480@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jul 2020 14:19:41 +0200
Message-ID: <CAJZ5v0iZvGzZU15-bkxaFi3Q=4Sd4h+B0Z9pHPMGzCgMvMDX2g@mail.gmail.com>
Subject: Re: [PATCH v3] powercap: Add Power Limit4 support
To:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 27, 2020 at 2:13 PM Shevchenko, Andriy
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Jul 27, 2020 at 01:46:12PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Jul 16, 2020 at 7:38 PM Sumeet Pawnikar
> > <sumeet.r.pawnikar@intel.com> wrote:
> > >
> > > Modern Intel Mobile platforms support power limit4 (PL4), which is
> > > the SoC package level maximum power limit (in Watts). It can be used
> > > to preemptively limits potential SoC power to prevent power spikes
> > > from tripping the power adapter and battery over-current protection.
> > > This patch enables this feature by exposing package level peak power
> > > capping control to userspace via RAPL sysfs interface. With this,
> > > application like DTPF can modify PL4 power limit, the similar way
> > > of other package power limit (PL1).
> > > As this feature is not tested on previous generations, here it is
> > > enabled only for the platform that has been verified to work,
> > > for safety concerns.
> >
> > Queued up as 5.9 material ->
> >
> > > Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> > > Co-developed-by: Zhang Rui <rui.zhang@intel.com>
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> >
> > -> with this tag removed, because the only case in which you can
> > include an S-o-b from someone else is when you also add a From:
> > pointing to that person.  IOW, you add a From: with a matching S-o-b
> > from someone else and you can add your own S-o-b to that.
> >
> > In this particular case, the C-d-b tag is sufficient to make a record
> > of somebody else's contribution to a patch carrying a From: header
> > that points to you (ie. your patch).
>
> Rafael, it looks like it contradicts documentation. I mean your amendment.
> SoB is specifically required to be coupled with Co-developed-by. That said,
> both or none are acceptable. (I don't consider the chain of SoB when it goes
> thru maintainers)

OK, I stand corrected and so I've added the Rui's S-o-b back to the commit.

Thanks!
