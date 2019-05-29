Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6AC62E304
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 19:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfE2RRj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 13:17:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfE2RRj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 May 2019 13:17:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A17B6309B15E;
        Wed, 29 May 2019 17:17:33 +0000 (UTC)
Received: from treble (ovpn-123-24.rdu2.redhat.com [10.10.123.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4D0210027CA;
        Wed, 29 May 2019 17:17:28 +0000 (UTC)
Date:   Wed, 29 May 2019 12:17:26 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
Message-ID: <20190529171726.obom7xql72bgbjhc@treble>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1905291230130.1962@cbobk.fhfr.pm>
 <20190529161028.a6kpywzpjazgql5u@treble>
 <nycvar.YFH.7.76.1905291818470.1962@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1905291818470.1962@cbobk.fhfr.pm>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 29 May 2019 17:17:38 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 29, 2019 at 06:26:59PM +0200, Jiri Kosina wrote:
> On Wed, 29 May 2019, Josh Poimboeuf wrote:
> 
> > hibernation_restore() is called by user space at runtime, via ioctl or 
> > sysfs.  So I think this still doesn't fix the case where you've disabled 
> > CPUs at runtime via sysfs, and then resumed from hibernation.  Or are we 
> > declaring that this is not a supported scenario?
> 
> Yeah I personally find that scenario awkward :) Anyway, cpuhp_smt_enable() 
> is going to online even those potentially "manually" offlined CPUs, isn't 
> it?
> 
> Are you perhaps suggesting to call enable_nonboot_cpus() instead of 
> cpuhp_smt_enable() here to make it more explicit?

Maybe, but I guess that wouldn't work as-is because it relies on
the frozen_cpus mask.  

But maybe this is just a scenario we don't care about anyway?

I still have the question about whether we could make mwait_play_dead()
monitor a fixed address.  If we could get that to work, that seems more
robust to me.

Another question.  With your patch, if booted with nosmt, is SMT still
disabled after you resume from hibernation?  I don't see how SMT would
get disabled again.

> > Is there are reason why maxcpus= doesn't do the CR4.MCE booted_once
> > dance?
> 
> I am not sure whether it's really needed. My understanding is that the MCE 
> issue happens only after primary sibling has been brought up; if that 
> never happened, MCE wouldn't be broadcasted to that core at all in the 
> first place.
> 
> But this needs to be confirmed by Intel.

Right, but can't maxcpus= create scenarios where only the primary
sibling has been brought up?

Anyway, Thomas indicated on IRC that maxcpus= may be deprecated and
should probably be documented as such.  So maybe it's another scenario
we don't care about.

-- 
Josh
