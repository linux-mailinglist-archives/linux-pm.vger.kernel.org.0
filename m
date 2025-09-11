Return-Path: <linux-pm+bounces-34480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2F5B534A1
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 15:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9171D1890157
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 13:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE00832C316;
	Thu, 11 Sep 2025 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tgz476OI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B6654763;
	Thu, 11 Sep 2025 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599028; cv=none; b=S/x7B/ZNbr7HLK9GYKoLZ3H2p+lQfM7V9QQqE9w1bAi0cDwz2AaxINjAWXMHB2HNlvjZH4lMkU8YW5aPn3hX1qz9f6zqwC+sCiC3ErUMtqrDWD+6zLZdIKlOdPXv5bsko4nHXO3FOyNIYTKcdGap5BxIyCcMdmb+m4OghxyxlKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599028; c=relaxed/simple;
	bh=hMtSvkMWxqsg6lCV2CppqzXzxo4LhI0P6FR0oVl35t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UV8fF7+rJX468gycZayfUhG2xdeZu80gyG4V2muDvoLVGHK2/qaeI0W/oe6k6AgB0Glm5G9YR8+SYZALMPPGdDnmmIf3y3BkqTzDm1R0WG3j7a2ajtBTWYmXmHnwr4OazXSZXHbDHCMNPPDDOmEWpC6ZwllbpIlys50Svg4XfpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tgz476OI; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-544a2cf582dso466958e0c.3;
        Thu, 11 Sep 2025 06:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757599026; x=1758203826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kcao4rN5X0cmuLo7SXDeH3m9W8a/UbP7jZQS+UPEOSA=;
        b=Tgz476OIWvzZgFY+ZBRYwhugv1gX4Pg7yhyq50pOHKXfZ1x+XcZLB1xFlZXeuJoTLH
         ipdpPlXg5kYgVeZeelwfA+frpoT1UdANRqPLZB1RR7f2LuTL3EZsXp9XUOpoO+T8BIGo
         aS5T14RB9xbX8Q7LbiANzeiLh6AqLZ0NjBiQA4rgI3fLCD9qjjoK8jns/dOe4p2YbDdS
         od+TJBW4m86GR5nty0Pk6WAOPBU5stFQRUwn1FzBj5NVKkLH2fsWjjSebZbz+7qzhi9n
         cHZdYxHj/fWrSs//AT75fAKMnRw90C3vI0U1pS9EHh3TYUinuziZ5healXbVneWgKEXG
         vp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757599026; x=1758203826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kcao4rN5X0cmuLo7SXDeH3m9W8a/UbP7jZQS+UPEOSA=;
        b=qjZ4nXIAxyRVImuQZ4wgV9bB100ITUE7XVS2bYi2FfxCgan60Dy6fKRvFobDX7S4HW
         +7dlock56iYL20W3QxxCrhPT3zSB1fZuYDmsH81Rtqnv0km1EhjCQicHh+Knqgckyb+n
         I6sLmbaEss/E/rnlr8gJzqGBNjHoYWgEfCOowNh0IYDOJkLUGXTAS2FZJuImL8YUAlJi
         P1KKTT4QudDWwzizRPXp05OYyQdlr6rUX9UHBQvUGnp25ZdqDuefb7w8gw7CPDiGPb/x
         AZj7Gkc9C9anz57jg+oQUg5+ikirbhs859uj+KaBt4ur61mhujWw46orQ0a1dMWlUEZW
         Nlag==
X-Forwarded-Encrypted: i=1; AJvYcCWJ8epqO07kDS63Ijaw4Uk5CXsA4YuJlOHZOPhNzK5A82VmyyMxePtL90VhtCJHaSMRyGt4A2FqqrzS3hg=@vger.kernel.org, AJvYcCWLTG01aaIwp0kRRvOIJxyz2fwKLwzxLxBxL/EZ9nMMfGskxOeeoSlMjsm9TPfCJ3wy7YpLP9LzWsXZ@vger.kernel.org, AJvYcCXjpKMrEVN0r/QgQz5i+s3QTF11Da0f9bK4nQiywQDlhWw+o6H/BiOaXb/8Jt9VxT2y4x1BwJey+ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZvsifFsDMpWDr4+SshysZw+WQihk5gLl6DzJ1GbKjFObewNhO
	Vo4GEZeO28zkepGt2IkC0R8gnhiIr6rJvSeXB0wg1sBGrWlDWV6dcl53aCyD2nyY1tk9+GCEciy
	/kLJ1Nsx+FY7txovNTRN0FWE7UyOJbls=
