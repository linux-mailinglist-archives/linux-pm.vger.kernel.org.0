Return-Path: <linux-pm+bounces-38267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DC7C72454
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 06:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D6924E4B9C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 05:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDAE2FE567;
	Thu, 20 Nov 2025 05:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6O44Yxx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EC22EACF9
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 05:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763617424; cv=none; b=AWyqLjfZ7ytFAIygy+ZOrSoHisAqtUwh8Czh7u/Xo4WqnpgSTc04g5Aw2qnQmDw4jQaTFjf+al7hKbGhvTHWzj7/D9uo4stCxoQOcTBs7QjSrfbn36BVsbxCRCzFg9LkUT1tn11uKEmzrJYw3f0FvC9AwlmXU2uyZs1ORqPl7pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763617424; c=relaxed/simple;
	bh=U151xLR0xAbp8Zo/f8OZp+wJyqHL+orqzWpyvMTDORI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWSKL7jWpvKtehbw/lur7DdOU3SB+xjwXGwFk7JPQz8AEF4++5TykE8PjhkPjFIZ/hh3mAM4sU2fhnXfAKD5ulf3q7vC2jB7VOCvUzzhNZrdb0gcxvaM4ITedO6OSu+CYQqZH/x9flHhUlp42ZDdbzNnLPPg5OX42+hWC2cxqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6O44Yxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1302EC4CEF1
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 05:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763617424;
	bh=U151xLR0xAbp8Zo/f8OZp+wJyqHL+orqzWpyvMTDORI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K6O44YxxGHucoYJywyHTWI+nWElJj3pqZ+hnRJMbLzQCS/H+Rr+mm/0rHaIWuwMt+
	 bTkEj1/MTRvYTqg+ZEbGYyOy1F0b3prjBS4kFzx8elZ5z0Fas1A+v7vsaz6UXtW60I
	 lF0T0Yq6EqUVRf6vErtbnzJcfgKCs4RnntchfEbTkD94StIwRbcg2bAbCOnUHsSTeh
	 8OwxdiMgexCrqa1LA/3ukpOgfs+MTfUyD4ajdq6gBzzt4cnDI4yMGMGBcC+sJl159W
	 W48qg6iqR3/kcQwbW6tDC1RveFoKlFL57xETEMEjcexMnjq5oCtp4iiENE1hJDxnkJ
	 084bE9/oIMvHQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-65745a436f7so192273eaf.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 21:43:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXaTLiCbhRCzVzTlrZv2JqQ0UsAkvG44SVFq3A37SuzWIKdMwj5//jHZMDbGn/C4J+4K7PV/nAZFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YztEZzqtG1wggJCXSnxAKULwrGuNYUrbBEjCnLEB3aUlKuMeLhP
	bgl4gbe+hn0eqb6ru/Vwo9ssAKip3AGG7JL7GiHItEKiC5oL2UtjHb66kvcPK0mBixlgXoFP5ci
	GIvOzpNy1eiaxemc1WHnKo99JeeT/3EU=
X-Google-Smtp-Source: AGHT+IEAeyg4SW3jKUp/mX+B30LN6w98qmIV7dpZ7HDxEGQT//P0jNQnVxfc0A7w7ZL6BUK9lekoNpoq5nnZxovnGjU=
X-Received: by 2002:a05:6820:2d8b:10b0:654:f9a7:76dc with SMTP id
 006d021491bc7-65787f3daefmr252556eaf.4.1763617423480; Wed, 19 Nov 2025
 21:43:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915062135.748653-1-zhangpengjie2@huawei.com> <5be41a73-9afc-4c70-b77d-f89630aa83a3@huawei.com>
In-Reply-To: <5be41a73-9afc-4c70-b77d-f89630aa83a3@huawei.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Thu, 20 Nov 2025 14:43:10 +0900
X-Gmail-Original-Message-ID: <CAGTfZH2nK9OU5Q63LCATkNgts4R-NOZyPr_eJQHYpPupDFNYrw@mail.gmail.com>
X-Gm-Features: AWmQ_bkUlSuonOtQflKSBf_3-FrPBA8CRRfk9R381s8AC3dcrb_uKDGVf773tZ0
Message-ID: <CAGTfZH2nK9OU5Q63LCATkNgts4R-NOZyPr_eJQHYpPupDFNYrw@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: hisi: Fix potential UAF in OPP handling
To: "zhangpengjie (A)" <zhangpengjie2@huawei.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, lihuisong@huawei.com, 
	yubowen8@huawei.com, linhongye@h-partners.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm sorry for late reply.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

If you need to apply this patch to other git repository with some
related patch, I agree.

Thanks,

On Thu, Nov 20, 2025 at 10:31=E2=80=AFAM zhangpengjie (A)
<zhangpengjie2@huawei.com> wrote:
>
>
> Hi All,
>
> This is a friendly follow-up on this patch.
>
> Given that everyone is often busy with various tasks, I wanted to make
> sure it doesn't fall through the cracks.
>
> Thank you for your time and review.
>
> Best regards,
> Pengjie Zhang
>
> On 9/15/2025 2:21 PM, Pengjie Zhang wrote:
> > Ensure all required data is acquired before calling dev_pm_opp_put(opp)
> > to maintain correct resource acquisition and release order.
> >
> > Fixes: 7da2fdaaa1e6 ("PM / devfreq: Add HiSilicon uncore frequency scal=
ing driver")
> > Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> > ---
> >   drivers/devfreq/hisi_uncore_freq.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/devfreq/hisi_uncore_freq.c b/drivers/devfreq/hisi_=
uncore_freq.c
> > index 96d1815059e3..c1ed70fa0a40 100644
> > --- a/drivers/devfreq/hisi_uncore_freq.c
> > +++ b/drivers/devfreq/hisi_uncore_freq.c
> > @@ -265,10 +265,11 @@ static int hisi_uncore_target(struct device *dev,=
 unsigned long *freq,
> >               dev_err(dev, "Failed to get opp for freq %lu hz\n", *freq=
);
> >               return PTR_ERR(opp);
> >       }
> > -     dev_pm_opp_put(opp);
> >
> >       data =3D (u32)(dev_pm_opp_get_freq(opp) / HZ_PER_MHZ);
> >
> > +     dev_pm_opp_put(opp);
> > +
> >       return hisi_uncore_cmd_send(uncore, HUCF_PCC_CMD_SET_FREQ, &data)=
;
> >   }
> >
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

