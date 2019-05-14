Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD4BA1C456
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2019 10:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfENIEg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 May 2019 04:04:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46342 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfENIEf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 May 2019 04:04:35 -0400
Received: by mail-ot1-f68.google.com with SMTP id j49so6720805otc.13;
        Tue, 14 May 2019 01:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kB17CNIkNudo9lQqUE06/YkvGevRbJzz0AoPJPb6ktc=;
        b=Z+HjzeLhr0Dqle03P0O/1srlROaWqziSFK4q78z4SOkQaRR1v5+3EiYgyR7pxtafXm
         WK2tdbr1ofhyHluvIPiN6bByHsuVFwA0iL+xSjp/ZEPVls6HBbndwscET8eYWwDeFTUj
         TlCGUk6Y0P51eW6yYTPe4oBjHaQ33pghQ88z0kHIKS2m05++SCVmj6O3VfqQGaWCJGxY
         fUv6btXYZmQi1Mt225fkX0QwDqdWMdI13AA2uhr9SvVJ+VWghqyTS5O66HN+IM/npiO1
         6GH3EsXNAOnz9ux59nxIZwm7GrvzT0gPJoHY7+J4L7d8wTU8YRqPuMBfyzzGFBbx0DGb
         XvlQ==
X-Gm-Message-State: APjAAAXhj1w/ku1PCqdgvzVN/D8YI19rrKKbLZJFdJBiy5s2kYcy2MFt
        SLvnBMAecax2k9PM0uSCtax3Pqii+gxN/zjUinE=
X-Google-Smtp-Source: APXvYqxWif0G6pQHhcU4KlJ5vC6KPXRlOORPDLaMZI5cz8NUcPo2oZliCB12ipxHoYjnRvcTjRrFXRhyFfoFmxezLIc=
X-Received: by 2002:a9d:5912:: with SMTP id t18mr14859091oth.252.1557821074817;
 Tue, 14 May 2019 01:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190510212937.11661-1-keith.busch@intel.com> <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143741.GA25500@lst.de> <b12ff66f8c224e4199ff1b90ed6bc393@AUSX13MPC105.AMER.DELL.COM>
 <20190513145522.GA15421@localhost.localdomain> <d69ff7154191492eaa8f55535a7effa5@AUSX13MPC105.AMER.DELL.COM>
 <20190513150458.GA15437@localhost.localdomain>
In-Reply-To: <20190513150458.GA15437@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 May 2019 10:04:22 +0200
Message-ID: <CAJZ5v0g3cCYK3rAQn09pCr7LMrRr=zQy_ceaEB5AKhVx604YgA@mail.gmail.com>
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
To:     Keith Busch <kbusch@kernel.org>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 13, 2019 at 5:10 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Mon, May 13, 2019 at 03:05:42PM +0000, Mario.Limonciello@dell.com wrote:
> > This system power state - suspend to idle is going to freeze threads.
> > But we're talking a multi threaded kernel.  Can't there be a timing problem going
> > on then too?  With a disk flush being active in one task and the other task trying
> > to put the disk into the deepest power state.  If you don't freeze the queues how
> > can you guarantee that didn't happen?
>
> But if an active data flush task is running, then we're not idle and
> shouldn't go to low power.

To be entirely precise, system suspend prevents user space from
running while it is in progress.  It doesn't do that to kernel
threads, at least not by default, though, so if there is a kernel
thread flushing the data, it needs to be stopped or suspended somehow
directly in the system suspend path.  [And yes, system suspend (or
hibernation) may take place at any time so long as all user space can
be prevented from running then (by means of the tasks freezer).]

However, freezing the queues from a driver ->suspend callback doesn't
help in general and the reason why is hibernation.  Roughly speaking,
hibernation works in two steps, the first of which creates a snapshot
image of system memory and the second one writes that image to
persistent storage.  Devices are resumed between the two steps in
order to make it possible to do the write, but that would unfreeze the
queues and let the data flusher run.  If it runs, it may cause the
memory snapshot image that has just been created to become outdated
and restoring the system memory contents from that image going forward
may cause corruption to occur.

Thus freezing the queues from a driver ->suspend callback should not
be relied on for correctness if the same callback is used for system
suspend and hibernation, which is the case here.  If doing that
prevents the system from crashing, it is critical to find out why IMO,
as that may very well indicate a broader issue, not necessarily in the
driver itself.

But note that even if the device turns out to behave oddly, it still
needs to be handled, unless it may be prevented from shipping to users
in that shape.  If it ships, users will face the odd behavior anyway.
