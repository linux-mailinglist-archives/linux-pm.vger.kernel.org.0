Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C5A3E534A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 08:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbhHJGNu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 02:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhHJGNt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 02:13:49 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC83C0613D3
        for <linux-pm@vger.kernel.org>; Mon,  9 Aug 2021 23:13:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so3773765pjb.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Aug 2021 23:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5WKAbQxOKS/IrQEEmtwpya3NRWtq5HT+8FBO008wyP4=;
        b=A52Ra2M1yMEUvePFtcZf95mUKZx2Wkxze5RnP93CfgBLMlamcXDi+8dEtj/83Oiv9V
         WMimVDURUW/Bl4kgpKmq2uwa57Wvpyn+TKNH9ouFW1wlJDQ4OErebr7NIFBp2JcDLLL/
         PGQi8GB6yFqSzxIaDYbNmtcUOkUmaUvNIGsi63nrpHENcB+ADoR8vG3HJmuK1cbePB63
         qsdKxAuaB6QMixD02CIFgj+g66DfArrDSeHJE+8V3PSS/EU1tQeCKmrYpL5HE0bs/RgA
         o9KFxqZUT+IhBMnKZ5y83ZDIHfYX7yPSdSSml8aj3px1qPzR+hbo6HoVT+CHRWDEEltW
         RRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5WKAbQxOKS/IrQEEmtwpya3NRWtq5HT+8FBO008wyP4=;
        b=QfuZGtjhdq+ACLH718HOwRcP5MA6aRXxgoWw3xPseeoiHxYwNAW8wJgBTuSw3p9A2S
         eDjQEvN8QT6SgJtrvS31SDdvxLOEV/6I0B0YMhhwQBaB9TyNui2LZIFeWWcliMKZhM9k
         WKUoHqDwKCPYqFvzcbICATCspf2qVeMvaDSpMJKOl8+Ee4JOYSg3hGo2Mop6FY6jbdfq
         gpd9X7IBLGyNoi/wFU91NPXX3MbYmmxxGcxJB7I88vdl8UNdQGuWnGdTYRiLIIp0kRYk
         FyOzP9EL/XgbT+LiIeJwzr9yXEtYo4/Lh1mVNiX2OWcOpaRPvPL1Ni0z1m5xv1WV/dFA
         25TQ==
X-Gm-Message-State: AOAM531tZJVCxJZbM0Q+WgcfcL5CHJDFyTHvTlYtrXg+0apO+NTkQHZl
        ynP/bAig4ET3e0TcVA52WohvgQ==
X-Google-Smtp-Source: ABdhPJweuNuq8CveTaxlrrjJpmph46mYi5uOZaomFmuNlua9N5NldDVMnzdEa9H63/YuG5kgImttCg==
X-Received: by 2002:a63:1456:: with SMTP id 22mr236634pgu.257.1628576007608;
        Mon, 09 Aug 2021 23:13:27 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id r3sm6206659pff.119.2021.08.09.23.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 23:13:25 -0700 (PDT)
Date:   Tue, 10 Aug 2021 11:43:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v4 0/9] Inefficient OPPs
Message-ID: <20210810061323.kc5kvy6m6566z3gz@vireshk-i7>
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0jLzj48-Bu1-i4=r3aratJwRzVYuaPvycUb--4jKSRkHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jLzj48-Bu1-i4=r3aratJwRzVYuaPvycUb--4jKSRkHw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-08-21, 18:21, Rafael J. Wysocki wrote:
> The cpufreq changes are mostly fine by me now, but I would like to
> hear from Viresh regarding this.

I have few doubts/concerns here.

Just to iterate it again, the idea here is to choose a higher
frequency, which will work in an efficient manner based on energy
consumption. So this _only_ works for the case where the caller asked
for CPUFREQ_RELATION_L.

- The new flag being added here, CPUFREQ_RELATION_E, doesn't feel
  complete in this sense to me. It should rather be called as
  CPUFREQ_RELATION_LE instead as it is _always_ used with relation L.

- IMO this has made the caller site a bit confusing now, i.e.  why we
  send CPUFREQ_RELATION_E sometimes and CPUFREQ_RELATION_H at other
  times. Why shouldn't the _H freq be efficient as well ? I understand
  that this was done to not do the efficient stuff in case of
  userspace/powersave/performance governors.

  What about reusing following for finding all such cases ?

        policy->governor->flags & CPUFREQ_GOV_DYNAMIC_SWITCHING

  The driver can set a flag to tell if it wants efficient frequencies
  or not, and at runtime we apply efficient algorithm only if the
  current governor does DVFS, which will leave out
  userspace/performance/powersave.


Now the other thing I didn't like since the beginning, I still don't
like it :)

A cpufreq table is provided by the driver, which can have some
inefficient frequencies. The inefficient frequencies can be caught by
many parts of the kernel, the current way (in this series) is via EM.
But this can totally be anything else as well, like a devfreq driver.

The way we have tied this whole thing with EM, via
cpufreq_read_inefficiencies_from_em(), is what I don't like. We have
closely bound the whole thing with one of the ways this can be done
and we shouldn't be polluting the cpufreq core with this IMHO. In a
sane world, the cpufreq core should just provide an API, like
cpufreq_set_freq_invariant() and it can be called by any part of
the kernel.

I understand that the current problem is where do we make that call
from and I suggested dev_pm_opp_of_register_em() for the same earlier.
But that doesn't work as the policy isn't properly initialized by that
point.

Now that I see the current implementation, I think we can make it work
in a different way.

- Copy what's done for thermal-cooling in cpufreq core, i.e.
  CPUFREQ_IS_COOLING_DEV flag, for the EM core as well. So the cpufreq
  drivers can set a flag, CPUFREQ_REGISTER_EM, and the cpufreq core
  can call dev_pm_opp_of_register_em() on their behalf. This call will
  be made from cpufreq_online(), just before/after
  cpufreq_thermal_control_enabled() stuff. By this point the policy is
  properly initialized and is also updated in
  per_cpu(cpufreq_cpu_data).

- Now the cpufreq core can provide an API like
  cpufreq_set_freq_invariant(int cpu, unsigned long freq), which can
  be called from EM core's implementation of
  em_dev_register_perf_domain().

-- 
viresh
