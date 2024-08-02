Return-Path: <linux-pm+bounces-11831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D53945DD4
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 14:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C305B22D18
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 12:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00511DF664;
	Fri,  2 Aug 2024 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9/EjL91"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF061C2322;
	Fri,  2 Aug 2024 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722602124; cv=none; b=C57lk540pylixSxY8UYehThXXsC4/5JBf3+7Fn4SVyBsyoN/eB1XfDXhtnks9bEDEQ0Khc1ufdmkfOw2JubkjgcFdmu6Dd4EWGX8oHejUI5t2vH/dkouMzLlAUL3iFX3HE2DfeKK3co9kwmTZeoewzc/D1WlgzHm0FBxD42bDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722602124; c=relaxed/simple;
	bh=FHnmpGRy8XB6Sk4thzRub55LsuEW/wUxScQBjyIdhwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrPUQ2QUd5E1wvCm++76GnRjjSuKJOpapUkDtCns7ykyw2DURxMsMEnrW2mhLQPPepKw9kiGa1hC2vZliBZDKONLDePil8E1A8Jp4+bq3lv3DDcrVIipOkM4id4u5shb/UyJpZHSxPes9zLU21qRjBX9fLRIxFTQroYmUQ+YKvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9/EjL91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19629C4AF0F;
	Fri,  2 Aug 2024 12:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722602124;
	bh=FHnmpGRy8XB6Sk4thzRub55LsuEW/wUxScQBjyIdhwY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a9/EjL91IlsfkKFaDSguE8aBOuIVCFWgc83VgXOkejD4AZr/nz0OwzLTBXkiO5U4/
	 UGVyEcDraSbfbs+ouCnlAFSfE5bIfQ1NQSO3pL3NTbDEDLzrfyi5JV6jyABb8yTOiU
	 EEEfM3HfLYuvVP0Z0hBenOZOrfBpL52G9dJXmfqFxZ1lmJrEoFSkHLCHRihy5dCC18
	 5ziGLAH9km1ETO6YiSYaep2Mbp1NM43ZV4vYMVMMgZeEpaoxxEMbH9EhSnE6YwC2qj
	 vate03mVdCLKZHLD4vBCZG3Kp0qMtfPMk+2F07DyFJh92zp3wq6XGmO7c2JsGh1joB
	 hdnAZP8e9NwQg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5c062f65cso688639eaf.3;
        Fri, 02 Aug 2024 05:35:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRILGAz2AvHOeIQqwRrpCYHBHgbZXc11FHSm0qDwUx3B3h9CR4xQ0GU6qcVCHeqadL+FARaiIeYtrjANguIvfAjbDzaxJln95lcRTYKPEh0m82/dsm+fh8ASZaK68Rd6cPrBHSgTJzsKV4F8YfWE//xxGOTZSNWI4iFF/Ln7gBFcnXsP5+VTHS
X-Gm-Message-State: AOJu0YwSMhKajmE+nXs3M8kiVSJbxwEmf/u9y/cAk9+OB+WobIaYvTvH
	pFujQW/nkQVgZh7WMei/OL3SiPeXHnOcPNEtcCY3fdP5OdImYL7GSWdPvka1oI2omPkZlXVWMgk
	eloVvyyQhhOqrmfyd4YEPqRCrmbQ=
X-Google-Smtp-Source: AGHT+IHKCZNxxthgxzvCmtFMXc0TcRz/ZjO3WP6GHIr9DsRgpDfzGnAkKSgA+J8T0YNm7URLGmMh58HfeLoZe/mHMlM=
X-Received: by 2002:a05:6870:c6aa:b0:260:eb92:22b5 with SMTP id
 586e51a60fabf-26891a29870mr2381440fac.1.1722602123299; Fri, 02 Aug 2024
 05:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730044917.4680-1-Dhananjay.Ugwekar@amd.com> <20240730044917.4680-3-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240730044917.4680-3-Dhananjay.Ugwekar@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Aug 2024 14:35:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h4GAVCpUnbCMHMophsSZ522kkReAbUMdfFgRJfd0vHkw@mail.gmail.com>
Message-ID: <CAJZ5v0h4GAVCpUnbCMHMophsSZ522kkReAbUMdfFgRJfd0vHkw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] powercap/intel_rapl: Fix the energy-pkg event for
 AMD CPUs
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, rui.zhang@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, ananth.narayan@amd.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, ravi.bangoria@amd.com, 
	Michael Larabel <michael@michaellarabel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 6:53=E2=80=AFAM Dhananjay Ugwekar
