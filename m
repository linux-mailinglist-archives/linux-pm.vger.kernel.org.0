Return-Path: <linux-pm+bounces-23726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C886A58B8C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 06:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EDD73AAF05
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 05:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5CB1C6F70;
	Mon, 10 Mar 2025 05:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwuDQEje"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDB01BD4E4;
	Mon, 10 Mar 2025 05:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741583337; cv=none; b=on1ZXqDUzCAElounhPJKTLp3qQxXzoPD4D7UjMuqAoGFmZ7a1NPyi4DVBnQ2YZ4fK5f92j3kGPcJqRS0SUm1iOTFMh8Lckl+2UiYzsaqcfhOpDx5UoVz0lTDEzGXgSI1TQTPzarQMUJ5GXny/24/tphmApgup2KioqPiycb33yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741583337; c=relaxed/simple;
	bh=626TycVV3BpUI2CH+NTcstOHpWvHFuXqScOhMeYrbxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzxaLNrderIPsO9pxfz5BA72HcKKCs/zSTz3c6AH9K+cOUCkRpNWBBjn+6PD4ql7BlUXfyXwxP2cewCjQetxN4ADKWb6nNrps25jdDnKG+dS7+ns01kSNEyTpMcOWPYcXmT0Tz/zknH8HausbJGgsXLEkT3VRYmwbp/DGE59+wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwuDQEje; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5498c156f1dso4359731e87.3;
        Sun, 09 Mar 2025 22:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741583333; x=1742188133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiuaRc+FvUTa6VQc150ltZP2w6zS+qt51yDmDvWWO90=;
        b=gwuDQEjeMr5kUUeb8HDIm9DZWzKOYLuaS9Yhybw7uh5A3m1PNE7XJhU9dqAFMzEeIA
         CawEORp6S1n8KDTBe0UeCbz6+pgAesVYCcr7skZmL87uoo9f45ZLcvbS+drgQEmhztKd
         D6SWkBEbLDcC6Pm4gShtaRaKoC/FqKo1og14AGmUdFqVR0sMRuWqoHhJ+yXY8yBqGqC/
         OClIll6lBKtyfLjZu0N0bEFF1SiDAtCUWqu5b/8k1ZTxEe9h3KTLXQVERBqT/Sl43/sj
         yYdjUPHwPZgbMuwzxk0A3OsTVeryokDB96+2Bl6YszpyEsQ65WbJziXKKe3bNrN81YL+
         oXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741583333; x=1742188133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiuaRc+FvUTa6VQc150ltZP2w6zS+qt51yDmDvWWO90=;
        b=XB3ldo3wK9cBa3U1HU/YsGqynILSMd13yyIUGg8RTL18aeumRY/QBAYzjNtZzvP7WP
         u1ogc/D5qVrvX9UUlfz2gW6vfXg8SXIRrb23jrFv9MZn0mQiAH/i1FgyEU+I4hG3suCA
         HMbVhNG3JSRz919AkXnEGfrJJ3oFiIPC+gD6n8KgFOq1nx4FKe1h3M3b3h53XqX8ATJy
         nEHvNWSzUFZ8Mr52eCDXw9Mp32Z3LsnKk4WuXrVG0yE0ercQO/dXz1QL6kMo4DdDvSN6
         PSRTikeM+mySNwTRx5ZMh8oMxgFjd+qxFEfAJDoPhVghjPPi3xFtx4mpOAHDFZg+X/lw
         C+5A==
