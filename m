Return-Path: <linux-pm+bounces-22043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 245BFA3506E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 22:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9054B3AC0D4
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 21:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BAA26619E;
	Thu, 13 Feb 2025 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzlcxEud"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5DF245B1B
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739481644; cv=none; b=dszxdkAEMcpxOrH/c24SKZ4tWsVyjRyBYabbqdWgwmodzsNIJiSQndtoyhybSMStJeZn/PRIOwh8fMCFvziYcUP8o+aZtfYL3hCHn92jKL8DYztcc0Ue4iL7CIb4T3ac/Q7UViag+XP2AjUxf5lq5pHZOWI7Wa8LFfiC+UE2dd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739481644; c=relaxed/simple;
	bh=R6yZihHam0h6IlcVsO97cIFK7OeOruhXhxzpvShzhP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fL/ftEtEMrh/OUgTvrtPzMmPkhT/j1U2+tzlzRLpnV/YXp486OiS+3mT+abUwnULxBakJgVAD6RIK53eqPZxJbR/avei92jZ3NhByovyD/KJ/DtVXIxRsD5UxTMJYx+B4q5p9C3po4CGJlCGm0T/u+y/sQ29fwz7m4vSgEGpA9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzlcxEud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E87C4CED1
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 21:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739481643;
	bh=R6yZihHam0h6IlcVsO97cIFK7OeOruhXhxzpvShzhP8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RzlcxEudos6tHo5uHtN1HgAw6EewdK0A9144rXpHZ9+TjlXCkiLgaTBcfDOdSpATo
	 Gc4/5Is/xGYmPE7r9hAG6sDgepefPTmnm2ofAM00OftOMboLusLJSNOkJu97oriya0
	 n7PWoGC9mrxxv5HS3DtleFPypPmUByoCQN82MiwYwcAzo1E6p6pYHxPiavqcTpUI+8
	 e1PhMLdduOPUbKRiAx84Gvh6dziyL/RbuuxdgF+ZLO0gOn2pCDBQlbHJpI8exdmhzZ
	 MNjCr++g5TEl6eTgeEvZ/HJ+i6lZ3RWW95EbMYRKU6DW23h+nzdnyuWpm/z2AncacO
	 EJ4WspA1EiXFQ==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2b8e26063e4so722359fac.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 13:20:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXR5zPJ2BGhdGtqv8a+uxuCwntcwUrGs5N7+O/9awNjTqptnIy1p9NCFADmexe1dvoRY7to634ujQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx03NjGRSnwi2FPD7A10XyB4B0DM0nrQ8L630MBwKGzkyG94EYr
	iHoD1HJY8Xz3s+z+iss8pqxQfgz/QoUMHzpk7oFLemmjw7WBz5vZs6wvBZbmldjxR+kEIzzf4dI
	WghAvJkNJaqis+54TTg1KhA4Aj2E=
X-Google-Smtp-Source: AGHT+IHhtwiyO7pSSPqsWR2kHRk24EchxhEUH5QxXM6/nqWNb/nvAeT4uYZe2n/jCmUVmvNLC3LUXeHdxJuvNMhzhDE=
X-Received: by 2002:a05:6871:7506:b0:2b7:ecaf:59d4 with SMTP id
 586e51a60fabf-2b8d6831231mr5507942fac.38.1739481642049; Thu, 13 Feb 2025
 13:20:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211034423.833783-1-xu.yang_2@nxp.com> <CAJZ5v0idzf1QKf8UKp4ttepLbipZD6b1RFHX7QqgQCyJZL8dQg@mail.gmail.com>
 <20250213105306.vz2xirvffqaycz7z@hippo>
In-Reply-To: <20250213105306.vz2xirvffqaycz7z@hippo>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Feb 2025 22:20:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jEd1hdssAeLXUMqAuqFsc1Pcebm3eEUP0wrx39xG2TwA@mail.gmail.com>
X-Gm-Features: AWEUYZn7R16V2pRKXfHP1W9UJH86Y8NuXzfIZN6YIUVp_0ne92KdxV50IZQCwYo
Message-ID: <CAJZ5v0jEd1hdssAeLXUMqAuqFsc1Pcebm3eEUP0wrx39xG2TwA@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: core: Set is_prepared to false before checking direct_complete
To: Xu Yang <xu.yang_2@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, len.brown@intel.com, pavel@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, stern@rowland.harvard.edu, 
	linux-pm@vger.kernel.org, imx@lists.linux.dev, jun.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 11:56=E2=80=AFAM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> On Wed, Feb 12, 2025 at 09:55:00PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Feb 11, 2025 at 4:43=E2=80=AFAM Xu Yang <xu.yang_2@nxp.com> wro=
te:
> > >
> > > Currently, if power.no_callbacks is true for a device, device_prepare=
()
> > > will also set power.direct_complete to true. When device_resume() che=
ck
> > > power.direct_complete, setting power.is_prepared will be skipped if i=
t
> > > can directly complete. This will cause a warning when add new devices
> > > during resume() stage.
> > >
> > > Although power.is_prepared should be cleared in complete() state, com=
mit
> > > (f76b168b6f11 PM: Rename dev_pm_info.in_suspend to is_prepared) allow
> > > clear it in earlier resume() stage. However, we need set is_prepared =
to
> > > false before checking direct_complete after including direct complete
> > > support.
> > >
> > > Take USB as example:
> > > The usb_interface is such a device which setting power.no_callbacks t=
o
> > > true. Then if the user call usb_set_interface() during resume() stage=
,
> > > the kernel will print below warning since the system will create and
> > > add ep devices.
> > >
> > > [  186.461414] usb 1-1: reset high-speed USB device number 3 using ci=
_hdrc
> > > [  187.102681]  ep_81: PM: parent 1-1:1.1 should not be sleeping
> > > [  187.105010] PM: resume devices took 0.936 seconds
> > >
> > > Fixes: aae4518b3124 ("PM / sleep: Mechanism to avoid resuming runtime=
-suspended devices unnecessarily")
> > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > > ---
> > >  drivers/base/power/main.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index 40e1d8d8a589..69d0f9ca7051 100644
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -929,6 +929,12 @@ static void device_resume(struct device *dev, pm=
_message_t state, bool async)
> > >         if (dev->power.syscore)
> > >                 goto Complete;
> > >
> > > +       /*
> > > +        * This is a fib.  But we'll allow new children to be added b=
elow
> > > +        * a resumed device, even if the device hasn't been completed=
 yet.
> > > +        */
> > > +       dev->power.is_prepared =3D false;
> >
> > Well, not really.
> >
> > This is to allow new children to be added from a resume callback, but
> > direct_complete devices are still in suspend at this point.  You can't
> > make this change for all of them.
> >
> > You can clear power.is_prepared for devices with power.no_pm_callbacks
> > set before the dev->power.syscore check, though.
>
> Okay. Thanks for your suggestion.

Actually, this is more complicated than I initially thought, sorry about th=
at.

While it is true that is_prepared may be set early for devices without
PM callbacks, in principle they still need to wait for their parents
and suppliers to get ready before this happens because the new
children may depend on the functionality provided by those devices.

However, IIRC in the USB case the new children are added by the parent
of the device in question during the execution of its resume callback,
so is_prepared needs to be set before that callback runs which is not
guaranteed to happen so long as it is done in device_resume().  It
looks like that would need to be done in device_resume_early(), which
then would be questionable because of the above.

I need to think about this some more.

