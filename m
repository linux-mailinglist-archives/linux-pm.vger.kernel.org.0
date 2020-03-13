Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8A6184195
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 08:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCMHjh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 03:39:37 -0400
Received: from mx1.riseup.net ([198.252.153.129]:48684 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgCMHjh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 13 Mar 2020 03:39:37 -0400
Received: from bell.riseup.net (unknown [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48dyJS0pSTzFdXY;
        Fri, 13 Mar 2020 00:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1584085176; bh=/2lm+HKQwrqmr/NQTXyU9Iy1inqGRKPnowAM9p8OHbA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=itVqz24ap0arDywoAlfvQ/l0Tq+UJ6AR++8y1m5jbFKcq7zxHQ+1XjIWeVEyphtTl
         6xTFHHT5M6F2AMPVmzo7K+7CtjS/QH13RKkf8MGc4BStQF9sNpulyatK3oh2ZwMc9P
         XZWpz8jf19upsGza9zC9nGlzlMm/2uOm57350bu8=
X-Riseup-User-ID: 4DB8727C5ABD8B75676853C830CBEA1484D8BB5A0C82CE53169296B6330ABA8F
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 48dyJR2C0zzJttB;
        Fri, 13 Mar 2020 00:39:35 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, linux-pm@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [Intel-gfx] [PATCH 02/10] drm/i915: Adjust PM QoS response frequency based on GPU load.
In-Reply-To: <36854a07-2dd5-694c-4b9d-a3eddf8e33f9@linux.intel.com>
References: <20200310214203.26459-1-currojerez@riseup.net> <20200310214203.26459-3-currojerez@riseup.net> <158387916218.28297.4489489879582782488@build.alporthouse.com> <ac5fdd3c-bf47-60d3-edef-82d451266dcb@linux.intel.com> <878sk6acqs.fsf@riseup.net> <36854a07-2dd5-694c-4b9d-a3eddf8e33f9@linux.intel.com>
Date:   Fri, 13 Mar 2020 00:39:35 -0700
Message-ID: <87sgic9008.fsf@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> writes:

> On 11/03/2020 19:54, Francisco Jerez wrote:
>> Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> writes:
>>=20
>>> On 10/03/2020 22:26, Chris Wilson wrote:
>>>> Quoting Francisco Jerez (2020-03-10 21:41:55)
>>>>> diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i9=
15/gt/intel_lrc.c
>>>>> index b9b3f78f1324..a5d7a80b826d 100644
>>>>> --- a/drivers/gpu/drm/i915/gt/intel_lrc.c
>>>>> +++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
>>>>> @@ -1577,6 +1577,11 @@ static void execlists_submit_ports(struct inte=
l_engine_cs *engine)
>>>>>           /* we need to manually load the submit queue */
>>>>>           if (execlists->ctrl_reg)
>>>>>                   writel(EL_CTRL_LOAD, execlists->ctrl_reg);
>>>>> +
>>>>> +       if (execlists_num_ports(execlists) > 1 &&
>>>> pending[1] is always defined, the minimum submission is one slot, with
>>>> pending[1] as the sentinel NULL.
>>>>
>>>>> +           execlists->pending[1] &&
>>>>> +           !atomic_xchg(&execlists->overload, 1))
>>>>> +               intel_gt_pm_active_begin(&engine->i915->gt);
>>>>
>>>> engine->gt
>>>>
>>>>>    }
>>>>>=20=20=20=20
>>>>>    static bool ctx_single_port_submission(const struct intel_context =
*ce)
>>>>> @@ -2213,6 +2218,12 @@ cancel_port_requests(struct intel_engine_execl=
ists * const execlists)
>>>>>           clear_ports(execlists->inflight, ARRAY_SIZE(execlists->infl=
ight));
>>>>>=20=20=20=20
>>>>>           WRITE_ONCE(execlists->active, execlists->inflight);
>>>>> +
>>>>> +       if (atomic_xchg(&execlists->overload, 0)) {
>>>>> +               struct intel_engine_cs *engine =3D
>>>>> +                       container_of(execlists, typeof(*engine), exec=
lists);
>>>>> +               intel_gt_pm_active_end(&engine->i915->gt);
>>>>> +       }
>>>>>    }
>>>>>=20=20=20=20
>>>>>    static inline void
>>>>> @@ -2386,6 +2397,9 @@ static void process_csb(struct intel_engine_cs =
*engine)
>>>>>                           /* port0 completed, advanced to port1 */
>>>>>                           trace_ports(execlists, "completed", execlis=
ts->active);
>>>>>=20=20=20=20
>>>>> +                       if (atomic_xchg(&execlists->overload, 0))
>>>>> +                               intel_gt_pm_active_end(&engine->i915-=
>gt);
>>>>
>>>> So this looses track if we preempt a dual-ELSP submission with a
>>>> single-ELSP submission (and never go back to dual).
>>>>
>>>> If you move this to the end of the loop and check
>>>>
>>>> if (!execlists->active[1] && atomic_xchg(&execlists->overload, 0))
>>>> 	intel_gt_pm_active_end(engine->gt);
>>>>
>>>> so that it covers both preemption/promotion and completion.
>>>>
>>>> However, that will fluctuate quite rapidly. (And runs the risk of
>>>> exceeding the sentinel.)
>>>>
>>>> An alternative approach would be to couple along
>>>> schedule_in/schedule_out
>>>>
>>>> atomic_set(overload, -1);
>>>>
>>>> __execlists_schedule_in:
>>>> 	if (!atomic_fetch_inc(overload)
>>>> 		intel_gt_pm_active_begin(engine->gt);
>>>> __execlists_schedule_out:
>>>> 	if (!atomic_dec_return(overload)
>>>> 		intel_gt_pm_active_end(engine->gt);
>>>>
>>>> which would mean we are overloaded as soon as we try to submit an
>>>> overlapping ELSP.
>>>
>>> Putting it this low-level into submission code also would not work well
>>> with GuC.
>>>
>>=20
>> I wrote a patch at some point that added calls to
>> intel_gt_pm_active_begin() and intel_gt_pm_active_end() to the GuC
>> submission code in order to obtain a similar effect.  However people
>> requested me to leave GuC submission alone for the moment in order to
>> avoid interference with SLPC.  At some point it might make sense to hook
>> this up in combination with SLPC, because SLPC doesn't provide much of a
>> CPU energy efficiency advantage in comparison to this series.
>>=20
>>> How about we try to keep some accounting one level higher, as the i915
>>> scheduler is passing requests on to the backend for execution?
>>>
>>> Or number of runnable contexts, if the distinction between contexts and
>>> requests is better for this purpose.
>>>
>>> Problematic bit in going one level higher though is that the exit point
>>> is less precisely coupled to the actual state. Or maybe with aggressive
>>> engine retire we have nowadays it wouldn't be a problem.
>>>
>>=20
>> The main advantage of instrumenting the execlists submission code at a
>> low level is that it gives us visibility over the number of ELSP ports
>> pending execution, which can cause the performance of the workload to be
>> substantially more or less latency-sensitive.  GuC submission shouldn't
>> care about this variable, so it kind of makes sense for its behavior to
>> be slightly different.
>>=20
>> Anyway if we're willing to give up the accuracy of keeping track of this
>> at a low level (and give GuC submission exactly the same treatment) it
>> should be possible to move the tracking one level up.
>
> The results you got are certainly extremely attractive and the approach=20
> and code looks tidy and mature - just so you don't get me wrong that I=20
> am not objecting to the idea.
>
> What I'd like to see is an easier to read breakdown of results, at=20
> minimum with separate perf and perf-per-Watt results. A graph with=20
> sorted results and error bars would also be nice.
>

I just plotted the same results from the cover letter in separate
performance and energy efficiency graphs:

https://people.freedesktop.org/~currojerez/intel_pstate-vlp-v2/benchmark-co=
mparison-ICL-perf.svg
https://people.freedesktop.org/~currojerez/intel_pstate-vlp-v2/benchmark-co=
mparison-ICL-perf-per-watt.svg

> Secondly in in the commit message of this particular patch I'd like to=20
> read some more thought about why ELSP[1] occupancy is thought to be the=20
> desired signal. Why for instance a deep ELSP[0] shouldn't benefit from=20
> more TDP budget towards the GPU and similar.
>
> Also a description of the control processing "rf_qos" function do with=20
> this signal. What and why.
>

I'll work on a better commit message for v2.

> Some time ago we entertained the idea of GPU "load average", where that=20
> was defined as a count of runnable requests (so batch buffers). How=20
> that, more generic metric, would behave here if used as an input signal=20
> really intrigues me. Sadly I don't have a patch ready to give to you and=
=20
> ask to please test it.
>
> Or maybe the key is count of runnable contexts as opposed to requests,=20
> which would more match the ELSP[1] idea.
>

Ultimately what we're trying to determine here is whether the
performance of the graphics workload is sensitive to the latency of the
CPU -- If it is we don't want to place a response latency constraint.
If the two ELSP ports are in use somewhere close to 100% of the time we
know that for most of the run-time of the workload the completion of one
request leads to the immediate execution of another, which means that
the GPU can be kept busy without the execlists submission code rushing
to submit a new requestt, so latency isn't a concern.

Looking at the number of runnable contexts is very close but not exactly
equivalent to that, since the workload may still be latency-sensitive if
the multiple contexts are only being submitted to a single port.

In the GuC submission case the CPU doesn't need to get involved to
submit the next piece of work (unless there is some cyclical dependency
between CPU and GPU work that is), so it should be sufficient to look at
whether at least one port is active -- Also even while using execlists,
there are applications which are able to keep some GPU engine busy
nearly 100% of the time (meaning that their performance won't increase
with decreasing latency since the engine can hardly do more work than
that), but they are unable to keep the two ELSP ports busy for some
significant fraction of that time, so it would be more accurate for them
to use the single-port utilization as heuristic (which yeah, is also
roughly equivalent to the fraction of time that at least one runnable
context or request was pending execution), at a cost for the
applications that are actually sensitive to the ELSP submission latency
we would be neglecting.

This patch takes the rather conservative approach of limiting the
application of the response frequency PM QoS request to the more
restrictive set of cases where we are most certain that CPU latency
shouldn't be an issue, in order to avoid regressions.  But it might be
that you find the additional energy efficiency benefit from the more
aggressive approach to be worth the cost to a few execlists submission
latency-sensitive applications.  I'm trying to get some numbers
comparing the two approaches now, will post them here once I have
results so we can make a more informed trade-off.

> But this is secondary, I primarily think we need to see a better=20
> presentation of the result and the theory of operation explained better=20
> in the commit message.
>

Sure, I'll see what I can come up with.

> Regards,
>
> Tvrtko

Thank you.


--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXms4uAAKCRCDmTidfVK/
W+JXAQCK9x/JbLvhGQ3ywwBqa9+/xooWveXbbwdlxa+Tx0yb6AD9EqMLHb2X4bSQ
GFFvPTgXezpE2HcEyRZA0tZS+Rodm5s=
=RSU+
-----END PGP SIGNATURE-----
--==-=-=--
