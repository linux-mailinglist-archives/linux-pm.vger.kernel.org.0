Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1655125569
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 18:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfEUQUj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 12:20:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:12243 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfEUQUj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 May 2019 12:20:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 09:20:38 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 21 May 2019 09:20:37 -0700
Date:   Tue, 21 May 2019 10:15:32 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@fb.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/4] nvme: add thermal zone infrastructure
Message-ID: <20190521161532.GD1639@localhost.localdomain>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 22, 2019 at 01:04:07AM +0900, Akinobu Mita wrote:
> +int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_smart_log *log;
> +	int ret;
> +	int i;
> +
> +	log = kzalloc(sizeof(*log), GFP_KERNEL);
> +	if (!log)
> +		return 0; /* non-fatal error */
> +
> +	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> +			   log, sizeof(*log), 0);
> +	if (ret) {
> +		dev_err(ctrl->device, "Failed to get SMART log: %d\n", ret);
> +		ret = ret > 0 ? -EINVAL : ret;

A ret > 0 means the device provided a response, so don't return a
negative for that condition, please. That's just going to break
controllers that don't provide smart data, like qemu.