X-Forwarded-Encrypted: i=1; AJvYcCUKTYAI0zif0vH8OH0vOdXjyVtIosJBB0pDwxFAVq6jk444DzGSRSLYD3GqWzWbBrLiA6N8UOvnYJO3p2s=@vger.kernel.org, AJvYcCUSY+L6UNQAPQryOe+xC4cpc46RTRQ+yjK+3vMef2U0HznftfONHO5loh080bPYl7gUMfJdoHgPsCA=@vger.kernel.org, AJvYcCX8vFCs9XHQraP2p53/VEH6dRxZ3bdrEGiAhhtWBWJMEJ0g5eUApB1nWKwLUCzebM4IIpO59MAbozBUZhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxFp3bAugymZ6sNSFxXvkF7/sjKVmXBZBGNlnSneVld1MOBbUJ
	GuGMlybgc0Zvi3MYR7VIx16e0/ByOAkc44+5fRq0qOhBK5k2kytgC2yggfbQBl/oCMIPutRJHxy
	e8qnhQHwBnTHrPkmiUuvrmZNDIuM=
X-Gm-Gg: ASbGncuv/YTRC3He7yCfMX1JkHicAW3PKLbfyX83G0tm76cahFDJi3CoySZuvEF0O6W
	P1utheI+095bFvNXP4dlbd6YUt2tXcmbhjiDLY587EWhKCJbXP9dFhCm44ff6rxflRk2ixRWyZV
	0H4N4gy0hIpaUm56I1x41r5NOQeQ==
X-Google-Smtp-Source: AGHT+IGRAKwpZcXi8TZgTZaYl3kR823ieCuZRyLnerwdPkqxoRbv1pSf0kPCfErdVeDkAUyWoWjTGoBOJQICAKi6um4=
X-Received: by 2002:a05:6512:1112:b0:546:2fde:d2d9 with SMTP id
 2adb3069b0e04-54990e672cbmr3817902e87.28.1741583333258; Sun, 09 Mar 2025
 22:08:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216160806.391566-1-webgeek1234@gmail.com> <20250310044553.zupmsoi4d3errjvs@vireshk-i7>
In-Reply-To: <20250310044553.zupmsoi4d3errjvs@vireshk-i7>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 10 Mar 2025 00:08:41 -0500
X-Gm-Features: AQ5f1Jpydkg7kBiKMLUlhT2KRAElIeoskeYm2st52SvxcpXbPVCQs2PxD5ub3iY
Message-ID: <CALHNRZ-YpkSmLipQJ6i8XR+R-4ReLp1fd=jx0X1V8vDvuPG-gA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: tegra186: Share policy per cluster
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Aaron Kling <luceoscutum@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 11:45=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 16-02-25, 10:08, Aaron Kling wrote:
> > This functionally brings tegra186 in line with tegra210 and tegra194,
> > sharing a cpufreq policy between all cores in a cluster.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  drivers/cpufreq/tegra186-cpufreq.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra=
186-cpufreq.c
> > index c7761eb99f3cc..c832a1270e688 100644
> > --- a/drivers/cpufreq/tegra186-cpufreq.c
> > +++ b/drivers/cpufreq/tegra186-cpufreq.c
> > @@ -73,11 +73,18 @@ static int tegra186_cpufreq_init(struct cpufreq_pol=
icy *policy)
> >  {
> >       struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_data();
> >       unsigned int cluster =3D data->cpus[policy->cpu].bpmp_cluster_id;
> > +     u32 cpu;
> >
> >       policy->freq_table =3D data->clusters[cluster].table;
> >       policy->cpuinfo.transition_latency =3D 300 * 1000;
> >       policy->driver_data =3D NULL;
> >
> > +     /* set same policy for all cpus in a cluster */
> > +     for (cpu =3D 0; cpu < (sizeof(tegra186_cpus)/sizeof(struct tegra1=
86_cpufreq_cpu)); cpu++) {
>
> Can't you use ARRAY_SIZE here ?

I could, just wasn't aware of that macro. Is that enough to send a v2 over?
>
> > +             if (data->cpus[cpu].bpmp_cluster_id =3D=3D cluster)
> > +                     cpumask_set_cpu(cpu, policy->cpus);
> > +     }
> > +
> >       return 0;
>
> --
> viresh

Sincerely,
Aaron

