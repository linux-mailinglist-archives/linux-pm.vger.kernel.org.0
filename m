Return-Path: <linux-pm+bounces-18883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6C39EA69B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 04:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33811691DF
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 03:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAB01D6DB3;
	Tue, 10 Dec 2024 03:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6w1/Yg+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E5B1D63FF;
	Tue, 10 Dec 2024 03:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801288; cv=none; b=H/eZ32o/NtyUpdvDNqXmz3sUi0DAzb6Q7/eCj+kJhEuI0BS1kEnbLxteMM1Rs1uMJZRHjBMGW4hyRySwzgDSZXyKtPBhwD8qS6H/oqGO7Fisno28jKf5isuA/oBVY87S/VOn2RTwWVItCAK1/HOe+WnoiXdxzhsmDMpfcYPwSgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801288; c=relaxed/simple;
	bh=wRsVljo8MUN3hoZUMF4MwpPgu14wTHgqIJagdgZZVes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEp4eLiWp9N+Em+UZHT/jsCph0dNJ6zceT8/PUqiQx7SFBeKxjCl97NscnkpNmGtXbv1yjcyJMSTsRwdvuino5GqClCkCyPbjF1fUn+y0/1duNASg3vb5us4AoMpQernRfosq3VnQDOpssExJTpWaKYQj1SDeG57gP2feI5EcXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6w1/Yg+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9e44654ae3so816775766b.1;
        Mon, 09 Dec 2024 19:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733801284; x=1734406084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bzuk2AXQA//axiBu+iuhHNZHjh/HIABNT+spYZNEEs0=;
        b=L6w1/Yg+CbeD1PN8LW1sKC26R6+XDFfzXzQMFyRQ01D7bg4F942g8SWEmuN5kbVe4a
         77S+RuWtcBlhUntRgrwaBvgD41ZH17YY8J7/ducIWjETxkRXIZ/19aztruYM9zJNg7n6
         R5VVsmhNyXWNtMaOCruG1Zy0ee3B9u+SbxyJ70ySIbtxEdveeVYrJckOkWwjcq5zCwfe
         F0sm2n9ASJjFu82QZ9nx3BwUJOaoYsIzurHd3YcwewPsru/jKiDVd7y7J/224BQEJizI
         DdGjBgm1wPMb4Q9SCdUIwGVhziGrB6zB2muhd08NbP/5lPymoIQUJg2w7Cf4uwBUHd88
         HNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733801284; x=1734406084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bzuk2AXQA//axiBu+iuhHNZHjh/HIABNT+spYZNEEs0=;
        b=dC9nZyZADVEhIs+XgeMCIJmL1dYqAYkV0vNQbfplksoZe3LB+QZ1zPvloUR3hXnBIo
         cES31FHIEQ/vKS+GqN6f+Ib2KIZMSy1E2buh3sm4oGZ8RKS1XbOSugC8gzKapm+hB+Wv
         thrgr2B4Co4BrIXmJqaefJY35vxniLzkVd3llR0Vg+Z06UGJsDuqMxeUWY1kHWBS1b0g
         N1B83m4MmI2L+hiwuUQQlZEaXdb2KVISQZu1G0IWX8PX7nuPkRlgAzfWlAqYi0Ufpb9C
         VCzWYqXpIqCSqBvTVXW7qQCf5Qse/paVi6HFnARlbFFydMHASI3LAQVKyQMIOqXoKoeb
         JUhA==
X-Forwarded-Encrypted: i=1; AJvYcCVd2qE/L8OT1dGnoT3Iuki3kECp5T4LJsZdgvCH8MKgdflPyksZEsyeebHhrPHRcWFCq89f5IV4840=@vger.kernel.org, AJvYcCXvb9am5vtzqyiwU3pWsuDELdszZ3rq0q2IxW1XR9ANMaPN4wgnUpADMa828o9xpkGBDz9FY6Hfq7sP+bA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1bXjWNCwzC30cFa2VNYPpWg/QcLXjL5Olye6HBC4QvaUHJsB2
	foLBXsf8sMkzjZn+Q9Mj+fWwAU7sFo3uAEKwst8CsY8VX1NSAuk1e9T2Ot0lazOh6mi4EB6ZKBi
	Sgtr9ZD4FGlF1SjXpJrRs6n1kJuI=
X-Gm-Gg: ASbGncsPpClaqLe+l4WHSw8x68RWvxiMORLrhJZvdwxeGDOWryGeW1/zSPq+R6Rikij
	tIQXPPlxgzBb+uPPm8HuFnyfXjxfRZPGchXkR
X-Google-Smtp-Source: AGHT+IGwYS5ST8ob87NnLhOiZDrTBqGoOAxcydxK26RDvqVMRiJX/k2aCd1Mnak6C2CmRN4P2y+tlepdF73TUeRzM6M=
X-Received: by 2002:a17:906:1db2:b0:aa6:19c9:ad08 with SMTP id
 a640c23a62f3a-aa69ce22fdemr252420666b.48.1733801284232; Mon, 09 Dec 2024
 19:28:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209081429.1871-1-xuewen.yan@unisoc.com> <09acd46b-ec63-46ec-a239-e792c3061e52@arm.com>
