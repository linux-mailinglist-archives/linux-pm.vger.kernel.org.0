Return-Path: <linux-pm+bounces-34481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D834B534AB
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 15:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CC03A695B
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 13:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D671331B126;
	Thu, 11 Sep 2025 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKKHGHUr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F7054763;
	Thu, 11 Sep 2025 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599126; cv=none; b=dYxstVMZNTZngKNs4muYqxSK9reEw0zjknkcbE1Qf+HZjaBANLAzWNo75jD5G3qZC6AmWb9z5NgqPqWAkYtEvZcCLC6SAIiRIxZ21IGfrauQpvip/PX5lSa+D1BP2Aktp4ZDwMfICYmq6cXi6G/QzAD/TfSdSDCqaVvZlk5QZmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599126; c=relaxed/simple;
	bh=zUOI85Wk3s5W8+C/qhkRVlPvNB7zX3sTSR/t7JsqQdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=je2YgllR3pSbDokzfQZFbUg9wQ9+IUsTDqNeNlGVWheylwmbUotXk3RYF0XNTZr7adgh1iM+7OBc97diHRUiN6b51kXVH6sOSmCgQa2W5ngKD4g2sZX8ACSNoEBwez6usVbEF8SwsXnjW0bI3J+xKl1/X26N2G+7MlrvZImkn7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKKHGHUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FE3C4CEF0;
	Thu, 11 Sep 2025 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757599126;
	bh=zUOI85Wk3s5W8+C/qhkRVlPvNB7zX3sTSR/t7JsqQdI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CKKHGHUrRl5i1ljvmz9lsju3Bx+AQgCbS4WCooXwHI7VaohAX33ZN+ZSVk7Tlac3c
	 CsnwDklUxZx3W6QT7PyEd5o9JVgLjJqJMaifdb/N02pAS1LR5724wsRnO0XA8dPAjj
	 0YDo08jUqYbQap3ZfUpBL4MK1bCWaZPmzlNSVPTiwnBiRpXF8A16PhE95c+8j/zAl9
	 6hFFflycJE3An18xeaQ4VBPQQ1xRXaOi4xjlHAvaoY1eHxLYiWZh7455zqMGQ40OME
	 Lgm/WXYezcXViTP/Nc46yKqEbNu+5XcpaHycdGs07K6h6t5eDjnkZISTySl1yIJrzb
	 32PJIEWlXuk/g==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-621b965a114so266009eaf.1;
        Thu, 11 Sep 2025 06:58:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAbXD5q74B/ibykvP+MsKuFd7PNGleXzHgxp7/z4ie6evd5u2Pft5laiB3r3J+ZY6jxOG4uSqkL6E3zN4=@vger.kernel.org, AJvYcCXMJ7dQSrbn8abLeH0oE/adPZ2NpyTF6L6elJiP7Y5r99kXXAsyL7R+4iDpISobJWjsN0c8CUdGiGI=@vger.kernel.org, AJvYcCXdtt/f0MZM8p/iOTVEkndV/KBnOEW4SDspE5hZC/cjuUpU1CkuAOaHdNac6TZpf3xc5+joxHQSw6wH@vger.kernel.org
X-Gm-Message-State: AOJu0YzL7ZYfP72oeRy8TQviGLGyxvN7mDYKtiJe3Q5nDqDzDPTv778n
	sc9bvhGUPaOc/L+BTtsu21tEBiyp32oRAWuZjZAT8xAejh/8C+ea5RP82bY1gKw0I9xJQW0x3WU
	4WpMS8CME3FGRKUDAxQ3FMz4WP+I12kI=
X-Google-Smtp-Source: AGHT+IFR256VrR2uXDvTtVSQ4KENYiS/q+WF+wlT+K2JOF02yDIg0gDxY9vVsXuSyke4TCTcXPfQu04EX9C9awhl1dk=
X-Received: by 2002:a05:6820:624:b0:621:7131:2e2b with SMTP id
 006d021491bc7-62178a8b54amr9148386eaf.7.1757599125607; Thu, 11 Sep 2025
 06:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <385dccf3-234a-4f83-9610-81ac30bf1466@rowland.harvard.edu>
 <20250909161901.10733-1-ryanzhou54@gmail.com> <20250911013242.oxm2kwfaqvmybbhk@synopsys.com>
 <xbfvykzfi26pyaycd7efbqvmraxcu6zzgqjfxtk33wcsjsnnal@5e3g4pq5qcj3>
 <CAJZ5v0gT26VK-sHmgK_S4RjjO3Uc-ZmoAYos43S5yWh0zWc9DA@mail.gmail.com> <CAPwe5RP14woNEiux4e4xfL0W=53rogmcionLuvYt37aLz-i-nA@mail.gmail.com>
