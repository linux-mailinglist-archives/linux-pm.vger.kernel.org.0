Return-Path: <linux-pm+bounces-18068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A99C9D8733
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0807165454
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD781ADFFB;
	Mon, 25 Nov 2024 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECQyahXm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5361AB52F;
	Mon, 25 Nov 2024 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543143; cv=none; b=LjmzTDLQ7boH3pxGe+zLgo6zURT2Hgr4waW/BOM4SQjYAuMtEk0sn2MikqoSz5xN3n+AK6Oge1YHvRsHo7SE2GBxQvE3XxDx7bSFC1ul7l4VM1zFP53q99ZIi3JPAk6jFI76hrI7bd+CHZGHKF+yD8K1nAm5rOUbePNgyLu7uMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543143; c=relaxed/simple;
	bh=nlh06/M9w7dwb0Qqn+nEAG4gZRwWgR83iPO+ZSzTMI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqpJeOP3kCR+EttMViOf+TTzURHqZvZHeg5ge+Hwh60vMiRo/ZeaSBSP8aRKbbA2P5WnSMWUkxJ762FgD1fs3uUmohmrWrlB8FWfsHA3a9Y5HgSLBgXhT0SDsUbfGbhL4GipS58Dr1g2JkgRlmG2scvFg64PNZoxa+NkqnP9I7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECQyahXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5975C4CED2;
	Mon, 25 Nov 2024 13:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543142;
	bh=nlh06/M9w7dwb0Qqn+nEAG4gZRwWgR83iPO+ZSzTMI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ECQyahXm2J0x21D6BzUE8EXkPhAr3mtQOQOQCDZYrU3/norB9Q7Boy3pRRxNmk4Z0
	 Y/VKw48vfThuqwMbs0GrDUkyDckAM4vanQ45blosAcX7AUErtQQHmWS10EMAvXLPvj
	 oYOMtj2tvechcvG3l78NOMFafyy3HEULry4aXG6CN4oNptJvGaw0z4hbD7s5yQjb4x
	 FawE0t0py3WjdWsQ2boMyd8TxiTTbTBI8LcI1Bab84u/rAP0IH2Kt/YAyu/4R+1Z+D
	 XOzCnL9SCq1Wtub+3F985+5eB29JrUS8l3/S0vULfHsneALhvr2HeSb/gtNo6Ql2Zs
	 a4y1IicWRGe5Q==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-296bf028170so1583683fac.3;
        Mon, 25 Nov 2024 05:59:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNVnDELwRm9a8kAaMh+YaahEEs4pzZ/g8szQvZTUZ5RVFDEckKW2FkfWvkGud4mtRqicgdsWCTBD0=@vger.kernel.org, AJvYcCWCQdPrfngwN22TVODUtICLSBSKuonrCboesASYho4f7alfzIbe/a50oKDgpBBGSr8bXYhmxNtc3MiVA/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZNqIONmwBODlBFzykc1KIBFQuH5Vg1j4k2MrXoH3G0+fDIWu
	ATduriHNOvlEHKcvZF/gvoQKwYTb79TqE/kxU/VejmOrf7UTwSTMsw9G7GCOUR91+9V+DlgCr9f
	R6i/e8SGWAJYXnknDIfBJZHI4zKw=
X-Google-Smtp-Source: AGHT+IGJZsp9odA0xVFquO+ieauG9+0l4/9M850g3RDFcOnRAJEukkiWpLw3QcJWekLNL5vl2hlIEWbzhtac+mr6PXo=
X-Received: by 2002:a05:6870:a543:b0:297:2201:84cd with SMTP id
 586e51a60fabf-2972201ab96mr7861067fac.5.1732543141951; Mon, 25 Nov 2024
 05:59:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-7-patryk.wlazlyn@linux.intel.com> <20241125135306.GD38837@noisy.programming.kicks-ass.net>
