Return-Path: <linux-pm+bounces-329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5707FB019
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 03:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B33B210E9
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 02:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E85110B;
	Tue, 28 Nov 2023 02:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4041AE
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 18:31:42 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1efb9571b13so3025098fac.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 18:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701138702; x=1701743502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRkOfNXHhXZITG1CgwgLnn/pGxb5q7dOhbTNgbjS55I=;
        b=qfUdNh9x+1WpCP1KPxmunh+snni1wXfYHZhHimU7lvOi1xZl8M9O9QVVKs+u28m+Ls
         EUVz+u2U9RQoXcimpxtdgd9A4F8m/rTXhqLMb3XTeAd2d25JaSuW9sr6BjxcAz5iD2Vy
         bGXFGJl7wKfZ3H8vzRtuX2bZyRhKs3Yffq6335AjC8K91rLaFKKXZC8C3O4KavVi3Ya+
         uho2AF5QXrzeVN+oxHUbQTgFnYc3dcltR44u9GIGl+VwsES8fP8ZOaYJsidXM35TNux8
         1e9gmc8hEyv4gp+tmKb716nn7cG4nUBcjbEl6aJNPUZF3BldPLeuug7r0+f4Vhf+9LN8
         jGPA==
X-Gm-Message-State: AOJu0YxvlKbud4+PJ7wYjnay5Nk9sE2dlK2Ny6TG5ATnLh+w+GpHqMmi
	zBjh9W9EIbWPwqY9HK+sclLkFPAoqj+UgEm6seDo/EKh
X-Google-Smtp-Source: AGHT+IGHVQsaLVeZVHCvTWQe5WB34otdJ4ELxrC0ncuHG/tqNm/yjqzpdt6mS6YxTorfc6WAeYCD987IjP+tCRp9c5k=
X-Received: by 2002:a05:6871:4e97:b0:1f9:fd01:e003 with SMTP id
 uk23-20020a0568714e9700b001f9fd01e003mr13492724oab.22.1701138701796; Mon, 27
 Nov 2023 18:31:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00d201d96670$e15ab9d0$a4102d70$@telus.net>
In-Reply-To: <00d201d96670$e15ab9d0$a4102d70$@telus.net>
From: Len Brown <lenb@kernel.org>
Date: Mon, 27 Nov 2023 21:31:30 -0500
Message-ID: <CAJvTdKmv-6rp=z=emS1VGdWgTmRfhSUrmUPLk8Hj+5=CvH0+nw@mail.gmail.com>
Subject: Re: [PATCH] tools/power/x86/turbostat: Fix added raw MSR output
To: Doug Smythies <dsmythies@telus.net>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

I recall puzzling what to do for the system summary row for a RAW added MSR=
.
In your example 1-package system with a package-scope MSR your patch
does the trick.

But if there are N packages, the summary will ignore all but the last
one, which it prints.

Similarly, if the MSR is core or CPU scope, the system summary ignores
all but the last one, which is prints.

So I concluded that printing nothing, er, zero that is, on the system
summary row for a RAW MSR was the least likely to confuse somebody.

I'm thinking that the first two hunks of your patch for thread and
core don't make sense because of this.
I'm thinking that the last hunk, for package, makes sense, but only on
a single package system?

thanks,
-Len



