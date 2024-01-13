Return-Path: <linux-pm+bounces-2178-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB8D82C895
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jan 2024 02:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC871F23313
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jan 2024 01:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F8C10953;
	Sat, 13 Jan 2024 01:15:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5CF10A04
	for <linux-pm@vger.kernel.org>; Sat, 13 Jan 2024 01:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-206689895bfso2178715fac.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2024 17:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705108521; x=1705713321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgZIsoLkYaXWqSOgNY6+h6bW694yMdLa337wBA4DrP4=;
        b=c0JKkkwHAdNRRYanrI52SVCSbnCzyoSWU/m5vrTdfOSFZ61PyykHETCXjcI/if8L3X
         gu/iVmfWE0avvZRwkaXG4U59DyGv3wGY9p5mjn1FC/XAGvHBa6QtbVtk4kgRayr1dG15
         QvOvwbOsSMZscHCTUkjs+AFmExNHG2jGtaxcyEFtXzF4L90962IaVq+J1lZluHFqBICr
         bVVgLI3NJRclgKOpZaS/bxt/cqP4KawiHcQYvifybEzLz4olWr18TrbjueMk9yqbTVTL
         pO5zpqjH7jykKvYgNASQ5z+Y6Lc1m1eqGvtojkjnKKYKzEZAa5hwS7nqmK6+7TGIKYxR
         ONRw==
X-Gm-Message-State: AOJu0Yz4yZ7wz1mKp3ciu1wZ3pLKBam88gs4rBHG9shpRQG0Y7G3ZXqu
	yGwU4JLsimGFFAu/l2jVnoPfKzSlaCOmeCLi3TlQhf8gSDHpf+N7
X-Google-Smtp-Source: AGHT+IEQW4vAjg96PgEXz3CVEepwdL9ZqyQYQPvVQ72ANnkf9ZebwJsGe0mLjBtsFid8PPG+LzvQbfxldCzynbI3JF0=
X-Received: by 2002:a05:6870:2382:b0:204:eff:c620 with SMTP id
 e2-20020a056870238200b002040effc620mr2205380oap.6.1705108521278; Fri, 12 Jan
 2024 17:15:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112124815.970-1-patryk.wlazlyn@linux.intel.com> <20240112124815.970-4-patryk.wlazlyn@linux.intel.com>
In-Reply-To: <20240112124815.970-4-patryk.wlazlyn@linux.intel.com>
From: Len Brown <lenb@kernel.org>
Date: Fri, 12 Jan 2024 19:15:10 -0600
Message-ID: <CAJvTdKnZQoBJfVXJWf-9dFV8=aZmMvna_n_oq=mTk1YCAb8MQw@mail.gmail.com>
Subject: Re: [PATCH 3/4] tools/power turbostat: Don't print invalid ucode revision
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: len.brown@intel.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.

This patch can be found on the latest development turbostat branch, here:

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

thanks!
-Len

On Fri, Jan 12, 2024 at 6:49=E2=80=AFAM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> Earlier we printed "microcode 0x0" if we failed to obtain it via MSR.
>
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index ba10a10c5144..bf733e7d73b5 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -5710,6 +5710,7 @@ void process_cpuid()
>         unsigned int eax, ebx, ecx, edx;
>         unsigned int fms, family, model, stepping, ecx_flags, edx_flags;
>         unsigned long long ucode_patch =3D 0;
> +       bool ucode_patch_valid =3D false;
>
>         eax =3D ebx =3D ecx =3D edx =3D 0;
>
> @@ -5740,6 +5741,8 @@ void process_cpuid()
>         if (!no_msr) {
>                 if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_pa=
tch))
>                         warnx("get_msr(UCODE)");
> +               else
> +                       ucode_patch_valid =3D true;
>         }
>
>         /*
> @@ -5751,9 +5754,12 @@ void process_cpuid()
>         __cpuid(0x80000000, max_extended_level, ebx, ecx, edx);
>
>         if (!quiet) {
> -               fprintf(outf, "CPUID(1): family:model:stepping 0x%x:%x:%x=
 (%d:%d:%d) microcode 0x%x\n",
> -                       family, model, stepping, family, model, stepping,
> -                       (unsigned int)((ucode_patch >> 32) & 0xFFFFFFFF))=
;
> +               fprintf(outf, "CPUID(1): family:model:stepping 0x%x:%x:%x=
 (%d:%d:%d)",
> +                       family, model, stepping, family, model, stepping)=
;
> +               if (ucode_patch_valid)
> +                       fprintf(outf, " microcode 0x%x", (unsigned int)((=
ucode_patch >> 32) & 0xFFFFFFFF));
> +               fputc('\n', outf);
> +
>                 fprintf(outf, "CPUID(0x80000000): max_extended_levels: 0x=
%x\n", max_extended_level);
>                 fprintf(outf, "CPUID(1): %s %s %s %s %s %s %s %s %s %s\n"=
,
>                         ecx_flags & (1 << 0) ? "SSE3" : "-",
> --
> 2.43.0
>
>


--=20
Len Brown, Intel

