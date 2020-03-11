Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3867A18118F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 08:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgCKHOs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 03:14:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44438 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgCKHOs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 03:14:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id 37so665963pgm.11
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2020 00:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mw6S/pbnwAl/4gHq+0211KpC3pYMBzh8ksLAFUs+aBM=;
        b=UvMJaRzYUO9DYoBR0o+X5bBDwPv/rSYwEtBLwzEMrsY+BhjlOdTgsgpo/GleUqyPml
         D4bQhM/ahfd11jTlFHS6yuAuX+BqXijrKIaRVHFB4tOgb9YU3vsu6lOQ45pcygBr+xCw
         VVK6cDiNsHD6Cv7ke0etX5BKLB9pUO/zEVAap8EcAwgRTeciucMXmuTQxkn3z7+v3CEY
         7pKb24mzhqkib/BhFwAs32uDb7DXF80Uj7T0VH3Wm8C/Qf6Oi8vOij/lKp81YydUgpWp
         2JnybcAND6oP6w9AX1++OI5E4a4hzljT8Ebh/kZ5WaQ1s1tt/SJgd4pI1ZGHdXV8IX1+
         6giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mw6S/pbnwAl/4gHq+0211KpC3pYMBzh8ksLAFUs+aBM=;
        b=HmzUYB90Jq2viDG/JyoCHkKmBEp2OOTTOdRwQ8CxRm+i9IojZR3XelRI5OVcAiu88o
         AFU2pVtoW2Peg6yjLcFUKfmXl5bLZNzgL0tucteLKDbm8F59svLTAh0PVpBZKZwdF6Nb
         sGi+D2qHiAZ3wCMMI4JE6L9H3FWgvDmmlcShOhkv1GW8BR/60syZhI/2rVBU/BcyUS0R
         pFTtxtg8yQwcye/1eH7JL+ia922ZSgj/xIBGjrgsxzvX3DXtNC0bEmUPDftWCMwXQdyU
         tzs7rgJ11J6wsyFH/4HylBA3548zZcCqp+PNA0tD9rfTzXdIh0yfT/3kqWPJZWAm7uKA
         7IUA==
X-Gm-Message-State: ANhLgQ20deKrbzqrWLh02fYFeGsCRP63nJN07r6lZ7w9bT4kKKMOjVBP
        INYiUqEch5RX0G8CaYi+2ZNWtl9VeUk=
X-Google-Smtp-Source: ADFU+vt7JMyNitahXVEbmux2l6p040H+M8FudiOWMcAFKNN+1XxEYWeH315nXIyX6eU8/X6QdD3L8w==
X-Received: by 2002:a63:ee02:: with SMTP id e2mr1489318pgi.183.1583910886647;
        Wed, 11 Mar 2020 00:14:46 -0700 (PDT)
Received: from localhost ([122.171.122.128])
        by smtp.gmail.com with ESMTPSA id l62sm35348525pgd.82.2020.03.11.00.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 00:14:46 -0700 (PDT)
Date:   Wed, 11 Mar 2020 12:44:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Use scnprintf() for avoiding potential buffer
 overflow
Message-ID: <20200311071444.ihuzc6n5x6pbmhbx@vireshk-i7>
References: <20200311071341.4339-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311071341.4339-1-tiwai@suse.de>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-03-20, 08:13, Takashi Iwai wrote:
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index f9bcf0f3ea30..94d959a8e954 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -90,35 +90,35 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>  	if (policy->fast_switch_enabled)
>  		return 0;
>  
> -	len += snprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
> -	len += snprintf(buf + len, PAGE_SIZE - len, "         : ");
> +	len += scnprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
> +	len += scnprintf(buf + len, PAGE_SIZE - len, "         : ");
>  	for (i = 0; i < stats->state_num; i++) {
>  		if (len >= PAGE_SIZE)
>  			break;
> -		len += snprintf(buf + len, PAGE_SIZE - len, "%9u ",
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ",
>  				stats->freq_table[i]);
>  	}
>  	if (len >= PAGE_SIZE)
>  		return PAGE_SIZE;
>  
> -	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
> +	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
>  
>  	for (i = 0; i < stats->state_num; i++) {
>  		if (len >= PAGE_SIZE)
>  			break;
>  
> -		len += snprintf(buf + len, PAGE_SIZE - len, "%9u: ",
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%9u: ",
>  				stats->freq_table[i]);
>  
>  		for (j = 0; j < stats->state_num; j++) {
>  			if (len >= PAGE_SIZE)
>  				break;
> -			len += snprintf(buf + len, PAGE_SIZE - len, "%9u ",
> +			len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ",
>  					stats->trans_table[i*stats->max_state+j]);
>  		}
>  		if (len >= PAGE_SIZE)
>  			break;
> -		len += snprintf(buf + len, PAGE_SIZE - len, "\n");
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
>  	}
>  
>  	if (len >= PAGE_SIZE) {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
