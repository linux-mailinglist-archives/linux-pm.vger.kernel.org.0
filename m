Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEB621AD32
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 05:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgGJDAg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 23:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgGJDAg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 23:00:36 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F599C08C5CE
        for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2020 20:00:36 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k5so1974760pjg.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2020 20:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x2Q65EzY9A+4WJ3/3xgyKC2pLQLOauk7fOikDEnLLU4=;
        b=GETUc2u39p7zUsL72Oq0XwZQlEW4m73isgdfB6vVv1Ss0Y1ukG1UVuZuCfEU2GjUjf
         iDhzCNv+q8CYc3fum11i2xf1arEQIpeaxepR5LKM9HT2hqaeNWhYGHxXnm+wh/fODrhx
         d9MpgNGBhu+C78hGnOu/oOn4aJ5j8YQywSglNskU5la3PTJg2E7DVpQcQ938EgjOIxGx
         7z++Zzk3H/qgdsNdOJGgja44weWdUbethNcvkBhQnxDV9zKEwHq05O2Ovy0YPno0sJPH
         ATYqPf+4jPueD+Z4NNE1FXoR4CCkfL5XWXkYj/FdWKIrC50uzI3a4z2+4wGDaBVZfdyI
         Ttpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x2Q65EzY9A+4WJ3/3xgyKC2pLQLOauk7fOikDEnLLU4=;
        b=o7ebr3iecoDM51Vv1LJyFKoysnI43QvPit+l9L991s3P2nz03ALuqUaxrPC3Pwkqcn
         wMCXk/QDGCzCQghyxz9TaY7M49x1NXWigsr9YKTDfd6SBrnOe2kSsZ9kbuSDl7k0McDb
         JLWQdTaF1LBBxYSLWeEQ5l/ikdPMMb2HmsrZ6URr8vHdhIYMxaTdLDqZLxhFHVwGSrND
         zQUcPMRNZQQph1Z2VGDX1QbaBfnDIZ+swplQkVdY4j58gb9sfwtuYEplGelR28eb1gbh
         b9kGPIG1IoqOMyWGnTgNSTqVrjb9AJVjcT4uwfzxRwCFcnpAcxrEFjE2PtKO00SlaxCC
         phtQ==
X-Gm-Message-State: AOAM530OFphxMpcXtETS8H843dHHw9cWBtCdOas0a3PtY7LlDabZOA8j
        Yo/QMTOJMELR4stxo5wUCrtBiw==
X-Google-Smtp-Source: ABdhPJzJbs8HynvxExYfLaLpk6jM+CJiUTM1pLP8kT49ZfV7ziWx8HZYwK+knJKvvfM5wbheEJB6SA==
X-Received: by 2002:a17:902:aa0c:: with SMTP id be12mr58339011plb.45.1594350035374;
        Thu, 09 Jul 2020 20:00:35 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id y17sm4141720pfe.30.2020.07.09.20.00.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 20:00:34 -0700 (PDT)
Date:   Fri, 10 Jul 2020 08:30:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Puhov <peter.puhov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC 0/3] cpufreq: cppc: Add support for frequency invariance
Message-ID: <20200710030032.3yq3lqqybhy5m744@vireshk-i7>
References: <cover.1594289009.git.viresh.kumar@linaro.org>
 <20200709124349.GA15342@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709124349.GA15342@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks for the quick reply Ionela.

On 09-07-20, 13:43, Ionela Voinescu wrote:
> I'll put all my comments here for now, as they refer more to the design
> of the solution.
> 
> I hope it won't be too repetitive compared to what we previously discussed
> offline.

> I understand you want to get additional points of view.

Not necessarily, I knew you would be one of the major reviewers here
:)

I posted so you don't need to review in private anymore and then the
code is somewhat updated since the previous time.

> On Thursday 09 Jul 2020 at 15:43:32 (+0530), Viresh Kumar wrote:
> I believe the code is unnecessarily invasive for the functionality it
> tries to introduce and it does break existing functionality.
> 
> 
>  - (1) From code readability and design point of view, this switching
>        between an architectural method and a driver method complicates
>        an already complicated situation. We already have code that
>        chooses between a cpufreq-based method and a counter based method
>        for frequency invariance. This would basically introduce a choice
>        between a cpufreq-based method through arch_set_freq_scale(), an
>        architectural counter-based method through arch_set_freq_tick(),
>        and another cpufreq-based method that piggy-backs on the
>        architectural arch_set_freq_tick().

I agree.

>        As discussed offline, before I even try to begin accepting the
>        possibility of this complicated mix, I would like to know why
>        methods of obtaining the same thing by using the cpufreq
>        arch_set_freq_scale()

The problem is same as that was in case of x86, we don't know the real
frequency the CPU may be running at and we need something that fires
up periodically in a guaranteed way to capture the freq-scale.

Though I am thinking now if we can trust the target_index() helper and
keep updating the freq-scale based on the delta between last call to
it and the latest call. I am not sure if it will be sufficient.

>        or even the more invasive wrapping of the
>        counter read functions is not working.

I am not sure I understood this one.

>  - (2) For 1/3, the presence of AMU counters does not guarantee their
>        usability for frequency invariance. I know you wanted to avoid
>        the complications of AMUs being marked as supporting invariance
>        after the cpufreq driver init function, but this breaks the
>        scenario in which the maximum frequency is invalid.

Is that really a scenario ? i.e. Invalid maximum frequency ? Why would
that ever happen ?

And I am not sure if this breaks anything which already exists,
because all we are doing in this case now is not registering cppc for
FI, which should be fine.

>  - (3) For 2/3, currently we support platforms that have partial support
>        for AMUs, while this would not be supported here. The suggestions
>        at (1) would give us this for free.

As both were counter based mechanisms, I thought it would be better
and more consistent if only one of them is picked. Though partial
support of AMUs would still work without the CPPC driver.

-- 
viresh
