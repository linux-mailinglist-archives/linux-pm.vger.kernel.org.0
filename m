Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1E831E8C5
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 11:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhBRKkK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 05:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhBRJ1m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 04:27:42 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A3EC061574
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:27:01 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id a24so911423plm.11
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=919iuc1yTl9Pu55utGz9sUod0tDzdfl+7EEqS8abU7g=;
        b=uFAXGEgmYDJ+WjEHhkN96qtv5IWzN1+mOuQqLx8qtEcBq1cNiWn66g5DEPd+OAoCVR
         WcMutik3aWjPIRgWyY7jR1F8fLAd6vjo8PpM/wbxK7jbQzbdHMQYfKvGbih20CZSI8sZ
         pHd9H0cnWBMsU27BiHe0GRN9kPXv0PPjPp96fj+kOMbOKDlRMBCbfFEwHDAbnHJnWLUy
         BnhOIhl5JgNritXcgHIONFSjJo4BcPUBd2h/rahTeihgbnrpTPVnPqhIY8zgYiwQGig0
         lm3lqB69uCZVlqm6R5DsbFK+66niwEDUNsS5sPgeBk6ofbL39N6lionfSeHytNp4nfMU
         c+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=919iuc1yTl9Pu55utGz9sUod0tDzdfl+7EEqS8abU7g=;
        b=N8Ap3iOynO0BRC+RARlao9BwvXk6tX2QAez2veBmsDxR3op2hLPy9rlmG0Z43lZ8Lr
         EkICyP64EOYMb/g3suISMg7R41s83n0eTDNy3EyYEjW3Rr3OUckfjr8Tl8l8LIai0Eih
         bc8KEe3glbVRRnK6xDbowXsTXNdceTz/TxCIZTXlaHjXyZshe0TlzqEB5YVK6swOR7Mp
         7hqefyi7GSNRC7Fwb/8YT7vE7UUWGrNxF5qU9S0DT2AwIBxq2+bSykoTt2oGhygzN/Jc
         peY3bSmjW9+FlYuikWhPN8ZnbLVbsT2pNrjANElfKBzUUGkQOna2/mDwvZq3oEZupQvX
         vypw==
X-Gm-Message-State: AOAM5318tFqdV0kzA8NK3uV9c7l9VU3x9VMaJFhHqWiDQquPJHkDu0vh
        YGn2Lr8B5y6y+MBAWe4SIesoWg==
X-Google-Smtp-Source: ABdhPJy1rl/Txd6nhUMGTs8hE/CtDGgL7so0bAmFni3AauoFqgtQdPPPJJ0SiIabhA5nO0BAdLsd5g==
X-Received: by 2002:a17:902:546:b029:e3:8f73:e75c with SMTP id 64-20020a1709020546b02900e38f73e75cmr3300671plf.1.1613640420941;
        Thu, 18 Feb 2021 01:27:00 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id c11sm5438517pfd.218.2021.02.18.01.27.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2021 01:27:00 -0800 (PST)
Date:   Thu, 18 Feb 2021 14:56:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] cpufreq: schedutil: Correct comment to update_lock of
 struct sugov_policy
Message-ID: <20210218092658.y4dxcxayz25ogrpi@vireshk-i7>
References: <20210218092316.1624-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218092316.1624-1-zbestahu@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-02-21, 17:23, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Currently, update_lock is also used in sugov_update_single_freq().
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index add8081..cc0308c 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -26,7 +26,7 @@ struct sugov_policy {
>  	struct sugov_tunables	*tunables;
>  	struct list_head	tunables_hook;
>  
> -	raw_spinlock_t		update_lock;	/* For shared policies */
> +	raw_spinlock_t		update_lock;	/* For single + shared policies */

I will just remove the comments, its pretty much useless anyway.

-- 
viresh
