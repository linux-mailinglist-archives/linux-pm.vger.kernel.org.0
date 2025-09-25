Return-Path: <linux-pm+bounces-35333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0769AB9EE1B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 13:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1548F1BC0357
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 11:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEF82F6560;
	Thu, 25 Sep 2025 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txvyULf5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE352EC560
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758798976; cv=none; b=pXRnmXxNjXcqRlSGRapF2d5iQEV3ESB+J5Dtoh01n6V5ZcRQdJRqoXT70IZBVK7P9OGZOEk/bW3gPTLJCxYC5hn16ZFr5xcCRM+aCLgr8w7XH4CUC6WFSO5F/FnMrwNZCgp1QlcpA35DNWZ7PzBSWbrL6veDiG3mCg+jOlMf1IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758798976; c=relaxed/simple;
	bh=fDQLdRzSJmuHNQkxmP5PqXzoQGXsDjWx1inTyaL1AQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1FUDHyYWVb2wupMGHYMZqE5tK1pX9/eGGH6jzLL504t8debOeuXdawbpWiqT/bTqzhEo5h7UpwB3CzwAl6p1hK6p4F9lxvtaiFwtdLbOlG6HzsrCMkZiFr5Sr03Ak7BBfa8MlfQRiFPGW6NR/562W2XRSiyitYLKF9WXC+edU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txvyULf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD71C4CEF7
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 11:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758798975;
	bh=fDQLdRzSJmuHNQkxmP5PqXzoQGXsDjWx1inTyaL1AQI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=txvyULf5nbxiObU4BzXZZAzzroRdBTJJspK3mZSPcSM4/1EJ0hmTzcB6Nf6Tid1Mv
	 aW7zpa82TEcPTi1gSi0z9fDKbySPmICnFio+kjpzQXgWr/jStNpa912Q1hmFb3o3H5
	 33SH/g+gUMbqz6qezJAQ2CPb/Gr6ZdDcpFaJRTIBMCtt/57OO4zjDDVkIH0ms40jcu
	 mSifuFXDCGKHkhrw4UIwPd2VP5w7aTBg95t9KxsqxYX1O7vTs1uJIq8wbc1k8A/o2i
	 W+ZPksKSiBbqXBzbuAipKN9IBCMfNp3KrHUdwbYbQl8Ix50CeXBrEfNdmXZD9jv9+c
	 cSpMnRudZp9BA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-332e66cd8e4so375179fac.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 04:16:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBsbPqH82yBuBNhxYkRci6VKwxP0twOY9x6v+wGt3NMMTAT6Txw2R+wbtpd98zubQS9fDQIB9sZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzKqEDZ/FrJTn75YIi2ij3ERqtBbhOj008B6xbu4AIgcsi2Mxg
	VdWnX888gkA7gcqAKdtk3y3ps+urkfFj+diG5xHQNHiGkFrTB7DrBN9jXxAdqRfszP/DudfJeLS
	j9biEC6M5jtScHe47O6iWGBlgWzMCD4E=
X-Google-Smtp-Source: AGHT+IHafUzhGBmN+xVEK4HkAcLgFcq2k7v2GHK3JiGAIsyUGVGNWDwDdgzwvEPjrjjcrQB8XEQvevxh7iz0rg1Q+2c=
X-Received: by 2002:a05:6870:6126:b0:34b:27bd:666a with SMTP id
 586e51a60fabf-35eeaa48d42mr1141756fac.51.1758798975128; Thu, 25 Sep 2025
 04:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922125929.453444-1-shawnguo2@yeah.net> <12764935.O9o76ZdvQC@rafael.j.wysocki>
 <aNT3k9OK82USu4n8@dragon>
In-Reply-To: <aNT3k9OK82USu4n8@dragon>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Sep 2025 13:16:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jd+Th7cdbf7arto+spSbdvd37gk0YZEL5mh=0HK2id=Q@mail.gmail.com>
X-Gm-Features: AS18NWDINpHUc47MEDXGMwzqgVPSTcDn3txgtXlXbHe1JLNEoukN9evapk2uawI
Message-ID: <CAJZ5v0jd+Th7cdbf7arto+spSbdvd37gk0YZEL5mh=0HK2id=Q@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: Handle CPUFREQ_ETERNAL with a default
 transition latency
