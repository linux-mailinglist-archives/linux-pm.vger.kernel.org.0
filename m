Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1399D653F
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 16:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732716AbfJNOda (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Oct 2019 10:33:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfJNOda (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2019 10:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oaPf6dnXppFrtIrvcvxSOzHPxnxg+Q1/gfUdnd2qqww=; b=H2xn3tNqupv4mtya7/ZVR254m
        sPEnCJnS3vkdQCoRyqO+jUcLVqIWn0yArybngv9Y/QprkEXIMMBTohbB/tX80eIhJ0mTAG+ldgtOE
        zXlQMqEFMaV+YT/MLRsA5k0Mv3229YPFlNOAsQiU7LGiqhxPsDQfp4WYM3rasClUBeLG8oOKZ3ejj
        XAkGg4jk7WvI58ZL6YeqQuTWV1quQM4vg0/88/i0Z0xlcqAaR2dg0DPLdeXsoVekNRqouuANEYa78
        y9O6mvcqdoGQTFWXpN/Hp7MNEFmkHtZhc4mKCBBWVVAnguwRu0Wacw7KOehU1zDjWAyxvc3cet1JN
        +LaKorZrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iK1PX-0001uU-97; Mon, 14 Oct 2019 14:33:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2604C305E42;
        Mon, 14 Oct 2019 16:32:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 31E482026F768; Mon, 14 Oct 2019 16:33:21 +0200 (CEST)
Date:   Mon, 14 Oct 2019 16:33:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
Subject: Re: [RFC PATCH v3 4/6] sched/cpufreq: Introduce sugov_cpu_ramp_boost
Message-ID: <20191014143321.GH2328@hirez.programming.kicks-ass.net>
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191011134500.235736-5-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011134500.235736-5-douglas.raillard@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 11, 2019 at 02:44:58PM +0100, Douglas RAILLARD wrote:
> Use the utilization signals dynamic to detect when the utilization of a
> set of tasks starts increasing because of a change in tasks' behavior.
> This allows detecting when spending extra power for faster frequency
> ramp up response would be beneficial to the reactivity of the system.
> 
> This ramp boost is computed as the difference
> util_avg-util_est_enqueued. This number somehow represents a lower bound

That reads funny, maybe 'as the difference between util_avg and
util_est_enqueued' ?

> of how much extra utilization this tasks is actually using, compared to
> our best current stable knowledge of it (which is util_est_enqueued).
> 
> When the set of runnable tasks changes, the boost is disabled as the
> impact of blocked utilization on util_avg will make the delta with
> util_est_enqueued not very informative.

> @@ -561,6 +604,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  		}
>  	}
>  
> +
>  	return get_next_freq(sg_policy, util, max);
>  }

Surely we can do without this extra whitespace? :-)
