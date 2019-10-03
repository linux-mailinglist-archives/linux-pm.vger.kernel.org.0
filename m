Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D092CADCE
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2019 20:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbfJCSFn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Oct 2019 14:05:43 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59760 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbfJCSFn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2019 14:05:43 -0400
Received: from 79.184.253.225.ipv4.supernova.orange.pl (79.184.253.225) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 7611574cb3852698; Thu, 3 Oct 2019 20:05:40 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH v2 2/2] cpufreq: intel_pstate: Conditional frequency invariant accounting
Date:   Thu, 03 Oct 2019 20:05:40 +0200
Message-ID: <13106850.QMtCbivBLn@kreacher>
In-Reply-To: <20191002122926.385-3-ggherdovich@suse.cz>
References: <20191002122926.385-1-ggherdovich@suse.cz> <20191002122926.385-3-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, October 2, 2019 2:29:26 PM CEST Giovanni Gherdovich wrote:
> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> intel_pstate has two operating modes: active and passive. In "active"
> mode, the in-built scaling governor is used and in "passive" mode,
> the driver can be used with any governor like "schedutil". In "active"
> mode the utilization values from schedutil is not used and there is
> a requirement from high performance computing use cases, not to read
> any APERF/MPERF MSRs.

Well, this isn't quite convincing.

In particular, I don't see why the "don't read APERF/MPERF MSRs" argument
applies *only* to intel_pstate in the "active" mode.  What about intel_pstate
in the "passive" mode combined with the "performance" governor?  Or any other
governor different from "schedutil" for that matter?

And what about acpi_cpufreq combined with any governor different from
"schedutil"?

Scale invariance is not really needed in all of those cases right now AFAICS,
or is it?

So is the real concern that intel_pstate in the "active" mode reads the MPERF
and APERF MSRs by itself and that kind of duplicates what the scale invariance
code does and is redundant etc?



