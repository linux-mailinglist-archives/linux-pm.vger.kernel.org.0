Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 458D1108AB1
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 10:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfKYJWI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 04:22:08 -0500
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:51589 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725938AbfKYJWI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 04:22:08 -0500
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Nov 2019 04:22:06 EST
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id E28C41C472F
        for <linux-pm@vger.kernel.org>; Mon, 25 Nov 2019 09:16:39 +0000 (GMT)
Received: (qmail 28355 invoked from network); 25 Nov 2019 09:16:39 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 Nov 2019 09:16:39 -0000
Date:   Mon, 25 Nov 2019 09:16:37 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'Giovanni Gherdovich' <ggherdovich@suse.cz>,
        'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Borislav Petkov' <bp@suse.de>, 'Len Brown' <lenb@kernel.org>,
        "'Rafael J . Wysocki'" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Matt Fleming' <matt@codeblueprint.co.uk>,
        'Viresh Kumar' <viresh.kumar@linaro.org>,
        'Juri Lelli' <juri.lelli@redhat.com>,
        'Paul Turner' <pjt@google.com>,
        'Vincent Guittot' <vincent.guittot@linaro.org>,
        'Quentin Perret' <qperret@qperret.net>,
        'Dietmar Eggemann' <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v4 1/6] x86,sched: Add support for frequency invariance
Message-ID: <20191125091637.GB3016@techsingularity.net>
References: <20191113124654.18122-1-ggherdovich@suse.cz>
 <20191113124654.18122-2-ggherdovich@suse.cz>
 <000001d5a29b$c944fd70$5bcef850$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <000001d5a29b$c944fd70$5bcef850$@net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Nov 23, 2019 at 11:49:57PM -0800, Doug Smythies wrote:
> Hi all,
> 
> The address list here is likely incorrect,
> and this e-mail is really about a kernel 5.4
> bisected regression.
> 
> It had been since mid September, and kernel 5.3-rc8 since
> I had tried this, so I wanted to try it again. Call it due diligence.
> I focused on my own version of the "gitsource" test.
> 
> Kernel 5.4-rc8 (as a baseline reference).
> 
> My results were extremely surprising.
> 
> As it turns out, at least on my test computer, both the
> acpi-cpufreq and intel_cpufreq CPU frequency scaling drivers
> using the schedutil governor are broken. For the tests that
> I ran, there is negligible difference between them and the
> performance governor. So, one might argue that they are not
> broken, but rather working incredibly well, which if true
> then this patch is no longer needed.
> 

I don't think that is necessarily fair. It still makes sense that the
"size" of a task is independent of the frequency the CPU is running at
for load balancing decisions and should be merged on that basis alone. If
the scheduler made perfect decisions on task location then there would
be negligible difference between ondemand (or powersave if intel_pstate)
and performance governor too. cpufreq tends to be more noticable under
the current implementation as tasks are a lot more mobile than they need
to be for basic workloads.

-- 
Mel Gorman
SUSE Labs
