Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 440CA1822D4
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 20:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387420AbgCKTye (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 15:54:34 -0400
Received: from mx1.riseup.net ([198.252.153.129]:52834 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387414AbgCKTye (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 15:54:34 -0400
Received: from capuchin.riseup.net (unknown [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48d2jP3QlPzFfCG;
        Wed, 11 Mar 2020 12:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1583956473; bh=/oIm3+H/Gjkwq6nU0tK5HhT1pSrbvRCdCac1zwwzqA8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=S+Z6K9Gqzjj6ynH6zFU95x6OzsWFilDVFnExkhyOpkSSO0oInk6wMEotPDwnx4vcU
         xHZqVYowzPygtVsMVIqkbLKGhMLY0lpK6ELbB70jZ+7GCryh83MCbXHLA1pH9/ZStx
         4QCQaEzJIacer5jEFMee0vth5nHQPkOL/XgwAZYs=
X-Riseup-User-ID: 5B6453F7EC4DDC4A599452C8EF4E242FEA4225E013722DDFB12F86EB81309ED7
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 48d2jN4wDLz8tXp;
        Wed, 11 Mar 2020 12:54:32 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, linux-pm@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [Intel-gfx] [PATCH 02/10] drm/i915: Adjust PM QoS response frequency based on GPU load.
In-Reply-To: <ac5fdd3c-bf47-60d3-edef-82d451266dcb@linux.intel.com>
References: <20200310214203.26459-1-currojerez@riseup.net> <20200310214203.26459-3-currojerez@riseup.net> <158387916218.28297.4489489879582782488@build.alporthouse.com> <ac5fdd3c-bf47-60d3-edef-82d451266dcb@linux.intel.com>
Date:   Wed, 11 Mar 2020 12:54:35 -0700
Message-ID: <878sk6acqs.fsf@riseup.net>
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

> On 10/03/2020 22:26, Chris Wilson wrote:
>> Quoting Francisco Jerez (2020-03-10 21:41:55)
>>> diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915=
/gt/intel_lrc.c
>>> index b9b3f78f1324..a5d7a80b826d 100644
>>> --- a/drivers/gpu/drm/i915/gt/intel_lrc.c
>>> +++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
>>> @@ -1577,6 +1577,11 @@ static void execlists_submit_ports(struct intel_=
engine_cs *engine)
>>>          /* we need to manually load the submit queue */
>>>          if (execlists->ctrl_reg)
>>>                  writel(EL_CTRL_LOAD, execlists->ctrl_reg);
>>> +
>>> +       if (execlists_num_ports(execlists) > 1 &&
>> pending[1] is always defined, the minimum submission is one slot, with
>> pending[1] as the sentinel NULL.
>>=20
>>> +           execlists->pending[1] &&
>>> +           !atomic_xchg(&execlists->overload, 1))
>>> +               intel_gt_pm_active_begin(&engine->i915->gt);
>>=20
>> engine->gt
>>=20
>>>   }
>>>=20=20=20
>>>   static bool ctx_single_port_submission(const struct intel_context *ce)
>>> @@ -2213,6 +2218,12 @@ cancel_port_requests(struct intel_engine_execlis=
ts * const execlists)
>>>          clear_ports(execlists->inflight, ARRAY_SIZE(execlists->infligh=
t));
>>>=20=20=20
>>>          WRITE_ONCE(execlists->active, execlists->inflight);
>>> +
>>> +       if (atomic_xchg(&execlists->overload, 0)) {
>>> +               struct intel_engine_cs *engine =3D
>>> +                       container_of(execlists, typeof(*engine), execli=
sts);
>>> +               intel_gt_pm_active_end(&engine->i915->gt);
>>> +       }
>>>   }
>>>=20=20=20
>>>   static inline void
>>> @@ -2386,6 +2397,9 @@ static void process_csb(struct intel_engine_cs *e=
ngine)
>>>                          /* port0 completed, advanced to port1 */
>>>                          trace_ports(execlists, "completed", execlists-=
>active);
>>>=20=20=20
>>> +                       if (atomic_xchg(&execlists->overload, 0))
>>> +                               intel_gt_pm_active_end(&engine->i915->g=
t);
>>=20
>> So this looses track if we preempt a dual-ELSP submission with a
>> single-ELSP submission (and never go back to dual).
>>=20
>> If you move this to the end of the loop and check
>>=20
>> if (!execlists->active[1] && atomic_xchg(&execlists->overload, 0))
>> 	intel_gt_pm_active_end(engine->gt);
>>=20
>> so that it covers both preemption/promotion and completion.
>>=20
>> However, that will fluctuate quite rapidly. (And runs the risk of
>> exceeding the sentinel.)
>>=20
>> An alternative approach would be to couple along
>> schedule_in/schedule_out
>>=20
>> atomic_set(overload, -1);
>>=20
>> __execlists_schedule_in:
>> 	if (!atomic_fetch_inc(overload)
>> 		intel_gt_pm_active_begin(engine->gt);
>> __execlists_schedule_out:
>> 	if (!atomic_dec_return(overload)
>> 		intel_gt_pm_active_end(engine->gt);
>>=20
>> which would mean we are overloaded as soon as we try to submit an
>> overlapping ELSP.
>
> Putting it this low-level into submission code also would not work well=20
> with GuC.
>

I wrote a patch at some point that added calls to
intel_gt_pm_active_begin() and intel_gt_pm_active_end() to the GuC
submission code in order to obtain a similar effect.  However people
requested me to leave GuC submission alone for the moment in order to
avoid interference with SLPC.  At some point it might make sense to hook
this up in combination with SLPC, because SLPC doesn't provide much of a
CPU energy efficiency advantage in comparison to this series.

> How about we try to keep some accounting one level higher, as the i915=20
> scheduler is passing requests on to the backend for execution?
>
> Or number of runnable contexts, if the distinction between contexts and=20
> requests is better for this purpose.
>
> Problematic bit in going one level higher though is that the exit point=20
> is less precisely coupled to the actual state. Or maybe with aggressive=20
> engine retire we have nowadays it wouldn't be a problem.
>

The main advantage of instrumenting the execlists submission code at a
low level is that it gives us visibility over the number of ELSP ports
pending execution, which can cause the performance of the workload to be
substantially more or less latency-sensitive.  GuC submission shouldn't
care about this variable, so it kind of makes sense for its behavior to
be slightly different.

Anyway if we're willing to give up the accuracy of keeping track of this
at a low level (and give GuC submission exactly the same treatment) it
should be possible to move the tracking one level up.

> Regards,
>
> Tvrtko
>

Thank you.

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXmlB+wAKCRCDmTidfVK/
W+yRAQCEEl5/huRg6/K96fmimPaZ6hLZLH9hq0bjfbsg08kqkQEApGp1uqvIWQyZ
9iFyXm7Q2ObDcqnwsW3XKTXNvpflwow=
=6PB1
-----END PGP SIGNATURE-----
--==-=-=--
