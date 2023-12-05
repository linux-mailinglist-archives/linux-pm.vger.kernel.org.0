Return-Path: <linux-pm+bounces-720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB04805EDE
	for <lists+linux-pm@lfdr.de>; Tue,  5 Dec 2023 20:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829CE1C20F22
	for <lists+linux-pm@lfdr.de>; Tue,  5 Dec 2023 19:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AAD6ABAA;
	Tue,  5 Dec 2023 19:54:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD7FA5;
	Tue,  5 Dec 2023 11:54:49 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1fb155ca04bso581560fac.0;
        Tue, 05 Dec 2023 11:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701806089; x=1702410889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPGxsQoxPpHlL6Ppz0lS+ug6RWxWQAf1JLFDoILOKxk=;
        b=lv+OiBl5zo7w3ILusbHF0+pFabQAoBIz+oIC4vI4lR3hfRiD5QV9fBr1Ka5VYlRnNv
         cQIYZdV59OeMXaUSaZawvGN8qWlTLk3nMpca4XGDj1I3Sgi9jHlTS++76lIc6A4idwcJ
         iWKrCUrCdOFf7Srek8tc8Hsni1b950FcifPKCasDDs2tZZPGPguj4lbgmTjoXApDb1Yh
         q4l/uwguMBUK7dG9ZEDvYaHQZ1ZnjwPPE0xqhHFMVnB5rEl8g4kewPEqGIvZGjlp9T1z
         cOBUmJL5GkEMZ3fhcpgGDzLj9kFaBSAD41jNundsQU6NguUHTN5mzOEVy1XBFLRFRqdg
         EVdA==
X-Gm-Message-State: AOJu0YyuxJS9BJ8oq2r3+bPKmDI373ykWk27iog9SW24mfyoYeOix6tD
	jd+m7GG5oFI4dODi4dd+DCYWEX5pwQPAnSvsFFg=
X-Google-Smtp-Source: AGHT+IEhx6WPaNGbt7d2ljM1iILKgZIiYOO/438XhxCPllpYfT29IloMq+viVAgZzWlXPNQOIxlPEfgR0ONDceOMJoA=
X-Received: by 2002:a05:6870:75cd:b0:1fb:136e:fa93 with SMTP id
 de13-20020a05687075cd00b001fb136efa93mr12559032oab.0.1701806089143; Tue, 05
 Dec 2023 11:54:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201123205.1996790-1-lukasz.luba@arm.com>
In-Reply-To: <20231201123205.1996790-1-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Dec 2023 20:54:38 +0100
Message-ID: <CAJZ5v0gYfvJCQ6Tk2Jh8ZYtaJM=sq3Qb6dq28rjYjMNPfJBT_Q@mail.gmail.com>
Subject: Re: [PATCH] powercap: DTPM: Fix the missing cpufreq_cpu_put() calls
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	daniel.lezcano@linaro.org, rafael@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 1:31=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
> The policy returned by cpufreq_cpu_get() has to be released with
> the help of cpufreq_cpu_put() to balance its kobject reference counter
> properly.
>
> Add the missing calls to cpufreq_cpu_put() in the code.
>
> Fixes: 0aea2e4ec2a2 ("powercap/dtpm_cpu: Reset per_cpu variable in the re=
lease function")
> Fixes: 0e8f68d7f048 ("powercap/drivers/dtpm: Add CPU energy model based s=
upport")
> Cc: <stable@vger.kernel.org> # v5.10+
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/powercap/dtpm_cpu.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 45bb7e2849d7..aac278e162d9 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -152,6 +152,8 @@ static void pd_release(struct dtpm *dtpm)
>         if (policy) {
>                 for_each_cpu(dtpm_cpu->cpu, policy->related_cpus)
>                         per_cpu(dtpm_per_cpu, dtpm_cpu->cpu) =3D NULL;
> +
> +               cpufreq_cpu_put(policy);
>         }
>
>         kfree(dtpm_cpu);
> @@ -204,12 +206,16 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *p=
arent)
>                 return 0;
>
>         pd =3D em_cpu_get(cpu);
> -       if (!pd || em_is_artificial(pd))
> -               return -EINVAL;
> +       if (!pd || em_is_artificial(pd)) {
> +               ret =3D -EINVAL;
> +               goto release_policy;
> +       }
>
>         dtpm_cpu =3D kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
> -       if (!dtpm_cpu)
> -               return -ENOMEM;
> +       if (!dtpm_cpu) {
> +               ret =3D -ENOMEM;
> +               goto release_policy;
> +       }
>
>         dtpm_init(&dtpm_cpu->dtpm, &dtpm_ops);
>         dtpm_cpu->cpu =3D cpu;
> @@ -231,6 +237,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *par=
ent)
>         if (ret)
>                 goto out_dtpm_unregister;
>
> +       cpufreq_cpu_put(policy);
>         return 0;
>
>  out_dtpm_unregister:
> @@ -242,6 +249,8 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *par=
ent)
>                 per_cpu(dtpm_per_cpu, cpu) =3D NULL;
>         kfree(dtpm_cpu);
>
> +release_policy:
> +       cpufreq_cpu_put(policy);
>         return ret;
>  }
>
> --

Applied as 6.7-rc material with the Cc: stable tag fixed.

Thanks!

