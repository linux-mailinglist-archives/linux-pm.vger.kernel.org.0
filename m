Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B941419488
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 23:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfEIVVk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 17:21:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:14670 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfEIVVk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 May 2019 17:21:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 May 2019 14:21:39 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 09 May 2019 14:21:38 -0700
Date:   Thu, 9 May 2019 15:16:09 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Message-ID: <20190509211608.GC9675@localhost.localdomain>
References: <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com>
 <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com>
 <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
 <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
 <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
 <20190509192807.GB9675@localhost.localdomain>
 <CAJZ5v0ivyByegTMzqdvxqRM2kyjcWmg-LktuwpQJETjMCzGJiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ivyByegTMzqdvxqRM2kyjcWmg-LktuwpQJETjMCzGJiw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 09, 2019 at 10:54:04PM +0200, Rafael J. Wysocki wrote:
> On Thu, May 9, 2019 at 9:33 PM Keith Busch <kbusch@kernel.org> wrote:
> >  #include <linux/io-64-nonatomic-lo-hi.h>
> > @@ -2851,6 +2852,8 @@ static int nvme_suspend(struct device *dev)
> >         struct pci_dev *pdev = to_pci_dev(dev);
> >         struct nvme_dev *ndev = pci_get_drvdata(pdev);
> >
> > +       if (!pm_suspend_via_firmware())
> > +               return nvme_set_power(&ndev->ctrl, ndev->ctrl.npss);
> 
> You probably want to call pci_save_state(pdev) in the branch above to
> prevent pci_pm_suspend_noirq() from calling pci_prepare_to_sleep()
> going forward, so I would write this routine as
> 
> if (pm_suspend_via_firmware()) {
>         nvme_dev_disable(ndev, true);
>         return 0;
> }
> 
> pci_save_state(pdev)
> return nvme_set_power(&ndev->ctrl, ndev->ctrl.npss);

Ah, good point. I'll make sure that's added and will wait to see hear if
there's any other feedback.

I am trying to test the paths by faking out PS capabilities, and have
a question on how to force each:

Running "rtcwake -m freeze ...", that takes the !pm_suspend_via_firmware()
path as I expected.

But trying to test the original path, I thought using "-m mem" would
have been a suspend via firmware, but that is still returning false.

Is that expected? I've only tried this on one platform so far, so might
just be this particular one is missing a firmware capability. 
