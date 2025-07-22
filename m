Return-Path: <linux-pm+bounces-31273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 272DCB0D729
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 12:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724BF188ABDF
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 10:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6767C2E041D;
	Tue, 22 Jul 2025 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/lJoeji"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE662DEA9B;
	Tue, 22 Jul 2025 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753179341; cv=none; b=Zc9XhIHRNa1Olv0QzzL9fVdwJ7d1TU56GYi5XhpGZxcJZEhmUZBkk3oyFG8q7CPt3ZeDI8L3CSptSHPRruxHzHJw0e52/01oxVSmIusOff5UmDTigLB2cq5MDOzLKCeSgs5uVXo7wtm3kFZJYoQOfEDfcW1YMR4GrRFDNIwqGtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753179341; c=relaxed/simple;
	bh=vgdtWTy+OU03fgHA88AqjQprjEpjM4D4FU/Fd8fBqVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+ngQBMlvRCzZCylOzxeYceipC0LysV/rQxMhKIMai2dKwrKoHR5KW4um4MiXwG1M+Mb+5YvS5XYVJUK8i6UseFnf30FeNnIVNSzhOJefafwKVeWD+jytgFnMhKuubqUzc5jMrDxzE4lLUSy6e9K52NlHZaFeCNtJd/ctjUHPhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/lJoeji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11DDC4CEF5;
	Tue, 22 Jul 2025 10:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753179340;
	bh=vgdtWTy+OU03fgHA88AqjQprjEpjM4D4FU/Fd8fBqVg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k/lJoejiqTfV53iDchuP7eEtK6sMSbeGWTRdeeP1StKgVS8HxBjERAYNVn94lbK8N
	 o2uy0tBXsPHRt3+eF9S68iqvfpCgN7mVtfw8oDlqCHD2qovMPvoKJFzyQKRBG4pVF7
	 /k5C1QIVBa9/KJENZP6oB292LJBK/DAvj3Z/3ilrRG4wUMMsVWMUKRI6q+5AM/l/Cj
	 XLulmy7pBgMAQkAmGNLRZ6f76SfNv1Dz9uz6z5e9y5LD+yMeZCE6gKnR15E+/xlWNh
	 s18AvmEM13rMLRDaGhLfupy1dNmiBdn7EDRre3A2qAgK4OyoxRPheCdpZYn42UGaTH
	 5mr+mg/KjHrdw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-615da180061so1079465eaf.2;
        Tue, 22 Jul 2025 03:15:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvZnTjr2eOceU6pufFVlzPrNzfHKgpNOexSOwFtRlZH68/ngKp2xbE3tCjZxJKSRjsf/hu8QBa+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2K+Rl1zWUc1SpRc2WR0MDCxmf7SE93De24yE6jgZBJGL7sKMU
	gZURx9m/VzAo8E8mIAQ2WEl7KwPpOv0vnazqg6yZvuJ2iPR/AejNe3BApbdAyaZ7mLoJPr0cx4N
	2Lkc9mj3qvo1YHqYZJVXHfT6dfzUwvr4=
X-Google-Smtp-Source: AGHT+IGE0hmdSQyJ9XbmUvGsf/YpiOKrtMvtXj6ut103LgiOuskz5Z24p/bjl/azbW9zxB0Y/CsZ5aj/KSGj8tc4wA8=
X-Received: by 2002:a05:6820:2004:b0:615:b293:1f17 with SMTP id
 006d021491bc7-615b2932180mr13775048eaf.8.1753179339998; Tue, 22 Jul 2025
 03:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722055611.130574-2-pmalani@google.com> <20250722060352.pdwk2nrrth4uph2s@vireshk-i7>
In-Reply-To: <20250722060352.pdwk2nrrth4uph2s@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 Jul 2025 12:15:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iUjOitwHYFqRgQY=h+Z-5of+3myDGDJKC8GcSOOSwYAA@mail.gmail.com>
X-Gm-Features: Ac12FXwzNYiAnpxS80e9nkG6rPTtD3O5MDapn5yoUXSg8yLyJX9rHJ3xM0BK5Iw
Message-ID: <CAJZ5v0iUjOitwHYFqRgQY=h+Z-5of+3myDGDJKC8GcSOOSwYAA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: CPPC: Mark driver with NEED_UPDATE_LIMITS flag
To: Viresh Kumar <viresh.kumar@linaro.org>, Prashant Malani <pmalani@google.com>
Cc: open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Beata Michalska <beata.michalska@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 8:03=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 22-07-25, 05:55, Prashant Malani wrote:
> > AMU counters on certain CPPC-based platforms tend to yield inaccurate
> > delivered performance measurements on systems that are idle/mostly idle=
.
> > This results in an inaccurate frequency being stored by cpufreq in its
> > policy structure when the CPU is brought online. [1]
> >
> > Consequently, if the userspace governor tries to set the frequency to a
> > new value, there is a possibility that it would be the erroneous value
> > stored earlier. In such a scenario, cpufreq would assume that the
> > requested frequency has already been set and return early, resulting in
> > the correct/new frequency request never making it to the hardware.
> >
> > Since the operating frequency is liable to this sort of inconsistency,
> > mark the CPPC driver with CPUFREQ_NEED_UPDATE_LIMITS so that it is alwa=
ys
> > invoked when a target frequency update is requested.
> >
> > [1] https://lore.kernel.org/linux-pm/20250619000925.415528-3-pmalani@go=
ogle.com/
> >
> > Cc: Beata Michalska <beata.michalska@arm.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Prashant Malani <pmalani@google.com>
> > ---
> >  drivers/cpufreq/cppc_cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpuf=
req.c
> > index a1fd0ff22bc5..4a17162a392d 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -910,7 +910,7 @@ static struct freq_attr *cppc_cpufreq_attr[] =3D {
> >  };
> >
> >  static struct cpufreq_driver cppc_cpufreq_driver =3D {
> > -     .flags =3D CPUFREQ_CONST_LOOPS,
> > +     .flags =3D CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
> >       .verify =3D cppc_verify_policy,
> >       .target =3D cppc_cpufreq_set_target,
> >       .get =3D cppc_cpufreq_get_rate,
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.17 material, thanks!

