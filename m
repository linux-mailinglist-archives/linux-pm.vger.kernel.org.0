Return-Path: <linux-pm+bounces-34351-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D540CB51386
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 12:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1798D4E1A92
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 10:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E8A3128B6;
	Wed, 10 Sep 2025 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQFU1GHH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE3E30DD15;
	Wed, 10 Sep 2025 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498942; cv=none; b=gc+l+bGgH0REocCljbSXX5/3D3FWLeqpdgDoWxv2DhUzWBRIVfHwaDnrEN+EUVPEWbK04bCg+7qbBxEj1Zgi1zepubWZZh0EntABugNFb49OtQ0bRYjkcg6ULseU6e0X4DTM1H0uUxwQGMkl4BnC6ybvrAb9XFb5wgq9KuaIVSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498942; c=relaxed/simple;
	bh=aeTA+lv2/iWgxRZ8jrB4QdsGG60YLD9kDCzhaXcpjuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXc1DfpZcgjkcWhLxXFs7r+qKgxpxEMKEWfq+aluETrx6XzE1zY1Tjp0iY6Te110z5iLg9VkgeWz+SGove6tJ3gd/R6ncPwVuRVN9B2jarxwJdRkqwT0DOd5Jtt431IM/Yf0W4CNMDd+PGZ6hg84sL+ZjRk+0XiXSVfN6u2pt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQFU1GHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47073C4CEFA;
	Wed, 10 Sep 2025 10:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757498942;
	bh=aeTA+lv2/iWgxRZ8jrB4QdsGG60YLD9kDCzhaXcpjuI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QQFU1GHHjWal7zYc1RUbSOSaNT0uaWghqNsDYZe5aP9TWWSRuwHaiP+rBjseazOe7
	 KdHnWOdoWamQrPloFa1nMFvP91qGHAtQllguliMy0H5sjU278KuYewVoxP1Q+1GpUy
	 RBuXYe9LRLH36Hk3B1zVggFknetUtvofUAY8Q94ukztZVPeMEfKC9XLG1Tm4jnr2SI
	 5COlVZERZ4h7nW3c8McxUIalWkWkQjJMyWfOtNCgdE6mW45hUSdpB3HWnWCaVncvs/
	 ooGQtFpUbqlkLnv7JzLhPIkC6hi8c1MY/OsjvKPvncrIhVVu+DPP1Pi+TfgO7XN0re
	 3nlWnmcI0uytQ==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-61e783a1e00so4347116eaf.1;
        Wed, 10 Sep 2025 03:09:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaNmLTCAnlB2vJT5AOpXFNXC0e8iKvFJiv+4THIhHeC4twwIvwbzXdP6VkMON4HNyL6Vp6bycJw/8TEbg=@vger.kernel.org, AJvYcCWNzEvcfCBF2VqXzeoE3Eo0eqpbkwTS4TNLKD8q4II08vvP+HfOl1tzKxkpAKmX21RSyr8QTRm94BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD1IA5Nj+GLEMx+MIx2D8RXXDEkqladF0lcpGMArdc2bfimVqo
	3JuhknNC7PfLi4i+L74QVKGYZe/ZqpE7Aw6xmUy+lF2V+I9hVvU52wsZaGSwEVQGT6LeqXmANYn
	cnJhDYjKzfeVPEsfi9fKQ7l54zWGxvBI=
X-Google-Smtp-Source: AGHT+IExtstt7zgf6AALxQeMVPvejKGakN2bVaehDXZcFGnx8oq5iaf6A0etveV3YN9Z/Vbh9/EJ7H+n5FKVYkmfBfo=
X-Received: by 2002:a4a:ba8d:0:b0:61f:f60f:de87 with SMTP id
 006d021491bc7-62178a93955mr5432528eaf.7.1757498941534; Wed, 10 Sep 2025
 03:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904000608.260817-1-srinivas.pandruvada@linux.intel.com>
 <20250904000608.260817-2-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0gwXiRTo_Lri3rduA-RqDhwgK4ymwX3ttxqhTw9W6d=fQ@mail.gmail.com> <CAJZ5v0jqLnnBL8fLJ3vxS_61rAigru8T1a9Q-k+cg2kptv_zUA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jqLnnBL8fLJ3vxS_61rAigru8T1a9Q-k+cg2kptv_zUA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Sep 2025 12:08:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iu87EJYfJV+6gTBXkc5B5pfXo97JEfBb_ddOMnMrTCTw@mail.gmail.com>
X-Gm-Features: Ac12FXzms7NFc8nF1XizTbqRsQ7_ppMIftb6YidwLrbMwfsz9eQKhTkFVqXLZwE
Message-ID: <CAJZ5v0iu87EJYfJV+6gTBXkc5B5pfXo97JEfBb_ddOMnMrTCTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: intel_pstate: Enable HWP without EPP feature
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, viresh.kumar@linaro.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 6:13=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Fri, Sep 5, 2025 at 11:02=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Thu, Sep 4, 2025 at 2:06=E2=80=AFAM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > When EPP feature is not available (CPUID CPUID.06H:EAX[10] is not set=
),
> > > intel_pstate will not enable HWP.
> > >
> > > Some processors support DEC feature (Dynamic Efficiency Control). But=
 in
