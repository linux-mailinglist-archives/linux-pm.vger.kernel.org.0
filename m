Return-Path: <linux-pm+bounces-17422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652BD9C5B4E
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 16:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B0C282129
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 15:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3B42036F0;
	Tue, 12 Nov 2024 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcBA/9/Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017D2022CF;
	Tue, 12 Nov 2024 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423757; cv=none; b=I/rDtiz4JzirVxG4x6VfHLGDbIXyBsh+bJuHLfq8d57vJIpKRHatuT6IMpYWEhpQ48lEzO44pxlSeyx1GWyXKwlnqnIExmzFgmztUuo55Dic8MvRbCXacv5GcL0ITUqbB3H0G22Iv0k7k60EJhm/YKhPYS4pKy+2TVe/MdXCDg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423757; c=relaxed/simple;
	bh=Lth/cTu415pGV1tveL1POnX0SqNeYIVlgE4dGG9C+Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJQKht+52QZ0zglHeqJspVf/9HvOL2l00j5hoyThz8RoPjFfOSXHZxdzJAC9ehFJdSPL1GvSW8KfC4PzHZGCALcUj5msmgvmxSQTH7twE2bc5ohShfMb3DIHuaZ86xA+D/Ywv56SBmFch21HemTvFFPiW2HuxZjT8niyO7xkvB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcBA/9/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47848C4CED0;
	Tue, 12 Nov 2024 15:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423757;
	bh=Lth/cTu415pGV1tveL1POnX0SqNeYIVlgE4dGG9C+Xk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VcBA/9/ZqfcGz9Ge8aq4Bd/tYrjbF+wn+r6SeUOWV9EDPFzGUbtCfztfOSZ1KMR00
	 9wkPBdseEZiZDwtXKXCgLznBA96dFragazszzIBI+xbRq7HO0l3xw2pzKbgi5oUt1S
	 6g7eLI6N5+R2xgmG6b7b+CxQ/lASya6kzI5HdFf3upwlpbYmCmGNhJegzfR0foD/y3
	 bUOgb45b6iKqd5cbuKd9uEVUX77UnJr2ycVtNYB3kcp8l80ndw2tZ2NbvL7oXBr8vz
	 YL/VGS7gJolG6HWrtck6+xClW6lKZh9zwCa8LaxvfxYZdkHIXyWbWvU7/7iYQ05ww7
	 dIGX84Z5wcQ7A==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-288916b7fceso2870314fac.3;
        Tue, 12 Nov 2024 07:02:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7EdTfsVYgc4rtPFVnZhAhEMFj9Cw7K3k2LrCDx8UEPnkOSwmzoISaSGCAs8SQ1bqRo5bBWTuDugk=@vger.kernel.org, AJvYcCXgPY0fKK3rwX329yIMZmcOFS3S8e5GhXQ5vt9mibo76YZojpqevhpCeYLydsi338XGporjofq9NgACvmc=@vger.kernel.org, AJvYcCXqZCf2h8fUGFNZmaJIAiU35xjXW0VjZFgDTdNMtSUIck3RyRjJfCBzHwi6UX2qRx0gHVzH5MYv@vger.kernel.org
X-Gm-Message-State: AOJu0YyOZbQfvU20iaSm9sr96uRmY69pJmDh/b+JkCl1jxOUF803ZPq3
	lvYbprExBZJRiYZ4wFN1lLBog1l720s5kHN9Ed+08RosMjC8h6FgwnaOx5FUw7C7SSGqtjkp+2g
	hAxgLRvuIZicEexrVgwELGCTuRPA=
X-Google-Smtp-Source: AGHT+IHpU8jj1gpJ3DpcjYHyo31Jfoe6bE1bjo7IXcIK5UkPqz+c4dbdqI8jvCFUwQQTlYVcet9pjMtpHQ29sT1Lf8c=
X-Received: by 2002:a05:6871:3a0e:b0:277:f14c:844b with SMTP id
 586e51a60fabf-2956032f0c4mr14089377fac.37.1731423756617; Tue, 12 Nov 2024
 07:02:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111162316.GH22801@noisy.programming.kicks-ass.net>
 <20241112053722.356303-1-lenb@kernel.org> <351549432f8d766842dec74ccab443077ea0af91.1731389117.git.len.brown@intel.com>
 <CAJZ5v0j1gvwoYS-YaOQWh0bQ3x5=54npiYj8erq68dM92+ad-g@mail.gmail.com>
 <CAJvTdKnRpDQKUVNJ4Gp7r+WaHo0y-Wume3ay7toHU+Xz0gv2Zw@mail.gmail.com>
 <CAJZ5v0g74GWomsfV9ko5pVrwx+x6smU7u7oHV=ZYDLTKYxMWsw@mail.gmail.com> <CAJvTdK=SnRqwjR5fUatP0CzaXD_CpZ-1cc+2yX0D8_XM_3oJUw@mail.gmail.com>
In-Reply-To: <CAJvTdK=SnRqwjR5fUatP0CzaXD_CpZ-1cc+2yX0D8_XM_3oJUw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Nov 2024 16:02:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hm8LenFyQBrORmreGWh+4dWoJeCLRngJOZSq3UVhnNOQ@mail.gmail.com>
Message-ID: <CAJZ5v0hm8LenFyQBrORmreGWh+4dWoJeCLRngJOZSq3UVhnNOQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/cpu: Add INTEL_LUNARLAKE_M to X86_BUG_MONITOR
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, peterz@infradead.org, tglx@linutronix.de, 
	x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 3:02=E2=80=AFPM Len Brown <lenb@kernel.org> wrote:
>
> On Tue, Nov 12, 2024 at 8:14=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Tue, Nov 12, 2024 at 2:12=E2=80=AFPM Len Brown <lenb@kernel.org> wro=
te:
> > >
> > > On Tue, Nov 12, 2024 at 6:44=E2=80=AFAM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> > >
> > > > > -       if (boot_cpu_has(X86_FEATURE_MWAIT) && c->x86_vfm =3D=3D =
INTEL_ATOM_GOLDMONT)
> > > > > +       if (boot_cpu_has(X86_FEATURE_MWAIT) &&
> > > > > +           (c->x86_vfm =3D=3D INTEL_ATOM_GOLDMONT
> > > > > +            || c->x86_vfm =3D=3D INTEL_LUNARLAKE_M))
> > > >
> > > > I would put the || at the end of the previous line, that is
> > >
> > >
> > > It isn't my personal preference for human readability either,
> > > but this is what scripts/Lindent does...
> >
> > Well, it doesn't match the coding style of the first line ...
>
> Fair observation.
>
> I'll bite.
>
> If you took the existing intel.c and added it as a patch to the kernel,
> the resulting checkpatch would have 6 errors and 33 warnings.
>
> If you ran Lindent on the existing intel.c, the resulting diff would be
> 408 lines --  1 file changed, 232 insertions(+), 176 deletions(-)
>
> This for a file that is only 1300 lines long.
>
> If whitespace nirvana is the goal, tools are the answer, not the valuable
> cycles of human reviewers.

Well, the advice always given is to follow the coding style of the
given fine in the first place.

checkpatch reflects the preferences of its author is this particular
respect and maintainers' preferences tend to differ from one to
another.

