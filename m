Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694833A7B9C
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 12:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFOKTP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 06:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhFOKTO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 06:19:14 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C2EC061574
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 03:17:10 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id q25so12895830pfh.7
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 03:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6h4I6yAf/ZmEuN83050IQibbyGvSumdJkSCoPwudq6k=;
        b=QRT8CmRHnjfqWuMG4/oKad9h6kyatnVbFnFn7GehgelYF4tvCcPsQxb7CUEbXOyCUh
         WA7zwdofS8PTEHH5SaM0lsNH8NhDcprJS6S4ka4mrKwE06wYY6nW2Sm8UzPBMVGQ2LEb
         KAyYEA2H3SgI+hs0Bcy0cK7hgMUMvACScJ/Q3fstfR5WpZ0vgRWwKIqotHHUswbExLbY
         1H+Km+hC1nHeQHRs5iNSQZBIWcgSypVt4LvOaWOiiXno+fWs6otl+R6xfL0Mmt64MoDA
         GTY16p9nyTRaF18JeOs+pYoUa5V//9kVQlMxCZwsfizdPt8+WPbMIiMTbqOqD/z0Y7wT
         5LKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6h4I6yAf/ZmEuN83050IQibbyGvSumdJkSCoPwudq6k=;
        b=E4LSDzAdfcXQawXX6EDs3jy6AxetTEp2bOaQFdIy3GUwU/+KC8ohpmyopojWLPY4FT
         dgeCKVYT2GMJkK6nodtsu6sm5TGCqW0yCPimBMSSxbNviM0UukOi6Js+uA6w8mE/POH5
         CUpGe7XrIUVa9ydDxLTA6etgURRAXRFAuh5/SeX9oHJHRIvfYk4ddElznHwv7a1qOgTZ
         8jd7SkhzAepG8WNuHQDc0Vg/ejxH1VY2GdS7tp4EWKfoM72cS0Dl8mPztvASJZuvklyC
         TZfShCNvrT9Ujvyx4sZrzMh+h0hp7thcPSUcSCRCdgGw4nG56SlaxsG1/iL4Vf/43hxc
         LGXQ==
X-Gm-Message-State: AOAM530u3ch/i3HQAkJk9I7rz8xWvVfwhMhiyP42yEp53A64IcJO9DVj
        qSPCZp+7UHn0Zdfn9zEVRKZSkA==
X-Google-Smtp-Source: ABdhPJyCzlTtge14HF2OaXKKKtBRLIgyMGLh8VoDxSeL/Nr2/9ufTx3kutSzXRdFodM0Fu8vN050IA==
X-Received: by 2002:a63:cd16:: with SMTP id i22mr21367878pgg.251.1623752229443;
        Tue, 15 Jun 2021 03:17:09 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id p15sm2312795pjb.45.2021.06.15.03.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 03:17:08 -0700 (PDT)
Date:   Tue, 15 Jun 2021 15:47:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
Message-ID: <20210615101706.mabloqrmakeiwcf5@vireshk-i7>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-4-git-send-email-vincent.donnefort@arm.com>
 <20210614072835.z2tjoaffcflry7pk@vireshk-i7>
 <20210614133522.GA34061@e120877-lin.cambridge.arm.com>
 <20210615050211.5gpx4faha6heytad@vireshk-i7>
 <20210615084418.GA167242@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615084418.GA167242@e120877-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-06-21, 09:44, Vincent Donnefort wrote:
> The cpufreq_policy is accessed through percpu data. I originally tried to get it
> with cpufreq_cpu_get_raw(). But when we init the cpufreq driver (and by
> extension when we call em_dev_register_perf_domain()), the percpu data isn't
> updated yet.

Right.

> I guess the only way at that moment would be to propagate the cpufreq_policy
> pointer through the functions parameters, which is a bit cumbersome, especially
> as the EM can be used with devfreq as well and that em_dev_register_perf_domain()
> can be called from dev_pm_opp_of_register_em()
> 
> Would we be ok with that?

No.

You only talked about freq_table earlier and that's all I checked :)

> I could use em_data_callback as well ... but that doesn't change the fact some
> registration is going through dev_pm_opp_of_register_em() which has no knowledge
> about the cpufreq_policy. Doesn't look a better approach.

The point is that I don't want cpufreq to carry this for users, we
have EM today, tomorrow we may want to mark a frequency as inefficient
from somewhere else. The call need to initiate from EM core.

And this isn't a cpufreq only thing, but is going to be generic along
with other device types.

This is exactly why I asked you earlier to play with OPP core for
this. That is the central place for data for all such users.

If this information is present at the OPP table (somehow), then we can
just fix dev_pm_opp_init_cpufreq_table() to set this for cpufreq core
as well.

This is the sequence that is followed in cpufreq drivers today:

dev_pm_opp_of_cpumask_add_table();
dev_pm_opp_init_cpufreq_table();
dev_pm_opp_of_register_em();

What about changing this to:

dev_pm_opp_of_cpumask_add_table();

/* Mark OPPs are inefficient here */
dev_pm_opp_of_register_em();

/* This should automatically pick the right set */
dev_pm_opp_init_cpufreq_table();

Will this break anything ?

-- 
viresh
