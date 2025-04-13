Return-Path: <linux-pm+bounces-25335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B41BA87408
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 23:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7579E3B2DA2
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 21:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22517485;
	Sun, 13 Apr 2025 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS8Kw3Bz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2145149C4A;
	Sun, 13 Apr 2025 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744579900; cv=none; b=MKy5nC8Hte0jv1o3Hosk6RdmHfxpOhMPcbXn21xwEf3dTjdzc87agR+UvDC5OFp4cc1vtAWcgwyAiQSwj9265NM9ZxLJG7oEsplh2Z/5rjqo4O1kMMzOo7IeaVAcEzN7d5/P86GEXD4S+nxKGxjhefZmE3jz7OSKKQneAY+9KVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744579900; c=relaxed/simple;
	bh=mgLxoK4EqdoZNRyJ7vtRt92RimlwlQcHoZsoh3I46Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4NG5QtdpI+D4SZD+9m16bjS6RCNEFTkWH3c7QY4LaBHE3VkVWoOt//eflXDb7U6L5y7axEWDDLKb66Oyy2TIRMHZU3QxU5gC2zi4FBzBqq3udgqR1SAVJ5+GJgmXAJodusixvgMunRRP7lsttcywNMwlfo7dh+nDM90KGAiSyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VS8Kw3Bz; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86d39be8c77so221465241.0;
        Sun, 13 Apr 2025 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744579898; x=1745184698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVx7pId+fo+v9AziRU2Xhwn4igyBgC1HT4sAj9Df4U0=;
        b=VS8Kw3BzgdRs8n6PkB66mOjFQcQrE6i+GaXB1ObYlW/vlSIHSWdkuDuEQBWpauCvBd
         HdhjuZ9BRWjB1xrUj65MfmvWHVp4wy6VpB0ackpkJyH+5ZTQbUNNEJxhB9P1Kj+o1fDD
         NaZAWH/+lSwibMwj13vy8/rwbxoVgbyMQuJn2cnvDThxx+f5TKloYl35EiInfodELZ+i
         9OOPTlOWcMKUVzypyjugQdbyJxUjhWkVWc0jjgbi1BGspwnW5EeT3eZFHLhbeu4rQaFu
         9Qwsj9zC/wHJngIE0RHSelqsx/UYTaUGOoujbtfLk9KNhV34vM4J8CaP3xjBC9iYNYGM
         hkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744579898; x=1745184698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVx7pId+fo+v9AziRU2Xhwn4igyBgC1HT4sAj9Df4U0=;
        b=EaQ/dcxm+FpE0/ACvrZ4ZuENXbt10yYTPD3unqc8gAT7lgrmEO2TapDq2+5KSijVZO
         ajJzhKm6b+aDq/0LSBraRpP71RMeKYa8VXV8sQn/dz51J2mOuKteX6OXV/0wnP83O4RA
         ud2ClbP5kMwZtWwrsv+gd4LMvJK0uaSPfYv2zb9rWrqFD/I1F8WkZQj+lPjjII4XRwAe
         juvN9lO5WmHdUU+i7fc3C4cD7ZqueUm0GmKt1wiQv3bzhNxPOJQAY2JIJckclVVcvABr
         2E3dn+aUAcQEENcS5ADLri5K7gvOzJUlMjmfbdYxWnb3KldtJDdzdGebSCJlKISLm2Ih
         GVgw==
X-Forwarded-Encrypted: i=1; AJvYcCX7Z/BsDwinmfajpuVtZJI1Ymld1ZbfG0Up5pceMgNvsXE//EEjv1mVUm5s95OW7j25Oc1fMMD/uso=@vger.kernel.org, AJvYcCXKEeuELHbGxbFM9wB9CHpa/hgMUfgj+1uKqUefnWZDBCGr5QWn11du3kTk4TK3jmQfjpEm/DW8vo9N/aU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3DifFDwim7qBU0gQIkxkkRWTbsWGJQ/a3hD9DT/TMCrn2aYtl
	ZS+NnhJTri2CpHaOlgYYfuUHPtm30njf4PZxFcS0xNLPtJwxkIiWiN8cuSdgjWCQGXi3MqVWIBi
	5ayj7RJATOiWKwupnxTU3FaoILuIxekApCA==
X-Gm-Gg: ASbGnctvT+xG07CP/tubMIi8wmgqrIifi0lQYxKrWPv9ouPiw3VsZhLAXgemLH1Rsox
	KJfM5Bs+AchakwtBPpM2RthaddjKKl4Ec1MKCqatHM1mV8/Z3aFynPdgM1qadlZGDVhzxDcC2Hf
	maDOVvfbBRuw2cZ1QdGp1NCuI=
