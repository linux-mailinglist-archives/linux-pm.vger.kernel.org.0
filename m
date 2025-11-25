Return-Path: <linux-pm+bounces-38647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F41EC86843
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 19:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FD93AA058
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 18:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D7432C333;
	Tue, 25 Nov 2025 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY88vkF0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF8629DB8F
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764094448; cv=none; b=m8Z9ZEz22tzh7ksF4kwGcTwNzmfCmhyu/1KJaCEftoOPguzRx0GotfATaz5w4SACnLjyRKzW3QBsCHkYXCyU2RDhqzCk3fBhXxQ6+DaNzL+SYpB9LzzsdAdwH4zgig3DG2pKEDmtjNzKXuRY+FCGEXOIRCT3kpBHRoBUxGQzRl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764094448; c=relaxed/simple;
	bh=hR+j2pQdqXbj/WtAHhfTF+vI3h8KpLX8dkRm16TU/kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIWQPlASLYi3apHzmShRvkDYc4nci7OKNM3IRk4NSQkJlz8CCtEchUGQrw9DviIU64SRtTo3pX0a323g3AXeUrT2pFGjpkW8j0910hcranfvopAYwTZwO9Lq4zzGfxkWR+Dac16sAAPooRl3WKigC9Be6ozMWjGShsqedr2lgxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KY88vkF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E1BC16AAE
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 18:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764094447;
	bh=hR+j2pQdqXbj/WtAHhfTF+vI3h8KpLX8dkRm16TU/kc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KY88vkF0j2KG+62FGjhZhAQBt+9CaGg9TS0S1sI3++mqNV0T7ww4Eu+rQpWLW/BjN
	 KKeVjOBlIjQ85t+2/9DjIBMltIFx7RCz/nrrsQzPWTPuAEWdd78pJS98sztcGfSodn
	 dn2ZOSCnyGn1S5tFAgQSTfMnfi/+ytosMYGaEuMFZzFiu4QKQR9leSbOmYBrDXQynk
	 eZY+K7n05JwAQybWIZUxIiFF68oTIi1a0VlzhSQj4vFcY0YJBRKQeic6keVFbrNjn4
	 a/dW2sSBGIDvLi+P+4t8h9KvesA2rUjY8UIBHTb7V2fUpdEtWdMtRr8FEZ7GIOEP5s
	 g6SiW7xfp4UCg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3ec31d2b7f8so1579139fac.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 10:14:07 -0800 (PST)
X-Gm-Message-State: AOJu0Yy8IRrPWD573j1FRkG+w+OWc1R00/9JkpV8hKr7LyRkbaAtIkWF
	Uql9pbKBWVvf/yCTRVFjAHDhg1m0fB8VuxpAbyM4M774QAHbUmVwzFPDSojlTNDckus/xNdSF/q
	/Xyg2SwRfJY+BWgSNVEfO2s2OUFsf6Is=
X-Google-Smtp-Source: AGHT+IFHcsWz2rk1/4pNLahTowRjWG8l3ymOFdfrZE120yWXl/Mbj0mkjXA1flZh86chhdEOx5po3DMWf1K34X2x/tE=
X-Received: by 2002:a05:6808:191e:b0:450:44b9:68e0 with SMTP id
 5614622812f47-451158659bcmr6115352b6e.11.1764094446953; Tue, 25 Nov 2025
 10:14:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113191609.28574-1-ehemily@amazon.de> <20251113191609.28574-2-ehemily@amazon.de>
In-Reply-To: <20251113191609.28574-2-ehemily@amazon.de>
From: Len Brown <lenb@kernel.org>
Date: Tue, 25 Nov 2025 13:13:54 -0500
X-Gmail-Original-Message-ID: <CAJvTdK=_v9q2eGMB6qG3iaDhXMzQHz-EJ4NeDEfBe2fbv+wKfQ@mail.gmail.com>
X-Gm-Features: AWmQ_bldYrjUy-jFdzSgOP8LVEE7X2xRdgNQd5flUDg3oEyf3PNWqz_jLvCB0c4
Message-ID: <CAJvTdK=_v9q2eGMB6qG3iaDhXMzQHz-EJ4NeDEfBe2fbv+wKfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/power/turbostat: Fix division by zero when TDP
 calculation fails
To: Emily Ehlert <ehemily@amazon.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Emily Ehlert <ehemily@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Can you share what system configuration went down this error path?

I don't have a good feeling about this remedy.

The reason we get TDP is to estimate if RAPL will overflow its
undersized energy counters during the measurement interval.  We arm a
timer appropriately to accumulate RAPL if it looks like this will be
possible.

It is possible to run into that underlying issue, but it is not common usag=
e.

So my question is if you have a system where RAPL works fine, but we
simply can't get TDP to build this safety net?

If so, it may make more sense to adjust the safety net, say, using
some conservative default timer interval, rather than not report RAPL
at all.

And if we do opt to disable RAPL, I'd rather uniformly use the
existing build-in-counter macros for testing if a counter is actually
present and enabled instead of a new global flag.

thanks,
-Len