> > > this case HWP must be enabled.
> > >
> > > So, enable HWP even if EPP feature is not available but DEC feature i=
s
> > > present.
> > >
> > > When EPP feature is not available don't publish sysfs attributes
> > > "energy_performance_available_preferences" and
> > > "energy_performance_preference", but continue to enable HWP.
> > >
> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.c=
om>
> > > ---
> > >  drivers/cpufreq/intel_pstate.c | 35 +++++++++++++++++++++++++++++++-=
--
> > >  1 file changed, 32 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_p=
state.c
> > > index c28454b16723..d74abe909fbc 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -904,6 +904,11 @@ static struct freq_attr *hwp_cpufreq_attrs[] =3D=
 {
> > >         NULL,
> > >  };
> > >
> > > +static struct freq_attr *hwp_cpufreq_default_attrs[] =3D {
> > > +       &base_frequency,
> > > +       NULL,
> > > +};
> > > +
> > >  static bool no_cas __ro_after_init;
> > >
> > >  static struct cpudata *hybrid_max_perf_cpu __read_mostly;
> > > @@ -1370,6 +1375,9 @@ static void intel_pstate_hwp_offline(struct cpu=
data *cpu)
> > >  #define POWER_CTL_EE_ENABLE    1
> > >  #define POWER_CTL_EE_DISABLE   2
> > >
> > > +/* Enable bit for Dynamic Efficiency Control (DEC) */
> > > +#define POWER_CTL_DEC_ENABLE   27
> > > +
> > >  static int power_ctl_ee_state;
> > >
> > >  static void set_power_ctl_ee_state(bool input)
> > > @@ -3761,6 +3769,17 @@ static const struct x86_cpu_id intel_hybrid_sc=
aling_factor[] =3D {
> > >         {}
> > >  };
> > >
> > > +static bool dec_enabled(void)
> > > +{
> > > +       u64 power_ctl;
> > > +
> > > +       rdmsrq(MSR_IA32_POWER_CTL, power_ctl);
> > > +       if (power_ctl & BIT(POWER_CTL_DEC_ENABLE))
> > > +               return true;
> > > +
> > > +       return false;
> > > +}
> > > +
> > >  static int __init intel_pstate_init(void)
> > >  {
> > >         static struct cpudata **_all_cpu_data;
> > > @@ -3793,15 +3812,24 @@ static int __init intel_pstate_init(void)
> > >                  * Avoid enabling HWP for processors without EPP supp=
ort,
> > >                  * because that means incomplete HWP implementation w=
hich is a
> > >                  * corner case and supporting it is generally problem=
atic.
> > > +                * But when DEC enable bit is set (MSR 0x1FC bit 27),=
 continue
> > > +                * to enable HWP.
> > >                  *
> > >                  * If HWP is enabled already, though, there is no cho=
ice but to
> > >                  * deal with it.
> > >                  */
> > > -               if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) ||=
 hwp_forced) {
> > > +               if (!no_hwp || hwp_forced) {
> > > +                       if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
> > > +                               intel_pstate.attr =3D hwp_cpufreq_att=
rs;
> > > +                               intel_cpufreq.attr =3D hwp_cpufreq_at=
trs;
> > > +                       } else if (dec_enabled()) {
> > > +                               intel_pstate.attr =3D hwp_cpufreq_def=
ault_attrs;
> > > +                               intel_cpufreq.attr =3D hwp_cpufreq_de=
fault_attrs;
> > > +                       } else {
> > > +                               goto skip_hwp_enable;
> > > +                       }
> > >                         hwp_active =3D true;
> > >                         hwp_mode_bdw =3D id->driver_data;
> > > -                       intel_pstate.attr =3D hwp_cpufreq_attrs;
> > > -                       intel_cpufreq.attr =3D hwp_cpufreq_attrs;
> > >                         intel_cpufreq.flags |=3D CPUFREQ_NEED_UPDATE_=
LIMITS;
> > >                         intel_cpufreq.adjust_perf =3D intel_cpufreq_a=
djust_perf;
> > >                         if (!default_driver)
> > > @@ -3811,6 +3839,7 @@ static int __init intel_pstate_init(void)
> > >
> > >                         goto hwp_cpu_matched;
> > >                 }
> > > +skip_hwp_enable:
> > >                 pr_info("HWP not enabled\n");
> > >         } else {
> > >                 if (no_load)
> > > --
> >
> > I think that this would work, but then it looks super ad hoc and I'd
> > like to completely rearrange it.
> >
> > My (totally untested) version is attached.  Please let me know if this
> > can be made work for you and if so, I'll turn it into a proper patch.
>
> Bah, the EPP-related attributes need to be hidden when EPP is not
> there, even if hwp_forced is set.
>
> Attached is a new version, please let me know if it works for you.

Any chance to have a look at the latest patch?

