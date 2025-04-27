Return-Path: <linux-pm+bounces-26297-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA56A9E2D3
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 13:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638241896075
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 11:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B7F24EABF;
	Sun, 27 Apr 2025 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISVZbkAq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08BF241665;
	Sun, 27 Apr 2025 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745754111; cv=none; b=K9qMRa9CYPzodKoWAQNqBUGoXETE1t5rCRcJdbvS2ziFglK/Fw8Ek8+UEpjGAFWHXo940St7X1lHtQTKpteCK83rovOTMJdjvmvfQNH4SQTkx2H/bep8noJD5pKNk3tl9uTPs93AnE1dMkAfRJJKGY5CWIq112YjtMiRXKhp/2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745754111; c=relaxed/simple;
	bh=+cqCkaeUWEl0iWYWRdN72D7ckuS7/Zv++x0oh64L6GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTJJqGqt/5Sl8tG/hnoysHBlAnK2UijGTvX2HFsHJSFcVj9ldEefsRwkc7g3JtZl5tGRorXFDM8wP6FBNHA7HZlQDoOo8ZuxSam/nxUY3U5dhRPmaB6EEMKfZQx/hKG0OU3/1FTJ0zaKqt2NFTyFUPlDNX0QEqu6xnZTRR6akDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISVZbkAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C4DC4CEE3;
	Sun, 27 Apr 2025 11:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745754110;
	bh=+cqCkaeUWEl0iWYWRdN72D7ckuS7/Zv++x0oh64L6GE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ISVZbkAqga2zsQRxAAwXARS92uVIyf1aoZksGM02qRne9+xqmEHGbe0UY+jU5A3X8
	 Duwhz/y/pj+O2uYlW+/CYtkoLdX1+dfZMMZhfNwVMt8Xpq8p7MfThlzj5V5H0Nz+kj
	 QcgGND0ZbWrrxPPzgf2JVttaSn+h8fxT5dY/0DS2nX1nQkwQ6KEVkewXkObzNW7ujY
	 Xy9upVmzQuuIvOoUeZvkEEozzAfcHf1HsmLtqxtu/ei8+ZLm28pr+PpQvDx+Uaii/Z
	 QgtjVLgz5IOxKIb164sqM8oNP8QsaVAhMmoPKGAZJYuBHWe/N1aLxK3IlQdj4Wy+3a
	 XLhFyg9jld0xw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c2dc6c30c2so1066188fac.2;
        Sun, 27 Apr 2025 04:41:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZ5riA+642j8J4BPAO5c7aqdFL+yjIjVaQ8MW2EjVEq2P8dMfF2gdD4nodU2a65IWOGOnGJ7ebdDd8LpQ=@vger.kernel.org, AJvYcCXTRW5nmFkI4isR1iIbc2priDR9cocdp/1XbhFBXsVjY+NRyZhY1P2EOYm0IBTlBWaQ+4e8WBoUHdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/uP8rj9RGPNKVBLr56G0hAMAy8YDRBjSRMTpGZtFawKqudJ+v
	X1b7t/6lL0AXUQ78VBYQ5O1Iryz9h9Jbjq3eAjhRdENrX5Sd/hWPGzDnyFxxu7791T4VWU+DzEC
	haXVZQvOBtMFRKjFAWzh1mHSniWs=
X-Google-Smtp-Source: AGHT+IHVHE3tASPIO1AlswjYgOJkqDBPbXr3vHFZYgQyalO2yDAxBDhdKxdKj/IkkDVwexBCyedCydSNdmtayuoY6nE=
X-Received: by 2002:a05:6870:911f:b0:2d5:ba2d:80da with SMTP id
 586e51a60fabf-2d99de8afd2mr4571552fac.36.1745754109465; Sun, 27 Apr 2025
 04:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5896780.DvuYhMxLoT@rjwysocki.net> <2fd8c27d-7206-4af6-b30b-d8f786827d94@huawei.com>
