Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026F721EB36
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 10:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgGNIYJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 04:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgGNIYJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 04:24:09 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044EDC061755;
        Tue, 14 Jul 2020 01:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NTXTDSxXIabpTtQm/KBGD+7vkhm9AF9uI5qymKFrD1w=; b=D+se2QTEccQm3Ggm33suL8k8ez
        e8uPxBkYvNfxWeFq95mKwbbpEU9WSrnr8JNTxU0ueYEw5bm+xA/r0BUDOUlxInDMjd0BiojA71AyX
        QPJ8pT10mSqJLKhMw7M+X0Bm+XrnzwYB2UKx5rnbUMmzi2d5mQ4XhzIERPlGuuK2E/l76p6xU+20b
        84/4zOfGHB8NXjGHmtu/rSRQRYtz0NKTxqONHWQkKuUk2fEG9sMgeRmPh/saiW1XyYveOYeFCnRay
        RLDJgcNxnIFRACLiYRer7WOpwsVF/g3gFZaJw1P3EUod3kRwXbArN+M7Q8UCwrG0J674qsp2zRcQp
        B4AD0qvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvGEH-0003WO-Ek; Tue, 14 Jul 2020 08:23:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D5D7F302753;
        Tue, 14 Jul 2020 10:23:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 405D02141F06E; Tue, 14 Jul 2020 10:23:52 +0200 (CEST)
Date:   Tue, 14 Jul 2020 10:23:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
Message-ID: <20200714082352.GN10769@hirez.programming.kicks-ass.net>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 12:06:53PM +0530, Viresh Kumar wrote:
> Several parts of the kernel are already using the effective CPU
> utilization to get the current load on the CPU, do the same here instead
> of depending on the idle time of the CPU, which isn't that accurate
> comparatively.
> 
> Note that, this (and CPU frequency scaling in general) doesn't work that
> well with idle injection as that is done from rt threads and is counted
> as load while it tries to do quite the opposite. That should be solved
> separately though.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/thermal/cpufreq_cooling.c | 65 +++++++------------------------
>  1 file changed, 15 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index 6c0e1b053126..74340b2b0da7 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -23,6 +23,7 @@
>  #include <linux/thermal.h>
>  
>  #include <trace/events/thermal.h>
> +#include "../../kernel/sched/sched.h"

Hard NAK on that. Just writing it should've been a clue.
