Return-Path: <linux-pm+bounces-30364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAC6AFCAB2
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 14:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB466480198
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 12:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7302DAFB4;
	Tue,  8 Jul 2025 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ne3SNLi2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A732DCBE0;
	Tue,  8 Jul 2025 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978656; cv=none; b=RuhPL1x9itYycvoXbRdlRBxu9S2zkGPWbAbQ2wkB9PiAGM9pkniRWs2QdyKhDF4zNQC3emCZmr3ysxFKJp5bdO6fve479OL8hhIkSa4f4y3gm6AIzS6fcYmRqQU1fHdPzJ9C8avdKZ2/vwOfUV7Ga7W/fNBEC6AN8PjYcTECMO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978656; c=relaxed/simple;
	bh=Tfq6U9j3UqtDfuImMpaxdIa3wUmTSJFPDtlgJI3oLKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUz1KLi5EdCRbHiO/ry2cs+qiDQF40kHU0GELYRHHrP6jjw6fZ3ADPqgjffogz501Y/DcuOq83IPJgzq3hSbU8gaKkjhpleJaGJftWmKgyOe9kLDY2pja7TeLuH+Z1Lgi1DyZXQ7OfRo73m1VNGwraRSrTex68TtvtQ9QAj0/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ne3SNLi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD58C4CEED;
	Tue,  8 Jul 2025 12:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751978656;
	bh=Tfq6U9j3UqtDfuImMpaxdIa3wUmTSJFPDtlgJI3oLKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ne3SNLi2KURMWTu07rcIAWc8sqRtOXf/Eb7kyS83XtQDJODtUXtYakJ/KvxWcOzRD
	 C0wxqJ4Z6sB9JULinQ+dqlwO1r9ufTuzfXw5canRblvgxSnrGHcTS8Q+nGI1CFYaYA
	 LCgVNkslCnVoNrRri+zpEgMNqNBh5XuP7XmL6z3942gn9U5jVFZ6MdMHSXFa4kgEGk
	 wrV7iEr5Kgf90e/YH3GJNPjdVe3TRCyfuEabaxSJXZyhyAn2tQ+qfmXtdOuZSUjyov
	 r1ajO5qB+hd67Nx3bWyv/2RceuIDqDTUTYmx2PTRzakA9sPgRyWDlgyc/PJH2Ml5zW
	 Pv4Tf4HQE5kuw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61208b86d75so2327606eaf.2;
        Tue, 08 Jul 2025 05:44:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXIsJs7YitaKOlB6dCUUmekrWYqLtIkHS8PMhziX1hxAVm8vIiABZMK70l3dUDc5G2hFhX2bB/@vger.kernel.org, AJvYcCX5UNPdfBjhp8xq93Q88QRCeGHSb2Dkt+g4/ca8mpmGlZwIGkPRBO5psryGOz6MYj/WYdO9iTyXdZcdAIQ=@vger.kernel.org, AJvYcCXN+vkWlsSm/lTJSez6r2STsi1m1wL350heHueDr9UHjgYEz8lbkcKtg+vcV4vOS1kp06IKbhq59no=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlB5p/1MBRa/n8Vj8EoVqSquSp+rYMeps3vCgsgRYIrW8vJdzR
	iYpQmunwRyOBYMsQGnhlWjANcQT+66G2bq4EsLT5UOdLAe1c4Q9RiVM7InIPS22EJZCEAh8dbGh
	W3vb/aHLUrPoiWEz/C7BTqpYhEhNrZQE=
X-Google-Smtp-Source: AGHT+IH84OmBbX2dpd1EJzzLz8MdrM74HLsLpl03lVZpvjZ4f1+6Nks9HDT+/xp4+wjfAkr/Xl8/PWTSugHyt1l7Z5o=
X-Received: by 2002:a05:6820:1792:b0:612:c547:7984 with SMTP id
 006d021491bc7-613928f68f4mr10686972eaf.1.1751978655467; Tue, 08 Jul 2025
 05:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-trip-point-v1-1-8f89d158eda0@chromium.org>
 <CAJZ5v0gOm4-qmAGGswk9nuPb45UGabNK-DqkcZEGmTO71tRLkQ@mail.gmail.com> <CAHc4DNK2_=81j-q4+1vsM9uyWJJ89dH4y2u_H5ie671umyNWxg@mail.gmail.com>
In-Reply-To: <CAHc4DNK2_=81j-q4+1vsM9uyWJJ89dH4y2u_H5ie671umyNWxg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 8 Jul 2025 14:44:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gAL0-OWZJd4tA-vTTrVVFzr7TK2uxES27U+uDvpBnH5w@mail.gmail.com>
X-Gm-Features: Ac12FXzA8wSnG6HTf8bMeQQzyX235KIL7T09DnPO2I3g82KkYeVYuqQZ7uns0No
Message-ID: <CAJZ5v0gAL0-OWZJd4tA-vTTrVVFzr7TK2uxES27U+uDvpBnH5w@mail.gmail.com>
Subject: Re: [PATCH 6.6] thermal/of: Fix mask mismatch when no trips subnode
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 8:41=E2=80=AFAM Hsin-Te Yuan <yuanhsinte@chromium.or=
g> wrote:
>
> On Tue, Jul 8, 2025 at 12:57=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Mon, Jul 7, 2025 at 12:27=E2=80=AFPM Hsin-Te Yuan <yuanhsinte@chromi=
um.org> wrote:
> > >
> > > After commit 725f31f300e3 ("thermal/of: support thermal zones w/o tri=
ps
> > > subnode") was backported on 6.6 stable branch as commit d3304dbc2d5f
> > > ("thermal/of: support thermal zones w/o trips subnode"), thermal zone=
s
> > > w/o trips subnode still fail to register since `mask` argument is not
> > > set correctly. When number of trips subnode is 0, `mask` must be 0 to
> > > pass the check in `thermal_zone_device_register_with_trips()`.
> > >
> > > Set `mask` to 0 when there's no trips subnode.
> > >
> > > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> > > ---
> > >  drivers/thermal/thermal_of.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_o=
f.c
> > > index 0f520cf923a1e684411a3077ad283551395eec11..97aeb869abf5179dfa512=
dd744725121ec7fd0d9 100644
> > > --- a/drivers/thermal/thermal_of.c
> > > +++ b/drivers/thermal/thermal_of.c
> > > @@ -514,7 +514,7 @@ static struct thermal_zone_device *thermal_of_zon=
e_register(struct device_node *
> > >         of_ops->bind =3D thermal_of_bind;
> > >         of_ops->unbind =3D thermal_of_unbind;
> > >
> > > -       mask =3D GENMASK_ULL((ntrips) - 1, 0);
> > > +       mask =3D ntrips ? GENMASK_ULL((ntrips) - 1, 0) : 0;
> > >
> > >         tz =3D thermal_zone_device_register_with_trips(np->name, trip=
s, ntrips,
> > >                                                      mask, data, of_o=
ps, &tzp,
> > >
> > > ---
> >
> > If this issue is present in the mainline, it is not necessary to
> > mention "stable" in the changelog.
> >
> > Just post a patch against the mainline with an appropriate Fixes: tag.
> >
> > Thanks!
> `mask` has been removed from the mainline, so this patch is only
> applicable on old branches.

So the way to go would be to follow the mainline in those branches.

