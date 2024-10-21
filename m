Return-Path: <linux-pm+bounces-16079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCD19A668A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31A31C21178
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 11:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F941E5037;
	Mon, 21 Oct 2024 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyO5fFB8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50ED198E6F
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729509913; cv=none; b=Qq5qKoXYsqitMer8OsBn41jPadUyyzSDGAbrAoVqxfJskj3Q7PzDRjSwczbKbeYp5+tWv/DgKuPshLVoyib/Z0En00ivyv29PYM4gti3TXRuSy2pyvKDFKn90W9YS+k8fSoGlQADuWbtWjspZrCVIQ8+xI8fNW1UGJXJC4HC1a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729509913; c=relaxed/simple;
	bh=dkMziRQuwM1+e9aIl91xc/6QsKx9OpO5FahTuMFhHhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLKnY3QqbmpsAD+j10b8Bg1eQfkGVuadG9Rgqc7Rf/gJbgh1/ZJ+BAcaQ5Jk5PIA11DXgpI9Pqht/DiuK84bbWXTERqTwhJvL+1yyNNxHHjxopwPfOR+5fEVPovtWPtnj7MrYiW20OQvy4Dw38+jXV2nN4uDy5UUetIyppbfp18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyO5fFB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843ABC4CEC3
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 11:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729509912;
	bh=dkMziRQuwM1+e9aIl91xc/6QsKx9OpO5FahTuMFhHhA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iyO5fFB846GlXYK+wrPzNvaa+8FXjdDhehA+4FfVwERaRC96gQlos5Vx/xPdqV+U6
	 sOQXvkEQPr/QKP7bDhmT9oNn+kqDLQqagi0DZ4Adwdc9artMLoEJay3bPz3jZXFsJC
	 cQfRWoyhz85tNsPhRTtdcb3W18i3rFXzuhGzmc1HF6PwQ/atI+mIE6+xIYkQIEpGvP
	 1AuzhE05+rdVJz5AAxRlOAMWxTdKkQGkkQQT1QM9Xg5bvC5zgOZ9bn4Kdcj3vRUVc0
	 Sywqyu8NltREiY0B3unmXVj7akPRqvgKUIg0sh2aTcawEM7W1AeNO9kgRGBMcBKYbU
	 1LHoWRWGDYaMg==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2884a6b897cso2025389fac.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 04:25:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgljbSymsBBKfzzSwtizT0ogK9C+nQgDG89Z101cTvGK0CCv7ZsThzikjjtTvpRblhhx2T6zM0CQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT8aAdQ4/XI3u2EUFshJeldQbZikZqiYfRKB8beXmQI1G4wOdh
	WbwNa7HCtduPpWUjvvYJicWKzyClcNhjDArfuXhmnaKHPPO/I8CSXnNHvMEpZZ5I2j91I4gXRZT
	dl3tR6hUUDX2beVlJh8J5MebxJqE=
X-Google-Smtp-Source: AGHT+IFO9ySmzQAO+Ftl1R22wPOby6uIn5xeSZw64xmiXTVraPi/nsQEC97ewaqPr3E8VBmpGEIn1eJimVBtCfhmdM4=
X-Received: by 2002:a05:6870:d202:b0:27c:a414:b907 with SMTP id
 586e51a60fabf-2892c49e923mr8762418fac.33.1729509911774; Mon, 21 Oct 2024
 04:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018021205.46460-1-yuancan@huawei.com> <c13e95ff-649d-4a43-a899-8f0088f3fc7f@arm.com>
In-Reply-To: <c13e95ff-649d-4a43-a899-8f0088f3fc7f@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Oct 2024 13:24:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hx1d5TJCQ9yrghtniUn1xhZrMouXzj60iaitHxw2S0xA@mail.gmail.com>
Message-ID: <CAJZ5v0hx1d5TJCQ9yrghtniUn1xhZrMouXzj60iaitHxw2S0xA@mail.gmail.com>
Subject: Re: [PATCH] powercap/dtpm_devfreq: Fix error check against dev_pm_qos_add_request()
To: Lukasz Luba <lukasz.luba@arm.com>, Yuan Can <yuancan@huawei.com>
Cc: daniel.lezcano@kernel.org, rafael@kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 10:23=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
> Hi Yuan,
>
> On 10/18/24 03:12, Yuan Can wrote:
> > The caller of the function dev_pm_qos_add_request() checks again a non
> > zero value but dev_pm_qos_add_request() can return '1' if the request
> > already exists. Therefore, the setup function fails while the QoS
> > request actually did not failed.
> >
> > Fix that by changing the check against a negative value like all the
> > other callers of the function.
> >
> > Fixes: e44655617317 ("powercap/drivers/dtpm: Add dtpm devfreq with ener=
gy model support")
> > Signed-off-by: Yuan Can <yuancan@huawei.com>
> > ---
> >   drivers/powercap/dtpm_devfreq.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_de=
vfreq.c
> > index f40bce8176df..d1dff6ccab12 100644
> > --- a/drivers/powercap/dtpm_devfreq.c
> > +++ b/drivers/powercap/dtpm_devfreq.c
> > @@ -178,7 +178,7 @@ static int __dtpm_devfreq_setup(struct devfreq *dev=
freq, struct dtpm *parent)
> >       ret =3D dev_pm_qos_add_request(dev, &dtpm_devfreq->qos_req,
> >                                    DEV_PM_QOS_MAX_FREQUENCY,
> >                                    PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
> > -     if (ret) {
> > +     if (ret < 0) {
> >               pr_err("Failed to add QoS request: %d\n", ret);
> >               goto out_dtpm_unregister;
> >       }
>
> Good catch thanks!
> Indeed in the doc of that API there is '1' as return value.
> I will check other places of that QoS usage.
>
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Applied as 6.12-rc material, thanks!

