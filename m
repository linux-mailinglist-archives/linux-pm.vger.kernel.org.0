Return-Path: <linux-pm+bounces-10296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD5591E63B
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 19:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8ED1C21D58
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 17:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807BC16E861;
	Mon,  1 Jul 2024 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2jnUjY0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D0216631C;
	Mon,  1 Jul 2024 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719853733; cv=none; b=X0BszuGLPRxaErRg6lyrDZ5FBJYZmPqLD7o080rR8oxBG29p5wI07/U+k7TUan+KrykSTa1I5NDqlSnrFJZYs7N3USMBG6hPNec1vwgue+e4NkM9k93UbT1e/r41KZnf9tfYmf223RDdAMObNZKYKkcoAEFxy3QFiSTOx+lUraI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719853733; c=relaxed/simple;
	bh=zsbuHy5w3OfgJ0azDM2BXoti/8qlEfU9xPQTRcEHelw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=De3fillKepmd6Dvu88Xa2HIpwgXoPIqoR2vfDqNeVhnECV5dls8hqIIZDzeU45wasvCGXf/LPo0/AHmjG7inLOi1VRtrWYjPuWtpYVfmohQlG6vpdx3/tbMPDmHEYZ88ZqOllGBUCIwN6vM69KwhM64kj2guqgl7Vg2FokCS4aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2jnUjY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD7FC116B1;
	Mon,  1 Jul 2024 17:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719853732;
	bh=zsbuHy5w3OfgJ0azDM2BXoti/8qlEfU9xPQTRcEHelw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F2jnUjY0VX/mlOYaaaNOahMAfD4fMzU2DiWaZErPsQyjNQ54vosqhObE2Br7YSC6C
	 XhzIXAZNPVuU9frlgBdRX2VyQUK6CIBtiXPdJKn6iuGrYIzBtw8rYLsHhWCLaiZjkb
	 pSOHU3AuRZjehR/LRU0C+OBApkLKBRdvEf2o3wi/1TzazaaTFs5s/YbxP66zS0HHAr
	 txWK8GIpyb3UBLSfAJbGNjTc68vTU/6u3USm+lkml5zwU4dp61haT9SzTz519ruHiu
	 mOb46CW+BdcTCdxnyp7QevmaEogoZUIwtlHXrXij1LhDq/F5Vd7de1fyKiOvBhF7M/
	 6nNjV8zO7HnDA==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25cd2b51fd3so429436fac.3;
        Mon, 01 Jul 2024 10:08:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2+p8AwhpO+OnofTGUeYndZ8l/QUYstLZP/0FmO97FAjsz33caxHAqVYEW9CtOwkWnYnv2jOp1MP3TNnc1599FiwN8GnNIMDp1S59sidLG5A4Wd/jWWD/cn9W4LNipX7B0efIFnHsqA23HFUplFZ6yvaGWGi7uKW0QC6EpRhcNc9Ong0MYuoP5
X-Gm-Message-State: AOJu0YwvVtdxRnQ9KbhfcBmYC6C3Z9+z5cc4mDz+4DoE3iBSMhD2L/hu
	uF1gdi4JgevETCbPU5eFvc5rWVuD+AbCX9y3QQBiKn3zKIInOrfcqB69YSqD9tigMYk0sfbH2n8
	JflY4d0lBgcjxkZtgP5bnlfkR0jU=
X-Google-Smtp-Source: AGHT+IHR4xtavs3WYiLzujF4aoqo2c9S9zl3NErTsshLspZCJKaUFkpOeuqq5NUryZB+mKUEOJsqiLWQefG2dVeChEg=
X-Received: by 2002:a05:6871:71e:b0:25d:707d:2550 with SMTP id
 586e51a60fabf-25db344441amr6479512fac.2.1719853732094; Mon, 01 Jul 2024
 10:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com> <20240627-add-cpu-type-v2-2-f927bde83ad0@linux.intel.com>
In-Reply-To: <20240627-add-cpu-type-v2-2-f927bde83ad0@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jul 2024 19:08:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g+ih6Yh3su58Wrj+p04vr_4nmcJc41O-8_OCyzVQFKpA@mail.gmail.com>
Message-ID: <CAJZ5v0g+ih6Yh3su58Wrj+p04vr_4nmcJc41O-8_OCyzVQFKpA@mail.gmail.com>
Subject: Re: [PATCH PATCH v2 2/9] cpufreq: intel_pstate: Use topology_cpu_type()
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	daniel.sneddon@linux.intel.com, tony.luck@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Brice Goglin <brice.goglin@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <Perry.Yuan@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 10:44=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> Intel pstate driver uses hybrid_get_type() to get the cpu-type of a given
> CPU. It uses smp_call_function_single() which is sub-optimal. Avoid it by
> using topology_hw_cpu_type(cpu) that returns the cached cpu-type.
>
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I'm assuming that it will be routed along with the rest of the series.

Thanks!

> ---
>  drivers/cpufreq/intel_pstate.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 15de5e3d96fd..0a1e832c7536 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1956,24 +1956,16 @@ static int knl_get_turbo_pstate(int cpu)
>         return ret;
>  }
>
> -static void hybrid_get_type(void *data)
> -{
> -       u8 *cpu_type =3D data;
> -
> -       *cpu_type =3D get_this_hybrid_cpu_type();
> -}
> -
>  static int hwp_get_cpu_scaling(int cpu)
>  {
> -       u8 cpu_type =3D 0;
> +       u8 cpu_type =3D topology_hw_cpu_type(cpu);
>
> -       smp_call_function_single(cpu, hybrid_get_type, &cpu_type, 1);
>         /* P-cores have a smaller perf level-to-freqency scaling factor. =
*/
> -       if (cpu_type =3D=3D 0x40)
> +       if (cpu_type =3D=3D X86_HW_CPU_TYPE_INTEL_CORE)
>                 return hybrid_scaling_factor;
>
>         /* Use default core scaling for E-cores */
> -       if (cpu_type =3D=3D 0x20)
> +       if (cpu_type =3D=3D X86_HW_CPU_TYPE_INTEL_ATOM)
>                 return core_get_scaling();
>
>         /*
>
> --

