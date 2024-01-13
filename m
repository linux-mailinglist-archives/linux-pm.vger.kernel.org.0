Return-Path: <linux-pm+bounces-2176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B3582C887
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jan 2024 02:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AB71F224C7
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jan 2024 01:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3823C1EF03;
	Sat, 13 Jan 2024 01:00:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A091A700
	for <linux-pm@vger.kernel.org>; Sat, 13 Jan 2024 01:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-203ae9903a6so3648649fac.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2024 17:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705107654; x=1705712454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nzn2TyQu5uVlfMxHSy9p076JrQgj+xfHLwbzk9Yf4rg=;
        b=gbTAYPFOFgkfU5oIA/i92OENnrwHSnPU6mryWyebVdEPBxPgamv1U6gXocfLkTtC0b
         G90gDn2+GwaxbEPZjWYnknIAnnMJ7HOJzrmvbWSDPFUs4T/etn80yquLWOOWpGjNckar
         tJB3LZeg2M7VQoTTCvFxA3GOBi9VcBQ5nY7R194Dq/vgp0scHBFWgdykSXPHXWTYLekg
         /+RqV7b+RSfiPvwG0e70ExNdoEyKXQ6YNwBxQg/OmxOMa9ApCzoTyyQaDhe4ixexC05s
         S4OoEkMbwRHR4YRaiAI/Rw8JM9IcHZ5oP7GkuE2JlCoXeAk/w23oXHDAvjrEFXq2j/Ce
         Xk9Q==
X-Gm-Message-State: AOJu0YwGrIDZH5ltLkrsVexVmvkyr+vwl2+9UoO9PS7Zu3MSJwfI4j4T
	rLke5ujzpLKnZEd11U9Y66eOXEThWonUGFo7LEw=
X-Google-Smtp-Source: AGHT+IEF6iWBagOMKd6YGUdPfE+gPzcAsPICuLmtgrGoKaezJvkimj1ofdxdW+e1GpiI7YCgVvqlYa2J9SqbsoF3/Rs=
X-Received: by 2002:a05:6870:1708:b0:206:7844:2b76 with SMTP id
 h8-20020a056870170800b0020678442b76mr2165438oae.119.1705107654176; Fri, 12
 Jan 2024 17:00:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112124815.970-1-patryk.wlazlyn@linux.intel.com> <20240112124815.970-2-patryk.wlazlyn@linux.intel.com>
