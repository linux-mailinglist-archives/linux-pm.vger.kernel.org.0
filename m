Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4F625785C
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 13:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgHaL1i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 07:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgHaL0m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 07:26:42 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD8AC061239
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 04:26:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k13so2865136plk.13
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 04:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tH82aWUMA2UBnyH/sX2Mzmczxh4jcROvZV+v6BjFVRo=;
        b=VMIbLDRMLVktTIUf5zOOIdeqrwLw/V7tJr4rRKsS1JoGBJ4suScF0zyi0gT9tVpLrC
         0lbZBiw/vQDNteulBImtfq+TUOpnBVGJJMUe2LVFOt/Iuo1GUg67zn6rE2hqO1ORDqyr
         3EQUaprmf2kbt/cbgoqmqyE8C1aev6T+LMoAEDt5WWW/OXkazfVvq5D/n3CanLDTsDCX
         4hPMsJeJcQ6Mvnv7ZPUUJ9TAaApOTyW6vLz6pmpX109HfW33joz+K619BG9tXjGJlt1m
         TWULz0V7MTagWxrZynTRiXPxujWKXMxLwnH9q0In6SNZFrk2xoBqukRM8t5/2KhNTloH
         a8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tH82aWUMA2UBnyH/sX2Mzmczxh4jcROvZV+v6BjFVRo=;
        b=PAqit6l5Rj7iFYhddquaegTkZaYzfPsO5tvTUkzzIldN2CZQhG+CoeFkrIQw9Pv8uM
         jsIF34gnauX/goYbhrsa19QxVknCBhms19QYbeBhTLJCKrWuylZy3mlD5kuVQUDT07uX
         hTNBiGVA6nuWgDSMTt4vOL/WLyhrhdgvxlpLQdfP/aPMeqRn9PuHp53PvSyC40pmWyy8
         Ihw8R4WrE5DzvXo03LjHapuHPSVMipKGGYnaIgC/Adp1eWAXyXg/ZKzMun31kPNb6UKY
         hCuy4PJ2VjEmj6rOyl6JIpvNb1hJJWSnBvoyVt/oxiP1+zFHjvM4n0J5ybk+/4WUdnCG
         nong==
X-Gm-Message-State: AOAM533GOFrwIatnmQyOU3g1pt80z+19wwOSYRxHNyFWmMh3+JK99uFl
        ZOHTY5DzYkLD53P3qXV+isQaAQ==
X-Google-Smtp-Source: ABdhPJw7Qs9sAfIfxfyEUjotME5wfjebiejj1Z5GBugIjslzE7U6vI8f7h5B/OqApj9KB4CR3Arysg==
X-Received: by 2002:a17:902:bd06:: with SMTP id p6mr714908pls.255.1598873200817;
        Mon, 31 Aug 2020 04:26:40 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id v20sm7018867pju.14.2020.08.31.04.26.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 04:26:39 -0700 (PDT)
Date:   Mon, 31 Aug 2020 16:56:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>,
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
        Will Deacon <will@kernel.org>,
        Peter Puhov <peter.puhov@linaro.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [RFC 0/3] cpufreq: cppc: Add support for frequency invariance
Message-ID: <20200831112638.v6vyljefggptij2v@vireshk-i7>
References: <cover.1594289009.git.viresh.kumar@linaro.org>
 <20200709124349.GA15342@arm.com>
 <20200710030032.3yq3lqqybhy5m744@vireshk-i7>
 <CAKfTPtBpOdRSV0gb2CoC8J9GnuPiqZ+MbQLLc6NdSmjJhb0cgA@mail.gmail.com>
 <20200825095629.GA15469@arm.com>
 <20200827075149.ixunmyi3m6ygtehu@vireshk-i7>
 <20200827112740.GA9923@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827112740.GA9923@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-08-20, 12:27, Ionela Voinescu wrote:
> I don't see it as anyone registering for freq invariance, rather the
> freq invariance framework chooses its source of information (AMU, CPPC,
> cpufreq).

Yeah, either way is fine for me.

> > i.e. if CPPC registers for it first then there is no need to check
> > AMUs further (as CPPC will be using AMUs anyway), else we will
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Not necessarily. Even if AMUs are present, they are only used for CPPC's
> delivered and reference performance counters if the ACPI _CPC entry
> specifies FFH as method:
> 
>   ResourceTemplate(){Register(FFixedHW, 0x40, 0, 1, 0x4)},
>   ResourceTemplate(){Register(FFixedHW, 0x40, 0, 0, 0x4)},

Right.

> While I understand your point (accessing AMUs through CPPC's read
> functions to implement invariance) I don't think it's worth tying the
> two together.
> 
> I see the two functionalities as independent:
>  - frequency invariance with whichever source of information is valid
>    (AMUs, cpufreq, etc) is separate from
>  - CPPC's delivered and reference performance counters, which currently
>    are used in cpufreq's .get() function.
> 
> Therefore, taking each of the scenarios one by one:
>  - All CPUs support AMUs: the freq invariance initialisation code will
>    find AMUs valid and it will use them to set the scale factor;
>    completely independently, if the FFH method is specified for CPPC's
>    delivered and reference performance counters, it will also use
>    AMUs, even if, let's say, invariance is disabled.
> 
>  - None of the CPUs support AMUs, but the _CPC entry specifies some
>    platform specific counters for delivered and reference performance.
>    With the current mainline code neither cpufreq or counter based
>    invariance is supported, but the CPPC counters can be used in the
>    cppc_cpufreq driver for the .get() function.
> 
>    But with the above new functionality we can detect that AMUs are not
>    supported and expose the CPPC counters to replace them in
>    implementing invariance.
> 
>  - Mixed scenarios are also supported if we play our cards right and
>    implement the above per-cpu.
> 
> 
> I'm thinking that having some well defined invariance sources might work
> well: it will simplify the init function (go through all registered
> sources and choose (per-cpu) the one that's valid) and allow for
> otherwise generic invariance support. Something like:
> 
> enum freq_inv_source {INV_CPUFREQ, INV_AMU_COUNTERS, INV_CPPC_COUNTERS};
> 
> struct freq_inv_source {
> 	enum freq_inv_source source;
> 	bool (*valid)(int cpu);
> 	u64 (*read_corecnt)(int cpu);
> 	u64 (*read_constcnt)(int cpu);
> 	u64 (*max_rate)(int cpu);
> 	u64 (*ref_rate)(int cpu);
> }
> 
> I am in the middle of unifying AMU counter and cpufreq invariance through
> something like this, so if you like the idea and you don't think I'm
> stepping too much on your toes with this, I can consider the usecase in
> my (what should be) generic support. So in the end this might end up
> being just a matter of adding a new invariance source (CPPC counters).

Okay, if you have already started working on that, no issues from my
side. I can just get the relevant stuff from CPPC added once you
provide that layer..

> My only worry is that while I know how a cpufreq source behaves and how
> AMU counters behave, I'm not entirely sure what to expect from CPPC

Neither do I :)

> counters: if they are always appropriate for updates on the tick (not
> blocking),

The update stuff may sleep here and so I had to do stuff in the
irq-work handler in my patch.

> if they both stop during idle, if there is save/restore
> functionality before/after idle, etc.

This I will check.

-- 
viresh
