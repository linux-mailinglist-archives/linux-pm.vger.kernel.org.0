Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFA919811
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 07:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfEJFbM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 01:31:12 -0400
Received: from verein.lst.de ([213.95.11.211]:50210 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfEJFbM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 May 2019 01:31:12 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6DF3B68AFE; Fri, 10 May 2019 07:30:52 +0200 (CEST)
Date:   Fri, 10 May 2019 07:30:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Mario.Limonciello@dell.com, kai.heng.feng@canonical.com,
        hch@lst.de, axboe@fb.com, sagi@grimberg.me, rafael@kernel.org,
        linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of
 D3 on Suspend-to-Idle
Message-ID: <20190510053052.GB3654@lst.de>
References: <20190509061237.GA15229@lst.de> <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com> <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com> <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com> <20190509095601.GA19041@lst.de> <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com> <20190509103142.GA19550@lst.de> <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com> <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM> <20190509192807.GB9675@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509192807.GB9675@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned npss)
> +{
> +	int ret;
> +
> +	mutex_lock(&ctrl->scan_lock);
> +	nvme_start_freeze(ctrl);
> +	nvme_wait_freeze(ctrl);
> +	ret = nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, npss, NULL, 0,
> +				NULL);
> +	nvme_unfreeze(ctrl);
> +	mutex_unlock(&ctrl->scan_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(nvme_set_power);

I think we should have this in the PCIe driver, givn that while in
theory power states are generic in practice they are only applicable
to PCIe.  To be revisited if history proves me wrong.

Also I don't see any reason why we'd need to do the freeze game on
resume.  Even on suspend it looks a little odd to me, as in theory
the PM core should have already put the system into a quiescent state.
But maybe we actually need it there, in which case a comment would
be helpful.

> +	if (!pm_suspend_via_firmware())

pm_suspend_via_firmware is a weird name and has absolutely zero
documentation.  So I think we really need a big fat comment with the
wisdom from this thread here.

> +		return nvme_set_power(&ndev->ctrl, ndev->ctrl.npss);

I think we need to skip this code path is NPSS is zero, as that
indicates that the device doesn't actually do power states and fall
back to the full teardown.

Also I can't find anything except for this odd sentences in the spec:

  "Hosts that do not dynamically manage power should set the power
  state to the lowest numbered state that satisfies the PCI Express
  slot power limit control value.

that requires the power states to be ordered in any particular way.
So we probably have to read through the table at probing time and find
the lowest power state there.

Rafael also brought up the issue of not entering D3, and the somewhat
non-intuitive to me solution for it, so I'm not commenting on that
except for asking on a comment on that save_state call.

> +     if (!pm_suspend_via_firmware())
> +             return nvme_set_power(&ndev->ctrl, 0);

Don't we need to save the previous power state here and restore that?
For example if someone set a specific state through nvme-cli?
