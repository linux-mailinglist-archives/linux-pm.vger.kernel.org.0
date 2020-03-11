Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B63311815AC
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 11:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgCKKVd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 11 Mar 2020 06:21:33 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:64984 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725976AbgCKKVd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 06:21:33 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20519258-1500050 
        for multiple; Wed, 11 Mar 2020 10:21:28 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <ac5fdd3c-bf47-60d3-edef-82d451266dcb@linux.intel.com>
References: <20200310214203.26459-1-currojerez@riseup.net> <20200310214203.26459-3-currojerez@riseup.net> <158387916218.28297.4489489879582782488@build.alporthouse.com> <ac5fdd3c-bf47-60d3-edef-82d451266dcb@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH 02/10] drm/i915: Adjust PM QoS response frequency based on GPU load.
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     Francisco Jerez <currojerez@riseup.net>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-pm@vger.kernel.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
Message-ID: <158392208709.10732.17989242384553331109@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Wed, 11 Mar 2020 10:21:27 +0000
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Tvrtko Ursulin (2020-03-11 10:00:41)
> 
> On 10/03/2020 22:26, Chris Wilson wrote:
> > Quoting Francisco Jerez (2020-03-10 21:41:55)
> >>   static inline void
> >> @@ -2386,6 +2397,9 @@ static void process_csb(struct intel_engine_cs *engine)
> >>                          /* port0 completed, advanced to port1 */
> >>                          trace_ports(execlists, "completed", execlists->active);
> >>   
> >> +                       if (atomic_xchg(&execlists->overload, 0))
> >> +                               intel_gt_pm_active_end(&engine->i915->gt);
> > 
> > So this looses track if we preempt a dual-ELSP submission with a
> > single-ELSP submission (and never go back to dual).
> > 
> > If you move this to the end of the loop and check
> > 
> > if (!execlists->active[1] && atomic_xchg(&execlists->overload, 0))
> >       intel_gt_pm_active_end(engine->gt);
> > 
> > so that it covers both preemption/promotion and completion.
> > 
> > However, that will fluctuate quite rapidly. (And runs the risk of
> > exceeding the sentinel.)
> > 
> > An alternative approach would be to couple along
> > schedule_in/schedule_out
> > 
> > atomic_set(overload, -1);
> > 
> > __execlists_schedule_in:
> >       if (!atomic_fetch_inc(overload)
> >               intel_gt_pm_active_begin(engine->gt);
> > __execlists_schedule_out:
> >       if (!atomic_dec_return(overload)
> >               intel_gt_pm_active_end(engine->gt);
> > 
> > which would mean we are overloaded as soon as we try to submit an
> > overlapping ELSP.
> 
> Putting it this low-level into submission code also would not work well 
> with GuC.

We can cross that bridge when it is built. [The GuC is also likely to
not want to play with us anyway, and just use SLPC.]

Now, I suspect we may want to use an engine utilisation (busy-stats or
equivalent) metric, but honestly if we can finally land this work it
brings huge benefit for GPU bound TDP constrained workloads. (p-state
loves to starve the GPU even when it provides no extra benefit for the
CPU.) We can raise the bar, establish expected behaviour and then work
to maintain and keep on improving.
-Chris