X-Gm-Gg: ASbGncuHCjH0uninmlLm5fkeGhpDVnkhIbSAOoAHtusIhU52iTe1damhnrb9gnxMrLK
	HRhZARHV8w4n+X7cKx6ZuppFOqvbRDFfTvobWJ7B7l8cnv9xWAnsVPc6vV4y1825a1AM/g0Fn9/
	n3qQ31Eivt6nCfOo8Q/YexKzt7UrpxxfxfTZGHk/DOVGYS/FWEeJjWD6o3Q4qf6URxn90y3wR9j
	U+Ff+o/DdHr2WBYlUhKJwh1infU/v+WhONL/1naCUd3Sw==
X-Google-Smtp-Source: AGHT+IHfaoER7CZHtltL7LNT+pecj12ZrOtK26TcGYDPu6M3eY+1PHAZQ3dMlk8ej2Fyxc3mQCfwAgq8TtigXExrlwA=
X-Received: by 2002:a05:6122:658b:b0:544:4ee5:1334 with SMTP id
 71dfb90a1353d-5472a006752mr6515775e0c.2.1757599025751; Thu, 11 Sep 2025
 06:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <385dccf3-234a-4f83-9610-81ac30bf1466@rowland.harvard.edu>
 <20250909161901.10733-1-ryanzhou54@gmail.com> <20250911013242.oxm2kwfaqvmybbhk@synopsys.com>
 <xbfvykzfi26pyaycd7efbqvmraxcu6zzgqjfxtk33wcsjsnnal@5e3g4pq5qcj3> <CAJZ5v0gT26VK-sHmgK_S4RjjO3Uc-ZmoAYos43S5yWh0zWc9DA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gT26VK-sHmgK_S4RjjO3Uc-ZmoAYos43S5yWh0zWc9DA@mail.gmail.com>
From: ryan zhou <ryanzhou54@gmail.com>
Date: Thu, 11 Sep 2025 21:56:54 +0800
X-Gm-Features: AS18NWDPE-BY2oqlpK1jbYCknJ2acQon-GvjcezpUvo-Fhxi1ToAyAixY67txWo
Message-ID: <CAPwe5RP14woNEiux4e4xfL0W=53rogmcionLuvYt37aLz-i-nA@mail.gmail.com>
Subject: Re: [PATCH v2] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Xu Yang <xu.yang_2@nxp.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "royluo@google.com" <royluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rafael J. Wysocki <rafael@kernel.org> =E4=BA=8E2025=E5=B9=B49=E6=9C=8811=E6=
=97=A5=E5=91=A8=E5=9B=9B 19:36=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Sep 11, 2025 at 12:58=E2=80=AFPM Xu Yang <xu.yang_2@nxp.com> wrot=
e:
> >
> > Hi Ryan,
> >
> > On Thu, Sep 11, 2025 at 01:32:47AM +0000, Thinh Nguyen wrote:
> > > On Wed, Sep 10, 2025, Ryan Zhou wrote:
> > > > Issue description:During the wake-up sequence, if the system invoke=
s
> > > >  dwc3->resume and detects that the parent device of dwc3 is in a
> > > > runtime suspend state, the system will generate an error: runtime P=
M
> > > > trying to activate child device xxx.dwc3 but parent is not active.
> > > >
> > > > Solution:At the dwc3->resume entry point, if the dwc3 controller
> > > > is detected in a suspended state, the function shall return
> > > > immediately without executing any further operations.
> > > >
> > > > Signed-off-by: Ryan Zhou <ryanzhou54@gmail.com>
> > > > ---
> > > >  drivers/usb/dwc3/core.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > > index 370fc524a468..06a6f8a67129 100644
> > > > --- a/drivers/usb/dwc3/core.c
> > > > +++ b/drivers/usb/dwc3/core.c
> > > > @@ -2687,6 +2687,9 @@ int dwc3_pm_resume(struct dwc3 *dwc)
> > > >     struct device *dev =3D dwc->dev;
> > > >     int             ret =3D 0;
> > > >
> > > > +   if (pm_runtime_suspended(dev))
> > > > +           return ret;
> > > > +
> > >
> > > Is this a documented behavior where the device should remain runtime
> > > suspend on system resume? I feel that that this should be configurabl=
e
> > > by the user or defined the PM core. I don't think we should change
> > > default behavior here just to workaround the issue that we're facing.
> > >
> > > What if the user wants to keep the old behavior and resume up the dev=
ice
> > > on system resume?
> >
> > What about resume the device firstly if it's already runtime suspended =
when
> > call dwc3_pm_suspend(). Therefor, the old behavior can be kept and the =
issue
> > can be avoided.
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 370fc524a468..1b8dbb260017 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -2672,6 +2672,9 @@ int dwc3_pm_suspend(struct dwc3 *dwc)
> >         struct device *dev =3D dwc->dev;
> >         int             ret;
> >
> > +       if (pm_runtime_suspended(dev))
> > +               pm_runtime_resume(dev);
>
> You can just call pm_runtime_resume() here without the preliminary check.

If the device is active before sleep, skip runtime_resume after wakeup
and just call dwc3->suspend.

Thanks=EF=BC=8C

Ryan

