Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5184B193D9
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 22:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfEIUyR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 16:54:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32876 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfEIUyR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 May 2019 16:54:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id 66so3641690otq.0;
        Thu, 09 May 2019 13:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=60ekcbJtI6yZwQK328DWx4KfVWdYhF9HdCOSd8tn+fc=;
        b=ntelopzQTQrtkSmCCmZCZMD6l5CqgGHbAxhvzNBMvS6Se7xG6G99dDg9dKcUKA+0jW
         BRQ9E3yijsTo6BVzs+VYPMMgyp8zgWsn2KI7diBKOXuKXvK5c4M+MnKnv+bSog/s6VRg
         HaTCWtqls2JZz1J5bfmL0kHb9hQP/700HzZGhLQ+7NnzTPVBlI6fDfe++On9PZDu4N8N
         qLk1Ss07An/fm7in+zkCOJbxldQFOZGEm3YpgDwMK8c2D19Ov/0/yLoZ1OnfX5dDkigN
         q7cNncFMigEVVEu0lbrbGfYDxvPvwBSpcuUye/jg8IU0KJ20XVzfYvr+2W1SgufH3/xc
         5apQ==
X-Gm-Message-State: APjAAAWR9YnQYsRUM+EbiwTZZ2vsw+FRY7luU58Svjl6ai9pedopMDFJ
        X+Chj5ZcwNGmzr8AhfarqtZD4AzXEfWqN4D9Yi+VVAWT
X-Google-Smtp-Source: APXvYqxd9HcbPWkz6t/Wpszcx4IS7BBEVuQ1Dmtlk6ndVnBj5wsJIJBWBYXfRyX1i+OvDo1jfPVbVdUN317opZrbVcA=
X-Received: by 2002:a9d:4c86:: with SMTP id m6mr4219435otf.168.1557435256055;
 Thu, 09 May 2019 13:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM>
 <20190509061237.GA15229@lst.de> <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com>
 <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com> <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com> <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com> <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
 <20190509192807.GB9675@localhost.localdomain>
In-Reply-To: <20190509192807.GB9675@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 May 2019 22:54:04 +0200
Message-ID: <CAJZ5v0ivyByegTMzqdvxqRM2kyjcWmg-LktuwpQJETjMCzGJiw@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
To:     Keith Busch <kbusch@kernel.org>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Thu, May 9, 2019 at 9:33 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, May 09, 2019 at 06:57:34PM +0000, Mario.Limonciello@dell.com wrote:
> > No, current Windows versions don't transition to D3 with inbox NVME driver.
> > You're correct, it's explicit state transitions even if APST was enabled
> > (as this patch is currently doing as well).
>
> The proposed patch does too much, and your resume latency will be worse
> off for doing an unnecessary controller reset.
>
> The following should be all that's needed if the device is spec
> compliant. The resume part isn't necessary if npss is non-operational, but
> we're not saving that info, and it shouldn't hurt to be explicit anyway.
>
> I don't have any PS capable devices, so this is just compile tested.
>
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 6265d9225ec8..ce8b9bc949b9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1132,6 +1132,22 @@ static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword
>         return ret;
>  }
>
> +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned npss)
> +{
> +       int ret;
> +
> +       mutex_lock(&ctrl->scan_lock);
> +       nvme_start_freeze(ctrl);
> +       nvme_wait_freeze(ctrl);
> +       ret = nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, npss, NULL, 0,
> +                               NULL);
> +       nvme_unfreeze(ctrl);
> +       mutex_unlock(&ctrl->scan_lock);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(nvme_set_power);
> +
>  int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
>  {
>         u32 q_count = (*count - 1) | ((*count - 1) << 16);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 527d64545023..f2be6aad9804 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -459,6 +459,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>                 unsigned timeout, int qid, int at_head,
>                 blk_mq_req_flags_t flags, bool poll);
>  int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
> +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned npss);
>  void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
>  int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
>  int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a90cf5d63aac..2c4154cb4e79 100644
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
> @@ -2851,6 +2852,8 @@ static int nvme_suspend(struct device *dev)
>         struct pci_dev *pdev = to_pci_dev(dev);
>         struct nvme_dev *ndev = pci_get_drvdata(pdev);
>
> +       if (!pm_suspend_via_firmware())
> +               return nvme_set_power(&ndev->ctrl, ndev->ctrl.npss);

You probably want to call pci_save_state(pdev) in the branch above to
prevent pci_pm_suspend_noirq() from calling pci_prepare_to_sleep()
going forward, so I would write this routine as

if (pm_suspend_via_firmware()) {
        nvme_dev_disable(ndev, true);
        return 0;
}

pci_save_state(pdev)
return nvme_set_power(&ndev->ctrl, ndev->ctrl.npss);

>         nvme_dev_disable(ndev, true);
>         return 0;
>  }
> @@ -2860,6 +2863,8 @@ static int nvme_resume(struct device *dev)
>         struct pci_dev *pdev = to_pci_dev(dev);
>         struct nvme_dev *ndev = pci_get_drvdata(pdev);
>
> +       if (!pm_suspend_via_firmware())
> +               return nvme_set_power(&ndev->ctrl, 0);
>         nvme_reset_ctrl(&ndev->ctrl);
>         return 0;
>  }

The rest of the patch LGTM.
