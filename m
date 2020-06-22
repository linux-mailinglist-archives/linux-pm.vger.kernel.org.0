Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23345202E47
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 04:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbgFVCVl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Jun 2020 22:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731010AbgFVCVk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jun 2020 22:21:40 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACE7C061795
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2020 19:21:40 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p3so4800684pgh.3
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2020 19:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=za4ixpkZVJ89aZj99CdaA5henDCAhx0/4oZkooHfKSM=;
        b=a5HO9j+w7TlTCzuhw+ErrqrGWVXKa5oUj7qYt5EOEM1bzS3OcwQ608ozcI6NloQw3D
         bXlHU46+YfEZwUWe0v6V5thX/67joii/re2fHcch1I/WF+f3tUku/ajXoIEVUAz9ZVJS
         djDjg3RcwiiXutYd+rBdbCPZoI4KUvriIYMhY0Wjx9bRjPzzVGn31NC89ATaNHWPnxY5
         i7a6VUynyNHt+KdqK9zVC4kh6Di9rUuSBPO95x+3YAPL3hgw1akVj4sm9Ojzw12C46aQ
         ego0CXDzdbS8h6O2MMrErvI7X/HGcIAFch1Ic9NiYquTB6xrFsWKTR+49YSUrXUyb2zW
         aK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=za4ixpkZVJ89aZj99CdaA5henDCAhx0/4oZkooHfKSM=;
        b=JQt0Be4M+QrB67KD+lcJ9zWIt2TpdE57O2bsD5QHo8urVGxw6TYzmavc4Gk6+/lSNc
         rnQQ3SzgKUDvCRdi7jD5GbvPxoq+Z/6M6Tai6xEAmEliQAhYXIy1VIsxcQUAIs8j3Kl7
         n1+/1zzHUshdceZk7Bgxx00E+Qc7m0kw/qWr5N6rLlPvHw4I7oyLZcSyuFV4Z1Ii9ZuB
         VOYRhPWB6ZVrXhxMgq6a4cm06GoyjyHfPTsFcgsBD+pe4r/DM3YlQTdknqBJ5MudHcP8
         p5jbfB47x4UfuOLWbwvClmn4N7qOjBj7yluKCi8SLmPnCoCoikOoLrUohowPIyv83ft/
         Oq6g==
X-Gm-Message-State: AOAM531EX6Fn4HjlbOvbS9+Z/cLotu6WQAYWZ80vJ8br9iWQSDqapWrB
        3VjZUd506X5qHPCLOK8bBJOzvQ==
X-Google-Smtp-Source: ABdhPJyUdbzgsK5VX3z+os8AgBV7UxgmQb8OJV6f2Z+9OVyvMSOlUO0h83jSi0pXsZKM6SwyJWa5zw==
X-Received: by 2002:a63:924b:: with SMTP id s11mr10807370pgn.74.1592792499893;
        Sun, 21 Jun 2020 19:21:39 -0700 (PDT)
Received: from localhost ([122.172.111.76])
        by smtp.gmail.com with ESMTPSA id i5sm11906183pjd.23.2020.06.21.19.21.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2020 19:21:39 -0700 (PDT)
Date:   Mon, 22 Jun 2020 07:51:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: dt: fix oops on armada37xx
Message-ID: <20200622022137.f27ztstb5w3o43fe@vireshk-i7>
References: <20200620164449.GA19776@mail.rc.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620164449.GA19776@mail.rc.ru>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-06-20, 17:44, Ivan Kokshaysky wrote:
> Commit 0c868627e617e43a295d8 (cpufreq: dt: Allow platform specific
> intermediate callbacks) added two function pointers to the
> struct cpufreq_dt_platform_data. However, armada37xx_cpufreq_driver_init()
> has this struct (pdata) located on the stack and uses only "suspend"
> and "resume" fields. So these newly added "get_intermediate" and
> "target_intermediate" pointers are uninitialized and contain arbitrary
> non-null values, causing all kinds of trouble.
> 
> For instance, here is an oops on espressobin after an attempt to change
> the cpefreq governor:
> 
> [   29.174554] Unable to handle kernel execute from non-executable memory at virtual address ffff00003f87bdc0
> ...
> [   29.269373] pc : 0xffff00003f87bdc0
> [   29.272957] lr : __cpufreq_driver_target+0x138/0x580
> ...
> 
> Fixed by zeroing out pdata before use.
> 
> Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> index aa0f06dec959..df1c941260d1 100644
> --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> @@ -456,6 +456,7 @@ static int __init armada37xx_cpufreq_driver_init(void)
>  	/* Now that everything is setup, enable the DVFS at hardware level */
>  	armada37xx_cpufreq_enable_dvfs(nb_pm_base);
>  
> +	memset(&pdata, 0, sizeof(pdata));
>  	pdata.suspend = armada37xx_cpufreq_suspend;
>  	pdata.resume = armada37xx_cpufreq_resume;

Applied. Thanks.

-- 
viresh