X-Google-Smtp-Source: AGHT+IFllKurmSafw9kTIxLu4ahAC8hkWzQYIgTlQSqJgaGokd0Bp/EPGcbx+9emTi0vCWUUQt+rhYiuzmyqBQu3x3o=
X-Received: by 2002:a05:6102:511f:b0:4c1:966a:3c4e with SMTP id
 ada2fe7eead31-4c9e50a7c13mr2151657137.9.1744579897520; Sun, 13 Apr 2025
 14:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412160518.1824538-1-chenyuan0y@gmail.com> <86bjt0l6q4.wl-maz@kernel.org>
In-Reply-To: <86bjt0l6q4.wl-maz@kernel.org>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Sun, 13 Apr 2025 16:31:26 -0500
X-Gm-Features: ATxdqUH1BeMQrQPrFwdsiZdU6msIr6wxehKc7O712r23xRkqjsP-yQUpqJTGusA
Message-ID: <CALGdzurneK24t3AF2z5U6CoxrGYMEWUzmPn8-Qp0tToKwQV8RA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: apple-soc: Fix possible null pointer dereference
To: Marc Zyngier <maz@kernel.org>
Cc: sven@svenpeter.dev, j@jannau.net, alyssa@rosenzweig.io, neal@gompa.dev, 
	rafael@kernel.org, viresh.kumar@linaro.org, marcan@marcan.st, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 13, 2025 at 5:02=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Sat, 12 Apr 2025 17:05:18 +0100,
> Chenyuan Yang <chenyuan0y@gmail.com> wrote:
> >
> > Check if policy is NULL before dereferencing it.
> >
> > This is similar to the commit cf7de25878a1
> > ("cppc_cpufreq: Fix possible null pointer dereference").
> >
>
> No, it's not similar. The patch you refer to actually introduces bugs
> by returning -ENODEV in functions that have an unsigned return type.
>
> > This is found by our static analysis tool KNighter.
>
> I'm surprised that your tool hasn't found the above, because it should
> be a pretty easy thing to do.
>
> Irrespective of this, it would be good to describe under which
> circumstances this can occur, because I can't see *how* this can
> trigger. The policy is directly provided by the core code and provide
> its association with a cpu, and is never NULL at the point of init.

Our tool currently identifies bug patterns by analyzing patches. For
example, in the similar function cppc_cpufreq_get_rate(),
a patch was applied to add a null check for the policy. Therefore, we
assume that a similar check should be implemented here

> And if it can trigger, why only fix this one particular case?
> Dereferences of policy are all over the map, and would be just as
> wrong.

It appears that similar checks are implemented in other areas=E2=80=94such =
as
in acpi-cpufreq.c, cppc_cpufreq.c, drivers/cpufreq/cpufreq_ondemand.c,
and drivers/cpufreq/cpufreq.c.
However, I'm not sure if apple_soc should adopt the same checking style.

> >
> > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > Fixes: 6286bbb40576 ("cpufreq: apple-soc: Add new driver to control App=
le SoC CPU P-states")
> > ---
> >  drivers/cpufreq/apple-soc-cpufreq.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/appl=
e-soc-cpufreq.c
> > index 4994c86feb57..3de9bb2b0f22 100644
> > --- a/drivers/cpufreq/apple-soc-cpufreq.c
> > +++ b/drivers/cpufreq/apple-soc-cpufreq.c
> > @@ -135,10 +135,14 @@ static const struct of_device_id apple_soc_cpufre=
q_of_match[] __maybe_unused =3D {
> >  static unsigned int apple_soc_cpufreq_get_rate(unsigned int cpu)
> >  {
> >       struct cpufreq_policy *policy =3D cpufreq_cpu_get_raw(cpu);
> > -     struct apple_cpu_priv *priv =3D policy->driver_data;
> > +     struct apple_cpu_priv *priv;
> >       struct cpufreq_frequency_table *p;
> >       unsigned int pstate;
> >
> > +     if (!policy)
> > +             return 0;
> > +     priv =3D policy->driver_data;
> > +
> >       if (priv->info->cur_pstate_mask) {
> >               u32 reg =3D readl_relaxed(priv->reg_base + APPLE_DVFS_STA=
TUS);
> >
>
> So while this is not wrong, I don't think this serves any real
> purpose.
>
> Thanks,
>
>         M.
>
> --

Thanks so much for your reply and comments!

-Chenyuan

