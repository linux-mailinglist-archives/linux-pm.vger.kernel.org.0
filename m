Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1B31A061
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 17:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfEJPm1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 11:42:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:52870 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbfEJPm1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 May 2019 11:42:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 08:42:25 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 10 May 2019 08:42:26 -0700
Date:   Fri, 10 May 2019 09:36:58 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Message-ID: <20190510153658.GI9675@localhost.localdomain>
References: <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
 <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
 <20190509192807.GB9675@localhost.localdomain>
 <7a002851c435481593f8629ec9193e40@AUSX13MPC101.AMER.DELL.COM>
 <20190509215409.GD9675@localhost.localdomain>
 <495d76c66aec41a8bfbbf527820f8eb9@AUSX13MPC101.AMER.DELL.COM>
 <BC5EB1D0-8718-48B3-ACAB-F7E5571D821D@canonical.com>
 <CAJZ5v0jAcX-Q2twygKoKvmx2H6tneHWimmH+c2GsYitHK5-knw@mail.gmail.com>
 <54E4999C-DBE8-4FC1-8E82-17FEDFDA9CA6@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54E4999C-DBE8-4FC1-8E82-17FEDFDA9CA6@canonical.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 10, 2019 at 11:15:05PM +0800, Kai Heng Feng wrote:
> Sorry, I should mention that I use a slightly modified drivers/nvme/host/pci.c:
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3e4fb891a95a..ece428ce6876 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -18,6 +18,7 @@
>  #include <linux/mutex.h>
>  #include <linux/once.h>
>  #include <linux/pci.h>
> +#include <linux/suspend.h>
>  #include <linux/t10-pi.h>
>  #include <linux/types.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> @@ -2833,6 +2834,11 @@ static int nvme_suspend(struct device *dev)
>         struct pci_dev *pdev = to_pci_dev(dev);
>         struct nvme_dev *ndev = pci_get_drvdata(pdev);
>  
> +       if (!pm_suspend_via_firmware()) {
> +               nvme_set_power(&ndev->ctrl, ndev->ctrl.npss);
> +               pci_save_state(pdev);
> +       }
> +
>         nvme_dev_disable(ndev, true);

This won't work because you're falling through to nvme_dev_disable after
setting the power, so the resume side would certainly fail.

This is what you'd want:

       if (!pm_suspend_via_firmware()) {
               pci_save_state(pdev);
               return nvme_set_power(&ndev->ctrl, ndev->ctrl.npss);
       }

>         return 0;
>  }
> @@ -2842,6 +2848,10 @@ static int nvme_resume(struct device *dev)
>         struct pci_dev *pdev = to_pci_dev(dev);
>         struct nvme_dev *ndev = pci_get_drvdata(pdev);
>  
> +       if (!pm_resume_via_firmware()) {
> +               return nvme_set_power(&ndev->ctrl, 0);
> +       }
> +
>         nvme_reset_ctrl(&ndev->ctrl);
>         return 0;
> }
> 
> Does pci_save_state() here enough to prevent the device enter to D3?

Yes, saving the state during suspend will prevent pci pm from assuming
control over this device's power. It's a bit non-intuitive as Christoph
mentioned, so we'll need to make that clear in the comments. For
reference, here's the relevant part in pci-driver.c:

---
static int pci_pm_suspend_noirq(struct device *dev)
{
...

	if (!pci_dev->state_saved) {
		pci_save_state(pci_dev);
		if (pci_power_manageable(pci_dev))
			pci_prepare_to_sleep(pci_dev);
	}
...
}
--

So by saving the state in our suspend callback, pci will skip
pci_prepare_to_sleep(), which is what's setting your device most likely
to a D3hot, undermining our nvme power state setting.