To: Shawn Guo <shawnguo2@yeah.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Qais Yousef <qyousef@layalina.io>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 10:15=E2=80=AFAM Shawn Guo <shawnguo2@yeah.net> wro=
te:
>
> On Mon, Sep 22, 2025 at 08:31:56PM +0200, Rafael J. Wysocki wrote:
> > What about the appended (untested) change instead?
>
> I'm trying to address a regression with a fix to be ported for stable
> kernel.  Not really sure it's a good idea to mix up with cleanup
> changes.

These are not cleanup changes, just a different way to address the given is=
sue.

Instead of pretending that it still works as documented even though
that's not the case strictly speaking, let's just get rid of it and
let the code be simpler at the same time.


> >
> > With a follow-up one to replace CPUFREQ_ETERNAL with something internal
> > to CPPC.
> >
> > ---
> >  Documentation/admin-guide/pm/cpufreq.rst                  |    4 ----
> >  Documentation/cpu-freq/cpu-drivers.rst                    |    3 +--
> >  Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst |    3 +--
> >  Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst |    3 +--
> >  drivers/cpufreq/cppc_cpufreq.c                            |   14 +++++=
+++++++--
> >  drivers/cpufreq/cpufreq-dt.c                              |    2 +-
> >  drivers/cpufreq/imx6q-cpufreq.c                           |    2 +-
> >  drivers/cpufreq/mediatek-cpufreq-hw.c                     |    2 +-
> >  drivers/cpufreq/scmi-cpufreq.c                            |    2 +-
> >  drivers/cpufreq/scpi-cpufreq.c                            |    2 +-
> >  drivers/cpufreq/spear-cpufreq.c                           |    2 +-
> >  include/linux/cpufreq.h                                   |    7 ++++-=
--
> >  12 files changed, 25 insertions(+), 21 deletions(-)
> >
> > --- a/Documentation/admin-guide/pm/cpufreq.rst
> > +++ b/Documentation/admin-guide/pm/cpufreq.rst
> > @@ -274,10 +274,6 @@ are the following:
> >       The time it takes to switch the CPUs belonging to this policy fro=
m one
> >       P-state to another, in nanoseconds.
> >
> > -     If unknown or if known to be so high that the scaling driver does=
 not
> > -     work with the `ondemand`_ governor, -1 (:c:macro:`CPUFREQ_ETERNAL=
`)
> > -     will be returned by reads from this attribute.
> > -
> >  ``related_cpus``
> >       List of all (online and offline) CPUs belonging to this policy.
> >
> > --- a/Documentation/cpu-freq/cpu-drivers.rst
> > +++ b/Documentation/cpu-freq/cpu-drivers.rst
> > @@ -109,8 +109,7 @@ Then, the driver must fill in the follow
> >  +-----------------------------------+---------------------------------=
-----+
> >  |policy->cpuinfo.transition_latency | the time it takes on this CPU to=
          |
> >  |                                | switch between two frequencies in  =
  |
> > -|                                | nanoseconds (if appropriate, else  =
  |
> > -|                                | specify CPUFREQ_ETERNAL)           =
  |
> > +|                                | nanoseconds                        =
  |
> >  +-----------------------------------+---------------------------------=
-----+
> >  |policy->cur                     | The current operating frequency of =
  |
> >  |                                | this CPU (if appropriate)          =
  |
> > --- a/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
> > +++ b/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
> > @@ -112,8 +112,7 @@ CPUfreq=E6=A0=B8=E5=BF=83=E5=B1=82=E6=B3=A8=E5=86=
=8C=E4=B8=80=E4=B8=AAcpufreq_driv
> >  |                                   |                                 =
     |
