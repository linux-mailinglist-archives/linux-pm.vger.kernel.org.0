Return-Path: <linux-pm+bounces-34361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5ACB51762
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 14:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 518EA4E350B
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 12:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522D331C591;
	Wed, 10 Sep 2025 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ttel2A/b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9222D31CA55;
	Wed, 10 Sep 2025 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509011; cv=none; b=mk1j2w2kdtfV7AknvtyAJWkcXOVxprBKbF80XbGmiPzRVL7pS+SeS5FPumwUDjz88KVDm99iZa9hteyEmH2JlOjR/rpKLX05styldpFQzAZOf3BpKTGf+pxENmUzh76SfAtfABOUI8r2zNHWeHTDGsGwTy0kYhTgP5ykqoH17U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509011; c=relaxed/simple;
	bh=xSHU9LrZBwNFz3tU6gqUFT4uW67nrsrFJZDTWDmyaJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaUz/+5ramIBCh4Vg3/aDLLdzLIhs/emqHaUEJ34EWCxN6Or3QyqQdaaq8+FuXDo6hNgnQyesV5Rz06yYmFOhszl2Lq/XgPoMDVk7Nbz8oFB0nhgtgQ6QEp6Kulnb5wtHDJwsgUsCAv2eNFj4E0hxNZ1YnLl9qCU0+DzonUKHpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ttel2A/b; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-54492cc6eb1so4596295e0c.2;
        Wed, 10 Sep 2025 05:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757509008; x=1758113808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sb8UTMBnB9ZvHWVTvvBbSBlx8XsNQb46z3ALMolTZM4=;
        b=Ttel2A/bFzMrA2PqQxGTCe2bhK37KmMvHka9zyVuTRM7HMP+U8Tbt7+BlPs/8kdOdB
         8yoq1F9jVxHaCbwsDVijafcJLit0XPUozymHL8gsWl9Hvv+KjfufF8O7Y7IwG1WMVsjg
         RReJh9QXqixjr3RunAEHN8qLhQ2y6ujupkMridqCp/TZS7S9BKOcNOWMytA13IQcqEGn
         QOdhtMl8UHmt+FkCx73a5VYjW4OJVdfWIfgObK/TyXUHzKLw4weeqyjjb0lFPav/Q8zx
         l9XtEtv+Im5J6P7EfGYn68JJn/sK7oV7gQ4u/dUu93EPWuapOEvI+34+dnQ9Tw9BeKAI
         ct0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757509008; x=1758113808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sb8UTMBnB9ZvHWVTvvBbSBlx8XsNQb46z3ALMolTZM4=;
        b=dQ4+FTeMSmP5xZy5peCLM9CeifjAa30yoQiRXPG6Py8g0Fg+ncjX2rf6oxs1nCIQSU
         WaNP9TYsrcls3LMOt5z5sgMEtSlNj/JBmIGuLPPzdLn++xpnaYOhTvpUmo3XFHLIMbqD
         273Pe1tAf9MSbG7N5wjxZPIjCEkqb/l08B5/bs9pEEXVmAqa/u3e1DTXEuJ76sdm3tvu
         qoj2ZcJ6kBydICT/gXhRf0RgVtU1LmoDM0pXkrGlYEZpRxDTNuScuWYDVX3jXu73bGG5
         IZEO6oOdvBpp225Y54dH0ChL32zZdFy3zvofFLF9PXUZuqZGJ4SCngvwKopKZa5ZY7UR
         F3vA==
X-Forwarded-Encrypted: i=1; AJvYcCVB4Dsp9cC1PZWPk71LGJCa86vPXjkehW8pATCigobzffL7MCrxQuMwZxLTzw7ytNbrSw/wGErMOzY=@vger.kernel.org, AJvYcCVsFjWO/cqFPXNHqTyu3AD+hqns0jkJ72vJJkquLFOjhK+shtV6geq+OnjFHQBlxeC/SxdIOSZcCIC0@vger.kernel.org, AJvYcCWf0EfmyqLe8UgigXJHLWSb12U18Bg4jQK1Q2TvzgUxuDuFi4ppqCs8aLk8dmVMCo5ftobPE+hd3B3WDY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8PJGuoKcr1RBwYkaxk53Q5XY+akdEoZEWx+1p2QsHCTQTugww
	kHMaM+JjeNeVLncCrc1yq7QGwDwl9XSIXdDFD1UOtypoVEA98Pry6GXOueUSrEKmHKEAV4gNMxq
	+HdGk6lSu5553vejYGBahV405WMy72TM=
