Return-Path: <linux-pm+bounces-35178-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0417B9203F
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 17:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CAD117A5EB
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7164C2EAB6C;
	Mon, 22 Sep 2025 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCFBpiJF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC222EA16D
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555772; cv=none; b=QwIKeNsam7hb22qR4p7BPlPtH7qkxc4CkUvOArt7wkI3qXWdfgQnt8WFxz7qcavhNZt0aBjCFo7qWjE4ffwb65+sE1V2gmdUXwMsZ7tM03LGF5nxuxMI/hyT+99t4byowOfrsSVTu1SfLUTIjUiaVbpyqm+DNAqbesVjC1PLZp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555772; c=relaxed/simple;
	bh=8a2xzUQVD9g6fYgl5qfxaW220V5QrIZ2t+whNUaKAEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvh/+yno1ECL9ihbXJyXnzypOcowU2ZkTMuJ7MhcVnFD4Gteu7FBHiMfRDR5YK7e+Nhs9k5A7LphuntrIXHQj+VIedMw5TBsBV/Tt2BQSlJAGHi6twb4e1KPT9UgdQf/uD1w6O7Q8vItLKHkpmbeicSU8cUybY6pTG8njdUAcsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCFBpiJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F5EC4CEF0
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 15:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555771;
	bh=8a2xzUQVD9g6fYgl5qfxaW220V5QrIZ2t+whNUaKAEw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bCFBpiJFpSveyzPEYzZRSSM7dEjExuWTrLMMljisPyehxDNsLtBAx+tAoWB8qCI60
	 Dia3CykgMQo64VLLfYQZMLaIC608ylc7xfajyuA1XZ9O4bMig0K7qIiCrRQaoj7dzC
	 ROfxHj25bflQANA7Yzzbc0XE/gOrbG/O7Dh2adyFEPxNYZnNdDHO2XShUhUqSxkSyJ
	 YVjbotM8F5OLx/Tiejh4nxEPZE/tVLNijaQq8DnT2P9z3PoALfzdRsL8RhejaoqooB
	 hgDy+UcZinBGOxgJWka344Hv1CUqLpkhnDWnyr1kbVnLeoavWMrgHcYyZoNaI6ITqa
	 24/QG67EEiF1Q==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6219b29ed57so2030972eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 08:42:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBgSHsLKHa8DZIpDY9QO2G8ONXjRt0ExRBOJLLQwDpUfL3Wj6YnqcBDRD97A/7g+RmURIkc8ihWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfuIqEhooXqe9k7L3GTW8+qFKUP2PlpHCMAnRXO+e6Txf9QXLD
	2iRJWvRqAkOT6YPjnqVkWXZHUyjCScifR7LCO0Z1XLK/riGx8FeXKwifgqdn+WRVpTCNb9O3Flu
	gEqOCh0lN0u9leDJpFny85DBzFiQi7bA=
X-Google-Smtp-Source: AGHT+IEM6VbLvbu+xwC6XpJ08a5O9TpUNhUlzecT/UdItH9r4lIBmLO8A4nhnKAqSWR4XGDk1UWsXrUSiXqzJW+gZRA=
X-Received: by 2002:a05:6808:191f:b0:43d:2762:834a with SMTP id
 5614622812f47-43d5b3fd59fmr7950395b6e.7.1758555771212; Mon, 22 Sep 2025
 08:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12740505.O9o76ZdvQC@rafael.j.wysocki> <871polxs9c.ffs@tglx>
 <CAJZ5v0jyN0=aGFOwE8fzuXi=1LgiLR5wgvvsAihGB0qpUp=mUQ@mail.gmail.com>
 <CAJZ5v0gsiuK5iFY6cHaqEgP8R1sz_pWGoqac2orYvXqLE2xbDQ@mail.gmail.com>
 <87o6rowrsp.ffs@tglx> <CAJZ5v0htmEeivbQaumRc7zw_Zx68GpUy98ksA9L42LupjO6tWA@mail.gmail.com>
 <87ldmqwgjc.ffs@tglx> <CAJZ5v0gW+A-eyckySFrHc7=Qr9URdRX6NqvPgkq4gZEvs_uBWg@mail.gmail.com>
 <87cy7k5gl3.ffs@tglx>
