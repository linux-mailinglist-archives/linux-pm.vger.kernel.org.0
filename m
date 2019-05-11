Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89C7E1A70E
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2019 09:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfEKHXU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 May 2019 03:23:20 -0400
Received: from verein.lst.de ([213.95.11.211]:56604 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbfEKHXU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 11 May 2019 03:23:20 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2FA1068AFE; Sat, 11 May 2019 09:22:59 +0200 (CEST)
Date:   Sat, 11 May 2019 09:22:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Rafael Wysocki <rafael@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Message-ID: <20190511072258.GB14764@lst.de>
References: <20190510212937.11661-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510212937.11661-1-keith.busch@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A couple nitpicks, mostly leftover from the previous iteration
(I didn't see replies to those comments from you, despite seeing
a reply to my mail, assuming it didn't get lost):

> +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned ps)
> +{
> +	return nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, ps, NULL, 0, NULL);
> +}
> +EXPORT_SYMBOL_GPL(nvme_set_power);
> +
> +int nvme_get_power(struct nvme_ctrl *ctrl, u32 *result)
> +{
> +	struct nvme_command c;
> +	union nvme_result res;
> +	int ret;
> +
> +	if (!result)
> +		return -EINVAL;
> +
> +	memset(&c, 0, sizeof(c));
> +	c.features.opcode = nvme_admin_get_features;
> +	c.features.fid = cpu_to_le32(NVME_FEAT_POWER_MGMT);
> +
> +	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &c, &res,
> +			NULL, 0, 0, NVME_QID_ANY, 0, 0, false);
> +	if (ret >= 0)
> +		*result = le32_to_cpu(res.u32);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(nvme_get_power);

At this point I'd rather see those in the PCIe driver.  While the
power state feature is generic in the spec I don't see it actually
being used anytime anywhere else any time soon.

But maybe we can add a nvme_get_features helper ala nvme_set_features
in the core to avoid a little boilerplate code for the future?

> +	ret = nvme_set_power(&dev->ctrl, dev->ctrl.npss);
> +	if (ret < 0)
> +		return ret;

I can't find any wording in the spec that guarantees the highest
numerical power state is the deepest.  But maybe I'm just missing
something as such an ordering would be really helpful?

>  static int nvme_suspend(struct device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct nvme_dev *ndev = pci_get_drvdata(pdev);
>  
> +	/*
> +	 * Try to use nvme if the device supports host managed power settings
> +	 * and platform firmware is not involved.
> +	 */

This just comments that what, but I think we need a why here as the
what is fairly obvious..
