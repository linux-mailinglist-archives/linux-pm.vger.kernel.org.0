Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1E017AB46
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 16:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbfG3OoU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 10:44:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:32265 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbfG3OoT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Jul 2019 10:44:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 07:44:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,327,1559545200"; 
   d="scan'208";a="195815593"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jul 2019 07:44:18 -0700
Date:   Tue, 30 Jul 2019 08:41:35 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Busch, Keith" <keith.busch@intel.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
Message-ID: <20190730144134.GA12844@localhost.localdomain>
References: <2332799.izEFUvJP67@kreacher>
 <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
 <47415939.KV5G6iaeJG@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47415939.KV5G6iaeJG@kreacher>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 30, 2019 at 03:45:31AM -0700, Rafael J. Wysocki wrote:
> So I can reproduce this problem with plain 5.3-rc1 and the patch below fixes it.
> 
> Also Mario reports that the same patch needs to be applied for his 9380 to reach
> SLP_S0 after some additional changes under testing/review now, so here it goes.
> 
> [The changes mentioned above are in the pm-s2idle-testing branch in the
>  linux-pm.git tree at kernel.org.]
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] nvme-pci: Do not prevent PCI bus-level PM from being used
> 
> One of the modifications made by commit d916b1be94b6 ("nvme-pci: use
> host managed power state for suspend") was adding a pci_save_state()
> call to nvme_suspend() in order to prevent the PCI bus-level PM from
> being applied to the suspended NVMe devices, but that causes the NVMe
> drive (PC401 NVMe SK hynix 256GB) in my Dell XPS13 9380 to prevent
> the SoC from reaching package idle states deeper than PC3, which is
> way insufficient for system suspend.
> 
> Fix this issue by removing the pci_save_state() call in question.

I'm okay with the patch if we can get confirmation this doesn't break
any previously tested devices. I recall we add the pci_save_state() in
the first place specifically to prevent PCI D3 since that was reported
to break some devices' low power settings. Kai-Heng or Mario, any input
here?


 
> Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/nvme/host/pci.c |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/nvme/host/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/nvme/host/pci.c
> +++ linux-pm/drivers/nvme/host/pci.c
> @@ -2897,14 +2897,8 @@ static int nvme_suspend(struct device *d
>  		nvme_dev_disable(ndev, true);
>  		ctrl->npss = 0;
>  		ret = 0;
> -		goto unfreeze;
>  	}
> -	/*
> -	 * A saved state prevents pci pm from generically controlling the
> -	 * device's power. If we're using protocol specific settings, we don't
> -	 * want pci interfering.
> -	 */
> -	pci_save_state(pdev);
> +
>  unfreeze:
>  	nvme_unfreeze(ctrl);
>  	return ret;
