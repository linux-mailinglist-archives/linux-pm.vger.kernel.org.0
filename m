Return-Path: <linux-pm+bounces-18949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2966B9EBB1B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BEA328361E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 20:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD4022B599;
	Tue, 10 Dec 2024 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsFFWUt8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B6822ACEB;
	Tue, 10 Dec 2024 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733863862; cv=none; b=U4TdocZBx/Ngu/h7RULs9Godh1qcEn+0JvLx0JmxUW1qS6P7fdnah5HyxlxPrVT2YJA+Qh5vBsmH/1+kYdrjflezPJipYhzsA56UB37a0LT8raTW66yYlwJa7Qp6nNSuoi38sjTfw8XbCpkuVViyvsTbE2P8Cflq2Kxrom5f3yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733863862; c=relaxed/simple;
	bh=dyEwqP/LvOfSb6lgImb0PrZsCaEvBCLNxC8XvejNDrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHBO3Madm9Vf/5vblhw1XzR2j22bv/bzDSuihYFyRm3UUCms1k8R+lBI0E8WybZ+BtOo1xnwy91IWVlVEUrb0epRL02fmO91zh8MuaQ0KuCqHejqOcQ9zbv6I9n9HFHqhzXglVX8j0J2hACGSDdLQjjAUP7I2X/MP7rgzlLJMVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsFFWUt8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7B9C4CEE2;
	Tue, 10 Dec 2024 20:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733863862;
	bh=dyEwqP/LvOfSb6lgImb0PrZsCaEvBCLNxC8XvejNDrc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HsFFWUt8Yn1wHjyYXuteu5LDa/b/JLcpPd7D4pQcsrKTOEN9cX7PlFUa+j1mh2VHm
	 jXBOUJT42zHmK+pWacPrxzGI8QBGD0yJ/e2ySg+6JN2/lT2WaIZ9Vhstq8UHO5nbO5
	 Fbjb+16qBIpAyM+W5M7BszVYgPOt9BpdPFru0cuG6mHZ/yQsE+l2zjKtEmtHGYlMhh
	 Rcz/1U2hhVmCeqAoimpCNkG7eVcHU9QtBM4bjnNtgJJwFWtm661s9HcSkFRJGy/dDj
	 mcGKEJEjkcQ5yXQw+1U5WYH0Qhyd7FttLQP+Pg6O9h7zK80KE36kNkY/sX7uQrvb2e
	 VHfmIGEHLsmZA==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71e1597e3b4so151464a34.3;
        Tue, 10 Dec 2024 12:51:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUi6G98XXzKoZeEKF5QuxpDM3G6KT4Zd3sdJDvjbOnR0m8UGMXHKF/5AqmwuPMjcO6++8Ebvx/T7bs=@vger.kernel.org, AJvYcCV+O/AoABODF99Tv6f0qa8cUPdqYbHIX10wIQImvThKhMyeGVXNAef9QyNhbJ89v/kAi+V44I+1JbYQ8Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoB+YRWAm+CzDAo2HIMiE67xW/SoVJDaZdZLxfMHUihvKmqtIY
	psTsGutEp1hwdq5as0H7/7dSMboJ3w2sqdSgqprjnNTrSzicewfGo/VFmp+01L5CW6SPzNRlZdD
	AWgRcNmDT+53fmfWfwkld6TOgoRQ=
X-Google-Smtp-Source: AGHT+IGT9d7iT2gDD2FgF/dK56idJ+pYXy+Fpv94tY9xP3Sd08ivYMCbdZtwuqM6bySxNyrFk7iIJhdTpF3x9R97dnc=
X-Received: by 2002:a05:6830:2a89:b0:71d:fe25:1a88 with SMTP id
 46e09a7af769-71e197f0d99mr213801a34.17.1733863861526; Tue, 10 Dec 2024
 12:51:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204140828.11699-1-patryk.wlazlyn@linux.intel.com> <20241204140828.11699-5-patryk.wlazlyn@linux.intel.com>
In-Reply-To: <20241204140828.11699-5-patryk.wlazlyn@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 21:50:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jg2pyeYOLZF8BEP3ptEsQT6bsz1H4AzWdp9kJ36Zj00g@mail.gmail.com>
Message-ID: <CAJZ5v0jg2pyeYOLZF8BEP3ptEsQT6bsz1H4AzWdp9kJ36Zj00g@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, peterz@infradead.org, dave.hansen@linux.intel.com, 
	gautham.shenoy@amd.com, tglx@linutronix.de, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

First off, I'd change the subject to something like "x86/smp:
Eliminate mwait_play_dead_cpuid_hint()" because that's what the patch
is doing.

On Wed, Dec 4, 2024 at 3:08=E2=80=AFPM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> The current algorithm* for looking up the mwait hint for the deepest
> cstate, in mwait_play_dead_cpuid_hint() code works by inspecting CPUID
> leaf 0x5 and calculates the mwait hint based on the number of reported
> substates.

I would just say

"Currently, mwait_play_dead_cpuid_hint() looks up the MWAIT hint of
the deepest idle state by inspecting CPUID leaf 0x5 with the
assumption that, if the number of sub-states for a given major C-state
is nonzero, those sub-states are always represented by consecutive
numbers starting from 0."

>  This approach depends on the hints associated with them to
> be continuous in the range [0, NUM_SUBSTATES-1]. This continuity is not
> documented and is not met on the recent Intel platforms.