In-Reply-To: <20240112124815.970-2-patryk.wlazlyn@linux.intel.com>
From: Len Brown <lenb@kernel.org>
Date: Fri, 12 Jan 2024 19:00:43 -0600
Message-ID: <CAJvTdK=NRSGz_1Mi_2-zLmqv4VeFiFF25Yw+sqeNLTV--r4TNg@mail.gmail.com>
Subject: Re: [PATCH 1/4] tools/power turbostat: Add --no-msr option
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: len.brown@intel.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> -       if (platform->has_ext_cst_msrs) {
< +       if (platform->has_ext_cst_msrs && !no_msr) {

6.7 added probe_platform_features().

Perhaps after it runs, we can simply update the result to disable
those impacted by no_msr?

platform->has_cst_msrs =3D 0;
platform->has_nhm_msrs =3D 0;
platform->rapl_msrs =3D 0;
etc.

that would avoid having to scatter no_msr in a lot of places.

of course that begs the question of what to do when a feature is
available both via MSR and via perf -- which is about to happen...

it also adds a place for us to make an error when we add a feature --
but even if we had a table and a bit to say whether the feature is
available via msr, we'd still have the opportunity to mess that up...

On Fri, Jan 12, 2024 at 6:49=E2=80=AFAM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> Add --no-msr option to allow users to run turbostat without
> accessing MSRs via the MSR driver.
>
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.8 |   2 +
>  tools/power/x86/turbostat/turbostat.c | 213 +++++++++++++++++++-------
>  2 files changed, 160 insertions(+), 55 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turb=
ostat/turbostat.8
> index 8f08c3fd498d..5575c947134d 100644
> --- a/tools/power/x86/turbostat/turbostat.8
> +++ b/tools/power/x86/turbostat/turbostat.8
> @@ -67,6 +67,8 @@ The column name "all" can be used to enable all disable=
d-by-default built-in cou
>  .PP
>  \fB--quiet\fP Do not decode and print the system configuration header in=
formation.
>  .PP
> ++\fB--no-msr\fP Disable all the uses of the MSR driver.
> ++.PP
>  \fB--interval seconds\fP overrides the default 5.0 second measurement in=
terval.
>  .PP
>  \fB--num_iterations num\fP number of the measurement iterations.
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index 7a334377f92b..f192d75d5977 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -36,6 +36,7 @@
>  #include <linux/perf_event.h>
>  #include <asm/unistd.h>
>  #include <stdbool.h>
> +#include <assert.h>
>
>  #define UNUSED(x) (void)(x)
>
> @@ -263,6 +264,7 @@ unsigned int has_hwp_epp;   /* IA32_HWP_REQUEST[bits =
31:24] */
>  unsigned int has_hwp_pkg;      /* IA32_HWP_REQUEST_PKG */
>  unsigned int first_counter_read =3D 1;
>  int ignore_stdin;
> +bool no_msr;
>
>  int get_msr(int cpu, off_t offset, unsigned long long *msr);
>
> @@ -1280,13 +1282,45 @@ int get_msr_fd(int cpu)
>         sprintf(pathname, "/dev/cpu/%d/msr", cpu);
>         fd =3D open(pathname, O_RDONLY);
>         if (fd < 0)
> -               err(-1, "%s open failed, try chown or chmod +r /dev/cpu/*=
/msr, or run as root", pathname);
> +               err(-1, "%s open failed, try chown or chmod +r /dev/cpu/*=
/msr, "
> +                        "or run with --no-msr, or run as root", pathname=
);
>
>         fd_percpu[cpu] =3D fd;
>
>         return fd;
>  }
>
> +static void bic_disable_msr_access(void)
> +{
> +       const unsigned long bic_msrs =3D
> +               BIC_Avg_MHz |
> +               BIC_Busy |
> +               BIC_Bzy_MHz |
> +               BIC_IPC |
> +               BIC_SMI |
> +               BIC_CPU_c1 |
> +               BIC_CPU_c3 |
> +               BIC_CPU_c6 |
> +               BIC_CPU_c7 |
> +               BIC_Mod_c6 |
> +               BIC_CoreTmp |
> +               BIC_Totl_c0 |
> +               BIC_Any_c0 |
> +               BIC_GFX_c0 |
> +               BIC_CPUGFX |
> +               BIC_Pkgpc2 |
> +               BIC_Pkgpc3 |
> +               BIC_Pkgpc6 |
> +               BIC_Pkgpc7 |
> +               BIC_Pkgpc8 |
> +               BIC_Pkgpc9 |
> +               BIC_Pkgpc10 |
> +               BIC_PkgTmp |
> +               BIC_RAMWatt;
> +
> +       bic_enabled &=3D ~bic_msrs;
> +}
> +
>  static long perf_event_open(struct perf_event_attr *hw_event, pid_t pid,=
 int cpu, int group_fd, unsigned long flags)
>  {
>         return syscall(__NR_perf_event_open, hw_event, pid, cpu, group_fd=
, flags);
> @@ -1326,6 +1360,8 @@ int get_msr(int cpu, off_t offset, unsigned long lo=
ng *msr)
>  {
>         ssize_t retval;
>
> +       assert(!no_msr);
> +
>         retval =3D pread(get_msr_fd(cpu), msr, sizeof(*msr), offset);
>
>         if (retval !=3D sizeof *msr)
> @@ -1369,6 +1405,7 @@ void help(void)
>                 "               Override default 5-second measurement int=
erval\n"
>                 "  -J, --Joules displays energy in Joules instead of Watt=
s\n"
>                 "  -l, --list   list column headers only\n"
> +               "  -M, --no-msr Disable all uses of the MSR driver\n"
>                 "  -n, --num_iterations num\n"
>                 "               number of the measurement iterations\n"
>                 "  -N, --header_iterations num\n"
> @@ -2578,6 +2615,7 @@ unsigned long long snapshot_sysfs_counter(char *pat=
h)
>  int get_mp(int cpu, struct msr_counter *mp, unsigned long long *counterp=
)
>  {
>         if (mp->msr_num !=3D 0) {
> +               assert(!no_msr);
>                 if (get_msr(cpu, mp->msr_num, counterp))
>                         return -1;
>         } else {
> @@ -2627,6 +2665,9 @@ int get_epb(int cpu)
>         return epb;
>
>  msr_fallback:
> +       if (no_msr)
> +               return -1;
> +
>         get_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &msr);
>
>         return msr & 0xf;
> @@ -2846,7 +2887,7 @@ int get_counters(struct thread_data *t, struct core=
_data *c, struct pkg_data *p)
>         if (DO_BIC(BIC_CORE_THROT_CNT))
>                 get_core_throt_cnt(cpu, &c->core_throt_cnt);
>
> -       if (platform->rapl_msrs & RAPL_AMD_F17H) {
> +       if ((platform->rapl_msrs & RAPL_AMD_F17H) && !no_msr) {
>                 if (get_msr(cpu, MSR_CORE_ENERGY_STAT, &msr))
>                         return -14;
>                 c->core_energy =3D msr & 0xFFFFFFFF;
> @@ -2911,41 +2952,44 @@ int get_counters(struct thread_data *t, struct co=
re_data *c, struct pkg_data *p)
>         if (DO_BIC(BIC_SYS_LPI))
>                 p->sys_lpi =3D cpuidle_cur_sys_lpi_us;
>
> -       if (platform->rapl_msrs & RAPL_PKG) {
> -               if (get_msr_sum(cpu, MSR_PKG_ENERGY_STATUS, &msr))
> -                       return -13;
> -               p->energy_pkg =3D msr;
> -       }
> -       if (platform->rapl_msrs & RAPL_CORE_ENERGY_STATUS) {
> -               if (get_msr_sum(cpu, MSR_PP0_ENERGY_STATUS, &msr))
> -                       return -14;
> -               p->energy_cores =3D msr;
> -       }
> -       if (platform->rapl_msrs & RAPL_DRAM) {
> -               if (get_msr_sum(cpu, MSR_DRAM_ENERGY_STATUS, &msr))
> -                       return -15;
> -               p->energy_dram =3D msr;
> -       }
> -       if (platform->rapl_msrs & RAPL_GFX) {
> -               if (get_msr_sum(cpu, MSR_PP1_ENERGY_STATUS, &msr))
> -                       return -16;
> -               p->energy_gfx =3D msr;
> -       }
> -       if (platform->rapl_msrs & RAPL_PKG_PERF_STATUS) {
> -               if (get_msr_sum(cpu, MSR_PKG_PERF_STATUS, &msr))
> -                       return -16;
> -               p->rapl_pkg_perf_status =3D msr;
> -       }
> -       if (platform->rapl_msrs & RAPL_DRAM_PERF_STATUS) {
> -               if (get_msr_sum(cpu, MSR_DRAM_PERF_STATUS, &msr))
> -                       return -16;
> -               p->rapl_dram_perf_status =3D msr;
> -       }
> -       if (platform->rapl_msrs & RAPL_AMD_F17H) {
> -               if (get_msr_sum(cpu, MSR_PKG_ENERGY_STAT, &msr))
> -                       return -13;
> -               p->energy_pkg =3D msr;
> +       if (!no_msr) {
> +               if (platform->rapl_msrs & RAPL_PKG) {
> +                       if (get_msr_sum(cpu, MSR_PKG_ENERGY_STATUS, &msr)=
)
> +                               return -13;
> +                       p->energy_pkg =3D msr;
> +               }
> +               if (platform->rapl_msrs & RAPL_CORE_ENERGY_STATUS) {
> +                       if (get_msr_sum(cpu, MSR_PP0_ENERGY_STATUS, &msr)=
)
> +                               return -14;
> +                       p->energy_cores =3D msr;
> +               }
> +               if (platform->rapl_msrs & RAPL_DRAM) {
> +                       if (get_msr_sum(cpu, MSR_DRAM_ENERGY_STATUS, &msr=
))
> +                               return -15;
> +                       p->energy_dram =3D msr;
> +               }
> +               if (platform->rapl_msrs & RAPL_GFX) {
> +                       if (get_msr_sum(cpu, MSR_PP1_ENERGY_STATUS, &msr)=
)
> +                               return -16;
> +                       p->energy_gfx =3D msr;
> +               }
> +               if (platform->rapl_msrs & RAPL_PKG_PERF_STATUS) {
> +                       if (get_msr_sum(cpu, MSR_PKG_PERF_STATUS, &msr))
> +                               return -16;
> +                       p->rapl_pkg_perf_status =3D msr;
> +               }
> +               if (platform->rapl_msrs & RAPL_DRAM_PERF_STATUS) {
> +                       if (get_msr_sum(cpu, MSR_DRAM_PERF_STATUS, &msr))
> +                               return -16;
> +                       p->rapl_dram_perf_status =3D msr;
> +               }
> +               if (platform->rapl_msrs & RAPL_AMD_F17H) {
> +                       if (get_msr_sum(cpu, MSR_PKG_ENERGY_STAT, &msr))
> +                               return -13;
> +                       p->energy_pkg =3D msr;
> +               }
>         }
> +
>         if (DO_BIC(BIC_PkgTmp)) {
>                 if (get_msr(cpu, MSR_IA32_PACKAGE_THERM_STATUS, &msr))
>                         return -17;
> @@ -3053,7 +3097,7 @@ void probe_cst_limit(void)
>         unsigned long long msr;
>         int *pkg_cstate_limits;
>
> -       if (!platform->has_nhm_msrs)
> +       if (!platform->has_nhm_msrs || no_msr)
>                 return;
>
>         switch (platform->cst_limit) {
> @@ -3097,7 +3141,7 @@ static void dump_platform_info(void)
>         unsigned long long msr;
>         unsigned int ratio;
>
> -       if (!platform->has_nhm_msrs)
> +       if (!platform->has_nhm_msrs || no_msr)
>                 return;
>
>         get_msr(base_cpu, MSR_PLATFORM_INFO, &msr);
> @@ -3115,7 +3159,7 @@ static void dump_power_ctl(void)
>  {
>         unsigned long long msr;
>
> -       if (!platform->has_nhm_msrs)
> +       if (!platform->has_nhm_msrs || no_msr)
>                 return;
>
>         get_msr(base_cpu, MSR_IA32_POWER_CTL, &msr);
> @@ -3321,7 +3365,7 @@ static void dump_cst_cfg(void)
>  {
>         unsigned long long msr;
>
> -       if (!platform->has_nhm_msrs)
> +       if (!platform->has_nhm_msrs || no_msr)
>                 return;
>
>         get_msr(base_cpu, MSR_PKG_CST_CONFIG_CONTROL, &msr);
> @@ -3393,7 +3437,7 @@ void print_irtl(void)
>  {
>         unsigned long long msr;
>
> -       if (!platform->has_irtl_msrs)
> +       if (!platform->has_irtl_msrs || no_msr)
>                 return;
>
>         if (platform->supported_cstates & PC3) {
> @@ -4173,6 +4217,8 @@ int get_msr_sum(int cpu, off_t offset, unsigned lon=
g long *msr)
>         int ret, idx;
>         unsigned long long msr_cur, msr_last;
>
> +       assert(!no_msr);
> +
>         if (!per_cpu_msr_sum)
>                 return 1;
>
> @@ -4201,6 +4247,8 @@ static int update_msr_sum(struct thread_data *t, st=
ruct core_data *c, struct pkg
>         UNUSED(c);
>         UNUSED(p);
>
> +       assert(!no_msr);
> +
>         for (i =3D IDX_PKG_ENERGY; i < IDX_COUNT; i++) {
>                 unsigned long long msr_cur, msr_last;
>                 off_t offset;
> @@ -4442,10 +4490,13 @@ void check_permissions(void)
>         do_exit +=3D check_for_cap_sys_rawio();
>
>         /* test file permissions */
> -       sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
> -       if (euidaccess(pathname, R_OK)) {
> -               do_exit++;
> -               warn("/dev/cpu/0/msr open failed, try chown or chmod +r /=
dev/cpu/*/msr");
> +       if (!no_msr) {
> +               sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
> +               if (euidaccess(pathname, R_OK)) {
> +                       do_exit++;
> +                       warn("/dev/cpu/0/msr open failed, try chown or ch=
mod +r /dev/cpu/*/msr, "
> +                            "or run with --no-msr");
> +               }
>         }
>
>         /* if all else fails, thell them to be root */
> @@ -4462,7 +4513,7 @@ void probe_bclk(void)
>         unsigned long long msr;
>         unsigned int base_ratio;
>
> -       if (!platform->has_nhm_msrs)
> +       if (!platform->has_nhm_msrs || no_msr)
>                 return;
>
>         if (platform->bclk_freq =3D=3D BCLK_100MHZ)
> @@ -4502,7 +4553,7 @@ static void dump_turbo_ratio_info(void)
>         if (!has_turbo)
>                 return;
>
> -       if (!platform->has_nhm_msrs)
> +       if (!platform->has_nhm_msrs || no_msr)
>                 return;
>
>         if (platform->trl_msrs & TRL_LIMIT2)
> @@ -4783,6 +4834,9 @@ int print_hwp(struct thread_data *t, struct core_da=
ta *c, struct pkg_data *p)
>         UNUSED(c);
>         UNUSED(p);
>
> +       if (no_msr)
> +               return 0;
> +
>         if (!has_hwp)
>                 return 0;
>
> @@ -4869,6 +4923,9 @@ int print_perf_limit(struct thread_data *t, struct =
core_data *c, struct pkg_data
>         UNUSED(c);
>         UNUSED(p);
>
> +       if (no_msr)
> +               return 0;
> +
>         cpu =3D t->cpu_id;
>
>         /* per-package */
> @@ -5202,7 +5259,7 @@ int print_rapl(struct thread_data *t, struct core_d=
ata *c, struct pkg_data *p)
>   */
>  void probe_rapl(void)
>  {
> -       if (!platform->rapl_msrs)
> +       if (!platform->rapl_msrs || no_msr)
>                 return;
>
>         if (genuine_intel)
> @@ -5258,7 +5315,7 @@ int set_temperature_target(struct thread_data *t, s=
truct core_data *c, struct pk
>         }
>
>         /* Temperature Target MSR is Nehalem and newer only */
> -       if (!platform->has_nhm_msrs)
> +       if (!platform->has_nhm_msrs || no_msr)
>                 goto guess;
>
>         if (get_msr(base_cpu, MSR_IA32_TEMPERATURE_TARGET, &msr))
> @@ -5305,6 +5362,9 @@ int print_thermal(struct thread_data *t, struct cor=
e_data *c, struct pkg_data *p
>         UNUSED(c);
>         UNUSED(p);
>
> +       if (no_msr)
> +               return 0;
> +
>         if (!(do_dts || do_ptm))
>                 return 0;
>
> @@ -5402,6 +5462,9 @@ void decode_feature_control_msr(void)
>  {
>         unsigned long long msr;
>
> +       if (no_msr)
> +               return;
> +
>         if (!get_msr(base_cpu, MSR_IA32_FEAT_CTL, &msr))
>                 fprintf(outf, "cpu%d: MSR_IA32_FEATURE_CONTROL: 0x%08llx =
(%sLocked %s)\n",
>                         base_cpu, msr, msr & FEAT_CTL_LOCKED ? "" : "UN-"=
, msr & (1 << 18) ? "SGX" : "");
> @@ -5411,6 +5474,9 @@ void decode_misc_enable_msr(void)
>  {
>         unsigned long long msr;
>
> +       if (no_msr)
> +               return;
> +
>         if (!genuine_intel)
>                 return;
>
> @@ -5428,6 +5494,9 @@ void decode_misc_feature_control(void)
>  {
>         unsigned long long msr;
>
> +       if (no_msr)
> +               return;
> +
>         if (!platform->has_msr_misc_feature_control)
>                 return;
>
> @@ -5449,6 +5518,9 @@ void decode_misc_pwr_mgmt_msr(void)
>  {
>         unsigned long long msr;
>
> +       if (no_msr)
> +               return;
> +
>         if (!platform->has_msr_misc_pwr_mgmt)
>                 return;
>
> @@ -5468,6 +5540,9 @@ void decode_c6_demotion_policy_msr(void)
>  {
>         unsigned long long msr;
>
> +       if (no_msr)
> +               return;
> +
>         if (!platform->has_msr_c6_demotion_policy_config)
>                 return;
>
> @@ -5563,7 +5638,7 @@ void probe_cstates(void)
>         if (platform->has_msr_module_c6_res_ms)
>                 BIC_PRESENT(BIC_Mod_c6);
>
> -       if (platform->has_ext_cst_msrs) {
> +       if (platform->has_ext_cst_msrs && !no_msr) {
>                 BIC_PRESENT(BIC_Totl_c0);
>                 BIC_PRESENT(BIC_Any_c0);
>                 BIC_PRESENT(BIC_GFX_c0);
> @@ -5650,8 +5725,10 @@ void process_cpuid()
>         ecx_flags =3D ecx;
>         edx_flags =3D edx;
>
> -       if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_patch))
> -               warnx("get_msr(UCODE)");
> +       if (!no_msr) {
> +               if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_pa=
tch))
> +                       warnx("get_msr(UCODE)");
> +       }
>
>         /*
>          * check max extended function levels of CPUID.
> @@ -5814,7 +5891,7 @@ void probe_pm_features(void)
>
>         probe_thermal();
>
> -       if (platform->has_nhm_msrs)
> +       if (platform->has_nhm_msrs && !no_msr)
>                 BIC_PRESENT(BIC_SMI);
>
>         if (!quiet)
> @@ -6291,6 +6368,9 @@ int add_counter(unsigned int msr_num, char *path, c=
har *name,
>  {
>         struct msr_counter *msrp;
>
> +       if (no_msr && msr_num)
> +               errx(1, "Requested MSR counter 0x%x, but in --no-msr mode=
", msr_num);
> +
>         msrp =3D calloc(1, sizeof(struct msr_counter));
>         if (msrp =3D=3D NULL) {
>                 perror("calloc");
> @@ -6595,6 +6675,7 @@ void cmdline(int argc, char **argv)
>                 { "list", no_argument, 0, 'l' },
>                 { "out", required_argument, 0, 'o' },
>                 { "quiet", no_argument, 0, 'q' },
> +               { "no-msr", no_argument, 0, 'M' },
>                 { "show", required_argument, 0, 's' },
>                 { "Summary", no_argument, 0, 'S' },
>                 { "TCC", required_argument, 0, 'T' },
> @@ -6604,7 +6685,22 @@ void cmdline(int argc, char **argv)
>
>         progname =3D argv[0];
>
> -       while ((opt =3D getopt_long_only(argc, argv, "+C:c:Dde:hi:Jn:o:qS=
T:v", long_options, &option_index)) !=3D -1) {
> +       /*
> +        * Parse some options early, because they may make other options =
invalid,
> +        * like adding the MSR counter with --add and at the same time us=
ing --no-msr.
> +        */
> +       while ((opt =3D getopt_long_only(argc, argv, "M", long_options, &=
option_index)) !=3D -1) {
> +               switch (opt) {
> +               case 'M':
> +                       no_msr =3D 1;
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
> +       optind =3D 0;
> +
> +       while ((opt =3D getopt_long_only(argc, argv, "+C:c:Dde:hi:Jn:o:qM=
ST:v", long_options, &option_index)) !=3D -1) {
>                 switch (opt) {
>                 case 'a':
>                         parse_add_command(optarg);
> @@ -6662,6 +6758,9 @@ void cmdline(int argc, char **argv)
>                 case 'q':
>                         quiet =3D 1;
>                         break;
> +               case 'M':
> +                       /* Parsed earlier */
> +                       break;
>                 case 'n':
>                         num_iterations =3D strtod(optarg, NULL);
>
> @@ -6722,6 +6821,9 @@ int main(int argc, char **argv)
>         outf =3D stderr;
>         cmdline(argc, argv);
>
> +       if (no_msr)
> +               bic_disable_msr_access();
> +
>         if (!quiet) {
>                 print_version();
>                 print_bootcmd();
> @@ -6731,7 +6833,8 @@ int main(int argc, char **argv)
>
>         turbostat_init();
>
> -       msr_sum_record();
> +       if (!no_msr)
> +               msr_sum_record();
>
>         /* dump counters and exit */
>         if (dump_only)
> --
> 2.43.0
>
>


--=20
Len Brown, Intel

