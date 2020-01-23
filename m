Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3217146D29
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 16:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgAWPpQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 10:45:16 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34888 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgAWPpQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2020 10:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CfGynnt/xKdfIoX3WMfV+TOt1SzqpkEnFYHQojJ4eyw=; b=McLHS2v0m0LRF8+Wgk153BavG
        1x0mpFvtr0BM2TLBd5GHvUOOmNcQ6c6eeCzhBn9NkfN6Z42mE1te7qDQiOlXcKUAinXGOFV7oLZ8m
        BRNE2Q5QW8deuAFp6aWaeJamLrDdM8xbWb5YkzYIcVYMR23KDhlUBf8NFLfrEYfPWF3g6UQKkRVq2
        Bx2S5CHsIwA953Tj/c8T2AP2OowZVDZqg8btcoK81EEuFFe9fohz4GNWYd7HYYjN2t57xZO2RdeQy
        w7kEMDLLy6uRPpf1WxwVnRKaKjKTlf7Z66+qfhos83Y5N0cQ5WYUkQtU3CR6zAZv1UPJQCf3r7qhq
        dV2rCZWSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuef2-0007oi-9n; Thu, 23 Jan 2020 15:44:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD64130067C;
        Thu, 23 Jan 2020 16:43:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7BE42B714F6E; Thu, 23 Jan 2020 16:44:45 +0100 (CET)
Date:   Thu, 23 Jan 2020 16:44:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Subject: Re: [PATCH v5 0/6] Add support for frequency invariance for (some)
 x86
Message-ID: <20200123154445.GW14914@hirez.programming.kicks-ass.net>
References: <20200122151617.531-1-ggherdovich@suse.cz>
 <CAJZ5v0gO18Oz4qvf3L9LfAX+1ww2XTeP_o_3WixYixB9d=s8Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gO18Oz4qvf3L9LfAX+1ww2XTeP_o_3WixYixB9d=s8Wg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 23, 2020 at 04:30:36PM +0100, Rafael J. Wysocki wrote:
> All looks good to me, so
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> for the whole series (and I'm assuming that it will go it through the tip tree).

Thanks, and yes, I've picked them up and will push them to tip if
nothing falls out.
