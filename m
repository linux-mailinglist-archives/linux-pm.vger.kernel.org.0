Return-Path: <linux-pm+bounces-22703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CC1A4036C
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 00:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDFF3B11F1
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 23:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757D72063ED;
	Fri, 21 Feb 2025 23:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J39rPdS3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975B817CA17
	for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 23:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740180339; cv=none; b=pJ2ad0xaCrnwhdgM6vdriDpS6100A/768cFxlRLKGooQ6JdIRIo88R0JyBsxmizaChY3nAXwPNTgVPzwjS+x/1C11/vF7EWa67h5oG6+cPF2P/kQ3/Oia7xCc2Gqw0sXQYomCXqwnr24X1SmbNRVV6Koqvb4YTB3o+1SwFkn1ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740180339; c=relaxed/simple;
	bh=SS2xJajvnKh6Chr/51nGTew/YKSyBH+KHgcj8HO8GsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYMsL8lKz6SUq9jKdX4yvpYpZXJTraC685sapDGBP+XXclP889GyV7xaNYKbmyKyheF/tO2pAoFx+ukA0YiP2jC7tRI3bhEweppUh+cdSlHO0buSUTPhxs/CPF1qxVzOOWXH6/qccHdV+4u6DaARN6Va3oGVQq3W0d23OeIs44Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J39rPdS3; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abb999658fbso340287666b.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 15:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740180336; x=1740785136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhwPcG9HO8s7xfZGsNbCdX7AUd1yrCVvMmNnJPXS/oY=;
        b=J39rPdS3BQZZXCMwB2uvy+1soqaR3WQ5KqPfFbxIrgPj5hOJvr9aEgxT9Lr598Sex3
         XizhTCffdpGVIg1i6D/AKFyvG7JtSAvXHFdeF+okbmaBDT6cnf3tzsc1psDmM5/clIBK
         72AbF/2/ZeE63kLFWmthZOt6yD4To7/1TQMtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740180336; x=1740785136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhwPcG9HO8s7xfZGsNbCdX7AUd1yrCVvMmNnJPXS/oY=;
        b=MQhXlPOjT1oF46hz9QN5iWL8bzcHL1u9gX/Bm6RCQL2jWX1rt2anhbKlNfpVKbhcDw
         Rag7k4FE6zAuub8WmvK2SLV9XiJCcThZ9MnJto/hp58SgGIT0Kqzp28ihbE4JBm8rM8z
         JK99cspeuG1GgTY6qrDAFvp+TF1neGyFj0tT7h4u8JI7KAGs+LPmhwp16lydoLDjL5J3
         /v562shj6jDr4+GmL3qGyGelw2jozZQfiKaJkdUNLXOOPX7j2bYiQW6H50HqaGadXK+Q
         3VKTBwHguejWlY8mH2v550KcPQ2Sey2mTv+XCPfJ6LNn0JJjaiZiP9ngiRP3JSl3vRWd
         3//w==
X-Forwarded-Encrypted: i=1; AJvYcCWt2p7PUiZB3tfb6nugRm4p5n7P9cVByOtVSTiWkqxVgwjvd9l0YzQD6RiT5hW3r5sNyKXcs4m9HA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/oQcdXx6oSpDmEDkkg/oxzB7dT8N7Wf+w8qp10gwwBivIX8Ua
	RFecSY30f93iQfQbmqEnUvjHg+BYCquq6dzFlI1O6/qvb9Vm+uLCiwgM7Gu8SmBpeMw1teSvNRW
	JDw==
X-Gm-Gg: ASbGncsM6HOPVoXseWVnjXqnweh7yBNciP1u5q5uNymb+Tjq3eQFtqAWm2FqJCgYEB4
	KiFp/S9VZ7JmVtOFT6n0sbOnyV4sggbwYoUp+dZehHwLouYmTtKpEIJ0qE5baFPyAuuJVrOqiaG
	TvbPfBnVMqXkV1EKhNWVSyKmuWEXfyV8IMufRWoq1R3D2gxm2V+Dh2k2kd2i9DUsqxGoN7O/nA7
	vNYdVj6wRDLV+uYgOGuozD+yXYASboTSOdLavhAyZRtwWnTQal2DcSza8eSf7RCJJJ7Y/z8ByXC
	jULIxfkQPq7nQcTUiLurD1pV0OmfIDANqiHRj5P9r+d2cp5ZGeX5Qb+eXNIcVw==
