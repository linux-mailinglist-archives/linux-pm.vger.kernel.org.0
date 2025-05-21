Return-Path: <linux-pm+bounces-27469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864E6ABFDE8
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 22:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76389E6547
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 20:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC32295D95;
	Wed, 21 May 2025 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI1nlRSN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942D92957A9;
	Wed, 21 May 2025 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859348; cv=none; b=il0tA/eZJB46Jmmy96ufOGrd7Sb7Um15K+8+zV/FRu98zN7YXsuggv4f0YkoK3/SudammiOifbYw98CeW1ogZi+FAZi1zuebGQxXaPjmy0T8immaM1D1cHBA/LHz4I9C0aY8FTrLhGDKdlIXr2JTGyfSvDDLZHVnzVy5aaFmdwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859348; c=relaxed/simple;
	bh=iu+hCyFeCKJW17PT9Xd5uMSXx8mgEQQ6H1fesLWdJas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YY0gsgzls9P2CevQy237fiuRwlCGcKZcP8kNalwsKrajoottg7wmo0U9UrXbcw3YvLgEBQpGbiPmaNR5cpb7JCNJjv80VZV6D/8++ztEKV8SZdzE+824lCT5OhPLiwRq54fY7X7nM3VsvddgP66KmReq24MB6Wguc98WALtJ2Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI1nlRSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E565C4AF0B;
	Wed, 21 May 2025 20:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747859348;
	bh=iu+hCyFeCKJW17PT9Xd5uMSXx8mgEQQ6H1fesLWdJas=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GI1nlRSN6dCZSm5FhnpgTjP6O4k8W0sSYjPoLJvXHTy0bC+RpSuUZZJtaG5ic7OEe
	 PEkVVWkUf/N1nyOTq/Wp9dPn2VT0v/Si+yD5KF9+7rw5zf4TCdRUaNs0xyU7XAfsTq
	 VTstCkH7m8hCTEl/C6VDaTsE6Bys5vi89JHSTE93EJT0rDKqoopZ605/wspZUmmQ+o
	 2gOSq7D5cjJZvNNIsnSwrI7ZOF0CvXSQBRhCC7//1TxO3E8BoVdBxZBZgeDj5Ei+0L
	 u2YZifY2pgBNARB5g+XgNQQdNltq/MXBaTlZdBAnAvTtAZdrGRvZVPR5DbY7VsLKKm
	 BF025/XghFutA==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-605f7d3215cso3845866eaf.0;
        Wed, 21 May 2025 13:29:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCQv6A8b/rOF10NXG8OkZ5A//m+2SWBkzIZ940MR5kxmn+djDRn6qjBWX9UT8mr0gsg92MUQss3xsqxGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDt0nhotJD486ZD0Pwym4lDq/K/0IE95Yozl8nbbRbYdfQg9qH
	QPdI98QxS1qM0l5om3rDPMeLGvSsYLtcI0YXtz0x0MuMh8p9qYuj7i8qpQx5k6y1HkZSPJw0NgD
	3G7ADjN5kNO2RQjvnblh7SyzTqlLx4C8=
X-Google-Smtp-Source: AGHT+IG47wmNc5V54Hgi72WMzCPM4pBQy/jJdSIvXoZiZIGQjPa5Fej9+y0GVx8U82lwWrRjyxri/mEfUeBBORZwQK8=
X-Received: by 2002:a05:6820:290c:b0:60a:9c7:e8e6 with SMTP id
 006d021491bc7-60a09c7eab4mr8513105eaf.4.1747859347442; Wed, 21 May 2025
 13:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519070938.931396-1-yubowen8@huawei.com> <20250519100416.fjixyqgbgk44pgps@vireshk-i7>
In-Reply-To: <20250519100416.fjixyqgbgk44pgps@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 May 2025 22:28:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i8tF8iGHfgX84ro7kFiYOq5kVSyfEoj_KE1mf=CN5SPw@mail.gmail.com>
X-Gm-Features: AX0GCFuEirXZbmumz-pS6DkTsaMyqseAR4OLi_bvgDb12LFIiINhRplZgjteEBo
Message-ID: <CAJZ5v0i8tF8iGHfgX84ro7kFiYOq5kVSyfEoj_KE1mf=CN5SPw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Update sscanf() to kstrtouint()
To: Viresh Kumar <viresh.kumar@linaro.org>, Bowen Yu <yubowen8@huawei.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxarm@huawei.com, zhanjie9@hisilicon.com, jonathan.cameron@huawei.com, 
	lihuisong@huawei.com, zhenglifeng1@huawei.com, cenxinghai@h-partners.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 12:04=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 19-05-25, 15:09, Bowen Yu wrote:
> > In store_scaling_setspeed(), sscanf is still used to read to sysfs.
> > Newer kstrtox provide more features including overflow protection,
> > better errorhandling and allows for other systems of numeration. It
> > is therefore better to update sscanf() to kstrtouint().
> >
> > Signed-off-by: Bowen Yu <yubowen8@huawei.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index be727da0be4d..0c842edd1a76 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -920,9 +920,9 @@ static ssize_t store_scaling_setspeed(struct cpufre=
q_policy *policy,
> >       if (!policy->governor || !policy->governor->store_setspeed)
> >               return -EINVAL;
> >
> > -     ret =3D sscanf(buf, "%u", &freq);
> > -     if (ret !=3D 1)
> > -             return -EINVAL;
> > +     ret =3D kstrtouint(buf, 0, &freq);
> > +     if (ret)
> > +             return ret;
> >
> >       policy->governor->store_setspeed(policy, freq);
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.16 material, thanks!

