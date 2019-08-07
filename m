Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF66384A0B
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 12:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfHGKpD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 06:45:03 -0400
Received: from verein.lst.de ([213.95.11.211]:36491 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfHGKpD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Aug 2019 06:45:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C62AB68AFE; Wed,  7 Aug 2019 12:45:00 +0200 (CEST)
Date:   Wed, 7 Aug 2019 12:45:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Keith Busch <kbusch@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state
 for suspend" has problems
Message-ID: <20190807104500.GB11356@lst.de>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM> <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com> <20190731221956.GB15795@localhost.localdomain> <2763495.NmdaWeg79L@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2763495.NmdaWeg79L@kreacher>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 07, 2019 at 11:48:33AM +0200, Rafael J. Wysocki wrote:
> So I think I know what the problem is here.
> 
> If ASPM is disabled for the NVMe device (which is the case on my machine by default),
> skipping the bus-level PM in nvme_suspend() causes the PCIe link of it to stay up and
> that prevents the SoC from getting into deeper package C-states.
> 
> If I change the ASPM policy to "powersave" (through the module parameter in there),
> ASPM gets enabled for the NVMe drive and I can get into PC10 via S2Idle with plain 5.3-rc3.
> 
> However, that's a bit less than straightforward, so I'm going to post a patch to make
> nvme_suspend() fall back to the "old ways" if ASPM is not enabled for the target device.

Sounds sensibel.

FYI your mail is not properly formatted and has way too long lines.
