Return-Path: <linux-pm+bounces-32659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CEEB2CCCF
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 21:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD46561C63
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 19:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ECD2BD586;
	Tue, 19 Aug 2025 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADXwe4W/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E058B267B92;
	Tue, 19 Aug 2025 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755630893; cv=none; b=U4OP9Ji7fFqZauPdij5G4YgcfQ4Lsi3zRMUzhbzd2ImmOElb3ByuBVuwEW783EtdbjO9toSZIkeUUVjfp5VRRHGSYNSBs9VeA8LK2xIHPhM3cno0CCeyRTVtkmlnbnuDr3q3mpQ16RRmp/ZzG7Fxl6X3MK9OKyS30hjAs2pHwxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755630893; c=relaxed/simple;
	bh=4/s8xNZ5bTBdSs6dpyVi5IutaYwPzwD7ky+ZoTEzoAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGP5ndltOiw3UOjIUd/GMpRZkWnVdzMvEzkQVuIy247Tz85xtCCnWU8+fDPlxJBj7F6kB0ixaTPXOPTR3WfgUk+MVAC/u9JGVl9qu8Nqyuwf/n7/aTIWOVhJq+zNmWwGZ2QY5vQnnH+oHZy9BTNtyrX+SsN+3myxTsLUAMbYO0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADXwe4W/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E93DC113D0;
	Tue, 19 Aug 2025 19:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755630892;
	bh=4/s8xNZ5bTBdSs6dpyVi5IutaYwPzwD7ky+ZoTEzoAs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ADXwe4W/ot3F99l4ZxlbiXGWD5NSvgdsvtsLuxI12Ln501dDv6l+wyU0wCOSa6INo
	 2/dq8CNSggWpFe4JrFe8GNM+LjplznBBXI4T+5OGa/D2YRf5RNBUFt0j4XLnlwbjkL
	 5oIK2tObiHJY7Ynt7AtNIfg1u3mZ74DHzOE9gf7YsdTnDDOyM9nveJjw7ADOMTW8mV
	 jbylsTLj796GAjyXS0JARQvBe2ZkB7eMD+L0awZ6ywMqRTEV6nB2Y4JD8uBEzUi2Sz
	 jyCst54mbuwVHueEG6GsJYcymWf93BttEpJthemqgOX7gplNThjWpqdxN92C/6tBFj
	 FrpRO0ihRZ66w==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-30ccec928f6so1695450fac.3;
        Tue, 19 Aug 2025 12:14:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkqVb3xfoOK2xj1nNDN2zDg2gZFecUaPG0epv3tsTzeYCBr7TBu3B/1gPpQANqTNowdqHwJWT+YZ+KuGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaGIlxbwrT/wUl3QN7Lmva4Uo3oZCH9bq7s578MdhZRVAlwonA
	zGYD0WMm3IEJycN1bn2ziTkpSxkBuzOirLyh3ISlvlCPN8kV3IwzK8E6V80v4a+tTrXhAvK+REe
	F2dZac9haRns0A6oJUHRCRYcP5KVlBs4=
X-Google-Smtp-Source: AGHT+IGiYMInwqWHg131MPxkjIautzcqE3GH7L95CvF16VCUpAmZpF6gLW6ob6nZMlPk3nsNXT16aijHecwPlFQPnI4=
X-Received: by 2002:a05:6870:2dcb:b0:2ff:a1b9:881d with SMTP id
 586e51a60fabf-311229eeda6mr105799fac.36.1755630891791; Tue, 19 Aug 2025
 12:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725041450.68754-1-zhangzihuan@kylinos.cn> <fb4b7ce4-e273-4622-abe2-31610d5da531@huawei.com>
In-Reply-To: <fb4b7ce4-e273-4622-abe2-31610d5da531@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Aug 2025 21:14:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hj74fK3u6AN_zTKUAROogCiVySH3HnMxvyUg=P6xAdvA@mail.gmail.com>
X-Gm-Features: Ac12FXzQWqPjPKHwIrndbdWpcXOoSLeDVksgUgzz-ZDAZ4eIImpzqD-2WDFXoF4
Message-ID: <CAJZ5v0hj74fK3u6AN_zTKUAROogCiVySH3HnMxvyUg=P6xAdvA@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: Avoid get_governor() for first policy
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, Zihuan Zhang <zhangzihuan@kylinos.cn>, 
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 11:11=E2=80=AFAM zhenglifeng (A)
<zhenglifeng1@huawei.com> wrote:
>
> On 2025/7/25 12:14, Zihuan Zhang wrote:
>
> > When a cpufreq driver registers the first policy, it may attempt to
> > initialize the policy governor from `last_governor`. However, this is
> > meaningless for the first policy instance, because `last_governor` is
> > only updated when policies are removed (e.g. during CPU offline).
> >
> > The `last_governor` mechanism is intended to restore the previously
> > used governor across CPU hotplug events. For the very first policy,
> > there is no "previous governor" to restore, so calling
> > get_governor(last_governor) is unnecessary and potentially confusing.
> >
> > This patch skips looking up `last_governor` when registering the first
> > policy. Instead, it directly uses the default governor after all
> > governors have been registered and are available.
> >
> > This avoids meaningless lookups, reduces unnecessary module reference
> > handling, and simplifies the initial policy path.
> >
> > Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> >
> > ---
> > Changes in v2:
> >  - Fix the case where the governor is NULL.
> > ---
> > ---
> >  drivers/cpufreq/cpufreq.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index d7426e1d8bdd..1aa559f53479 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1122,7 +1122,8 @@ static int cpufreq_init_policy(struct cpufreq_pol=
icy *policy)
> >
> >       if (has_target()) {
> >               /* Update policy governor to the one used before hotplug.=
 */
> > -             gov =3D get_governor(policy->last_governor);
> > +             if (policy->last_governor[0] !=3D '\0')
> > +                     gov =3D get_governor(policy->last_governor);
> >               if (gov) {
> >                       pr_debug("Restoring governor %s for cpu %d\n",
> >                                gov->name, policy->cpu);
>
> Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>

Applied as 6.18 material, thanks!

