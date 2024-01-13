Return-Path: <linux-pm+bounces-2177-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1526582C88B
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jan 2024 02:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9FA1C22656
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jan 2024 01:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7B71EF03;
	Sat, 13 Jan 2024 01:04:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E054B10796
	for <linux-pm@vger.kernel.org>; Sat, 13 Jan 2024 01:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2043e721daaso3929520fac.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2024 17:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705107842; x=1705712642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8wy8REJBZ4o1ti7AeO2Ao1J0OOJ/9k95oiJ04SutSk=;
        b=vLBFtkCKPnc4QAoo04uipfxOdNLhCY7p6kCM+jhtYcvlcUf8gDuj+F4vuZqvvpjmV7
         7kA2nqlgf+mTnzsDQy2bu2eUMo/PkuInZt4jqXWteGL5GjzT1OvTu0jNW9tf4OjBV0ES
         XallRtD6ucwPl0ohpQ9FLS80ikIInapS7g+39QZ5o+z7hjnnkwSOsXprw4Un6V+QDeZP
         9KyelWCigUUX5NO2csyLFKuECnGDRmrMJ+mrwqWDAbbuSKOVWUZ4egK1bviYfPgA1fZV
         9izx1HAv+nsag9Rq/eJKe82ngMoSyPVXyuBFAlUcPL9/dWRjL47tFySoUDsj6nXsXI7U
         VwIg==
X-Gm-Message-State: AOJu0YyvblVWMACGG7Ud4JdlWgyqNX41w66GDMwmm+tJ2ZxVu0VnTD9b
	eOk3th/j1cmWWksD7HXqhDmrON7VyOWKTw/Xvs7/dPTw5Oj3dw==
X-Google-Smtp-Source: AGHT+IG4Qn8KAB4C6waRsuaTiCsuQtxh+1JuaDsW6i2L6JC2b3hOvyMXwYzvEFgjZjIfTrG/7HvM4/LHhFbEa34/qbU=
X-Received: by 2002:a05:6871:72a:b0:203:f7a9:5346 with SMTP id
 f42-20020a056871072a00b00203f7a95346mr2711503oap.67.1705107841919; Fri, 12
 Jan 2024 17:04:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112124815.970-1-patryk.wlazlyn@linux.intel.com> <20240112124815.970-3-patryk.wlazlyn@linux.intel.com>
In-Reply-To: <20240112124815.970-3-patryk.wlazlyn@linux.intel.com>
From: Len Brown <lenb@kernel.org>
Date: Fri, 12 Jan 2024 19:03:51 -0600
Message-ID: <CAJvTdKm0ikfteXDhDD8LHJVawUawywhCWWM8QLJiJyOO+nd3cA@mail.gmail.com>
Subject: Re: [PATCH 2/4] tools/power turbostat: Add --no-perf option
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: len.brown@intel.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good,
but it depends on 1/4, which you are about to change, so I'll wait for
the refresh.

thanks,
-Len

