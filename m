Return-Path: <linux-pm+bounces-10594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC4592736F
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 11:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4741F23D34
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 09:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8981AB8FC;
	Thu,  4 Jul 2024 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQ5K7yae"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0121AB526;
	Thu,  4 Jul 2024 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720086972; cv=none; b=BgDM4h3txphpW/YUHQ6LV0RbuBvUWSPNALgDpK/qcFd/eR5AE/SU+4pf3dMBNRfv1SEsYL9yOMCDQftbXb7CMMWTGcLkzsW33NlhDc2aGylXMM+RfWTFtyaYovs7nnxesnMYFeHm6JqeQ7XO7fYERn5PhIwlpyr3ms+VWs1q2As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720086972; c=relaxed/simple;
	bh=COEjk9Oj72PdEK4k+Ahpuka/isshgbyhwwmtFNnF57c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBKLnmpFuK+c2pAXhtmMe5mlI7j/+eJHfDIP3aW2biw1oY1tvlI3uTT2dNY5zAurvqettsgx97TSGm+q5ogdYrBmkTdfXchvkb9IbGN3+uv61jE9kXKhvc3E6jSOmBhcuc5My1UZ21/nH98/HME60klA9QQDWHdLVCNHTQd5ZY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQ5K7yae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17D8C4AF0C;
	Thu,  4 Jul 2024 09:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720086972;
	bh=COEjk9Oj72PdEK4k+Ahpuka/isshgbyhwwmtFNnF57c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dQ5K7yaeSMyntI46FdQXcBQtEO0b3qAmOKsATzghngrplFsEg8/Ho06SCm2iirIiv
	 68ka5QBRiJZpSIRCufJhe8fyaoK4vz4swZnVbCwF+OihxOh34IzqicrXn6dzJfdHT0
	 d+8AvAkj/K+TCWHIhEtxgATilfk27lmYXYnDfd8eQCpKf6RGaZGVgx3BlrGwAENklh
	 ty0J4wq2SjmKIZ6UvyyzTvfTVQOVIisdR2VtvVuZm0H0ovsfMx42tAVDTTyLJlIEC/
	 tertsap30dpMkoqSfxc+U2tcYNkARwMk5c1kon9G2OjthphZorItlOXh3T+N5OGRDP
	 oq/u6E8mVKtDg==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5c477d759ffso10337eaf.2;
        Thu, 04 Jul 2024 02:56:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpOe4PoOe/RL9Np+xhdJriYwQ0fyZOYSADrrhBI8+Ny011zqEhE6y+0Fs7Hp2uwNznYfkJcR/jvHfW5d2ft6aCxNb6kqCAvD9ruCza9DS+ZiMHFv3kPHxVzb+jc7kYjWxa9+Nvm0D3eAOpZaE/aKcaG+beHFf0wCvvbTEWGDAHS8rsKwQv
X-Gm-Message-State: AOJu0Yz6BihA5nmU95QURb6UkfTn69Bi+WZb4yWtvYBYOx6jselDgmKG
	QUoHPuswlz8rRnnknQDL3M0RdgvjypfAipZpJYCrFARMWNdN4Osxb97Un2Grswcs2MeQAMqW/jc
	ary9O8i2H0w8gY3LH6Dba8FnwU+A=
X-Google-Smtp-Source: AGHT+IHL27S/pDU0YvWXpAxhpyYPpDZN9BSijWYjpfutmPzGD1M6tgLna6yoOLjv16+Sfd/NgfaOZ7LcB8l7WKIT0U4=
X-Received: by 2002:a05:6820:166:b0:5c2:2795:7cae with SMTP id
 006d021491bc7-5c646eb2ee8mr1183685eaf.1.1720086971219; Thu, 04 Jul 2024
 02:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2764814.mvXUDI8C0e@rjwysocki.net> <2ed4c630-204a-4f80-a37f-f2ca838eb455@linaro.org>
 <8d91a3c1-018f-495b-83be-979b795b5548@linaro.org> <12c5c133-9519-4a26-b9a3-2da1d3466e94@linaro.org>
 <15b67ce6-3238-435d-ad28-7c06efbe9153@linaro.org> <ce6c2e8a-65a7-4cb2-a91d-fbcaeef6edc1@linaro.org>
 <0c4b401e-86b8-4169-af88-475433012d67@linaro.org> <636922b4-96d4-49cb-9020-2359e7497f56@linaro.org>