In-Reply-To: <2fd8c27d-7206-4af6-b30b-d8f786827d94@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 27 Apr 2025 13:41:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hTbdTaos9gc8ubPNdjq+K-pBwYpAvT8Rm887EZpSm1bw@mail.gmail.com>
X-Gm-Features: ATxdqUGvVQEYb8hwUdHjADdXcKmp7kg_WG1uRPDY-zHoEe5H8iE1RC5O9dPDels
Message-ID: <CAJZ5v0hTbdTaos9gc8ubPNdjq+K-pBwYpAvT8Rm887EZpSm1bw@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: Fix setting policy limits when frequency
 tables are used
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, LKML <linux-kernel@vger.kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Sultan Alsawaf <sultan@kerneltoast.com>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 4:26=E2=80=AFAM zhenglifeng (A) <zhenglifeng1@huawe=
i.com> wrote:
>
> On 2025/4/25 19:36, Rafael J. Wysocki wrote:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 7491cdf46b5c ("cpufreq: Avoid using inconsistent policy->min and
> > policy->max") overlooked the fact that policy->min and policy->max were
> > accessed directly in cpufreq_frequency_table_target() and in the
> > functions called by it.  Consequently, the changes made by that commit
> > led to problems with setting policy limits.
> >
> > Address this by passing the target frequency limits to __resolve_freq()
> > and cpufreq_frequency_table_target() and propagating them to the
> > functions called by the latter.
> >
> > Fixes: 7491cdf46b5c ("cpufreq: Avoid using inconsistent policy->min and=
 policy->max")
> > Link: https://lore.kernel.org/linux-pm/aAplED3IA_J0eZN0@linaro.org/
> > Reported-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > The v1 is here: https://lore.kernel.org/linux-pm/12665363.O9o76ZdvQC@rj=
wysocki.net/
> >
> > v1 -> v2:
> >    * Do clamp_val(target_freq, min, max) before checking freq_table aga=
inst
> >      NULL in __resolve_freq().
> >    * Update comment in cpufreq_frequency_table_target() to match the ne=
w code.
> >
> > ---
> >  drivers/cpufreq/cpufreq.c          |   22 ++++++---
> >  drivers/cpufreq/cpufreq_ondemand.c |    3 -
> >  drivers/cpufreq/freq_table.c       |    6 +-
> >  include/linux/cpufreq.h            |   83 ++++++++++++++++++++++++----=
---------
> >  4 files changed, 73 insertions(+), 41 deletions(-)
> >
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -491,14 +491,18 @@
> >  EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
> >
> >  static unsigned int __resolve_freq(struct cpufreq_policy *policy,
> > -             unsigned int target_freq, unsigned int relation)
> > +                                unsigned int target_freq,
> > +                                unsigned int min, unsigned int max,
> > +                                unsigned int relation)
> >  {
> >       unsigned int idx;
> >
> > +     target_freq =3D clamp_val(target_freq, min, max);
> > +
> >       if (!policy->freq_table)
> >               return target_freq;
> >
> > -     idx =3D cpufreq_frequency_table_target(policy, target_freq, relat=
ion);
> > +     idx =3D cpufreq_frequency_table_target(policy, target_freq, min, =
max, relation);
> >       policy->cached_resolved_idx =3D idx;
> >       policy->cached_target_freq =3D target_freq;
> >       return policy->freq_table[idx].frequency;
> > @@ -532,8 +536,7 @@
> >       if (unlikely(min > max))
> >               min =3D max;
> >
> > -     return __resolve_freq(policy, clamp_val(target_freq, min, max),
> > -                           CPUFREQ_RELATION_LE);
> > +     return __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELA=
TION_LE);
> >  }
> >  EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
> >
> > @@ -2351,8 +2354,8 @@
> >       if (cpufreq_disabled())
> >               return -ENODEV;
> >
> > -     target_freq =3D clamp_val(target_freq, policy->min, policy->max);
> > -     target_freq =3D __resolve_freq(policy, target_freq, relation);
> > +     target_freq =3D __resolve_freq(policy, target_freq, policy->min,
> > +                                  policy->max, relation);
> >
> >       pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kH=
z\n",
> >                policy->cpu, target_freq, relation, old_target_freq);
> > @@ -2650,8 +2653,11 @@
> >        * compiler optimizations around them because they may be accesse=
d
> >        * concurrently by cpufreq_driver_resolve_freq() during the updat=
e.
> >        */
> > -     WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, CPUF=
REQ_RELATION_H));
> > -     new_data.min =3D __resolve_freq(policy, new_data.min, CPUFREQ_REL=
ATION_L);
> > +     WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max,
> > +                                            new_data.min, new_data.max=
,
> > +                                            CPUFREQ_RELATION_H));
> > +     new_data.min =3D __resolve_freq(policy, new_data.min, new_data.mi=
n,
> > +                                   new_data.max, CPUFREQ_RELATION_L);
> >       WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max =
: new_data.min);
>
> It might be better like:
>
> -       WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, CPUF=
REQ_RELATION_H));
> -       new_data.min =3D __resolve_freq(policy, new_data.min, CPUFREQ_REL=
ATION_L);
> -       WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max =
: new_data.min);
> +       WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max,
> +                                              new_data.min, new_data.max=
,
> +                                              CPUFREQ_RELATION_H));
> +       WRITE_ONCE(policy->min, __resolve_freq(policy, new_data.min,
> +                                              new_data.min, policy->max,
> +                                              CPUFREQ_RELATION_L));
>

Not really because policy->max may be less than new_data.min at this
point AFAICS.

