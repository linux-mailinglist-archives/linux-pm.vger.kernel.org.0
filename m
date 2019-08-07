Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEAB848D7
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 11:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfHGJsg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 05:48:36 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50927 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfHGJsg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 05:48:36 -0400
Received: from 79.184.254.29.ipv4.supernova.orange.pl (79.184.254.29) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id d7bf4b4fc498339b; Wed, 7 Aug 2019 11:48:33 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Keith Busch <kbusch@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for suspend" has problems
Date:   Wed, 07 Aug 2019 11:48:33 +0200
Message-ID: <2763495.NmdaWeg79L@kreacher>
In-Reply-To: <20190731221956.GB15795@localhost.localdomain>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM> <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com> <20190731221956.GB15795@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, August 1, 2019 12:19:56 AM CEST Keith Busch wrote:
> On Wed, Jul 31, 2019 at 11:25:51PM +0200, Rafael J. Wysocki wrote:
> > 
> > A couple of remarks if you will.
> > 
> > First, we don't know which case is the majority at this point.  For
> > now, there is one example of each, but it may very well turn out that
> > the SK Hynix BC501 above needs to be quirked.
> > 
> > Second, the reference here really is 5.2, so if there are any systems
> > that are not better off with 5.3-rc than they were with 5.2, well, we
> > have not made progress.  However, if there are systems that are worse
> > off with 5.3, that's bad.  In the face of the latest findings the only
> > way to avoid that is to be backwards compatible with 5.2 and that's
> > where my patch is going.  That cannot be achieved by quirking all
> > cases that are reported as "bad", because there still may be
> > unreported ones.
> 
> I have to agree. I think your proposal may allow PCI D3cold, in which
> case we do need to reintroduce the HMB handling.

So I think I know what the problem is here.

If ASPM is disabled for the NVMe device (which is the case on my machine by default),
skipping the bus-level PM in nvme_suspend() causes the PCIe link of it to stay up and
that prevents the SoC from getting into deeper package C-states.

If I change the ASPM policy to "powersave" (through the module parameter in there),
ASPM gets enabled for the NVMe drive and I can get into PC10 via S2Idle with plain 5.3-rc3.

However, that's a bit less than straightforward, so I'm going to post a patch to make
nvme_suspend() fall back to the "old ways" if ASPM is not enabled for the target device.

Cheers!



