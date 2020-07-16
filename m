Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE35221957
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 03:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGPBOn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 21:14:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:4087 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgGPBOn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jul 2020 21:14:43 -0400
IronPort-SDR: 4rRE5yDWAgCmi1xDYvC4uezYbA+q2uRkctnD33u7RQG49A+TU2uIm+c8lagdwH3LOP8AmpCyee
 kGA70ZFUq2zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="167431159"
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="167431159"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 18:14:37 -0700
IronPort-SDR: /apEjM2sbtI+InvtVljomDOuqO+E/HTR6Z8Yvtnwa8mdz35nmskknQIDLsclCyHnAIyKrGQMZ2
 +Soee8unFA/g==
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="286311658"
Received: from spandruv-mobl.amr.corp.intel.com ([10.255.229.194])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 18:14:37 -0700
Message-ID: <44797cd1312843e5998070aec236b1cd80c48d14.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Implement passive mode with HWP
 enabled
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Francisco Jerez <currojerez@riseup.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Date:   Wed, 15 Jul 2020 18:14:35 -0700
In-Reply-To: <87imeoihqs.fsf@riseup.net>
References: <3955470.QvD6XneCf3@kreacher> <87r1tdiqpu.fsf@riseup.net>
         <CAJZ5v0jaRm-wv+ZKhOyGJrrKZAsTKc3sq2GYyv0uerTTe3gXbQ@mail.gmail.com>
         <87imeoihqs.fsf@riseup.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-07-15 at 14:35 -0700, Francisco Jerez wrote:
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
> 
> > On Wed, Jul 15, 2020 at 2:09 AM Francisco Jerez <
> > currojerez@riseup.net> wrote:
> > > "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> > > 
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > 

[...]

> > > > I don't think that's accurate.  I've looked at hundreds of
> > > > traces
> while
> my series [1] was in control of HWP_REQ_MAX and I've never seen an
> excursion above the maximum HWP_REQ_MAX control specified by it
> within a
> given P-state domain, even while that maximum specified was well into
> the turbo range.  So, yeah, I agree that HWP_REQ_MAX is nothing like
> a
> hard limit, particularly when multiple threads are running on the
> same
> clock domain, but the processor will still make its best effort to
> limit
> the clock frequency to the maximum of the requested maximums, even if
> it
> happens to be within the turbo range.  That doesn't make it useless.
> The exact same thing can be said about controlling HWP_REQ_MIN as
> you're
> doing now in this revision of your patch, BTW.
> 
> If you don't believe me here is the turbostat sample with maximum
> Bzy_MHz I get on the computer I'm sitting on right now while
> compiling a
> kernel on CPU0 if I set HWP_REQ_MAX to 0x1c (within the turbo range):
> 
> > Core    CPU     Avg_MHz
> > Busy%   Bzy_MHz            HWP_REQ      PkgWatt CorWatt
> > -       -       757     27.03   2800    0x0000000000000000      7.1
> > 3    4.90
> > 0       0       2794    99.77   2800    0x0000000080001c04      7.1
> > 3    4.90
> > 0       2       83      2.98    2800    0x0000000080001c04
> > 1       1       73      2.60    2800    0x0000000080001c04
> > 1       3       78      2.79    2800    0x0000000080001c04
> 
> With the default HWP_REQUEST:
> 
> > Core    CPU     Avg_MHz
> > Busy%   Bzy_MHz            HWP_REQ      PkgWatt CorWatt
> > -       -       814     27.00   3015    0x0000000000000000      8.4
> > 9    6.18
> > 0       0       2968    98.24   3021    0x0000000080001f04      8.4
> > 9    6.18
> > 0       2       84      2.81    2982    0x0000000080001f04
> > 1       1       99      3.34    2961    0x0000000080001f04
> > 1       3       105     3.60    2921    0x0000000080001f04

Correct. In HWP mode this is possible to lower limit in turbo region
conditionally. In legacy mode you can't with turbo activation ratio.

But what we don't want set max and min perf and use like desired to run
at a P-state overriding HWP or limit the range where HWP can't do any
meaningful selection.

> > Generally, I'm not quite convinced that limiting the max frequency
> > is
> > really the right choice for controlling the processor's power draw
> > on
> > the systems in question.  There are other ways to do that, which in
> > theory should be more effective.  I mentioned RAPL somewhere in
> > this
> > context and there's the GUC firmware too.
> 
> I feel like we've had that conversation before and it's somewhat
> off-topic so I'll keep it short: Yes, in theory RAPL is more
> effective
> than HWP_REQ_MAX as a mechanism to limit the absolute power
> consumption
> of the processor package, but that's not the purpose of [1], its
> purpose
> is setting a lower limit to the energy efficiency of the processor
> when
> the maximum usable CPU frequency is known (due to the existence of an
> IO
> device bottleneck) -- And if the maximum usable CPU frequency is the
> information we have at hand, controlling the maximum CPU frequency
> directly is optimal, rather than trying to find the RAPL constraint
> that
> achieves the same average frequency by trial an error.  Also, in
> theory,
> even if you had an oracle to tell you what the appropriate RAPL
> constraint is, the result would necessarily be more energy-
> inefficient
> than controlling the maximum CPU frequency directly, since you're
> giving
> the processor additional freedom to run at frequencies above the one
> you
> want to average, which is guaranteed to be more energy-inefficient
> than
> running at that fixed frequency, assuming we are in the region of
> convexity of the processor's power curve.
> 
> Anyway, if you still have some disagreement on the theoretical
> details
> you're more than welcome to bring up the matter on the other thread
> [1],
> or accept the invitation for a presentation I sent you months ago...
> ;)

