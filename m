Return-Path: <linux-pm+bounces-16584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4E39B346C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8AA81F228C1
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 15:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3069D1DE4D5;
	Mon, 28 Oct 2024 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Dqd61ePl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A911DE3C5
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128043; cv=none; b=EDSxjqtRQJ28EBY8XZfd0Okp5Ef3dTk9MGuRG1C63EwD90TBdIXfB3xE/n23c2Ec6RI+gP7OYmZ35+H42EoHPQwnOu8sI8/OoLqTKMx2b9i4pOyfZMTsmjiBSORHWHLks60cyGGTKvflNfLraEfARc8I2Sh4yS4ihjMi1nhb4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128043; c=relaxed/simple;
	bh=CimpsCOYMgsWETM1szMTbewpbQ+dQp+1fcyvCiBqs7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmqHD6Z5Nt8Om+/PSbwYZ7cCEDZSB6pvTdIGpfrix9TfZOmDFtG+ZSqOfc/RTourkLrMSQzMDTQoaZ/BrlqRVSPJjuuLF36//6PbaRy7X5nI9PTNyj+eAM+twtNTmwXUDKORhvseIV078nI+ihr1tkv8i7vwtLNeWDlNgibp9Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Dqd61ePl; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e35fb3792eso41227757b3.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 08:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730128039; x=1730732839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6O4jglmADBFdb5cCGurguIuIM8SEZnGdEDSwKFhYFc=;
        b=Dqd61ePlWZ4syzO6eZgvT2dE2MViwItSQmpOWXPd6yGI1Pmn4CMcxU57pnAEel9G8m
         HVJTonJB+uZ1uWhc5sMEyf0P317Ur7ep0TUfPrrS+KILEr2+iB6dub4PJJ+sX+kb4fsQ
         MitfGZoKyjkndo7t1RHfrf2ZZiohAt7UhrMXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730128039; x=1730732839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6O4jglmADBFdb5cCGurguIuIM8SEZnGdEDSwKFhYFc=;
        b=suP4rvAjmqRrsOzvP14oG+KH5SuPzhb8ei7u5mLkHEf5xo8iZRWdtDGuIJ9Q3wBpCK
         jYKvE7OcG0GWUVNBTD+xikQ6COGl53cujw7v8e0nRCtzBmO7Z9wwSThY6JQIuqRqaKZE
         ki6ylQ/uiZBztiM9vvnhFnP/cZivWUPdaPNFHMVgmZBhoQ4w+FYglvaUiVFPxy2EVjm/
         yA+olXrNg9e6Z7K2pWuTorOea25AqVo2dl63T272+RXKHcEpjuWnWPGGjjf0nnU45G/6
         9dHxS7YZuyyhefpxGnPPmEUsU5KTHg63jchVCQ/MFeew4Y0xWzei/90vEPBjRUysuMwX
         54+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzz8HlfXcmqL46nco18oc7Z23apB2iliB7B12PbVpx3cwh55/K3m9mtUnNs2vXLPne0J4h2pT8LQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxpLc8HhJUdN/9TyXyR6S+DgBxsf3e/HbSyqjtMimISIT27pVT
	6SIBIMAUeDjOSttERGq4zmbPHog6YhT9ffCh6bzaR3roO0N7odwpzpkB9JZr4HWBD3E3lhMHp5U
	kYHyQDw68UwonnbAAiZnG/COPMmLh2FDVO+CS1A==
X-Google-Smtp-Source: AGHT+IFqui6wNSxoTwWnJIJHlVatiBkIoXdvwJ0um02G+DFgaufXJo1xlrNhf/8t5iD5prAKnr8XPktd7hAEMwnrgFc=
X-Received: by 2002:a05:690c:12:b0:6af:6762:eba1 with SMTP id
 00721157ae682-6e9d8a42c2dmr78811917b3.20.1730128038855; Mon, 28 Oct 2024
 08:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024094930.3221729-1-dario.binacchi@amarulasolutions.com> <CAPDyKFqqCWt5oCj6qBuP_oZ=O1kmkfMirYETPXEeW-AmiA9P+g@mail.gmail.com>
In-Reply-To: <CAPDyKFqqCWt5oCj6qBuP_oZ=O1kmkfMirYETPXEeW-AmiA9P+g@mail.gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 28 Oct 2024 16:07:08 +0100
Message-ID: <CABGWkvqbiuvBNy2wBT4yVgwP+CY67__+sNxN3vS3Bwss7AwQhA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: fix "sd_count" field setting
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Michael Trimarchi <michael@amarulasolutions.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 2:34=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Thu, 24 Oct 2024 at 11:49, Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
> >
> > The "sd_count" field keeps track of the number of subdomains with power
> > "on," so if pm_genpd_init() is called with the "is_off" parameter set t=
o
> > false, it means that the power domain is already on, and therefore its
> > "sd_count" must be 1.
>
> genpd_sd_counter_inc() is being called when adding subdomains. Doesn't
> that work correctly for you?

In my use case the genpd_add_subdomain() is not called.
I am working on :
drivers/pmdomain/imx/gpcv2.c
drivers/pmdomain/imx/imx8m-blk-ctrl.c

Thanks and regards,
Dario

>
> >
> > Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >
>
> Kind regards
> Uffe
>
> > ---
> >
> >  drivers/pmdomain/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index 5ede0f7eda09..2df6dda98021 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -2221,7 +2221,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd=
,
> >         genpd_lock_init(genpd);
> >         genpd->gov =3D gov;
> >         INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
> > -       atomic_set(&genpd->sd_count, 0);
> > +       atomic_set(&genpd->sd_count, is_off ? 0 : 1);
> >         genpd->status =3D is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
> >         genpd->device_count =3D 0;
> >         genpd->provider =3D NULL;
> > --
> > 2.43.0
> >



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