On Fri, Jan 12, 2024 at 6:49=E2=80=AFAM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> Add the --no-perf option to allow users to run turbostat without
> accessing perf.
>
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.8 |  2 ++
>  tools/power/x86/turbostat/turbostat.c | 26 +++++++++++++++++++++++---
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turb=
ostat/turbostat.8
> index 5575c947134d..8d3d9cac27e0 100644
> --- a/tools/power/x86/turbostat/turbostat.8
> +++ b/tools/power/x86/turbostat/turbostat.8
> @@ -69,6 +69,8 @@ The column name "all" can be used to enable all disable=
d-by-default built-in cou
>  .PP
>  +\fB--no-msr\fP Disable all the uses of the MSR driver.
>  +.PP
> ++\fB--no-perf\fP Disable all the uses of the perf API.
> ++.PP
>  \fB--interval seconds\fP overrides the default 5.0 second measurement in=
terval.
>  .PP
>  \fB--num_iterations num\fP number of the measurement iterations.
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index f192d75d5977..ba10a10c5144 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -265,6 +265,7 @@ unsigned int has_hwp_pkg;   /* IA32_HWP_REQUEST_PKG *=
/
>  unsigned int first_counter_read =3D 1;
>  int ignore_stdin;
>  bool no_msr;
> +bool no_perf;
>
>  int get_msr(int cpu, off_t offset, unsigned long long *msr);
>
> @@ -1321,8 +1322,17 @@ static void bic_disable_msr_access(void)
>         bic_enabled &=3D ~bic_msrs;
>  }
>
> +static void bic_disable_perf_access(void)
> +{
> +       const unsigned long bic_perf =3D BIC_IPC;
> +
> +       bic_enabled &=3D ~bic_perf;
> +}
> +
>  static long perf_event_open(struct perf_event_attr *hw_event, pid_t pid,=
 int cpu, int group_fd, unsigned long flags)
>  {
> +       assert(!no_perf);
> +
>         return syscall(__NR_perf_event_open, hw_event, pid, cpu, group_fd=
, flags);
>  }
>
> @@ -1339,8 +1349,9 @@ static int perf_instr_count_open(int cpu_num)
>         /* counter for cpu_num, including user + kernel and all processes=
 */
>         fd =3D perf_event_open(&pea, -1, cpu_num, -1, 0);
>         if (fd =3D=3D -1) {
> -               warnx("capget(CAP_PERFMON) failed, try \"# setcap cap_sys=
_admin=3Dep %s\"", progname);
> -               BIC_NOT_PRESENT(BIC_IPC);
> +               warnx("capget(CAP_PERFMON) failed, try \"# setcap cap_sys=
_admin=3Dep %s\""
> +                     " or use --no-perf", progname);
> +               bic_disable_perf_access();
>         }
>
>         return fd;
> @@ -1406,6 +1417,7 @@ void help(void)
>                 "  -J, --Joules displays energy in Joules instead of Watt=
s\n"
>                 "  -l, --list   list column headers only\n"
>                 "  -M, --no-msr Disable all uses of the MSR driver\n"
> +               "  -P, --no-perf Disable all uses of the perf API\n"
>                 "  -n, --num_iterations num\n"
>                 "               number of the measurement iterations\n"
>                 "  -N, --header_iterations num\n"
> @@ -6676,6 +6688,7 @@ void cmdline(int argc, char **argv)
>                 { "out", required_argument, 0, 'o' },
>                 { "quiet", no_argument, 0, 'q' },
>                 { "no-msr", no_argument, 0, 'M' },
> +               { "no-perf", no_argument, 0, 'P' },
>                 { "show", required_argument, 0, 's' },
>                 { "Summary", no_argument, 0, 'S' },
>                 { "TCC", required_argument, 0, 'T' },
> @@ -6689,11 +6702,14 @@ void cmdline(int argc, char **argv)
>          * Parse some options early, because they may make other options =
invalid,
>          * like adding the MSR counter with --add and at the same time us=
ing --no-msr.
>          */
> -       while ((opt =3D getopt_long_only(argc, argv, "M", long_options, &=
option_index)) !=3D -1) {
> +       while ((opt =3D getopt_long_only(argc, argv, "MP", long_options, =
&option_index)) !=3D -1) {
>                 switch (opt) {
>                 case 'M':
>                         no_msr =3D 1;
>                         break;
> +               case 'P':
> +                       no_perf =3D 1;
> +                       break;
>                 default:
>                         break;
>                 }
> @@ -6759,6 +6775,7 @@ void cmdline(int argc, char **argv)
>                         quiet =3D 1;
>                         break;
>                 case 'M':
> +               case 'P':
>                         /* Parsed earlier */
>                         break;
>                 case 'n':
> @@ -6824,6 +6841,9 @@ int main(int argc, char **argv)
>         if (no_msr)
>                 bic_disable_msr_access();
>
> +       if (no_perf)
> +               bic_disable_perf_access();
> +
>         if (!quiet) {
>                 print_version();
>                 print_bootcmd();
> --
> 2.43.0
>
>


--=20
Len Brown, Intel