On Mon, Apr 3, 2023 at 5:11=E2=80=AFPM Doug Smythies <dsmythies@telus.net> =
wrote:
>
>
> When using --Summary mode, added MSRs in raw mode always
> print zeros. Print the actual register contents.
>
> Example, with patch:
>
> note the added column:
> --add msr0x64f,u32,package,raw,REASON
>
> Where:
>
> 0x64F is MSR_CORE_PERF_LIMIT_REASONS
>
> # ./turbostat --quiet --Summary --show Busy%,Bzy_MHz,PkgWatt,PkgTmp,CorWa=
tt --add msr0x64f,u32,package,raw,REASON --interval 10
> Busy%   Bzy_MHz PkgTmp  PkgWatt CorWatt     REASON
> 0.00    4800    35      1.42    0.76    0x00000000
> 0.00    4801    34      1.42    0.76    0x00000000
> 80.08   4531    66      108.17  107.52  0x08000000
> 98.69   4530    66      133.21  132.54  0x08000000
> 99.28   4505    66      128.26  127.60  0x0c000400
> 99.65   4486    68      124.91  124.25  0x0c000400
> 99.63   4483    68      124.90  124.25  0x0c000400
> 79.34   4481    41      99.80   99.13   0x0c000000
> 0.00    4801    41      1.40    0.73    0x0c000000
>
> Where, for the test processor (i5-10600K):
>
> PKG Limit #1: 125.000 Watts, 8.000000 sec
> MSR bit 26 =3D log; bit 10 =3D status
>
> PKG Limit #2: 136.000 Watts, 0.002441 sec
> MSR bit 27 =3D log; bit 11 =3D status
>
> Example, without patch:
>
> # ./turbostat --quiet --Summary --show Busy%,Bzy_MHz,PkgWatt,PkgTmp,CorWa=
tt --add msr0x64f,u32,package,raw,REASON --interval 10
> Busy%   Bzy_MHz PkgTmp  PkgWatt CorWatt     REASON
> 0.01    4800    35      1.43    0.77    0x00000000
> 0.00    4801    35      1.39    0.73    0x00000000
> 83.49   4531    66      112.71  112.06  0x00000000
> 98.69   4530    68      133.35  132.69  0x00000000
> 99.31   4500    67      127.96  127.30  0x00000000
> 99.63   4483    69      124.91  124.25  0x00000000
> 99.61   4481    69      124.90  124.25  0x00000000
> 99.61   4481    71      124.92  124.25  0x00000000
> 59.35   4479    42      75.03   74.37   0x00000000
> 0.00    4800    42      1.39    0.73    0x00000000
> 0.00    4801    42      1.42    0.76    0x00000000
>
> # rdmsr 0x64f
> c000000
>
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
>  tools/power/x86/turbostat/turbostat.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index 8a36ba5df9f9..d8d667934a23 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -1744,8 +1744,9 @@ int sum_counters(struct thread_data *t, struct core=
_data *c, struct pkg_data *p)
>
>         for (i =3D 0, mp =3D sys.tp; mp; i++, mp =3D mp->next) {
>                 if (mp->format =3D=3D FORMAT_RAW)
> -                       continue;
> -               average.threads.counter[i] +=3D t->counter[i];
> +                       average.threads.counter[i] =3D t->counter[i];
> +               else
> +                       average.threads.counter[i] +=3D t->counter[i];
>         }
>
>         /* sum per-core values only for 1st thread in core */
> @@ -1764,8 +1765,9 @@ int sum_counters(struct thread_data *t, struct core=
_data *c, struct pkg_data *p)
>
>         for (i =3D 0, mp =3D sys.cp; mp; i++, mp =3D mp->next) {
>                 if (mp->format =3D=3D FORMAT_RAW)
> -                       continue;
> -               average.cores.counter[i] +=3D c->counter[i];
> +                       average.cores.counter[i] =3D c->counter[i];
> +               else
> +                       average.cores.counter[i] +=3D c->counter[i];
>         }
>
>         /* sum per-pkg values only for 1st core in pkg */
> @@ -1812,8 +1814,9 @@ int sum_counters(struct thread_data *t, struct core=
_data *c, struct pkg_data *p)
>
>         for (i =3D 0, mp =3D sys.pp; mp; i++, mp =3D mp->next) {
>                 if (mp->format =3D=3D FORMAT_RAW)
> -                       continue;
> -               average.packages.counter[i] +=3D p->counter[i];
> +                       average.packages.counter[i] =3D p->counter[i];
> +               else
> +                       average.packages.counter[i] +=3D p->counter[i];
>         }
>         return 0;
>  }
> --
> 2.25.1
>
>


--=20
Len Brown, Intel

