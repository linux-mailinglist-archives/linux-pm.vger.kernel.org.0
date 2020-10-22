Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834D0295B57
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 11:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2510015AbgJVJFg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 05:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgJVJFg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 05:05:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1A4C0613CE;
        Thu, 22 Oct 2020 02:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZVZNelDFP1ISGQkJQIpjBgIP26XxQBw8Ne7CDYzrM/4=; b=WBbOr/6ZorL55TUfAGz02WKNDw
        FSMpWZPIZpafKc7SX6ucvdsvJrN5UpfIH4MGzRbpY0Ip/wA/gA891dtaREdy7hTg0VtGp/dGY2kEI
        rPHSfAbXrmFGIrYZIlEsM1JRj8/tnJ8exErz71p2m/VwWEwI9qEmRjrqqna85Hq5Icvx+7HAi1UIB
        c+Z8aPU1pz/UDPNjQci/dY8FY5DJZmlPHLkMc5U2l5kycDLbDjb/IhqsmHgTBCSMJVY36h8N5wafT
        VUAn7PkLuPCWmqE5L/tPHCNQABtJ9Q6wUP/nwmKR35Furp9xJri0qgFqrk5TcaxQJHGCPb8mBjUSr
        4MIwKYqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVWXE-0001mH-Tu; Thu, 22 Oct 2020 09:05:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7A923010D2;
        Thu, 22 Oct 2020 11:05:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89CEB2B7802F2; Thu, 22 Oct 2020 11:05:23 +0200 (CEST)
Date:   Thu, 22 Oct 2020 11:05:23 +0200
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
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
Message-ID: <20201022090523.GV2628@hirez.programming.kicks-ass.net>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <20200716115605.GR10769@hirez.programming.kicks-ass.net>
 <20201022083255.37xl3lffwk5qo6uk@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022083255.37xl3lffwk5qo6uk@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22, 2020 at 02:02:55PM +0530, Viresh Kumar wrote:
> On 16-07-20, 13:56, Peter Zijlstra wrote:

> > Another point is that cpu_util() vs turbo is a bit iffy, and to that,
> > things like x86-APERF/MPERF and ARM-AMU got mentioned. Those might also
> > have the benefit of giving you values that match your own sampling
> > interval (100ms), where the sched stuff is PELT (64,32.. based).
> 
> I believe the above stuff is more around additional improvements that
> we can do over this change, and probably Lukasz was looking to do
> that.
> 
> > So what I've been thinking is that cpufreq drivers ought to be able to
> > supply this method, and only when they lack, can the cpufreq-governor
> > (schedutil) install a fallback.
> 
> One of the issues I see with this is that schedutil may not be
> available in all configurations and it is still absolutely fine to
> using the suggested helper to get the energy numbers in such cases, so
> we shouldn't really make it scheutil dependent.

The only constraint on schedutil is SMP I think; aside from that it
should/could always be available.

Given the trainwreck here:

  20201022071145.GM2628@hirez.programming.kicks-ass.net

(you're on Cc), I'm starting to lean more and more towards making it
unconditionally available (when SMP).

Anybody forcing it off either sets performance (in which case we don't
care about energy usage anyway) or they select one of the old (broken)
ondemand/conservative things and I don't give a crap.


