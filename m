Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56533A941D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 09:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhFPHhN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 03:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhFPHhK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 03:37:10 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D5AC061574
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 00:35:04 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id m2so1255753pgk.7
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 00:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LsOsXn5RKI2yCt+p5QwjpHHKJ3IatRdDF49oEr4EgNU=;
        b=kGqDFqZBN1NOzFNiTA9XWVUPKNmsSDVSXi3spwwOoaFPDPcqnKo6idGP7VX2XutiPu
         ZndxhtjS7pXx4wDDsr+0Y4di21DyDF5/t3G/WZDXEO1rxns1n0X4M/fTTPCe7BNUkLnB
         IY/JmJ94se3kQbbClh36u8P/6NqZUH0YqVYyUBKBQX2yRQ4BU7YK2hKamFF+gFtgTuoA
         VzQHOHhg1xCmVENTA/dEVf3lUgpvAEqsIbgIQDlGjdhe6kxEtZ+uxALHa6JhEfGnAukd
         A8QKc16UABx85c1AbcB9tL4GSq/PmGsjEx1MAkd88GI9Y7q0MFgoWQQPoyoRDgu77Nk4
         fHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LsOsXn5RKI2yCt+p5QwjpHHKJ3IatRdDF49oEr4EgNU=;
        b=Nmw/csigpzdgrs29R/NCeniNVEP2YbAdZkB4sZefMuIHErB/7jvuwlKVf+REeJcfNE
         1g6Pm0nRArsHP37IdqOAX69hc2m+Rw3gcWHs+MQxHDwAynVSePn5VIOr50AUMQzy4pTO
         ZZ125j3SUml6fdrsmAUt5YmS8I/A6HsE4tvyWT3nL92GkQ9fFDfoWQcMwgk5Rd5sgKZp
         g3xhP7Iuq4MSdNhAl0v70lkaoXSqlUbKTpW6WZnjPm+pHnYNnZc9BXhfpjpqQcbhUG1V
         7658rYq1DF2QE/dYdJb1bq9N23n5G39W6/qRiQ5AoXugUcWjcRZRjz/FMgCycz+zOtG6
         7/gw==
X-Gm-Message-State: AOAM533aqgON09CM+SpR2a5IdG5iX4Hu/gL81cXE+oP3dTR8AoFEkM+F
        HKyrJehmnLmri7LyvY9JDkFcQw==
X-Google-Smtp-Source: ABdhPJw8cb4vhpLrx1b9jKyfshUIwaboQRtkzvMDIU5kDN24evu4wyZUQiO7qmtjaYJNZCJShpS+wA==
X-Received: by 2002:a63:d40d:: with SMTP id a13mr3652782pgh.382.1623828904347;
        Wed, 16 Jun 2021 00:35:04 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id x8sm4657931pje.52.2021.06.16.00.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 00:35:03 -0700 (PDT)
Date:   Wed, 16 Jun 2021 13:05:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
Message-ID: <20210616073500.b5wazdssoa5djp5o@vireshk-i7>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-4-git-send-email-vincent.donnefort@arm.com>
 <20210614072835.z2tjoaffcflry7pk@vireshk-i7>
 <20210614133522.GA34061@e120877-lin.cambridge.arm.com>
 <20210615050211.5gpx4faha6heytad@vireshk-i7>
 <20210615084418.GA167242@e120877-lin.cambridge.arm.com>
 <20210615101706.mabloqrmakeiwcf5@vireshk-i7>
 <20210615171530.GA277695@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615171530.GA277695@e120877-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-06-21, 18:15, Vincent Donnefort wrote:
> On Tue, Jun 15, 2021 at 03:47:06PM +0530, Viresh Kumar wrote:
> > The point is that I don't want cpufreq to carry this for users, we
> > have EM today, tomorrow we may want to mark a frequency as inefficient
> > from somewhere else. The call need to initiate from EM core.
> 
> In the current version of this patchset, any driver can mark inefficiencies
> without relying on the EM, just by adding the flag CPUFREQ_INEFFICIENT_FREQ in
> cpufreq_frequency_table.

Yeah, I wasn't really talking about cpufreq drivers but external
entities, like EM.

> Populating cpufreq_frequency_table from the EM in cpufreq was just an attempt to
> a less intrusive set of changes.
 
> > And this isn't a cpufreq only thing, but is going to be generic along
> > with other device types.
> > 
> > This is exactly why I asked you earlier to play with OPP core for
> > this. That is the central place for data for all such users.
> > 
> > If this information is present at the OPP table (somehow), then we can
> > just fix dev_pm_opp_init_cpufreq_table() to set this for cpufreq core
> > as well.
> > 
> > This is the sequence that is followed in cpufreq drivers today:
> > 
> > dev_pm_opp_of_cpumask_add_table();
> > dev_pm_opp_init_cpufreq_table();
> > dev_pm_opp_of_register_em();
> > 
> > What about changing this to:
> > 
> > dev_pm_opp_of_cpumask_add_table();
> > 
> > /* Mark OPPs are inefficient here */
> > dev_pm_opp_of_register_em();
> > 
> > /* This should automatically pick the right set */
> > dev_pm_opp_init_cpufreq_table();
> > 
> > Will this break anything ?
> 
> Probably not, but with this approach I'll have to modify all the cpufreq drivers
> that are registering the EM, which I tried to avoid as much as possible so far.

Hmm. You are right as well, but I just want to get the right API in
place which lives a longer life :)

> But if we sum-up:
> 
> 1. em_dev_register_perf_domain() find inefficiencies
> 
> 2. dev_pm_opp_of_register_em() apply EM inefficiencies into the OPP structures

I was looking to add a new API to the OPP core
(dev_pm_opp_mark_inefficient()) to mark an OPP inefficient. And then
get it called from em_create_perf_table().

But I now see that EM core rather has callbacks to call into and with
that I think you should rather add another callback
(.mark_inefficient()) in struct em_data_callback, to set inefficient
frequencies.

>    Note: scmi-cpufreq would need special treatment, as it doesn't rely
>    dev_pm_opp_of_register_em().

For both dev_pm_opp_of_register_em() and scmi case, you can then set
this callback to dev_pm_opp_mark_inefficient().

> 3. dev_pm_opp_init_cpufreq_table() marks the cpufreq table with the OPP
>    inefficiencies 

Yes.

> Guess it would ease the adoption by other OPP clients. However this patchset
> will clearly get bigger.
> 
> Would you agree with that?

Yes, it is fine.

-- 
viresh
