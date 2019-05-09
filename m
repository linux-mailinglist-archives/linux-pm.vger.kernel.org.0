Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE75E18DFB
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 18:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfEIQ0K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 12:26:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:40864 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfEIQ0K (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 May 2019 12:26:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 May 2019 09:26:10 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 09 May 2019 09:26:09 -0700
Date:   Thu, 9 May 2019 10:20:38 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        "Busch, Keith" <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Message-ID: <20190509162038.GC9548@localhost.localdomain>
References: <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
 <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>
 <20190508195159.GA1530@lst.de>
 <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM>
 <20190509061237.GA15229@lst.de>
 <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com>
 <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com>
 <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 09, 2019 at 03:28:32AM -0700, Kai-Heng Feng wrote:
> at 17:56, Christoph Hellwig <hch@lst.de> wrote:
> > The we have the sequence in your patch.  This seems to be related to
> > some of the MS wording, but I'm not sure what for example tearing down
> > the queues buys us.  Can you explain a bit more where those bits
> > make a difference?
> 
> Based on my testing if queues (IRQ) are not disabled, NVMe controller won’t  
> be quiesced.
> Symptoms can be high power drain or system freeze.
> 
> I can check with vendors whether this also necessary under Windows.

Hm, that doesn't sound right based on the spec's description of how this
feature works. We should not need to tear down IO queues for entering
low power, nor reset the controller to exit it.

The sequence for entering non-operational low power should just be freeze
request queues, set the power feature, then unfreeze request queues.

We shouldn't have to do anything to exit the state as the spec requires
devices autonomously return to operational when an IO doorbell is written.
