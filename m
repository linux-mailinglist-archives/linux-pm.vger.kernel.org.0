Return-Path: <linux-pm+bounces-25379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5810DA88723
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 17:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A6D16B340
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 15:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8C523D2B4;
	Mon, 14 Apr 2025 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gw+KfmKn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233D1274679;
	Mon, 14 Apr 2025 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744644485; cv=none; b=B8FhgJf2v1WFQP1LKvvv/gkNYe6i/WpR03CY6DplUbd4EqZgarZoG+E/0NblyRZKv96Mg2dkRCssasamul8w58xffS0OWyl5X2doOBX8jjWslsIie98dV826QqbMviGFuYo4D6nQxT/Q7wAYmLzPmHDUSDsgHSVKd+y3fFCVzQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744644485; c=relaxed/simple;
	bh=i+7Swq1d1sqyQE3C+3Rg9ou0tTAESJm1TsJjqY5qojw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8mKxYC3t8hBzvDKUO2iU1GIoWvj4lAaT+tl0N/SxX3icWfUaDW0nTGj0/ZkDhGpVps+nJ2TAySwRF5tlFXLmmE/0j9TV5wlkZ/kIxygmOVa+IGEesEbEqn64/4d+4Mmk3QS07Nf0264MswDJESBhv9xEhZ+uQbJUk1H9X16md0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gw+KfmKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F257C4CEE2;
	Mon, 14 Apr 2025 15:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744644484;
	bh=i+7Swq1d1sqyQE3C+3Rg9ou0tTAESJm1TsJjqY5qojw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gw+KfmKn3MJBZRwJBTo0mOEuulSPEyQJATe3/qzQBdUjUburu2BW6r16lOoEhx+0g
	 ebrr8EYxxz2syUPUqCrukIeTwZbELdFcE2/bbcor8cSvn0aQcjO9wtEYpc2z1T795/
	 xnevczigdXWglTigXoHQ+vRzoX0dk1iV+jxKAAvowIEiiZ60FAQ4QkjF7PYnwM5SHU
	 QpXbm8xepQUczxn5iOLKq72r+TpdBCUunhdg7wPYZwqxjo4Dj9eSskykUyt/X/bzmO
	 SOPIgVGlUzR70ozHozpI/ZESJE3M08SFiZ41vycO26lARtmah492A03WHXjfu8RCMA
	 jbAcxBvOV2BdA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c6f27599abso1142040fac.2;
        Mon, 14 Apr 2025 08:28:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHMFbKE4XIDzOK1I9z/hJtf9a/XkpQVK86Iyz4dTCud2BndBBcL0wGuLtWmNYrrthWqCnjNpPI334=@vger.kernel.org, AJvYcCVeMM54tkjpgFJMKxKyuUGfb7rB6Nh3mC0TxANKS+0fhockRhJ2Qe/r82PaNHcEJntDbE2Xxq2usn5KG7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKzZpRpjQgPdgLCFkAdJX+aZ/3T5qrMumdhfYM3HlBhetqOTQy
	fA2RWBXrTxyItcv/QNZ+vDeKLQYUi55eZ0Rz5bMjT5YrreChwy1mEQoGqax2yKQpN0e0TMLV4MJ
	Wrlxe2Z6FADeQhfDkSeHd9qK17rs=
X-Google-Smtp-Source: AGHT+IF8nWr8VuHtql09DDRONXFeDtbo/DvXPvg4cN6WHhoF8MoBO5IrvQt0bSgKrUJJDWAqPLARYEKYBm1ZRrxlen8=
X-Received: by 2002:a05:6871:a987:b0:2b8:2f9c:d513 with SMTP id
 586e51a60fabf-2d0d5d0aff6mr6616166fac.19.1744644483977; Mon, 14 Apr 2025
 08:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412103434.5321-1-xry111@xry111.site> <b7b0b3f98f8fad9cc9559e1c4ce832387c520d7a.camel@linux.intel.com>
 <12659608.O9o76ZdvQC@rjwysocki.net> <5dd2e5c6abb39dfafee91247cd8473ec643280ac.camel@linux.intel.com>
In-Reply-To: <5dd2e5c6abb39dfafee91247cd8473ec643280ac.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 14 Apr 2025 17:27:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jboEsEd+AnPNez+0bCiFfv-SdaPupXm0EZCwDCGy+tNw@mail.gmail.com>
X-Gm-Features: ATxdqUFXrbGBhDxE1-_oFmMrgpGG0zND2gxSVkiJwskhBWAJz7IJYqOeMgg69tc
Message-ID: <CAJZ5v0jboEsEd+AnPNez+0bCiFfv-SdaPupXm0EZCwDCGy+tNw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use raw_smp_processor_id() in hwp_get_cpu_scaling()
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Xi Ruoyao <xry111@xry111.site>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 5:26=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2025-04-14 at 17:19 +0200, Rafael J. Wysocki wrote:
> > On Sunday, April 13, 2025 4:44:56 PM CEST srinivas pandruvada wrote:
> > > On Sat, 2025-04-12 at 18:34 +0800, Xi Ruoyao wrote:
> > > > Use raw_smp_processor_id() instead of plain smp_processor_id() in
> > > > hwp_get_cpu_scaling(), otherwise we get some errors on a Lenovo
> > > > Thinkpad
> > > > T14P Gen 2:
> > > >
> > > >     BUG: using smp_processor_id() in preemptible [00000000] code:
> > > > swapper/0/1
> > > >     caller is hwp_get_cpu_scaling+0x7f/0xc0
> > > >
> > > > Fixes: b52aaeeadfac ("cpufreq: intel_pstate: Avoid SMP calls to
> > > > get
> > > > cpu-type")
> > > > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > >
> > > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> >
> > It's still broken after this patch though because the function should
> > use the cpu_data() of the target CPU and not of the CPU running the
> > code.
>
> That is correct. The below patch should work.

OK, I'll add an ACK from you to it then if you don't mind.

> >
> > The patch below should fix it.
> >
> > =3D=3D=3D
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH v1] cpufreq: intel_pstate: Fix hwp_get_cpu_scaling()
> >
> > Commit b52aaeeadfac ("cpufreq: intel_pstate: Avoid SMP calls to get
> > cpu-type") introduced two issues into hwp_get_cpu_scaling().  First,
> > it made that function use the CPU type of the CPU running the code
> > even though the target CPU is passed as the argument to it and
> > second,
> > it used smp_processor_id() for that even though hwp_get_cpu_scaling()
> > runs in preemptible context.
> >
> > Fix both of these problems by simply passing "cpu" to cpu_data().
> >
> > Fixes: b52aaeeadfac ("cpufreq: intel_pstate: Avoid SMP calls to get
> > cpu-type")
> > Link:
> > https://lore.kernel.org/linux-pm/20250412103434.5321-1-xry111@xry111.si=
te/
> > Reported-by: Xi Ruoyao <xry111@xry111.site>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/intel_pstate.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2336,7 +2336,7 @@
> >  static int hwp_get_cpu_scaling(int cpu)
> >  {
> >       if (hybrid_scaling_factor) {
> > -             struct cpuinfo_x86 *c =3D
> > &cpu_data(smp_processor_id());
> > +             struct cpuinfo_x86 *c =3D &cpu_data(cpu);
> >               u8 cpu_type =3D c->topo.intel_type;
> >
> >               /*
> >
> >
> >
> >
>
>

