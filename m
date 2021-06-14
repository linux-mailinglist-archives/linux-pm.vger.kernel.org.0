Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AB43A6E48
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 20:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhFNSk4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 14:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhFNSkz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 14:40:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4E5C061574;
        Mon, 14 Jun 2021 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4tHLuqmgdgsWH9+Oan4cN/C2KwNR0UqEdUEL10Y7OWA=; b=A/q5A9ocg4uEv/akQNc9poVyAA
        WAdjFOB5BQpqVtcMB6RyDLgtzXUGv2kiTvL6im0d//2rt3l1dpdtfrWVbkb/mJHxHOiqWShhxSc37
        6rthibJdTvbUr1jd4BDnHYe7etM+DnqfEKRVE3wv59djWu3wJ0i+c4Ul62fqDQSH4+z32alAbNkZa
        wd6+ZiIDGTjdkSgR/uxukUHtW3QcXn6BFC0+7BXZz6nFWJTrHq4klMPSAcf6GNLD5PHne8hu5iTWh
        w8+kMUTRZJHOduBp35oBVBLYqNdUbBeNsj2wPeCFnCiU/y/xJ5VaQbdioReqkyLwnfVnw+vg3RnAx
        126qNDqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lsrTI-005ij6-6b; Mon, 14 Jun 2021 18:38:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C0DEB982D9F; Mon, 14 Jun 2021 20:38:01 +0200 (CEST)
Date:   Mon, 14 Jun 2021 20:38:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] freezer,sched: Rewrite core freezer logic
Message-ID: <20210614183801.GE68749@worktop.programming.kicks-ass.net>
References: <YMMijNqaLDbS3sIv@hirez.programming.kicks-ass.net>
 <20210614154246.GB13677@redhat.com>
 <20210614161221.GC68749@worktop.programming.kicks-ass.net>
 <20210614165422.GC13677@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614165422.GC13677@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 14, 2021 at 06:54:23PM +0200, Oleg Nesterov wrote:
> On 06/14, Peter Zijlstra wrote:

> > > I guess you do this to avoid freezable_schedule() in ptrace/signal_stop,
> > > and we can't use TASK_STOPPED|TASK_FREEZABLE, it should not run after
> > > thaw()... But see above, we can't rely on __frozen(parent).
> >
> > I do this because freezing puts a task in TASK_FROZEN, and that cannot
> > preserve TAKS_STOPPED or TASK_TRACED without being subject to wakups
> 
> Yes, yes, this is what I tried to say.

OK, thanks for all that. Clearly I need to stare at this code longer and
harder.

One more thing; if I add additional state bits to preserve
__TASK_{TRACED,STOPPED}, then I need to figure out at thaw time if we've
missed a wakeup or not.

Do we have sufficient state for that? If so, don't we then also not have
sufficient state to tell if a task should've been TRACED/STOPPED in the
first place?

If not, I probably should add this... I'll go dig.
