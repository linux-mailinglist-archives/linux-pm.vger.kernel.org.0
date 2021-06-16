Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471163A9829
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 12:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhFPKzg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 06:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhFPKzf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 06:55:35 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30940C061574
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 03:53:30 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id i34so1630138pgl.9
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 03:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FexP6Xz/QQGXJHiLL9q2XNs3uh5luq4ZebsXEDLzrnM=;
        b=xQOUEZQdPZatFvPp6H5fD0tADd2PM4WxNBauF8hz6y9uC6ttHEtJ5hXXLldipRUHEY
         e2Kb0N3XYFWIyFta8Zh1WEETkRsYzJEn06/pMQrTMbXJUAlXBa12+7OcpJ4boegjqCk0
         xGb5l3EVvgZ/ABD/AP52sFTaztc1pM1cp4goVsGRKZBHEnO7vQ3uxx/N1Kb4MRSIVwkz
         Hvxcsz/4OpjAc7SzzYzH/mAPfN5an0SwLTCr7egMul2EqVX7onQ0SI6rKOXIYiK2OCFm
         gCINLVlq+apeBZRBf4SFKbzoiqrejzeD/ALdTzKcr61ez962fvluxpwMdoUQoRNQYz1N
         AMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FexP6Xz/QQGXJHiLL9q2XNs3uh5luq4ZebsXEDLzrnM=;
        b=EuhqyA2bBho45+ApE7Z2Jf7tXiXZoPUJJQSvGFnrTSqjrKenm61fwr0lGklxgOPPE7
         AO+G1YfgfdEv3A/OxWWdQ9kl1hGSxbusQh/1DH+WJFXNBUnBrk5JyV4bKy+nxRvIzB6p
         dGla2ji2D9Rnyr36S24b6Hzf/YPpilbuIQ8wAQ8tW7NmzH6JPb0qjxTRkqEcJbWGYydh
         5CvhkDGsRns2syCsNOjwUxOUe2tdpqaWeq4wzxTyHO4EwDg5qGUx1bgt9g7g5nt5GENX
         CZIwhdnN1MLzCVdAFAD2HxpE5LXcPFL10908nYHFYVMxuXAFhZUd8LgyoUeHwE6m3ZVU
         jB/Q==
X-Gm-Message-State: AOAM531kFX5DDzhS3TFDZTP8fTmf0FgbaLWH6zwykUAbOdvYTqFphJUg
        rZ6eORftRY3ENwT4+z/rglG+mg==
X-Google-Smtp-Source: ABdhPJzBBywnA564Cpi85yUvQr51763iQANmsukWoPMsIquwpcybVAdimcVVn6QtsNVLZkf5DhT1Qg==
X-Received: by 2002:a62:bd14:0:b029:2de:8bf7:2df8 with SMTP id a20-20020a62bd140000b02902de8bf72df8mr8671158pff.60.1623840809587;
        Wed, 16 Jun 2021 03:53:29 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id q21sm1965970pfn.81.2021.06.16.03.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 03:53:29 -0700 (PDT)
Date:   Wed, 16 Jun 2021 16:23:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
Message-ID: <20210616105327.wnppsau4gg5ihrlv@vireshk-i7>
References: <20210614072835.z2tjoaffcflry7pk@vireshk-i7>
 <20210614133522.GA34061@e120877-lin.cambridge.arm.com>
 <20210615050211.5gpx4faha6heytad@vireshk-i7>
 <20210615084418.GA167242@e120877-lin.cambridge.arm.com>
 <20210615101706.mabloqrmakeiwcf5@vireshk-i7>
 <20210615171530.GA277695@e120877-lin.cambridge.arm.com>
 <20210616073500.b5wazdssoa5djp5o@vireshk-i7>
 <a4971ab0-87d7-4457-49ec-ce20106be358@arm.com>
 <20210616093127.lfpi4rje56b3dhwx@vireshk-i7>
 <ff9a9daa-7d25-ea08-2cd9-fc56f778acde@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff9a9daa-7d25-ea08-2cd9-fc56f778acde@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-06-21, 11:33, Lukasz Luba wrote:
