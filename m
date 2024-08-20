Return-Path: <linux-pm+bounces-12546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3768A958188
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 10:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8209283A9F
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 08:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D86D18A952;
	Tue, 20 Aug 2024 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DkmFRCPH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB218A95B
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724144303; cv=none; b=Pss4jaHCNgpLWTjqiya3OtDpQO1JVhxAzMZKybG1Up+Cyj7ZOnrG/lJsIlk/XrR58kg1OnThEDHX9B7xR+V8dAQ2ePMNrXK2NytTWV39WiHDcmFy+N4VobebqHnJhRC3CBkwflA78MzAuTeWZsppFTxn7HBEC0rtKgAEuh9EOcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724144303; c=relaxed/simple;
	bh=6Tkdd3Meo0GfjfzZFGqvsGzY6sKlazdEJzewsarTR48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXPTcM4NUUlWIzUM4h1TsqYdqo9omcuquDhWEHvKG68FKw9cY6qeWfaaRtRUBtfULOCm7f4iTvSLy57bWqLRfQgI35Uxzf6XQWxHos4d4wc9/cZh+Tg9wegSdto3ZgVvBgy6206YckUifsq+h8cT04gOdM7SmlQzkoQmHCb97kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DkmFRCPH; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e165ab430e7so171041276.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 01:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724144300; x=1724749100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sQqK35BG9rk0fC+Ql+lqOsPE+09qa68+cU1cYBJ8yM=;
        b=DkmFRCPHLsmVdkoH7tq0TC9lO/8M8j/j5d3r3ONUssbsJv/w6h5+LjhQaoHWcMV0cQ
         Qv2X5DiyQdlLEott4YID5C3gCLo3J5m4HwTgjcEWP2TLajnfBRUFr8u4kCJrFc9rVm3U
         9LtyAnZkGr4iwvYQzwgMx1XeepI9QZKe3XsRDqInNHjgew8Mt2dxinkyAWqaE53myXnj
         mXksu/Ivxz0otyubOsGz41cT3el3cu5OdMPZKcH+1TCPWhXuG+1ka6pJ40ONLQKgF9fZ
         vLLdsEk3GLYmMgF2OS+gQgGzVW1OtCrYvIv52kC8x+aFiiny6dFTI9IBfB9yVoSqKVcO
         201g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724144300; x=1724749100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sQqK35BG9rk0fC+Ql+lqOsPE+09qa68+cU1cYBJ8yM=;
        b=K1JFqWCeV3PFLLX5Rx+eUJ5Sxeft83NFZ4W/8VIiZ0wzfiGtHqIx4hP2cdHQeB6p14
         01Oa1A19MQm33ZMe+H/SJilEtFYPr0nX1IpTCND/HV5W62DA2KFfiKHfHvKvpPO7rFx7
         yl1mz/6tzNtjSqjltl/lirA1uEGELAAP/U5FNgEE+gNoWgK80wglmTvuFEvOI0T0oHIS
         lgdHAFlBeHr+YLHNVDDLmjtFqXJOE5H2FQzyoBvtIPPruoI434CHR38xHLCfVva6mjSF
         LGA9RdcMBEV2R4Rm9zIpRm9We2i7aNnE3CnfrlAOfavNA1nHbpVA0RbuXvBP/IWDV9wt
         t0IA==
X-Forwarded-Encrypted: i=1; AJvYcCVWjlYQoNJQPWaVHKwJOOoIl0mlkUMLCLZI/oUasLwe4nJwskRsInssUeljMKlLTNh5U2JhUZej+ybo6SNp4DVbqZyYLSRZf7U=
X-Gm-Message-State: AOJu0YxC+gWLSdE4y626kyjlDLtIhf2zKFD//pmNnpxy6Z+0f9tPuDwe
	WQggH5y8ZRdNc5vidAlgEkudTU9T2U5bUH9sv+v+WEhzhLYVOF1rnO04OtJzjAIvHGD5zV0vf8j
	8yNJRgAsrLgOkQHvmm70Srke9/ZyCx2qrVaIB26EFB3MWEWZB
X-Google-Smtp-Source: AGHT+IG5+/Ak9xzdfmnxlBpDT2OA99O+vdwecgCE7zdsQMevjk6KXLK9MPRyqnfgtvL2CxSxwLtXI6vlsm1cEDCFaNM=
X-Received: by 2002:a05:6902:240a:b0:e0e:cef6:5265 with SMTP id
 3f1490d57ef6-e1181046903mr14227508276.41.1724144300450; Tue, 20 Aug 2024
 01:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
 <20240527142557.321610-4-ulf.hansson@linaro.org> <CAMuHMdUoZBJewA6nQZLhnbebZuoZo85UCCfwuOv8or_N_e-0qg@mail.gmail.com>
In-Reply-To: <CAMuHMdUoZBJewA6nQZLhnbebZuoZo85UCCfwuOv8or_N_e-0qg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 10:57:43 +0200
Message-ID: <CAPDyKFqcpxUJWL7FoRSXLXVhS5B9PjcTY5ryG8HAY_E1Btgwag@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] pmdomain: core: Use dev_name() instead of
 kobject_get_path() in debugfs
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, 
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Nikunj Kela <nkela@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-rt-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Aug 2024 at 10:55, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> Hi Ulf,
>
> On Mon, May 27, 2024 at 4:27=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> > Using kobject_get_path() means a dynamic memory allocation gets done, w=
hich
> > doesn't work on a PREEMPT_RT based configuration while holding genpd's =
raw
> > spinlock.
> >
> > To fix the problem, let's convert into using the simpler dev_name(). Th=
is
> > means the information about the path doesn't get presented in debugfs, =
but
> > hopefully this shouldn't be an issue.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> > Changes in v2:
> >         - New patch.
>
> Thanks for your patch, which is now commit 9094e53ff5c86ebe ("pmdomain:
> core: Use dev_name() instead of kobject_get_path() in debugfs")
> in pmdomain/next.
>
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -3215,16 +3214,9 @@ static int genpd_summary_one(struct seq_file *s,
> >         }
> >
> >         list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
> > -               kobj_path =3D kobject_get_path(&pm_data->dev->kobj,
> > -                               genpd_is_irq_safe(genpd) ?
> > -                               GFP_ATOMIC : GFP_KERNEL);
> > -               if (kobj_path =3D=3D NULL)
> > -                       continue;
> > -
> > -               seq_printf(s, "\n    %-50s  ", kobj_path);
> > +               seq_printf(s, "\n    %-50s  ", dev_name(pm_data->dev));
>
> While some of the old names didn't even fit in 50 characters, the new
> names need much less space, so perhaps this is a good opportunity to
> decrease the table width?

Sure, it seems reasonable! Do you want to send a patch?

>
> >                 rtpm_status_str(s, pm_data->dev);
> >                 perf_status_str(s, pm_data->dev);
> > -               kfree(kobj_path);
> >         }
> >
> >         seq_puts(s, "\n");

Kind regards
Uffe

