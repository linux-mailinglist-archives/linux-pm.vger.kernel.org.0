Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA3ED2102
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 08:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732821AbfJJGt0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 02:49:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46936 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfJJGt0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 02:49:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id q24so2280456plr.13
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2019 23:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j46NH305ztFTvNldakMciV5IclJCb8SSWiPljO6b3kk=;
        b=DNSz30prMMmDYikaWcMI7vY6U34PpQpor/YtlS9khiab5CAitsrnHXGoROOOWCZGHp
         dBrvgsQt7sfQFLiuddP5vwDzofpUykmDbhuI9mRO8UEbaFxTJ2i1jh20koKDUNWuoBJF
         HUirJErzLVeVhJ/xPjkGH93CbCzwtog4xAyPQz4bXQ9dADQUlvy5oyAF4PBo4rQZqbJk
         VKawBO9y1BSRGtJduz73+hHmlRzk9FXXjqXikgZv4YobtdDx/MUo1/sJ6FU/WgvnQyui
         IdmNrThDC9v7i4DQPvGovN6J2EARMBDxGm1dlFbkmAEzb1IMy+7+CY4r0IKBFwZO0V7l
         x7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j46NH305ztFTvNldakMciV5IclJCb8SSWiPljO6b3kk=;
        b=cmb6Tq35a/6F9ro0wBu6cGVweroW8kEasCTdRh02Zp7NEFaHqwfa2fE0OiujN/qg9h
         W4D+7yOvuXuF5DKLqXOeGeLkfMbnSsMkLG2eypf9eLUHpvzUqwsnqSSh/flUdsAosnR8
         xQNQLNOH3v6lZ2yU+PjKy/a3U0pWGXNvUNg4N4VYyTmi6sMOeUw3BeXbPzZ76l1WfQqD
         yPQpJBAspC7nN5xUst4EQOtq2qa8AXoq5V42V5iXW3t9SYr1i6lzTdv6c2C+HgnbgBe0
         cW1APVkgeZ/a8Cz4XlXMtk88i2g3B8DsKdKcns/RgtNvYr8cQQWTT6Vqv5pfjUJRhfHC
         mwNA==
X-Gm-Message-State: APjAAAWp57TiB9kzO30WCRuK/1TKzY+abfR+RcjispE96vVNw+MgtKww
        GGGBucCiglHWe/Jh3qoIXoaWyQ==
X-Google-Smtp-Source: APXvYqw8ag57XreRLnPesI1psh9D80BWE920D0Opy7kfMSFO0Cqu2BPwsk2IGyYe+B6HYjkrXvwi2w==
X-Received: by 2002:a17:902:ac85:: with SMTP id h5mr8046714plr.44.1570690165268;
        Wed, 09 Oct 2019 23:49:25 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id p88sm3999484pjp.22.2019.10.09.23.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 23:49:24 -0700 (PDT)
Date:   Thu, 10 Oct 2019 12:19:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq/cpufreq_governor: Fix memory leak in
 cpufreq_dbs_governor_init
Message-ID: <20191010064917.4lsyd5zhwlfbql3d@vireshk-i7>
References: <20191009232643.20427-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009232643.20427-1-navid.emamdoost@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-10-19, 18:26, Navid Emamdoost wrote:
> In the implementation of cpufreq_dbs_governor_init(), dbs_data is
> allocated and later is assigned to governor_data. But before that
> assignment, if gov->init() fails this allocation is not released.
> dbs_data should be released in case if gov->init() failure.
> 
> Fixes: 714a2d9c8792 ("cpufreq: governor: split cpufreq_governor_dbs()")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 4bb054d0cb43..deb099d36266 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -428,8 +428,10 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>  	gov_attr_set_init(&dbs_data->attr_set, &policy_dbs->list);
>  
>  	ret = gov->init(dbs_data);
> -	if (ret)
> +	if (ret) {
> +		kfree(dbs_data);
>  		goto free_policy_dbs_info;

Maybe add another label right before kfree() at the bottom and jump there
instead. We wanted to share code in the error path.

> +	}
>  
>  	/*
>  	 * The sampling interval should not be less than the transition latency
> -- 
> 2.17.1

-- 
viresh
