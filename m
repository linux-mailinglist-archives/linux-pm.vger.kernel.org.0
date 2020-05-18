Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3691D722D
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 09:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgERHqX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 03:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgERHqW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 03:46:22 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DFBC061A0C
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 00:46:22 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q16so3900237plr.2
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 00:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T9uobIKgESmbFhcuFLvRC/S5GOAhDlp80k1lTkiWfKM=;
        b=T4l87AsvtM398ZfQFUCbHOm+0gApWhAh9+UypGIAehpL0702593j7D1uQmoMGMS0yo
         W3eNo4hJuLx2wPbLcShZWQRSIhCeOjFp+5hgr5KSYZZ+a5afnFIXLAU1AqiOth5Zi+Q7
         ElI/Yc1QHETsutLE+HiWmwYpseYxV5vLw/jDBR9pZ90ypUudHjkjRMyNnoJSAG5MN+xO
         qhArU6RIT2cm1gtCmXigngecBnhHTI42eLeA+EqO0HczxVY75sFTk/3QzH7VEpsP8eLq
         qdT43DHRhYT+/wox6NY4tvGoAvh9cB+4eD2W0oD0zWeX4gxWmU4RzNs6MEeLTV+pCbw6
         LiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T9uobIKgESmbFhcuFLvRC/S5GOAhDlp80k1lTkiWfKM=;
        b=cG739oUXnpFqhM8/mrudPmZ7sDT63YklxIpkRy+BWlf8CziIDlMS3bDntWmTYx4yTj
         Ex1cJeUtLNp3KmbySDiFaGZ1tVORsm8PD62Tc1iDJFc+HLcD7STOuRcvo5lkuljISVuM
         0LnajbwPO38Lft3vGh6wxi8muH/MCRuZx4KrhkC+fmqmS4tE0oHcVhlodC2Abj66hutY
         m/KpsC485Wfmb1U29PBh9stuQ155ZHNnKuKfTUNPbvS6hTMPSOjpuz57rzEagSA+4JBS
         pHWD65ZhHgivzn60U4+80o4jsTePp61vvxWqI1pG7LYK45193kU+6z02BkwKd3UeVbqj
         hRhA==
X-Gm-Message-State: AOAM531Ttu76jhezxhZz4GCipSyuiDm8opmz2EkpqaZ5k/o8R8xyDoGR
        Fpduphx+WkKgLlakfu+9avhWTsA4iVI=
X-Google-Smtp-Source: ABdhPJyWn1h4OaUsYFY5yOnVGCBI9FC17QjIyeNF8hYyKqfne9DIliRG1JSn9840EhNF4tX2Rcgglw==
X-Received: by 2002:a17:90a:a102:: with SMTP id s2mr14005683pjp.94.1589787981851;
        Mon, 18 May 2020 00:46:21 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id 141sm8105467pfz.171.2020.05.18.00.46.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 00:46:21 -0700 (PDT)
Date:   Mon, 18 May 2020 13:16:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     rjw@rjwysocki.net, Souvik.Chakravarty@arm.com,
        Thanu.Rangarajan@arm.com, Sudeep.Holla@arm.com,
        guohanjun@huawei.com, john.garry@huawei.com,
        jonathan.cameron@huawei.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] cpufreq: handle the return value of
 '.set_boost()' properly
Message-ID: <20200518074619.yznopcgqmoq6ds7t@vireshk-i7>
References: <1589785808-12138-1-git-send-email-wangxiongfeng2@huawei.com>
 <1589785808-12138-2-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589785808-12138-2-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-05-20, 15:10, Xiongfeng Wang wrote:
> 'freq_qos_update_request()' called by 'cpufreq_boost_set_sw()' reutrns 1
> when the effective constraint value of frequency QoS has changed. It's
> not an error code. So handle the return value 1 of '.set_boost()' in
> 'cpufreq_boost_trigger_state()' properly.
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4adac3a..bb6746e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2540,7 +2540,10 @@ int cpufreq_boost_trigger_state(int state)
>  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>  
>  	ret = cpufreq_driver->set_boost(state);
> -	if (ret) {
> +	if (ret == 1) {
> +		pr_debug("The effective constraint value of frequency QoS has changed.\n");
> +		return 0;
> +	} else if (ret) {

Rafael, IMO it is better to pick patch from Sergey for this as this is
implementation detail.

>  		write_lock_irqsave(&cpufreq_driver_lock, flags);
>  		cpufreq_driver->boost_enabled = !state;
>  		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> -- 
> 1.7.12.4

-- 
viresh
