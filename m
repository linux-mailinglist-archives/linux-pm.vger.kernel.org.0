Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC0DE1B736
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 15:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfEMNle (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 09:41:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:31556 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfEMNle (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 09:41:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 06:41:33 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 13 May 2019 06:41:33 -0700
Date:   Mon, 13 May 2019 07:36:11 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Busch, Keith" <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Rafael Wysocki <rafael@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Message-ID: <20190513133611.GA15318@localhost.localdomain>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <20190511072258.GB14764@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190511072258.GB14764@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, May 11, 2019 at 12:22:58AM -0700, Christoph Hellwig wrote:
> A couple nitpicks, mostly leftover from the previous iteration
> (I didn't see replies to those comments from you, despite seeing
> a reply to my mail, assuming it didn't get lost):

I thought you just meant the freeze/unfreeze sequence. I removed that
part entirely, but yes, I can move all of this from the core. I will
just need to export 'nvme_set_features'
 
> > +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned ps)
> > +{
> > +	return nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, ps, NULL, 0, NULL);
> > +}
> > +EXPORT_SYMBOL_GPL(nvme_set_power);
> > +
> > +int nvme_get_power(struct nvme_ctrl *ctrl, u32 *result)
> > +{
> > +	struct nvme_command c;
> > +	union nvme_result res;
> > +	int ret;
> > +
> > +	if (!result)
> > +		return -EINVAL;
> > +
> > +	memset(&c, 0, sizeof(c));
> > +	c.features.opcode = nvme_admin_get_features;
> > +	c.features.fid = cpu_to_le32(NVME_FEAT_POWER_MGMT);
> > +
> > +	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &c, &res,
> > +			NULL, 0, 0, NVME_QID_ANY, 0, 0, false);
> > +	if (ret >= 0)
> > +		*result = le32_to_cpu(res.u32);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(nvme_get_power);
> 
> At this point I'd rather see those in the PCIe driver.  While the
> power state feature is generic in the spec I don't see it actually
> being used anytime anywhere else any time soon.
> 
> But maybe we can add a nvme_get_features helper ala nvme_set_features
> in the core to avoid a little boilerplate code for the future?

Sounds good.
 
> > +	ret = nvme_set_power(&dev->ctrl, dev->ctrl.npss);
> > +	if (ret < 0)
> > +		return ret;
> 
> I can't find any wording in the spec that guarantees the highest
> numerical power state is the deepest.  But maybe I'm just missing
> something as such an ordering would be really helpful?

I actually only noticed APST made this assumption, and I had to search
the spec to see where it calls this out. It is in section 8.4:

  Power states are contiguously numbered starting with zero such that
  each subsequent power state consumes less than or equal to the maximum
  power consumed in the previous state.

> >  static int nvme_suspend(struct device *dev)
> >  {
> >  	struct pci_dev *pdev = to_pci_dev(dev);
> >  	struct nvme_dev *ndev = pci_get_drvdata(pdev);
> >  
> > +	/*
> > +	 * Try to use nvme if the device supports host managed power settings
> > +	 * and platform firmware is not involved.
> > +	 */
> 
> This just comments that what, but I think we need a why here as the
> what is fairly obvious..

Sounds good.
