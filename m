Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E402CA6E8
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 16:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390355AbgLAPXT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 10:23:19 -0500
Received: from outbound-smtp62.blacknight.com ([46.22.136.251]:58647 "EHLO
        outbound-smtp62.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390132AbgLAPXS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2020 10:23:18 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id 87009FABC6
        for <linux-pm@vger.kernel.org>; Tue,  1 Dec 2020 15:22:26 +0000 (GMT)
Received: (qmail 26898 invoked from network); 1 Dec 2020 15:22:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 1 Dec 2020 15:22:26 -0000
Date:   Tue, 1 Dec 2020 15:22:24 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpuidle: Select polling interval based on a c-state with
 a longer target residency
Message-ID: <20201201152224.GU3371@techsingularity.net>
References: <20201130092241.GR3371@techsingularity.net>
 <CAJZ5v0h-ZBUMKqP5om7h67iMTe87GUf2Bw5dJ9tQN6MKwaTWzA@mail.gmail.com>
 <20201130223202.GT3371@techsingularity.net>
 <CAJZ5v0gMyMhjmFwV=j2+iu21K+upvrt0m_d-b5nFE5EfccNHjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gMyMhjmFwV=j2+iu21K+upvrt0m_d-b5nFE5EfccNHjg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 01, 2020 at 04:08:02PM +0100, Rafael J. Wysocki wrote:
> > > Also this is about certain drivers only which support the "polling
> > > idle state" (the ACPI one and intel_idle only AFAICS).  So I'm not
> > > sure about the framework-level tunable here.
> > >
> > > Moreover, to be precise, that value is the maximum time to do the
> > > polling (in one go) in the case when requesting any "physical" idle
> > > states is likely to hurt energy-efficiency or latency.  In particular,
> > > it doesn't mean that idle CPUs will do the idle polling every time.
> > >
> >
> > At first I was nodding along and thinking "sure". Then I started
> > thinking about what the configuration space then looks like and how a
> > user might reasonably interpret it. You were right during the review of
> > the first version, it's a mess because it's driver specific and difficult
> > to interpret even on a per-driver basis because there is no control of
> > when a rescheduling event may occur.
> 
> Indeed.
> 
> > You suggest making poll=0 would be valid but that might be interpreted
> > as being equivalent to idle=poll on x86 which is not the same thing.
> > processor_idle and intel_idle would have understandable semantics if the
> > parameter was maxpoll but it's not as understandable for haltpoll.
> 
> Well, my point was basically that if the plan was to add a boot
> parameter to control the polling behavior, it would be prudent to also
> allow the admin to specify that they didn't want any polling at all.
> 
> But frankly I was hoping to drive you away from that idea which seems
> to have worked. :-)
> 

Yes, it most certainly worked. Thanks for repeating yourself in a different
way so that your concern could penetrate my thick skull :D

> > Finally, the parameter partially ties us into the current
> > implementation. For example, the polling loop is based on clock time but
> > we know looking up the clock is costly in itself so it's very granular
> > based on the magic "check every 200 loops" logic meaning we can go over
> > the expected maxiumum polling inverval. If we ever changed that into a
> > calibration loop to estimate the number of loops then the polling interval
> > changes slightly even for the same parameter as we no longer depend on the
> > granularity of calling local_clock. If we ever decided to use adaptive
> > polling similar to haltpoll then the behaviour changes again resulting
> > in bugs because the driver.poll parameter means something new.
> 
> Right.
> 
> > Using min_cstate was definitely a hazard because it showed up in both
> > microbenchmarks and real workloads but you were right, lets only
> > introduce a tunable when and if there is no other choice in the matter.
> >
> > So, informally the following patch is the next candidate. I'm happy to
> > resend it as a separate mail if you prefer and think the patch is ok.
> 
> I actually can apply it right away, so no need to resend.
> 

Thanks very much.

-- 
Mel Gorman
SUSE Labs
