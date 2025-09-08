Return-Path: <linux-pm+bounces-34170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 904F7B4991F
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 20:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97BE1B263C1
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 18:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3349831E0E7;
	Mon,  8 Sep 2025 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMqnPm92"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093A531C576;
	Mon,  8 Sep 2025 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357684; cv=none; b=UhCNqcPZsJHAe3fjPdswNBz3Z/SJUHQ2kr7SHUv2RAmURbEGVHm1Ay7nkt+qCl4thqTKJaK5QB8blUJdQnblqxFjpNopk70plvavAzVTR8bFRDV5OwPbIIR0zOg1il2MCTOw6Tc1bQdUau2FB+ADe4VQua+/I/lGgyzLAMOK5xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357684; c=relaxed/simple;
	bh=HC3BwWe2fJzOfGoybqsrEIEg9/rGhJskoegmSxORszM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENHciBiFcD2OphEvzJ4yAWB0do7UJaFmwyBsrVh6XWuOAgzzzaVY8355wmLg7bdhygJZ4o82DLbwzowKldPj2dUuFMmzxgbU4bU7nWqJSbw6P0kleQ2vysfEQdj8pM7PxoTB4GOhUNpzOSFaK9fX0KWb9s+G5txSRyCmlpsrBD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMqnPm92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8796EC4CEFA;
	Mon,  8 Sep 2025 18:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757357683;
	bh=HC3BwWe2fJzOfGoybqsrEIEg9/rGhJskoegmSxORszM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nMqnPm929t4cun8MDWo706UzxnidQaGX+8PE+SOJmuXd0sw9p1OAy3fNeomhXuJ8y
	 FAZXCbNIb9kFvxoKruPUz640gwSvvks0aSz4daKaNz0BFK94jyYUjeyPoXicy2WVa8
	 gcr4rBCkxVp1Loh6kgfNRedrHgRgkISQtqHjxUwuoRkYhYQ1ZnqSgpgKGijCfAlBw1
	 YVelIs/JTyvimSyzrdlvRfEpLfjPJlFfYn/Q0HUDzQpXQdwze3dGT1cjyz+Q4o1cW1
	 hjPDKjoJz2n6khfeBDJgslryCFsARByLkpba5YVbBghJlwhMU/DOsMvHo14IL6VAhQ
	 hEe/x2z22kY3g==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74542b1b2bcso3647286a34.3;
        Mon, 08 Sep 2025 11:54:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0lR1MpDjqL5LXt+dwYuZ7Nkzf9vLakbzOoLU5aYdvvzpNj0ND8TZpJ+Egq9kTOfoUWa4HzVEHpQhkOZM=@vger.kernel.org, AJvYcCX9XllCTRsNoqnWGgUb+WBOzqnw+lwRxDL1jjyLqztqZdYJKGoWzSwlW2b8v0H2Zi6dlEBRAIUlD7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1MWKdq65MrvSFIj6fWtOOwKJARVGtQiaVmfh4NHo+36wncPig
	sV7ON/fvUp7EOn8OytHa0iMMwv0+oHP/844jV0AhfzH+Jc0IP3VSNVBQhjrPkFBV3oeh9jiZi5v
	TTRncIBO0CC52Jt8pf3dTkEV/OizLpQY=
X-Google-Smtp-Source: AGHT+IFI4Bx5Gvm0Ft6vinfpRqYEXas41f/whzbKpcuomonW8MSHnsmc1TuQt3oBeG1Cy67OATMaENJHiGiUwfm7FAs=
X-Received: by 2002:a05:6808:2190:b0:439:adcd:9eb6 with SMTP id
 5614622812f47-43b29859a99mr4229388b6e.0.1757357682859; Mon, 08 Sep 2025
 11:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826183644.220093-1-sohil.mehta@intel.com>
 <CAJZ5v0hw+797-mm3qA6PqQdA7hWyZKhkYobbvF+8MCvg1cHZvQ@mail.gmail.com> <67ffd6b7-55c2-4ee0-9243-44bf8336152d@intel.com>
In-Reply-To: <67ffd6b7-55c2-4ee0-9243-44bf8336152d@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Sep 2025 20:54:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iXrqs2oVx0iYanjyJ6ucXorWi6PXPqW7Kdjnsu-zTGEg@mail.gmail.com>
X-Gm-Features: Ac12FXwY-2evvI3P2YVMrb7jo8op0NgDbdgESRZ7BRnBXWyTJn2_4vQQnQjFOus
Message-ID: <CAJZ5v0iXrqs2oVx0iYanjyJ6ucXorWi6PXPqW7Kdjnsu-zTGEg@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: ondemand: Update the efficient idle check for
 Intel extended Families
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	x86@kernel.org, Tony Luck <tony.luck@intel.com>, Zhao Liu <zhao1.liu@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 11:32=E2=80=AFPM Sohil Mehta <sohil.mehta@intel.com>=
 wrote:
>
> On 9/4/2025 1:02 PM, Rafael J. Wysocki wrote:
>
> >
> > Since you are adding this #ifdef below, why don't you go a bit farther =
and do
> >
> >> +#ifdef CONFIG_X86
> >> +#include <asm/cpu_device_id.h>
> >
> > static bool should_io_be_busy(void)
> > {
> >        /* All Intel Family 6 and later processors have efficient idle. =
*/
> >        return boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL &&
> > boot_cpu_data.x86_vfm >=3D INTEL_PENTIUM_PRO;
> > }
> > #else
> > static inline bool should_io_be_busy(void)
> > {
> >         return false;
> > }
> >> +#endif
> >> +
> >>  #include "cpufreq_ondemand.h"
> >>
>
> I am fine with this approach. Would moving the #define to the header be
> slightly better?

I think so.

> Add to cpufreq_ondemand.h:
>
> #ifdef CONFIG_X86
> #include <asm/cpu_device_id.h>
> bool od_should_io_be_busy(void);
> #else
> static inline bool od_should_io_be_busy(void) { return false; }
> #endif
>
> Then, cpufreq_ondemand.c doesn't need the #ifdefs. It can simply do:
>
> bool od_should_io_be_busy(void)
> {
>         /* For Intel, Family 6 and later have an efficient idle. */
>         return (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL &&
>                 boot_cpu_data.x86_vfm >=3D INTEL_PENTIUM_PRO);
> }

You'd still need to put the above under #ifdef CONFIG_X86 though.

But it may as well go into the header as static inline in the CONFIG_X86 ca=
se.

