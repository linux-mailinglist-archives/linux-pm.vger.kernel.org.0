Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5370431E8D0
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 12:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhBRKpg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 05:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbhBRKd6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 05:33:58 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9E7C0613D6
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:39:27 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b8so924372plh.12
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZrHj/ewduFsrl8RHbqYy1rIkDuaW8Pl3FnzqCRyJ9lU=;
        b=CfUw/qR927D6nvLjxoT9egbyXhk7Vnz2ubKSrs1EbUnx7I0dtOhSDOYNkzbuYnFk8i
         htuAPdAsEfBzbN8xm4wmU6jiaUdyGA0VoWsrsF9N6SCfpVSo1T8S3BlS5UWbNaSjebGd
         3ebdxH4Y+14FT5sZhMdGo9sOd0GD2sF7z+jb7jO5k/0DYeiPHDbkIXxsZsGW0sIy4cRg
         6f8yA99av8EYYj+rzTxwBeJEj20bzTlVm+8d8Bw8ZkqESSv+0M1kwSIT7hQl1wVJMLfZ
         xDJJFwwQjVklD6OKgU5iG9ggs+8jhlXOqmrO0lt0QCmWzs6ikJDbnf9VEtSJkSUrL3W7
         0eQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZrHj/ewduFsrl8RHbqYy1rIkDuaW8Pl3FnzqCRyJ9lU=;
        b=ZWm1vbj7u0bVwaqAYdfokF8i9q08p9sxT+rlxvef42OWvl66ELMeUIRBh7aiNgAGcX
         sqnHBkheONUuR6youRqBlYk5Nzvw9ig6LFsZK020uoepzQHTJA8L1GTgRxqIwNf8NuAe
         t0y6dgu2K6yXvI6RReKX1YlgOUisumVogcXF+sjncCbhV4t7R3YdPBNJaxsBmm6U2eHA
         PNydDwIp2ADnOIpFTMXzFXR+cBsLeFlR4svmiJ5U96O6wsLn8V3UdQvmYuwi02q0XsEe
         KHnpia/F0M6eh6aGd+Z4Wzcscb87rZ3QcTlOcmAjMyvwsFLe28/aBAuZBJyVjNbDO7gK
         fZPg==
X-Gm-Message-State: AOAM533P1tW3yDvlcrj2HNxYRzB2Gw0ZC18BcQ3zF9PdnlQi2A4+27EZ
        98jbJrt/2c5IN3KLCnDSVnWQR/qNlXqdog==
X-Google-Smtp-Source: ABdhPJwPpfRraGWLBQW+/O+c3RtnR1nZPsbY50zDQM3FiRkUum3np+ApN6ZsqmgF0quwGaHwsNaEDA==
X-Received: by 2002:a17:902:aa03:b029:e3:721:c093 with SMTP id be3-20020a170902aa03b02900e30721c093mr3365131plb.50.1613641166831;
        Thu, 18 Feb 2021 01:39:26 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id k9sm4531630pji.8.2021.02.18.01.39.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2021 01:39:26 -0800 (PST)
Date:   Thu, 18 Feb 2021 15:09:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] cpufreq: schedutil: Remove comment to update_lock of
 struct sugov_policy
Message-ID: <20210218093924.ye5i4vvwqqubkdqw@vireshk-i7>
References: <20210218093753.1700-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218093753.1700-1-zbestahu@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Always mention version number and version history in a patch. Don't
resend it now anyway.

On 18-02-21, 17:37, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Currently, update_lock is also used in sugov_update_single_freq(). The
> comment is not helpful anymore.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index add8081..fd43d59 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -26,7 +26,7 @@ struct sugov_policy {
>  	struct sugov_tunables	*tunables;
>  	struct list_head	tunables_hook;
>  
> -	raw_spinlock_t		update_lock;	/* For shared policies */
> +	raw_spinlock_t		update_lock;
>  	u64			last_freq_update_time;
>  	s64			freq_update_delay_ns;
>  	unsigned int		next_freq;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