> >  +-----------------------------------+---------------------------------=
-----+
> >  |policy->cpuinfo.transition_latency | CPU=E5=9C=A8=E4=B8=A4=E4=B8=AA=
=E9=A2=91=E7=8E=87=E4=B9=8B=E9=97=B4=E5=88=87=E6=8D=A2=E6=89=80=E9=9C=80=E7=
=9A=84=E6=97=B6=E9=97=B4=EF=BC=8C=E4=BB=A5  |
> > -|                                   | =E7=BA=B3=E7=A7=92=E4=B8=BA=E5=
=8D=95=E4=BD=8D=EF=BC=88=E5=A6=82=E4=B8=8D=E9=80=82=E7=94=A8=EF=BC=8C=E8=AE=
=BE=E5=AE=9A=E4=B8=BA         |
> > -|                                   | CPUFREQ_ETERNAL=EF=BC=89        =
            |
> > +|                                   | =E7=BA=B3=E7=A7=92=E4=B8=BA=E5=
=8D=95=E4=BD=8D                    |
> >  |                                   |                                 =
     |
> >  +-----------------------------------+---------------------------------=
-----+
> >  |policy->cur                        | =E8=AF=A5CPU=E5=BD=93=E5=89=8D=
=E7=9A=84=E5=B7=A5=E4=BD=9C=E9=A2=91=E7=8E=87(=E5=A6=82=E9=80=82=E7=94=A8) =
         |
> > --- a/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
> > +++ b/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
> > @@ -112,8 +112,7 @@ CPUfreq=E6=A0=B8=E5=BF=83=E5=B1=A4=E8=A8=BB=E5=86=
=8A=E4=B8=80=E5=80=8Bcpufreq_driv
> >  |                                   |                                 =
     |
> >  +-----------------------------------+---------------------------------=
-----+
> >  |policy->cpuinfo.transition_latency | CPU=E5=9C=A8=E5=85=A9=E5=80=8B=
=E9=A0=BB=E7=8E=87=E4=B9=8B=E9=96=93=E5=88=87=E6=8F=9B=E6=89=80=E9=9C=80=E7=
=9A=84=E6=99=82=E9=96=93=EF=BC=8C=E4=BB=A5  |
> > -|                                   | =E7=B4=8D=E7=A7=92=E7=88=B2=E5=
=96=AE=E4=BD=8D=EF=BC=88=E5=A6=82=E4=B8=8D=E9=81=A9=E7=94=A8=EF=BC=8C=E8=A8=
=AD=E5=AE=9A=E7=88=B2         |
> > -|                                   | CPUFREQ_ETERNAL=EF=BC=89        =
            |
> > +|                                   | =E7=B4=8D=E7=A7=92=E7=88=B2=E5=
=96=AE=E4=BD=8D                    |
> >  |                                   |                                 =
     |
