Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D1119E91
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 15:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfEJN5K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 09:57:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:52402 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727425AbfEJN5I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 May 2019 09:57:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 06:57:08 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 10 May 2019 06:57:07 -0700
Date:   Fri, 10 May 2019 07:51:39 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Message-ID: <20190510135139.GE9675@localhost.localdomain>
References: <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com>
 <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com>
 <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
 <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
 <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
 <20190509192807.GB9675@localhost.localdomain>
 <20190510053052.GB3654@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510053052.GB3654@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 09, 2019 at 10:30:52PM -0700, Christoph Hellwig wrote:
> Also I don't see any reason why we'd need to do the freeze game on
> resume.  

Right, definitely no reason for resume.

> Even on suspend it looks a little odd to me, as in theory
> the PM core should have already put the system into a quiescent state.
> But maybe we actually need it there, in which case a comment would
> be helpful.

I wasn't sure if suspend prevents a kthread or work queue from
running. For example, if the device sends a namespace notify AEN during
S2I, does the nvme scan_work run?

Since I wasn't sure, I took a paranoid approach to ensure nothing was
in flight, but I'd be happy if this is unnecessary.

> > +     if (!pm_suspend_via_firmware())
> > +             return nvme_set_power(&ndev->ctrl, 0);
> 
> Don't we need to save the previous power state here and restore that?
> For example if someone set a specific state through nvme-cli?

Sure, we can do that. It would have been super if the spec had this
set feature command's CQE DW0 return the previous power state so we
could set the new and save the old in a single command, but two commands
is just a minor inconvenience.
