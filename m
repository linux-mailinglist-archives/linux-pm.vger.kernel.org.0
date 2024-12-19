Return-Path: <linux-pm+bounces-19523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C04E9F7D55
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 15:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39DF1672EC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 14:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB368632D;
	Thu, 19 Dec 2024 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TcEqdfqa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B0878F2A
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734619763; cv=none; b=SAcEF+CWcFR89LT69jui3DjYVakLwr6oq+8gO2iBsvYYekxUX1douZ1hx/dfWKQJ1WF3pP8fbWtMQtjTvLyHn6ICdpB4J2z+CS4S4l7dZP7di2NbDNHB9eEvxa6ybRVNZyiGq+EAmzR7jaK4CM4gJEr4dgLXOGftmRXwDT9H/No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734619763; c=relaxed/simple;
	bh=eGIwgTmk4hUIOV5cxG3XKmB6DfX9AYEvr/rbSHDj5lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4yNzFviiDj7IHhIRcoBkNkvFIt3pwbLfsGkd5CKf2sgLkvU1Nc/ydRdvs44LkwpKJkyMWxDDlFvDQdeeAvRWMGTX/50BCRFixFnrH3V40Iko4UMn+gYyzdAoIeFHFXGx0pDSgY3RD/NO/x4HHFo9czKKfPdIOE6DZlbrfhQ3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TcEqdfqa; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6eff5ad69a1so7599617b3.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 06:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734619760; x=1735224560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5c2sUd+IyRgXR8XMvLXUS0hCl0qB7C9Mpgm46b5w+TM=;
        b=TcEqdfqaS/ntAulRzuc59MvEUXXUVwvpp1jD9FvcuhorX8/C/qRlIyY5lbapbuH8mW
         QLuoz1whssXlR0n+17Of0xMHVXob3qMF2Tm9PCjHSglg55tYvo7eJDrchDylOfEqlPl+
         gkWIhuZ2IPRx0iBK/ZquIDHfQihpc0X3bbAfDrFDIr5QOIo/C8oj+cSmF2SJgsiQrKXI
         qXyof0tg2ZnhR1kURu/715ArCWPIOLk5KA7G2HSzHzcoSXxt8uTf5+cW+PeDP+R3hdOF
         CgPrd9FrAOMlYQxqBzTQYcK9xHFV+klB+AL4jb06AxzuvhQK9iFK38hF/4mWynxbWUPU
         QF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734619760; x=1735224560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5c2sUd+IyRgXR8XMvLXUS0hCl0qB7C9Mpgm46b5w+TM=;
        b=ijZGkjkTn3WtrD4W9Wlap9/WeeUERM1+3wcbHpHAi7BAkWIvVW00WbfnAalNwSO6QZ
         04Ri0x7GZJNUvLosxddes0xGQZW3k/uINUYOcFN3LwTL9jEqxlaECQMS4zvZeBdjq1a6
         Z4pd7+yQ+sIh/lMfBe3cdNeKOpnDBGmIHZ5yROowR0eGUXhVV7F+lNwxW9gOeiqJkIzs
         P8+g0bHU4npkdU9RMEzFxuhhMi/7JziXljSDCU7zGZRWY7f7ucOTuAUJbfhwUZrEMnqe
         r+dqqCupwosBCl6hxGVXYd3j4SQeJqV7lO+3IlSk0OBmSIWTErauHtge8Xk/PrlvSmRu
         zGKw==
X-Gm-Message-State: AOJu0YwgVva2DvMPCGLQ+KcRW7KqalOuAhb3y2cAA2ATYextt6OSVHEM
	JlpOkpPzg8lvw257UdmEGgVsCqnl0h5RD51tuZZPWml60WWhPLd3lAd5tuiRIOv6Tdmf2hjJxaB
	agplSh4SglBqbaBz7bBvtDPozpIhMP8MOPprbuA==
X-Gm-Gg: ASbGncsPA/rPzuE+HUyP6o9WipYK+mffqBf10IcqqgfuO/uo5ugNILUcacXtGRNNhuo
	kOUVYAB+HigvVwOW81ItQLcuIWHEc74R1RV0EkXI=
X-Google-Smtp-Source: AGHT+IFpdLg3h59XvwZH8HVSCufTXZJvSj8/IZ5bC6xZe8zuPKIdWjdv9d4IorRrr65O789ozMuTkduYAFZwuC56z0k=
X-Received: by 2002:a05:690c:4d01:b0:6ef:a187:f3a3 with SMTP id
 00721157ae682-6f3d26918c4mr53083267b3.27.1734619760358; Thu, 19 Dec 2024
 06:49:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218184433.1930532-1-l.stach@pengutronix.de> <CAPDyKFoeebzUkmeya4WEcdc+px-=8rwSGdmF_-1giiwkHvWo5Q@mail.gmail.com>
In-Reply-To: <CAPDyKFoeebzUkmeya4WEcdc+px-=8rwSGdmF_-1giiwkHvWo5Q@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Dec 2024 15:48:44 +0100
Message-ID: <CAPDyKFp8jvEDGfkuMzzSVSo2gDtf+naC3QwXrCJD7t1e8wPJFQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: add dummy release function to genpd device
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-pm@vger.kernel.org, kernel@pengutronix.de, 
	patchwork-lst@pengutronix.de, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Dec 2024 at 15:40, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 18 Dec 2024 at 19:44, Lucas Stach <l.stach@pengutronix.de> wrote:
> >
> > The genpd device, which is really only used as a handle to lookup
> > OPP, but not even registered to the device core otherwise and thus
> > lifetime linked to the genpd struct it is contained in, is missing
> > a release function. After b8f7bbd1f4ec ("pmdomain: core: Add
> > missing put_device()") the device will be cleaned up going through
> > the driver core device_release() function, which will warn when no
> > release callback is present for the device. Add a dummy release
> > function to shut up the warning.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> > It's a bit unfortunate that the genpd even needs to have this
> > not-really-a-device just for the sake of the OPP lookup.
>
> Right. Although, I have patches in the pipe that will make use of it
> that isn't limited to the use for OPP.
>
> > ---
> >  drivers/pmdomain/core.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index bb11f467dc78..83659d79e07d 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -2142,6 +2142,11 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
> >         return 0;
> >  }
> >
> > +static void genpd_release_opp_dev(struct device *dev)
>
> The above said, would you mind changing the name to
> "genpd_provider_release". Or something along those lines.
>

Well, it's kind of trivial so I just amended the patch when applying.
Thanks for fixing this!

Applied for fixes and by adding a stable tag.

Kind rergards
Uffe

