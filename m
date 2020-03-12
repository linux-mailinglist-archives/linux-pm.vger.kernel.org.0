Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9D04182FA0
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 12:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCLLwn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 07:52:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:20021 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgCLLwm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Mar 2020 07:52:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 04:52:41 -0700
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="246345125"
Received: from pkosiack-mobl2.ger.corp.intel.com (HELO [10.252.21.27]) ([10.252.21.27])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Mar 2020 04:52:40 -0700
Subject: Re: [Intel-gfx] [PATCH 02/10] drm/i915: Adjust PM QoS response
 frequency based on GPU load.
To:     Francisco Jerez <currojerez@riseup.net>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, linux-pm@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
References: <20200310214203.26459-1-currojerez@riseup.net>
 <20200310214203.26459-3-currojerez@riseup.net>
 <158387916218.28297.4489489879582782488@build.alporthouse.com>
 <ac5fdd3c-bf47-60d3-edef-82d451266dcb@linux.intel.com>
 <878sk6acqs.fsf@riseup.net>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <36854a07-2dd5-694c-4b9d-a3eddf8e33f9@linux.intel.com>
Date:   Thu, 12 Mar 2020 11:52:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <878sk6acqs.fsf@riseup.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 11/03/2020 19:54, Francisco Jerez wrote:
> Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> writes:
> 
>> On 10/03/2020 22:26, Chris Wilson wrote:
>>> Quoting Francisco Jerez (2020-03-10 21:41:55)
>>>> diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/gt/intel_lrc.c
>>>> index b9b3f78f1324..a5d7a80b826d 100644
>>>> --- a/drivers/gpu/drm/i915/gt/intel_lrc.c
>>>> +++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
>>>> @@ -1577,6 +1577,11 @@ static void execlists_submit_ports(struct intel_engine_cs *engine)
>>>>           /* we need to manually load the submit queue */
>>>>           if (execlists->ctrl_reg)
>>>>                   writel(EL_CTRL_LOAD, execlists->ctrl_reg);
>>>> +
>>>> +       if (execlists_num_ports(execlists) > 1 &&
>>> pending[1] is always defined, the minimum submission is one slot, with
>>> pending[1] as the sentinel NULL.
>>>
>>>> +           execlists->pending[1] &&
>>>> +           !atomic_xchg(&execlists->overload, 1))
>>>> +               intel_gt_pm_active_begin(&engine->i915->gt);
>>>
>>> engine->gt
>>>
>>>>    }
>>>>    
>>>>    static bool ctx_single_port_submission(const struct intel_context *ce)
>>>> @@ -2213,6 +2218,12 @@ cancel_port_requests(struct intel_engine_execlists * const execlists)
>>>>           clear_ports(execlists->inflight, ARRAY_SIZE(execlists->inflight));
>>>>    
>>>>           WRITE_ONCE(execlists->active, execlists->inflight);
>>>> +
>>>> +       if (atomic_xchg(&execlists->overload, 0)) {
>>>> +               struct intel_engine_cs *engine =
>>>> +                       container_of(execlists, typeof(*engine), execlists);
>>>> +               intel_gt_pm_active_end(&engine->i915->gt);
>>>> +       }
>>>>    }
>>>>    
>>>>    static inline void
>>>> @@ -2386,6 +2397,9 @@ static void process_csb(struct intel_engine_cs *engine)
>>>>                           /* port0 completed, advanced to port1 */
>>>>                           trace_ports(execlists, "completed", execlists->active);
>>>>    
>>>> +                       if (atomic_xchg(&execlists->overload, 0))
>>>> +                               intel_gt_pm_active_end(&engine->i915->gt);
>>>
>>> So this looses track if we preempt a dual-ELSP submission with a
>>> single-ELSP submission (and never go back to dual).
>>>
>>> If you move this to the end of the loop and check
>>>
>>> if (!execlists->active[1] && atomic_xchg(&execlists->overload, 0))
>>> 	intel_gt_pm_active_end(engine->gt);
>>>
>>> so that it covers both preemption/promotion and completion.
>>>
>>> However, that will fluctuate quite rapidly. (And runs the risk of
>>> exceeding the sentinel.)
>>>
>>> An alternative approach would be to couple along
>>> schedule_in/schedule_out
>>>
>>> atomic_set(overload, -1);
>>>
>>> __execlists_schedule_in:
>>> 	if (!atomic_fetch_inc(overload)
>>> 		intel_gt_pm_active_begin(engine->gt);
>>> __execlists_schedule_out:
>>> 	if (!atomic_dec_return(overload)
>>> 		intel_gt_pm_active_end(engine->gt);
>>>
>>> which would mean we are overloaded as soon as we try to submit an
>>> overlapping ELSP.
>>
>> Putting it this low-level into submission code also would not work well
>> with GuC.
>>
> 
> I wrote a patch at some point that added calls to
> intel_gt_pm_active_begin() and intel_gt_pm_active_end() to the GuC
> submission code in order to obtain a similar effect.  However people
> requested me to leave GuC submission alone for the moment in order to
> avoid interference with SLPC.  At some point it might make sense to hook
> this up in combination with SLPC, because SLPC doesn't provide much of a
> CPU energy efficiency advantage in comparison to this series.
> 
>> How about we try to keep some accounting one level higher, as the i915
>> scheduler is passing requests on to the backend for execution?
>>
>> Or number of runnable contexts, if the distinction between contexts and
>> requests is better for this purpose.
>>
>> Problematic bit in going one level higher though is that the exit point
>> is less precisely coupled to the actual state. Or maybe with aggressive
>> engine retire we have nowadays it wouldn't be a problem.
>>
> 
> The main advantage of instrumenting the execlists submission code at a
> low level is that it gives us visibility over the number of ELSP ports
> pending execution, which can cause the performance of the workload to be
> substantially more or less latency-sensitive.  GuC submission shouldn't
> care about this variable, so it kind of makes sense for its behavior to
> be slightly different.
> 
> Anyway if we're willing to give up the accuracy of keeping track of this
> at a low level (and give GuC submission exactly the same treatment) it
> should be possible to move the tracking one level up.

The results you got are certainly extremely attractive and the approach 
and code looks tidy and mature - just so you don't get me wrong that I 
am not objecting to the idea.

What I'd like to see is an easier to read breakdown of results, at 
minimum with separate perf and perf-per-Watt results. A graph with 
sorted results and error bars would also be nice.

Secondly in in the commit message of this particular patch I'd like to 
read some more thought about why ELSP[1] occupancy is thought to be the 
desired signal. Why for instance a deep ELSP[0] shouldn't benefit from 
more TDP budget towards the GPU and similar.

Also a description of the control processing "rf_qos" function do with 
this signal. What and why.

Some time ago we entertained the idea of GPU "load average", where that 
was defined as a count of runnable requests (so batch buffers). How 
that, more generic metric, would behave here if used as an input signal 
really intrigues me. Sadly I don't have a patch ready to give to you and 
ask to please test it.

Or maybe the key is count of runnable contexts as opposed to requests, 
which would more match the ELSP[1] idea.

But this is secondary, I primarily think we need to see a better 
presentation of the result and the theory of operation explained better 
in the commit message.

Regards,

Tvrtko
