Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C055E19E97
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 15:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfEJN6E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 09:58:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:18693 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727425AbfEJN6D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 May 2019 09:58:03 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 06:58:03 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 10 May 2019 06:58:02 -0700
Date:   Fri, 10 May 2019 07:52:34 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Message-ID: <20190510135234.GF9675@localhost.localdomain>
References: <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
 <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
 <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
 <20190509192807.GB9675@localhost.localdomain>
 <7a002851c435481593f8629ec9193e40@AUSX13MPC101.AMER.DELL.COM>
 <20190509215409.GD9675@localhost.localdomain>
 <495d76c66aec41a8bfbbf527820f8eb9@AUSX13MPC101.AMER.DELL.COM>
 <BC5EB1D0-8718-48B3-ACAB-F7E5571D821D@canonical.com>
 <CAJZ5v0jAcX-Q2twygKoKvmx2H6tneHWimmH+c2GsYitHK5-knw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jAcX-Q2twygKoKvmx2H6tneHWimmH+c2GsYitHK5-knw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 10, 2019 at 01:23:11AM -0700, Rafael J. Wysocki wrote:
> On Fri, May 10, 2019 at 8:08 AM Kai-Heng Feng
> > I tested the patch from Keith and it has two issues just as simply skipping
> > nvme_dev_disable():
> > 1) It consumes more power in S2I
> > 2) System freeze after resume
> 
> Well, the Keith's patch doesn't prevent pci_pm_suspend_noirq() from
> asking for D3 and both of the symptoms above may be consequences of
> that in principle.

Right, I'll fix up the kernel's PCI D3 control and resend for
consideration.
