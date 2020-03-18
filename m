Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFE318A3B2
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 21:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgCRUWH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 16:22:07 -0400
Received: from mx1.riseup.net ([198.252.153.129]:42630 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgCRUWG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Mar 2020 16:22:06 -0400
Received: from bell.riseup.net (unknown [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48jLzx69DYzFf4q;
        Wed, 18 Mar 2020 13:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1584562926; bh=cDqg1MsbDTAfwQVv223Mp84dLxQs+hLv0G3KGMuZ6PQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GTGAQWcJF8jDry8P04YEg+wc+LYZZ2RZ7xTkrp/103RnNrIVeyVl+c+uVhS81ZxSl
         Mwz73rLOtB/KEX4BYa+Yit8jqTKpsPgvQS623xAnhJB1iCJ6EBizy4oQ/8kvU+GGb6
         XkATSfE7ZJKenh/Dx5ibpCuXNKcXNUEqkmR9eL9c=
X-Riseup-User-ID: A15938F5A50A638D8932D02AB7091E8995C1909F43D339D23C61597545147285
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 48jLzx3pr8zJsBR;
        Wed, 18 Mar 2020 13:22:05 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>,
        "linux-pm\@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "intel-gfx\@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Cc:     "Vivi\, Rodrigo" <rodrigo.vivi@intel.com>,
        "peterz\@infradead.org" <peterz@infradead.org>,
        "rjw\@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH 07/10] cpufreq: intel_pstate: Implement VLP controller for HWP parts.
In-Reply-To: <8819f9b64ef4bd9ae3621b1073740de1febe3967.camel@intel.com>
References: <20200310214203.26459-1-currojerez@riseup.net> <20200310214203.26459-8-currojerez@riseup.net> <40db3c86c68abfab406618e2424787c18c119c87.camel@intel.com> <87fte57879.fsf@riseup.net> <8819f9b64ef4bd9ae3621b1073740de1febe3967.camel@intel.com>
Date:   Wed, 18 Mar 2020 13:22:10 -0700
Message-ID: <87blot76rx.fsf@riseup.net>
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

"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com> writes:

> On Wed, 2020-03-18 at 12:51 -0700, Francisco Jerez wrote:
>> "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com> writes:
>>=20
>> > On Tue, 2020-03-10 at 14:42 -0700, Francisco Jerez wrote:
>> > > This implements a simple variably low-pass-filtering governor in
>> > > control of the HWP MIN/MAX PERF range based on the previously
>> > > introduced get_vlp_target_range().  See "cpufreq: intel_pstate:
>> > > Implement VLP controller target P-state range estimation." for
>> > > the
>> > > rationale.
>> >=20
>> > I just gave a try on a pretty idle system with just systemd
>> > processes
>> > and usual background tasks with nomodset.=20
>> >=20
>> > I see that there HWP min is getting changed between 4-8. Why are
>> > changing HWP dynamic range even on an idle system running no where
>> > close to TDP?
>> >=20
>>=20
>> The HWP request range is clamped to the frequency range specified by
>> the
>> CPUFREQ policy and to the cpu->pstate.min_pstate bound.
>>=20
>> If you see the HWP minimum fluctuating above that it's likely a sign
>> of
>> your system not being completely idle -- If that's the case it's
>> likely
>> to go away after you do:
>>=20
>>  echo 0 > /sys/kernel/debug/pstate_snb/vlp_realtime_gain_pml
>>=20
> The objective which I though was to improve performance of GPU
> workloads limited by TDP because of P-states ramping up and resulting
> in less power to GPU to complete a task.
>=20=20
> HWP takes decision not on just load on a CPU but several other factors
> like total SoC power and scalability. We don't want to disturb HWP
> algorithms when there is no TDP limitations. If writing 0, causes this
> behavior then that should be the default.
>

The heuristic disabled by that debugfs file is there to avoid
regressions in latency-sensitive workloads as you can probably get from
the ecomments.  However ISTR those regressions were specific to non-HWP
systems, so I wouldn't mind disabling it for the moment (or punting it
to the non-HWP series if you like)j.  But first I need to verify that
there are no performance regressions on HWP systems after changing that.
Can you confirm that the debugfs write above prevents the behavior you'd
like to avoid?

> Thanks,
> Srinivas
>
>
>
>
>
>> > Thanks,
>> > Srinivas
>> >=20
>> >=20
>> > > Signed-off-by: Francisco Jerez <currojerez@riseup.net>
>> > > ---
>> > >  drivers/cpufreq/intel_pstate.c | 79
>> > > +++++++++++++++++++++++++++++++++-
>> > >  1 file changed, 77 insertions(+), 2 deletions(-)
>> > >=20
>> > > diff --git a/drivers/cpufreq/intel_pstate.c
>> > > b/drivers/cpufreq/intel_pstate.c
>> > > index cecadfec8bc1..a01eed40d897 100644
>> > > --- a/drivers/cpufreq/intel_pstate.c
>> > > +++ b/drivers/cpufreq/intel_pstate.c
>> > > @@ -1905,6 +1905,20 @@ static void intel_pstate_reset_vlp(struct
>> > > cpudata *cpu)
>> > >  	vlp->gain =3D max(1, div_fp(1000, vlp_params.setpoint_0_pml));
>> > >  	vlp->target.p_base =3D 0;
>> > >  	vlp->stats.last_response_frequency_hz =3D vlp_params.avg_hz;
>> > > +
>> > > +	if (hwp_active) {
>> > > +		const uint32_t p0 =3D max(cpu->pstate.min_pstate,
>> > > +					cpu->min_perf_ratio);
>> > > +		const uint32_t p1 =3D max_t(uint32_t, p0, cpu-
>> > > > max_perf_ratio);
>> > > +		const uint64_t hwp_req =3D (READ_ONCE(cpu-
>> > > > hwp_req_cached) &
>> > > +					  ~(HWP_MAX_PERF(~0L) |
>> > > +					    HWP_MIN_PERF(~0L) |
>> > > +					    HWP_DESIRED_PERF(~0L))) |
>> > > +					 HWP_MIN_PERF(p0) |
>> > > HWP_MAX_PERF(p1);
>> > > +
>> > > +		wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, hwp_req);
>> > > +		cpu->hwp_req_cached =3D hwp_req;
>> > > +	}
>> > >  }
>> > >=20=20
>> > >  /**
>> > > @@ -2222,6 +2236,46 @@ static void
>> > > intel_pstate_adjust_pstate(struct
>> > > cpudata *cpu)
>> > >  		fp_toint(cpu->iowait_boost * 100));
>> > >  }
>> > >=20=20
>> > > +static void intel_pstate_adjust_pstate_range(struct cpudata
>> > > *cpu,
>> > > +					     const unsigned int
>> > > range[])
>> > > +{
>> > > +	const int from =3D cpu->hwp_req_cached;
>> > > +	unsigned int p0, p1, p_min, p_max;
>> > > +	struct sample *sample;
>> > > +	uint64_t hwp_req;
>> > > +
>> > > +	update_turbo_state();
>> > > +
>> > > +	p0 =3D max(cpu->pstate.min_pstate, cpu->min_perf_ratio);
>> > > +	p1 =3D max_t(unsigned int, p0, cpu->max_perf_ratio);
>> > > +	p_min =3D clamp_t(unsigned int, range[0], p0, p1);
>> > > +	p_max =3D clamp_t(unsigned int, range[1], p0, p1);
>> > > +
>> > > +	trace_cpu_frequency(p_max * cpu->pstate.scaling, cpu->cpu);
>> > > +
>> > > +	hwp_req =3D (READ_ONCE(cpu->hwp_req_cached) &
>> > > +		   ~(HWP_MAX_PERF(~0L) | HWP_MIN_PERF(~0L) |
>> > > +		     HWP_DESIRED_PERF(~0L))) |
>> > > +		  HWP_MIN_PERF(vlp_params.debug & 2 ? p0 : p_min) |
>> > > +		  HWP_MAX_PERF(vlp_params.debug & 4 ? p1 : p_max);
>> > > +
>> > > +	if (hwp_req !=3D cpu->hwp_req_cached) {
>> > > +		wrmsrl(MSR_HWP_REQUEST, hwp_req);
>> > > +		cpu->hwp_req_cached =3D hwp_req;
>> > > +	}
>> > > +
>> > > +	sample =3D &cpu->sample;
>> > > +	trace_pstate_sample(mul_ext_fp(100, sample->core_avg_perf),
>> > > +			    fp_toint(sample->busy_scaled),
>> > > +			    from,
>> > > +			    hwp_req,
>> > > +			    sample->mperf,
>> > > +			    sample->aperf,
>> > > +			    sample->tsc,
>> > > +			    get_avg_frequency(cpu),
>> > > +			    fp_toint(cpu->iowait_boost * 100));
>> > > +}
>> > > +
>> > >  static void intel_pstate_update_util(struct update_util_data
>> > > *data,
>> > > u64 time,
>> > >  				     unsigned int flags)
>> > >  {
>> > > @@ -2260,6 +2314,22 @@ static void
>> > > intel_pstate_update_util(struct
>> > > update_util_data *data, u64 time,
>> > >  		intel_pstate_adjust_pstate(cpu);
>> > >  }
>> > >=20=20
>> > > +/**
>> > > + * Implementation of the cpufreq update_util hook based on the
>> > > VLP
>> > > + * controller (see get_vlp_target_range()).
>> > > + */
>> > > +static void intel_pstate_update_util_hwp_vlp(struct
>> > > update_util_data
>> > > *data,
>> > > +					     u64 time, unsigned int
>> > > flags)
>> > > +{
>> > > +	struct cpudata *cpu =3D container_of(data, struct cpudata,
>> > > update_util);
>> > > +
>> > > +	if (update_vlp_sample(cpu, time, flags)) {
>> > > +		const struct vlp_target_range *target =3D
>> > > +			get_vlp_target_range(cpu);
>> > > +		intel_pstate_adjust_pstate_range(cpu, target->value);
>> > > +	}
>> > > +}
>> > > +
>> > >  static struct pstate_funcs core_funcs =3D {
>> > >  	.get_max =3D core_get_max_pstate,
>> > >  	.get_max_physical =3D core_get_max_pstate_physical,
>> > > @@ -2389,6 +2459,9 @@ static int intel_pstate_init_cpu(unsigned
>> > > int
>> > > cpunum)
>> > >=20=20
>> > >  	intel_pstate_get_cpu_pstates(cpu);
>> > >=20=20
>> > > +	if (pstate_funcs.update_util =3D=3D
>> > > intel_pstate_update_util_hwp_vlp)
>> > > +		intel_pstate_reset_vlp(cpu);
>> > > +
>> > >  	pr_debug("controlling: cpu %d\n", cpunum);
>> > >=20=20
>> > >  	return 0;
>> > > @@ -2398,7 +2471,8 @@ static void
>> > > intel_pstate_set_update_util_hook(unsigned int cpu_num)
>> > >  {
>> > >  	struct cpudata *cpu =3D all_cpu_data[cpu_num];
>> > >=20=20
>> > > -	if (hwp_active && !hwp_boost)
>> > > +	if (hwp_active && !hwp_boost &&
>> > > +	    pstate_funcs.update_util !=3D
>> > > intel_pstate_update_util_hwp_vlp)
>> > >  		return;
>> > >=20=20
>> > >  	if (cpu->update_util_set)
>> > > @@ -2526,7 +2600,8 @@ static int intel_pstate_set_policy(struct
>> > > cpufreq_policy *policy)
>> > >  		 * was turned off, in that case we need to clear the
>> > >  		 * update util hook.
>> > >  		 */
>> > > -		if (!hwp_boost)
>> > > +		if (!hwp_boost && pstate_funcs.update_util !=3D
>> > > +				  intel_pstate_update_util_hwp_vlp)
>> > >  			intel_pstate_clear_update_util_hook(policy-
>> > > > cpu);
>> > >  		intel_pstate_hwp_set(policy->cpu);
>> > >  	}

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXnKC8gAKCRCDmTidfVK/
WwjpAP9Lht+LH9u8C7LhezrhlrRE8zKtSrzNdY7hy2a9B2Tx8AD8CM4A5JF30VvF
1wK8yMS2o0+OxwlVnNsfvztWkNO9JFI=
=J4Jr
-----END PGP SIGNATURE-----
--==-=-=--
