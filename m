Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E59FE259A6
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 23:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfEUVFo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 17:05:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:46480 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbfEUVFo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 May 2019 17:05:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 14:05:43 -0700
Received: from unknown (HELO [10.232.112.165]) ([10.232.112.165])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 21 May 2019 14:05:42 -0700
Subject: Re: [PATCH v2 2/4] nvme: add thermal zone infrastructure
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@fb.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
From:   "Heitke, Kenneth" <kenneth.heitke@intel.com>
Message-ID: <44154394-c0a0-4895-d406-ea357a906cfe@intel.com>
Date:   Tue, 21 May 2019 15:05:41 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/21/2019 10:04 AM, Akinobu Mita wrote:
> +static int nvme_set_over_temp_thresh(struct nvme_ctrl *ctrl,
> +				     unsigned int sensor, int temp)
> +{
> +	unsigned int threshold = sensor << NVME_TEMP_THRESH_SELECT_SHIFT;
> +	int status;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(sensor >= ARRAY_SIZE(ctrl->tzdev)))
> +		return -EINVAL;
> +
> +	if (temp > NVME_TEMP_THRESH_MASK)
> +		return -EINVAL;
> +
> +	threshold |= temp & NVME_TEMP_THRESH_MASK;
> +
> +	ret = nvme_set_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold, NULL, 0,
> +				&status);

I'm not sure about best practices here but since 'status' is unused, you
can pass in a NULL pointer. The called function deals with it correctly.

> +
> +	return ret > 0 ? -EINVAL : ret;
> +}
> +