In-Reply-To: <09acd46b-ec63-46ec-a239-e792c3061e52@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 10 Dec 2024 11:27:52 +0800
Message-ID: <CAB8ipk92xYEkZ_+m+xKnn2Z0DNOkum+6cgHUhSd_gbdzjAbOXA@mail.gmail.com>
Subject: Re: [RFC PATCH] cpufreq: userspace: Add fast-switch support for userspace
To: Christian Loehle <christian.loehle@arm.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org, viresh.kumar@linaro.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, guohua.yan@unisoc.com, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 6:36=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 12/9/24 08:14, Xuewen Yan wrote:
> > Now, the userspace governor does not support userspace,
> > if the driver only use the fast-switch and not add target_index(),
>
> Which driver does that? Is that actually valid?
> No mainline driver from what I can see.
>

Yes, indeed no mainline driver, It's on our own driver.

> > it will cause uerspace not work.
>
> s/uerspace/userspace
> to not work?
>
> > So add fast-switch support for userspace governor.
> >
> > Co-developed-by: Guohua Yan <guohua.yan@unisoc.com>
> > Signed-off-by: Guohua Yan <guohua.yan@unisoc.com>
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  drivers/cpufreq/cpufreq_userspace.c | 35 +++++++++++++++++++++++++----
> >  1 file changed, 31 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpuf=
req_userspace.c
> > index 2c42fee76daa..3a99197246ed 100644
> > --- a/drivers/cpufreq/cpufreq_userspace.c
> > +++ b/drivers/cpufreq/cpufreq_userspace.c
> > @@ -21,6 +21,30 @@ struct userspace_policy {
> >       struct mutex mutex;
> >  };
> >
> > +static int cpufreq_userspace_target_freq(struct cpufreq_policy *policy=
,
> > +                     unsigned int target_freq, unsigned int relation)
> > +{
> > +     int ret;
>
> not really necessary

In cpufreq_set(), we need the return value.

>
> > +
> > +     if (policy->fast_switch_enabled) {
> > +             unsigned int idx;
> > +
> > +             target_freq =3D clamp_val(target_freq, policy->min, polic=
y->max);
> > +
> > +             if (!policy->freq_table)
> > +                     return target_freq;
> > +
> > +             idx =3D cpufreq_frequency_table_target(policy, target_fre=
q, relation);
> > +             policy->cached_resolved_idx =3D idx;
> > +             policy->cached_target_freq =3D target_freq;
> > +             ret =3D !cpufreq_driver_fast_switch(policy, policy->freq_=
table[idx].frequency);
> > +     } else {
> > +             ret =3D __cpufreq_driver_target(policy, target_freq, rela=
tion);
>
> NIT: could save the indent if you reverse conditions and ret early on !fa=
st_switch

Okay, thanks!

>
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> >  /**
> >   * cpufreq_set - set the CPU frequency
> >   * @policy: pointer to policy struct where freq is being set
> > @@ -41,7 +65,7 @@ static int cpufreq_set(struct cpufreq_policy *policy,=
 unsigned int freq)
> >
> >       userspace->setspeed =3D freq;
> >
> > -     ret =3D __cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_L)=
;
> > +     ret =3D cpufreq_userspace_target_freq(policy, freq, CPUFREQ_RELAT=
ION_L);
> >   err:
> >       mutex_unlock(&userspace->mutex);
> >       return ret;
> > @@ -62,6 +86,8 @@ static int cpufreq_userspace_policy_init(struct cpufr=
eq_policy *policy)
> >
> >       mutex_init(&userspace->mutex);
> >
> > +     cpufreq_enable_fast_switch(policy);
> > +
> >       policy->governor_data =3D userspace;
> >       return 0;
> >  }
> > @@ -72,6 +98,7 @@ static int cpufreq_userspace_policy_init(struct cpufr=
eq_policy *policy)
> >   */
> >  static void cpufreq_userspace_policy_exit(struct cpufreq_policy *polic=
y)
> >  {
> > +     cpufreq_disable_fast_switch(policy);
> >       kfree(policy->governor_data);
> >       policy->governor_data =3D NULL;
> >  }
> > @@ -112,13 +139,13 @@ static void cpufreq_userspace_policy_limits(struc=
t cpufreq_policy *policy)
> >                policy->cpu, policy->min, policy->max, policy->cur, user=
space->setspeed);
> >
> >       if (policy->max < userspace->setspeed)
> > -             __cpufreq_driver_target(policy, policy->max,
> > +             cpufreq_userspace_target_freq(policy, policy->max,
> >                                       CPUFREQ_RELATION_H);
> >       else if (policy->min > userspace->setspeed)
> > -             __cpufreq_driver_target(policy, policy->min,
> > +             cpufreq_userspace_target_freq(policy, policy->min,
> >                                       CPUFREQ_RELATION_L);
> >       else
> > -             __cpufreq_driver_target(policy, userspace->setspeed,
> > +             cpufreq_userspace_target_freq(policy, userspace->setspeed=
,
> >                                       CPUFREQ_RELATION_L);
> >
> >       mutex_unlock(&userspace->mutex);
>

BR