In-Reply-To: <636922b4-96d4-49cb-9020-2359e7497f56@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jul 2024 11:55:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hHV8VfLd7pi2pP2TyJ3ghc0bMnodfVC00kxv6bBTDEfw@mail.gmail.com>
Message-ID: <CAJZ5v0hHV8VfLd7pi2pP2TyJ3ghc0bMnodfVC00kxv6bBTDEfw@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: neil.armstrong@linaro.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 9:39=E2=80=AFAM <neil.armstrong@linaro.org> wrote:
>
> On 03/07/2024 17:12, Daniel Lezcano wrote:
> > On 03/07/2024 16:42, neil.armstrong@linaro.org wrote:
> >> On 03/07/2024 16:00, Daniel Lezcano wrote:
> >>> On 03/07/2024 14:43, neil.armstrong@linaro.org wrote:
> >>>> Hi,
> >>>>
> >>>> On 03/07/2024 14:25, Daniel Lezcano wrote:
> >>>>>
> >>>>> Hi Neil,
> >>>>>
> >>>>> it seems there is something wrong with the driver actually.
> >>>>>
> >>>>> There can be a moment where the sensor is not yet initialized for d=
ifferent reason, so reading the temperature fails. The routine will just re=
try until the sensor gets ready.
> >>>>>
> >>>>> Having these errors seem to me that the sensor for this specific th=
ermal zone is never ready which may be the root cause of your issue. The ch=
ange is spotting this problem IMO.
> >>>>
> >>>> Probably, but it gets printed every second until system shutdown, bu=
t only for a single thermal_zone.
> >>>>
> >>>> Using v1 of Rafael's patch makes the message disappear completely.
> >>>
> >>> Yes, because you have probably the thermal zone polling delay set to =
zero, thus it fails the first time and does no longer try to set it up agai=
n. The V1 is an incomplete fix.
> >>>
> >>> Very likely the problem is in the sensor platform driver, or in the t=
hermal zone description in the device tree which describes a non functional=
 thermal zone.
> >>>
> >>
> >> It was at 0 but the delay was removed recently:
> >> https://lore.kernel.org/all/20240510-topic-msm-polling-cleanup-v2-0-43=
6ca4218da2@linaro.org/
> >
> > Yes, these changes are because another change did:
> >
> > commit 488164006a281986d95abbc4b26e340c19c4c85b
> > Author: Konrad Dybcio <konrad.dybcio@linaro.org>
> >
> >      thermal/of: Assume polling-delay(-passive) 0 when absent
> >
> > diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.=
c
> >
> >> That doesn't explain it because only the last platforms have this erro=
r message printed.
> >
> > Let me recap.
> >
> > It has been reported if a thermal-zone with zero delay fails to initial=
ize because the sensor returns an error, then there is no more attempt to i=
nitialize it and the thermal zone won't be functional.
> >
> > The provided fix will periodically read the sensor temperature until th=
ere is a valid temperature. When there is a valid temperature, then the int=
errupts are set for the previous and the next temperature thresholds. That =
leads to the end of the routine of initializing the thermal zone and cancel=
s the timer.
> >
> > The platforms you reported, the delay is zero (before and after the 'po=
lling cleanup').
> >
> > My hypothesis is the following:
> >
> > The thermal-zone29 describes a sensor which does not operate.
> >
> > Before the patch:
> >
> > First attempt to initialize it, the temperature is invalid, then becaus=
e the delay is zero, the routine stops, and there is no more attempts to in=
itialize it. Nothing will happen to this thermal zone and it will stay stuc=
k silently. So at this point, the thermal zone is broken and you don't noti=
ce it.
> >
> > After the patch:
> >
> > The initialization routine is constantly retrying to init the thermal z=
one.
> >
> > -------------------
> >
> > If you revert the fix and you try to read the thermal zone 29, it shoul=
d always fail to return an error.
> >
> > If I'm correct, then I suggest to identify what thermal zone is 29 (typ=
e file), identify the node name in the DT, find the tsens channel and doubl=
e check if it really describes an existing sensor
> >
> >
> >
> OK I just found out, it's the `qcom-battmgr-bat` thermal zone, and in CI =
we do not have the firmwares so the
> temperature is never available, this is why it fails in a loop.
>
> Before this patch it would fail silently, but would be useless if we star=
t the firmware too late.
>
> So since it's firmware based, valid data could arrive very late in the bo=
ot stage, and sending an
> error message in a loop until the firmware isn't started doesn't seem rig=
ht.
>
> I think Rafael's new patch is good, but perhaps it should send an error w=
hen it finally stops monitoring.

Do you mean do something in addition to printing the message?  It can
do a couple of things.  For instance, it could disable the thermal
zone which would also cause a netlink message to be sent.  However,
I'd rather send another patch for this for the next cycle because we
are late in the current one and I'd rather stay on the conservative
side of things ATM.

Or do you mean the pr_info() log level is too low for this message?

Anyway, I'm going to submit the patch officially as is and please feel
free to send comments on that submission.

