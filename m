Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6072D2DDE
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 16:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgLHPHk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 10:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729945AbgLHPHk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 10:07:40 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42A5C061793
        for <linux-pm@vger.kernel.org>; Tue,  8 Dec 2020 07:06:54 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w4so12381978pgg.13
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2020 07:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4IacYES1hVcq0zolMo4HyO8X+zUOxgs9o5mp4aXbTwE=;
        b=FTsqMH/DnUT78QPuQ+DrSSCncv3heeZ8an6t2CRIvrwHaitn5KpK16B0cxE7M1IayF
         IhEtm9gvtqVq9HX/QWxwtpM3aowc4Ow7kdOwJ36wXaqG3pfx0m5lHGOyFU9tE8rxnyg6
         x1jCs1k14LQrIzMz7EVc1rW9E9fl/H09e0vM/HaVWL32ddTNFy7eKdqyTCJFMkBDqpW/
         wBnrT+D2akoTc3ypOLCys7WrpX5UaF0Kq5pXDOpQWqF1r5pgF1T/Z2vq3YHnnVAfHMBu
         SJkJb6RKyhUyGiroNZ1SH8BYw5sw3JSBrUbEO5kDiVts2u4EkoU7yAIugKmGv6P4hPQ5
         w0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4IacYES1hVcq0zolMo4HyO8X+zUOxgs9o5mp4aXbTwE=;
        b=bch4l1W7DlrweJMwHvcFmqXFJFAisVQgrz9bkNx1vN9vGypb4+i9bxk9Nx5Pa6goxp
         nTh8lFeXKQwdlPrU09whr4hhE4fGWIoXugmF08TYYjeNPCnsDbYy2NmZpyfM+86uQH4t
         In0qoCNtcHjOhTw2fSDVb5I4tGyMXL0o5IQGWJ76VlIkh/F8FIFbXjnyZWK1QCrOIP+0
         gLpHHCfcOFaHek5eJUvujmsr2XlyOL2hKYq9WFH0AO8NmK2F3iM7W+ID9QJegyjuNdwU
         r/S1xQISnP9+JQtArMrBLlsRH2nI7LlsLKyDLiYOAqw28eY7sSSu7QY/m3++xj9rg/Ra
         d0Iw==
X-Gm-Message-State: AOAM533dIJ/PEN1bP5Y+gJmrrqeAhurNAgp5dxtWO6hx4WWzVzQ1bEym
        06jD37kFNZ8DGp+7G3SlZH+QdA==
X-Google-Smtp-Source: ABdhPJwMCgJ+t7tL4H+y54i776PPWHEYOtePK9ERwABVM/9Rb6abY7nAWoFGyUNPusElNl4gDtL94A==
X-Received: by 2002:aa7:928c:0:b029:19a:de9d:fb11 with SMTP id j12-20020aa7928c0000b029019ade9dfb11mr20968226pfa.21.1607440014248;
        Tue, 08 Dec 2020 07:06:54 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id 84sm4768700pfy.9.2020.12.08.07.06.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 07:06:53 -0800 (PST)
Date:   Tue, 8 Dec 2020 20:36:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Javi Merino <javi.merino@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V5 0/3] cpufreq_cooling: Get effective CPU utilization
 from scheduler
Message-ID: <20201208150650.ceswfsa6tqulidoh@vireshk-i7>
References: <cover.1607400596.git.viresh.kumar@linaro.org>
 <20201208145024.GD2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208145024.GD2414@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-12-20, 15:50, Peter Zijlstra wrote:
> On Tue, Dec 08, 2020 at 09:46:54AM +0530, Viresh Kumar wrote:
> > Viresh Kumar (3):
> >   sched/core: Move schedutil_cpu_util() to core.c
> >   sched/core: Rename schedutil_cpu_util() and allow rest of the kernel
> >     to use it
> >   thermal: cpufreq_cooling: Reuse sched_cpu_util() for SMP platforms
> 
> How should we go about merging this? Do I take the lot, or do we go muck
> about with topic branches?

Please take all of these through your tree. Thanks.

-- 
viresh
