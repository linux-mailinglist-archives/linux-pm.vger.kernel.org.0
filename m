Return-Path: <linux-pm+bounces-33162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD52B37A06
	for <lists+linux-pm@lfdr.de>; Wed, 27 Aug 2025 07:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65B01B62AC8
	for <lists+linux-pm@lfdr.de>; Wed, 27 Aug 2025 05:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD8D30F953;
	Wed, 27 Aug 2025 05:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiJQ/rjj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94AA287273;
	Wed, 27 Aug 2025 05:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756274097; cv=none; b=Ua82v+S+adU8C6+uVFw7biJVlNMxbmxVAOYYkotjldkknlNxswT6cPdkpSk7XLwk7br5BMDGHHdjTuy7qACrKfzNSkc3ghgmNgjZBALcEWay+mq08AA0aPEt2utuFrQFI1T1VmAcQmQAd5KLvEJVHSpMsdBZ51W5VyoEQPz06qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756274097; c=relaxed/simple;
	bh=8eROKf5S0VMq51uDrP4Ccww8z69TnWPueZiuLEnNzMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfQYuojg+oGsbzWYYY6YDp5QIMhTSTrnx+89eJj+xF9TNpB4LxiRuyOFuGNmgNk3YZkpoWvgaOLh4eiN59TaOKMClOYQ61cn4o9DmlIVevoIk7xJL27CqjapIrmnc91BiO5B8dONZdZBrWo2GiO2UTyzmKl/ZF9TCRYCwYZJTNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiJQ/rjj; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f499c7f0cso2408191e87.0;
        Tue, 26 Aug 2025 22:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756274093; x=1756878893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8n1j89CvjN5ZFEbdFGzttMH7tyzPC+isNQLY6VZ0w0=;
        b=NiJQ/rjjB1cOxvwYSOr41aeZa0HgSKuAbKrug4sqFj/qMV/I05+oY1g9rEjfdHr1HR
         VqS1GWx4mC8MLFrqo1naF+p3gwE59vZHfpyEtP3brcwn0cwCnye+V8za5uoWuCxX3h+Y
         KWjzOV96M3vdTeABWrH0d8gKchPgPXu1qyYXoX2AV1Oxnn0iWA693N9+7SAkG3CQX9Ie
         eVu4+KVuDJHLv0WTjn1yr8Sxia6A4xy28sGRDIfjo9rzU4yE1GJkcmtGbFAyeMm/X74z
         AO9m3SjVNz5oXIwLjdNbE3thPFDV30rc7K5rSpUd8oKRycjRRPzcgP0zLRfBRmDOGVwa
         do2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756274093; x=1756878893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8n1j89CvjN5ZFEbdFGzttMH7tyzPC+isNQLY6VZ0w0=;
        b=d8q4Bfs2yq50o1TbcGAuSGwakwG+q29xSN1eAfy14IbOS/etQi0tmU8eZmGu0W+K2u
         XfBqYCgFhzMSI9LLPlFQp9MwuRp577VGwbISRR+34xH31Yeleu5xl96dd1D43cSCKT5q
         X3Y2jfdoOIt5saSYxMxO2ZyTznpXDG+XgAZHHvGFkclqVB7/uuQBOV+ouLPzBk3DjGEo
         V5vJK4jb0TcjyYDpPTa4C1ZDOT6+8d5z6gFDGs+wnCwdPyeypa5sLABSID1m5OWOChgP
         ZQmBBy5xU8chyQkz2gj3fQAQtDgRgmMtepM4t6k+ioO7+mKloUQbzCmY0bucquC1LPIE
         x3xw==
X-Forwarded-Encrypted: i=1; AJvYcCU1giFfrbS3DKefCbAzdh2nKkkA10BUIm9tKQywakjcgNaUqexSyE3Qz8YoZIrKcQ9fd7E54E5jbXB7x/U=@vger.kernel.org, AJvYcCUXXMaqGVCRZrVzI31ochacr2AYpNO9e9kYGIamR0W8WKDqNa3wpDD7WGF6PW0Jwkuq5FPVajhPbdxiuVk=@vger.kernel.org, AJvYcCXj9/VlVLcrK4+hVOwSKnFcZwJmD/TqDk+wYcrO93iIi+1pVoU/8X7uBe/rz7yJ+5LGXw4vnPLvuAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFjPGH5Sjn6LJiBowwc0W8aDMRpMhrvrQz6CKKwXJFXDgbQokj
	bb/BgBD+z1VV1jcqgdVq2O0WUH+Jx3E9AAj+ss0PVpYFj8WfnE6oL09C+xLC6DpwRymofkg0eYZ
	kBULXPunFCf8bUbZbE6znV4X5sup2ubw=
