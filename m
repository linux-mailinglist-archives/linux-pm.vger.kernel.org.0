Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 395CE180B86
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 23:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgCJW0G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 10 Mar 2020 18:26:06 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:58034 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727582AbgCJW0G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 18:26:06 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20515138-1500050 
        for multiple; Tue, 10 Mar 2020 22:26:02 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200310214203.26459-3-currojerez@riseup.net>
References: <20200310214203.26459-1-currojerez@riseup.net> <20200310214203.26459-3-currojerez@riseup.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [Intel-gfx] [PATCH 02/10] drm/i915: Adjust PM QoS response frequency based on GPU load.
To:     Francisco Jerez <currojerez@riseup.net>,
        intel-gfx@lists.freedesktop.org, linux-pm@vger.kernel.org
Message-ID: <158387916218.28297.4489489879582782488@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Tue, 10 Mar 2020 22:26:02 +0000
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Francisco Jerez (2020-03-10 21:41:55)
> diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/gt/intel_lrc.c
> index b9b3f78f1324..a5d7a80b826d 100644
> --- a/drivers/gpu/drm/i915/gt/intel_lrc.c
> +++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
> @@ -1577,6 +1577,11 @@ static void execlists_submit_ports(struct intel_engine_cs *engine)
>         /* we need to manually load the submit queue */
>         if (execlists->ctrl_reg)
>                 writel(EL_CTRL_LOAD, execlists->ctrl_reg);
> +
> +       if (execlists_num_ports(execlists) > 1 &&
pending[1] is always defined, the minimum submission is one slot, with
pending[1] as the sentinel NULL.

> +           execlists->pending[1] &&
> +           !atomic_xchg(&execlists->overload, 1))
> +               intel_gt_pm_active_begin(&engine->i915->gt);

engine->gt

>  }
>  
>  static bool ctx_single_port_submission(const struct intel_context *ce)
> @@ -2213,6 +2218,12 @@ cancel_port_requests(struct intel_engine_execlists * const execlists)
>         clear_ports(execlists->inflight, ARRAY_SIZE(execlists->inflight));
>  
>         WRITE_ONCE(execlists->active, execlists->inflight);
> +
> +       if (atomic_xchg(&execlists->overload, 0)) {
> +               struct intel_engine_cs *engine =
> +                       container_of(execlists, typeof(*engine), execlists);
> +               intel_gt_pm_active_end(&engine->i915->gt);
> +       }
>  }
>  
>  static inline void
> @@ -2386,6 +2397,9 @@ static void process_csb(struct intel_engine_cs *engine)
>                         /* port0 completed, advanced to port1 */
>                         trace_ports(execlists, "completed", execlists->active);
>  
> +                       if (atomic_xchg(&execlists->overload, 0))
> +                               intel_gt_pm_active_end(&engine->i915->gt);

So this looses track if we preempt a dual-ELSP submission with a
single-ELSP submission (and never go back to dual).

If you move this to the end of the loop and check

if (!execlists->active[1] && atomic_xchg(&execlists->overload, 0))
	intel_gt_pm_active_end(engine->gt);

so that it covers both preemption/promotion and completion.

However, that will fluctuate quite rapidly. (And runs the risk of
exceeding the sentinel.)

An alternative approach would be to couple along
schedule_in/schedule_out

atomic_set(overload, -1);

__execlists_schedule_in:
	if (!atomic_fetch_inc(overload)
		intel_gt_pm_active_begin(engine->gt);
__execlists_schedule_out:
	if (!atomic_dec_return(overload)
		intel_gt_pm_active_end(engine->gt);

which would mean we are overloaded as soon as we try to submit an
overlapping ELSP.


The metric feels very multiple client (game + display server, or
saturated transcode) centric. In the endless kernel world, we expect
100% engine utilisation from a single context, and never a dual-ELSP
submission. They are also likely to want to avoid being throttled to
converse TDP for the CPU.

Should we also reduce the overload for the number of clients who are
waiting for interrupts from the GPU, so that their wakeup latency is not
impacted?
-Chris
