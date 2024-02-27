Return-Path: <linux-pm+bounces-4439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 172CF868E6C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 12:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4883D1C24263
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 11:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FFF139585;
	Tue, 27 Feb 2024 11:10:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3AC139589;
	Tue, 27 Feb 2024 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032203; cv=none; b=CbkRgrdbV/AJNgdlNq2Sans+WmDNC5e8UETSHftD0vi7gaYI2VsQe5YHyHL2snGUAhA7QobUa20A2Wp6W8ulv5rP8/XdAaW9Q/HjdE731glsvG7tK9oMWJhSSsj/t8+bJxSgL/nKYQIh6LxryNI5RLf4KrcLw1FN9oe/LZegVXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032203; c=relaxed/simple;
	bh=oUFC+Ms/PGoprdHPfwJASHTgX7mCTMpNsR2R0SvHniw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZELW2Zn87P2QKM4Zpdk93TWe0kektMcHAMMsO/aPxURFmx61c+GYS1TefyZsJQUycSppgir1YIdfz7FzBDt9xN9HJ7yJhUm/+9Y3Z4tv7ToiVGf0+rt+1r1CWzyN+8WkyDg/b1TpBFNWb1AHeQ5ZW+/sA/hm0WZ9TWOp3mWZkL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e45f7c63f4so377484a34.1;
        Tue, 27 Feb 2024 03:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709032200; x=1709637000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58qasL+PjuH6C+4EgXRIPgaJXcrY9WER2jiA7gx3XRI=;
        b=Hd/WKssnBj2Ow/6Dmf74/4qmrk3EFIi5GAZgBmp+rFW6s7MG3sda+gR0zXng3/Lu6x
         u2ZJ9L352R0FW+eeNlwXcFxTG9thYiu4SifmXucv+4tTAeC1IDOo058kGyUONd+Af05v
         31wz0OtXDNk8VRht0HIWN37BF8yjGBF1zXwqcjj2hv+a9D5C+ngEjMOlCVJgLo2seaQ7
         U9tMigXTKFpC5sq1qRCXdfpOQMwCpUvyiDY2c+QT0SX9oU9ZMetlwe9IcDlmnG+FINre
         lAPjRGYHmnMtEDAE+UYdKcMbt+LNS7tlejznR27AEaCdphZgNW6SPMt6V3w+ory0NAIs
         HZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6f5z8veDZgYABIiiobGH1KRm726hCvsf3YYGq2E5s5cpGt4LTpc4Uzpatk6G2+bGIB+jNwqZ8EWsP68JXHwrwKaS0w+/+5xdsDvhflHSYD1deLt+tgADL0pubLiHWHivokLWXl0dfNkQ=
X-Gm-Message-State: AOJu0YxGdByp9tLRqW67BNQZz6mAVtmcq28bEu5QxmfQ0RYlQrVn49Ui
	+jXkoyHro5Ww9rd4j9jWnLRkV7T4GKWKR20SCH5v4DDFLNHxDP+xo4VpSwPTcx9XRBHnCZ987qa
	oIpNeMzwNP4roBlDsPSS+rxH2moM=
X-Google-Smtp-Source: AGHT+IHhkogYh5axZJlkdz39EXpfWA4N1lmL2hWGrLTfQK1CgX8f2AdRQ7BWQZA4oTIjqFYYolsDnWhY+2YEQoRtCZQ=
X-Received: by 2002:a4a:d037:0:b0:5a0:3d13:a45a with SMTP id
 w23-20020a4ad037000000b005a03d13a45amr9157307oor.0.1709032200531; Tue, 27 Feb
 2024 03:10:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226-thermal-fix-fortify-panic-num_trips-v1-1-accc12a341d7@kernel.org>
 <6a6be01d-3453-4268-8b2e-0279cc20835d@linaro.org>
In-Reply-To: <6a6be01d-3453-4268-8b2e-0279cc20835d@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Feb 2024 12:09:48 +0100
Message-ID: <CAJZ5v0h87k6xoi-9V0Cfb2rHQcr-STfG_bNWpzfoj4Dy46U0Lw@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: Move initial num_trips assignment before memcpy()
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Nathan Chancellor <nathan@kernel.org>, rafael@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, keescook@chromium.org, gustavoars@kernel.org, 
	morbo@google.com, justinstitt@google.com, stanislaw.gruszka@linux.intel.com, 
	linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 11:14=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 27/02/2024 01:54, Nathan Chancellor wrote:
> > When booting a CONFIG_FORTIFY_SOURCE=3Dy kernel compiled with a toolcha=
in
> > that supports __counted_by() (such as clang-18 and newer), there is a
> > panic on boot:
> >
> >    [    2.913770] memcpy: detected buffer overflow: 72 byte write of bu=
ffer size 0
> >    [    2.920834] WARNING: CPU: 2 PID: 1 at lib/string_helpers.c:1027 _=
_fortify_report+0x5c/0x74
> >    ...
> >    [    3.039208] Call trace:
> >    [    3.041643]  __fortify_report+0x5c/0x74
> >    [    3.045469]  __fortify_panic+0x18/0x20
> >    [    3.049209]  thermal_zone_device_register_with_trips+0x4c8/0x4f8
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
> >   drivers/thermal/thermal_core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
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
> IIUC, clang-18 is used and supports __counted_by().
>
> Is it possible sizeof(*trips) returns already the real trips array size
> and we are multiplying it again by num_trips ?
>
> While with an older compiler, __counted_by() does nothing and we have to
> multiply by num_trips ?
>
> IOW, the array size arithmetic is different depending if we have
> _counted_by supported or not ?

IIUC it is just the instrumentation using the current value of
tz->num_trips (which is 0 before the initialization).

