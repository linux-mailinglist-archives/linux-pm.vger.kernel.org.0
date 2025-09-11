Return-Path: <linux-pm+bounces-34478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A047B53499
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 15:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7B4AB61559
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 13:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B30E3314A3;
	Thu, 11 Sep 2025 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlT860eg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA39F327A00;
	Thu, 11 Sep 2025 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598725; cv=none; b=f2MdPHMoRmHJHgiJ1mJ7vmbVtP+AZs5f1sXgKuB8FXBEwnlhHeQzl7Sv2E/Lf+EbAfzaUSBAKr7AD6wuIc9A/lJgxrNkTmRx61wON/Qo8ozE2sGZCXaQse0giZ4edWTA80CbagK9NAQTpZjArPa0/Ui0OfTIrQ058b/lVMqU6Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598725; c=relaxed/simple;
	bh=oXQUqn25nnJsMzhF9F1nXOg6Ycgm/P1u5nJ4QuFi05w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPW9VaVQFpkzJMXGzE+wjA+iNNgFXK+/njHIR2/mrd504zVPGa/XJYI1RtYHo3jlfLsvJVcrSDi8ohBsZmT6HGgN8JbEyzEfclYc7T+b9cwU49MUDaZV1ua1qf5nGnuLWol1abFquxUHgWRaX6IeIKJDe+gkau8DtCHL1gBdJFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlT860eg; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-8a756436f44so404992241.3;
        Thu, 11 Sep 2025 06:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757598722; x=1758203522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEE00+6hvF6rmsi4WJZpiTuvESHAQjXYHBJkPHyecw0=;
        b=RlT860eg2TtMcp+7r8W7yQcwqx17+mZwaDe1NiSt/6zV0Wv1fvrpOsmXRq+bQCWZKP
         hRI3dyVYkmsgYnzbEbehwyYxz0LEq3hVvXN52gKgpQ7RH0dydlqmP25ENYBJ4X+VwcEc
         M59nKu5wHc+fZhAJeylEoDvj5+ooMzg2/c4fktScYL2Nc52PcnOVXzcK65pIKtGH4UQi
         V5kzfqn9z1amYRTqwtpGDKouVUYrUVyIdFuJb6NCqVUAVgXVlUizsk2ZOZhQLiShl6fj
         Jcq4dChK1gA2MOh8jyr+caBSjd4DWsLg/i6QC05RVo0soWQV4gzwOUt7sfeBK0XkoKGN
         whFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598722; x=1758203522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEE00+6hvF6rmsi4WJZpiTuvESHAQjXYHBJkPHyecw0=;
        b=rM7hF4KGe7tSzOePT3jUbkPj8K004oGjq1Ds6Qt/ofQOcCMUXtaev0qnRz9SCUa6TK
         wpWN+oIOyEdlLgGHlZwXxGM7AGpCGl5mQ5u5+JWdulMcvxTQtTGXXlsZyCAjyJzzI/f8
         IzlwCSMn+BHzan21xTbfA5BfCMR4itzU3MNKYgPedlVWmmaUd9PhaU3hD4kY8PfhkayS
         Yi7a1MwuhQO+aKtP/dJkHT0OdMzlE+VejtXRUmyp2TGxfJ2Vrp96qAOhBtWKYml/Fk1o
         jkNT5pU6ruXzD3d448aRvWATxLkNe/Jgi3DyO58OAJs4/sb97M9XInWxDHZkwrCs4UfQ
         jR6g==
X-Forwarded-Encrypted: i=1; AJvYcCUJd136XsbbHg6yg+nyRTNQIVkwyd7+My32nKbUVeqOys2+FnYUXYfsf/amBlQcrBArcv0X4S2h3GE=@vger.kernel.org, AJvYcCUvjsYlYkdv0AWX62lAzHmg+yW2z6nOA9l1dV0b3gdvkJxgLBmeVMdzYliiNtWFzDSJi+vl3nv8zrMK@vger.kernel.org, AJvYcCXI4hZqprNX/1Wr0TMvbZG3MxHNjxtKUYJnhFdG2gZoi/JQDTpU1ajjLzaDwiiLfaTMR5l57kdJB2fztCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrsbY1v6e7rBsl6978i+FE5n7iq6iOdJC9xzaC+8SY2IoFQ4aP
	kT9kqYnoxT1BOTKWWyideTK163xcix0Zfq9JFGAkXeWsFP3kTxxfYlxKEH8C4p/wMYT9ZaVCPhE
	tDevpzjBIpWkp3Cernk55pZxCtMWOLuHzIPFbm38=
