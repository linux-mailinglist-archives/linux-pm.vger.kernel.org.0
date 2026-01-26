Return-Path: <linux-pm+bounces-41467-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id est7K8lSd2mdeAEAu9opvQ
	(envelope-from <linux-pm+bounces-41467-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 12:40:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E962D87B6B
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 12:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94D073011BFD
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 11:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5AF3314DC;
	Mon, 26 Jan 2026 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlO7fCnZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF69E329C6A
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769427653; cv=none; b=MlqjzJF7PCjNknuiFaO7Z88VqnUio8TTRtraB0loymEOozPfCLKX2dooqBbh+ldNDxv9ejYBLvcGsp9+RtPkmBRsC+Hgs/YetV35cDeICobN5lwJ/5Isvyeofbex9rHszIFDJPUrQfpZEFT6VE9qCaeWcSSKiY0HOa7rZhaTog8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769427653; c=relaxed/simple;
	bh=OglUG7901k+OmNx+oBfG1WiE0ASoGol21Gyou7EskQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3oIhqXT7vuICUQt17PwIbPzC0Fw2Fy5hKXUtKO8V2joYYKFRLS5Y4FB1s8owcIcdCaBqIK1V5DqNoxH1UAOQvxcxb1+JEjuXkj6jQG5jeLBzheLQwlGQzSfMPO3nVnqAlDTX04pWlSzJV7w68c7SbKutLOVHhozTdJ+YxxCRTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlO7fCnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F53C19422
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 11:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769427653;
	bh=OglUG7901k+OmNx+oBfG1WiE0ASoGol21Gyou7EskQU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SlO7fCnZ+ZmEI8+wNj7gDUUiFexwSkqnBSqwf+8ywwSDQHCTYIhpVDptLvNyqLI2O
	 DM4x66yBqdT5VpUmzAtA9F/0gj4LDyAqgtEJBxOM/nI8zuUfwno1XpjN3GaFBU+cGw
	 Ckn6ZCF+6vrNn8fDmEXLmQDZt7gPna67wMtQceVeOKgvZYPn2GgsvaXnthdQqP/ikw
	 7bSqXOPHkjKWs1HeHU5mo5/T4u9986qBb7Hftu/8+0Pv8yEnZbihXDdWpcH9renjaO
	 K4ANorsUnDmZFXh+Pi4zHzdfaCuQdgcb5aMT/I1fll8rw3UkR5hJO8F5SwRds+GhlL
	 HraR+aAs4quSw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-65e94e128beso2839612eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 03:40:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWbUtPyinPonj6r794/VP6nIYI8C/7v8i3yj/SrUmu5tTAcWoPtp9bd+Ks7/LVudFFtR2VGHHQUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywna5ayWTwanUvpqTNCxgwWMZqpZ/uLm3xgo30ipQ0o+jjfBFb4
	72s8gIlp3fQzxSbtQ1bx61dGC5/d8zMzugIb9X3fJuyAzrDEAGT/Hbd/zKOKI9E25ppYhChe+x5
	o3ByZtliyEnkoXcNgDduNQmfAgcBayjg=
X-Received: by 2002:a05:6820:f008:b0:662:c0e8:40f0 with SMTP id
 006d021491bc7-662e0a0bd7dmr2215177eaf.2.1769427652619; Mon, 26 Jan 2026
 03:40:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2257365.irdbgypaU6@rafael.j.wysocki> <3033265.e9J7NaK4W3@rafael.j.wysocki>
 <0d066ce0-b0bf-43f2-a1c4-56e5ac47cce1@arm.com> <CAJZ5v0iVPDY5wvz0KY7aHJXnX=7ZCMbqi1G5mWTYdYsi2xf9+g@mail.gmail.com>
 <401cbcab-5a41-4aa2-97f8-3dccc069e836@arm.com>
In-Reply-To: <401cbcab-5a41-4aa2-97f8-3dccc069e836@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Jan 2026 12:40:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iygK59hvYKfNy0AYXe4Nyn-kM3dnY-9ongeGWc_jZ+3Q@mail.gmail.com>
X-Gm-Features: AZwV_QgJxhZ9HWF2B4nv6-exdib5l5Z64z0LithgQheiX8B1e0aI0XU3Dq5shZY
Message-ID: <CAJZ5v0iygK59hvYKfNy0AYXe4Nyn-kM3dnY-9ongeGWc_jZ+3Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] cpuidle: governors: teo: Avoid selecting states
 with zero-size bins
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41467-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: E962D87B6B
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 10:18=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 1/23/26 20:46, Rafael J. Wysocki wrote:
> > On Wed, Jan 21, 2026 at 2:10=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 1/14/26 19:44, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> If the last two enabled idle states have the same target residency wh=
ich
> >>> is at least equal to TICK_NSET, teo may select the next-to-last one e=
ven
> >>
> >> s/TICK_NSET/TICK_NSEC
> >
> > Yup, thanks!
> >
> >>> though the size of that state's bin is 0, which is confusing.
> >>>
> >>> Prevent that from happening by adding a target residency check to the
> >>> relevant code path.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>  drivers/cpuidle/governors/teo.c |   10 ++++++++++
> >>>  1 file changed, 10 insertions(+)
> >>>
> >>> --- a/drivers/cpuidle/governors/teo.c
> >>> +++ b/drivers/cpuidle/governors/teo.c
> >>> @@ -388,6 +388,15 @@ static int teo_select(struct cpuidle_dri
> >>>                       while (min_idx < idx &&
> >>>                              drv->states[min_idx].target_residency_ns=
 < TICK_NSEC)
> >>>                               min_idx++;
> >>> +
> >>> +                     /*
> >>> +                      * Avoid selecting a state with a lower index, =
but with
> >>> +                      * the same target residency as the current can=
didate
> >>> +                      * one.
> >>> +                      */
> >>> +                     if (drv->states[min_idx].target_residency_ns =
=3D=3D
> >>> +                                     drv->states[idx].target_residen=
cy_ns)
> >>
> >> We need to check that min_idx isn't disabled though, otherwise we now =
skip a
> >> potential (enabled) idx=3D=3D1 if min_idx=3D=3D2 and min_idx is disabl=
ed.
> >
> > Not really because idx is the current candidate state and it is
> > enabled.  We'll use idx if this check is true, not min_idx.
> >
>
> Are you sure?

Yeah, pretty much.

> I meant initially:
>
>                 for (i =3D intercept_max_idx; i >=3D min_idx; i--) {
>                         intercept_sum +=3D cpu_data->state_bins[i].interc=
epts;
>
>                         if (dev->states_usage[i].disable)
>                                 continue;
>
>                         idx =3D i;
>                         if (2 * intercept_sum > idx_intercept_sum)
>                                 break;
>                 }
> might skip an idx=3D=3D3 if it enters with min_idx=3D=3D2 (sorry, messed =
up the +-1 in the initial mail)
> even though idx=3D=3D3 might have the same residency as idx=3D=3D2.
> So if idx=3D=3D2 is disabled we could've selected idx=3D=3D3, but now won=
't and will go for idx=3D=3D1 or
> whatever is the next shallower enabled state.

But that's after patch [5/5] that has problems (I have a new version
of it ready to send, will do that later today).

