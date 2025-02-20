Return-Path: <linux-pm+bounces-22583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE299A3E5C1
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 21:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40AE17F28C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 20:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71712116F4;
	Thu, 20 Feb 2025 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDrNB/k7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD231DDC14;
	Thu, 20 Feb 2025 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082976; cv=none; b=VSAmKlQNafRUytQ2sbD09pEDM5j3uzosUpUlHHBME7aQTyJJ2Sap1civkam2EPGtevd4t4yaRdhnAuraQWVnSOeBgS461FPg1hjxyBXy/CNHXld2qU3bnjvpsAXEr+b0h1viLlbyGuKPaXjMNSNutoSieSoEvVJOWqGtqMC4h5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082976; c=relaxed/simple;
	bh=U6lgGAkdJH04BdRUnJnulDKU0SeQEUC1Zm+TPPwbPD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7KNovP7Zs+YiqNp9w4RNH3r1E3L/O4f9+un/TV4HO2XWmZerxVwf7mBH5yuNX/P2ThbAB4IgkjhOaDowCrOTA1r64mGj30gul6blPQN3KqQh+UdEuRxHdX5g3GuwmIUqayKGrMNdb2Q1RgzzbyxiRzBHtYLp0cFgWY3FIy42RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDrNB/k7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E416EC4CEE6;
	Thu, 20 Feb 2025 20:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740082975;
	bh=U6lgGAkdJH04BdRUnJnulDKU0SeQEUC1Zm+TPPwbPD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rDrNB/k7xDR0W9Aj/TtQNcloxj1e2YesHJPpF7YkVSjKN+IpyXXheMoYISA54oBoG
	 jIoIlcky4Q+aJlFJJCdl7+BG4SxIbwn0ks1B5uARPaTUSHz8ojpmfaL1D0n6HZOGNZ
	 H0zq2/l7VkIUu5w2WXBwTyKatV/H3Hk1nHqWCX42VD1IwnG3i07p+jMpngcVNFHtIO
	 8Vmwz6yo3th0jib3ZS9r4Nj3cDnYWEX3QWKe7F8dGAwok+WPbsgJPvyGANG13ll4aZ
	 yEKY0JwdPgFszLsyU0HtYgWtaAz4iOmuqEutLO9cPr8I3RUTT0oWfq85rnLO24/qZ8
	 3jTpTdYJ+yAaQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5fc6fe05460so890909eaf.1;
        Thu, 20 Feb 2025 12:22:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUErVzJj+AWpAaBf4cdwEMuUiqev8i+1kG+Xy5/J/edCBzikHqEX4DI+SI12VRCZviQqug7jbGQT4bv9qA=@vger.kernel.org, AJvYcCVFnWN6KB2j4f9QUgyNOLVD5O8CZG4rI5skIBU9VJ8TQo4ustpEx/6fy4tpXZ6mPhohvPcWdX+CYA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEeHCYeCNMKVKkwDmoVpodq1zYpXfDhUVX/t4IuJUtriWiq8H5
	abfmrhuIRKbO6WPS+WUEAug2JoU0rHWV3qKf7cQlDP9rYUCY3Hx3GiV+7g6MeaFrVpHS3dabkZB
	Oi2q1ZQuK32ZC49AmMmht0+k9c6A=
X-Google-Smtp-Source: AGHT+IH6EnL8brABp0Mk08UkkaLVEWekbBYe117zho8S6YxJimcuHVsgFBeidi1T3RqWmnhFWN4yc17qyiyRheV126Q=
X-Received: by 2002:a05:6820:260d:b0:5fc:92b3:2b03 with SMTP id
 006d021491bc7-5fd1949807fmr698175eaf.1.1740082975197; Thu, 20 Feb 2025
 12:22:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-fix-thermal-of-v1-1-de36e7a590c4@chromium.org> <CAJZ5v0i=Ehi1icm4Tx6cXmdhjq-Qj8Vwv1SwzCyx5oBj-5y9hQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0i=Ehi1icm4Tx6cXmdhjq-Qj8Vwv1SwzCyx5oBj-5y9hQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Feb 2025 21:22:43 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gJGxWA=7zHYU5h=ueqQcXNt94wOAg7sqrphOUb++mAyw@mail.gmail.com>