> >  +-----------------------------------+---------------------------------=
-----+
> >  |policy->cur                        | =E8=A9=B2CPU=E7=95=B6=E5=89=8D=
=E7=9A=84=E5=B7=A5=E4=BD=9C=E9=A0=BB=E7=8E=87(=E5=A6=82=E9=81=A9=E7=94=A8) =
         |
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -308,6 +308,16 @@ static int cppc_verify_policy(struct cpu
> >       return 0;
> >  }
> >
> > +static unsigned int get_transition_latency(unsigned int cpu)
> > +{
> > +     unsigned int transition_latency_ns =3D cppc_get_transition_latenc=
y(cpu);
> > +
> > +     if (transition_latency_ns =3D=3D CPUFREQ_ETERNAL)
> > +             return CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS / NSEC_PER_U=
SEC;
> > +
> > +     return transition_latency_ns / NSEC_PER_USEC;
> > +}
> > +
> >  /*
> >   * The PCC subspace describes the rate at which platform can accept co=
mmands
> >   * on the shared PCC channel (including READs which do not count towar=
ds freq
> > @@ -330,12 +340,12 @@ static unsigned int cppc_cpufreq_get_tra
> >                       return 10000;
> >               }
> >       }
> > -     return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
> > +     return get_transition_latency(cpu);
> >  }
> >  #else
> >  static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int =
cpu)
> >  {
> > -     return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
> > +     return get_transition_latency(cpu);
> >  }
> >  #endif
> >
> > --- a/drivers/cpufreq/cpufreq-dt.c
> > +++ b/drivers/cpufreq/cpufreq-dt.c
> > @@ -104,7 +104,7 @@ static int cpufreq_init(struct cpufreq_p
> >
> >       transition_latency =3D dev_pm_opp_get_max_transition_latency(cpu_=
dev);
> >       if (!transition_latency)
> > -             transition_latency =3D CPUFREQ_ETERNAL;
> > +             transition_latency =3D CPUFREQ_DEFAULT_TRANSITION_LATENCY=
_NS;
> >
> >       cpumask_copy(policy->cpus, priv->cpus);
> >       policy->driver_data =3D priv;
> > --- a/drivers/cpufreq/imx6q-cpufreq.c
> > +++ b/drivers/cpufreq/imx6q-cpufreq.c
> > @@ -442,7 +442,7 @@ soc_opp_out:
> >       }
> >
> >       if (of_property_read_u32(np, "clock-latency", &transition_latency=
))
> > -             transition_latency =3D CPUFREQ_ETERNAL;
> > +             transition_latency =3D CPUFREQ_DEFAULT_TRANSITION_LATENCY=
_NS;
> >
> >       /*
> >        * Calculate the ramp time for max voltage change in the
> > --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> > @@ -309,7 +309,7 @@ static int mtk_cpufreq_hw_cpu_init(struc
> >
> >       latency =3D readl_relaxed(data->reg_bases[REG_FREQ_LATENCY]) * 10=
00;
> >       if (!latency)
> > -             latency =3D CPUFREQ_ETERNAL;
> > +             latency =3D CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
> >
> >       policy->cpuinfo.transition_latency =3D latency;
> >       policy->fast_switch_possible =3D true;
> > --- a/drivers/cpufreq/scmi-cpufreq.c
> > +++ b/drivers/cpufreq/scmi-cpufreq.c
> > @@ -294,7 +294,7 @@ static int scmi_cpufreq_init(struct cpuf
> >
> >       latency =3D perf_ops->transition_latency_get(ph, domain);
> >       if (!latency)
> > -             latency =3D CPUFREQ_ETERNAL;
> > +             latency =3D CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
> >
> >       policy->cpuinfo.transition_latency =3D latency;
> >
> > --- a/drivers/cpufreq/scpi-cpufreq.c
> > +++ b/drivers/cpufreq/scpi-cpufreq.c
> > @@ -157,7 +157,7 @@ static int scpi_cpufreq_init(struct cpuf
> >
> >       latency =3D scpi_ops->get_transition_latency(cpu_dev);
> >       if (!latency)
> > -             latency =3D CPUFREQ_ETERNAL;
> > +             latency =3D CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
> >
> >       policy->cpuinfo.transition_latency =3D latency;
> >
> > --- a/drivers/cpufreq/spear-cpufreq.c
> > +++ b/drivers/cpufreq/spear-cpufreq.c
> > @@ -182,7 +182,7 @@ static int spear_cpufreq_probe(struct pl
> >
> >       if (of_property_read_u32(np, "clock-latency",
> >                               &spear_cpufreq.transition_latency))
> > -             spear_cpufreq.transition_latency =3D CPUFREQ_ETERNAL;
> > +             spear_cpufreq.transition_latency =3D CPUFREQ_DEFAULT_TRAN=
SITION_LATENCY_NS;
> >
> >       cnt =3D of_property_count_u32_elems(np, "cpufreq_tbl");
> >       if (cnt <=3D 0) {
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -26,12 +26,13 @@
> >   *********************************************************************=
/
> >  /*
> >   * Frequency values here are CPU kHz
> > - *
> > - * Maximum transition latency is in nanoseconds - if it's unknown,
> > - * CPUFREQ_ETERNAL shall be used.
> >   */
> >
> > +/* Represents unknown transition latency */
> >  #define CPUFREQ_ETERNAL                      (-1)
> > +
> > +#define CPUFREQ_DEFAULT_TANSITION_LATENCY_NS NSEC_PER_MSEC
> > +
> >  #define CPUFREQ_NAME_LEN             16
> >  /* Print length for names. Extra 1 space for accommodating '\n' in pri=
nts */
> >  #define CPUFREQ_NAME_PLEN            (CPUFREQ_NAME_LEN + 1)
> >
> >
> >
> >
>

