Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF94295E65
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 14:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898207AbgJVMaU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 08:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898192AbgJVMaT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 08:30:19 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97213C0613CE;
        Thu, 22 Oct 2020 05:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EedHvqVCCjLDevVL9HqqLGGu/5dwmfqkwiCkYnXrnOA=; b=g+h2ebbhZ35yKxhx72G5WLe0iJ
        3rYFno3qrByA6M6lsokAgw7OrLS3xFU85vASl4h1DEqQl+pzuAfwt4F3VuiRzSXvt3kN2Yba1LJeT
        R4CjyU1YtwTUbROFR4U5+7rTnS6MS6pKpUaeQ/zXmgJ2V0sc2upTt4v2zLsnZX1eegkeRU9kmfa76
        WElyrTsC25oKVo6e9kbGnO2Pm4y/b5VFJORsyej7cDtfrEhYV5f5Mk79reBSabhg58Tr8Mm6HxnNg
        J8nlexO5gNUGekaDJPKVbKbTyae7LBzx1quCNZAN0M4f6R5I3NY4S4jnAGZL7fKAzZc2uBZeivhom
        fxPJ9h6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVZj7-000463-HD; Thu, 22 Oct 2020 12:29:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A0DF306099;
        Thu, 22 Oct 2020 14:29:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27418203CC4B3; Thu, 22 Oct 2020 14:29:49 +0200 (CEST)
Date:   Thu, 22 Oct 2020 14:29:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        srinivas.pandruvada@linux.intel.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>
Subject: Re: default cpufreq gov, was: [PATCH] sched/fair: check for idle core
Message-ID: <20201022122949.GW2628@hirez.programming.kicks-ass.net>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <34115486.YmRjPRKJaA@kreacher>
 <20201022120213.GG2611@hirez.programming.kicks-ass.net>
 <1790766.jaFeG3T87Z@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1790766.jaFeG3T87Z@kreacher>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22, 2020 at 02:19:29PM +0200, Rafael J. Wysocki wrote:
> > However I do want to retire ondemand, conservative and also very much
> > intel_pstate/active mode.
> 
> I agree in general, but IMO it would not be prudent to do that without making
> schedutil provide the same level of performance in all of the relevant use
> cases.

Agreed; I though to have understood we were there already.
