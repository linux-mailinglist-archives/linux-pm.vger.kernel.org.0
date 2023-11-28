Return-Path: <linux-pm+bounces-373-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2267FBC8D
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 15:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C23D1C20BCE
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 14:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB68D5ABAF;
	Tue, 28 Nov 2023 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250CBD53;
	Tue, 28 Nov 2023 06:17:33 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1fa364b147dso354175fac.1;
        Tue, 28 Nov 2023 06:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701181052; x=1701785852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRGoQyo/qsOxZBEdcNrITTBVpKcTeeXC0RVRkpQMWcc=;
        b=DX+GzVg7G4cnUNM6VX53uBl46XooZGjkdqyEFVM6x9GIohl4sWNz9rDwHDpO++MStb
         npOwsQcRk+5rYVIL4oFdV6kRkTSNaKKGxJMLJo93k37K5Li4rvEU2r05pXl8jyxkHXmF
         YZ7oRzO4G1VXaXYrbknZsWtDeAzUlytaeVihNm+EtPXEp1HH9v8kRsl+FNW1rr0F9IXY
         r37Zz1D+PsGtYaHrvVBy2BW65mMdcS7/+U5Iwj1dr7r5+xoNw1HJ/700pLKiqRZQcY7v
         VZ5YONfrcUnOZNYBRSROdJDTNNQqFIBTdnhFvzO4GG/pdifP3rDbFqGZx1S552UOtSq8
         vqZw==
X-Gm-Message-State: AOJu0YzS77xrEHkXWPGZidDFYIqxyJjSXnW0+vX89+eKe2OmuqpEoo20
	XJMynQnmpcJUmZMqVvfAIfUlzV5ZX1fJ9s5Op6Smz+Rw
X-Google-Smtp-Source: AGHT+IHK5jlORTPJ4Yi2JZLbahqxmCAW3UTalor5HpTR9Edfy3RrLMPh0+L9de/6FsZfb1R4r5wSfybebBHvgi/RV+Q=
X-Received: by 2002:a05:6870:d0a:b0:1f9:5346:2121 with SMTP id
 mk10-20020a0568700d0a00b001f953462121mr16981047oab.4.1701181052390; Tue, 28
 Nov 2023 06:17:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127092819.2019744-1-lukasz.luba@arm.com>
In-Reply-To: <20231127092819.2019744-1-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 Nov 2023 15:17:21 +0100
Message-ID: <CAJZ5v0hun3D29w0DMgaSoaGpLNLP4dWN-mYpRHYESdFwP6iRsQ@mail.gmail.com>
Subject: Re: [PATCH] powercap: DTPM: Fix unneeded conversion to micro-Watts
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	daniel.lezcano@linaro.org, rafael@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 10:27=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
> The Power values coming from the Energy Model are already in uW.
> The PowerCap and DTPM framework operate on uW, thus all places should
> just use the values from EM. Fix the code which left and still does
> the unneeded conversion.
>
> Fixes: ae6ccaa65038 (PM: EM: convert power field to micro-Watts precision=
 and align drivers)
> Cc: <stable@vger.kernel.org> # v5.19+
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> Hi Daniel,
>
> I have found an issue due to the uW in the EM. My apologies for that.

No need to apologize, you are making the code better.

> I have check those with the Rockpi dev board with your DTPM module there.
> BTW, if you like to check the DTPM_devfreq there, you can apply that
> patch. It should create EM for your GPU there and setup DTPM GPU:
> https://lore.kernel.org/all/20231127081511.1911706-1-lukasz.luba@arm.com/
>
> Regards,
> Lukasz
>
>
>  drivers/powercap/dtpm_cpu.c     |  6 +-----
>  drivers/powercap/dtpm_devfreq.c | 11 +++--------
>  2 files changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 2ff7717530bf..8a2f18fa3faf 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -24,7 +24,6 @@
>  #include <linux/of.h>
>  #include <linux/pm_qos.h>
>  #include <linux/slab.h>
> -#include <linux/units.h>
>
>  struct dtpm_cpu {
>         struct dtpm dtpm;
> @@ -104,8 +103,7 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
>                 if (pd->table[i].frequency < freq)
>                         continue;
>
> -               return scale_pd_power_uw(pd_mask, pd->table[i].power *
> -                                        MICROWATT_PER_MILLIWATT);
> +               return scale_pd_power_uw(pd_mask, pd->table[i].power);
>         }
>
>         return 0;
> @@ -122,11 +120,9 @@ static int update_pd_power_uw(struct dtpm *dtpm)
>         nr_cpus =3D cpumask_weight(&cpus);
>
>         dtpm->power_min =3D em->table[0].power;
> -       dtpm->power_min *=3D MICROWATT_PER_MILLIWATT;
>         dtpm->power_min *=3D nr_cpus;
>
>         dtpm->power_max =3D em->table[em->nr_perf_states - 1].power;
> -       dtpm->power_max *=3D MICROWATT_PER_MILLIWATT;
>         dtpm->power_max *=3D nr_cpus;
>
>         return 0;
> diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_devf=
req.c
> index 91276761a31d..612c3b59dd5b 100644
> --- a/drivers/powercap/dtpm_devfreq.c
> +++ b/drivers/powercap/dtpm_devfreq.c
> @@ -39,10 +39,8 @@ static int update_pd_power_uw(struct dtpm *dtpm)
>         struct em_perf_domain *pd =3D em_pd_get(dev);
>
>         dtpm->power_min =3D pd->table[0].power;
> -       dtpm->power_min *=3D MICROWATT_PER_MILLIWATT;
>
>         dtpm->power_max =3D pd->table[pd->nr_perf_states - 1].power;
> -       dtpm->power_max *=3D MICROWATT_PER_MILLIWATT;
>
>         return 0;
>  }
> @@ -54,13 +52,10 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 =
power_limit)
>         struct device *dev =3D devfreq->dev.parent;
>         struct em_perf_domain *pd =3D em_pd_get(dev);
>         unsigned long freq;
> -       u64 power;
>         int i;
>
>         for (i =3D 0; i < pd->nr_perf_states; i++) {
> -
> -               power =3D pd->table[i].power * MICROWATT_PER_MILLIWATT;
> -               if (power > power_limit)
> +               if (pd->table[i].power > power_limit)
>                         break;
>         }
>
> @@ -68,7 +63,7 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 po=
wer_limit)
>
>         dev_pm_qos_update_request(&dtpm_devfreq->qos_req, freq);
>
> -       power_limit =3D pd->table[i - 1].power * MICROWATT_PER_MILLIWATT;
> +       power_limit =3D pd->table[i - 1].power;
>
>         return power_limit;
>  }
> @@ -110,7 +105,7 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
>                 if (pd->table[i].frequency < freq)
>                         continue;
>
> -               power =3D pd->table[i].power * MICROWATT_PER_MILLIWATT;
> +               power =3D pd->table[i].power;
>                 power *=3D status.busy_time;
>                 power >>=3D 10;
>
> --

Applied as 6.7-rc material, thanks!

