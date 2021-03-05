Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC7C32F112
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 18:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhCERYb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 12:24:31 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:35945 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhCERYU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Mar 2021 12:24:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614965060; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=4NIisY4w811oIA/VcR62rR+yydbAx2ISOLfSurqEVg8=;
 b=iYmezbiEGkphh+tI362GvzDEo+jAimPDMMIOpC/RoFPpxToUyPFLRFBULSKX9d4S53aKOzEK
 1JOvFB/C3SylDamkc6YGhe2dmhEPC2xvN4wJX3XmOxPZxzMlr9uDgRgA/LYnneyJxyx/lFpG
 WTB3AgiV3iEgYupPbP9nE10dowE=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 604269351a5c93533f2f7fce (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 05 Mar 2021 17:24:05
 GMT
Sender: manafm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E4088C43461; Fri,  5 Mar 2021 17:24:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: manafm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A61EC433CA;
        Fri,  5 Mar 2021 17:24:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Mar 2021 22:54:04 +0530
From:   manafm@codeaurora.org
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers: thermal: Add NULL pointer check before using
 cooling device stats
In-Reply-To: <1607367181-24589-1-git-send-email-manafm@codeaurora.org>
References: <1607367181-24589-1-git-send-email-manafm@codeaurora.org>
Message-ID: <483eabf92d011964d58c2321c9344ed2@codeaurora.org>
X-Sender: manafm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-12-08 00:23, Manaf Meethalavalappu Pallikunhi wrote:

Gentle reminder..

> There is a possible chance that some cooling device stats buffer
> allocation fails due to very high cooling device max state value.
> Later cooling device update sysfs can try to access stats data
> for the same cooling device. It will lead to NULL pointer
> dereference issue.
> 
> Add a NULL pointer check before accessing thermal cooling device
> stats data. It fixes the following bug
> 
> [ 26.812833] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000004
> [ 27.122960] Call trace:
> [ 27.122963] do_raw_spin_lock+0x18/0xe8
> [ 27.122966] _raw_spin_lock+0x24/0x30
> [ 27.128157] thermal_cooling_device_stats_update+0x24/0x98
> [ 27.128162] cur_state_store+0x88/0xb8
> [ 27.128166] dev_attr_store+0x40/0x58
> [ 27.128169] sysfs_kf_write+0x50/0x68
> [ 27.133358] kernfs_fop_write+0x12c/0x1c8
> [ 27.133362] __vfs_write+0x54/0x160
> [ 27.152297] vfs_write+0xcc/0x188
> [ 27.157132] ksys_write+0x78/0x108
> [ 27.162050] ksys_write+0xf8/0x108
> [ 27.166968] __arm_smccc_hvc+0x158/0x4b0
> [ 27.166973] __arm_smccc_hvc+0x9c/0x4b0
> [ 27.186005] el0_svc+0x8/0xc
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
> ---
>  drivers/thermal/thermal_sysfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_sysfs.c 
> b/drivers/thermal/thermal_sysfs.c
> index 473449b..10ca4f5 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -827,6 +827,9 @@ void thermal_cooling_device_stats_update(struct
> thermal_cooling_device *cdev,
>  {
>  	struct cooling_dev_stats *stats = cdev->stats;
> 
> +	if (!stats)
> +		return;
> +
>  	spin_lock(&stats->lock);
> 
>  	if (stats->state == new_state)
