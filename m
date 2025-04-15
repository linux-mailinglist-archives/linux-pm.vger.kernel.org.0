Return-Path: <linux-pm+bounces-25471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 390A7A89F1C
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 15:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A346D19020FB
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 13:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5772129A3C2;
	Tue, 15 Apr 2025 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k958yCx9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2982989A9;
	Tue, 15 Apr 2025 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744722754; cv=none; b=ls2SMS4AZ5FRvH3KZMppTPbVngDbjlvubfjsa32/yC0oWVgVLua6yKl871siyPu0SD8aYCRHPoWTXoyz8MrT+U1l/tWZsEAxy65cwTUgCL5pYXZLoaWlhSHCp9iYwCbzJyN12K1Z7ZDGSkKokRThr3z1mij5zBwLGYKiXghPHBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744722754; c=relaxed/simple;
	bh=NvOGweny3//9PpU6g+4X9hkULpzaTPAuQjLSl6LDn5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvzbt/4PMIzjcIPzhfDL8I9acb8Pa5G/9pC/4A9BIDa7ylbhaezef2SQYyrfM2fikPeB0V08orSjnzQQucqIu77xXQkasc703e96b8j0N5jpZ5Z+RehVtIrHbZxaNy264Duv9dfh3F7m3PCDMqqML9Wpp0Er6povp0ZX8OlQ12E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k958yCx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C1DC4AF09;
	Tue, 15 Apr 2025 13:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744722753;
	bh=NvOGweny3//9PpU6g+4X9hkULpzaTPAuQjLSl6LDn5A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k958yCx9+v4kckx+SPonwhjsq1VKNVbGDW+tScgS2FgQouS3NJzLirzUNCltrBREA
	 LVmAUxTl4FPx0Bh3XuL+z7P+9lOR577/LmjB8C/qdVXL2PCfl+6oVbUl8CWi8HaYtd
	 iE6VidSp28AHtkqIn1t+BzXxE7PaWhUuQbfyWsF9jPTBASsgPqsa/ZnP56bZxUQGyu
	 AgpTG+rRAOXkyL0NH9E+WMF3NlMIbX27qpLx+7WtjnhGE3h69EpsgHetBe5J1hkufI
	 h37ty6ipxig0gmdDN0UUDyCpHyb5JR6N6tVFGdeXlUIYdR2iGzAvWwRtjt27iu4mjJ
	 YNgz3vdA9idtg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c769da02b0so3763862fac.3;
        Tue, 15 Apr 2025 06:12:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8Wx3GLYpm+M82l64cktXB3NfYYvMBLB6cfrgvddx2GJ4rCSF0Xd7GNXZxY/eAKLHPkcnfjOTv3Rc=@vger.kernel.org, AJvYcCWQ/FG2PxOOgZsAbeAVTqgVXXGMHXjDxwp+N3mDjful5ghAuij2Rhi/LWEZ+nO3lj+ah0FWwooDIhP6wWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkjLRWJjBN5C5QZ5d9wN9cD41phJwc93I+l1uaxwYi2P4s4K6G
	g7lvA1i+2MJ3XxcQ/0w5BzI+CYewCqcxIbTV13cmzmyawhjrEAcbiKhXNrgUxs+Pxk4RMJkxB94
	JRG9B/jDyHeJRFsr0cBGrv3DIcUA=
X-Google-Smtp-Source: AGHT+IHQz7afKClIl9JufIHbfXY8ywdQ1OxG3dTUq+Tinrq+8ujCnjZuoRlAVf6U7oolhBUM7P3nNKRRbGwANWnXCgI=
X-Received: by 2002:a05:6870:289b:b0:2bc:66cc:1507 with SMTP id
 586e51a60fabf-2d0d5cf7285mr9975832fac.12.1744722752838; Tue, 15 Apr 2025
 06:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4651448.LvFx2qVVIh@rjwysocki.net> <1928789.tdWV9SEqCh@rjwysocki.net>
 <Z_5aQdqYJCFkcHLi@mail-itl>
In-Reply-To: <Z_5aQdqYJCFkcHLi@mail-itl>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Apr 2025 15:12:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hoSoa+DpN3jYSgQ1T8aWxcT806hJJOOwY5c8cRs3T1Fw@mail.gmail.com>
X-Gm-Features: ATxdqUHc-dIqFVvUeKybIaMPNzyJQH1Kh_mq1jQvhviOH-6zO6Sh8oW5sWNMXnQ
Message-ID: <CAJZ5v0hoSoa+DpN3jYSgQ1T8aWxcT806hJJOOwY5c8cRs3T1Fw@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] cpufreq: Reference count policy in cpufreq_update_limits()
To: =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= <marmarek@invisiblethingslab.com>
Cc: stable@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 3:08=E2=80=AFPM Marek Marczykowski-G=C3=B3recki
<marmarek@invisiblethingslab.com> wrote:
>
> On Fri, Mar 28, 2025 at 09:39:08PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Since acpi_processor_notify() can be called before registering a cpufre=
q
> > driver or even in cases when a cpufreq driver is not registered at all,
> > cpufreq_update_limits() needs to check if a cpufreq driver is present
> > and prevent it from being unregistered.
> >
> > For this purpose, make it call cpufreq_cpu_get() to obtain a cpufreq
> > policy pointer for the given CPU and reference count the corresponding
> > policy object, if present.
> >
> > Fixes: 5a25e3f7cc53 ("cpufreq: intel_pstate: Driver-specific handling o=
f _PPC updates")
> > Closes: https://lore.kernel.org/linux-acpi/Z-ShAR59cTow0KcR@mail-itl
> > Reporetd-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingsl=
ab.com>
> > Cc: All applicable <stable@vger.kernel.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It looks like this patch is missing in stable branches.

It may have not been picked up by the "stable" maintainers yet.

> > ---
> >  drivers/cpufreq/cpufreq.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2781,6 +2781,12 @@
> >   */
> >  void cpufreq_update_limits(unsigned int cpu)
> >  {
> > +     struct cpufreq_policy *policy __free(put_cpufreq_policy);
> > +
> > +     policy =3D cpufreq_cpu_get(cpu);
> > +     if (!policy)
> > +             return;
> > +
> >       if (cpufreq_driver->update_limits)
> >               cpufreq_driver->update_limits(cpu);
> >       else
> >
> >
> >
>
> --
> Best Regards,
> Marek Marczykowski-G=C3=B3recki
> Invisible Things Lab