And then

"This assumption is not based on the documented platform behavior and
in fact it is not met on recent Intel platforms."

>
>  * The current algorithm is implemented in the for loop inspecting edx
>    in mwait_play_dead_cpuid_hint().

The above sentence does not add any value IMV.

> For example, Intel's Sierra Forest report two cstates with two substates
> each in cpuid leaf 0x5:

It's "Intel Sierra Forest" and if you said C-states above, please be
consistent and say C-states here too.

>
>   Name*   target cstate    target subcstate (mwait hint)
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   C1      0x00             0x00
>   C1E     0x00             0x01
>
>   --      0x10             ----
>
>   C6S     0x20             0x22
>   C6P     0x20             0x23
>
>   --      0x30             ----
>
>   /* No more (sub)states all the way down to the end. */
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>    * Names of the cstates are not included in the CPUID leaf 0x5, they ar=
e
>      taken from the product specific documentation.
>
> Notice that hints 0x20 and 0x21 are skipped entirely for the target
> cstate 0x20 (C6), being a cause of the problem for the current cpuid
> leaf 0x5 algorithm.

And here

"Notice that hints 0x20 and 0x21 are not defined for C-state 0x20
(C6), so the existing MWAIT hint lookup in
mwait_play_dead_cpuid_hint() based on the CPUID leaf 0x5 contents does
not work in this case."

> Remove the old implementation of play_dead MWAIT hint calculation based
> on the CPUID leaf 0x5 in mwait_play_dead_cpuid_hint() and delegate
> calling of the mwait_play_dead() to the idle driver.

Well, the above is not exactly what's going on.

I'd say something like

"Instead of using MWAIT hint lookup that is not guaranteed to work,
make native_play_dead() rely on the idle driver for the given platform
to put CPUs going offline into appropriate idle state and, if that
fails, fall back to hlt_play_dead().

Accordingly, drop mwait_play_dead_cpuid_hint() altogether and make
native_play_dead() call cpuidle_play_dead() instead of it
unconditionally with the assumption that it will not return if it is
successful.  Still, in case cpuidle_play_dead() fails, call
hlt_play_dead() at the end."

> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> ---
>  arch/x86/kernel/smpboot.c | 56 +++++----------------------------------
>  1 file changed, 7 insertions(+), 49 deletions(-)
>
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 8a3545c2cae9..82801137486d 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1272,6 +1272,10 @@ void play_dead_common(void)
>         local_irq_disable();
>  }
>
> +/*
> + * We need to flush the caches before going to sleep, lest we have
> + * dirty data in our caches when we come back up.
> + */
>  void __noreturn mwait_play_dead(unsigned int eax_hint)
>  {
>         struct mwait_cpu_dead *md =3D this_cpu_ptr(&mwait_cpu_dead);
> @@ -1317,52 +1321,6 @@ void __noreturn mwait_play_dead(unsigned int eax_h=
int)
>         }
>  }
>
> -/*
> - * We need to flush the caches before going to sleep, lest we have
> - * dirty data in our caches when we come back up.
> - */
> -static inline void mwait_play_dead_cpuid_hint(void)
> -{
> -       unsigned int eax, ebx, ecx, edx;
> -       unsigned int highest_cstate =3D 0;
> -       unsigned int highest_subcstate =3D 0;
> -       int i;
> -
> -       if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD ||
> -           boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_HYGON)
> -               return;
> -       if (!this_cpu_has(X86_FEATURE_MWAIT))
> -               return;
> -       if (!this_cpu_has(X86_FEATURE_CLFLUSH))
> -               return;
> -       if (__this_cpu_read(cpu_info.cpuid_level) < CPUID_MWAIT_LEAF)
> -               return;
> -
> -       eax =3D CPUID_MWAIT_LEAF;
> -       ecx =3D 0;
> -       native_cpuid(&eax, &ebx, &ecx, &edx);
> -
> -       /*
> -        * eax will be 0 if EDX enumeration is not valid.
> -        * Initialized below to cstate, sub_cstate value when EDX is vali=
d.
> -        */
> -       if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED)) {
> -               eax =3D 0;
> -       } else {
> -               edx >>=3D MWAIT_SUBSTATE_SIZE;
> -               for (i =3D 0; i < 7 && edx; i++, edx >>=3D MWAIT_SUBSTATE=
_SIZE) {
> -                       if (edx & MWAIT_SUBSTATE_MASK) {
> -                               highest_cstate =3D i;
> -                               highest_subcstate =3D edx & MWAIT_SUBSTAT=
E_MASK;
> -                       }
> -               }
> -               eax =3D (highest_cstate << MWAIT_SUBSTATE_SIZE) |
> -                       (highest_subcstate - 1);
> -       }
> -
> -       mwait_play_dead(eax);
> -}
> -
>  /*
>   * Kick all "offline" CPUs out of mwait on kexec(). See comment in
>   * mwait_play_dead().
> @@ -1413,9 +1371,9 @@ void native_play_dead(void)
>         play_dead_common();
>         tboot_shutdown(TB_SHUTDOWN_WFS);
>
> -       mwait_play_dead_cpuid_hint();
> -       if (cpuidle_play_dead())
> -               hlt_play_dead();
> +       /* Below returns only on error. */
> +       cpuidle_play_dead();
> +       hlt_play_dead();
>  }
>
>  #else /* ... !CONFIG_HOTPLUG_CPU */
> --

