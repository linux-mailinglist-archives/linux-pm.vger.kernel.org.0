Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA571F8D9
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 18:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfEOQnF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 12:43:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfEOQnE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 12:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LFWmpV8Lm1fyxQJMm8Z7yO88zEmKawJucYqlb2bUzLQ=; b=sRb5I1/01FFguKFh/14b7u3pn
        XWfGsZjlNhtVArXeFiwSiq2EX+GX5EoldwhEdBYKRPL+7S4fEEq31Qrhvh8zdL6cUdRXY0bUEIgBj
        6hmCt77YddaRvV+JDgkDHnYpmE/TfZOBHaMCFHmp/nv7ZWz1wQ3Vl+Nf2NiGCOqM99+zthij8fufg
        qBBezfWuPdOIAv2rrLRvouYZlMDArybxG/dl6skBG4oFQ0C7W6+B08qi2tKA/dZhMqJ4L6B0N+8BD
        UNtIDqs4MuFXbeuGCeriB7gOyPV75E2VQti5Q5xtX9ggq+dneyZpsnHdAUesEvKnmRkpB3B9WWqeF
        xrctqRKdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQwzd-0007ik-Sr; Wed, 15 May 2019 16:43:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5FD0D2029906B; Wed, 15 May 2019 18:43:00 +0200 (CEST)
Date:   Wed, 15 May 2019 18:43:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
Subject: Re: [RFCv2 5/6] sched/fair: Tune task wake-up logic to pack jitter
 tasks
Message-ID: <20190515164300.GX2589@hirez.programming.kicks-ass.net>
References: <20190515135322.19393-1-parth@linux.ibm.com>
 <20190515135322.19393-6-parth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515135322.19393-6-parth@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 15, 2019 at 07:23:21PM +0530, Parth Shah wrote:
> @@ -6704,6 +6773,31 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	return -1;
>  }
>  
> +#ifdef CONFIG_SCHED_SMT
> +/*
> + * Select all tasks of type 1(jitter) for task packing
> + */
> +static int turbosched_select_idle_sibling(struct task_struct *p, int prev_cpu,
> +					  int target)
> +{
> +	int new_cpu;
> +
> +	if (unlikely(task_group(p)->turbo_sched_enabled)) {

So if you build without cgroups, this is a NULL dereference.

Also, this really should not be group based.

> +		new_cpu = select_non_idle_core(p, prev_cpu);
> +		if (new_cpu >= 0)
> +			return new_cpu;
> +	}
> +
> +	return select_idle_sibling(p, prev_cpu, target);
> +}
> +#else
