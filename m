Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD0B2B5A31
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 08:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgKQHTC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 02:19:02 -0500
Received: from mga09.intel.com ([134.134.136.24]:64092 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgKQHTC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Nov 2020 02:19:02 -0500
IronPort-SDR: q/XLf/syn0pkLSChM1xhZkMf8uWsw47gVT5B5twViLsomDWgmx/aX0S7FJxhMvU6WWmF0S7Hih
 ZE56prMT8IHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="171046561"
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="171046561"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 23:19:01 -0800
IronPort-SDR: OJyEAJwupTcejrNgP+arSDCBG3RV0nzIt3rzpr4dk9U72ehub4eMTKsIRitC5+hhJHKjPzP6f3
 MCebQDWd9zZA==
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="543923046"
Received: from lil6-mobl1.ccr.corp.intel.com ([10.255.30.220])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 23:18:59 -0800
Message-ID: <4e28affd89ba8a852e0fb7ace076458b3d43839a.camel@intel.com>
Subject: Re: [PATCH] thermal: Fix NULL pointer dereference issue
From:   Zhang Rui <rui.zhang@intel.com>
To:     Mukesh Ojha <mojha@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org
Date:   Tue, 17 Nov 2020 15:18:57 +0800
In-Reply-To: <1605544181-5348-1-git-send-email-mojha@codeaurora.org>
References: <1605544181-5348-1-git-send-email-mojha@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-11-16 at 21:59 +0530, Mukesh Ojha wrote:
> Cooling stats variable inside thermal_cooling_device_stats_update()
> can get NULL. We should add a NULL check on stat inside for sanity.
> 
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
>  drivers/thermal/thermal_sysfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_sysfs.c
> b/drivers/thermal/thermal_sysfs.c
> index a6f371f..f52708f 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -754,6 +754,9 @@ void thermal_cooling_device_stats_update(struct
> thermal_cooling_device *cdev,
>  {
>  	struct cooling_dev_stats *stats = cdev->stats;
>  
> +	if (!stats)
> +		return;
> +
May I know in which case stats can be NULL?
The only possibility I can see is that cdev->ops->get_max_state() fails
in cooling_device_stats_setup(), right?

thanks,
rui

>  	spin_lock(&stats->lock);
>  
>  	if (stats->state == new_state)