In-Reply-To: <CAPwe5RP14woNEiux4e4xfL0W=53rogmcionLuvYt37aLz-i-nA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Sep 2025 15:58:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g_0D7-68eM6ofv3naSipvXEF4pLMknjwGaA6kLm1FzMg@mail.gmail.com>
X-Gm-Features: Ac12FXztfpoz0wfYIHdtahSgMF__AuYX2WX63LsezHHyUZxy1AASDifWg2WLTUU
Message-ID: <CAJZ5v0g_0D7-68eM6ofv3naSipvXEF4pLMknjwGaA6kLm1FzMg@mail.gmail.com>
Subject: Re: [PATCH v2] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
To: ryan zhou <ryanzhou54@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "royluo@google.com" <royluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 3:57=E2=80=AFPM ryan zhou <ryanzhou54@gmail.com> wr=
ote:
>
> Rafael J. Wysocki <rafael@kernel.org> =E4=BA=8E2025=E5=B9=B49=E6=9C=8811=
=E6=97=A5=E5=91=A8=E5=9B=9B 19:36=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Sep 11, 2025 at 12:58=E2=80=AFPM Xu Yang <xu.yang_2@nxp.com> wr=
ote:
> > >
> > > Hi Ryan,
> > >
> > > On Thu, Sep 11, 2025 at 01:32:47AM +0000, Thinh Nguyen wrote:
> > > > On Wed, Sep 10, 2025, Ryan Zhou wrote:
> > > > > Issue description:During the wake-up sequence, if the system invo=
kes
> > > > >  dwc3->resume and detects that the parent device of dwc3 is in a
> > > > > runtime suspend state, the system will generate an error: runtime=
 PM
> > > > > trying to activate child device xxx.dwc3 but parent is not active=
.
> > > > >
> > > > > Solution:At the dwc3->resume entry point, if the dwc3 controller
> > > > > is detected in a suspended state, the function shall return
> > > > > immediately without executing any further operations.
> > > > >
> > > > > Signed-off-by: Ryan Zhou <ryanzhou54@gmail.com>
> > > > > ---
> > > > >  drivers/usb/dwc3/core.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > > > index 370fc524a468..06a6f8a67129 100644
> > > > > --- a/drivers/usb/dwc3/core.c
> > > > > +++ b/drivers/usb/dwc3/core.c
> > > > > @@ -2687,6 +2687,9 @@ int dwc3_pm_resume(struct dwc3 *dwc)
> > > > >     struct device *dev =3D dwc->dev;
> > > > >     int             ret =3D 0;
> > > > >
> > > > > +   if (pm_runtime_suspended(dev))
> > > > > +           return ret;
> > > > > +
> > > >
> > > > Is this a documented behavior where the device should remain runtim=
e
> > > > suspend on system resume? I feel that that this should be configura=
ble
> > > > by the user or defined the PM core. I don't think we should change
> > > > default behavior here just to workaround the issue that we're facin=
g.
> > > >
> > > > What if the user wants to keep the old behavior and resume up the d=
evice
> > > > on system resume?
> > >
> > > What about resume the device firstly if it's already runtime suspende=
d when
> > > call dwc3_pm_suspend(). Therefor, the old behavior can be kept and th=
e issue
> > > can be avoided.
> > >
> > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > index 370fc524a468..1b8dbb260017 100644
> > > --- a/drivers/usb/dwc3/core.c
> > > +++ b/drivers/usb/dwc3/core.c
> > > @@ -2672,6 +2672,9 @@ int dwc3_pm_suspend(struct dwc3 *dwc)
> > >         struct device *dev =3D dwc->dev;
> > >         int             ret;
> > >
> > > +       if (pm_runtime_suspended(dev))
> > > +               pm_runtime_resume(dev);
> >
> > You can just call pm_runtime_resume() here without the preliminary chec=
k.
>
> If the device is active before sleep, skip runtime_resume after wakeup
> and just call dwc3->suspend.

But pm_runtime_resume() will not resume an active device, will it?

