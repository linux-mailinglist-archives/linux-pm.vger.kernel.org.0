Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C297157879
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2020 14:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgBJNIM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Feb 2020 08:08:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbgBJNIM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Feb 2020 08:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TdcuDpxLgQJeHBcjjVmCcGsEmDfK4lLRpvk8VBOXZEk=; b=Su/gbaRlBpenaffOyzKGTCy2Kv
        U4VhuSMUBuiH5znbE8cOJQiXc7OAauUE3Rr5zDYruT/2zFwUqWw8u8N06QVtl4w+u1uzvUsPrb83e
        YoMJyArf4azD3c8CyMwK5/ciw1xcEI1wqrDRRWJ1ghDMGFrXoTFVImPDMhyXO2OMJ93EZ1TtXLuzZ
        B6zyGC0NSxpn8QH/CrgKfXvO9aihTKBAL5brXqHdW8vzr0HZSFqXZsstmks+fnPKx5s/ZmNoaX0ak
        9NxODiMBETNDfExlqYLhuSIDGHbL7fqHP2RoIQL1WoJDdoJkcjziR2P0GIStEQf2EjcTYrJp0bn8j
        V07W3OhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j18nE-0005je-1z; Mon, 10 Feb 2020 13:08:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0B8B2300446;
        Mon, 10 Feb 2020 14:06:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B97120148931; Mon, 10 Feb 2020 14:08:02 +0100 (CET)
Date:   Mon, 10 Feb 2020 14:08:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v4 4/6] sched/cpufreq: Introduce sugov_cpu_ramp_boost
Message-ID: <20200210130802.GG14879@hirez.programming.kicks-ass.net>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <20200122173538.1142069-5-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122173538.1142069-5-douglas.raillard@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 22, 2020 at 05:35:36PM +0000, Douglas RAILLARD wrote:

> +static unsigned long sugov_cpu_ramp_boost_update(struct sugov_cpu *sg_cpu)
> +{
> +	struct rq *rq = cpu_rq(sg_cpu->cpu);
> +	unsigned long util_est_enqueued;
> +	unsigned long util_avg;
> +	unsigned long boost = 0;
> +

Should we NO-OP this function when !sched_feat(UTIL_EST) ?

> +	util_est_enqueued = READ_ONCE(rq->cfs.avg.util_est.enqueued);

Otherwise you're reading garbage here, no?

> +	util_avg = READ_ONCE(rq->cfs.avg.util_avg);
> +
> +	/*
> +	 * Boost when util_avg becomes higher than the previous stable
> +	 * knowledge of the enqueued tasks' set util, which is CPU's
> +	 * util_est_enqueued.
> +	 *
> +	 * We try to spot changes in the workload itself, so we want to
> +	 * avoid the noise of tasks being enqueued/dequeued. To do that,
> +	 * we only trigger boosting when the "amount of work" enqueued
> +	 * is stable.
> +	 */
> +	if (util_est_enqueued == sg_cpu->util_est_enqueued &&
> +	    util_avg >= sg_cpu->util_avg &&
> +	    util_avg > util_est_enqueued)
> +		boost = util_avg - util_est_enqueued;
> +
> +	sg_cpu->util_est_enqueued = util_est_enqueued;
> +	sg_cpu->util_avg = util_avg;
> +	WRITE_ONCE(sg_cpu->ramp_boost, boost);
> +	return boost;
> +}
