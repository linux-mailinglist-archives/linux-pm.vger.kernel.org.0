Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A463718156B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 11:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgCKKAr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 06:00:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:21772 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728444AbgCKKAr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 06:00:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 03:00:46 -0700
X-IronPort-AV: E=Sophos;i="5.70,540,1574150400"; 
   d="scan'208";a="231643406"
Received: from pkosiack-mobl2.ger.corp.intel.com (HELO [10.252.21.27]) ([10.252.21.27])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Mar 2020 03:00:44 -0700
Subject: Re: [Intel-gfx] [PATCH 02/10] drm/i915: Adjust PM QoS response
 frequency based on GPU load.
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Francisco Jerez <currojerez@riseup.net>,
        intel-gfx@lists.freedesktop.org, linux-pm@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
References: <20200310214203.26459-1-currojerez@riseup.net>
 <20200310214203.26459-3-currojerez@riseup.net>
 <158387916218.28297.4489489879582782488@build.alporthouse.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <ac5fdd3c-bf47-60d3-edef-82d451266dcb@linux.intel.com>
Date:   Wed, 11 Mar 2020 10:00:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <158387916218.28297.4489489879582782488@build.alporthouse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 10/03/2020 22:26, Chris Wilson wrote:
> Quoting Francisco Jerez (2020-03-10 21:41:55)
>> diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/gt/intel_lrc.c
>> index b9b3f78f1324..a5d7a80b826d 100644
>> --- a/drivers/gpu/drm/i915/gt/intel_lrc.c
>> +++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
>> @@ -1577,6 +1577,11 @@ static void execlists_submit_ports(struct intel_engine_cs *engine)
>>          /* we need to manually load the submit queue */
>>          if (execlists->ctrl_reg)
>>                  writel(EL_CTRL_LOAD, execlists->ctrl_reg);
>> +
>> +       if (execlists_num_ports(execlists) > 1 &&
> pending[1] is always defined, the minimum submission is one slot, with
> pending[1] as the sentinel NULL.
> 
>> +           execlists->pending[1] &&
>> +           !atomic_xchg(&execlists->overload, 1))
>> +               intel_gt_pm_active_begin(&engine->i915->gt);
> 
> engine->gt
> 
>>   }
>>   
>>   static bool ctx_single_port_submission(const struct intel_context *ce)
>> @@ -2213,6 +2218,12 @@ cancel_port_requests(struct intel_engine_execlists * const execlists)
>>          clear_ports(execlists->inflight, ARRAY_SIZE(execlists->inflight));
>>   
>>          WRITE_ONCE(execlists->active, execlists->inflight);
>> +
>> +       if (atomic_xchg(&execlists->overload, 0)) {
>> +               struct intel_engine_cs *engine =
>> +                       container_of(execlists, typeof(*engine), execlists);
>> +               intel_gt_pm_active_end(&engine->i915->gt);
>> +       }
>>   }
>>   
>>   static inline void
>> @@ -2386,6 +2397,9 @@ static void process_csb(struct intel_engine_cs *engine)
>>                          /* port0 completed, advanced to port1 */
>>                          trace_ports(execlists, "completed", execlists->active);
>>   
>> +                       if (atomic_xchg(&execlists->overload, 0))
>> +                               intel_gt_pm_active_end(&engine->i915->gt);
> 
> So this looses track if we preempt a dual-ELSP submission with a
> single-ELSP submission (and never go back to dual).
> 
> If you move this to the end of the loop and check
> 
> if (!execlists->active[1] && atomic_xchg(&execlists->overload, 0))
> 	intel_gt_pm_active_end(engine->gt);
> 
> so that it covers both preemption/promotion and completion.
> 
> However, that will fluctuate quite rapidly. (And runs the risk of
> exceeding the sentinel.)
> 
> An alternative approach would be to couple along
> schedule_in/schedule_out
> 
> atomic_set(overload, -1);
> 
> __execlists_schedule_in:
> 	if (!atomic_fetch_inc(overload)
> 		intel_gt_pm_active_begin(engine->gt);
> __execlists_schedule_out:
> 	if (!atomic_dec_return(overload)
> 		intel_gt_pm_active_end(engine->gt);
> 
> which would mean we are overloaded as soon as we try to submit an
> overlapping ELSP.

Putting it this low-level into submission code also would not work well 
with GuC.

How about we try to keep some accounting one level higher, as the i915 
scheduler is passing requests on to the backend for execution?

Or number of runnable contexts, if the distinction between contexts and 
requests is better for this purpose.

Problematic bit in going one level higher though is that the exit point 
is less precisely coupled to the actual state. Or maybe with aggressive 
engine retire we have nowadays it wouldn't be a problem.

Regards,

Tvrtko

> 
> 
> The metric feels very multiple client (game + display server, or
> saturated transcode) centric. In the endless kernel world, we expect
> 100% engine utilisation from a single context, and never a dual-ELSP
> submission. They are also likely to want to avoid being throttled to
> converse TDP for the CPU.
> 
> Should we also reduce the overload for the number of clients who are
> waiting for interrupts from the GPU, so that their wakeup latency is not
> impacted?
> -Chris
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
> 
