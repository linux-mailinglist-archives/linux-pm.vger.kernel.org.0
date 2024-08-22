Return-Path: <linux-pm+bounces-12713-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C56C095B27B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 11:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB391F21D55
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 09:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DBC17A588;
	Thu, 22 Aug 2024 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehP8tu0q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438F1CF8B;
	Thu, 22 Aug 2024 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320786; cv=none; b=POBf1eSH/S2minw/thPOhIDqSNLVtebcq5RAeSAO5gNImZrcx/vwY4TKrrYME9cXDbeUGLBMTuMTK6bZyTSJlAU68vDOaHyOnjYNwRKS2fKSdTjm3rJFk3LgJa9t2MhkHSGUnsb8nD2HI15HYKLSvWVq1N24xjmHf3e52cTcSqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320786; c=relaxed/simple;
	bh=XPMNw3U+6wApPUyGdg6a+638oZGYyHMVxSjcK8CMYGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0GSDWfW22oLZ7cZZZ26J28OyJdH3DrcdSqtGmDYFrEg3qIykJtBlT+4c/XPtWleqBENmvZ/2bgJnzYzgt3HCvulcrluJT34HF7PhPPK9A0gMZ7S1eBJkEB6vei1jUMhvhDE+p71l2Lkq0Gg+K4rw0nGHCes6NPfKBwwg8imWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehP8tu0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AD0C4AF0B;
	Thu, 22 Aug 2024 09:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724320785;
	bh=XPMNw3U+6wApPUyGdg6a+638oZGYyHMVxSjcK8CMYGE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ehP8tu0qTx3ycdTbkfgV1nQx2RUd+XBVWKY9jCPKwBNYyTIivmkvShOJqBpuYHt1f
	 cGVA9WRCk99GKKNGWB3DYoCzqHuASxyi5BI+2kc77cGjiTWbHZQtxN34NRR1QoE/1S
	 XRMSBlWv+X5LSqTI+WxdeL5WfzemupYoK3WIWrhOE2EO4EgmQviTk6yjONdL5C/LEQ
	 UbFTmVJ2FAmNJtKsr6D1LT3u/zQfhzy3LHoZlR0rgyLm7qvLhQX6F0cyBGKMSvOQoV
	 4xjcoF6M043EIqMLpXegMiZ1RoMOKpGpWCkqrE68avD9gzYIz9PeyYfzkXT4er28Xx
	 oX6WAI6WkrksA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-27020fca39aso402078fac.0;
        Thu, 22 Aug 2024 02:59:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGw96+0/r7w44OoM+aJv5Q/Wul7ZLUOAgNqNPvVkzyljBID7r8bh4HYpwx+xqYSsIbC3x/2FiSXLMLQsM=@vger.kernel.org, AJvYcCXD/h8KNqOlnC3WtpuZ4exjPibIzEufGA5wg/btd7v8ZcMu6z85wGRnibT/MPrDyXmGkxBL8lts2qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzfIebsWd22Yu+Gl5rFChx08yDR9/zcbN7Y6rLcpcGnuhQPgtv
	OOvATIsAeuaEA2QvQOxmS7avz9EQ2mvZaouW09A7rSOQw3xIkLVKQ225ShjaSc833+hScvSiI0j
	pelixT/do8h5J/+SWPFs0ohrlPZI=
X-Google-Smtp-Source: AGHT+IFwBOLZWp2Ctcuruy/52HSq8Owqpqi3w4sqr08hPHh5byfuEFeKi2n1eTxr3CVp7KiAZtrNQ/F92vf83zlSqwA=
X-Received: by 2002:a05:6870:649f:b0:254:b420:5ab with SMTP id
 586e51a60fabf-273cfbaaf89mr1216464fac.8.1724320785061; Thu, 22 Aug 2024
 02:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822025931.3455-1-11162571@vivo.com> <CAJZ5v0jq_2RoH8qJjKn3UUxLgNn4o4RqB=cfnT_pEFqtcMDdsw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jq_2RoH8qJjKn3UUxLgNn4o4RqB=cfnT_pEFqtcMDdsw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Aug 2024 11:59:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h8std0JijjjTskTP2p1jubYQvsCmm30OVmNuj_S8QrqQ@mail.gmail.com>
Message-ID: <CAJZ5v0h8std0JijjjTskTP2p1jubYQvsCmm30OVmNuj_S8QrqQ@mail.gmail.com>
Subject: Re: [PATCH v1] drivers:testing:Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
To: Yang Ruibin <11162571@vivo.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 11:43=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Thu, Aug 22, 2024 at 4:59=E2=80=AFAM Yang Ruibin <11162571@vivo.com> w=
rote:
> >
> > The debugfs_create_dir() function returns error pointers.
> > It never returns NULL. So use IS_ERR() to check it.
> >
> > Signed-off-by: Yang Ruibin <11162571@vivo.com>
> > ---
> >  drivers/thermal/testing/zone.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/testing/zone.c b/drivers/thermal/testing/z=
one.c
> > index fcee12b152da..26f0f80a6a5d 100644
> > --- a/drivers/thermal/testing/zone.c
> > +++ b/drivers/thermal/testing/zone.c
> > @@ -167,7 +167,7 @@ static void tt_add_tz_work_fn(struct work_struct *w=
ork)
> >
> >         snprintf(f_name, TT_MAX_FILE_NAME_LENGTH, "tz%d", tt_zone->id);
> >         tt_zone->d_tt_zone =3D debugfs_create_dir(f_name, d_testing);
> > -       if (!tt_zone->d_tt_zone) {
> > +       if (IS_ERR(tt_zone->d_tt_zone)) {
> >                 tt_zone_free(tt_zone);
> >                 return;
> >         }
> > --
>
> Thanks for catching this, but I'll just redo the patch while it is still =
fresh.

BTW, which tree is this patch against?

This issue has been addressed in my linux-next branch already AFAICS.

