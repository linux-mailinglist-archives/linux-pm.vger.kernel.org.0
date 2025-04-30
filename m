Return-Path: <linux-pm+bounces-26475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB323AA54AC
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 21:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1559E173DB6
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 19:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B40D265616;
	Wed, 30 Apr 2025 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaBaAUtw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F47D1C8FB5;
	Wed, 30 Apr 2025 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746041358; cv=none; b=UNp29BNfnBKNqZJR4oV8aOsxeSo5DnbwhdYhS7CxSlCcXCaj+0LDpgldkDYn0v363RvXFEuxPvMhZwAdwmkUMQE64wcL76xJ3PTJBHGK/nIrviQFUrWAkv9JAZCVPPBR9oTV9dQu58ygceQv7S4DRg+AmvI/0m1ODdU3Ej9ZKgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746041358; c=relaxed/simple;
	bh=TSQzzbl3EsKBukopuvv7KXmmhLFWkYUsMHgSZYkoJ5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mr3z0NvKnM+CbNG1AuoXqfCU8P0lfQ61nUhrdGEILgzTXs3pFXLGS/xftnh1U9Q2HNlrCO/HlGQwq6+IcbRqQhnxwk96W6O5YcT5HWldQYV2b+VFvWBCJPZ99194/CeCLIrnXH9QoCgeNYSOt8dBDf9HO6pYiP+2gvqqwIVF1Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaBaAUtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F66C4CEE7;
	Wed, 30 Apr 2025 19:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746041357;
	bh=TSQzzbl3EsKBukopuvv7KXmmhLFWkYUsMHgSZYkoJ5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uaBaAUtwofPpbz/CI1LETtyvLTZRHy313M+gwo5LvqHZNvWvz21K1AIp2jqqdE0hQ
	 e0CoyoWMfZgz5Pm5krVijRw/DGoCNmufZ3Qmz9tGGolBtLir0ChWZA35oKUa2pXt8G
	 C8uFhKbwPai8tFn7USoXeH1Lq8Hq2SA6GsLHLxAwVObQ8fadPe16UkL42G1RiLfEpX
	 i2Sy80I9oKifKYBx81nC1AEcDXWDFHCfJgReERy9gKWlKydWTBqA4wMGRVFL7LzXDx
	 RLcuFcVApW1qBbFMza1A3tyz7O84mF7jlqOiQik9DWig50Bf/1rPGa05AH1wGnp1fX
	 QtdveJlk7C9ww==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-60658e1fedfso86182eaf.2;
        Wed, 30 Apr 2025 12:29:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU08VRQfgsEMBr9CSpeJUgxW4kUaws87BOi+4htlBc4d1pBJabYMZ5Jqs9YMHppm9tJRVZbDWYXf8U7lhs=@vger.kernel.org, AJvYcCXg0hJGp5od8kn4cynJCDIJXzw70GNsELVF3+xd8Qas4kc0tm80KL8TOB607IceFhFu4yuLpmVGIfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPLAZ/e1OyJ/dPK09uLdEtMD+D2DatqrDxTIgNOtKBkfXqe3U8
	SFShfOOg2FtriejPUtWs98fM3U23tqvlwXxdUlIAtv038F9mQ5RYtM4C3ceS/M9RUuo2dtt7PUK
	ep8YJpraqb1NYeJ9aq9jTleH8Duw=
X-Google-Smtp-Source: AGHT+IGISJUV2jpLcM2+2GyXFPp+2NbPz0XfmZEs2LzbFKHFbUrTlMI0gMVlFY3xzLFLilCvXqPlK271k4dfipxZfU4=
X-Received: by 2002:a05:6870:b010:b0:2d4:d07c:7cb6 with SMTP id
 586e51a60fabf-2da69d10088mr2314347fac.1.1746041357018; Wed, 30 Apr 2025
 12:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3344336.aeNJFYEL58@rjwysocki.net> <1964444.taCxCBeP46@rjwysocki.net>
 <a8f11abd-758e-4e5e-bf78-419b95100918@arm.com>
