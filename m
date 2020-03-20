Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB41418C56E
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 03:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgCTCqU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 22:46:20 -0400
Received: from mx1.riseup.net ([198.252.153.129]:51986 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbgCTCqU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Mar 2020 22:46:20 -0400
Received: from capuchin.riseup.net (unknown [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48k7Sq4FSxzFdFq;
        Thu, 19 Mar 2020 19:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1584672379; bh=CVkasvIzn+5thv9quZ5c83PuBC12AWJxuBEDKD4gGI4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AIajsIg1sy702R5E2B6yuPUT4SHfikEPpoeBP7jtouKZZaFWXGwv1NisVoxAzU65E
         thdcx60p6XxtK5jq6kw8hW4cWakGPcPFGAvdA5yolsKsu0JUFcOd8H1PGF/UlRXJmA
         3xCCuqnh6zF4zTi2r/09SHPmlvljzLrjU+6n48qg=
X-Riseup-User-ID: C423D6455EADAB01BCED61C17DE3DE0E86927745834F2434DFDA7065D016F430
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 48k7Sp4VWBz8tq2;
        Thu, 19 Mar 2020 19:46:18 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     chris.p.wilson@intel.com, intel-gfx@lists.freedesktop.org,
        linux-pm@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [Intel-gfx] [PATCH 02/10] drm/i915: Adjust PM QoS response frequency based on GPU load.
In-Reply-To: <87k13h78mk.fsf@riseup.net>
References: <20200310214203.26459-1-currojerez@riseup.net> <20200310214203.26459-3-currojerez@riseup.net> <158387916218.28297.4489489879582782488@build.alporthouse.com> <87r1xzafwn.fsf@riseup.net> <87k13h78mk.fsf@riseup.net>
Date:   Thu, 19 Mar 2020 19:46:19 -0700
Message-ID: <874kuj68w4.fsf@riseup.net>
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

Francisco Jerez <currojerez@riseup.net> writes:

> Francisco Jerez <currojerez@riseup.net> writes:
>
>> Chris Wilson <chris@chris-wilson.co.uk> writes:
>>
>>> Quoting Francisco Jerez (2020-03-10 21:41:55)
>>>> diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i91=
5/gt/intel_lrc.c
>>>> index b9b3f78f1324..a5d7a80b826d 100644
>>>> --- a/drivers/gpu/drm/i915/gt/intel_lrc.c
>>>> +++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
>>>> @@ -1577,6 +1577,11 @@ static void execlists_submit_ports(struct intel=
_engine_cs *engine)
>>>>         /* we need to manually load the submit queue */
>>>>         if (execlists->ctrl_reg)
>>>>                 writel(EL_CTRL_LOAD, execlists->ctrl_reg);
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
>>
>> Applied your suggestions above locally, will probably wait to have a few
>> more changes batched up before sending a v2.
>>
>>>>  }
>>>>=20=20
>>>>  static bool ctx_single_port_submission(const struct intel_context *ce)
>>>> @@ -2213,6 +2218,12 @@ cancel_port_requests(struct intel_engine_execli=
sts * const execlists)
>>>>         clear_ports(execlists->inflight, ARRAY_SIZE(execlists->infligh=
t));
>>>>=20=20
>>>>         WRITE_ONCE(execlists->active, execlists->inflight);
>>>> +
>>>> +       if (atomic_xchg(&execlists->overload, 0)) {
>>>> +               struct intel_engine_cs *engine =3D
>>>> +                       container_of(execlists, typeof(*engine), execl=
ists);
>>>> +               intel_gt_pm_active_end(&engine->i915->gt);
>>>> +       }
>>>>  }
>>>>=20=20
>>>>  static inline void
>>>> @@ -2386,6 +2397,9 @@ static void process_csb(struct intel_engine_cs *=
engine)
>>>>                         /* port0 completed, advanced to port1 */
>>>>                         trace_ports(execlists, "completed", execlists-=
>active);
>>>>=20=20
>>>> +                       if (atomic_xchg(&execlists->overload, 0))
>>>> +                               intel_gt_pm_active_end(&engine->i915->=
gt);
>>>
>>> So this looses track if we preempt a dual-ELSP submission with a
>>> single-ELSP submission (and never go back to dual).
>>>
>>
>> Yes, good point.  You're right that if a dual-ELSP submission gets
>> preempted by a single-ELSP submission "overload" will remain signaled
>> until the first completion interrupt arrives (e.g. from the preempting
>> submission).
>>
>>> If you move this to the end of the loop and check
>>>
>>> if (!execlists->active[1] && atomic_xchg(&execlists->overload, 0))
>>> 	intel_gt_pm_active_end(engine->gt);
>>>
>>> so that it covers both preemption/promotion and completion.
>>>
>>
>> That sounds reasonable.
>>
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
>>>
>>
>> That sounds good to me too, and AFAICT would have roughly the same
>> behavior as this metric except for the preemption corner case you
>> mention above.  I'll try this and verify that I get approximately the
>> same performance numbers.
>>
>
> This suggestion seems to lead to some minor regressions, I'm
> investigating the issue.  Will send a v2 as soon as I have something
> along the lines of what you suggested running with equivalent
> performance to v1.

I think I've figured out why both of the alternatives we were talking
about above lead to a couple percent regressions in latency-sensitive
workloads: In some scenarios it's possible for execlist_dequeue() to
execute after the GPU has gone idle, but before we've processed the
corresponding CSB entries, particularly when called from the
submit_queue() path.  In that case __execlists_schedule_in() will think
that the next request is overlapping, and tell CPU power management to
relax, even though the GPU is starving intermittently.

How about we do the same:

|       if (atomic_xchg(&execlists->overload, 0))
|               intel_gt_pm_active_end(engine->gt);

as in this patch from process_csb() in response to each completion CSB
entry, which ensures that the system is considered non-GPU-bound as soon
as the first context completes.  Subsequently if another CSB entry
signals a dual-ELSP active-to-idle transition or a dual-ELSP preemption
we call intel_gt_pm_active_begin() directly from process_csb().  If we
hit a single-ELSP preemption CSB entry we call intel_gt_pm_active_end()
instead, in order to avoid the problem you pointed out in your previous
email.

How does that sound to you?  [Still need to verify that it has
comparable performance to this patch overall.]

Thanks!

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXnQuewAKCRCDmTidfVK/
WxXgAP9252cVgsoRyyqdvt7eGw2+bh8imJeFLWlOuS8CyfYJ/gD/fUskudgUkbJU
y3wMKsCgIOJvzmAfV5/irlRbWLzQoLY=
=NYsY
-----END PGP SIGNATURE-----
--==-=-=--
