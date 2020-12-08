Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901172D2641
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 09:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgLHIe2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 03:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgLHIe2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 03:34:28 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B70DC0613D6
        for <linux-pm@vger.kernel.org>; Tue,  8 Dec 2020 00:33:48 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id j1so6627401pld.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2020 00:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gjlk/jLtNyUeazDdibe5U/NgLr5RcEOaHOigFIrgjeQ=;
        b=OCylihwq7Lr5YIGlbD2kaf6/40QC0sTHW78aJsoFmHE03MNa1w24Gwx7iPgKqOuMiW
         dr1Fs5D8hBgnHMLti9ou6c9x3yky5vgVa72hOXjS6nmiYup1XgMyBr6LPJJhB+t5MxUL
         7mqR1RvunHbJ9ijFWcJQe2u+zs60a+3gWFYIb0nEkE/MbHLL0hxR9ZDTaPJqZv0fi8C8
         jscJmQ2gm1Wmkc6gdui2bOmIehjxPsmM6yXpSACpZ7jgQ7tQJLfNjs6sFhbyjsPLK6MC
         XjBRdR9R81z5whkK8AWEg+WDvrp5jDcl/vrjpQEkNWUYnFH37g9O39jzEvm+uJ8qEngU
         b6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gjlk/jLtNyUeazDdibe5U/NgLr5RcEOaHOigFIrgjeQ=;
        b=n7HmCC9uTLgDbOJciFmQJvYRwk61i4/rIk5hgr/qtYGc5dwOnqIDUME7xWxYmCDM6L
         w/MkiBVXtd6NkFemEBWnnryv/ur4NDZQB9xo9Yz8FHgDyMhQCystSqwDp5g/JF1c4Hev
         uOWA8fBXlhOY2G17zovHyjZsWNTVuTQ+jQ5CLSJUk4Gen6ZJw+R+xOQ/0t69UWlWwiic
         YjAeatJnbAKWHrHEgkyI1T7aIBpiGY18WVny1M9LvND/0QMshdcM4bxlh8teYiNCl9j5
         JIRLbwigPWh0qWams4yZyCOzwVlJqkNhqHkoU/fp3cU210mW9P4ZZpkYo8IPblVVAPMp
         Rx/w==
X-Gm-Message-State: AOAM53224ODsOHpjvIgHoLnFqp9VkONuRkxbUPWlPxVxBLFUG8jF5xff
        tR7IigX+krsJ1ET1RsnWy1Jlbw==
X-Google-Smtp-Source: ABdhPJzY0+766oi0+74mYEbdymuuxI+2nI3fPnl7VRjTC2pW8nnX+qsLQ4JACq+CUkg+5IvstN2a/A==
X-Received: by 2002:a17:902:6b8c:b029:d6:d32e:4a8c with SMTP id p12-20020a1709026b8cb02900d6d32e4a8cmr20100699plk.28.1607416427728;
        Tue, 08 Dec 2020 00:33:47 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id k21sm16105066pfu.77.2020.12.08.00.33.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 00:33:46 -0800 (PST)
Date:   Tue, 8 Dec 2020 14:03:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Subject: Re: [PATCH v1 1/4] cpufreq: schedutil: Add util to struct sg_cpu
Message-ID: <20201208083344.s67kalyxuui3ia4q@vireshk-i7>
References: <20360841.iInq7taT2Z@kreacher>
 <2344038.BgO4qI7qUv@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2344038.BgO4qI7qUv@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-12-20, 17:28, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of passing util and max between functions while computing the
> utilization and capacity, store the former in struct sg_cpu (along
> with the latter and bw_dl).
> 
> This will allow the current utilization value to be compared with the
> one obtained previously (which is requisite for some code changes to
> follow this one), but also it makes the code look slightly more
> consistent and clean.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/sched/cpufreq_schedutil.c |   42 ++++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 22 deletions(-)
> 
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> @@ -53,6 +53,7 @@ struct sugov_cpu {
>  	unsigned int		iowait_boost;
>  	u64			last_update;
>  
> +	unsigned long		util;
>  	unsigned long		bw_dl;
>  	unsigned long		max;
>  
> @@ -276,16 +277,15 @@ unsigned long schedutil_cpu_util(int cpu
>  	return min(max, util);
>  }
>  
> -static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
> +static void sugov_get_util(struct sugov_cpu *sg_cpu)

Maybe name it sugov_update_util() ?

Otherwise,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
