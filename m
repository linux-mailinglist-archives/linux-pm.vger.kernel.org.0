Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 345C320FF5
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 23:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfEPVWQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 17:22:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:52072 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfEPVWQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 May 2019 17:22:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 May 2019 14:22:15 -0700
Received: from unknown (HELO [10.232.112.136]) ([10.232.112.136])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 16 May 2019 14:22:14 -0700
Subject: Re: [PATCH 1/2] nvme: add thermal zone infrastructure
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
From:   "Heitke, Kenneth" <kenneth.heitke@intel.com>
Message-ID: <2bf1e2cf-b922-d947-c939-375aba75994d@intel.com>
Date:   Thu, 16 May 2019 15:22:13 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/15/2019 9:17 AM, Akinobu Mita wrote:
> The NVMe controller reports up to nine temperature values in the SMART /
> Health log page (the composite temperature and temperature sensor 1 through
> temperature sensor 8).
> The temperature threshold feature (Feature Identifier 04h) configures the
> asynchronous event request command to complete when the temperature is
> crossed its correspoinding temperature threshold.

s/correspoinding/corresponding/

> +
> +static void nvme_thermal_init(struct nvme_ctrl *ctrl)
> +{
> +	INIT_WORK(&ctrl->thermal_work, nvme_thermal_work);
> +}

Does this work queue need to be destroyed at some point?
