Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299D22A85A7
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 19:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgKESEN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 13:04:13 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45138 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbgKESEM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 13:04:12 -0500
Received: from 89-64-88-191.dynamic.chello.pl (89.64.88.191) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.514)
 id 4284eb2aea7df779; Thu, 5 Nov 2020 19:04:09 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Victor Ding <victording@google.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>, linux-pm@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        x86@kernel.org
Subject: Re: [PATCH v3 3/4] powercap: Add AMD Fam17h RAPL support
Date:   Thu, 05 Nov 2020 19:04:08 +0100
Message-ID: <2121012.oOYSSSs1xd@kreacher>
In-Reply-To: <9ea15f21febf47d5d6f62911fe0141a2ae5d5e2b.camel@linux.intel.com>
References: <20201027072358.13725-1-victording@google.com> <CANqTbdafN+NekRN3oO35o-7DXvu1p_9SwH_XVkw1DmbgSk9y6w@mail.gmail.com> <9ea15f21febf47d5d6f62911fe0141a2ae5d5e2b.camel@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, November 5, 2020 6:14:01 PM CET Srinivas Pandruvada wrote:
> On Thu, 2020-11-05 at 14:53 +1100, Victor Ding wrote:
> > On Wed, Nov 4, 2020 at 1:17 PM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > > On Wed, 2020-11-04 at 12:43 +1100, Victor Ding wrote:
> > > > On Wed, Nov 4, 2020 at 4:09 AM Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > > On Tue, 2020-11-03 at 17:10 +1100, Victor Ding wrote:
> > > > > > On Mon, Nov 2, 2020 at 12:39 PM Zhang Rui <
> > > > > > rui.zhang@intel.com>
> > > > > > wrote:
> > > > > > > On Tue, 2020-10-27 at 07:23 +0000, Victor Ding wrote:
> > > > > > > > This patch enables AMD Fam17h RAPL support for the power
> > > > > > > > capping
> > > > > > > > framework. The support is as per AMD Fam17h Model31h
> > > > > > > > (Zen2)
> > > > > > > > and
> > > > > > > > model 00-ffh (Zen1) PPR.
> > > > > > > > 
> > > > > > > > Tested by comparing the results of following two sysfs
> > > > > > > > entries
> > > > > > > > and
> > > > > > > > the
> > > > > > > > values directly read from corresponding MSRs via
> > > > > > > > /dev/cpu/[x]/msr:
> > > > > > > >   /sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj
> > > > > > > >   /sys/class/powercap/intel-rapl/intel-rapl:0/intel-
> > > > > > > > rapl:0:0/energy_uj
> > > > > 
> > > > > Is this for just energy reporting? No capping of power?
> > > > Correct, the hardware does not support capping of power.
> > > I wonder if there is no capping, is this the right interface?
> > > Do you have specific user space, which cares about this?
> > We have tools that previously developed to measure energy status
> > on Intel via the powercap interface. Powercap is the only interface
> > allowing reading RAPL energy counters without requiring MSR access
> > privileges. We want to use these tools on AMD with minimal
> > modifications.
> > I believe the powercap interface should support these counters,
> > regardless of the use cases, mainly for two reasons:
> > 1. Powercap interface already supports monitoring-only power domains,
> > e.g. power limit is locked by BIOS or the (Intel) CPU does not expose
> > an
> > MSR for certain power domains. The latter is the exact situation on
> > AMD;
> > 2. As AMD has partially introduced the equivalent of Intel's RAPL, we
> > should leverage this opportunity to reduce the divergence in the
> > APIs. i.e.
> > OS as a hardware abstraction layer should allow users to use the same
> > set of APIs to access RAPL features if it issupported on both Intel
> > and AMD.
> > In this specific case, if users can query for Intel's RAPL counters
> > via
> > powercap, they should be able to do so as well for AMD's.
> > > I think these counters are already exposed via hwmon sysf.
> > Yes, they were introduced early this year. However, it is not the
> > same as
> > the counters exposed via powercap interface: powercap exposes the
> > actual value of the energy counters while hwmon adds an accumulation
> > layer on top.
> > In addition, I don't think Intel's RAPL counters are exposed via
> > hwmon;
> > therefore: 1. existing fine grade power monitoring tools are not
> > based on
> > hwmon; 2. new tools cannot query the same set of counters via the
> > same
> > API so that they have to actively maintain two sets of logic.
> 
> Fine with me.

OK, I'll queue up the series for 5.11 then if there are no other concerns.

Thanks!



