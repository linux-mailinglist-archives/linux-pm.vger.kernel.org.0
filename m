Return-Path: <linux-pm+bounces-36715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6EBC00A25
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 13:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0D854F0D43
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 11:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE77330BF78;
	Thu, 23 Oct 2025 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdKOa3K6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9366C30101A
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217738; cv=none; b=g+rlb+h53FQxLV1RULKpVtZ73Lwb5q56mWiiSNkkV1gpX0gH+kOFacAqQza5PKF45ggFTS6+rRh4dq6esSYiKAZrw2m18WFYw8InVc61cXGLihytOQ4BXeAK1XF15lEtMzVzPmtvamRceMsyXrVwLYdPomo+W7Ci+jde9+U1YNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217738; c=relaxed/simple;
	bh=2gtsPC5so8y6JlR/LE6EcnMO20S4+I796HirmIgdDJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wpywn43gtErVbj+mpcpMAwur7K3AwC1WGG7HDx7hQuSaPCvS6/CQOFOOWxcmdlhE961wh1+i+LKdxjLyZh8ACq6xli8SPZpqzI0aFpXqaTfzAXCRsthn5MDMAdYURjSHqGSUa1qizjkxufggCBqLvmRm//5cpLbmQqNfhoetRZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdKOa3K6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63e0cec110eso1129171a12.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 04:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761217735; x=1761822535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjVTzYMRUK9px4tCar1m0xiZ+9sd2t0ODPLBN+ZVn8M=;
        b=KdKOa3K6waUkW0GYhOosJkCYGIJIZqrvpfFr6jzNI1/PdhZGq5ilbKjK2XZEEZbTHc
         Cc/LT/mrSSVDE682cRd4WLqCuN3akDe5iQqKbwAJ1L2zaeISF70Tk+kPlkj8OJjLpHPi
         UlhAu6JxbrhBkYTybov3h2fQOdwaXCkAZbDekUBS4NZHspB6eY98cdZonqd4hUrjFVdl
         wjjTynqdzvJukc+HOztd5Sa9PKEZtPVqhcdu+T0mGvV7VYwOnEKKdVV/j7686rJWiyAU
         o9EXG0fGjrT8BaeG9GrRFkEToJAi6d3WwHFN5+PgQvJA3aUc/MKzwXHlKlHUk7bvulS/
         8nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761217735; x=1761822535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjVTzYMRUK9px4tCar1m0xiZ+9sd2t0ODPLBN+ZVn8M=;
        b=HHFAEJZ+9x8eAOXC2zX7Ijv1rbXlMzDapllrmURQtp198qkn3WpZ+7HerMfKqgIebC
         BnAFt8/B0Xz6LtplpBKwSFw9DvHroZUzYtnKOsLituOLDBmNzPpG3ECTa4gp3RDUJU8v
         a35df7GDFFE4dml+eylGn7gFessPMz6JA0wFHQOLO6DDKOFQST3z6EotizUQD7bpdaJF
         2sSWt0Fz2W9esTficvw1QzoTR5gkMVetCDma6Hdx68uglC9E42Zs9ouQPDuyC+FingFn
         dwrdf3WerTMxVF++bKdv7OclPoidHCe94rDze4G51Wi1ODFA5NjJCNUfeMOmkNCXbm1X
         ispg==
X-Forwarded-Encrypted: i=1; AJvYcCUWlrZnfezLSBBtkfz44XVKWebB7vE1WKPrB1sVHADLz0aRnYkcBkZoXbOjKfeEcniu4ETLb07W/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/KRFjLvW96cRHyGVShOb8um8EJRsoAyMgSN+214iaQOftbID5
	m9gTuJJwPZ1rg7GAU9aH667HleWNjChGrT6tk0r4r/g3nvGOabsvKgEG3BW1jcOUm3tS2o88Kc3
	0UmhRC9zjGWh+0a2SoS5MZCJ/iasLO5E=
X-Gm-Gg: ASbGncuJtAAupkz2sZUGLn5Q7WLJBA2sUVTkBhXBQJ3qVXFuEo0aEsEKDrhY/i1yt2m
	4e9mNKe9dLn67Cj3J9BlEUm3aX5TWtwHd7Dcwgqb2ZgpvX6nyqd6s6azAVkjVYDSmJaVvx1sy/Z
	bPu7FSYGyPTeBWbEZVA/sDPbblppa6Mwq38Rd+xX7iZ3ZpA6qMPEyaB1kI5+ax2ooh0tvi/XOrs
	ls6WmJJpeZnZqBcktoVLiuf+A73g1ZyVpXg/9iR2YX2o42/AOfDs5maoZ6Bq7AhIP27e+136UhA
	wec82o/bZCE/PBGT9+uGNIcZFeLQNQ==
X-Google-Smtp-Source: AGHT+IHaZkNWJBzwX+xnT6zDyIsd+FpAB6bVyKjHzY4MeJJT61pxMSaC+0svUKX7j1+JJd4Z5fMUP57lUimsGmTU5qA=
X-Received: by 2002:a05:6402:510b:b0:639:dd3f:f25d with SMTP id
 4fb4d7f45d1cf-63c1f631b53mr22704985a12.7.1761217734817; Thu, 23 Oct 2025
 04:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com>
 <68f7b830ec21a_10e910070@dwillia2-mobl4.notmuch> <f9cabfed7b165299b8048670e548c671f300f2b2.camel@gmail.com>
In-Reply-To: <f9cabfed7b165299b8048670e548c671f300f2b2.camel@gmail.com>
From: ally heev <allyheev@gmail.com>
Date: Thu, 23 Oct 2025 16:38:43 +0530
X-Gm-Features: AS18NWALoCjfGGgMJQ1J0KTtA-LIrHjubjnnhPj65_HytxxNdk20M4XgmPj7hPU
Message-ID: <CAMB6jUG+ES6XY7NL5TF-hFVDmz6O5rd9T-HNk7Q+pJA2_9g4Mw@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add uninitialized pointer with __free
 attribute check
To: dan.j.williams@intel.com, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
	David Hunter <david.hunter.linux@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 4:01=E2=80=AFPM ally heev <allyheev@gmail.com> wrot=
e:
> > I would go futher and suggest that the pattern of:
> >
> >       type foo __free(free_foo) =3D NULL;
> >
> > ...be made into a warning because that easily leads to situations where
> > declaration order is out of sync with allocation order. I.e. can be mad=
e
> > technically correct, but at a level of cleverness that undermines the
> > benefit.
>
> But, does this pattern cause any real issue? I found allocating memory
> later useful in cases like below
>
> arch/powerpc/perf/vpa-dtl.c
> ```
>
>         struct vpa_pmu_buf *buf __free(kfree) =3D NULL;
>         struct page **pglist __free(kfree) =3D NULL;
>
>         /* We need at least one page for this to work. */
>         if (!nr_pages)
>                 return NULL;
>
>         if (cpu =3D=3D -1)
>                 cpu =3D raw_smp_processor_id();
>
>         buf =3D kzalloc_node(sizeof(*buf), GFP_KERNEL,
> cpu_to_node(cpu));
> ```
>

I will take this back. Found this in `include/linux/cleanup.h`
```
* Given that the "__free(...) =3D NULL" pattern for variables defined at
* the top of the function poses this potential interdependency problem
* the recommendation is to always define and assign variables in one
* statement and not group variable definitions at the top of the
* function when __free() is used.
```

