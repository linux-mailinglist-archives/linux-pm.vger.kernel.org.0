Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB2B8194C6
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 23:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfEIVkD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 17:40:03 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42511 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfEIVkC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 May 2019 17:40:02 -0400
Received: by mail-oi1-f195.google.com with SMTP id k9so3056636oig.9;
        Thu, 09 May 2019 14:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWqUG/1Q13/Mgi8WYJUSOwOl7Nvw/G1FqiVogS2PJUU=;
        b=LFEtzodD7pm6u/S9cgqcjmWu4IoOF6tDGg734x3h8Bjq2RKSs1UyB4/A7aOwPLdsOr
         dmKEvg1Lf0ZNIc8c3u/fY4BOOLV73SzUI0b4zTLa7Vk1Dvzoe0aLURF/ze+Zl+nnHSqb
         oODTpv2m2GCYYGV4VNsyI/QlHnfG6lfvPs4JgHTMUYAPOYOPtkcxtQw9kJQW90Di+I1g
         wXxmQJ9x0SwsTJmGzN6KbU3L6XeHfeSTEbMJPo21GqGpeCPAzU9lAhZtKkvgXh3igcDn
         cREPrbSVm8tzblININGRky6LHTWSFSm8xqZwVjXGkXXD4bJkmNV/nvKBQvW9hqo0IGuk
         LXcA==
X-Gm-Message-State: APjAAAV3yms4BoeIbdDO2UysgYJLcc9s3mG+OFWzVjXPSKXwzVm19NRM
        fz8yTKEpOrb/sl9N4DhZZFfT7TikHl/CcDa6ovw=
X-Google-Smtp-Source: APXvYqyKl5SlkcDFgO5vnRTd1pL4AcZ5QulP6DrlxtnNmeZsn1LLArtlg5CH58bHUEjFNoX4LuDOC98A5i+IaWekgTQ=
X-Received: by 2002:aca:f4c3:: with SMTP id s186mr2791143oih.68.1557438002008;
 Thu, 09 May 2019 14:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com>
 <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com> <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com> <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com> <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
 <20190509192807.GB9675@localhost.localdomain> <CAJZ5v0ivyByegTMzqdvxqRM2kyjcWmg-LktuwpQJETjMCzGJiw@mail.gmail.com>
 <20190509211608.GC9675@localhost.localdomain>
In-Reply-To: <20190509211608.GC9675@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 May 2019 23:39:50 +0200
Message-ID: <CAJZ5v0geQV2Z4SdnisPKgEKJY0kypjgd9bRmwaYvf2pp0Rw4dg@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
To:     Keith Busch <kbusch@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 9, 2019 at 11:21 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, May 09, 2019 at 10:54:04PM +0200, Rafael J. Wysocki wrote:
> > On Thu, May 9, 2019 at 9:33 PM Keith Busch <kbusch@kernel.org> wrote:
> > >  #include <linux/io-64-nonatomic-lo-hi.h>
> > > @@ -2851,6 +2852,8 @@ static int nvme_suspend(struct device *dev)
> > >         struct pci_dev *pdev = to_pci_dev(dev);
> > >         struct nvme_dev *ndev = pci_get_drvdata(pdev);
> > >
> > > +       if (!pm_suspend_via_firmware())
> > > +               return nvme_set_power(&ndev->ctrl, ndev->ctrl.npss);
> >
> > You probably want to call pci_save_state(pdev) in the branch above to
> > prevent pci_pm_suspend_noirq() from calling pci_prepare_to_sleep()
> > going forward, so I would write this routine as
> >
> > if (pm_suspend_via_firmware()) {
> >         nvme_dev_disable(ndev, true);
> >         return 0;
> > }
> >
> > pci_save_state(pdev)
> > return nvme_set_power(&ndev->ctrl, ndev->ctrl.npss);
>
> Ah, good point. I'll make sure that's added and will wait to see hear if
> there's any other feedback.
>
> I am trying to test the paths by faking out PS capabilities, and have
> a question on how to force each:
>
> Running "rtcwake -m freeze ...", that takes the !pm_suspend_via_firmware()
> path as I expected.
>
> But trying to test the original path, I thought using "-m mem" would
> have been a suspend via firmware, but that is still returning false.
>
> Is that expected?

Yes, if s2idle is the default on that platform.  You should be able to
switch over to S3 by writing "deep" into /sys/power/mem_sleep as long
as it is supported on that platform at all.

> I've only tried this on one platform so far, so might
> just be this particular one is missing a firmware capability.

You can check that by looking into /sys/power/mem_sleep (if there is
only "[s2idle]" in there, S3 is not supported).
