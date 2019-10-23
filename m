Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50B22E1088
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 05:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbfJWD0M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 23:26:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38853 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbfJWD0M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 23:26:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3so11247999pgt.5
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2019 20:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/UlXYMZppBsSqe1vUiYDqERsW7xBrjIEOgZPw2HevXQ=;
        b=Of993IQqMLC66eF00w8dmizT/a6HT3ZI87pGzsxKyvSWD+kCvdW4DiBN4LmAPwUc06
         IxuBFUqjFceVK5QoPCC8AGawzgTctgoOMQeMdOGiLUG8e96xxVu9xODLI6bade4ALOq5
         UpgTGh5csfvIeadwi9tSJXsYtXMAOqcrW7QUGlPUIKgOa4T4g3vBv2JBh01ORZyabaTX
         8Kq4npb/1KrvUN7ZRyB2kgXtod30n4cYXnFQf7IXLRQ2XGYKQS6V0wLRhz9oJsfyOPp9
         LQwI+7HhvF4fxvXGDdB04OmFg0Y+yUoHcJT7fKdNR8sSSrrelmRi7YvX8+dNTTEkbzvs
         gbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/UlXYMZppBsSqe1vUiYDqERsW7xBrjIEOgZPw2HevXQ=;
        b=cVOHXZ4LhJjEk2vQWB61p4ccRVEVVWMuETTBd+DJa4UvFszF0X93WCgDL5VHYiiFrn
         /PCIGxUea7fKMQQ3/MyboWl9v8QokjS2/3y7Fksb7g+KJTUrcZR9GsvefmJG7mmSlO2G
         BJ0TaL0NK8iza8JIUG1jaiIJmctmL/tXo/+jXa+kN8MnR0xZaZiHnb84rHyjVFtmS0DC
         9pGAK2SUTARaaq33pMmELdjV1Tb4ruLB3XrB3ypMKpNTzs0n9x8+RvSDAHP0AcxCA3ZV
         4JMwqD/WHQ5Ipu3zjGbbx4VoFy/6ziDKQt1K18R2NBEhdNeg5BR14erTwfnjVvRmaHjZ
         M5nQ==
X-Gm-Message-State: APjAAAU/FzSfJo72rEfX3XthA9kXa5ZwoMJQ4uJfTNcvrdjQt/DP/uDM
        AwBqv/3PDOQLyFy6jM/wSWd3vQ==
X-Google-Smtp-Source: APXvYqynLoFjILHM41lE+4jb0UI2aJV2uE0h4ShZERIOG33lA0L4lJ6LJkceyIhhirWA25OIYT9srQ==
X-Received: by 2002:a17:90a:6283:: with SMTP id d3mr8926771pjj.27.1571801171251;
        Tue, 22 Oct 2019 20:26:11 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id a20sm16271438pjs.30.2019.10.22.20.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 20:26:10 -0700 (PDT)
Date:   Wed, 23 Oct 2019 08:56:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] cpufreq: mark duplicate frequencies as invalid and
 continue as normal
Message-ID: <20191023032608.v7lgqirvpbwgsyz4@vireshk-i7>
References: <20191022173215.13350-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022173215.13350-1-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-10-19, 18:32, Sudeep Holla wrote:
> Currently if we encounter duplicate frequency table entries, we abort
> the validation and return error immediately. Instead of failing, we
> can mark the entry as invalid and continue to function normal.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/freq_table.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Hi Viresh,
> 
> Since commit da0c6dc00c69 ("cpufreq: Handle sorted frequency tables more
> efficiently"), I seem to have modified the firmware entry on my TC2 to
> drop 500MHz and had not seen the issue with duplicate entries and had
> totally forgotten about it.
> 
> Recently I reverted back to original setting as I corrupted it and
> started seeing this issues. I don't know the background for raising
> duplicates as fatal error but we did allow it when we add arm_big_little.c
> and hence this RFC. If there are known issues with this approach, I can
> continue with changed firmware config.
> 
> With switcher, we have:
> (little cluster)
> Virt: 175 MHz, 200 MHz, 250 MHz, 300 MHz, 350 MHz, 400 MHz, 450 MHz, 500 MHz
> Actu: 350 MHz, 400 MHz, 500 MHz, 600 MHz, 700 MHz, 800 MHz, 900 MHz, 1000 MHz
> (big cluster)
> 500 MHz, 600 MHz, 700 MHz, 800 MHz, 900 MHz, 1000 MHz, 1.10 GHz, 1.20 GHz
> 
> with 500 MHz duplicate in merged table.
> 
> Regards,
> Sudeep
> 
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index ded427e0a488..e9bf287846d6 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -305,9 +305,10 @@ static int set_freq_table_sorted(struct cpufreq_policy *policy)
>  		}
>  
>  		if (pos->frequency == prev->frequency) {
> -			pr_warn("Duplicate freq-table entries: %u\n",
> +			pr_warn("Duplicate freq-table entries: %u marking it invalid\n,",
>  				pos->frequency);
> -			return -EINVAL;
> +			pos->frequency = CPUFREQ_ENTRY_INVALID;
> +			continue;
>  		}
>  
>  		/* Frequency increased from prev to pos */

Of course we can do this, but I don't see why we shouldn't force
people to fix the freq-tables instead. What's the point of allowing
people to have duplicate entries instead ? This shouldn't happen with
OPP tables as we check for duplicate entries there as well.

-- 
viresh