In-Reply-To: <20241125135306.GD38837@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Nov 2024 14:58:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gXy5FNsRepBTAyBS++HmhszZbN22KgfO8M=mXRVK9d6Q@mail.gmail.com>
Message-ID: <CAJZ5v0gXy5FNsRepBTAyBS++HmhszZbN22KgfO8M=mXRVK9d6Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 6/8] intel_idle: Provide enter_dead() handler for SRF
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com, 
	tglx@linutronix.de, gautham.shenoy@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 2:53=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Nov 25, 2024 at 02:20:26PM +0100, Patryk Wlazlyn wrote:
> > Intel's Sierra Forest report two C6 substates in cpuid leaf 5:
> >     C6S  (hint 0x22)
> >     C6SP (hint 0x23)
> >
> > Hints 0x20 and 0x21 are skipped entirely, causing the generic
> > implementation in mwait_play_dead() to compute the wrong hint, when
> > looking for the deepest cstate. As a result, package with an offlined
> > CPU can never reach PC6.
> >
> > Define the enter_dead() handler for SRF.
>
> How about you do something like so instead?
>
> ---
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index ac4d8faa3886..c49ca89ee17c 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -240,7 +240,7 @@ static struct cpuidle_state nehalem_cstates[] __initd=
ata =3D {
>                 .exit_latency =3D 3,
>                 .target_residency =3D 6,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -248,7 +248,7 @@ static struct cpuidle_state nehalem_cstates[] __initd=
ata =3D {
>                 .exit_latency =3D 10,
>                 .target_residency =3D 20,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C3",
>                 .desc =3D "MWAIT 0x10",
> @@ -256,7 +256,7 @@ static struct cpuidle_state nehalem_cstates[] __initd=
ata =3D {
>                 .exit_latency =3D 20,
>                 .target_residency =3D 80,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -264,7 +264,7 @@ static struct cpuidle_state nehalem_cstates[] __initd=
ata =3D {
>                 .exit_latency =3D 200,
>                 .target_residency =3D 800,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -277,7 +277,7 @@ static struct cpuidle_state snb_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 2,
>                 .target_residency =3D 2,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -285,7 +285,7 @@ static struct cpuidle_state snb_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 10,
>                 .target_residency =3D 20,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C3",
>                 .desc =3D "MWAIT 0x10",
> @@ -293,7 +293,7 @@ static struct cpuidle_state snb_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 80,
>                 .target_residency =3D 211,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -301,7 +301,7 @@ static struct cpuidle_state snb_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 104,
>                 .target_residency =3D 345,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C7",
>                 .desc =3D "MWAIT 0x30",
> @@ -309,7 +309,7 @@ static struct cpuidle_state snb_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 109,
>                 .target_residency =3D 345,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -322,7 +322,7 @@ static struct cpuidle_state byt_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 1,
>                 .target_residency =3D 1,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6N",
>                 .desc =3D "MWAIT 0x58",
> @@ -330,7 +330,7 @@ static struct cpuidle_state byt_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 300,
>                 .target_residency =3D 275,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6S",
>                 .desc =3D "MWAIT 0x52",
> @@ -338,7 +338,7 @@ static struct cpuidle_state byt_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 500,
>                 .target_residency =3D 560,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C7",
>                 .desc =3D "MWAIT 0x60",
> @@ -346,7 +346,7 @@ static struct cpuidle_state byt_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 1200,
>                 .target_residency =3D 4000,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C7S",
>                 .desc =3D "MWAIT 0x64",
> @@ -354,7 +354,7 @@ static struct cpuidle_state byt_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 10000,
>                 .target_residency =3D 20000,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -367,7 +367,7 @@ static struct cpuidle_state cht_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 1,
>                 .target_residency =3D 1,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6N",
>                 .desc =3D "MWAIT 0x58",
> @@ -375,7 +375,7 @@ static struct cpuidle_state cht_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 80,
>                 .target_residency =3D 275,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6S",
>                 .desc =3D "MWAIT 0x52",
> @@ -383,7 +383,7 @@ static struct cpuidle_state cht_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 200,
>                 .target_residency =3D 560,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C7",
>                 .desc =3D "MWAIT 0x60",
> @@ -391,7 +391,7 @@ static struct cpuidle_state cht_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 1200,
>                 .target_residency =3D 4000,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C7S",
>                 .desc =3D "MWAIT 0x64",
> @@ -399,7 +399,7 @@ static struct cpuidle_state cht_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 10000,
>                 .target_residency =3D 20000,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -412,7 +412,7 @@ static struct cpuidle_state ivb_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 1,
>                 .target_residency =3D 1,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -420,7 +420,7 @@ static struct cpuidle_state ivb_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 10,
>                 .target_residency =3D 20,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C3",
>                 .desc =3D "MWAIT 0x10",
> @@ -428,7 +428,7 @@ static struct cpuidle_state ivb_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 59,
>                 .target_residency =3D 156,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -436,7 +436,7 @@ static struct cpuidle_state ivb_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 80,
>                 .target_residency =3D 300,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C7",
>                 .desc =3D "MWAIT 0x30",
> @@ -444,7 +444,7 @@ static struct cpuidle_state ivb_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 87,
>                 .target_residency =3D 300,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -457,7 +457,7 @@ static struct cpuidle_state ivt_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 1,
>                 .target_residency =3D 1,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -465,7 +465,7 @@ static struct cpuidle_state ivt_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 10,
>                 .target_residency =3D 80,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C3",
>                 .desc =3D "MWAIT 0x10",
> @@ -473,7 +473,7 @@ static struct cpuidle_state ivt_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 59,
>                 .target_residency =3D 156,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -481,7 +481,7 @@ static struct cpuidle_state ivt_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 82,
>                 .target_residency =3D 300,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -494,7 +494,7 @@ static struct cpuidle_state ivt_cstates_4s[] __initda=
ta =3D {
>                 .exit_latency =3D 1,
>                 .target_residency =3D 1,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -502,7 +502,7 @@ static struct cpuidle_state ivt_cstates_4s[] __initda=
ta =3D {
>                 .exit_latency =3D 10,
>                 .target_residency =3D 250,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C3",
>                 .desc =3D "MWAIT 0x10",
> @@ -510,7 +510,7 @@ static struct cpuidle_state ivt_cstates_4s[] __initda=
ta =3D {
>                 .exit_latency =3D 59,
>                 .target_residency =3D 300,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -518,7 +518,7 @@ static struct cpuidle_state ivt_cstates_4s[] __initda=
ta =3D {
>                 .exit_latency =3D 84,
>                 .target_residency =3D 400,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -531,7 +531,7 @@ static struct cpuidle_state ivt_cstates_8s[] __initda=
ta =3D {
>                 .exit_latency =3D 1,
>                 .target_residency =3D 1,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -539,7 +539,7 @@ static struct cpuidle_state ivt_cstates_8s[] __initda=
ta =3D {
>                 .exit_latency =3D 10,
>                 .target_residency =3D 500,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C3",
>                 .desc =3D "MWAIT 0x10",
> @@ -547,7 +547,7 @@ static struct cpuidle_state ivt_cstates_8s[] __initda=
ta =3D {
>                 .exit_latency =3D 59,
>                 .target_residency =3D 600,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -555,7 +555,7 @@ static struct cpuidle_state ivt_cstates_8s[] __initda=
ta =3D {
>                 .exit_latency =3D 88,
>                 .target_residency =3D 700,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -568,7 +568,7 @@ static struct cpuidle_state hsw_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 2,
>                 .target_residency =3D 2,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -576,7 +576,7 @@ static struct cpuidle_state hsw_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 10,
>                 .target_residency =3D 20,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C3",
>                 .desc =3D "MWAIT 0x10",
> @@ -584,7 +584,7 @@ static struct cpuidle_state hsw_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 33,
>                 .target_residency =3D 100,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -592,7 +592,7 @@ static struct cpuidle_state hsw_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 133,
>                 .target_residency =3D 400,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C7s",
>                 .desc =3D "MWAIT 0x32",
> @@ -600,7 +600,7 @@ static struct cpuidle_state hsw_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 166,
>                 .target_residency =3D 500,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C8",
>                 .desc =3D "MWAIT 0x40",
> @@ -608,7 +608,7 @@ static struct cpuidle_state hsw_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 300,
>                 .target_residency =3D 900,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C9",
>                 .desc =3D "MWAIT 0x50",
> @@ -616,7 +616,7 @@ static struct cpuidle_state hsw_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 600,
>                 .target_residency =3D 1800,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C10",
>                 .desc =3D "MWAIT 0x60",
> @@ -624,7 +624,7 @@ static struct cpuidle_state hsw_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 2600,
>                 .target_residency =3D 7700,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -636,7 +636,7 @@ static struct cpuidle_state bdw_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 2,
>                 .target_residency =3D 2,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -644,7 +644,7 @@ static struct cpuidle_state bdw_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 10,
>                 .target_residency =3D 20,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C3",
>                 .desc =3D "MWAIT 0x10",
> @@ -652,7 +652,7 @@ static struct cpuidle_state bdw_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 40,
>                 .target_residency =3D 100,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -660,7 +660,7 @@ static struct cpuidle_state bdw_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 133,
>                 .target_residency =3D 400,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C7s",
>                 .desc =3D "MWAIT 0x32",
> @@ -668,7 +668,7 @@ static struct cpuidle_state bdw_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 166,
>                 .target_residency =3D 500,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C8",
>                 .desc =3D "MWAIT 0x40",
> @@ -676,7 +676,7 @@ static struct cpuidle_state bdw_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 300,
>                 .target_residency =3D 900,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C9",
>                 .desc =3D "MWAIT 0x50",
> @@ -684,7 +684,7 @@ static struct cpuidle_state bdw_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 600,
>                 .target_residency =3D 1800,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C10",
>                 .desc =3D "MWAIT 0x60",
> @@ -692,7 +692,7 @@ static struct cpuidle_state bdw_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 2600,
>                 .target_residency =3D 7700,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -705,7 +705,7 @@ static struct cpuidle_state skl_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 2,
>                 .target_residency =3D 2,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -713,7 +713,7 @@ static struct cpuidle_state skl_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 10,
>                 .target_residency =3D 20,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C3",
>                 .desc =3D "MWAIT 0x10",
> @@ -721,7 +721,7 @@ static struct cpuidle_state skl_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 70,
>                 .target_residency =3D 100,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -729,7 +729,7 @@ static struct cpuidle_state skl_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 85,
>                 .target_residency =3D 200,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C7s",
>                 .desc =3D "MWAIT 0x33",
> @@ -737,7 +737,7 @@ static struct cpuidle_state skl_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 124,
>                 .target_residency =3D 800,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C8",
>                 .desc =3D "MWAIT 0x40",
> @@ -745,7 +745,7 @@ static struct cpuidle_state skl_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 200,
>                 .target_residency =3D 800,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C9",
>                 .desc =3D "MWAIT 0x50",
> @@ -753,7 +753,7 @@ static struct cpuidle_state skl_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 480,
>                 .target_residency =3D 5000,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C10",
>                 .desc =3D "MWAIT 0x60",
> @@ -761,7 +761,7 @@ static struct cpuidle_state skl_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 890,
>                 .target_residency =3D 5000,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -774,7 +774,7 @@ static struct cpuidle_state skx_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 2,
>                 .target_residency =3D 2,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -782,7 +782,7 @@ static struct cpuidle_state skx_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 10,
>                 .target_residency =3D 20,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -790,7 +790,7 @@ static struct cpuidle_state skx_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 133,
>                 .target_residency =3D 600,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -803,7 +803,7 @@ static struct cpuidle_state icx_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 1,
>                 .target_residency =3D 1,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -811,7 +811,7 @@ static struct cpuidle_state icx_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 4,
>                 .target_residency =3D 4,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -819,7 +819,7 @@ static struct cpuidle_state icx_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 170,
>                 .target_residency =3D 600,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -842,7 +842,7 @@ static struct cpuidle_state adl_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 1,
>                 .target_residency =3D 1,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -850,7 +850,7 @@ static struct cpuidle_state adl_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 2,
>                 .target_residency =3D 4,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -858,7 +858,7 @@ static struct cpuidle_state adl_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 220,
>                 .target_residency =3D 600,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C8",
>                 .desc =3D "MWAIT 0x40",
> @@ -866,7 +866,7 @@ static struct cpuidle_state adl_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 280,
>                 .target_residency =3D 800,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C10",
>                 .desc =3D "MWAIT 0x60",
> @@ -874,7 +874,7 @@ static struct cpuidle_state adl_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 680,
>                 .target_residency =3D 2000,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -887,7 +887,7 @@ static struct cpuidle_state adl_l_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 1,
>                 .target_residency =3D 1,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -895,7 +895,7 @@ static struct cpuidle_state adl_l_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 2,
>                 .target_residency =3D 4,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -903,7 +903,7 @@ static struct cpuidle_state adl_l_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 170,
>                 .target_residency =3D 500,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C8",
>                 .desc =3D "MWAIT 0x40",
> @@ -911,7 +911,7 @@ static struct cpuidle_state adl_l_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 200,
>                 .target_residency =3D 600,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C10",
>                 .desc =3D "MWAIT 0x60",
> @@ -919,7 +919,7 @@ static struct cpuidle_state adl_l_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 230,
>                 .target_residency =3D 700,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -932,7 +932,7 @@ static struct cpuidle_state mtl_l_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 1,
>                 .target_residency =3D 1,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -940,7 +940,7 @@ static struct cpuidle_state mtl_l_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 140,
>                 .target_residency =3D 420,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C10",
>                 .desc =3D "MWAIT 0x60",
> @@ -948,7 +948,7 @@ static struct cpuidle_state mtl_l_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 310,
>                 .target_residency =3D 930,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -961,7 +961,7 @@ static struct cpuidle_state gmt_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 1,
>                 .target_residency =3D 1,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -969,7 +969,7 @@ static struct cpuidle_state gmt_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 2,
>                 .target_residency =3D 4,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -977,7 +977,7 @@ static struct cpuidle_state gmt_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 195,
>                 .target_residency =3D 585,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C8",
>                 .desc =3D "MWAIT 0x40",
> @@ -985,7 +985,7 @@ static struct cpuidle_state gmt_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 260,
>                 .target_residency =3D 1040,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C10",
>                 .desc =3D "MWAIT 0x60",
> @@ -993,7 +993,7 @@ static struct cpuidle_state gmt_cstates[] __initdata =
=3D {
>                 .exit_latency =3D 660,
>                 .target_residency =3D 1980,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -1006,7 +1006,7 @@ static struct cpuidle_state spr_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 1,
>                 .target_residency =3D 1,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -1014,7 +1014,7 @@ static struct cpuidle_state spr_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 2,
>                 .target_residency =3D 4,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -1023,7 +1023,7 @@ static struct cpuidle_state spr_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 290,
>                 .target_residency =3D 800,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -1036,7 +1036,7 @@ static struct cpuidle_state gnr_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 1,
>                 .target_residency =3D 1,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -1044,7 +1044,7 @@ static struct cpuidle_state gnr_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 4,
>                 .target_residency =3D 4,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -1054,7 +1054,7 @@ static struct cpuidle_state gnr_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 170,
>                 .target_residency =3D 650,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6P",
>                 .desc =3D "MWAIT 0x21",
> @@ -1064,7 +1064,7 @@ static struct cpuidle_state gnr_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 210,
>                 .target_residency =3D 1000,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -1077,7 +1077,7 @@ static struct cpuidle_state gnrd_cstates[] __initda=
ta =3D {
>                 .exit_latency =3D 1,
>                 .target_residency =3D 1,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -1085,7 +1085,7 @@ static struct cpuidle_state gnrd_cstates[] __initda=
ta =3D {
>                 .exit_latency =3D 4,
>                 .target_residency =3D 4,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -1095,7 +1095,7 @@ static struct cpuidle_state gnrd_cstates[] __initda=
ta =3D {
>                 .exit_latency =3D 220,
>                 .target_residency =3D 650,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6P",
>                 .desc =3D "MWAIT 0x21",
> @@ -1105,7 +1105,7 @@ static struct cpuidle_state gnrd_cstates[] __initda=
ta =3D {
>                 .exit_latency =3D 240,
>                 .target_residency =3D 750,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -1118,7 +1118,7 @@ static struct cpuidle_state atom_cstates[] __initda=
ta =3D {
>                 .exit_latency =3D 10,
>                 .target_residency =3D 20,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C2",
>                 .desc =3D "MWAIT 0x10",
> @@ -1126,7 +1126,7 @@ static struct cpuidle_state atom_cstates[] __initda=
ta =3D {
>                 .exit_latency =3D 20,
>                 .target_residency =3D 80,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C4",
>                 .desc =3D "MWAIT 0x30",
> @@ -1134,7 +1134,7 @@ static struct cpuidle_state atom_cstates[] __initda=
ta =3D {
>                 .exit_latency =3D 100,
>                 .target_residency =3D 400,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x52",
> @@ -1142,7 +1142,7 @@ static struct cpuidle_state atom_cstates[] __initda=
ta =3D {
>                 .exit_latency =3D 140,
>                 .target_residency =3D 560,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -1154,7 +1154,7 @@ static struct cpuidle_state tangier_cstates[] __ini=
tdata =3D {
>                 .exit_latency =3D 1,
>                 .target_residency =3D 4,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C4",
>                 .desc =3D "MWAIT 0x30",
> @@ -1162,7 +1162,7 @@ static struct cpuidle_state tangier_cstates[] __ini=
tdata =3D {
>                 .exit_latency =3D 100,
>                 .target_residency =3D 400,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x52",
> @@ -1170,7 +1170,7 @@ static struct cpuidle_state tangier_cstates[] __ini=
tdata =3D {
>                 .exit_latency =3D 140,
>                 .target_residency =3D 560,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C7",
>                 .desc =3D "MWAIT 0x60",
> @@ -1178,7 +1178,7 @@ static struct cpuidle_state tangier_cstates[] __ini=
tdata =3D {
>                 .exit_latency =3D 1200,
>                 .target_residency =3D 4000,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C9",
>                 .desc =3D "MWAIT 0x64",
> @@ -1186,7 +1186,7 @@ static struct cpuidle_state tangier_cstates[] __ini=
tdata =3D {
>                 .exit_latency =3D 10000,
>                 .target_residency =3D 20000,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -1198,7 +1198,7 @@ static struct cpuidle_state avn_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 2,
>                 .target_residency =3D 2,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x51",
> @@ -1206,7 +1206,7 @@ static struct cpuidle_state avn_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 15,
>                 .target_residency =3D 45,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -1239,7 +1239,7 @@ static struct cpuidle_state bxt_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 2,
>                 .target_residency =3D 2,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -1247,7 +1247,7 @@ static struct cpuidle_state bxt_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 10,
>                 .target_residency =3D 20,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -1255,7 +1255,7 @@ static struct cpuidle_state bxt_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 133,
>                 .target_residency =3D 133,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C7s",
>                 .desc =3D "MWAIT 0x31",
> @@ -1263,7 +1263,7 @@ static struct cpuidle_state bxt_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 155,
>                 .target_residency =3D 155,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C8",
>                 .desc =3D "MWAIT 0x40",
> @@ -1271,7 +1271,7 @@ static struct cpuidle_state bxt_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 1000,
>                 .target_residency =3D 1000,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C9",
>                 .desc =3D "MWAIT 0x50",
> @@ -1279,7 +1279,7 @@ static struct cpuidle_state bxt_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 2000,
>                 .target_residency =3D 2000,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C10",
>                 .desc =3D "MWAIT 0x60",
> @@ -1287,7 +1287,7 @@ static struct cpuidle_state bxt_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 10000,
>                 .target_residency =3D 10000,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -1300,7 +1300,7 @@ static struct cpuidle_state dnv_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 2,
>                 .target_residency =3D 2,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -1308,7 +1308,7 @@ static struct cpuidle_state dnv_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 10,
>                 .target_residency =3D 20,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -1316,7 +1316,7 @@ static struct cpuidle_state dnv_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 50,
>                 .target_residency =3D 500,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -1333,7 +1333,7 @@ static struct cpuidle_state snr_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 2,
>                 .target_residency =3D 2,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -1341,7 +1341,7 @@ static struct cpuidle_state snr_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 15,
>                 .target_residency =3D 25,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6",
>                 .desc =3D "MWAIT 0x20",
> @@ -1349,7 +1349,7 @@ static struct cpuidle_state snr_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 130,
>                 .target_residency =3D 500,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -1362,7 +1362,7 @@ static struct cpuidle_state grr_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 1,
>                 .target_residency =3D 1,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -1370,7 +1370,7 @@ static struct cpuidle_state grr_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 2,
>                 .target_residency =3D 10,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6S",
>                 .desc =3D "MWAIT 0x22",
> @@ -1378,7 +1378,7 @@ static struct cpuidle_state grr_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 140,
>                 .target_residency =3D 500,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -1391,7 +1391,7 @@ static struct cpuidle_state srf_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 1,
>                 .target_residency =3D 1,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C1E",
>                 .desc =3D "MWAIT 0x01",
> @@ -1399,7 +1399,7 @@ static struct cpuidle_state srf_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 2,
>                 .target_residency =3D 10,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6S",
>                 .desc =3D "MWAIT 0x22",
> @@ -1408,7 +1408,7 @@ static struct cpuidle_state srf_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 270,
>                 .target_residency =3D 700,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .name =3D "C6SP",
>                 .desc =3D "MWAIT 0x23",
> @@ -1417,7 +1417,7 @@ static struct cpuidle_state srf_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 310,
>                 .target_residency =3D 900,
>                 .enter =3D &intel_idle,
> -               .enter_s2idle =3D intel_idle_s2idle, },
> +       },
>         {
>                 .enter =3D NULL }
>  };
> @@ -2143,10 +2143,15 @@ static void __init intel_idle_init_cstates_icpu(s=
truct cpuidle_driver *drv)
>                 if (intel_idle_max_cstate_reached(cstate))
>                         break;
>
> -               if (!cpuidle_state_table[cstate].enter &&
> -                   !cpuidle_state_table[cstate].enter_s2idle)
> +               if (!cpuidle_state_table[cstate].enter)
>                         break;
>
> +               if (!cpuidle_state_table[cstate].enter_dead)
> +                       cpuidle_state_table[cstate].enter_dead =3D intel_=
idle_enter_dead;
> +
> +               if (!cpuidle_state_table[cstate].enter_s2idle)
> +                       cpuidle_state_table[cstate].enter_s2idle =3D inte=
l_idle_s2idle;
> +
>                 /* If marked as unusable, skip this state. */
>                 if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_UNUS=
ABLE) {
>                         pr_debug("state %s is disabled\n",

You can do the same thing with :enter() I think?  And it doesn't need
to be in one go.