In-Reply-To: <a8f11abd-758e-4e5e-bf78-419b95100918@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 Apr 2025 21:29:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g+pRw4H39-BNKKD9KhtRm78y9Q9a3K+yjjK1jskcbJnw@mail.gmail.com>
X-Gm-Features: ATxdqUE7jnQrQB_qNd2gwjLYX4xS2wxQi29rcxmuLElBWeI__c5V-_HKbZuWxp8
Message-ID: <CAJZ5v0g+pRw4H39-BNKKD9KhtRm78y9Q9a3K+yjjK1jskcbJnw@mail.gmail.com>
Subject: Re: [RFT][PATCH v1 7/8] cpufreq: intel_pstate: Align perf domains
 with L2 cache
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Morten Rasmussen <morten.rasmussen@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Christian Loehle <christian.loehle@arm.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 6:23=E2=80=AFPM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 16/04/2025 20:10, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > On some hybrid platforms a group of cores (referred to as a module) may
> > share an L2 cache in which case they also share a voltage regulator and
> > always run at the same frequency (while not in idle states).
> >
> > For this reason, make hybrid_register_perf_domain() in the intel_pstate
> > driver add all CPUs sharing an L2 cache to the same perf domain for EAS=
.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > New in v1.
> >
> > ---
> >  drivers/cpufreq/intel_pstate.c |   23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -999,8 +999,11 @@
> >  {
> >       static const struct em_data_callback cb
> >                       =3D EM_ADV_DATA_CB(hybrid_active_power, hybrid_ge=
t_cost);
> > +     struct cpu_cacheinfo *cacheinfo =3D get_cpu_cacheinfo(cpu);
> > +     const struct cpumask *cpumask =3D cpumask_of(cpu);
> >       struct cpudata *cpudata =3D all_cpu_data[cpu];
> >       struct device *cpu_dev;
> > +     int ret;
> >
> >       /*
> >        * Registering EM perf domains without enabling asymmetric CPU ca=
pacity
> > @@ -1014,9 +1017,25 @@
> >       if (!cpu_dev)
> >               return false;
> >
> > -     if (em_dev_register_perf_domain(cpu_dev, HYBRID_EM_STATE_COUNT, &=
cb,
> > -                                     cpumask_of(cpu), false))
> > +     if (cacheinfo) {
> > +             unsigned int i;
> > +
> > +             /* Find the L2 cache and the CPUs sharing it. */
> > +             for (i =3D 0; i < cacheinfo->num_leaves; i++) {
> > +                     if (cacheinfo->info_list[i].level =3D=3D 2) {
> > +                             cpumask =3D &cacheinfo->info_list[i].shar=
ed_cpu_map;
> > +                             break;
> > +                     }
> > +             }
> > +     }
> > +
> > +     ret =3D em_dev_register_perf_domain(cpu_dev, HYBRID_EM_STATE_COUN=
T, &cb,
> > +                                       cpumask, false);
> > +     if (ret) {
> > +             cpudata->em_registered =3D ret =3D=3D -EEXIST;
> > +
> >               return false;
> > +     }
> >
> >       cpudata->em_registered =3D true;
>
> There seems to be an issue with late CPU-hotplug-in and this alignment
> on L2 cache boundaries.
>
> Example:
>
> i7-13700K [P-cores: [0,2,4,6,8,10,12,14] E-cores: [16-23] w/ 'nosmt' and
> 'maxcpus=3D12', [16-19] & [20-23] share L2 cache.
>
> root:/sys/kernel/debug/energy_model# cat cpu*/cpus
> 0
> 10
> 12
> 14
> 16-19
> 2
> 4
> 6
> 8
>
> # echo 1 > /sys/devices/system/cpu/cpu20/online
>
> ...
> [  496.616050] root_domain 0,2,4,6,8,10,12,14,16-20: pd20:{ cpus=3D20
> nr_pstate=3D4 } pd16:{ cpus=3D16-19 nr_pstate=3D4 } pd14:{ cpus=3D14 nr_p=
state=3D4
> } pd12:{ cpus=3D12 nr_pstate=3D4 } pd10:{ cpus=3D10 nr_pstate=3D4 } pd8:{=
 cpus=3D8
> nr_pstate=3D4 } pd6:{ cpus=3D6 nr_pstate=3D4 } pd4:{ cpus=3D4 nr_pstate=
=3D4 }
> pd2:{ cpus=3D2 nr_pstate=3D4 } pd0:{ cpus=3D0 nr_pstate=3D4 }
> ...
>
> root:/sys/kernel/debug/energy_model# cat cpu*/cpus
> 0
> 10
> 12
> 14
> 16-19
> 20
> 2
> 4
> 6
> 8
>
> # echo 1 > /sys/devices/system/cpu/cpu21/online
>
> ...
> [  589.001256] root domain span: 0,2,4,6,8,10,12,14,16-21
> [  589.001265] pd_init: no EM found for CPU21
> [  589.001266] sched_energy_set: stopping EAS
> ...
>
> root:/sys/kernel/debug/energy_model# cat cpu*/cpus
> 0
> 10
> 12
> 14
> 16-19
> 20
> 2
> 4
> 6
> 8

I see.

What happens is that cpu_cacheinfo hides information on offline CPUs,
so when CPU20 goes online, it doesn't see any other CPUs sharing the
L2 with it.  Accordingly, a PD is created just for itself.

When CPU21 goes online, it sees that CPU20 shares the L2 with it, so
the code attempts to create a PD for them both which fails.

This could be addressed, but the code would need to be a bit more
complex and the current hardware seems to do better with a PD per CPU,
so I'll drop the $subject patch for now.

