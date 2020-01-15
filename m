Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1613613C7F2
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 16:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgAOPfq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 10:35:46 -0500
Received: from merlin.infradead.org ([205.233.59.134]:53838 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgAOPfp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 10:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7tULYdTXDefQzbKKBjZ631T3tpAXiYEzA7pWjvx6gGA=; b=Ds1WK8cmSxxcfazLYqs9vF4vC
        orBgkcryPgdZM0FJw4XD8X2o0fa/u8PDT/Ia04oY7sEuVQQZj8TbPL+jTAe0DlLi6U6QlRDM2gZ6J
        boL1goQmonroRVS7pj/ztTBbxvQ7b97FlWTBAV0ZWkOxXQr8AL8f3PVSR1bPnl+To1wkIatchYaF6
        ZsI8CfkDoVyhG5pTZmufqY5P53eIO4pWTVt+0MdES4BsoX7/mLss2fBvP6pmKEXmn3dJfePemrW1a
        FXTVZoh/ElM8AId0FI26W2vAw9fUyZmNDy8ay/YVKipGd+vmQV/hpPoBhZwPEjRT6UI5b73TKgIgr
        GdCGtBQGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irkhN-0007sH-AD; Wed, 15 Jan 2020 15:35:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E98C30734B;
        Wed, 15 Jan 2020 16:33:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5AC10201A93DF; Wed, 15 Jan 2020 16:35:11 +0100 (CET)
Date:   Wed, 15 Jan 2020 16:35:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] sched/fair: remove redundant call to cpufreq_update_util
Message-ID: <20200115153511.GN2827@hirez.programming.kicks-ass.net>
References: <1579083620-24943-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579083620-24943-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 15, 2020 at 11:20:20AM +0100, Vincent Guittot wrote:
> With commit bef69dd87828 ("sched/cpufreq: Move the cfs_rq_util_change() call to cpufreq_update_util()")
> update_load_avg() has become the central point for calling cpufreq (not
> including the update of blocked load). This change helps to simplify
> further the number of call to cpufreq_update_util() and to remove last
> redundant ones. With update_load_avg(), we are now sure that
> cpufreq_update_util() will be called after every task attachment to a
> cfs_rq and especially after propagating this event down to the util_avg of
> the root cfs_rq, which is the level that is used by cpufreq governors like
> schedutil to set the frequency of a CPU.
> 
> The SCHED_CPUFREQ_MIGRATION flag forces an early call to cpufreq when the
> migration happens in a cgroup whereas util_avg of root cfs_rq is not yet
> updated and this call is duplicated with the one that happens immediately
> after when the migration event reaches the root cfs_rq. The dedicated flag
> SCHED_CPUFREQ_MIGRATION is now useless and can be removed. The interface of
> attach_entity_load_avg() can also be simplified accordingly.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks!