X-Google-Smtp-Source: AGHT+IHxkY4MEBaT0D0pRaZKp53HVqOys9Ja1prTzrdf4kp3fG/C9QZWCz7uzWI2b4CSNLnH3QPv0g==
X-Received: by 2002:a05:6402:4606:b0:5dc:9589:9f64 with SMTP id 4fb4d7f45d1cf-5e0b7107237mr10785809a12.13.1740180335701;
        Fri, 21 Feb 2025 15:25:35 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbe7afb953sm473510666b.143.2025.02.21.15.25.34
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 15:25:34 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f378498c9so2375787f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 15:25:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKmuxzoiimmjgE2DbhAn+0ciYnQVR1EL6qr+rw7WvBkLd2Q1GEJHQX57YJQJRp5x+n/dySKYEjgw==@vger.kernel.org
X-Received: by 2002:a5d:47c2:0:b0:38f:2856:7dc4 with SMTP id
 ffacd0b85a97d-38f6f0c670bmr5093469f8f.55.1740180334106; Fri, 21 Feb 2025
 15:25:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-fix-thermal-of-v1-1-de36e7a590c4@chromium.org>
 <CAJZ5v0i=Ehi1icm4Tx6cXmdhjq-Qj8Vwv1SwzCyx5oBj-5y9hQ@mail.gmail.com> <CAJZ5v0gJGxWA=7zHYU5h=ueqQcXNt94wOAg7sqrphOUb++mAyw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gJGxWA=7zHYU5h=ueqQcXNt94wOAg7sqrphOUb++mAyw@mail.gmail.com>
From: Yu-Che Cheng <giver@chromium.org>
Date: Sat, 22 Feb 2025 07:24:57 +0800
X-Gmail-Original-Message-ID: <CAKchOA0gnq8i7UFApTfaUQx=DJWAF3NkQAc10aZhW0+zctw3Vg@mail.gmail.com>
X-Gm-Features: AWEUYZl7-vzHaC1P8Qd4xK_Pd8d7lHdEurf2U-XeOtWmEgUBp7Z6JuPcQdGy4bQ
Message-ID: <CAKchOA0gnq8i7UFApTfaUQx=DJWAF3NkQAc10aZhW0+zctw3Vg@mail.gmail.com>
Subject: Re: [PATCH] thermal: of: Fix logic in thermal_of_should_bind
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Yu-Che Cheng <giver@chromium.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, it works on my side, as they look functionally equivalent.
Moving into a new function makes the control flow look more intuitive indee=
d.





On Fri, Feb 21, 2025 at 4:22=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Feb 19, 2025 at 10:40=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >
> > On Wed, Feb 19, 2025 at 8:06=E2=80=AFAM Yu-Che Cheng <giver@chromium.or=
g> wrote:
> > >
> > > The current thermal_of_should_bind will stop iterating cooling-maps o=
n
> > > the first matched trip point, leading to subsequent cooling devices
> > > binding to the same trip point failing to find the cooling spec.
> > >
> > > The iteration should continue enumerating subsequent cooling-maps if =
the
> > > target cooling device is not found.
> > >
> > > Fix the logic to break only when a matched cooling device is found.
> >
> > OK, but ->
> >
> > > Fixes: 94c6110b0b13 ("thermal/of: Use the .should_bind() thermal zone=
 callback")
> > > Signed-off-by: Yu-Che Cheng <giver@chromium.org>
> > > ---
> > >  drivers/thermal/thermal_of.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_o=
f.c
> > > index 5ab4ce4daaeb..69c530e38574 100644
> > > --- a/drivers/thermal/thermal_of.c
> > > +++ b/drivers/thermal/thermal_of.c
> > > @@ -312,7 +312,8 @@ static bool thermal_of_should_bind(struct thermal=
_zone_device *tz,
> > >                                 break;
> >
> > -> I'd prefer to do a jump from here, that is
> >
> > -                                 break;
> > +                                goto put_cm_np;
> > >                 }
> > >
> > > -               break;
> >
> > and remove the break statement above altogether.
> >
> > > +               if (result)
> > > +                       break;
> > >         }
> > >
> >
> > And of course the label needs to be added too:
> >
> > +put_cm_np:
> > >         of_node_put(cm_np);
> > >
> > > ---
>
> Or even, to avoid adding a new label, move the loop from
> thermal_of_should_bind() into a new function that will be called by it
> do carry out the cooling-maps lookup, like in the attached patch.
>
> Can you check if it works for you, please?

