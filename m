Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5B73AFFCA
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 11:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFVJEH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 05:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhFVJEG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 05:04:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772CDC061756
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 02:01:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f15so7246858wro.8
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 02:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ptHW8BAmdxpCBxQUcolRGi8sX0n3Ly6PDuUfb4/zXJw=;
        b=bKQUpxzVqx5UvKeV2YGy5Vh6wt2OOLR8CZY2niHrCCgy2Juhre0HTrezMPEH9u02nY
         zxoKVKovq6v/gSJ47F+jDRxXGRHb7l3ezUFILFNbQ0aKF5NabtE8CPLIDkHbFjXXnKT8
         VcdIC7npnJE2Un/LS1tanUxS5sAw6zS9fU2ngVREfNxlY5CKLs4lsZBSg4cNgRjSP7IW
         Gr4TVo+DT4L4qSAmtRjqF9XHnwloqUeQD+ms2g7WYSWgggu86FERwaVnvlo0A43hjyLx
         hi7mt0a4CFZmNdsGx+4M0fHZeaM5NGnMYGwwQTCsHszLlsFU47R392fXkD1RajCqH6wi
         gW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ptHW8BAmdxpCBxQUcolRGi8sX0n3Ly6PDuUfb4/zXJw=;
        b=aZzuG6EKbh3Twg2yIyFQDdSwBgwwkxX64xqg5tOStP45nA+nfVfY2oKaciC34mvzlz
         HM/CbB+ZHR1vgyFA6n9quSUAPIOUiD0JY64pJRFPdSV/juebOyB6scCn7sa9rTO+/uVv
         5/YGLtXYqY4xyVe3OJJb5FkfdzFaQ1qMknamgbxyt9FkKw+f+e03rz+0urGBpNiD9yDC
         XQgdnEwtELKpUlIMQu6GQF8R8ZNZss3ICKU+/mY78TjUKINRJFEPvXFs49n5HCgLL1mD
         uNhPv16zaZhBoy4V7BB2InEW0zjKlaDw4c1RfO0+F5j16UcNF/8vB2agvmLf11nq0sVX
         ueWw==
X-Gm-Message-State: AOAM532BpadiO3AVm9LWoFYGFtiyF6AKGf2xovdp3zEuQOeHhV5Nd1+1
        uqO3O6+uTrkDKnWhK9e+vO7qJg==
X-Google-Smtp-Source: ABdhPJzCCN0VtZioHOGcdzWlEhNW5nhQL9zaVghAJX+v1pLGPZhJ+sPKD7YwAVCO26ANj2PukjuDNQ==
X-Received: by 2002:a5d:6d8a:: with SMTP id l10mr3496679wrs.63.1624352508882;
        Tue, 22 Jun 2021 02:01:48 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id o11sm1626399wmq.1.2021.06.22.02.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 02:01:48 -0700 (PDT)
Date:   Tue, 22 Jun 2021 09:01:45 +0000
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, linux-pm@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
Message-ID: <YNGm+W/BBQnvfPe/@google.com>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-4-git-send-email-vincent.donnefort@arm.com>
 <20210614072835.z2tjoaffcflry7pk@vireshk-i7>
 <20210614133522.GA34061@e120877-lin.cambridge.arm.com>
 <20210615050211.5gpx4faha6heytad@vireshk-i7>
 <20210615084418.GA167242@e120877-lin.cambridge.arm.com>
 <20210615101706.mabloqrmakeiwcf5@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615101706.mabloqrmakeiwcf5@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 15 Jun 2021 at 15:47:06 (+0530), Viresh Kumar wrote:
> On 15-06-21, 09:44, Vincent Donnefort wrote:
> > The cpufreq_policy is accessed through percpu data. I originally tried to get it
> > with cpufreq_cpu_get_raw(). But when we init the cpufreq driver (and by
> > extension when we call em_dev_register_perf_domain()), the percpu data isn't
> > updated yet.
> 
> Right.
> 
> > I guess the only way at that moment would be to propagate the cpufreq_policy
> > pointer through the functions parameters, which is a bit cumbersome, especially
> > as the EM can be used with devfreq as well and that em_dev_register_perf_domain()
> > can be called from dev_pm_opp_of_register_em()
> > 
> > Would we be ok with that?
> 
> No.
> 
> You only talked about freq_table earlier and that's all I checked :)
> 
> > I could use em_data_callback as well ... but that doesn't change the fact some
> > registration is going through dev_pm_opp_of_register_em() which has no knowledge
> > about the cpufreq_policy. Doesn't look a better approach.
> 
> The point is that I don't want cpufreq to carry this for users, we
> have EM today, tomorrow we may want to mark a frequency as inefficient
> from somewhere else. The call need to initiate from EM core.
> 
> And this isn't a cpufreq only thing, but is going to be generic along
> with other device types.
>
> This is exactly why I asked you earlier to play with OPP core for
> this. That is the central place for data for all such users.

The thing is, the very reason for the existence of PM_EM in the first
place is to NOT depend on PM_OPP which was deemed too Arm-specific. So
let's not create those dependencies now please.

> If this information is present at the OPP table (somehow), then we can
> just fix dev_pm_opp_init_cpufreq_table() to set this for cpufreq core
> as well.

Honnestly, I don't think PM_OPP should have anything to do with this,
for the reason mentionned above.

I don't really see the problem with cpufreq core querying the EM data
directly, we already have core subsystems doing that (the scheduler) so
why would that be a problem? If the only concern is for non-CPU devices,
all we'd need is a matching feature in devfreq core and everything
should be good no?

Thanks,
Quentin
