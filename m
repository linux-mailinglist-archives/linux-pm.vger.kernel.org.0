Return-Path: <linux-pm+bounces-33979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4E2B45889
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 15:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6A05C0EC8
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 13:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267F3350857;
	Fri,  5 Sep 2025 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3bSByT7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A1F350848;
	Fri,  5 Sep 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078034; cv=none; b=sVkI+qkd358fXpRtwDfgN2opRJLVQbs3+vj6UURibv1VXb+CEkBD5I73L/V3BpjJaNGJ6VOwOg2ZiU69EBvcye8yNuWiJtW3yEj4qnaT5t4L84mz+qQZh56c7EtxpUJda0CX4qEDGyM61JO5jtNJvvFXNacz2BOIm9nPCZTe4kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078034; c=relaxed/simple;
	bh=4fPiVUr8iqSHUA1048R7A5lGeRD0073y1e1CWCfad+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cR25W6bg+DtdK39Q4TsWkX2ro9Mie2s8/XZyGZK2kHbff5VRxkPo16syoT7mhAyoAx2JXlVeEfSrGL7Jm4lpSjC26XgKIRE5tmim1QPdofBuVPEK6Qru/CrQoTDVsFSBeSbPTmnAyXtSbURPyfF+C+VIpHLOqhHU6ToK4X/Bc5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3bSByT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40A3C4CEFB;
	Fri,  5 Sep 2025 13:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757078033;
	bh=4fPiVUr8iqSHUA1048R7A5lGeRD0073y1e1CWCfad+4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r3bSByT7fJh4/eg4OUCA7r/B+lOhcIzVlTUYOH0PkK7wnmHVVqhsF3hB31k1ee16k
	 IE7zVoR7w6ItgNUPNeknoirAkgujWF7B057JqvQkoZZ5sjbJcGfBSy0mDB4Ix3HoPk
	 zCWBm1bw6z5GzuJ3L/vY4jy0llOv7BJjIlh4bP+UWH2Z7RyyjSGIoCnqzFQvn4No6X
	 4yAtGYd6SXsCR9XRlAe8Pb6Mn0U0Oq0ZtYn6fGBfEPw7+lths1xeo6AfQHcvdqm8vB
	 S2AGmabgQC9PNIbNHe+1soaGzmldetgDNeRVbyzJud1Y0sgXSSDdDMGHBFX9VCrvum
	 sFIhFmTZWT/4g==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7454cf6abf9so1023435a34.1;
        Fri, 05 Sep 2025 06:13:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4o4v+fgI68T/pMdqmBO5cpirGeq8vESJ1Dsf97LE8mdFmg3p+YP+oI6E/hBqjMe8Nvn4zQ/G6VMG8vlk=@vger.kernel.org, AJvYcCVXNIyY43VtIehvNawsaFQTgVLqhC278oQFMiHaXh4DZXkuxETlKDJPfG2KzQQ17XRo8OZOJ7HtyHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo9hwI3Z7E6fYI6saKuGvAh2Cubvpecje8+epnUHXTcU1LLQe6
	oQUDQBpoAY7menyA/wchME/Lq+kofYss8N4mZkbYwwRAmLenRyN5QRcOOgxiSChU9nWONGx93oe
	BaYrJ5ZiW7Y/H1fqAAHbyKKbTRktToFM=
X-Google-Smtp-Source: AGHT+IFffuiP30MgrkTsgngQV11TsWgdOrnGzK7NoEJFqBdCBOCtrraIWbEOd+sb7Dy7S/K5rYsbEu53ji3Zgc0AX60=
X-Received: by 2002:a05:6830:6a8b:b0:746:d832:eb4d with SMTP id
 46e09a7af769-746d832ee97mr3136923a34.6.1757078033181; Fri, 05 Sep 2025
 06:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12740505.O9o76ZdvQC@rafael.j.wysocki> <871polxs9c.ffs@tglx>
In-Reply-To: <871polxs9c.ffs@tglx>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 15:13:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jyN0=aGFOwE8fzuXi=1LgiLR5wgvvsAihGB0qpUp=mUQ@mail.gmail.com>
X-Gm-Features: Ac12FXytMQ0oah2eRFtPagBtfjslFVTgXfnj9GXfs5MDvT0D4yuymp6BzFyWryE
Message-ID: <CAJZ5v0jyN0=aGFOwE8fzuXi=1LgiLR5wgvvsAihGB0qpUp=mUQ@mail.gmail.com>
Subject: Re: [PATCH v1] cpu: Add missing check to cpuhp_smt_enable()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Christian Loehle <christian.loehle@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 9:39=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Fri, Aug 29 2025 at 22:01, Rafael J. Wysocki wrote:
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -2710,6 +2710,12 @@
> >       cpu_maps_update_begin();
> >       cpu_smt_control =3D CPU_SMT_ENABLED;
> >       for_each_present_cpu(cpu) {
> > +             /*
> > +              * Avoid accidentally onlining primary thread CPUs that h=
ave
> > +              * been taken offline.
> > +              */
> > +             if (topology_is_primary_thread(cpu))
> > +                     continue;
>
> Hmm. That's kinda solving the problem, but I think the proper solution
> would be to implement topology_is_core_online() for x86.
>
> The above is preventing the primary thread to be onlined, but then
> onlines the corresponding hyperthread, which does not really make sense.

Well, manual online can be used for onlining the secondary thread of a
core where the primary thread is offline, so this is technically
possible already.

> Something like the completely untested below.

So given the above, shouldn't topology_is_core_online() check if any
thread in the given core is online?

> ---
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topol=
ogy.h
> index 6c79ee7c0957..21041898157a 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -231,6 +231,16 @@ static inline bool topology_is_primary_thread(unsign=
ed int cpu)
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
> diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topolog=
y.c
> index e35ccdc84910..6073a16628f9 100644
> --- a/arch/x86/kernel/cpu/topology.c
> +++ b/arch/x86/kernel/cpu/topology.c
> @@ -372,6 +372,19 @@ unsigned int topology_unit_count(u32 apicid, enum x8=
6_topology_domains which_uni
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
>
>

