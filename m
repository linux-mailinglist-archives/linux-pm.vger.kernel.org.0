Return-Path: <linux-pm+bounces-20437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD919A11141
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 20:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC1D3A1A89
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 19:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE65202C41;
	Tue, 14 Jan 2025 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyKfe5lj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C601CEE92;
	Tue, 14 Jan 2025 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736883537; cv=none; b=S1KKdePRMsEhYLrBCV9mU6+wvPADA9jJSCQX45AqzjssByFHtTgz9jDs4KG4V2kwDkId4oPLCsUy0dX86pFptAW7gNaRB9NlkutoAQ+UryYI4p2Rs8pUzDP2IAyuQ50wc1dbkG1sd5w5VM0dk1xPO+cRTLvcZyAOaBibDaKaRdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736883537; c=relaxed/simple;
	bh=OincceTvqAqEpfIje4dELWgrlyHWDOIWYkXRrsBVy5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEcGrPybh89FmDv5b0aPHFHo8KW5I2CKXuKPNq6nlfjy22bYxT34PgwDOBsBlrBbmvUYojzmY3dPjLnaaEPC/W1ux8qgfsndouM4sSSOUxOyzQs2pvML8Wdy2kdF6BgDNzOVuHi7J1xavPDIdzosunjXOGstJKBHrnKhvxGSvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyKfe5lj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CD5C4CEDD;
	Tue, 14 Jan 2025 19:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736883536;
	bh=OincceTvqAqEpfIje4dELWgrlyHWDOIWYkXRrsBVy5o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CyKfe5ljU9ll4V4DBYvKLID0oqsycgmmiXy9Ghw/HatzxXC6i0V4xCpYw4Ru5Vbgu
	 XXcZs7D3coWrRm5R1wuc6HpWShac3E9l01XiejObkTBb/+9ErGKiaf4X04MQzf65QA
	 OuziKXgf5Dfjdg6r90wxJsuk+msyBDJ9U9QxfZhFq8Yo5mrgmud482s8e3zFXk7ORN
	 GzkOGMQUrBsIyNWWGxvfvEBqhuDTuuzN+pF8Em89CgMj2d1nNY3oYAslRwlJAQBzLm
	 Z+kmJGg6AGj38+Ep1hPJulF0T5UITLgwysoApnLTRKNEgjmSb5XtAR4Kt2eyAE8Q8P
	 tFTw8TB2jq+Bw==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f6b65c89c4so1153155eaf.2;
        Tue, 14 Jan 2025 11:38:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnj+gmQrMvbiA70lAaH3U5aSQBeTSeTDob2Ty6zg/GfAhGBVNhtIWOAQvT38YTC3K9ZIFs2+w53yA=@vger.kernel.org, AJvYcCWhTqvp0Pm8uIujDtmW2gxw2WA16Og7RYgDbw/s161BIjroxxDRyH96rEiz/B6q7lekk+DCgqjR2WnOJ9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YynlLYERAFIJA959HIhP7T3rEJyUOJUp+d0eC4YEjblvGBmFpjn
	q3oqclqL45zllHmrIKqxstUqAMV5mVnv3HBVzf6t3NIsDr6oCAQoTcKYx+11JFc8BJ3IAMuPH5h
	OrQZJZRscC3nDpjXJyjmnsq6Gi5w=
X-Google-Smtp-Source: AGHT+IH2at2WiK9Qz938X6eVc5gH+upks6UVSnjd9BbiVdH2NZZq0Qyq7zmmLPZXgaD6psvziPrHvtJMF84VY9ZLvEA=
X-Received: by 2002:a05:6871:6317:b0:29e:3132:5897 with SMTP id
 586e51a60fabf-2aa0666a876mr15423039fac.5.1736883536148; Tue, 14 Jan 2025
 11:38:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108061942.3264396-1-rui.zhang@intel.com>
In-Reply-To: <20250108061942.3264396-1-rui.zhang@intel.com>
From: Len Brown <lenb@kernel.org>
Date: Tue, 14 Jan 2025 13:38:48 -0600
X-Gmail-Original-Message-ID: <CAJvTdKmVcS5X0Q5omBsEPEzwBiNgkx0RzRmHzpWJvswsqQSCmQ@mail.gmail.com>
X-Gm-Features: AbW1kvakpseX_sbCc2Al2je5Ull6GHqSHrezL4e8WtuqMMumrig1a66bguqlg6U
Message-ID: <CAJvTdKmVcS5X0Q5omBsEPEzwBiNgkx0RzRmHzpWJvswsqQSCmQ@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: Time procfs/sysfs snapshot cost
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks!

BTW. when you start a line with "---" in the e-mail, git-am excludes
text from there on out from the commit patch header.
This is sometimes used to add some context in the e-mail that isn't
intended to go into the log.

In this case, I think your extra comments deserve to live in the log,
so I've tweaked the syntax to include them.

thanks,
-Len

