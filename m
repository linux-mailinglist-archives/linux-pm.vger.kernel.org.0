Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2375534948
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 05:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiEZD0I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 May 2022 23:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiEZD0H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2022 23:26:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CEEB0A57
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2022 20:26:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nn3-20020a17090b38c300b001e0e091cf03so116818pjb.1
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2022 20:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ArSZJa1J1kFEuElJFIYmUXoBdpEK05pDadUhvHYNYrk=;
        b=UmqlIRm7NBvNzXuxGbw7NvDgEh0B+IN+hYO1NZAlJ+4ZP/AUMk5z5nCuDyx9Mgq6c7
         RpRIx/ql5aQ6qOBY1MwyawhmZ7nUGa+hegM+w6Er6m3YdIAe90jb9vvytpM9znTObyIp
         D3BBIMAA8FzPYToVy861uE3lLMlsra7VXp0iTpjf8VOlaUkyZ0Itc/60yBqldBcyFPno
         +L8/VIsfCjoDq5Q/DHNGwBi3cjuhx860fy8uZBIkMUFjPNEMOy5vO3px1LDAg3GxaTFo
         dp6CjlhXip6ogG4aUDeXxk8iGXJlW9ee/hDBDiBbmAO4ERbP8txkOIYQ1551XsYGYEew
         Xo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ArSZJa1J1kFEuElJFIYmUXoBdpEK05pDadUhvHYNYrk=;
        b=skpdca/I23AgcscxyLgx6G3RpalK4POoc44bPf66ozEVqHVOG720bBWaa+qIe7xC3g
         RSxQMOREcgJ6TJQ0HibtBteIEQFFDEcn4aNMWLEp0L8S4cVSCwUuf3VhNRxmQwuLNGi/
         W9a9p+oxRT23l1b2tZwSv1OrDFSglpVCqqZQt31iXMFrzu7wd5EL2sZymD7Wk0s7E+nu
         R3ZDL+jb55paYV1FZyA3SIUq8e+K/gX7vOIacbI/NPHfHNwIM8aES3/+IqxqiWae8Z9A
         iAp51pZy94v9BcIiYuEZG38NI6TkREPeM0qWDLVR7soHKB5WF9Tw15dFMGqq9QT0Jxjk
         2IdQ==
X-Gm-Message-State: AOAM53075Fr4oIeg9ErHyON0TnVWgMAXm6n0z45Ahkva9ri25tc/5SGF
        4tfaWiGrkmJzgA8VbMtCi6Fd3A==
X-Google-Smtp-Source: ABdhPJyygmksUP4XHveI/lMupaklCIZTxTlgTChbVazs8xameZBhD6bGmx6qxULmZgdzv7vKO5DC1Q==
X-Received: by 2002:a17:90b:388c:b0:1df:cb4b:3e72 with SMTP id mu12-20020a17090b388c00b001dfcb4b3e72mr412472pjb.130.1653535564079;
        Wed, 25 May 2022 20:26:04 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902714a00b0015e8d4eb1f5sm181214plm.63.2022.05.25.20.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 20:26:03 -0700 (PDT)
Date:   Thu, 26 May 2022 08:56:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     =?utf-8?B?4oCcUmFmYWVsIEouIFd5c29ja2nigJ0=?= <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: 'schedutil' (possibly) aberrant behavior surrounding
 suspend/resume process (timing/delay/run-away CPU issues)
Message-ID: <20220526032600.dlbrrppqovizwpvs@vireshk-i7>
References: <R6AlCxZca3GET8vtwpOAkzQ4Y9SX-NOVQ05FlJAKDUvNTYCAhsWy1e0q5soCkapaviI8SS-9eC51nwJj6yn6n1rFAlwndEqYqlr_hqz4C_U=@dannyvanheumen.nl>
 <20220525052804.rvnp2jinpmz7vukx@vireshk-i7>
 <34KkbDDzdEpklXuY3YwJi95cgyhc44xzV-xQVDRRuKctbmHUdH8Ddm2LMcSUVNVmwtGUaB73-yOqIijCnMFRfh3aYxlKOKcrrRyCHb2uOPw=@dannyvanheumen.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34KkbDDzdEpklXuY3YwJi95cgyhc44xzV-xQVDRRuKctbmHUdH8Ddm2LMcSUVNVmwtGUaB73-yOqIijCnMFRfh3aYxlKOKcrrRyCHb2uOPw=@dannyvanheumen.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-05-22, 13:39, Danny van Heumen wrote:
> On Wednesday, May 25th, 2022 at 07:28, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 21-05-22, 22:13, Danny van Heumen wrote:
> > > In all cases, when taking schedutil out of the loop, these issues
> > > disappear. In case of the Kabylake laptop, I do set
> > > intel_pstate=active.
> >
> >
> > Just to clarify here, from what I understand about the active/passive
> > parts of intel-pstate driver, if you set intel_pstate=active then none
> > of the cpufreq governor's will be used. This enables the setpolicy()
> > callback of the driver, which will decide how the frequency changes
> > later on. The cpufreq governors, ondemand or schedutil, are only in
> > play if intel_pstate=passive.
> 
> So the fact that 'schedutil' is not available but the other governors
> are, is actually meaningless?

Cpufreq core in the kernel has two separate entities: drivers and
governors. Drivers mostly decide how frequency is read or updated on
the hardware and governors decide on the policy, i.e. what frequency
to go to and when.

When intel-pstate is set to "active", the governor algorithms from
cpufreq core are take out, i.e. files like
drivers/cpufreq/cpufreq_ondemand.c or cpufreq_conservative.c or
sched/kernel/cpufreq_schedutil.c. Instead the driver, along with help
from the hardware, decides the next frequency by itself. In this case
we have two policies available (these are still called as governors in
userspace), powersave and performance. These two tell how aggressive
we need to be, but again the governor algorithms are gone.

> Does that mean that setting 'powersave' vs 'performance' is meaningless
> too?

No.

> If not, does that mean that the meaning changes (as in "determined
> by") intel_pstate?

What I wanted to say earlier was that if you want to pin point it to
schedutil (I know you are just trying to find it out yourself as
well), then you must always keep intel_pstate="passive" and then test
between ondemand and schedutil and see if problem happens or not. That
way we can see if it is one of the governors or both, when the problem
happens.

> > Also I am not yet sure it is related to cpufreq right now.
> 
> I am trying to figure out whether or not some problems are caused by
> 'schedutil' vs it just being present. I guessed from the MAINTAINERS
> index that you are probably the maintainers with knowledge on
> schedutil. If not, do you know where I should look then?

That's right. Me, Rafael and Peter look at the schedutil governor
normally. You have the mail to right people.

> To clarify, I interpreted 'cpufreq' as in:
> /sys/devices/system/cpu/cpufreq/policy*/scaling_governor

Right.

> I wonder if I am taking a wrong approach in tackling these issues,
> so if you have recommendations, please let me know.

I would also try intel_pstate=passive with powersave and performance.
The heating issue, if related to cpufreq leaving CPU at higher freq,
should also occur with performance (which keeps CPUs at highest freq).

-- 
viresh