<Dhananjay.Ugwekar@amd.com> wrote:
>
> After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"=
),
> on AMD processors that support extended CPUID leaf 0x80000026, the
> topology_logical_die_id() macros, no longer returns package id, instead i=
t
> returns the CCD (Core Complex Die) id. This leads to the energy-pkg
> event scope to be modified to CCD instead of package.
>
> For more historical context, please refer to commit 32fb480e0a2c
> ("powercap/intel_rapl: Support multi-die/package"), which initially chang=
ed
> the RAPL scope from package to die for all systems, as Intel systems
> with Die enumeration have RAPL scope as die, and those without die
> enumeration are not affected. So, all systems(Intel, AMD, Hygon), worked
> correctly with topology_logical_die_id() until recently, but this changed
> after the "0x80000026 leaf" commit mentioned above.
>
> Future multi-die Intel systems will have package scope RAPL counters,
> but they will be using TPMI RAPL interface, which is not affected by
> this change.
>
> Replacing topology_logical_die_id() with topology_physical_package_id()
> conditionally only for AMD and Hygon fixes the energy-pkg event.
>
> On an AMD 2 socket 8 CCD Zen4 server:
>
> Before:
>
> linux$ ls /sys/class/powercap/
> intel-rapl      intel-rapl:4    intel-rapl:8:0  intel-rapl:d
> intel-rapl:0    intel-rapl:4:0  intel-rapl:9    intel-rapl:d:0
> intel-rapl:0:0  intel-rapl:5    intel-rapl:9:0  intel-rapl:e
> intel-rapl:1    intel-rapl:5:0  intel-rapl:a    intel-rapl:e:0
> intel-rapl:1:0  intel-rapl:6    intel-rapl:a:0  intel-rapl:f
> intel-rapl:2    intel-rapl:6:0  intel-rapl:b    intel-rapl:f:0
> intel-rapl:2:0  intel-rapl:7    intel-rapl:b:0
> intel-rapl:3    intel-rapl:7:0  intel-rapl:c
> intel-rapl:3:0  intel-rapl:8    intel-rapl:c:0
>
> After:
>
> linux$ ls /sys/class/powercap/
> intel-rapl  intel-rapl:0  intel-rapl:0:0  intel-rapl:1  intel-rapl:1:0
>
> Only one sysfs entry per-event per-package is created after this change.
>
> Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x8000002=
6 leaf")
> Reported-by: Michael Larabel <michael@michaellarabel.com>
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> ---
> Changes in v2:
> * Updated scope description comment, commit log
> * Rename rapl_pmu_is_pkg_scope() to rapl_msrs_are_pkg_scope()
> * Check topology_logical_(die/package)_id return value

This patch does not depend on the first one in the series if I'm not
mistaken, in which case I can pick it up separately if you want me to
do that, so please let me know.

Thanks!

> ---
>  drivers/powercap/intel_rapl_common.c | 34 ++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index 3cffa6c79538..4bc56acb99d6 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -2128,6 +2128,21 @@ void rapl_remove_package(struct rapl_package *rp)
>  }
>  EXPORT_SYMBOL_GPL(rapl_remove_package);
>
> +/*
> + * RAPL Package energy counter scope:
> + * 1. AMD/HYGON platforms use per-PKG package energy counter
> + * 2. For Intel platforms
> + *     2.1 CLX-AP platform has per-DIE package energy counter
> + *     2.2 Other platforms that uses MSR RAPL are single die systems so =
the
> + *          package energy counter can be considered as per-PKG/per-DIE,
> + *          here it is considered as per-DIE.
> + *     2.3 New platforms that use TPMI RAPL doesn't care about the
> + *         scope because they are not MSR/CPU based.
> + */
> +#define rapl_msrs_are_pkg_scope()                              \
> +       (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD ||  \
> +        boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_HYGON)
> +
>  /* caller to ensure CPU hotplug lock is held */
>  struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct =
rapl_if_priv *priv,
>                                                          bool id_is_cpu)
> @@ -2135,8 +2150,14 @@ struct rapl_package *rapl_find_package_domain_cpus=
locked(int id, struct rapl_if_
>         struct rapl_package *rp;
>         int uid;
>
> -       if (id_is_cpu)
> -               uid =3D topology_logical_die_id(id);
> +       if (id_is_cpu) {
> +               uid =3D rapl_msrs_are_pkg_scope() ?
> +                     topology_physical_package_id(id) : topology_logical=
_die_id(id);
> +               if (uid < 0) {
> +                       pr_err("topology_logical_(package/die)_id() retur=
ned a negative value");
> +                       return ERR_PTR(-EINVAL);
> +               }
> +       }
>         else
>                 uid =3D id;
>
> @@ -2168,9 +2189,14 @@ struct rapl_package *rapl_add_package_cpuslocked(i=
nt id, struct rapl_if_priv *pr
>                 return ERR_PTR(-ENOMEM);
>
>         if (id_is_cpu) {
> -               rp->id =3D topology_logical_die_id(id);
> +               rp->id =3D rapl_msrs_are_pkg_scope() ?
> +                        topology_physical_package_id(id) : topology_logi=
cal_die_id(id);
> +               if ((int)(rp->id) < 0) {
> +                       pr_err("topology_logical_(package/die)_id() retur=
ned a negative value");
> +                       return ERR_PTR(-EINVAL);
> +               }
>                 rp->lead_cpu =3D id;
> -               if (topology_max_dies_per_package() > 1)
> +               if (!rapl_msrs_are_pkg_scope() && topology_max_dies_per_p=
ackage() > 1)
>                         snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "p=
ackage-%d-die-%d",
>                                  topology_physical_package_id(id), topolo=
gy_die_id(id));
>                 else
> --
> 2.43.0
>
>

