Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0FDF1F8BE
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 18:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfEOQh6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 12:37:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48744 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfEOQh6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 12:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OtMvEXRStSFfAAGIbWQmGKZWz5rWXJEj2aQ6RYI6efI=; b=bIpHC5/OJWt+EW0yH5oJoix53
        Yo6l9W5Z/jkqvOKRRVXc4gbZFnZ4MnECgs5PXJ/ieEumhruTuadQshGB6iGJtG8UuTLkOgVR/VJE9
        a5BiM2mmPAC+SuQoK8A6ct7iakYS/2l9HOSE1aOxYv6p2JZ1EsRrJKEH9mQssVVZVGWTmnjgw6hps
        usaBuZE6qgazdHL6SAMJ9xznNW0gYBl2AwCrXUACQAlDiMrvvgfVdkWJ8Pi/9kxl3/gLtbn1LXBpN
        /i7OYeja6dF5WPZ7NiMGBozw9RDvzMz1joQqMcRpVD4DJVPLNIJRvDPbUTRiHJI0tGPL4xURxe+dK
        VYEmHiZkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQwuf-0001Fy-Dt; Wed, 15 May 2019 16:37:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D2042029906B; Wed, 15 May 2019 18:37:52 +0200 (CEST)
Date:   Wed, 15 May 2019 18:37:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
Subject: Re: [RFCv2 4/6] sched/fair: Define core capacity to limit task
 packing
Message-ID: <20190515163751.GW2589@hirez.programming.kicks-ass.net>
References: <20190515135322.19393-1-parth@linux.ibm.com>
 <20190515135322.19393-5-parth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515135322.19393-5-parth@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 15, 2019 at 07:23:20PM +0530, Parth Shah wrote:
> The task packing on a core needs to be bounded based on its capacity. This
> patch defines a new method which acts as a tipping point for task packing.
> 
> The Core capacity is the method which limits task packing above certain
> point. In general, the capacity of a core is defined to be the aggregated
> sum of all the CPUs in the Core.
> 
> Some architectures does not have core capacity linearly increasing with the
> number of threads( or CPUs) in the core. For such cases, architecture
> specific calculations needs to be done to find core capacity.
> 
> The `arch_scale_core_capacity` is currently tuned for `powerpc` arch by
> scaling capacity w.r.t to the number of online SMT in the core.
> 
> The patch provides default handler for other architecture by scaling core
> capacity w.r.t. to the capacity of all the threads in the core.
> 
> ToDo: SMT mode is calculated each time a jitter task wakes up leading to
> redundant decision time which can be eliminated by keeping track of online
> CPUs during hotplug task.

Urgh, we just got rid of capacity for SMT. Also I don't think the above
clearly defines your metric.
