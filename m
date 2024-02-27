Return-Path: <linux-pm+bounces-4438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA73868E5B
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 12:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE42EB21383
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0831386D6;
	Tue, 27 Feb 2024 11:07:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B01386B9;
	Tue, 27 Feb 2024 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032078; cv=none; b=dClith0oD1Rf1PzHzdJ2BoPyZ1gx8J9pLhBB26ODkPEbT0lrHNhwrn6yGwJNXqZOsUXYFt9bg3SKl8FMuu388K0Cxz8Yfqk6qydl1+gw0cVlxv1HYjHDAsIL4iQKiVBYpDPLHRmSdD+56fD85PPGmWSSNp7DSdhEMQ3GXT6NVnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032078; c=relaxed/simple;
	bh=34F9Z4iZf+zhWbYhtZNRE0IqJQ27+A+XKn1T0p8dgKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZxwMldgoMFiL+Kcm8DC+/BbvnY5szacs8mcBu6MIuuQTaJSaPSBWROUn42iXZrLsgVeCm7RbBxTbA32QuD4AUTTvAZtneB+5Lp9vBmbDLjSSPrpQia/+ADKEbvo6KB0cPBp17bn4D5KzR5rGYQEk3gP63nBwv90D+deKKGRBb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3be110bbff9so1260473b6e.1;
        Tue, 27 Feb 2024 03:07:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709032076; x=1709636876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skOPLIuxWMEaf7NIrg2gBG0ipla5NBpvoy48o/0tCL4=;
        b=E82dEnb5SnbvQW6AQnG1nMWaERQLA8oY5uaOmG4zQiW82QhNhKFXuHNvTpJNhMDYBg
         m7jHHmHF0pUYw/7lPJcR/VsMqPmeDly5psVmHj5SyRoGJpbgC2zPY6poSuSaBP+hCIwi
         MzWRlTsmcyk7t/NdN1XBeXL82IEfNVvTy5m7dkBkIOK64K/4hrPhpTA76bLvvRMjZQSG
         kjO66EfxxtaEgC5r3uTEaCTjjHIAElT1RVC94ZwQFi/wn7s1twW9WeXcuw+GKQNgdbEj
         vHdLUwMuHkiVfY1R5Oe5VEiYATB+zdunzkMVff753x+fwgdkwEemxs6F4V7wi6GEOy6L
         OcEw==
X-Forwarded-Encrypted: i=1; AJvYcCU5vMsxba8R2XrxZO7AetSTay2xpAQSj1cfT33UmWd1N0+sEhJonoplNADJBO+Dw0+3XvVBCNNm7gCneIPgKK8mWnjj+dZmZSDbeCOthXz1fprpQKI5iDWPKgkfMrwW3nzULx8/PXZyBuk=
X-Gm-Message-State: AOJu0YyKqfovQvBdsbIUvPZuuEwCCE/47ol1pJ+mSD+192rsXkWk+d4R
	AgFmfMZdRsb6gG/bQpXoTLaXF8qsxOyAzs+dgGa2eQGgDtJtglFWnHIXe7hE6QbiI8woAJBgCrD
	uu5zyFYt8sRYabXckOyXRnGbqsaA=
X-Google-Smtp-Source: AGHT+IGkYlkdOebTrB+0a3ntjFHyIn86N1gDBuhwNRPmsGOjLy1F2kZT0BIFzCuMQhVJVW9189Lkoh5I24vW3xNhKcU=
X-Received: by 2002:a4a:d037:0:b0:5a0:3d13:a45a with SMTP id
 w23-20020a4ad037000000b005a03d13a45amr9152893oor.0.1709032075843; Tue, 27 Feb
 2024 03:07:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226-thermal-fix-fortify-panic-num_trips-v1-1-accc12a341d7@kernel.org>
 <202402261806.A8340C71D@keescook>
In-Reply-To: <202402261806.A8340C71D@keescook>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Feb 2024 12:07:43 +0100
Message-ID: <CAJZ5v0gcTZxrgQxbrAFnfEw_Efzud70bg9tVW6Mypu_G6N7hOg@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: Move initial num_trips assignment before memcpy()
To: Kees Cook <keescook@chromium.org>, Nathan Chancellor <nathan@kernel.org>
Cc: daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	gustavoars@kernel.org, morbo@google.com, justinstitt@google.com, 
	stanislaw.gruszka@linux.intel.com, linux-pm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 3:08=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Feb 26, 2024 at 05:54:58PM -0700, Nathan Chancellor wrote:
> > When booting a CONFIG_FORTIFY_SOURCE=3Dy kernel compiled with a toolcha=
in
> > that supports __counted_by() (such as clang-18 and newer), there is a
> > panic on boot:
> >
> >   [    2.913770] memcpy: detected buffer overflow: 72 byte write of buf=
fer size 0
>
> Yay, the "better details" output is working. :)
>
> >   [    2.920834] WARNING: CPU: 2 PID: 1 at lib/string_helpers.c:1027 __=
fortify_report+0x5c/0x74
> >   ...
> >   [    3.039208] Call trace:
> >   [    3.041643]  __fortify_report+0x5c/0x74
> >   [    3.045469]  __fortify_panic+0x18/0x20
> >   [    3.049209]  thermal_zone_device_register_with_trips+0x4c8/0x4f8
> >
> > This panic occurs because trips is counted by num_trips but num_trips i=
s
> > assigned after the call to memcpy(), so the fortify checks think the
> > buffer size is zero because tz was allocated with kzalloc().
> >
> > Move the num_trips assignment before the memcpy() to resolve the panic
> > and ensure that the fortify checks work properly.
> >
> > Fixes: 9b0a62758665 ("thermal: core: Store zone trips table in struct t=
hermal_zone_device")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  drivers/thermal/thermal_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> > index bb21f78b4bfa..1eabc8ebe27d 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -1354,8 +1354,8 @@ thermal_zone_device_register_with_trips(const cha=
r *type,
> >
> >       tz->device.class =3D thermal_class;
> >       tz->devdata =3D devdata;
> > -     memcpy(tz->trips, trips, num_trips * sizeof(*trips));
> >       tz->num_trips =3D num_trips;
> > +     memcpy(tz->trips, trips, num_trips * sizeof(*trips));
>
> Looks good to me; thanks for catching this!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied, thanks!

