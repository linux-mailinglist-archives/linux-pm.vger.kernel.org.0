Return-Path: <linux-pm+bounces-23132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77849A48959
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 21:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3463B4982
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 20:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632B226F46E;
	Thu, 27 Feb 2025 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8dwXfDf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBEE226183
	for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686512; cv=none; b=LrnL2qYvt7+BQwar974rJirj5YWVZsx+AQ1xmA1f7eno7BNtxFIH19oZKrNmXcbdIQTH0tngQtTq5f/Bxb0dwRAhlhqLO5NsrHw6Xpzj68rH1bpzujT/xoA+5NeIbyJeCghNJkZQ6PoSWxAmU4D5xm0lqNXql8GS9OzSJ98mvFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686512; c=relaxed/simple;
	bh=BD/JYlkq7yAGC62e77/mkqjJGjquw+AdOQ/MzlUETrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJmqjggBQQUHDt3Mvemq0wCOLePk0RM/ReROGivyl0Mt0ib+rOPuTr61FqAjRvsUqwtkKX5E8hJvfWJcrBfNUSinyqoVhI+0awwshjTOpSB6QvMux4E7AvXep70bNiMV6Y48wda8nCvDKevHHONCg/PaXA+n6MQNWdA60k8fRoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8dwXfDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54E3C4CEDD
	for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 20:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740686511;
	bh=BD/JYlkq7yAGC62e77/mkqjJGjquw+AdOQ/MzlUETrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m8dwXfDf5ipFVM8UQIVpjJUHwQyw0I0DtasrwecgIgzCFnYfBB8gLaYUvPw1PevKf
	 vdLaRlDPGfmjikd7auQcj+G+CCBBuG33wzCWbfckVxmRL0OdZ3Dt/IJm8M+i3G9//W
	 XEpd0WfXQtaOcVVGEVzrQkPs8mu7yqY3wGSBkhKAoLxCzaPg8Fr5K6SayixwqfLZPk
	 O4kplb6IT2RapVyk78PbHw5sp99E8mVAG3+Ueg76gFdPRGhETFX8yIFgpNK39PiJBo
	 VzFL4KMldCspCPZn+8YEEsBoQOBIgdghqoGtP28ho0hd05JashqRL7svZRrMeJgcjC
	 CUe7jLDuFJn/Q==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2c12f9e9449so738117fac.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 12:01:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVradiCQn0WPxO6BccUBS2PWFYxlLnxHE43RQ0m9RLJH79AqqxpD8+3ix0t/8qx+NZUkTIF0Mrm+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhmC/S8D03LCqPHixBjaXFqaahPlKWrLNRm62f7tfr2H2xUjzr
	qGPg1oHCPTKu07trLD1n39mTKlhvWOzLxsTutM3WZ/V8n8uGzDua7sawr8yK2fDQLW+3KFJ1NaJ
	KQnh10D9BBBRHY9yqLZyMs8xCLl8=
X-Google-Smtp-Source: AGHT+IFL1Dd2TdiWkoutWrk1Eu2JTMarqwGhyy/Tkg7LVbPhfB1tAIMLMbRuspyMaCcG2U8A4CUN3Xocc5Je9MwwE2o=
X-Received: by 2002:a05:6871:5808:b0:2bc:7d6f:fa86 with SMTP id
 586e51a60fabf-2c1787a37a4mr347438fac.35.1740686511122; Thu, 27 Feb 2025
 12:01:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220154306.2166129-1-dedekind1@gmail.com> <20250220154306.2166129-2-dedekind1@gmail.com>
