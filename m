Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C8B3954F5
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 07:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhEaFSa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 01:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhEaFSZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 01:18:25 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E81C061574
        for <linux-pm@vger.kernel.org>; Sun, 30 May 2021 22:16:46 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e7so2552097plj.7
        for <linux-pm@vger.kernel.org>; Sun, 30 May 2021 22:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rHdDhXlkghpKxfcJQs3sTLAGjLPGNMHk0nDLkF7VpsQ=;
        b=O3ZDIKvW6hpo7tp4ReDc9JUXt0sDqykDBZ74te4tbcYgogq/7nSBSKCjeshQkoj9E5
         HG79CZykedxVbOWCQr3/W9U4BNePp/jg6zkvQNAqFM2i3W2gUEwheW0u+tTa/84B+5Fk
         +wW5WlxHAo2IvlcjgIidi6sQEzw2BG7DKsv8NfLfMWRTjV+k7GRkrgiFUrWPqhxwyx5y
         A5EF5K5YcDvfZpPDWkiqi5gfmyfSnxe+XOc0+ZeVY3QaRctKt4yfGDLmpcnfragNSH4E
         p2W//8wPi0frcFFzHjArVcRYmlyXFEBiSiyXICZ+WoSPe8aGFxXe5r+/cv3fhNczA68T
         payA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rHdDhXlkghpKxfcJQs3sTLAGjLPGNMHk0nDLkF7VpsQ=;
        b=c20lylixsq/5wuZNqKeoqDawGrevPS+FvK3fhLkjb4D1djbdgV305hxezxKb+LHibd
         AuLOslVKB7HJPwvfUGFRIlV10A1eRuGqkuy7VDm0Fry3KYVDYnBKBSptzo3msjqLT7TU
         HJ11H2dVpAFTRbJtCe55UoUm0LDaotq5DBKt29lBg/Q3p8CgrUThboCfYyZYkWYu0Oda
         FS3Cz/+JtcwVeN00tReFHRTVAaMZsoAmBbAbhpxSvPNTBQqw7/tkD7/39Ltee0cJKZU8
         lB5yt2LT1rIFPLTLnXiHYIEKA93yRwsLy91Sby/qey4lbyooAs6/bMzuZo91vP3g0ukY
         0cwA==
X-Gm-Message-State: AOAM531Stc2uQLB1bHXzx6R4/PowDXCaSSe2kQfxG4B5mu/GlAhb152Q
        lkqzK7TK6DGLM5AW+FVMBEv39g==
X-Google-Smtp-Source: ABdhPJyMIljjCqRd5AHUAPEDQXXbbZ4c+5oYDmA6bcb94H9K5XUZKbUjIpXz0YFMspHzHjdVeSvVoQ==
X-Received: by 2002:a17:90a:738c:: with SMTP id j12mr14344646pjg.150.1622438205637;
        Sun, 30 May 2021 22:16:45 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id b15sm9669018pfi.100.2021.05.30.22.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 22:16:45 -0700 (PDT)
Date:   Mon, 31 May 2021 10:46:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: stats: Remove redundant initialization of local
 variable
Message-ID: <20210531051643.xvjqb4rog6hmpyjm@vireshk-i7>
References: <1622282079-52196-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622282079-52196-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-05-21, 17:54, Shaokun Zhang wrote:
> Local variable 'count' and 'ret' will be initialized, so remove the
> redundant initialization.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index da717f7cd9a9..2af6c5b43c43 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -211,7 +211,7 @@ void cpufreq_stats_free_table(struct cpufreq_policy *policy)
>  
>  void cpufreq_stats_create_table(struct cpufreq_policy *policy)
>  {
> -	unsigned int i = 0, count = 0, ret = -ENOMEM;
> +	unsigned int i = 0, count, ret;

ret isn't really required at all, can you get rid of it and update the only user
to something like this ?

	if (!sysfs_create_group(&policy->kobj, &stats_attr_group))
                return;

-- 
viresh
