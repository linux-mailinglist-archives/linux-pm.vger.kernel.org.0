Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900A32DE6A5
	for <lists+linux-pm@lfdr.de>; Fri, 18 Dec 2020 16:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgLRPdm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Dec 2020 10:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgLRPdm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Dec 2020 10:33:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C74AC0617A7;
        Fri, 18 Dec 2020 07:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ivzl+SgN1fSmo4LHwIz5rmX0mNUDsLZaBvVQA2TlPFI=; b=L7u/5ZwMZEsfNyllfNMqlLqYso
        icEocTd4pIA4y+rJOlU5KquYog1RzGuDm+xrPIwzUi12t4SMvvcYbLdSxbb2e9leLcrFUss2Fl0n1
        y2niBfN26cnXhCZ9uYXQ6BGCZ9/jtNplC8TR3MjoCXyF/lsWXIrAonBODAuVSzm4u8kttnbORN8A8
        s78dbXKm0rZp0GBe4QkUW6h+kVWNXz8ZsG+PEi4uJS4MEaBOUPhMV8/g3izbi0pLERo4y8m8fDpeV
        KJhwWf5I1RmRaDDyYH6a2gJ0lgSmvvfI51r6Pvf8Oy9GX6HwdX0LLyy6VwuADyTyP+VZn1637oxDp
        7aEb+Cdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kqHkB-0001Qr-8V; Fri, 18 Dec 2020 15:32:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CADA5300B22;
        Fri, 18 Dec 2020 16:32:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B45562BFB9808; Fri, 18 Dec 2020 16:32:31 +0100 (CET)
Date:   Fri, 18 Dec 2020 16:32:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        'Giovanni Gherdovich' <ggherdovich@suse.com>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        'Linux PM' <linux-pm@vger.kernel.org>,
        'LKML' <linux-kernel@vger.kernel.org>,
        'Viresh Kumar' <viresh.kumar@linaro.org>,
        'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        efault@gmx.de, Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>
Subject: Re: [PATCH v1 0/4] cpufreq: Allow drivers to receive more
 information from the governor
Message-ID: <20201218153231.GB2414@hirez.programming.kicks-ass.net>
References: <20360841.iInq7taT2Z@kreacher>
 <1607445035.2673.64.camel@suse.com>
 <CAJZ5v0j2u7MrO82+ubx01kvyhDUKo11mfyofF-TAqdSLx_i3Ng@mail.gmail.com>
 <001d01d6cd96$601c8a80$20559f80$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001d01d6cd96$601c8a80$20559f80$@net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 08, 2020 at 11:14:36AM -0800, Doug Smythies wrote:
> At least on my system, it is most evident for some of the pipe type tests,
> where the schedutil governor has never really known what to do. This patch
> set seems to add enough of a downward bias that this version of the schedutil
> governor now behaves much like the other versions

Yeah, pipe relies on task-task interaction, where one task waits on
another, and by boosting the producer the consumer can start earlier and
we get more cycles done etc.. Rather similar to IO-wait, where by
boosting the producer we gain throughput.

schedutil doesn't track anything useful here, but it is a semi common
pattern and it would be really good if we could somehow fix this.

We obviously have access to the task A wakes task B information, but I'm
not sure what to do with it, we're tried some things like this in the
past (although for slightly different reasons) and they've always ended
up being a mess :/
