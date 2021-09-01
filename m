Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DCF3FD2E4
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 07:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241855AbhIAFbW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 01:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhIAFbW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 01:31:22 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43180C061575
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 22:30:26 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id e7so809467plh.8
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 22:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0a8DV4NTJtAQbJ1ji6wGX17sRDh9lg64UlvcJCPKmSY=;
        b=MFvl+/io46/0aTMEdmoQnqMwIyg0rDg6FTQpYkt0aAsMkffWwjIQtpQuNpNuFVB0oP
         BLLOBKdkpj9GkG7u0BbnUZtKdaCMCTN6AC2Oit9nbQFeRWa7Tml91m5wHNgU5QU9l8hk
         hXmkR+V0HnwqBE3nE23MoEy6BoXwgMK4jlRpp5kMg9/v+PwyIUjeQhLh7Y8BKo/tqsEj
         +DP63pQt3t0kPVVTCIeNtUPCTl8uHY4+eGN9o1cL38YIqPEQH9WTMRd/eoxf6/IQ8pvw
         X80Dgl1jJo/Ds2d1GGofN7j09S25b/NWWC6KBdXk2pzUuMpAcI756ZBRU7Cn3ra0oaxl
         rmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0a8DV4NTJtAQbJ1ji6wGX17sRDh9lg64UlvcJCPKmSY=;
        b=e9kedZw8rYmcQz/MdqzO9S1q2h0JRoyG/JRujjbWDRpl+Uu91sABrmTyrSsmr2ek//
         vhmWQsazSU9WkruRvAirmTR+nRW+9/l6GKNTWb5Og2911+oo3wBJkhFjoq6pdATgjzer
         7GNX/w/HGaKbhAQaMf67Gt3SEZUEY8GuXCP81vUP8QSRhawCVhONoNQbvUYU2Bp7v7nR
         gFtBQvZrDv/OoPwDCZs5QuQjU+NBkwI+L7zty62jCi3QC/P2oglmVQBOR++PEU5Je99l
         Rf9WMYiA2uPu58xgdCnbJzsU+4mh+3NkjFLYqFUanuJb7cqLyIhtJJArpuNpk1P0am3a
         1H4w==
X-Gm-Message-State: AOAM533XyMyD7r/NdeGGtPpB9x/gs4b0QxS3aZjIrbDMmyQndG7pcTpy
        JC8dmIUVWejiTBZOmdZ5RM3VuA==
X-Google-Smtp-Source: ABdhPJy6V+rys7YKPEFArqlTE8Tw8Cde+f5YINqmCw/VPP2rUjdg9Y7IWRkajXd52bP90+RJ8H9yzA==
X-Received: by 2002:a17:903:11c3:b0:138:f348:4340 with SMTP id q3-20020a17090311c300b00138f3484340mr4751737plh.84.1630474225776;
        Tue, 31 Aug 2021 22:30:25 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id n15sm19861794pff.149.2021.08.31.22.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 22:30:25 -0700 (PDT)
Date:   Wed, 1 Sep 2021 11:00:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org
Subject: Re: [PATCH v6 6/7] cpufreq: Skip inefficient frequencies
Message-ID: <20210901053023.yg4pbmqsgbmvo2qa@vireshk-i7>
References: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com>
 <1630405453-275784-7-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630405453-275784-7-git-send-email-vincent.donnefort@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31-08-21, 11:24, Vincent Donnefort wrote:
> +static inline bool

I would drop the inline part here.

> +cpufreq_can_skip_inefficiencies(struct cpufreq_policy *policy)
> +{
> +	struct cpufreq_frequency_table *pos;
> +	bool valid = false;
> +	int idx;
> +
> +	if (!(policy->governor->flags & CPUFREQ_GOV_DYNAMIC_SWITCHING))
> +		return false;
> +
> +	if (policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED)
> +		return false;
> +
> +	/* Is there at least one inefficiency ? */
> +	cpufreq_for_each_valid_entry(pos, policy->freq_table) {
> +		if (pos->flags & CPUFREQ_INEFFICIENT_FREQ) {
> +			valid = true;
> +			break;
> +		}
> +	}
> +
> +	if (!valid)
> +		return false;
> +
> +	/*
> +	 * Has cpufreq_table_update_efficiencies been called? i.e. is the
> +	 * highest frequency efficient.
> +	 */
> +	cpufreq_for_each_valid_entry_idx(pos, policy->freq_table, idx) {
> +		valid = !!(idx == pos->efficient);

I don't think !! is required here. == already returns a bool.

> +		if (policy->freq_table_sorted ==
> +					CPUFREQ_TABLE_SORTED_DESCENDING)
> +			break;
> +	}

-- 
viresh
