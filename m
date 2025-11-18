Return-Path: <linux-pm+bounces-38165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB363C695A6
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 13:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 018FF2B45E
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 12:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7864353898;
	Tue, 18 Nov 2025 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDWerkh4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A462D641C
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763468600; cv=none; b=IxJ+QIG+aA1OsCc4/JCeKjY7Vhk/XTy1Eue5C8uigKTb3jHXVykveBjdnB3/R5beUdCpI9j34ScKIapqbmHSyMgwc9lbNQiEn8YuGABpfhJNRUECJoZ6uU8fcu1HnsWVaHak6GG7JXieJqL3TqtogXt8yGJq2tbX7wGihu6/WhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763468600; c=relaxed/simple;
	bh=dXez72CNtS64lJMeFM1Ska+giRRRF60EacmF3GBK1Oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTNYSo9JnZCClRQaIrfy7fU+6z1gd708nTR+x/1iGcnZBsmrvyhNrrMovcZ84TDLv0DcFw3pTgV2j5QLzVae+6nDinKOB9qrEO1m8E1m4sPdeHJsdKYMKeg26jyAOK/mJvBRuuc7/JuADRyhTHQu0RzPABq6CdGVMnfrZH8JNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDWerkh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB940C116B1
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 12:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763468600;
	bh=dXez72CNtS64lJMeFM1Ska+giRRRF60EacmF3GBK1Oc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rDWerkh4tux5gezUsWSei/O6ZvtkMrlmSBqIaluC0J+ebg1JgV8Faup2sYKgb/D+Y
	 5lRqNuTPO+KKZvZ0fcW0vxGkH0Eu/49Vb6tETxxZSbCg7QwxHlw8ap2XFVGUKSInaP
	 Xfk4ccO/AdYkDefyzbHy1rLFC8yGg5VW/5yALASBYlGOeg1ev/7Yi3imnRnP3xS8oo
	 yB9iHPdGFCrySmtPAf0PfHMPgqee5cVXnygn/CUM7ARZUt+lDZoES3XZ+BvR1LtcHF
	 q/2y3AZVqFRsF1X/nRTTHKAlLqADiYbjZVavWSPYPTaIc6leLMgBIN0fx+ccJ3ytxg
	 GI4JZYTSq9uGw==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-65752954c43so851452eaf.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 04:23:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVx9MELS9FOYKlVfGOwZX1aUvkGeGXfRhWeIvdiflb267gjthJnSemHv0RoFq/VuapLCEyP+JK3sg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxveDeL1xfvHdti1wxe0msjp7mueMqY7xJDN1rhYBf5xf5rMVH/
	18UWTnRCP8E+ZyfXxHQ1IiE5BuXCPlJR9E70IwVr18QxDMBCaPmYb77cJuU39jKMQRQfYyjNr5i
	HVzvlkx9XT77hsNHdNilILGia4OWwj2A=
X-Google-Smtp-Source: AGHT+IHHll6B9tm/cWX8pVyrcRROycuv9psSS5GvKXIWfMLYGCZ+0wrfw3HkhcZP4NfqAovxTEwfQIir6op4aTWQ27o=
X-Received: by 2002:a05:6820:5305:b0:657:44c3:eb66 with SMTP id
 006d021491bc7-65762fc3ae9mr996683eaf.1.1763468598392; Tue, 18 Nov 2025
 04:23:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118064606.2777035-1-kaushlendra.kumar@intel.com> <242f6e83-fca0-4225-a196-e573202c2a95@arm.com>
In-Reply-To: <242f6e83-fca0-4225-a196-e573202c2a95@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Nov 2025 13:23:05 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hKncY4krfQQnszizr8k9p9PCT5GD2bQ_3SXj-8H1RcuA@mail.gmail.com>
X-Gm-Features: AWmQ_bnY4GWXSDo-YTIQuo0sEl7px_0KK5NnjomQNIHg2l9hq-EWKPmoHSciqRA
Message-ID: <CAJZ5v0hKncY4krfQQnszizr8k9p9PCT5GD2bQ_3SXj-8H1RcuA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: use cashed resolved frequency
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, linux-pm@vger.kernel.org, 
	rafael@kernel.org, viresh.kumar@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 1:00=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Kaushlendra,
>
> s/cashed/cached/
>
> On 11/18/25 06:46, Kaushlendra Kumar wrote:
> > Return a previously resolved frequency when the requested target
> > matches the policy cache to avoid repeated frequency-table lookups
> > This implementation reuses the existing cached_target_freq and
> > cached_resolved_idx fields maintained by __resolve_freq() and does not
> > introduce new state.
> >
> > Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> > ---
> >   drivers/cpufreq/cpufreq.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 4472bb1ec83c..d90dcffac953 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -527,6 +527,15 @@ unsigned int cpufreq_driver_resolve_freq(struct cp=
ufreq_policy *policy,
> >       unsigned int min =3D READ_ONCE(policy->min);
> >       unsigned int max =3D READ_ONCE(policy->max);
>
> You've probably missed those two potentially changed values behind
> your back...
>
> >
> > +     /* If we recently resolved this target, return cached value.
> > +      * This avoids repeated frequency table searches.
> > +      */
> > +     if (likely(policy->cached_target_freq =3D=3D target_freq &&
> > +                policy->cached_resolved_idx !=3D UINT_MAX &&
> > +                policy->freq_table)) {
> > +             return policy->freq_table[policy->cached_resolved_idx].fr=
equency;
> > +     }
> > +
>
> I'm not that sure if this is a wise shortcut to make.
>
> What if the 'target_freq' is the same as 'cached_target_freq' but
> in the meantime the 'policy->max' has been updated and your
> 'target_freq' should be clamped (like it's in the
> __resolve_freq() ?
>
> IMO it would introduce be a potential bug, isn't it?
>
> >       /*
> >        * If this function runs in parallel with cpufreq_set_policy(), i=
t may
> >        * read policy->min before the update and policy->max after the u=
pdate
>
> Look at the cut comment above and go to the code to see better. This
> code runs in parallel with cpufreq_set_policy() and special care should
> be takes to those values.
>
> Maybe it could be solve with checking:
> target_freq =3D clamp_val(target_freq, min, max);
>
> Although, I'm not sure about the state of the 'relation' variable in
> calling __resolve_freq(). It's hard-coded to CPUFREQ_RELATION_LE
> but I would like to see Rafael's or Viresh's opinion about that
> potential assumption.

It is documented in the cpufreq_driver_resolve_freq() kerneldoc comment.

Overall, the change is unnecessary and potentially harmful.

First, the only user of this function is the schedutil governor which
does its own frequency caching, so duplicating it here is less than
useful.

Second, you've pointed out possible problems with this change.

It also appears to ignore the development history regarding this piece
of code, which is sad and quite disappointing.