In-Reply-To: <20250220154306.2166129-2-dedekind1@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Feb 2025 21:01:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gd+Xazbz-ZHqnXS2_geK+f60xZzb4CGbXEWbwiKp81NA@mail.gmail.com>
X-Gm-Features: AQ5f1JrUIU6XaNyNku4rt-Ut44LqtxmFkm_cHpVgA9-qw_GguBeZRWGyxu1pAl8
Message-ID: <CAJZ5v0gd+Xazbz-ZHqnXS2_geK+f60xZzb4CGbXEWbwiKp81NA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] x86: msr: add new 'msr_pkg_cst_config_control.h' header
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:43=E2=80=AFPM Artem Bityutskiy <dedekind1@gmail.c=
om> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> There are now two users that modify the MSR_PKG_CST_CONFIG_CONTROL regist=
er:
> 1. The Intel PMC framework (cnp.c).
> 2. The intel_idle.c driver.
>
> They do not interfere with each other because the former modifies it only
> during suspend/resume.
>
> Introduce common accessor functions for the MSR to make it more clear tha=
t
> there is already more than one user. There is no other purpose at this po=
int.
> But if more users are introduced, the header file may be replaced with a =
small
> MSR_PKG_CST_CONFIG_CONTROL subsystem, possibly implementing locking.
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  .../include/asm/msr_pkg_cst_config_control.h  | 28 +++++++++++++++++++
>  drivers/idle/intel_idle.c                     | 17 +++++------
>  drivers/platform/x86/intel/pmc/cnp.c          | 13 +++++----
>  3 files changed, 44 insertions(+), 14 deletions(-)
>  create mode 100644 arch/x86/include/asm/msr_pkg_cst_config_control.h
>
> diff --git a/arch/x86/include/asm/msr_pkg_cst_config_control.h b/arch/x86=
/include/asm/msr_pkg_cst_config_control.h
> new file mode 100644
> index 000000000000..0d9dab4c20ef
> --- /dev/null
> +++ b/arch/x86/include/asm/msr_pkg_cst_config_control.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Accessors from MSR_PKG_CST_CONFIG_CONTROL (0xe2) MSR found on Intel C=
PUs.
> + *
> + * At this point provide only trival read/write functions. But this head=
er file
> + * can be turned into a small library if there are more MSR users in the=
 future.
> + */
> +
> +#ifndef _MSR_PKG_CST_CONFIG_CONTROL_H
> +#define _MSR_PKG_CST_CONFIG_CONTROL_H
> +
> +#include <asm/msr-index.h>
> +#include <asm/msr.h>
> +
> +static inline unsigned long long rdmsrl_pkg_cst_config_control(void)
> +{
> +       unsigned long long val;
> +
> +       rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
> +       return val;
> +}
> +
> +static inline void wrmsrl_pkg_cst_config_control(unsigned long long val)
> +{
> +       wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
> +}

I didn't actually mean this.

My comment was based on the observation that both
disable_c1_auto_demote() and the new code in intel_idle would
implement a very similar code pattern, that is

(1) read MSR_PKG_CST_CONFIG_CONTROL
(2) either set or clear NHM_C1_AUTO_DEMOTE (possibly along with some
additional bits) in the value read from it
(3) write the updated value to MSR_PKG_CST_CONFIG_CONTROL

and it would be good to have a wrapper for it.  So something like

static inline unsigned long long
msr_pkg_cst_config_c1_auto_demote(bool set, unsigned long long
other_bits)
{
        unsigned long long val, newval;

        rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);

        if (set)
                newval |=3D NHM_C1_AUTO_DEMOTE | other_bits;
        else
                newval &=3D ~(NHM_C1_AUTO_DEMOTE | other_bits);

        wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, newval);

        return val;
}

