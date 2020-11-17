Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF662B5A29
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 08:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgKQHPI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 02:15:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:31188 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgKQHPH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Nov 2020 02:15:07 -0500
IronPort-SDR: nu7tpJqvoaAbwvDHcF3Zt6CvhTGJ9RwptoI7aO62NJ9TTnXKN9X48jEPU/LRweMB+hR+qMQlIl
 R1YFeo2cB3lw==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="168298824"
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="168298824"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 23:15:07 -0800
IronPort-SDR: sR8h+o7akjT61qOtzbZd64/FD6vJBKF7clfnMi8baqWtQQzuhTDi9yyL3jKGyxSSXRaoaX7eiD
 MYTzcLc3ZDig==
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="543921746"
Received: from lil6-mobl1.ccr.corp.intel.com ([10.255.30.220])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 23:15:04 -0800
Message-ID: <3776af7407728bc11428d887a9a7028919218f6b.camel@intel.com>
Subject: Re: [PATCH] thermal: Fix slab-out-of-bounds in
 thermal_cooling_device_stats_update()
From:   Zhang Rui <rui.zhang@intel.com>
To:     zhuguangqing83@gmail.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuguangqing@xiaomi.com
Date:   Tue, 17 Nov 2020 15:15:02 +0800
In-Reply-To: <20200915055837.498-1-zhuguangqing83@gmail.com>
References: <20200915055837.498-1-zhuguangqing83@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-09-15 at 13:58 +0800, zhuguangqing83@gmail.com wrote:
> From: zhuguangqing <zhuguangqing@xiaomi.com>
> 
> In function thermal_cooling_device_stats_update(), if the input
> parameter
> new_state is greater or equal to stats->max_states, then it will
> cause
> slab-out-of-bounds error when execute the code as follows:
> stats->trans_table[stats->state * stats->max_states + new_state]++;
> 
> Two functions call the function
> thermal_cooling_device_stats_update().
> 1. cur_state_store()
> 2. thermal_cdev_set_cur_state()
> Both of the two functions call cdev->ops->set_cur_state(cdev, state)
> before thermal_cooling_device_stats_update(), if the return value is
> not 0, then thermal_cooling_device_stats_update() will not be called.
> So if all cdev->ops->set_cur_state(cdev, state) check validity of the
> parameter state, then it's ok. Unfortunately, it's not now.
> 
> We have two methods to avoid the slab-out-of-bounds error in
> thermal_cooling_device_stats_update().
> 1. Check the validity of the parameter state in all
> cdev->ops->set_cur_state(cdev, state).
> 2. Check the validity of the parameter state in
> thermal_cooling_device_stats_update().
> 
> Use method 2 in this patch. Because the modification is simple and
> resolve the problem in the scope of "#ifdef
> CONFIG_THERMAL_STATISTICS".
> 
> Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>

Hi, Daniel,

this patch is a similar fix as

https://patchwork.kernel.org/project/linux-pm/patch/20200408041917.2329-4-rui.zhang@intel.com/

I think we'd better take the original fix from Takashi Iwai.
And I will refresh and submit the patches that supports dynamic cooling
states later when I have time.

thanks,
rui
> ---
>  drivers/thermal/thermal_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_sysfs.c
> b/drivers/thermal/thermal_sysfs.c
> index 8c231219e15d..9c49f744d79d 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -756,7 +756,7 @@ void thermal_cooling_device_stats_update(struct
> thermal_cooling_device *cdev,
>  
>  	spin_lock(&stats->lock);
>  
> -	if (stats->state == new_state)
> +	if (stats->state == new_state || new_state >= stats-
> >max_states)
>  		goto unlock;
>  
>  	update_time_in_state(stats);

