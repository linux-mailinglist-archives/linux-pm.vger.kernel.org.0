Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3341E285816
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 07:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgJGFTE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 01:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgJGFTE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2020 01:19:04 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494AFC061755
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 22:19:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h4so468663pjk.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 22:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ayGMg8h43lG7PbBqTH8iqf1Q66kPpyBldgC5Ro0D6M8=;
        b=G5cbNoRl9Gz+77Gjj21vI6W5SSUbGy9flyeg6kxobLbVaiGLTcBr9ER6WL7bZnUEWA
         Xzmk19xbrDdwr3ax06nRdYaE30ysp5i16L6k36Y41wX6NAkozvbxzhL2WANIXJrBVHZF
         60Nmd447wQiVnznC8cORn6OmJxoCy7v40Nk5IPRKu1DJ7YS4IZbOs17NoUAg+vwRBNBc
         11jFakeqz1kFmummy3mgoANFhzI+DJjKY38f3NXkyNrW5PI3SOhiqFZ8WIpvuzIYlnBg
         YDhDtgfX0oDpMf6AijVTf+hPPOfLzEfcTCqvFaQpn5cROjYuOdM4pnD314bwajil0hmm
         QNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ayGMg8h43lG7PbBqTH8iqf1Q66kPpyBldgC5Ro0D6M8=;
        b=J4omCsF/reiUDFaq02kGFsuUwLK6dZFY8ah/drh3EYLwEwTlEUO2liJd3ScHSzbwx3
         EmSob9MOtH39AczbFk4mfZzXfHxa+3nvq5N4dFRC++XDi5LpO4edmpsGRt5M6swyz510
         2YP+fs2SiCsDcwIi4jZ7ngaSEZC/GbulSaVgET9H56XB+jLjvvOXBqTGqLV6HGcXcTJ4
         jAMep5h0+ezIRSS0jzSiKN6W8KpONTFf7wD4XHrcFizM+BoFk03siAzL2bauHeTYynzS
         c/3G3vENiJBNW1mX6JXQsrk7hvoojj1VVy8fRsfIScJ0AkoklbOXc2rPXH35wGPapJjx
         +Akg==
X-Gm-Message-State: AOAM5325n0Cop1ui6GA0vk92k8YlmUAmHGn01HKmo1EI06zPSihTw1dO
        nVPcDVkp7/LY+PtU1sVPOSRVzA==
X-Google-Smtp-Source: ABdhPJw0AmrcCvj1IidFKL2G7Zx1qxG1/k3Tiba5CMBcvjISP4r66rueMQMCqlK+VkUlNy/sjIrrDw==
X-Received: by 2002:a17:90a:a595:: with SMTP id b21mr1324973pjq.95.1602047942767;
        Tue, 06 Oct 2020 22:19:02 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id k7sm765222pjs.9.2020.10.06.22.19.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 22:19:02 -0700 (PDT)
Date:   Wed, 7 Oct 2020 10:49:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: stats: Add memory barrier to store_reset()
Message-ID: <20201007051900.3t22s2gzbaedw2jb@vireshk-i7>
References: <4635763.B4JZuFUhXG@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4635763.B4JZuFUhXG@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-10-20, 21:43, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There is nothing to prevent the CPU or the compiler from reordering
> the writes to stats->reset_time and stats->reset_pending in
> store_reset(), in which case the readers of stats->reset_time may see
> a stale value.  Moreover, on 32-bit arches the write to reset_time
> cannot be completed in one go, so the readers of it may see a
> partially updated value in that case.
> 
> To prevent that from happening, add a write memory barrier between
> the writes to stats->reset_time and stats->reset_pending in
> store_reset() and corresponding read memory barrier in the
> readers of stats->reset_time.
> 
> Fixes: 40c3bd4cfa6f ("cpufreq: stats: Defer stats update to cpufreq_stats_record_transition()")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> linux-next material.
> 
> -> v2: Pair read and write memory barriers as appropriate.
> 
> ---
>  drivers/cpufreq/cpufreq_stats.c |   20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq_stats.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_stats.c
> +++ linux-pm/drivers/cpufreq/cpufreq_stats.c
> @@ -47,6 +47,11 @@ static void cpufreq_stats_reset_table(st
>  
>  	/* Adjust for the time elapsed since reset was requested */
>  	WRITE_ONCE(stats->reset_pending, 0);
> +	/*
> +	 * Prevent the reset_time read from being reordered before the
> +	 * reset_pending accesses in cpufreq_stats_record_transition().
> +	 */
> +	smp_rmb();
>  	cpufreq_stats_update(stats, READ_ONCE(stats->reset_time));
>  }
>  
> @@ -71,10 +76,16 @@ static ssize_t show_time_in_state(struct
>  
>  	for (i = 0; i < stats->state_num; i++) {
>  		if (pending) {
> -			if (i == stats->last_index)
> +			if (i == stats->last_index) {
> +				/*
> +				 * Prevent the reset_time read from occurring
> +				 * before the reset_pending read above.
> +				 */
> +				smp_rmb();
>  				time = get_jiffies_64() - READ_ONCE(stats->reset_time);
> -			else
> +			} else {
>  				time = 0;
> +			}
>  		} else {
>  			time = stats->time_in_state[i];
>  			if (i == stats->last_index)
> @@ -99,6 +110,11 @@ static ssize_t store_reset(struct cpufre
>  	 * avoid races.
>  	 */
>  	WRITE_ONCE(stats->reset_time, get_jiffies_64());
> +	/*
> +	 * The memory barrier below is to prevent the readers of reset_time from
> +	 * seeing a stale or partially updated value.
> +	 */
> +	smp_wmb();
>  	WRITE_ONCE(stats->reset_pending, 1);
>  
>  	return count;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