> +
> +#endif /* _MSR_PKG_CST_CONFIG_CONTROL_H */
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 8d2095078469..e5415e20e0e3 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -59,6 +59,7 @@
>  #include <asm/mwait.h>
>  #include <asm/spec-ctrl.h>
>  #include <asm/fpu/api.h>
> +#include <asm/msr_pkg_cst_config_control.h>
>
>  #define INTEL_IDLE_VERSION "0.5.1"
>
> @@ -1975,7 +1976,7 @@ static void __init sklh_idle_state_table_update(voi=
d)
>         if ((mwait_substates & (0xF << 28)) =3D=3D 0)
>                 return;
>
> -       rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr);
> +       msr =3D rdmsrl_pkg_cst_config_control();
>
>         /* PC10 is not enabled in PKG C-state limit */
>         if ((msr & 0xF) !=3D 8)
> @@ -2006,7 +2007,7 @@ static void __init skx_idle_state_table_update(void=
)
>  {
>         unsigned long long msr;
>
> -       rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr);
> +       msr =3D rdmsrl_pkg_cst_config_control();
>
>         /*
>          * 000b: C0/C1 (no package C-state support)
> @@ -2059,7 +2060,7 @@ static void __init spr_idle_state_table_update(void=
)
>          * C6. However, if PC6 is disabled, we update the numbers to matc=
h
>          * core C6.
>          */
> -       rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr);
> +       msr =3D rdmsrl_pkg_cst_config_control();
>
>         /* Limit value 2 and above allow for PC6. */
>         if ((msr & 0x7) < 2) {
> @@ -2221,9 +2222,9 @@ static void auto_demotion_disable(void)
>  {
>         unsigned long long msr_bits;
>
> -       rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
> +       msr_bits =3D rdmsrl_pkg_cst_config_control();
>         msr_bits &=3D ~auto_demotion_disable_flags;
> -       wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
> +       wrmsrl_pkg_cst_config_control(msr_bits);
>  }
>
>  static void c1e_promotion_enable(void)
> @@ -2309,7 +2310,7 @@ static void intel_c1_demotion_toggle(void *info)
>         unsigned long long msr_val;
>         bool enable =3D *(bool *)info;
>
> -       rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
> +       msr_val =3D rdmsrl_pkg_cst_config_control();
>         /*
>          * Enable/disable C1 undemotion along with C1 demotion, as this i=
s the
>          * most sensible configuration in general.
> @@ -2318,7 +2319,7 @@ static void intel_c1_demotion_toggle(void *info)
>                 msr_val |=3D NHM_C1_AUTO_DEMOTE | SNB_C1_AUTO_UNDEMOTE;
>         else
>                 msr_val &=3D ~(NHM_C1_AUTO_DEMOTE | SNB_C1_AUTO_UNDEMOTE)=
;
> -       wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
> +       wrmsrl_pkg_cst_config_control(msr_val);

And now you can do

static void intel_c1_demotion_toggle(void *info)
{
        msr_pkg_cst_config_c1_auto_demote(*(bool *)info, SNB_C1_AUTO_UNDEMO=
TE);
}

here and similarly below.

>  }
>
>  static ssize_t intel_c1_demotion_store(struct device *dev,
> @@ -2349,7 +2350,7 @@ static ssize_t intel_c1_demotion_show(struct device=
 *dev,
>          * Read the MSR value for a CPU and assume it is the same for all=
 CPUs. Any other
>          * configureation would be a BIOS bug.
>          */
> -       rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
> +       msr_val =3D rdmsrl_pkg_cst_config_control();
>         return sysfs_emit(buf, "%d\n", !!(msr_val & NHM_C1_AUTO_DEMOTE));
>  }
>  static DEVICE_ATTR_RW(intel_c1_demotion);
> diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/=
intel/pmc/cnp.c
> index fc5193fdf8a8..4ef8dfe07664 100644
> --- a/drivers/platform/x86/intel/pmc/cnp.c
> +++ b/drivers/platform/x86/intel/pmc/cnp.c
> @@ -10,6 +10,7 @@
>
>  #include <linux/smp.h>
>  #include <linux/suspend.h>
> +#include <asm/msr_pkg_cst_config_control.h>
>  #include "core.h"
>
>  /* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
> @@ -225,12 +226,12 @@ static DEFINE_PER_CPU(u64, pkg_cst_config);
>  static void disable_c1_auto_demote(void *unused)
>  {
>         int cpunum =3D smp_processor_id();
> -       u64 val;
> +       unsigned long long val;
>
> -       rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
> +       val =3D rdmsrl_pkg_cst_config_control();
>         per_cpu(pkg_cst_config, cpunum) =3D val;
>         val &=3D ~NHM_C1_AUTO_DEMOTE;
> -       wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
> +       wrmsrl_pkg_cst_config_control(val);

That is

per_cpu(pkg_cst_config, cpunum) =3D msr_pkg_cst_config_c1_auto_demote(false=
, 0);

>         pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, val);
>  }
> @@ -238,11 +239,11 @@ static void disable_c1_auto_demote(void *unused)
>  static void restore_c1_auto_demote(void *unused)
>  {
>         int cpunum =3D smp_processor_id();
> +       unsigned long long val =3D per_cpu(pkg_cst_config, cpunum);
>
> -       wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, per_cpu(pkg_cst_config, cpunum=
));
> +       wrmsrl_pkg_cst_config_control(val);

And I would leave this code as is (in this patch, but generally, as a
matter of cleanup, adding a local variable var to it would make sense
IMV).

>
> -       pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum,
> -                per_cpu(pkg_cst_config, cpunum));
> +       pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, val);
>  }
>
>  static void s2idle_cpu_quirk(smp_call_func_t func)
> --