In-Reply-To: <87cy7k5gl3.ffs@tglx>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Sep 2025 17:42:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hkMUP3rwSggAPNp+LAKnYBoNn4sE2e9xGR_d-aofwxAA@mail.gmail.com>
X-Gm-Features: AS18NWDut5eiI7pdRbz4uGDE_snloiZCO-WRNYNZHkBj9-M5TFtrGKR0jxiCgr0
Message-ID: <CAJZ5v0hkMUP3rwSggAPNp+LAKnYBoNn4sE2e9xGR_d-aofwxAA@mail.gmail.com>
Subject: Re: [PATCH] x86/topology: Implement topology_is_core_online() to
 address SMT regression
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Christian Loehle <christian.loehle@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 10:56=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> Christian reported that commit a430c11f4015 ("intel_idle: Rescan "dead" S=
MT
> siblings during initialization") broke the use case in which both 'nosmt'
> and 'maxcpus' are on the kernel command line because it onlines primary
> threads, which were offline due to the maxcpus limit.
>
> The initially proposed fix to skip primary threads in the loop is
> inconsistent. While it prevents the primary thread to be onlined, it then
> onlines the corresponding hyperthread(s), which does not really make sens=
e.
>
> The CPU iterator in cpuhp_smt_enable() contains a check which excludes al=
l
> threads of a core, when the primary thread is offline. The default
> implementation is a NOOP and therefore not effective on x86.
>
> Implement topology_is_core_online() on x86 to address this issue. This
> makes the behaviour consistent between x86 and PowerPC.
>
> Fixes: a430c11f4015 ("intel_idle: Rescan "dead" SMT siblings during initi=
alization")
> Fixes: f694481b1d31 ("ACPI: processor: Rescan "dead" SMT siblings during =
initialization")
> Reported-by: Christian Loehle <christian.loehle@arm.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/12740505.O9o76ZdvQC@rafael.j.wysocki
> Closes: https://lore.kernel.org/linux-pm/724616a2-6374-4ba3-8ce3-ea9c45e2=
ae3b@arm.com/

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  arch/x86/include/asm/topology.h |   10 ++++++++++
>  arch/x86/kernel/cpu/topology.c  |   13 +++++++++++++
>  2 files changed, 23 insertions(+)
>
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -231,6 +231,16 @@ static inline bool topology_is_primary_t
>  }
>  #define topology_is_primary_thread topology_is_primary_thread
>
> +int topology_get_primary_thread(unsigned int cpu);
> +
> +static inline bool topology_is_core_online(unsigned int cpu)
> +{
> +       int pcpu =3D topology_get_primary_thread(cpu);
> +
> +       return pcpu >=3D 0 ? cpu_online(pcpu) : false;
> +}
> +#define topology_is_core_online topology_is_core_online
> +
>  #else /* CONFIG_SMP */
>  static inline int topology_phys_to_logical_pkg(unsigned int pkg) { retur=
n 0; }
>  static inline int topology_max_smt_threads(void) { return 1; }
> --- a/arch/x86/kernel/cpu/topology.c
> +++ b/arch/x86/kernel/cpu/topology.c
> @@ -372,6 +372,19 @@ unsigned int topology_unit_count(u32 api
>         return topo_unit_count(lvlid, at_level, apic_maps[which_units].ma=
p);
>  }
>
> +#ifdef CONFIG_SMP
> +int topology_get_primary_thread(unsigned int cpu)
> +{
> +       u32 apic_id =3D cpuid_to_apicid[cpu];
> +
> +       /*
> +        * Get the core domain level APIC id, which is the primary thread
> +        * and return the CPU number assigned to it.
> +        */
> +       return topo_lookup_cpuid(topo_apicid(apic_id, TOPO_CORE_DOMAIN));
> +}
> +#endif
> +
>  #ifdef CONFIG_ACPI_HOTPLUG_CPU
>  /**
>   * topology_hotplug_apic - Handle a physical hotplugged APIC after boot

