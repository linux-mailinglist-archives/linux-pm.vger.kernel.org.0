Return-Path: <linux-pm+bounces-39658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C40CC8D56
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 17:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F4188323E514
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 16:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76834DCCD;
	Wed, 17 Dec 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3ClToel"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6981B34DB75
	for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988839; cv=none; b=ONt2hBtkBX/r5W6NxgO604WpBm/pNm+jwFllxODpNl3thsdVtLml4GVBEpQNErC1Gb20ZhW8xUNO1k4iSeZTnaMo93BiOo64k8u6Iqg5jgtB9qbGQjJt4So5ev/aLpLuRC9T7LCDUEPuB2VIFeGgZw37atO7YR1DAYY30pZoyz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988839; c=relaxed/simple;
	bh=+6RkEBeM1QCS7AAwb7E8VMPZXz427bHunEHjO2qR/5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGI74Z9ysY+TLJDuAWs0AAQrDwoyqtqOuvBSgIvY96zWvc59/NLokgw57GWPDvZru8zFwzVCPDhM3TP8BdzHGoAFaOxiCpys+Xp5w9FQTnFljzEGy/xGmwpUFFKzUlZ/IXUHXb0imGx6/7AUq37mFJgCO2jUV6TJsrm75FT5uHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3ClToel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C363C4CEF5
	for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2025 16:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765988839;
	bh=+6RkEBeM1QCS7AAwb7E8VMPZXz427bHunEHjO2qR/5A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c3ClToelW7+3dH19iO97et2er8kIG8EXb220Olt/TvLCG0CtzkIvFs6Ns0J2y9pUx
	 rKul34jXU7OCA2b+Qc0R5h4uMnlNA4sLMTSAtJZZxVJhDTFTtf28tuFIhfl6BIRxLN
	 /ilcu4uNPAKqX7ndkLD9/7+Imbp+HXaKTgoQOgjZjGeMlGRWXwDSHKLQHBPENnadCY
	 EqpPMQygAFAQJuGWWf7UuypZdm9YZBNm8sEjALaRPw890PySyXBx+2VEpwgx1HT6bw
	 rarog5Lb/ogO7ztg84cgry/NMms6yRiaJaxMBTlVEfAXzT/t6midw/nvwUhqjQUYOX
	 IFPQu14qzciZQ==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3f9e592af58so1003097fac.2
        for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2025 08:27:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWplXytIvNquowAjankOknj2Olrn7EXiFg/okxaco8upfqI+2z1hL80HiYc2wwN7zS72vKR+Coelw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMkLPOPnBmIOArlD4THZGoUSg7cTk6jPE6FgmP99GtnvCS/Z0B
	PSUcRWVEb7X3NSywmmIHBO1jWulwwucA4ceTEj/9M4SdQ7O+vJTNu1HzwzJ9VEbL2+KZTAUSLUG
	k7VImm6nLgsbF6+DbsgwY3oKNeJ5VTFM=
X-Google-Smtp-Source: AGHT+IH5qVQcjuZSqC+zkKGJAVahJae8INKGe/qdE9fTyKPYpz/pbcYXqBou8r51keuQL0zzs17VACrG+h6oGwfQO2E=
X-Received: by 2002:a05:6820:1897:b0:659:9a49:9049 with SMTP id
 006d021491bc7-65b45186236mr7465582eaf.20.1765988838166; Wed, 17 Dec 2025
 08:27:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217153455.3560176-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20251217153455.3560176-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Dec 2025 17:27:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h4SPvp97iU9ibXrnjqKOQ7GZOtUPb9ZGj80=O5pfukYQ@mail.gmail.com>
