Return-Path: <linux-pm+bounces-30120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EA8AF8F2C
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 11:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71FAD7B51EC
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC012DCC17;
	Fri,  4 Jul 2025 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XirrYf0G"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CEB28D840;
	Fri,  4 Jul 2025 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622545; cv=none; b=r9S+M8HMEHMDa0Rhisa67WFQrGAGuaSN/55jAEYit5lHERhE0akMW1mASYgE3R9z3DZvnD1vDWa2EizLQu5v9QDgsvizP1fDfADwgDodcFamWZUXFLKNwzu+dx5B/QkHyfzu3Ha+111KeV/OfgdoqOB1UnP/Uqb+O33KtJHQFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622545; c=relaxed/simple;
	bh=0Ud86XP9bYEP8sLzhOOGO61bEW1HVjXeaRHDIa3CSGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dn5/tbKyfbrQBpZFv9hVl3yQYGwPMX9HTep0ItjUV6KTsOIyPu57Eq3h4dgtU+FZGzjovAIuQFysEWzemO43eKSNvLxOOARFjmzReGkUdWjx2rqdfLpn3oi1y7IOGMbvzRIuOJVHZGgBLR6Yd5wX6JqkjwAb3XBbdwBiU+Bq10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XirrYf0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E833C4CEEE;
	Fri,  4 Jul 2025 09:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751622545;
	bh=0Ud86XP9bYEP8sLzhOOGO61bEW1HVjXeaRHDIa3CSGY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XirrYf0GjePlbRcR4e5kgYVe+qrZwml1Adl2K8NBLzxXu/C1de4Zin8szgl+Y2BRj
	 /RWmJniJH9MAqKTAVtbV+8s8xLYqYlgs2eoIMlMLLt6nWpsMc1smIJvmrQKuoIQGxu
	 EsP4MTY6YsbXdOc3OBzOLe4uLfTTJmA5WSpWcdnkR63juOBhdTpOmdGbwbeJkDrfkR
	 lK7PpY33hQnaZ6wuEnM+jOhGdxK/GIXeFEFfPxj+UVHPoqIXeCmixXkiR6sr6HTFie
	 BL65kw3Sb6LT6U7YkDfSmeGuf/5wI3/rPnuAf51NKiBVmETMCP/jUTFTpTrJeDbsiy
	 UcZtuzEcorcjw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-61396c3f681so49529eaf.3;
        Fri, 04 Jul 2025 02:49:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbjbBgXIXoODmQGeiVM9Gcq11E4u9RnmEi5o+1VFRX9u9/WBOq0tBM0aA8DgeZ7JvZKbzIAGgUt2s=@vger.kernel.org, AJvYcCWMwM0HijLpLL3qbq7zgeI0Xr7EMZD54Nh2CITLLIEsXdfRQ2Yu1H0VhfDnqXX4EV43pK0j65sTGHmnfLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkrs8fJ5Z41Y625WK44T8b0WHMsafv5sxLXaaXEdqQwMrueLOM
	C3wBZO3uHEcw8xBU3k9rXgyFxGt5Au93JK8Yp7sU8h+8xcdCK6nqUjEprC1IhiNKDK4Der1gIii
	ufsq758soJwt63ATPQ278c5LfKXEkhyM=
X-Google-Smtp-Source: AGHT+IHSKYWJVT4Y3YWle481bfVW84W5gzUk/bh3TVw9A/v1XsLO3tSf/KPvBrhlZSIXrYhDTyrVfPi7AKbp7pOOHw8=
X-Received: by 2002:a05:6820:174b:b0:613:7eb8:a4a6 with SMTP id
 006d021491bc7-6138fd5e525mr1548591eaf.2.1751622544551; Fri, 04 Jul 2025
 02:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623133402.3120230-1-zhenglifeng1@huawei.com>
 <20250623133402.3120230-8-zhenglifeng1@huawei.com> <CAJZ5v0hizEYaJw77feqAoHJWYuANvbdxZ6BbogZ52sTU2eKTUA@mail.gmail.com>
 <7c509446-7925-4bcb-97c5-1a6082550d96@huawei.com>
In-Reply-To: <7c509446-7925-4bcb-97c5-1a6082550d96@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 4 Jul 2025 11:48:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h6iN_EQd6kMvYZjQwryF5cPo-EEXDFcJ6MK+k=24dr2Q@mail.gmail.com>
X-Gm-Features: Ac12FXwRFY3IHfo2wyyje1ul5fFlkpToFDdYhI6wzgo76tUDvNADNu-Ibd6MZS0
Message-ID: <CAJZ5v0h6iN_EQd6kMvYZjQwryF5cPo-EEXDFcJ6MK+k=24dr2Q@mail.gmail.com>
Subject: Re: [PATCH 7/7] cpufreq: Exit governor when failed to start old governor
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org, ionela.voinescu@arm.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 11:38=E2=80=AFAM zhenglifeng (A) <zhenglifeng1@huawe=
i.com> wrote:
>
> On 2025/6/23 23:12, Rafael J. Wysocki wrote:
>
> > On Mon, Jun 23, 2025 at 3:34=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huaw=
ei.com> wrote:
> >>
> >> Detect the result of starting old governor in cpufreq_set_policy(). If=
 it
> >> fails, exit the governor and clear policy->governor.
> >>
> >> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> >> ---
> >>  drivers/cpufreq/cpufreq.c | 8 +++++---
> >>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index 7b82ffb50283..2b431845a8a3 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -2715,10 +2715,12 @@ static int cpufreq_set_policy(struct cpufreq_p=
olicy *policy,
> >>         pr_debug("starting governor %s failed\n", policy->governor->na=
me);
> >>         if (old_gov) {
> >>                 policy->governor =3D old_gov;
> >> -               if (cpufreq_init_governor(policy))
> >> +               if (cpufreq_init_governor(policy)) {
> >>                         policy->governor =3D NULL;
> >> -               else
> >> -                       cpufreq_start_governor(policy);
> >> +               } else if (cpufreq_start_governor(policy)) {
> >> +                       cpufreq_exit_governor(policy);
> >
> > This may introduce a governor module reference imbalance AFAICS.
>
> Sorry, I don't really understand this. Could you explain more? Thanks.

It looks like I've confused cpufreq_start_governor() with
cpufreq_init_governor(), sorry for the noise.