X-Gm-Gg: ASbGncvjo5Jt2gbZQFouHSYz2sU7uJ/jyk2971PA/Ccb1cjNngV0aFebdizpx3OUDwz
	lIhKzz0wDbAP06L2Ljlcrs40hTsD/r9UmlR2pudglpsmykRZR5Kkxaz8fpTvho4/Ve5YzR7pXo4
	VFS9kAeQw2T+kC2/LKp/uudTlclAbBso7QM7tKPKXpBlivTtHVtsKMCUOcAu+eMKYbjZQqUe0kp
	XVZK7Q89mcr1q4AHbbeQ9ugurD9
X-Google-Smtp-Source: AGHT+IHNbW4SO/xBJ0LMEH+gXwKwnl/GVQ4u+pDvk847J5bPbkQbK4PsfsRLx2GNcufPD1Q3bNVfi4pbQWjgy5kT/Vk=
X-Received: by 2002:a05:6512:1451:20b0:55f:3996:4f82 with SMTP id
 2adb3069b0e04-55f399650cfmr2395180e87.1.1756274092506; Tue, 26 Aug 2025
 22:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826-tegra186-cpufreq-fixes-v1-0-97f98d3e0adb@gmail.com>
 <20250826-tegra186-cpufreq-fixes-v1-2-97f98d3e0adb@gmail.com> <24066927.6Emhk5qWAg@senjougahara>
In-Reply-To: <24066927.6Emhk5qWAg@senjougahara>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Wed, 27 Aug 2025 00:54:41 -0500
X-Gm-Features: Ac12FXy6I9yuststMLMbu0a9gFKQlY2gGlFE3HWxValsmuH9e5xd_3-3x7Zc26U
Message-ID: <CALHNRZ8SfAZHm5PszA0uCbr0QUYFSkdayVwEwjgRYX2JT0xhfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: tegra186: Initialize all cores to base frequencies
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Aaron Kling <luceoscutum@gmail.com>, Sumit Gupta <sumitg@nvidia.com>, 
	Thierry Reding <treding@nvidia.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 9:09=E2=80=AFPM Mikko Perttunen <mperttunen@nvidia.=
com> wrote:
>
> On Wednesday, August 27, 2025 5:16=E2=80=AFAM Aaron Kling via B4 Relay wr=
ote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > During initialization, the EDVD_COREx_VOLT_FREQ registers for some core=
s
> > are still at reset values and not reflecting the actual frequency. This
> > causes get calls to fail. Set all cores to their respective base
> > frequency during probe to initialize the registers to working values.
> >
> > Suggested-by: Mikko Perttunen <mperttunen@nvidia.com>
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  drivers/cpufreq/tegra186-cpufreq.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/tegra186-cpufreq.c
> > b/drivers/cpufreq/tegra186-cpufreq.c index
> > 6c394b429b6182faffabf222e5af501393dbbba9..ef288705f00b0918d0f8963ef9cc9=
fc53
> > be88091 100644 --- a/drivers/cpufreq/tegra186-cpufreq.c
> > +++ b/drivers/cpufreq/tegra186-cpufreq.c
> > @@ -229,7 +229,8 @@ static int tegra186_cpufreq_probe(struct platform_d=
evice
> > *pdev) {
> >       struct tegra186_cpufreq_data *data;
> >       struct tegra_bpmp *bpmp;
> > -     unsigned int i =3D 0, err;
> > +     unsigned int i =3D 0, err, edvd_offset;
> > +     u32 edvd_val, cpu;
> >
> >       data =3D devm_kzalloc(&pdev->dev,
> >                           struct_size(data, clusters,
> TEGRA186_NUM_CLUSTERS),
> > @@ -257,6 +258,14 @@ static int tegra186_cpufreq_probe(struct
> > platform_device *pdev) err =3D PTR_ERR(cluster->table);
> >                       goto put_bpmp;
> >               }
> > +
> > +             for (cpu =3D 0; cpu < ARRAY_SIZE(tegra186_cpus); cpu++) {
> > +                     if (data->cpus[cpu].bpmp_cluster_id =3D=3D i) {
> > +                             edvd_val =3D cluster->table[0].driver_dat=
a;
> > +                             edvd_offset =3D data->cpus[cpu].edvd_offs=
et;
> > +                             writel(edvd_val, data->regs +
> edvd_offset);
> > +                     }
> > +             }
> >       }
> >
> >       tegra186_cpufreq_driver.driver_data =3D data;
>
> Looks OK, but I think it might be better to set the frequency to Fmax ins=
tead
> of Fmin to avoid any slowdown during boot.

I considered this, but I'm somewhat skittish about setting Fmax by
default due to seeing instability across different tegra archs and
finding out that the t210 devkits have been factory overclocked on
mainline for the last six years [0]. That may be less of a problem on
t186+ with the bpmp having more tight control over stuff, but... yeah,
I'm still wary. But on the other hand, I set performance governor on
boot for my android builds and have not seen any obvious cpu related
instability on p2771 or p3636+p3509, so that might be okay. If you
still think Fmax is better, I'll update and send a v2.

Aaron

[0] https://lore.kernel.org/all/20250816-tegra210-speedo-v1-0-a981360adc27@=
gmail.com/