X-Gm-Gg: ASbGnctEodg77zRu7QID1s7Sf2xibp6dk2aTby8WYdYGARJuLz86BFuFosQtPN2dg2+
	zh+JR20mW7T/5Oqgh3UI1CNy2GF0WISlaCAlF5jDL8b/n2dDAfBkDZN2wpVKKdjWPEZ5GM1I7ds
	gPRa7k48vzSflxVRWZH33Kqqfuuv2z4mKx/iu37ZlnMyM4iCsphmvhdyBYIHxm6eszqauwzyR2m
	O/mf/wsnwgypoO2X7Pr8vmPG/O8rF7cXg==
X-Google-Smtp-Source: AGHT+IGv0enk7fYhOCUXWeXriRP5nJe9zA6ZJ12AwgJXoYDwpTT3uv6N5288bzYDWEt9Jff+/TgZf+T19I96wZzBOtg=
X-Received: by 2002:a05:6122:92a:b0:544:71fb:f49b with SMTP id
 71dfb90a1353d-5472c0d3f98mr4731397e0c.10.1757509008386; Wed, 10 Sep 2025
 05:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <385dccf3-234a-4f83-9610-81ac30bf1466@rowland.harvard.edu>
 <20250909161901.10733-1-ryanzhou54@gmail.com> <2025090959-italicize-silly-f628@gregkh>
In-Reply-To: <2025090959-italicize-silly-f628@gregkh>
From: ryan zhou <ryanzhou54@gmail.com>
Date: Wed, 10 Sep 2025 20:56:36 +0800
X-Gm-Features: AS18NWDBnTEnh2Hh312GhBRiDmM_gIC7GVX0oLT774vf9tj-hQ0o8e7_KViXTHM
Message-ID: <CAPwe5RPxRhvYmoDZF792Vwv638kt+Hk+CYoJJCmcjewGp8NfYQ@mail.gmail.com>
Subject: Re: [PATCH v2] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stern@rowland.harvard.edu, Thinh.Nguyen@synopsys.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, rafael@kernel.org, royluo@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg KH,
Sorry, I didn't understand your question. Are you asking for my patch
commit ID? I've resubmitted patch v3, and the commit details are as
follows:

commit 92bc5086f53404f6d14d8550209d1c8cd3fa9036 (HEAD -> usb-next-develop)

Or do you need the commit that introduced this issue?



Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2025=E5=B9=B49=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=B8=89 00:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Sep 10, 2025 at 12:19:01AM +0800, Ryan Zhou wrote:
> > Issue description:During the wake-up sequence, if the system invokes
> >  dwc3->resume and detects that the parent device of dwc3 is in a
> > runtime suspend state, the system will generate an error: runtime PM
> > trying to activate child device xxx.dwc3 but parent is not active.
> >
> > Solution:At the dwc3->resume entry point, if the dwc3 controller
> > is detected in a suspended state, the function shall return
> > immediately without executing any further operations.
> >
> > Signed-off-by: Ryan Zhou <ryanzhou54@gmail.com>
> > ---
> >  drivers/usb/dwc3/core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 370fc524a468..06a6f8a67129 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -2687,6 +2687,9 @@ int dwc3_pm_resume(struct dwc3 *dwc)
> >       struct device *dev =3D dwc->dev;
> >       int             ret =3D 0;
> >
> > +     if (pm_runtime_suspended(dev))
> > +             return ret;
> > +
> >       pinctrl_pm_select_default_state(dev);
> >
> >       pm_runtime_disable(dev);
> > --
> > 2.25.1
> >
> >
>
> What commit id does this fi?
>
> thanks,
>
> greg k-h