X-Gm-Features: AWEUYZmj4dQ16TOdfKXb0i2SDj6G95jHG8F4Bi6ctfjebp24lSIqhie6AGReCF8
Message-ID: <CAJZ5v0gJGxWA=7zHYU5h=ueqQcXNt94wOAg7sqrphOUb++mAyw@mail.gmail.com>
Subject: Re: [PATCH] thermal: of: Fix logic in thermal_of_should_bind
To: Yu-Che Cheng <giver@chromium.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chen-Yu Tsai <wenst@chromium.org>
Content-Type: multipart/mixed; boundary="0000000000009e135c062e98a365"

--0000000000009e135c062e98a365
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 10:40=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Wed, Feb 19, 2025 at 8:06=E2=80=AFAM Yu-Che Cheng <giver@chromium.org>=
 wrote:
> >
> > The current thermal_of_should_bind will stop iterating cooling-maps on
> > the first matched trip point, leading to subsequent cooling devices
> > binding to the same trip point failing to find the cooling spec.
> >
> > The iteration should continue enumerating subsequent cooling-maps if th=
e
> > target cooling device is not found.
> >
> > Fix the logic to break only when a matched cooling device is found.
>
> OK, but ->
>
> > Fixes: 94c6110b0b13 ("thermal/of: Use the .should_bind() thermal zone c=
allback")
> > Signed-off-by: Yu-Che Cheng <giver@chromium.org>
> > ---
> >  drivers/thermal/thermal_of.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.=
c
> > index 5ab4ce4daaeb..69c530e38574 100644
> > --- a/drivers/thermal/thermal_of.c
> > +++ b/drivers/thermal/thermal_of.c
> > @@ -312,7 +312,8 @@ static bool thermal_of_should_bind(struct thermal_z=
one_device *tz,
> >                                 break;
>
> -> I'd prefer to do a jump from here, that is
>
> -                                 break;
> +                                goto put_cm_np;
> >                 }
> >
> > -               break;
>
> and remove the break statement above altogether.
>
> > +               if (result)
> > +                       break;
> >         }
> >
>
> And of course the label needs to be added too:
>
> +put_cm_np:
> >         of_node_put(cm_np);
> >
> > ---

Or even, to avoid adding a new label, move the loop from
thermal_of_should_bind() into a new function that will be called by it
do carry out the cooling-maps lookup, like in the attached patch.

Can you check if it works for you, please?

--0000000000009e135c062e98a365
Content-Type: text/x-patch; charset="US-ASCII"; name="thermal-of-fix.patch"
Content-Disposition: attachment; filename="thermal-of-fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m7dsfrk30>
X-Attachment-Id: f_m7dsfrk30