X-Gm-Features: AQt7F2qXANFkY7ra7OKts1ws58AAQdAHbxb8UkBB-qRDS532HlGOB9s-rAlAVy4
Message-ID: <CAJZ5v0h4SPvp97iU9ibXrnjqKOQ7GZOtUPb9ZGj80=O5pfukYQ@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Fix possible recursive lock warning
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	RavitejaX Veesam <ravitejax.veesam@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 4:35=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> With the RAPL PMU addition, there is a recursive locking when CPU online
> callback function calls rapl_package_add_pmu(). Here cpu_hotplug_lock
> is already acquired by cpuhp_thread_fun() and rapl_package_add_pmu()
> tries to acquire again.
>
> <4>[ 8.197433] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> <4>[ 8.197437] WARNING: possible recursive locking detected
> <4>[ 8.197440] 6.19.0-rc1-lgci-xe-xe-4242-05b7c58b3367dca84+ #1 Not taint=
ed
> <4>[ 8.197444] --------------------------------------------
> <4>[ 8.197447] cpuhp/0/20 is trying to acquire lock:
> <4>[ 8.197450] ffffffff83487870 (cpu_hotplug_lock){++++}-{0:0}, at:
> rapl_package_add_pmu+0x37/0x370 [intel_rapl_common]
> <4>[ 8.197463]
> but task is already holding lock:
> <4>[ 8.197466] ffffffff83487870 (cpu_hotplug_lock){++++}-{0:0}, at:
> cpuhp_thread_fun+0x6d/0x290
> <4>[ 8.197477]
> other info that might help us debug this:
> <4>[ 8.197480] Possible unsafe locking scenario:
>
> <4>[ 8.197483] CPU0
> <4>[ 8.197485] ----
> <4>[ 8.197487] lock(cpu_hotplug_lock);
> <4>[ 8.197490] lock(cpu_hotplug_lock);
> <4>[ 8.197493]
> *** DEADLOCK ***
> ..
> ..
> <4>[ 8.197542] __lock_acquire+0x146e/0x2790
> <4>[ 8.197548] lock_acquire+0xc4/0x2c0
> <4>[ 8.197550] ? rapl_package_add_pmu+0x37/0x370 [intel_rapl_common]
> <4>[ 8.197556] cpus_read_lock+0x41/0x110
> <4>[ 8.197558] ? rapl_package_add_pmu+0x37/0x370 [intel_rapl_common]
> <4>[ 8.197561] rapl_package_add_pmu+0x37/0x370 [intel_rapl_common]
> <4>[ 8.197565] rapl_cpu_online+0x85/0x87 [intel_rapl_msr]
> <4>[ 8.197568] ? __pfx_rapl_cpu_online+0x10/0x10 [intel_rapl_msr]
> <4>[ 8.197570] cpuhp_invoke_callback+0x41f/0x6c0
> <4>[ 8.197573] ? cpuhp_thread_fun+0x6d/0x290
> <4>[ 8.197575] cpuhp_thread_fun+0x1e2/0x290
> <4>[ 8.197578] ? smpboot_thread_fn+0x26/0x290
> <4>[ 8.197581] smpboot_thread_fn+0x12f/0x290
> <4>[ 8.197584] ? __pfx_smpboot_thread_fn+0x10/0x10
> <4>[ 8.197586] kthread+0x11f/0x250
> <4>[ 8.197589] ? __pfx_kthread+0x10/0x10
> <4>[ 8.197592] ret_from_fork+0x344/0x3a0
> <4>[ 8.197595] ? __pfx_kthread+0x10/0x10
> <4>[ 8.197597] ret_from_fork_asm+0x1a/0x30
> <4>[ 8.197604] </TASK>
>
> Fix this issue in the same way as rapl powercap package domain is added
> from the same CPU online callback by introducing another interface which
> doesn't call cpus_read_lock(). Add rapl_package_add_pmu_locked() and
> rapl_package_remove_pmu_locked() which don't call cpus_read_lock().
>
> Fixes: 748d6ba43afd ("powercap: intel_rapl: Enable MSR-based RAPL PMU sup=
port")
> Reported-by: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
> Closes: https://lore.kernel.org/linux-pm/5427ede1-57a0-43d1-99f3-8ca4b064=
3e82@intel.com/T/#u
> Tested-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.i=
ntel.com>
> Tested-by: RavitejaX Veesam <ravitejax.veesam@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 24 ++++++++++++++++++------
>  drivers/powercap/intel_rapl_msr.c    |  4 ++--
>  include/linux/intel_rapl.h           |  4 ++++
>  3 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index b9d87e56cbbc..3ff6da3bf4e6 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -2032,7 +2032,7 @@ static int rapl_pmu_update(struct rapl_package *rp)
>         return ret;
>  }
>
> -int rapl_package_add_pmu(struct rapl_package *rp)
> +int rapl_package_add_pmu_locked(struct rapl_package *rp)
>  {
>         struct rapl_package_pmu_data *data =3D &rp->pmu_data;
>         int idx;
> @@ -2040,8 +2040,6 @@ int rapl_package_add_pmu(struct rapl_package *rp)
>         if (rp->has_pmu)
>                 return -EEXIST;
>
> -       guard(cpus_read_lock)();
> -
>         for (idx =3D 0; idx < rp->nr_domains; idx++) {
>                 struct rapl_domain *rd =3D &rp->domains[idx];
>                 int domain =3D rd->id;
> @@ -2091,17 +2089,23 @@ int rapl_package_add_pmu(struct rapl_package *rp)
>
>         return rapl_pmu_update(rp);
>  }
> +EXPORT_SYMBOL_GPL(rapl_package_add_pmu_locked);
> +
> +int rapl_package_add_pmu(struct rapl_package *rp)
> +{
> +       guard(cpus_read_lock)();
> +
> +       return rapl_package_add_pmu_locked(rp);
> +}
>  EXPORT_SYMBOL_GPL(rapl_package_add_pmu);
>
> -void rapl_package_remove_pmu(struct rapl_package *rp)
> +void rapl_package_remove_pmu_locked(struct rapl_package *rp)
>  {
>         struct rapl_package *pos;
>
>         if (!rp->has_pmu)
>                 return;
>
> -       guard(cpus_read_lock)();
> -
>         list_for_each_entry(pos, &rapl_packages, plist) {
>                 /* PMU is still needed */
>                 if (pos->has_pmu && pos !=3D rp)
> @@ -2111,6 +2115,14 @@ void rapl_package_remove_pmu(struct rapl_package *=
rp)
>         perf_pmu_unregister(&rapl_pmu.pmu);
>         memset(&rapl_pmu, 0, sizeof(struct rapl_pmu));
>  }
> +EXPORT_SYMBOL_GPL(rapl_package_remove_pmu_locked);
> +
> +void rapl_package_remove_pmu(struct rapl_package *rp)
> +{
> +       guard(cpus_read_lock)();
> +
> +       rapl_package_remove_pmu_locked(rp);
> +}
>  EXPORT_SYMBOL_GPL(rapl_package_remove_pmu);
>  #endif
>
> diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_r=
apl_msr.c
> index 0ce1096b6314..9a7e150b3536 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -82,7 +82,7 @@ static int rapl_cpu_online(unsigned int cpu)
>                 if (IS_ERR(rp))
>                         return PTR_ERR(rp);
>                 if (rapl_msr_pmu)
> -                       rapl_package_add_pmu(rp);
> +                       rapl_package_add_pmu_locked(rp);
>         }
>         cpumask_set_cpu(cpu, &rp->cpumask);
>         return 0;
> @@ -101,7 +101,7 @@ static int rapl_cpu_down_prep(unsigned int cpu)
>         lead_cpu =3D cpumask_first(&rp->cpumask);
>         if (lead_cpu >=3D nr_cpu_ids) {
>                 if (rapl_msr_pmu)
> -                       rapl_package_remove_pmu(rp);
> +                       rapl_package_remove_pmu_locked(rp);
>                 rapl_remove_package_cpuslocked(rp);
>         } else if (rp->lead_cpu =3D=3D cpu) {
>                 rp->lead_cpu =3D lead_cpu;
> diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
> index e9ade2ff4af6..f479ef5b3341 100644
> --- a/include/linux/intel_rapl.h
> +++ b/include/linux/intel_rapl.h
> @@ -214,10 +214,14 @@ void rapl_remove_package(struct rapl_package *rp);
>
>  #ifdef CONFIG_PERF_EVENTS
>  int rapl_package_add_pmu(struct rapl_package *rp);
> +int rapl_package_add_pmu_locked(struct rapl_package *rp);
>  void rapl_package_remove_pmu(struct rapl_package *rp);
> +void rapl_package_remove_pmu_locked(struct rapl_package *rp);
>  #else
>  static inline int rapl_package_add_pmu(struct rapl_package *rp) { return=
 0; }
> +static inline int rapl_package_add_pmu_locked(struct rapl_package *rp) {=
 return 0; }
>  static inline void rapl_package_remove_pmu(struct rapl_package *rp) { }
> +static inline void rapl_package_remove_pmu_locked(struct rapl_package *r=
p) { }
>  #endif
>
>  #endif /* __INTEL_RAPL_H__ */
> --

Applied as 6.19-rc material, thanks!

