Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BA0354D4B
	for <lists+linux-pm@lfdr.de>; Tue,  6 Apr 2021 09:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbhDFHG4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Apr 2021 03:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238404AbhDFHG4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Apr 2021 03:06:56 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EA7C06174A
        for <linux-pm@vger.kernel.org>; Tue,  6 Apr 2021 00:06:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mj7-20020a17090b3687b029014d162a65b6so3226007pjb.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Apr 2021 00:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7EEcX0WRaaFWF5q8a9TDVvXz9lOn7XGkt32r3j6MV8s=;
        b=ZFNEBYZEDyHBuSDtkWkZyqHMduF43HCFzTRMuKkHrNlPbvN+dG6yO23kpAXXg2ancT
         bhTlFBgh+BuFpoonbQA1p25btjwbSp0Km6C++pB1WWfkwPHBc163kN7h0w7ZNRZRjBgD
         X+BazbpRHNdqGaOc+pEVmWZC9PLzRHUHFR29ueY8PB3HGt05GImL4omsj1YYf3B+O3uG
         OVx+sZcCaw3j7aGw7f44W9kt7I7T+RWvpdpPwWjgkPXMxWF4gic02FF4iJld7ZnluUTY
         XukF6qteE4QwUGXDHqNuG4hh7sfknIKTHioxCUNyO4EV6m6+IkEc1vR5m7JSmj7FNVh2
         VeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7EEcX0WRaaFWF5q8a9TDVvXz9lOn7XGkt32r3j6MV8s=;
        b=MniN9PAWipss/kstFqcP5CGIU9YnZAQXsoeuuHxjmBXVj541CW5gYcYw8RHFu3j7AS
         tZVPZl4exQfaS3ptWLo6rMO6XobNqX0xjMcJMcP+eK2DzU92UWHzWaTqji2ZxOrk1OFf
         AzfUcjYA9ILk+y7tG1/nwO8yFb/gZ/Hs8DW8Bp9gYua9VjB9D1VdtwrDbK9dxy9279hE
         OerWJ7Je90RujPhItZ4HNugQdHK9M7xsa7yCE5rkJA2m12TMayR7T7H3+/XmJy3IHejb
         7lsZETwB3l4kkFNBz4CeVlIylEGMbP2IW4zv5siOWOrnSXNbTVyupJj9Ec8ksSprz2Mv
         /Nzg==
X-Gm-Message-State: AOAM5320fA2X5RYqjMkwivHlL94tROzixEL7kOqhy4JmfmcJAtbt9sIQ
        yaA50jz1l/xbwNwGBJlOJUh+CzlhxvnwHA==
X-Google-Smtp-Source: ABdhPJzfSd0NLxAqKlszz4O1W/EkCrrpik2cqx9Vo8bSyzR+H9qY8i+3MvQblST5j+7bSHu6Fi8HOg==
X-Received: by 2002:a17:90b:fc5:: with SMTP id gd5mr2969574pjb.108.1617692808615;
        Tue, 06 Apr 2021 00:06:48 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id t19sm18417173pfg.38.2021.04.06.00.06.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Apr 2021 00:06:48 -0700 (PDT)
Date:   Tue, 6 Apr 2021 12:36:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Remove unused for_each_policy macro
Message-ID: <20210406070645.73l2oeqrdlwzxxi4@vireshk-i7>
References: <1617692459-35670-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617692459-35670-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-04-21, 15:00, Shaokun Zhang wrote:
> macro 'for_each_policy' has become unused since commit
> f963735a3ca3 ("cpufreq: Create for_each_{in}active_policy()"),
> Remove it.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  drivers/cpufreq/cpufreq.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1d1b563cea4b..802abc925b2a 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -42,9 +42,6 @@ static LIST_HEAD(cpufreq_policy_list);
>  #define for_each_inactive_policy(__policy)		\
>  	for_each_suitable_policy(__policy, false)
>  
> -#define for_each_policy(__policy)			\
> -	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
> -
>  /* Iterate over governors */
>  static LIST_HEAD(cpufreq_governor_list);
>  #define for_each_governor(__governor)				\

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