Look at the original 6.19-rc code and patch [1/1] by itself and you'll
see what I mean.

Patch [1/1] only adds a check and a jump to a new label (at which
point idx is going to be used), nothing more.

> Additionally an issue with this and patch 5/5:
>
>                 if (min_idx >=3D intercept_max_idx) {
>                         idx =3D min_idx;
>                         goto constraint; // CL: this will just select min=
_idx
>                 }
>
> will use min_idx even though it might be disabled and also the scenario

Again, after patch [5/5] which adds the code quoted above.

> I think we should just add something like
>
> ------8<-------
>
> cpuidle: teo: Fix intercept-logic selecting disabled
>
> Prevent min_idx to be set to a disabled state, which could lead to
> both a disabled state being returned by teo, but also an equally good
> state being skipped because it has a higher index than a disabled state.
>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/cpuidle/governors/teo.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/=
teo.c
> index 4cf6302f99ad..94c5ef5df467 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -420,9 +420,11 @@ static int teo_select(struct cpuidle_driver *drv, st=
ruct cpuidle_device *dev,
>                          * candidate one whose target residency is at lea=
st
>                          * equal to the tick period length.
>                          */
> -                       while (min_idx < idx &&
> -                              drv->states[min_idx].target_residency_ns <=
 TICK_NSEC)
> -                               min_idx++;
> +                       while (i < idx && drv->states[i].target_residency=
_ns < TICK_NSEC) {
> +                               i++;
> +                               if (!dev->states_usage[i].disable)
> +                                       min_idx =3D i;
> +                       }
>
>                         /*
>                          * Avoid selecting a state with a lower index, bu=
t with
> --

After fixing patch [5/5] that's not needed any more.