LS0tCiBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9vZi5jIHwgICA1MCArKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9u
cygrKSwgMjEgZGVsZXRpb25zKC0pCgotLS0gYS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9vZi5j
CisrKyBiL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX29mLmMKQEAgLTI3NCw2ICsyNzQsMzQgQEAK
IAlyZXR1cm4gdHJ1ZTsKIH0KIAorc3RhdGljIGJvb2wgdGhlcm1hbF9vZl9jbV9sb29rdXAoc3Ry
dWN0IGRldmljZV9ub2RlICpjbV9ucCwKKwkJCQkgY29uc3Qgc3RydWN0IHRoZXJtYWxfdHJpcCAq
dHJpcCwKKwkJCQkgc3RydWN0IHRoZXJtYWxfY29vbGluZ19kZXZpY2UgKmNkZXYsCisJCQkJIHN0
cnVjdCBjb29saW5nX3NwZWMgKmMpCit7CisJZm9yX2VhY2hfY2hpbGRfb2Zfbm9kZV9zY29wZWQo
Y21fbnAsIGNoaWxkKSB7CisJCXN0cnVjdCBkZXZpY2Vfbm9kZSAqdHJfbnA7CisJCWludCBjb3Vu
dCwgaTsKKworCQl0cl9ucCA9IG9mX3BhcnNlX3BoYW5kbGUoY2hpbGQsICJ0cmlwIiwgMCk7CisJ
CWlmICh0cl9ucCAhPSB0cmlwLT5wcml2KQorCQkJY29udGludWU7CisKKwkJLyogVGhlIHRyaXAg
aGFzIGJlZW4gZm91bmQsIGxvb2sgdXAgdGhlIGNkZXYuICovCisJCWNvdW50ID0gb2ZfY291bnRf
cGhhbmRsZV93aXRoX2FyZ3MoY2hpbGQsICJjb29saW5nLWRldmljZSIsCisJCQkJCQkgICAiI2Nv
b2xpbmctY2VsbHMiKTsKKwkJaWYgKGNvdW50IDw9IDApCisJCQlwcl9lcnIoIkFkZCBhIGNvb2xp
bmdfZGV2aWNlIHByb3BlcnR5IHdpdGggYXQgbGVhc3Qgb25lIGRldmljZVxuIik7CisKKwkJZm9y
IChpID0gMDsgaSA8IGNvdW50OyBpKyspIHsKKwkJCWlmICh0aGVybWFsX29mX2dldF9jb29saW5n
X3NwZWMoY2hpbGQsIGksIGNkZXYsIGMpKQorCQkJCXJldHVybiB0cnVlOworCQl9CisJfQorCisJ
cmV0dXJuIGZhbHNlOworfQorCiBzdGF0aWMgYm9vbCB0aGVybWFsX29mX3Nob3VsZF9iaW5kKHN0
cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp0eiwKIAkJCQkgICBjb25zdCBzdHJ1Y3QgdGhlcm1h
bF90cmlwICp0cmlwLAogCQkJCSAgIHN0cnVjdCB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlICpjZGV2
LApAQCAtMjkzLDI3ICszMjEsNyBAQAogCQlnb3RvIG91dDsKIAogCS8qIExvb2sgdXAgdGhlIHRy
aXAgYW5kIHRoZSBjZGV2IGluIHRoZSBjb29saW5nIG1hcHMuICovCi0JZm9yX2VhY2hfY2hpbGRf
b2Zfbm9kZV9zY29wZWQoY21fbnAsIGNoaWxkKSB7Ci0JCXN0cnVjdCBkZXZpY2Vfbm9kZSAqdHJf
bnA7Ci0JCWludCBjb3VudCwgaTsKLQotCQl0cl9ucCA9IG9mX3BhcnNlX3BoYW5kbGUoY2hpbGQs
ICJ0cmlwIiwgMCk7Ci0JCWlmICh0cl9ucCAhPSB0cmlwLT5wcml2KQotCQkJY29udGludWU7Ci0K
LQkJLyogVGhlIHRyaXAgaGFzIGJlZW4gZm91bmQsIGxvb2sgdXAgdGhlIGNkZXYuICovCi0JCWNv
dW50ID0gb2ZfY291bnRfcGhhbmRsZV93aXRoX2FyZ3MoY2hpbGQsICJjb29saW5nLWRldmljZSIs
ICIjY29vbGluZy1jZWxscyIpOwotCQlpZiAoY291bnQgPD0gMCkKLQkJCXByX2VycigiQWRkIGEg
Y29vbGluZ19kZXZpY2UgcHJvcGVydHkgd2l0aCBhdCBsZWFzdCBvbmUgZGV2aWNlXG4iKTsKLQot
CQlmb3IgKGkgPSAwOyBpIDwgY291bnQ7IGkrKykgewotCQkJcmVzdWx0ID0gdGhlcm1hbF9vZl9n
ZXRfY29vbGluZ19zcGVjKGNoaWxkLCBpLCBjZGV2LCBjKTsKLQkJCWlmIChyZXN1bHQpCi0JCQkJ
YnJlYWs7Ci0JCX0KLQotCQlicmVhazsKLQl9CisJcmVzdWx0ID0gdGhlcm1hbF9vZl9jbV9sb29r
dXAoY21fbnAsIHRyaXAsIGNkZXYsIGMpOwogCiAJb2Zfbm9kZV9wdXQoY21fbnApOwogb3V0Ogo=
--0000000000009e135c062e98a365--

