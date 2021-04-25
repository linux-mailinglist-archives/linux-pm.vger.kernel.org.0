Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CD236A6D8
	for <lists+linux-pm@lfdr.de>; Sun, 25 Apr 2021 13:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhDYLH6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Apr 2021 07:07:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:59806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhDYLH5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 25 Apr 2021 07:07:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B710AF45;
        Sun, 25 Apr 2021 11:07:17 +0000 (UTC)
Date:   Sun, 25 Apr 2021 13:07:14 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, joedecke@de.ibm.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpuidle/pseries: Fixup CEDE0 latency only for POWER10
 onwards
Message-ID: <20210425110714.GH6564@kitsune.suse.cz>
References: <1619104049-5118-1-git-send-email-ego@linux.vnet.ibm.com>
 <20210423073551.GZ6564@kitsune.suse.cz>
 <YILu6/GK+RwpskCc@drishya.in.ibm.com>
 <20210423174505.GE6564@kitsune.suse.cz>
 <YIMSCjTzcSwjQtRi@drishya.in.ibm.com>
 <20210423184216.GG6564@kitsune.suse.cz>
 <YIPKrIb+tY39taZv@drishya.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIPKrIb+tY39taZv@drishya.in.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Apr 24, 2021 at 01:07:16PM +0530, Vaidyanathan Srinivasan wrote:
> * Michal Such?nek <msuchanek@suse.de> [2021-04-23 20:42:16]:
> 
> > On Fri, Apr 23, 2021 at 11:59:30PM +0530, Vaidyanathan Srinivasan wrote:
> > > * Michal Such?nek <msuchanek@suse.de> [2021-04-23 19:45:05]:
> > > 
> > > > On Fri, Apr 23, 2021 at 09:29:39PM +0530, Vaidyanathan Srinivasan wrote:
> > > > > * Michal Such?nek <msuchanek@suse.de> [2021-04-23 09:35:51]:
> > > > > 
> > > > > > On Thu, Apr 22, 2021 at 08:37:29PM +0530, Gautham R. Shenoy wrote:
> > > > > > > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > > > > > > 
> > > > > > > Commit d947fb4c965c ("cpuidle: pseries: Fixup exit latency for
> > > > > > > CEDE(0)") sets the exit latency of CEDE(0) based on the latency values
> > > > > > > of the Extended CEDE states advertised by the platform
> > > > > > > 
> > > > > > > On some of the POWER9 LPARs, the older firmwares advertise a very low
> > > > > > > value of 2us for CEDE1 exit latency on a Dedicated LPAR. However the
> > > > > > Can you be more specific about 'older firmwares'?
> > > > > 
> > > > > Hi Michal,
> > > > > 
> > > > > This is POWER9 vs POWER10 difference, not really an obsolete FW.  The
> > > > > key idea behind the original patch was to make the H_CEDE latency and
> > > > > hence target residency come from firmware instead of being decided by
> > > > > the kernel.  The advantage is such that, different type of systems in
> > > > > POWER10 generation can adjust this value and have an optimal H_CEDE
> > > > > entry criteria which balances good single thread performance and
> > > > > wakeup latency.  Further we can have additional H_CEDE state to feed
> > > > > into the cpuidle.  
> > > > 
> > > > So all POWER9 machines are affected by the firmware bug where firmware
> > > > reports CEDE1 exit latency of 2us and the real latency is 5us which
> > > > causes the kernel to prefer CEDE1 too much when relying on the values
> > > > supplied by the firmware. It is not about 'older firmware'.
> > > 
> > > Correct.  All POWER9 systems running Linux as guest LPARs will see
> > > extra usage of CEDE idle state, but not baremetal (PowerNV).
> > > 
> > > The correct definition of the bug or miss-match in expectation is that
> > > firmware reports wakeup latency from a core/thread wakeup timing, but
> > > not end-to-end time from sending a wakeup event like an IPI using
> > > H_calls and receiving the events on the target.  Practically there are
> > > few extra micro-seconds needed after deciding to wakeup a target
> > > core/thread to getting the target to start executing instructions
> > > within the LPAR instance.
> > 
> > Thanks for the detailed explanation.
> > 
> > Maybe just adding a few microseconds to the reported time would be a
> > more reasonable workaround than using a blanket fixed value then.
> 
> Yes, that is an option.  But that may only reduce the difference
> between existing kernel and new kernel unless we make it the same
> number.  Further we are fixing this in P10 and hence we will have to
> add "if(P9) do the compensation" and otherwise take it as is.  That
> would not be elegant.  Given that our goal for P9 platform is to not
> introduce changes in H_CEDE entry behaviour, we arrived at this
> approach (this small patch) and this also makes it easy to backport to
> various distro products.

I don't see how this is more elegent.

The current patch is

if(p9)
	use fixed value

the suggested patch is

if(p9)
	apply compensation

That is either will add one branch for the affected platform.

But I understand if you do not have confidence that the compensation is
the same in all cases and do not have the opportunity to measure it it
may be simpler to apply one very conservative adjustment.

Thanks

Michal
