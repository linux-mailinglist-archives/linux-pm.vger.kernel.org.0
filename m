Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75B721A02D
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 14:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgGIMny (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 08:43:54 -0400
Received: from foss.arm.com ([217.140.110.172]:56178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgGIMnw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Jul 2020 08:43:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 232D61FB;
        Thu,  9 Jul 2020 05:43:51 -0700 (PDT)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B892C3F71E;
        Thu,  9 Jul 2020 05:43:50 -0700 (PDT)
Date:   Thu, 9 Jul 2020 13:43:49 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Puhov <peter.puhov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC 0/3] cpufreq: cppc: Add support for frequency invariance
Message-ID: <20200709124349.GA15342@arm.com>
References: <cover.1594289009.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1594289009.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

I'll put all my comments here for now, as they refer more to the design
of the solution.

I hope it won't be too repetitive compared to what we previously discussed
offline. I understand you want to get additional points of view.

On Thursday 09 Jul 2020 at 15:43:32 (+0530), Viresh Kumar wrote:
> Hello,
> 
> CPPC cpufreq driver is used for ARM servers and this patch series tries
> to provide frequency invariance support for them. The same is also
> provided using a specific hardware extension, known as AMU (Activity
> Monitors Unit), but that is optional for platforms and at least few of
> them don't have it.
> 
> This patchset allows multiple parts of the kernel to provide the same
> functionality, by registering with the topology core.
> 
> This is tested with some hacks, as I didn't have access to the right
> hardware, on the ARM64 hikey board to check the overall functionality
> and that works fine.
> 
> Ionela/Peter Puhov, it would be nice if you guys can give this a shot.
> 

I believe the code is unnecessarily invasive for the functionality it
tries to introduce and it does break existing functionality.


 - (1) From code readability and design point of view, this switching
       between an architectural method and a driver method complicates
       an already complicated situation. We already have code that
       chooses between a cpufreq-based method and a counter based method
       for frequency invariance. This would basically introduce a choice
       between a cpufreq-based method through arch_set_freq_scale(), an
       architectural counter-based method through arch_set_freq_tick(),
       and another cpufreq-based method that piggy-backs on the
       architectural arch_set_freq_tick().

       As discussed offline, before I even try to begin accepting the
       possibility of this complicated mix, I would like to know why
       methods of obtaining the same thing by using the cpufreq
       arch_set_freq_scale() or even the more invasive wrapping of the
       counter read functions is not working. I believe those solutions
       would brings only a fraction of the complexity added through this
       set.

 - (2) For 1/3, the presence of AMU counters does not guarantee their
       usability for frequency invariance. I know you wanted to avoid
       the complications of AMUs being marked as supporting invariance
       after the cpufreq driver init function, but this breaks the
       scenario in which the maximum frequency is invalid.

 - (3) For 2/3, currently we support platforms that have partial support
       for AMUs, while this would not be supported here. The suggestions
       at (1) would give us this for free.


While I'm keen on having invariance support for CPPC when lacking part
or full support for AMUs, I think we should explore alternative designs.
I can try to come up with some code suggestions, but it will take a few
days as I have many other things in the air :).

I'm happy to test this when the design is agreed on.

Hope it helps,
Ionela.
