Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740BFE18F7
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 13:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404627AbfJWLZp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 07:25:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41530 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404612AbfJWLZn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 07:25:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id t3so11965456pga.8
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2019 04:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CMbUesWrEBI4umlhGm4RX5JKBMDct6YIIfX5NPakVec=;
        b=F59zCQmMZ8PGnVxppmEJ1cQ9+Ru2hgprfou80/UTpJDSpK/s5dEAh4fD0/KLRESMQV
         9fpsdghcO2ZIyAkWok4ZGaXXaJqeaFuASZSO7kJeaBKkdNq8QhLvxHvMyNxFBrUbXgKr
         uwp0BAgyf7Urc40k1QC0scuLSc6ch3y4cwaUJdUjQgWgEFNObAc5NVKdC13CNQlkrmgq
         yDSOSVsud0Hz/Vj3vS4Tga6CQH1nqR1eoOnBKvsC7768baqyYK65HpPPC2jOOE/e4oug
         a9aOQLaeqKIIbbmnyXoWhHbGZkIhALc3EuQM8FQ6NhKblgzipTEE+45RlvpSP18ETm33
         FvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CMbUesWrEBI4umlhGm4RX5JKBMDct6YIIfX5NPakVec=;
        b=hw7VaTnfM6RBZoXIvSoPPXbaT9a8Si8AUxy7WUp7rwWgMjGTNZNPB2I9ognLbw1wKq
         xFiY+ldMx3AlSi4PzmmwiFb7MPEL9l39gRGGiAgt36pk5f4kFAEXXhz+aLutxFkNF9jN
         W9x5Y+JsoKXYWKuaqVyMvLWD34LcTA5MsXVFHacmwMppZ24boPwRZYQf7DHY0vhLI1iM
         bQLzAgva9G9/CllklLQjZP9qJgm73G/fTEgTRH0+hW9QELwb5wDSmzH6mwH7rGd2VDD1
         WqtxbudRks7fitbec9GGlONIPKVf+h6zOrpwDRQWd3uFYQOTPZRzWSdg4g1GRyDoBLNE
         /a7w==
X-Gm-Message-State: APjAAAUnJP5KXPnxjvqcV/SpM+2p3Tldz4v78CdpVm/NURxEW+QdyILD
        cuvEwk25wUQy2LGSOhA51vThYw==
X-Google-Smtp-Source: APXvYqzxhzsRny5uh2R2JdrXKYiUCBZlYE60w6K6/wJCw7cMH69UZFHcridk5yb6oiGxufLe6QDfIw==
X-Received: by 2002:a63:b5b:: with SMTP id a27mr9661769pgl.262.1571829941207;
        Wed, 23 Oct 2019 04:25:41 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id j11sm11855535pgk.3.2019.10.23.04.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 04:25:40 -0700 (PDT)
Date:   Wed, 23 Oct 2019 16:55:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: vexpress-spc: find and skip duplicates when
 merging frequencies
Message-ID: <20191023112537.pywnhihvmokcveeu@vireshk-i7>
References: <20191023110811.15086-1-sudeep.holla@arm.com>
 <20191023110811.15086-2-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023110811.15086-2-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-10-19, 12:08, Sudeep Holla wrote:
> Currently the cpufreq core aborts the validation and return error
> immediately when it encounter duplicate frequency table entries.
> This change was introduced long back since commit da0c6dc00c69
> ("cpufreq: Handle sorted frequency tables more efficiently").
> 
> However, this missed the testing with modified firmware for long time.
> Inorder to make it work with default settings, we need to ensure the
> merged table for bL switcher contains no duplicates. Find the duplicates
> and skip them when merging the frequenct tables of A15 and A7 clusters.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 35 ++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
> index 093ef8d3a8d4..921dbd42b3bb 100644
> --- a/drivers/cpufreq/vexpress-spc-cpufreq.c
> +++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
> @@ -242,6 +242,19 @@ static inline u32 get_table_max(struct cpufreq_frequency_table *table)
>  	return max_freq;
>  }
>  
> +static bool search_frequency(struct cpufreq_frequency_table *table, int size,
> +			     unsigned int freq)
> +{
> +	int count;
> +
> +	for (count = 0; count < size; count++) {
> +		if (table[count].frequency == freq)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int merge_cluster_tables(void)
>  {
>  	int i, j, k = 0, count = 1;
> @@ -256,13 +269,21 @@ static int merge_cluster_tables(void)
>  
>  	freq_table[MAX_CLUSTERS] = table;
>  
> -	/* Add in reverse order to get freqs in increasing order */
> -	for (i = MAX_CLUSTERS - 1; i >= 0; i--) {
> -		for (j = 0; freq_table[i][j].frequency != CPUFREQ_TABLE_END;
> -		     j++, k++) {
> -			table[k].frequency =
> -				VIRT_FREQ(i, freq_table[i][j].frequency);
> -		}

I think we can still use this single loop, which already starts from
A7 cluster. Just that we can add an if (A15) block inside it as the
first line.

> +	/* Add A7_CLUSTER first to get freqs in increasing order */
> +	for (j = 0; freq_table[A7_CLUSTER][j].frequency != CPUFREQ_TABLE_END;
> +	     j++, k++) {
> +		table[k].frequency =
> +			VIRT_FREQ(A7_CLUSTER, freq_table[A7_CLUSTER][j].frequency);
> +	}
> +	count = k;
> +
> +	/* And then A15_CLUSTER checking for duplicates */
> +	for (j = 0; freq_table[A15_CLUSTER][j].frequency != CPUFREQ_TABLE_END;
> +	     j++) {
> +		if (search_frequency(table, count,
> +				     freq_table[A15_CLUSTER][j].frequency))
> +			continue; /* skip duplicates */
> +		table[k++].frequency = freq_table[A15_CLUSTER][j].frequency;
>  	}

How many duplicate entries are there anyway in the firmware? Or do we
really need to make it that generic? I mean, only the last of A7 and
first of A15 should be overlapping, in that case why search entire
table again ?

>  
>  	table[k].driver_data = k;
> -- 
> 2.17.1

-- 
viresh
