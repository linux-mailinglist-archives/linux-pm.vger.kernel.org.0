Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B732CFB1F
	for <lists+linux-pm@lfdr.de>; Sat,  5 Dec 2020 12:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgLELPL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Dec 2020 06:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbgLELNq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Dec 2020 06:13:46 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D99C0613D1
        for <linux-pm@vger.kernel.org>; Sat,  5 Dec 2020 03:12:51 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id v14so7504928wml.1
        for <linux-pm@vger.kernel.org>; Sat, 05 Dec 2020 03:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x3MlcU7qqnioeGe3U/h0AtvIhqUW7zxX3foVy4H6+84=;
        b=C4RyjZ4JSoS3BTtaC5zAAqyR2bcFbLrC7Ytn2UGOw4q3Gcvy6l+glY+tvNz4sQ2RrA
         6iJTSrWMdWuTbxxKHoiHvqWEjknGlD8iE39gyXHx2dKbqe8cdXGH5Z1b5F+m/HVBjb8F
         yBllAA69pD3d9JSSATw0C9TxwazEoap4o3dYJCV578ffe5p3lwhhNEibsdGHo7lGK4yt
         OZ/Lqm2ANSuYUJNiwLkDwE2wg7b7vRWUPqHtnZYgUFMD3bzBWxsYbaotHz1kjpE07Wg4
         BvzAqa/L9EYX7n+2pLQnmr1Sgmd1twuBigLoNWiIJQ+/CFNEMaCzomv3dgr36hRsHB4Z
         Isxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x3MlcU7qqnioeGe3U/h0AtvIhqUW7zxX3foVy4H6+84=;
        b=LZSvzSqZh5YEUeoHq6eKE1ToOh+UGiJYoBUUO8TNkjLKHjJS4Nw+8GpTpwHoUYCH/A
         7U1tvr9Bd5tJV21JNOoaDQUZT2/21HzyjFXkoioG3RTGsl/ODnQaSGOunLF6Fq85em6S
         MzIcF2dgO0zc5qzGdRs88Tr3rZeVCqOpLa9KzfKIn2qzetTU2L9l7z8N2VW3v0NKgcJM
         RW9YaoW2sz98GYmKNmlqH4dWgR/pGxyD2oqOqYV8uZS9SuorFfhI9z9UzheMkOGozRSh
         UoGX3DwttHrWnjTyo3Zd2JSStGYO1Llaa8Bg0QYjljJPVFVgEYnkS2xEeu0z59mIR74F
         U16A==
X-Gm-Message-State: AOAM533jW0aQ+kV/ehI966ows1EWlilXXZLVbNSjh083KimbJ0o2VioI
        sR/2bL19is0xIopUxMhRvUWMMg==
X-Google-Smtp-Source: ABdhPJyK6+pzfmdgdfdzDxmhPadpiRIzI84quG8t7VrbxKpOoG4iaO6VPOchFkh4D6FL7GChjsOGIQ==
X-Received: by 2002:a1c:6a10:: with SMTP id f16mr8823663wmc.106.1607166769794;
        Sat, 05 Dec 2020 03:12:49 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8165:c1cc:d736:b53f? ([2a01:e34:ed2f:f020:8165:c1cc:d736:b53f])
        by smtp.googlemail.com with ESMTPSA id e3sm7312160wro.90.2020.12.05.03.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 03:12:49 -0800 (PST)
Subject: Re: [PATCH] drivers: thermal: Add NULL pointer check before using
 cooling device stats
To:     Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1607108991-31948-1-git-send-email-manafm@codeaurora.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <55cd5e44-f34e-26a3-fad7-20100d429d1d@linaro.org>
Date:   Sat, 5 Dec 2020 12:12:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1607108991-31948-1-git-send-email-manafm@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/12/2020 20:09, Manaf Meethalavalappu Pallikunhi wrote:
> There is a possible chance that some cooling device stats buffer
> allocation fails due to very high cooling device max state value.
> Later cooling device update or cooling stats sysfs will try to
> access stats data for the same cooling device. It will lead to
> NULL pointer dereference issue.
> 
> Add a NULL pointer check before accessing thermal cooling device
> stats data. It fixes the following bug
> 
> [ 26.812833] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
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

The only place where it can crash is when the
thermal_cooling_device_stats_update() function is called.

The other places in show*/store* in the stats directory are inaccessible
as the sysfs entry is not showed up due to the
thermal_cooling_device_stats_setup() failing.

It would have been nice if the thermal_cooling_device_stats_update() was
not called at all but I don't see how we can do that without static keys
which is overkill for a degraded mode.

I guess having the kzallocation warning in the console output is enough
to warn the user the system is working without the stats for the cooling
device. That should not prevent the system functioning.

Can you resend with the check in thermal_cooling_device_stats_update() only?

Thanks

  -- Daniel


> ---
>  drivers/thermal/thermal_sysfs.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 473449b..a5e4855 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -827,6 +827,9 @@ void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
>  {
>  	struct cooling_dev_stats *stats = cdev->stats;
>  
> +	if (!stats)
> +		return;
> +
>  	spin_lock(&stats->lock);
>  
>  	if (stats->state == new_state)
> @@ -848,6 +851,9 @@ static ssize_t total_trans_show(struct device *dev,
>  	struct cooling_dev_stats *stats = cdev->stats;
>  	int ret;
>  
> +	if (!stats)
> +		return -ENODEV;
> +
>  	spin_lock(&stats->lock);
>  	ret = sprintf(buf, "%u\n", stats->total_trans);
>  	spin_unlock(&stats->lock);
> @@ -864,6 +870,9 @@ time_in_state_ms_show(struct device *dev, struct device_attribute *attr,
>  	ssize_t len = 0;
>  	int i;
>  
> +	if (!stats)
> +		return -ENODEV;
> +
>  	spin_lock(&stats->lock);
>  	update_time_in_state(stats);
>  
> @@ -882,8 +891,12 @@ reset_store(struct device *dev, struct device_attribute *attr, const char *buf,
>  {
>  	struct thermal_cooling_device *cdev = to_cooling_device(dev);
>  	struct cooling_dev_stats *stats = cdev->stats;
> -	int i, states = stats->max_states;
> +	int i, states;
> +
> +	if (!stats)
> +		return -ENODEV;
>  
> +	states = stats->max_states;
>  	spin_lock(&stats->lock);
>  
>  	stats->total_trans = 0;
> @@ -907,6 +920,9 @@ static ssize_t trans_table_show(struct device *dev,
>  	ssize_t len = 0;
>  	int i, j;
>  
> +	if (!stats)
> +		return -ENODEV;
> +
>  	len += snprintf(buf + len, PAGE_SIZE - len, " From  :    To\n");
>  	len += snprintf(buf + len, PAGE_SIZE - len, "       : ");
>  	for (i = 0; i < stats->max_states; i++) {
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
