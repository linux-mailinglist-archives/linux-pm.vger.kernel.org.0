Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E58180CD7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 01:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgCKAeA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 20:34:00 -0400
Received: from mx1.riseup.net ([198.252.153.129]:49274 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727648AbgCKAeA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Mar 2020 20:34:00 -0400
Received: from bell.riseup.net (unknown [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48cXyH6gbzzFf6h;
        Tue, 10 Mar 2020 17:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1583886840; bh=2HjnUPBcz0MuPxjqtnp+0ItBXqbCWN5PDbDI2uovOHo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=e9+qu/MzOfVjoYdWdax43fw03FhcPELFByFB2CRNBoKuEEpQ0whx7Rre2u48BaY9I
         +PX+cOIqkk4gVueqyWZzGvZjS24VHOE/ZFcwgNRpk9oYbd4aZ4Orf1bS2hycKhFVPB
         OkUcZiZz0hMDswQ2KYCxi83J/daddJFyLRUVC08g=
X-Riseup-User-ID: 4276A88B71E96D66D2E452B58CA27B77CD155BA0D828A8EB7D3907D9FC0BDB95
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 48cXyH1GyXzJstk;
        Tue, 10 Mar 2020 17:33:59 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, linux-pm@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [Intel-gfx] [PATCH 02/10] drm/i915: Adjust PM QoS response frequency based on GPU load.
In-Reply-To: <158387916218.28297.4489489879582782488@build.alporthouse.com>
References: <20200310214203.26459-1-currojerez@riseup.net> <20200310214203.26459-3-currojerez@riseup.net> <158387916218.28297.4489489879582782488@build.alporthouse.com>
Date:   Tue, 10 Mar 2020 17:34:00 -0700
Message-ID: <87r1xzafwn.fsf@riseup.net>
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

Chris Wilson <chris@chris-wilson.co.uk> writes:

> Quoting Francisco Jerez (2020-03-10 21:41:55)
>> diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/=
gt/intel_lrc.c
>> index b9b3f78f1324..a5d7a80b826d 100644
>> --- a/drivers/gpu/drm/i915/gt/intel_lrc.c
>> +++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
>> @@ -1577,6 +1577,11 @@ static void execlists_submit_ports(struct intel_e=
ngine_cs *engine)
>>         /* we need to manually load the submit queue */
>>         if (execlists->ctrl_reg)
>>                 writel(EL_CTRL_LOAD, execlists->ctrl_reg);
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

Applied your suggestions above locally, will probably wait to have a few
more changes batched up before sending a v2.

>>  }
>>=20=20
>>  static bool ctx_single_port_submission(const struct intel_context *ce)
>> @@ -2213,6 +2218,12 @@ cancel_port_requests(struct intel_engine_execlist=
s * const execlists)
>>         clear_ports(execlists->inflight, ARRAY_SIZE(execlists->inflight)=
);
>>=20=20
>>         WRITE_ONCE(execlists->active, execlists->inflight);
>> +
>> +       if (atomic_xchg(&execlists->overload, 0)) {
>> +               struct intel_engine_cs *engine =3D
>> +                       container_of(execlists, typeof(*engine), execlis=
ts);
>> +               intel_gt_pm_active_end(&engine->i915->gt);
>> +       }
>>  }
>>=20=20
>>  static inline void
>> @@ -2386,6 +2397,9 @@ static void process_csb(struct intel_engine_cs *en=
gine)
>>                         /* port0 completed, advanced to port1 */
>>                         trace_ports(execlists, "completed", execlists->a=
ctive);
>>=20=20
>> +                       if (atomic_xchg(&execlists->overload, 0))
>> +                               intel_gt_pm_active_end(&engine->i915->gt=
);
>
> So this looses track if we preempt a dual-ELSP submission with a
> single-ELSP submission (and never go back to dual).
>

Yes, good point.  You're right that if a dual-ELSP submission gets
preempted by a single-ELSP submission "overload" will remain signaled
until the first completion interrupt arrives (e.g. from the preempting
submission).

> If you move this to the end of the loop and check
>
> if (!execlists->active[1] && atomic_xchg(&execlists->overload, 0))
> 	intel_gt_pm_active_end(engine->gt);
>
> so that it covers both preemption/promotion and completion.
>

That sounds reasonable.

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
>

That sounds good to me too, and AFAICT would have roughly the same
behavior as this metric except for the preemption corner case you
mention above.  I'll try this and verify that I get approximately the
same performance numbers.

>
> The metric feels very multiple client (game + display server, or
> saturated transcode) centric. In the endless kernel world, we expect
> 100% engine utilisation from a single context, and never a dual-ELSP
> submission. They are also likely to want to avoid being throttled to
> converse TDP for the CPU.
>
Yes, this metric is fairly conservative, it won't trigger in all cases
which would potentially benefit from the energy efficiency optimization,
only where we can be reasonably certain that CPU latency is not critical
in order to keep the GPU busy (e.g. because the CS has an additional
ELSP port pending execution that will immediately kick in as soon as the
current one completes).

My original approach was to call intel_gt_pm_active_begin() directly as
soon as the first ELSP is submitted to the GPU, which was somewhat more
effective at improving the energy efficiency of the system than waiting
for the second port to be in use, but it involved a slight execlists
submission latency cost that led to some regressions.  It would
certainly cover the single-context case you have in mind though.  I'll
get some updated numbers with my previous approach so we can decide
which one provides a better trade-off.

> Should we also reduce the overload for the number of clients who are
> waiting for interrupts from the GPU, so that their wakeup latency is not
> impacted?

A number of clients waiting doesn't necessarily indicate that wake-up
latency is a concern.  It frequently indicates the opposite: That the
GPU has a bottleneck which will only be exacerbated by attempting to
reduce the ramp-up latency of the CPU.  IOW, I think we should only care
about reducing the CPU wake-up latency in cases where the client is
unable to keep the GPU fully utilized with the latency target which
allows the GPU to run at maximum throughput -- If the client is unable
to it will already cause the GPU utilization to drop, so the PM QoS
request will be removed whether it is waiting or not.

> -Chris

Thanks!

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXmgx+AAKCRCDmTidfVK/
W0HRAP9GR8mKyi5SO9tikmxJJKg8p6q489cXSbz9Nd6NfXSyGQD+Pkn0CZrcbwSN
QQxG/26PCgz7qcCVIZliPSPlKiA7kSA=
=90yW
-----END PGP SIGNATURE-----
--==-=-=--
