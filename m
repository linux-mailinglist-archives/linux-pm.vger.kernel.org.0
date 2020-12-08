Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E80A2D2D8B
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 15:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgLHOv1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 09:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLHOv1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 09:51:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DA3C061749;
        Tue,  8 Dec 2020 06:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sm5ylG4LyLpBWgCJ8nF1i/lYdpFR+VS2lu9SrvWQeB0=; b=Yts/GSDgA8COPDOd2yB7VQ+SZ9
        5x0Eu8mvT2qexks4umgJwQrtdEWvoFuDco1dnZnxARWDUKA5aBbzh00UzcnTyKVCtmWfRhszm0K3j
        EsI/3oi4F6j1G+1KqbImPy/J0Od5nTC5FOgVaDuahggm57KqEK4R4/fFUOSvGvVOxf+HwsDPuC1MQ
        +eSzEA9i+BDWXqmLjJbxvEhxCuwdzP/0+kcZkdFJYpBV2gNaYrZtq8Qq0+Q/CYzlJdYvyNF8Y/tQy
        4vuu92Z0niD+xkkWUwM8Erb1mR5RQOVV44k48+S+LwQF9F03/j/d3jJ48b03fSj6KCROM18eW9pac
        jfkrWzJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmeJt-0003IW-71; Tue, 08 Dec 2020 14:50:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D1E6305C10;
        Tue,  8 Dec 2020 15:50:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 75F4721ADBEA0; Tue,  8 Dec 2020 15:50:24 +0100 (CET)
Date:   Tue, 8 Dec 2020 15:50:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
Message-ID: <20201208145024.GD2414@hirez.programming.kicks-ass.net>
References: <cover.1607400596.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1607400596.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 08, 2020 at 09:46:54AM +0530, Viresh Kumar wrote:
> Viresh Kumar (3):
>   sched/core: Move schedutil_cpu_util() to core.c
>   sched/core: Rename schedutil_cpu_util() and allow rest of the kernel
>     to use it
>   thermal: cpufreq_cooling: Reuse sched_cpu_util() for SMP platforms

How should we go about merging this? Do I take the lot, or do we go muck
about with topic branches?
