Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C11295D2A
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 13:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896977AbgJVLHA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 07:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896965AbgJVLG7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 07:06:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FC9C0613CF
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2020 04:06:59 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s22so720061pga.9
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2020 04:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5F1P3cDyZZfB+5wQAJZN/bSRRcbsJk9yH9Mp8FnRfG0=;
        b=KtCmAvWUglFJkVFnOpbKc+tedHFB8GWLzyy5Pf2YNN/ltIPGpeE8VV3Ezrjnf6MtIV
         Iw4YsvNEjCjJ/OfyB5p3R99DTyqL8uYJRhtq4+teGl6/7a0rL1YIDTb5zMHpu9uUcipF
         6JdheIPbQRh2Bw6KUfUrHXrpyZaFQYVP5LvGejO9lqEsy/eRPGt0KsURP9/q+NolQXTi
         diBLTSbgB+kw+mgQ9Pfi6wRP7eec4Lce/cOInisWYBqnWovam16o1mQTRtwPTVxY3t03
         amLoYsvpP5RAv7CpiC3bYM8aSUIQOIAjof7yIO8+Rx+9hduyEbCUSfk9rskNrfQyrgr1
         OLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5F1P3cDyZZfB+5wQAJZN/bSRRcbsJk9yH9Mp8FnRfG0=;
        b=j4puLmLWHcWW6NPawJ38tttPJWuzKCv9aB52PlmeRB2ZXBNo4tKcFtPLTZG4EDjyAc
         UOaSu1kgpq3mV33ECKr5h6AvsqWXWKIfwvZk703JktdcT7c0bwq0Uo2cRYWmh1kfjSnx
         MRlPFbx3eOw44csWj9RH+8n5bwF/TnGfXQjL4bN5P2JoullMG+5nwo+uHrUg0rv1sbH+
         dAE0PoIFLQzrk87Ocdmobn9M4/VPegpBlBwSh6rKDiwsVILZYpB2F6wU6QIsx2AnV2Y9
         5FTkQeOMaooZA2Bv6UUqQSBKk36NMfiCp9CPSFw9Pz0792r8v9x/HRr0C07gvrxZjILo
         bghg==
X-Gm-Message-State: AOAM531vAWfDIPP30PyD95JOe+VhYLdN80PP3vjIjxPA74JKiAj/WEkG
        HnFSOlFPFB30vWUFMbap284/zg==
X-Google-Smtp-Source: ABdhPJwe/yxHcXuREOavhKWa2LijXwU7OHCva5pj9T8tlFVE8ZZKFk9++TWqYSyj+47QdqGv+rSW8w==
X-Received: by 2002:a62:7609:0:b029:152:b31e:6aed with SMTP id r9-20020a6276090000b0290152b31e6aedmr2031340pfc.10.1603364819189;
        Thu, 22 Oct 2020 04:06:59 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id u2sm1944980pgf.63.2020.10.22.04.06.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2020 04:06:58 -0700 (PDT)
Date:   Thu, 22 Oct 2020 16:36:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
Message-ID: <20201022110656.gaphjv2tzhj4f5y6@vireshk-i7>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <20200716115605.GR10769@hirez.programming.kicks-ass.net>
 <20201022083255.37xl3lffwk5qo6uk@vireshk-i7>
 <20201022090523.GV2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022090523.GV2628@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-10-20, 11:05, Peter Zijlstra wrote:
> On Thu, Oct 22, 2020 at 02:02:55PM +0530, Viresh Kumar wrote:
> > One of the issues I see with this is that schedutil may not be
> > available in all configurations and it is still absolutely fine to
> > using the suggested helper to get the energy numbers in such cases, so
> > we shouldn't really make it scheutil dependent.
> 
> The only constraint on schedutil is SMP I think; aside from that it
> should/could always be available.
> 
> Given the trainwreck here:
> 
>   20201022071145.GM2628@hirez.programming.kicks-ass.net
> 
> (you're on Cc), I'm starting to lean more and more towards making it
> unconditionally available (when SMP).
> 
> Anybody forcing it off either sets performance (in which case we don't
> care about energy usage anyway)

I agree.

> or they select one of the old (broken)
> ondemand/conservative things and I don't give a crap.

The other kernel layers, for example cpufreq-cooling in question here,
don't really need to bother with the governor in use and should be
able to get the energy numbers anyway. So for me, the energy number
that the cpufreq-cooling stuff gets should be same irrespective of the
governor in use, schedutil or ondemand.

Having said that, schedutil really doesn't need to install the
fallback (which you suggested earlier), rather the scheduler core can
do that directly with cpufreq core and schedutil can also use the same
fallback mechanism maybe ? And so we can avoid the exporting of stuff
that way.

-- 
viresh
