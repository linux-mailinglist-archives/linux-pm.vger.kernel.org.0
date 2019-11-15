Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37731FDB5D
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 11:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfKOK2n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 05:28:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:38222 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727122AbfKOK2m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Nov 2019 05:28:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C9040AB71;
        Fri, 15 Nov 2019 10:28:40 +0000 (UTC)
Message-ID: <1573814061.28635.2.camel@suse.cz>
Subject: Re: [PATCH v4 5/6] x86,sched: Add support for frequency invariance
 on ATOM
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
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
Date:   Fri, 15 Nov 2019 11:34:21 +0100
In-Reply-To: <64baa18f7cd6066cc50360928d77504c1b68773e.camel@linux.intel.com>
References: <20191113124654.18122-1-ggherdovich@suse.cz>
         <20191113124654.18122-6-ggherdovich@suse.cz>
         <64baa18f7cd6066cc50360928d77504c1b68773e.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-11-13 at 08:50 -0800, Srinivas Pandruvada wrote:
> On Wed, 2019-11-13 at 13:46 +0100, Giovanni Gherdovich wrote:
> > The scheduler needs the ratio freq_curr/freq_max for frequency-
> > invariant
> > accounting. On all ATOM CPUs prior to Goldmont, set freq_max to the
> > 1-core
> > turbo ratio.
> > 
> > We intended to perform tests validating that this patch doesn't
> > regress in
> > terms of energy efficiency, given that this is the primary concern on
> > Atom
> > processors. Alas, we found out that turbostat doesn't support reading
> > RAPL
> > interfaces on our test machine (Airmont), and we don't have external
> > equipment
> > to measure power consumption; all we have is the performance results
> > of the
> > benchmarks we ran.
> > 
> 
> I can run some benchmarks on this.
> 

That'd be appreciated, thank you Srinivas.


Giovanni
