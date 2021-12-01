Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA0F464768
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 07:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346996AbhLAGyg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 01:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239629AbhLAGyf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 01:54:35 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A54C061574
        for <linux-pm@vger.kernel.org>; Tue, 30 Nov 2021 22:51:15 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id p13so15721424pfw.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Nov 2021 22:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HZdr5FaAwMs7gYlPkQG8bLmm++50OoWZum7rGMAyFng=;
        b=SC7ibXdGmDCiVZJHNonTL61wY7xYyz6ToA5gLOp9tHz++JGv8VO8jXkVKGz5JrKGbS
         uNWvHibVIx6qRy3VhhATG/NersgEVElOoXi/7d/So396aBSQtE1a2FE6AzTmT/zOAjPC
         tRVwDmASr+Hcnup/qlhfwtIieKBhNzwyCqlHLC8vJVOrRdzNHooX29Egh0QjxK2Kg684
         4KibNGz1thYi968He+dpV9OCftundZb2ahtWNg4DMzGdtbF86NKfsv5HvuzJsBUagTce
         5FxMtvjs0tkq9ts3sF9I/TIuKaq6eO68wUEnAoWCZkxqShZnDXcKqAkWjBxw+P9rrpql
         UTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HZdr5FaAwMs7gYlPkQG8bLmm++50OoWZum7rGMAyFng=;
        b=mLSVfYhv8z02RkcSqaTi1a3uENcgJAfHyObKgq/r0CawWFmqsH8TFa/km8L6qGMeRQ
         3VJF23FzRxO2v9iJNxC6lw4Z50vUYPrPMkOpQQMRI/7iZpKpqtoWwUuAWgTMWO4I4gEF
         3c8fIv0DQ4zG4nV1fTadR0pMcUo/EaO1kppGq/qQUyb3g7Fa4vmD7S/+yVYqUsAfJbSl
         WFoZyYz+FHjU5/MV37ZETmiuqz2BRtJFxhJEpmiWwKfAOR8ad2d6YX3cPzT6JY1qGQvp
         mh1s/+ldxrqn9i3kizoptAYlVlJ9Kbex1PLwYK6d+pi98ghixCRaZyOl3FJEDpySN7CW
         MneQ==
X-Gm-Message-State: AOAM530JfWiMgBRmcoNlK+BbGRUk9rixEOcvcsdaiNP9MMUVCgxZbNIz
        /WUao7stdTKkDd+QTQdgXfGttg==
X-Google-Smtp-Source: ABdhPJxvMWTp6p5XeTopZa8OffNd3Il6ExUKM0+i3dJaVoaBj5E22Schm1QmSK5foMX8GmudgBc0KA==
X-Received: by 2002:a63:6cc8:: with SMTP id h191mr3357300pgc.76.1638341475129;
        Tue, 30 Nov 2021 22:51:15 -0800 (PST)
Received: from localhost ([122.171.9.64])
        by smtp.gmail.com with ESMTPSA id v19sm17644pju.32.2021.11.30.22.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 22:51:14 -0800 (PST)
Date:   Wed, 1 Dec 2021 12:21:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Tang Yizhou <tangyizhou@huawei.com>
Cc:     rafael.j.wysocki@intel.com, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cpufreq: Fix a comment in cpufreq_policy_free
Message-ID: <20211201065113.se47btr7wr2y3oim@vireshk-i7>
References: <20211201071500.28648-1-tangyizhou@huawei.com>
 <20211201071500.28648-2-tangyizhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201071500.28648-2-tangyizhou@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-12-21, 15:14, Tang Yizhou wrote:
> Comment both when CPUFREQ_CREATE_POLICY and CPUFREQ_REMOVE_POLICY
> notification are sent.
> 
> Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e338d2f010fe..e76777881739 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1296,8 +1296,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  
>  	if (policy->max_freq_req) {
>  		/*
> -		 * CPUFREQ_CREATE_POLICY notification is sent only after
> -		 * successfully adding max_freq_req request.
> +		 * Need to send CPUFREQ_REMOVE_POLICY notification if
> +		 * max_freq_req request is successfully added.
> +		 * See also: CPUFREQ_CREATE_POLICY notification.

I will rather write this as:

		/*
                 * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY
                 * notification, since CPUFREQ_CREATE_POLICY notification was
                 * sent after adding max_freq_req earlier.
                 */

>  		 */
>  		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>  					     CPUFREQ_REMOVE_POLICY, policy);
> @@ -1429,6 +1430,10 @@ static int cpufreq_online(unsigned int cpu)
>  			goto out_destroy_policy;
>  		}
>  
> +		/*
> +		 * CPUFREQ_CREATE_POLICY notification is sent only after
> +		 * successfully adding max_freq_req request.
> +		 */

This is obvious, we don't need a comment here.

>  		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>  				CPUFREQ_CREATE_POLICY, policy);
>  	}
> -- 
> 2.17.1

-- 
viresh