X-Gm-Gg: ASbGncvTAk0wNyhmEfvB1++orBQxZgCH6L2FQ7GCgCv6coYK4RmHvzsd+/YATcz0R8V
	EWPG3Kjv4/BWJZq/hOW5/2XhC/CCeYGfpdID/Hi0aLEvJrKFfU5OgKCrUwKqQWO18SpAo7Q1WM+
	jlUaYI8XkZm4y4EUz3nEoTNQoNNJoKl3ORk7WJB2xhb8sDL7rO8vZxtk8+7XREtD637J0DLGbYT
	DbuhhPiUECyLPUyZYH8Y8Bn1cF7ndAMvJAyxgavrPNgiA==
X-Google-Smtp-Source: AGHT+IGIHPz0RBFl/nm1DjVtb9Rh3E0Rvz3E+f3+Bkjasib3i3qRcuIpsUrg8FbZUBt7+s9qysRmXR5UjQTOfOHapuc=
X-Received: by 2002:a05:6102:3e0b:b0:4fb:fa84:2e64 with SMTP id
 ada2fe7eead31-53d1c8a24f2mr5963295137.14.1757598722320; Thu, 11 Sep 2025
 06:52:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <385dccf3-234a-4f83-9610-81ac30bf1466@rowland.harvard.edu>
 <20250909161901.10733-1-ryanzhou54@gmail.com> <20250911013242.oxm2kwfaqvmybbhk@synopsys.com>
 <xbfvykzfi26pyaycd7efbqvmraxcu6zzgqjfxtk33wcsjsnnal@5e3g4pq5qcj3>
In-Reply-To: <xbfvykzfi26pyaycd7efbqvmraxcu6zzgqjfxtk33wcsjsnnal@5e3g4pq5qcj3>
From: ryan zhou <ryanzhou54@gmail.com>
Date: Thu, 11 Sep 2025 21:51:50 +0800
X-Gm-Features: AS18NWDtmlDggqyp6K0v_e1uqwqAiIfa83fbw9mVmNTcQYr6GUERskSZVB3YZKg
Message-ID: <CAPwe5RNZuUB0ri=cuO4yMUq2nAwTYy_qwNg+wgfXhTHBFO6baA@mail.gmail.com>
Subject: Re: [PATCH v2] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, 
	"royluo@google.com" <royluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xu=EF=BC=8C

Xu Yang <xu.yang_2@nxp.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=8811=E6=97=A5=E5=
=91=A8=E5=9B=9B 18:58=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Ryan,
>
> On Thu, Sep 11, 2025 at 01:32:47AM +0000, Thinh Nguyen wrote:
> > On Wed, Sep 10, 2025, Ryan Zhou wrote:
> > > Issue description:During the wake-up sequence, if the system invokes
> > >  dwc3->resume and detects that the parent device of dwc3 is in a
> > > runtime suspend state, the system will generate an error: runtime PM
> > > trying to activate child device xxx.dwc3 but parent is not active.
> > >
> > > Solution:At the dwc3->resume entry point, if the dwc3 controller
> > > is detected in a suspended state, the function shall return
> > > immediately without executing any further operations.
> > >
> > > Signed-off-by: Ryan Zhou <ryanzhou54@gmail.com>
> > > ---
> > >  drivers/usb/dwc3/core.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > index 370fc524a468..06a6f8a67129 100644
> > > --- a/drivers/usb/dwc3/core.c
> > > +++ b/drivers/usb/dwc3/core.c
> > > @@ -2687,6 +2687,9 @@ int dwc3_pm_resume(struct dwc3 *dwc)
> > >     struct device *dev =3D dwc->dev;
> > >     int             ret =3D 0;
> > >
> > > +   if (pm_runtime_suspended(dev))
> > > +           return ret;
> > > +
> >
> > Is this a documented behavior where the device should remain runtime
> > suspend on system resume? I feel that that this should be configurable
> > by the user or defined the PM core. I don't think we should change
> > default behavior here just to workaround the issue that we're facing.
> >
> > What if the user wants to keep the old behavior and resume up the devic=
e
> > on system resume?
>
> What about resume the device firstly if it's already runtime suspended wh=
en
> call dwc3_pm_suspend(). Therefor, the old behavior can be kept and the is=
sue
> can be avoided.

Originally, I also believed that forcing the device to remain active
before PM suspend
 was necessary. However, this approach has two drawbacks:
    1. It prolongs the system's sleep transition time.
    2. Worse, if a USB insertion wakes the system during enumeration,
the system may
    re-enter sleep before the USB device is fully recognized.

> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 370fc524a468..1b8dbb260017 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -2672,6 +2672,9 @@ int dwc3_pm_suspend(struct dwc3 *dwc)
>         struct device *dev =3D dwc->dev;
>         int             ret;
>
> +       if (pm_runtime_suspended(dev))
> +               pm_runtime_resume(dev);
> +
>         ret =3D dwc3_suspend_common(dwc, PMSG_SUSPEND);
>         if (ret)
>                 return ret;