On Thu, Nov 13, 2025 at 2:17=E2=80=AFPM Emily Ehlert <ehemily@amazon.de> wr=
ote:
>
> From: Emily Ehlert <ehemily@amazon.com>
>
> turbostat uses hard coded features for CPU families and expects access to
> RAPL (Running Average Power Limit) MSRs. When RAPL or power info is not
> available, turbostat reads PKG_POWER_INFO MSR to calculate TDP with
> RAPL_POWER_UNIT MSR. If TDP calculation results in 0, no zero check is
> performed and the 0 TDP is used in division, resulting in an invalid
> rapl_joule_counter_range. This variable is later used in msr_sum_record()
> as a timer parameter to timer_settime() syscall, causing issues.
>
> Fix the issue by:
>
> - Introduce zero check for tdp in rapl_probe_intel() and rapl_probe_amd()
> - Introduce global variable no_rapl which is set to true if zero check fa=
ils
> - Skip RAPL-dependent functions when no_rapl is true
> - Add assertions and guards to prevent RAPL operations when disabled
>
> Signed-off-by: Emily Ehlert <ehemily@amazon.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index 9a2be201a3a6..9c6ee0acbe12 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -531,6 +531,7 @@ static struct timeval procsysfs_tv_begin;
>  int ignore_stdin;
>  bool no_msr;
>  bool no_perf;
> +bool no_rapl;
>
>  enum gfx_sysfs_idx {
>         GFX_rc6,
> @@ -3119,6 +3120,10 @@ int dump_counters(PER_THREAD_PARAMS)
>
>  double rapl_counter_get_value(const struct rapl_counter *c, enum rapl_un=
it desired_unit, double interval)
>  {
> +       if (no_rapl) {
> +               return NAN;
> +       }
> +
>         assert(desired_unit !=3D RAPL_UNIT_INVALID);
>
>         /*
> @@ -4696,6 +4701,8 @@ static size_t cstate_counter_info_count_perf(const =
struct cstate_counter_info_t
>
>  void write_rapl_counter(struct rapl_counter *rc, struct rapl_counter_inf=
o_t *rci, unsigned int idx)
>  {
> +       assert(!no_rapl);
> +
>         if (rci->source[idx] =3D=3D COUNTER_SOURCE_NONE)
>                 return;
>
> @@ -4706,6 +4713,8 @@ void write_rapl_counter(struct rapl_counter *rc, st=
ruct rapl_counter_info_t *rci
>
>  int get_rapl_counters(int cpu, unsigned int domain, struct core_data *c,=
 struct pkg_data *p)
>  {
> +       assert(!no_rapl);
> +
>         struct platform_counters *pplat_cnt =3D p =3D=3D package_odd ? &p=
latform_counters_odd : &platform_counters_even;
>         unsigned long long perf_data[NUM_RAPL_COUNTERS + 1];
>         struct rapl_counter_info_t *rci;
> @@ -5147,7 +5156,7 @@ int get_counters(PER_THREAD_PARAMS)
>         if (!is_cpu_first_thread_in_core(t, c, p))
>                 goto done;
>
> -       if (platform->has_per_core_rapl) {
> +       if (platform->has_per_core_rapl && !no_rapl) {
>                 status =3D get_rapl_counters(cpu, get_rapl_domain_id(cpu)=
, c, p);
>                 if (status !=3D 0)
>                         return status;
> @@ -5213,7 +5222,7 @@ int get_counters(PER_THREAD_PARAMS)
>         if (DO_BIC(BIC_SYS_LPI))
>                 p->sys_lpi =3D cpuidle_cur_sys_lpi_us;
>
> -       if (!platform->has_per_core_rapl) {
> +       if (!platform->has_per_core_rapl && !no_rapl) {
>                 status =3D get_rapl_counters(cpu, get_rapl_domain_id(cpu)=
, c, p);
>                 if (status !=3D 0)
>                         return status;
> @@ -7650,6 +7659,12 @@ void rapl_probe_intel(void)
>
>         tdp =3D get_tdp_intel();
>
> +       if (tdp =3D=3D 0.0) {
> +               no_rapl =3D true;
> +               fprintf(outf, "RAPL: Could not calculate TDP (TDP: %.0f, =
MSR_RAPL_POWER_UNIT: %llx)\n", tdp, msr);
> +               return;
> +       }
> +
>         rapl_joule_counter_range =3D 0xFFFFFFFF * rapl_energy_units / tdp=
;
>         if (!quiet)
>                 fprintf(outf, "RAPL: %.0f sec. Joule Counter Range, at %.=
0f Watts\n", rapl_joule_counter_range, tdp);
> @@ -7680,6 +7695,12 @@ void rapl_probe_amd(void)
>
>         tdp =3D get_tdp_amd();
>
> +       if (tdp =3D=3D 0.0) {
> +               no_rapl =3D true;
> +               fprintf(outf, "RAPL: Could not calculate TDP (TDP: %.0f, =
MSR_RAPL_POWER_UNIT: %llx)\n", tdp, msr);
> +               return;
> +       }
> +
>         rapl_joule_counter_range =3D 0xFFFFFFFF * rapl_energy_units / tdp=
;
>         if (!quiet)
>                 fprintf(outf, "RAPL: %.0f sec. Joule Counter Range, at %.=
0f Watts\n", rapl_joule_counter_range, tdp);
> @@ -11215,7 +11236,7 @@ int main(int argc, char **argv)
>
>         turbostat_init();
>
> -       if (!no_msr)
> +       if (!no_msr && !no_rapl)
>                 msr_sum_record();
>
>         /* dump counters and exit */
> --
> 2.47.3
>
>
>
>
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597
>


--=20
Len Brown, Intel Open Source Technology Center

