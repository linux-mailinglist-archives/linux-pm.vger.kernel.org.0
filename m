Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A39B11EA88
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 11:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfEOJAN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 05:00:13 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40586 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOJAN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 05:00:13 -0400
Received: by mail-oi1-f193.google.com with SMTP id r136so1255768oie.7;
        Wed, 15 May 2019 02:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lrqj6jKrkXcRwqIiYwyrhsIxd6bZvvZrh2+SSoZ20J0=;
        b=tLbNnFqCG9b+NM2rIAUZ3p401DLBMhEowpQVywyUJuqe1NuU7hLXgyOfLcuIEGNEIY
         haRT3DT1ooSlHyJ3S43fgJAJbNOBMY7tmmobwebz/n9GHyV8fDqi6vZr9sWHFgssBueJ
         Xq1H2T2vGslplMg3CDjxYVo3mJK1zZ7ZZ9FdI9JMY7OeJfiIjOlychV4DiW82shbblQM
         vRCD4uYg8mdgyEzIcvJpkyyRwqidgYmBhGkwP5+OMGFEeYvj1us69HXMO9UuS67eW8AB
         DkIvqWEf7iBkhllkR9Z8yK9rOtQNMpGDSngFbE1K00nvUqzQMYnvGOYmRbLyOSzWoj8J
         9N3w==
X-Gm-Message-State: APjAAAWk4IHf4+IRvt2UFihEeI8lr06/xN5nsRqW+PV0Ygx2M0bmRv+Q
        DnousFCZiId3rYhK5KskGoCW86g7JDevlPNcDR8RcQ==
X-Google-Smtp-Source: APXvYqwHaBsNdrxgMt9H08QfD06eGXj4HaMnSdWMvb9W72y+vEGR3kUnlh0NIou/5pP1CEOGRrXrlsI/Ydn/lftSsq8=
X-Received: by 2002:aca:f4c3:: with SMTP id s186mr5432131oih.68.1557910812335;
 Wed, 15 May 2019 02:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190510212937.11661-1-keith.busch@intel.com> <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143741.GA25500@lst.de> <b12ff66f8c224e4199ff1b90ed6bc393@AUSX13MPC105.AMER.DELL.COM>
 <20190513145522.GA15421@localhost.localdomain> <d69ff7154191492eaa8f55535a7effa5@AUSX13MPC105.AMER.DELL.COM>
 <20190513150458.GA15437@localhost.localdomain> <CAJZ5v0g3cCYK3rAQn09pCr7LMrRr=zQy_ceaEB5AKhVx604YgA@mail.gmail.com>
 <20190514221609.GC19977@localhost.localdomain>
In-Reply-To: <20190514221609.GC19977@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 May 2019 11:00:01 +0200
Message-ID: <CAJZ5v0hrzV+cz+112sfgJ1eNznuf5oLH+kpFwhQb5VA05EAS2g@mail.gmail.com>
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
To:     Keith Busch <kbusch@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 15, 2019 at 12:21 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Tue, May 14, 2019 at 10:04:22AM +0200, Rafael J. Wysocki wrote:
> > On Mon, May 13, 2019 at 5:10 PM Keith Busch <kbusch@kernel.org> wrote:
> > >
> > > On Mon, May 13, 2019 at 03:05:42PM +0000, Mario.Limonciello@dell.com wrote:
> > > > This system power state - suspend to idle is going to freeze threads.
> > > > But we're talking a multi threaded kernel.  Can't there be a timing problem going
> > > > on then too?  With a disk flush being active in one task and the other task trying
> > > > to put the disk into the deepest power state.  If you don't freeze the queues how
> > > > can you guarantee that didn't happen?
> > >
> > > But if an active data flush task is running, then we're not idle and
> > > shouldn't go to low power.
> >
> > To be entirely precise, system suspend prevents user space from
> > running while it is in progress.  It doesn't do that to kernel
> > threads, at least not by default, though, so if there is a kernel
> > thread flushing the data, it needs to be stopped or suspended somehow
> > directly in the system suspend path.  [And yes, system suspend (or
> > hibernation) may take place at any time so long as all user space can
> > be prevented from running then (by means of the tasks freezer).]
> >
> > However, freezing the queues from a driver ->suspend callback doesn't
> > help in general and the reason why is hibernation.  Roughly speaking,
> > hibernation works in two steps, the first of which creates a snapshot
> > image of system memory and the second one writes that image to
> > persistent storage.  Devices are resumed between the two steps in
> > order to make it possible to do the write, but that would unfreeze the
> > queues and let the data flusher run.  If it runs, it may cause the
> > memory snapshot image that has just been created to become outdated
> > and restoring the system memory contents from that image going forward
> > may cause corruption to occur.
> >
> > Thus freezing the queues from a driver ->suspend callback should not
> > be relied on for correctness if the same callback is used for system
> > suspend and hibernation, which is the case here.  If doing that
> > prevents the system from crashing, it is critical to find out why IMO,
> > as that may very well indicate a broader issue, not necessarily in the
> > driver itself.
> >
> > But note that even if the device turns out to behave oddly, it still
> > needs to be handled, unless it may be prevented from shipping to users
> > in that shape.  If it ships, users will face the odd behavior anyway.
>
> Thanks for all the information. I'll take another shot at this, should
> have it posted tomorrow.
>
> It's mostly not a problem to ensure enqueued and dispatched requests are
> completed before returning from our suspend callback. I originally had
> that behavior and backed it out when I thought it wasn't necessary. So
> I'll reintroduce that. I'm not sure yet how we may handle kernel tasks
> that are about to read/write pages, but haven't yet enqueued their
> requests.

That is a hard problem in general.

Currently, there are two ways to prevent a kernel thread from running
across hibernation.  One of them is to freeze it with the help of the
tasks freezer, but that isn't nice.  The second one would be to
register a PM notifier with register_pm_notifier() and then stop the
thread on the PM_HIBERNATION_PREPARE events (and restart it on the
PM_POST_HIBERNATION and PM_POST_RESTORE events).  The drawback here
is, though, that PM_HIBERNATION_PREPARE is signaled before freezing
user space which may produce some deadlock scenarios in principle if
anything in user space may be blocked waiting for the stopped kernel
thread.

It may be necessary to add PM_HIBERNATION/SUSPEND_POSTFREEZE and
_PRETHAW events to the PM notifier for that, which will be signaled
after running the tasks freezer and before unfreezing tasks,
respectively.  Or something else to that effect.

If you need something like that, please let me know and I will prepare
a core patch to add it.
