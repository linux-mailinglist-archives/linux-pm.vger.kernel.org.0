Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D79F18A340
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 20:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgCRTmK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 15:42:10 -0400
Received: from mx1.riseup.net ([198.252.153.129]:48168 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCRTmK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Mar 2020 15:42:10 -0400
Received: from capuchin.riseup.net (unknown [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48jL5s3WBmzFfYM;
        Wed, 18 Mar 2020 12:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1584560529; bh=a5nYf4uJw7aYCyEYlZi0u83zqkdSfNAtDLlEBJVc2Ro=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hXhiz5aJJY9j4uFI3UeyxV2cfoXs3OaO2P/Rb7QdZa1xS3dZLAIdURebHeezemFIP
         j6gkLQ8yZp7M5wwrXX5V9MUr+HX7snsQpmjo7xb6lbqGs5HuKRduZwZPySU11Ag07w
         RP4Esq6hlHJWO6GkAMmcQdEVp8c5g4Y1xXugR0yE=
X-Riseup-User-ID: 6DF06374A87D2B38EFD187F6AD1B7F97D48C7066E73C4B6BA964BE507E2E536A
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 48jL5s027dz8wXk;
        Wed, 18 Mar 2020 12:42:08 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     chris.p.wilson@intel.com, intel-gfx@lists.freedesktop.org,
        linux-pm@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [Intel-gfx] [PATCH 02/10] drm/i915: Adjust PM QoS response frequency based on GPU load.
In-Reply-To: <87r1xzafwn.fsf@riseup.net>
References: <20200310214203.26459-1-currojerez@riseup.net> <20200310214203.26459-3-currojerez@riseup.net> <158387916218.28297.4489489879582782488@build.alporthouse.com> <87r1xzafwn.fsf@riseup.net>
Date:   Wed, 18 Mar 2020 12:42:11 -0700
Message-ID: <87k13h78mk.fsf@riseup.net>
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

> Chris Wilson <chris@chris-wilson.co.uk> writes:
>
>> Quoting Francisco Jerez (2020-03-10 21:41:55)
>>> diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915=
/gt/intel_lrc.c
>>> index b9b3f78f1324..a5d7a80b826d 100644
>>> --- a/drivers/gpu/drm/i915/gt/intel_lrc.c
>>> +++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
>>> @@ -1577,6 +1577,11 @@ static void execlists_submit_ports(struct intel_=
engine_cs *engine)
>>>         /* we need to manually load the submit queue */
>>>         if (execlists->ctrl_reg)
>>>                 writel(EL_CTRL_LOAD, execlists->ctrl_reg);
>>> +
>>> +       if (execlists_num_ports(execlists) > 1 &&
>> pending[1] is always defined, the minimum submission is one slot, with
>> pending[1] as the sentinel NULL.
>>
>>> +           execlists->pending[1] &&
>>> +           !atomic_xchg(&execlists->overload, 1))
>>> +               intel_gt_pm_active_begin(&engine->i915->gt);
>>
>> engine->gt
>>
>
> Applied your suggestions above locally, will probably wait to have a few
> more changes batched up before sending a v2.
>
>>>  }
>>>=20=20
>>>  static bool ctx_single_port_submission(const struct intel_context *ce)
>>> @@ -2213,6 +2218,12 @@ cancel_port_requests(struct intel_engine_execlis=
ts * const execlists)
>>>         clear_ports(execlists->inflight, ARRAY_SIZE(execlists->inflight=
));
>>>=20=20
>>>         WRITE_ONCE(execlists->active, execlists->inflight);
>>> +
>>> +       if (atomic_xchg(&execlists->overload, 0)) {
>>> +               struct intel_engine_cs *engine =3D
>>> +                       container_of(execlists, typeof(*engine), execli=
sts);
>>> +               intel_gt_pm_active_end(&engine->i915->gt);
>>> +       }
>>>  }
>>>=20=20
>>>  static inline void
>>> @@ -2386,6 +2397,9 @@ static void process_csb(struct intel_engine_cs *e=
ngine)
>>>                         /* port0 completed, advanced to port1 */
>>>                         trace_ports(execlists, "completed", execlists->=
active);
>>>=20=20
>>> +                       if (atomic_xchg(&execlists->overload, 0))
>>> +                               intel_gt_pm_active_end(&engine->i915->g=
t);
>>
>> So this looses track if we preempt a dual-ELSP submission with a
>> single-ELSP submission (and never go back to dual).
>>
>
> Yes, good point.  You're right that if a dual-ELSP submission gets
> preempted by a single-ELSP submission "overload" will remain signaled
> until the first completion interrupt arrives (e.g. from the preempting
> submission).
>
>> If you move this to the end of the loop and check
>>
>> if (!execlists->active[1] && atomic_xchg(&execlists->overload, 0))
>> 	intel_gt_pm_active_end(engine->gt);
>>
>> so that it covers both preemption/promotion and completion.
>>
>
> That sounds reasonable.
>
>> However, that will fluctuate quite rapidly. (And runs the risk of
>> exceeding the sentinel.)
>>
>> An alternative approach would be to couple along
>> schedule_in/schedule_out
>>
>> atomic_set(overload, -1);
>>
>> __execlists_schedule_in:
>> 	if (!atomic_fetch_inc(overload)
>> 		intel_gt_pm_active_begin(engine->gt);
>> __execlists_schedule_out:
>> 	if (!atomic_dec_return(overload)
>> 		intel_gt_pm_active_end(engine->gt);
>>
>> which would mean we are overloaded as soon as we try to submit an
>> overlapping ELSP.
>>
>
> That sounds good to me too, and AFAICT would have roughly the same
> behavior as this metric except for the preemption corner case you
> mention above.  I'll try this and verify that I get approximately the
> same performance numbers.
>

This suggestion seems to lead to some minor regressions, I'm
investigating the issue.  Will send a v2 as soon as I have something
along the lines of what you suggested running with equivalent
performance to v1.

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXnJ5kwAKCRCDmTidfVK/
W8RGAP0fnP5bgq8VI2HwdNgG26U1KneF9BgkFiRqan1wgKlaTgD/W7IGl6KnT8Xh
OeVjlFfQFrRzOU86JZfmyCb7sXAtNFk=
=JAxw
-----END PGP SIGNATURE-----
--==-=-=--