> On 6/16/21 10:31 AM, Viresh Kumar wrote:
> > On 16-06-21, 10:03, Lukasz Luba wrote:
> > Clean is not lesser number of lines for me, but rather having the
> > right ownership of such things.
> 
> Some developers do like patches which removes more lines then adds ;)

:)

> > 
> > For example this patch:
> > 
> > https://lore.kernel.org/linux-pm/1622804761-126737-6-git-send-email-vincent.donnefort@arm.com/
> > 
> > tries to add EM stuff in cpufreq core. Cpufreq core doesn't care about
> > EM and it shouldn't. And this piece of code doesn't belong here.
> > 
> > Would you guys like to add a cpufreq specific call into the EM core? I
> > won't, that's not a place for cpufreq stuff. It is the EM core. I was
> > fine with not including OPP core into this, and I gave up that
> > argument earlier, but then we realized that the cpufreq core isn't
> > ready at the time we register with EM core.
> > 
> > Honestly, OPP core looks to be a better place holder for such stuff.
> > This is exactly the purpose of the OPP core. Moreover, we can apply
> > the same logic to devfreq or other devices later, with or without EM
> > core. Again, OPP core fits better.
> > 
> > The cpufreq core already has the relevant APIs in place to the OPP
> > core and this won't require a new API there.
> 
> I don't see an API function in the OPP framework or a field in the
> OPP struct which gives information that this freq is inefficient.
> Thus, it will require new API changes: cpufreq --> OPP.

dev_pm_opp_init_cpufreq_table() is all we need here, we just need to
change it to update one more field in the cpufreq table's entries.

> > 
> > > Let's don't over-engineering. The inefficient information is only valid
> > > for schedutil, thus IMHO it can live like this patch set made - in the
> > > cpufreq table.
> > 
> > For now, yes. There is no guarantee though that we won't have more in
> > future.
> 
> And there won't be in near future. We don't build massive interfaces
> because there *might* be potential *oneday*.

Yes, true.

> Even for this idea, it was a massive work to do the research and prove
> it that this is worth to put mainline so all vendors will get it.
> 
> The GPUs are slightly different beasts and they have different
> workloads (not util + SchedUtil driven AFAIK).

Right, but even if there is a single user for this, I think getting
this through the right layers is a more cleaner solution.

> In v1 there was LUT.

Oops, yes, I started looking from V2 and not V1.

> IMHO we have too easily gave and said:
> 'Remove the Look-up table as the numbers weren't strong enough to justify
> the implementation.'
> But it had other benefits, which are now pointed.
> 
> There was different issue, which we could fix now.
> With this patch set [1] EAS could have the freq_max limit, which
> SchedUtil has in the hotpath.
> 
> What could be the modified v1 [2]:
> - LUT which holds two IDs: efficient, inefficient, take one
>   according to the clamp f_max
> - add new argument 'policy->max' to em_pd_get_efficient_freq()
> 
> freq = em_pd_get_efficient_freq(em_cpu_get(policy->cpu), freq, policy->max);
> 
> The problem was that EAS couldn't know the clamp freq_max,
> which shouldn't be the blocker now.

If you can do that without adding any EM specific stuff in the cpufreq
core, I will mostly be fine.

But honestly speaking, creating more data structures to keep related
information doesn't scale well.

We already have so many tables for keeping freq/voltage pairs, OPP,
cpufreq, EM. You tried to add one more in EM I think V1, not sure.

It is always better to consolidate and we almost reached to a point
where that could have been done very easily. I understand that you
didn't want to touch so many different parts, but anyway..
 
> > > this v3 and your proposal.
> > 
> > IMHO, adding such callbacks to the EM core, like .mark_efficient(),
> > will only make this easier to handle for all different frameworks, and
> > not otherwise. The code will look much cleaner everywhere..
> > 
> 
> What about coming back to the slightly modified v1 idea?
> That was really self-contained modification for this
> inefficient opps heuristic.

I am not sure if I really understand what that would be, but again
adding another table is going to create more problems then it should.

Anyway, that's my view, which can be wrong as well.

Rafael: You have any suggestions here ?

-- 
viresh
