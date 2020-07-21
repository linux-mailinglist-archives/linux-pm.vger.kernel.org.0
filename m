Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF0F228540
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 18:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgGUQZl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 12:25:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:38912 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgGUQZk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Jul 2020 12:25:40 -0400
IronPort-SDR: zStfbMFIlpraalvVd4sJhSPU0HChG4ij78Ry+S5VUf2J6SjrMUj/9A3XOhRALQ8DONZK2pANlD
 TCmFjU03gBLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="211715778"
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="211715778"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 09:25:37 -0700
IronPort-SDR: hryq/gywAQdtW3AZ3P9cFmuFkG1C1Uq9yicrFjyp1cWlHwY4DU4cxqNCrJ3fm8tqMsQ7pRxK4U
 kpZFmQREgUKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="327920958"
Received: from jacoraci-mobl.amr.corp.intel.com ([10.212.210.224])
  by orsmga007.jf.intel.com with ESMTP; 21 Jul 2020 09:25:36 -0700
Message-ID: <babeff29a60d3fadb5515eaf57f7bb42a1c9c792.camel@linux.intel.com>
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
Date:   Tue, 21 Jul 2020 09:25:36 -0700
In-Reply-To: <87mu3thiz5.fsf@riseup.net>
References: <3955470.QvD6XneCf3@kreacher> <87r1tdiqpu.fsf@riseup.net>
         <CAJZ5v0jaRm-wv+ZKhOyGJrrKZAsTKc3sq2GYyv0uerTTe3gXbQ@mail.gmail.com>
         <87imeoihqs.fsf@riseup.net>
         <CAJZ5v0hhLWvbNA6w0yHtzKa5ANR9yF++u63dh8wWAgkhbtLXXA@mail.gmail.com>
         <875zanhty6.fsf@riseup.net>
         <CAJZ5v0g2U+1wD5rUQwJ4_x9sQyvGyGiBiLFs7MA-xdhRBX9zBQ@mail.gmail.com>
         <87mu3thiz5.fsf@riseup.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-07-20 at 16:20 -0700, Francisco Jerez wrote:
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
> 
> > On Fri, Jul 17, 2020 at 2:21 AM Francisco Jerez <
> > currojerez@riseup.net> wrote:
> > > "Rafael J. Wysocki" <rafael@kernel.org> writes:
> > > 
{...]

> > Overall, so far, I'm seeing a claim that the CPU subsystem can be
> > made
> > use less energy and do as much work as before (which is what
> > improving
> > the energy-efficiency means in general) if the maximum frequency of
> > CPUs is limited in a clever way.
> > 
> > I'm failing to see what that clever way is, though.
> Hopefully the clarifications above help some.

To simplify:

Suppose I called a function numpy.multiply() to multiply two big arrays
and thread is a pegged to a CPU. Let's say it is causing CPU to
finish the job in 10ms and it is using a P-State of 0x20. But the same
job could have been done in 10ms even if it was using P-state of 0x16.
So we are not energy efficient. To really know where is the bottle neck
there are numbers of perf counters, may be cache was the issue, we
could rather raise the uncore frequency a little. A simple APRF,MPERF
counters are not enough. or we characterize the workload at different
P-states and set limits.
I think this is not you want to say for energy efficiency with your
changes. 

The way you are trying to improve "performance" is by caller (device
driver) to say how important my job at hand. Here device driver suppose
offload this calculations to some GPU and can wait up to 10 ms, you
want to tell CPU to be slow. But the p-state driver at a movement
observes that there is a chance of overshoot of latency, it will
immediately ask for higher P-state. So you want P-state limits based on
the latency requirements of the caller. Since caller has more knowledge
of latency requirement, this allows other devices sharing the power
budget to get more or less power, and improve overall energy efficiency
as the combined performance of system is improved.
Is this correct?

