On Wed, Jan 8, 2025 at 12:19=E2=80=AFAM Zhang Rui <rui.zhang@intel.com> wro=
te:
>
> Column "usec" is used to measure time cost, but right now it does not
> include the procfs and sysfs snapshot time, which lowers its value.
>
> --- Background ---
> Column "usec" shows
> 1. the number of microseconds elapsed during counter collection,
>    including thread migration -- if any, for each CPU row.
> 2. total elapsed time to collect the counters on all cpus, for the
>    summary row.
> This can be used to check the time cost of a give column. For example,
> run below commands separately
>    turbostat --show usec sleep 1
>    turbostat --show usec,CoreTmp sleep 1
> and the delta in the usec column will tell the time cost for CoreTmp
> (Thermal MSR read)
>
> --- Problem ---
> Some of the kernel procfs/sysfs accesses are expensive, especially on
> high core count systems. "usec" column cannot tell this because it only
> includes the time cost of the counters.
>
> --- Solution ---
> Leave the per CPU "usec" as it is and modify the summary "usec" to
> include the time cost of the procfs/sysfs snapshot.
>
> With it, the "usec" column can be used to get
> 1. the baseline, e.g.
>         turbostat --show usec sleep 1
> 2. the baseline + some per CPU counter cost, e.g.
>         turbostat --show usec,CoreTmp sleep 1
> 3. the baseline + some per CPU sysfs cost, e.g.
>         turbostat --show usec,C1 sleep 1
> 4. the baseline + /proc/interrupts cost, e.g
>         turbostat --show usec,IRQ sleep 1
>
> Document update is also included.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.8 | 2 +-
>  tools/power/x86/turbostat/turbostat.c | 7 ++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turb=
ostat/turbostat.8
> index a7f7ed01421c..6fad772dacde 100644
> --- a/tools/power/x86/turbostat/turbostat.8
> +++ b/tools/power/x86/turbostat/turbostat.8
> @@ -136,7 +136,7 @@ displays the statistics gathered since it was forked.
>  The system configuration dump (if --quiet is not used) is followed by st=
atistics.  The first row of the statistics labels the content of each colum=
n (below).  The second row of statistics is the system summary line.  The s=
ystem summary line has a '-' in the columns for the Package, Core, and CPU.=
  The contents of the system summary line depends on the type of column.  C=
olumns that count items (eg. IRQ) show the sum across all CPUs in the syste=
m.  Columns that show a percentage show the average across all CPUs in the =
system.  Columns that dump raw MSR values simply show 0 in the summary.  Af=
ter the system summary row, each row describes a specific Package/Core/CPU.=
  Note that if the --cpu parameter is used to limit which specific CPUs are=
 displayed, turbostat will still collect statistics for all CPUs in the sys=
tem and will still show the system summary for all CPUs in the system.
>  .SH COLUMN DESCRIPTIONS
>  .PP
> -\fBusec\fP For each CPU, the number of microseconds elapsed during count=
er collection, including thread migration -- if any.  This counter is disab=
led by default, and is enabled with "--enable usec", or --debug.  On the su=
mmary row, usec refers to the total elapsed time to collect the counters on=
 all cpus.
> +\fBusec\fP For each CPU, the number of microseconds elapsed during count=
er collection, including thread migration -- if any.  This counter is disab=
led by default, and is enabled with "--enable usec", or --debug.  On the su=
mmary row, usec refers to the total elapsed time to snapshot the procfs/sys=
fs and collect the counters on all cpus.
>  .PP
>  \fBTime_Of_Day_Seconds\fP For each CPU, the gettimeofday(2) value (secon=
ds.subsec since Epoch) when the counters ending the measurement interval we=
re collected.  This column is disabled by default, and can be enabled with =
"--enable Time_Of_Day_Seconds" or "--debug".  On the summary row, Time_Of_D=
ay_Seconds refers to the timestamp following collection of counters on the =
last CPU.
>  .PP
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index 58a487c225a7..ff6c5fa95aac 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -365,6 +365,9 @@ unsigned int has_hwp_activity_window;       /* IA32_H=
WP_REQUEST[bits 41:32] */
>  unsigned int has_hwp_epp;      /* IA32_HWP_REQUEST[bits 31:24] */
>  unsigned int has_hwp_pkg;      /* IA32_HWP_REQUEST_PKG */
>  unsigned int first_counter_read =3D 1;
> +
> +static struct timeval procsysfs_tv_begin;
> +
>  int ignore_stdin;
>  bool no_msr;
>  bool no_perf;
> @@ -3580,7 +3583,7 @@ int sum_counters(struct thread_data *t, struct core=
_data *c, struct pkg_data *p)
>
>         /* remember first tv_begin */
>         if (average.threads.tv_begin.tv_sec =3D=3D 0)
> -               average.threads.tv_begin =3D t->tv_begin;
> +               average.threads.tv_begin =3D procsysfs_tv_begin;
>
>         /* remember last tv_end */
>         average.threads.tv_end =3D t->tv_end;
> @@ -5912,6 +5915,8 @@ int snapshot_sys_lpi_us(void)
>   */
>  int snapshot_proc_sysfs_files(void)
>  {
> +       gettimeofday(&procsysfs_tv_begin, (struct timezone *)NULL);
> +
>         if (DO_BIC(BIC_IRQ))
>                 if (snapshot_proc_interrupts())
>                         return 1;
> --
> 2.43.0
>


--=20
Len Brown, Intel Open Source Technology Center

