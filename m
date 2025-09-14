Return-Path: <linux-pm+bounces-34605-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FC8B56A27
	for <lists+linux-pm@lfdr.de>; Sun, 14 Sep 2025 17:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B35B1897685
	for <lists+linux-pm@lfdr.de>; Sun, 14 Sep 2025 15:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8780C2D97A4;
	Sun, 14 Sep 2025 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0actOFo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D063D1FBC92
	for <linux-pm@vger.kernel.org>; Sun, 14 Sep 2025 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757863231; cv=none; b=nJ+YPynMRapuLi/Ki03+ozzatf6hAUfuUfy1VoOW6mJP5NAe0I1rc/IJkL0dNkhK/Qw7qhuybfl25BBgd2rxoFvSpO0ZfjC9M59EcsboSdMnu2FekRYjjC24B9CZHYPD9HeFwMpAu3rrIkLJMOKHQNrAY8+/TMLVugDgT7ksBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757863231; c=relaxed/simple;
	bh=8k+nJtDsuoPZkKT6XUJmXpNomth89X9LTT+a3orMk8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERiXZXGb2QKTC8jv6NpFM5ovgB562zN83fOZGUm6sHJQYzExIFCQhaDA0vq53BrOoQg3MVZUtqIIm9o1LJfhE7QMmpVQh6NZDjxmRwc3vAaN2Kk/aasT6QeB94wUtksmi8Tx0+MtvWX1dwqYb+u7BzOx8o5mCDoCaI9H+d+QFcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0actOFo; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so3964308a12.1
        for <linux-pm@vger.kernel.org>; Sun, 14 Sep 2025 08:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757863228; x=1758468028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAX4epvx2yfbrAYRoI1Myq8YDs/AsdoHkdS8EZpoCP0=;
        b=g0actOFoVOYITrJTb1jrkG/I95HQwpX83oJXH3WimLosYChnuNo5U686JVd2uyUiiC
         wxiQQtzJ9GcqKydocvk9b/DZLJJBCNFM/ExzrJSlugPQ4VzRJjyaCQ3nBaQbXM/b0+S0
         thTjdctMcUIifR7Qv0Y18t+FknY68JDHACQDr2OXYizOxdkCL/M4431cJPt9Bz7vg2ab
         2z5RVjPiZxw+hYUDwDeGlwL9SnYo18ko4RK3QCQO3jTnH9oGTzbELt6cp8qMlNna6UaG
         o0CU4Lo/Dns3CtFTxW6sbCsAVaAqWsQLToYA9N1H+3UUbgXn74te/mgkC0sj9RFFgqb3
         /wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757863228; x=1758468028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAX4epvx2yfbrAYRoI1Myq8YDs/AsdoHkdS8EZpoCP0=;
        b=h61W2TVzKPHq8hMekUYP+sc5+1RxySyNyw5qTFZTCWomnbjU5niDUKUdQL3a0AoPv7
         aRRcR7TP6VwjyCKhQ2mzZJ75BfTuiOVqBYAK6PupyUI0n8jUJSaUz++kG3VIW+XZbAFU
         x1Ms+IXQ2z2xzdgtzUh1IMDdKG/k//OqVfbWdqLrhREjppBmCBwziCi3W7PyvbCBVSV1
         A9un175le0SWAyTgqb7kl5aYE+bEF/whaaojGD6gDK1jrZ6Pr7f5sBolr0OTLU11zTtX
         MvkEIrGGetu8Utezuf3PgtH6z1RSM8K9IgEGYTxfDb05SRX5KZt6NsKSirqjtQHgmhaL
         3H6g==
X-Forwarded-Encrypted: i=1; AJvYcCUjqqt4ybq4QToThxInxmt1y/rduh/x5XxtAjkSsj4y1HFqKfv65Stz2/EMrgZpHtOxObx32vFSvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxonQ1zIjvqE9idMeY7YVJ0/tAGN/GXAxRX2/X0zN4KksV27URr
	oFM4PQr7lqGe44ylcZy7KWCG5AeEDP3DdBH82Rwa1FXRoL+6myu3vV5LHQk3VNmnr0WVCH1eK67
	266qx/MbzrZ+rTMkHEqWaM7nIOXihWoU=
X-Gm-Gg: ASbGncuc7FaY0lIuRBFj1V16OEF9Oa6t575vYKgJzsUuPqXT101GUvIBpQnyETDfzab
	h1AA4rK9r7lIf3E+STHfl6x0SQMvtASTPHuch5cqR2ZZP3DyUHJQ/Na2Hd2mA433Hla68oRdqn/
	A/1/D0dr8a96bjepmbpBRAwV7Njdqd3vz1QITPgrdOoxj66SFiPNmx4aOaa5CeCzIR1ijF/NvIJ
	fz0fD8J/2A8qNWuCAIbGVJFWo2Ylw6YMnR1Gnmt
X-Google-Smtp-Source: AGHT+IFoUsbKdgvI7DUejNdZApGLucGmUXzgKN910ohumYEzbO+YqD5vnc8n/gSlGLo4Mx79goBc79Q3vctUqPXpjLE=
X-Received: by 2002:a05:6402:21d1:b0:628:bee2:b31d with SMTP id
 4fb4d7f45d1cf-62ed8240c8bmr9077078a12.3.1757863227989; Sun, 14 Sep 2025
 08:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825185807.57668-1-vivekyadav1207731111@gmail.com>
 <CAJZ5v0gfrTvLgs=PdmRbRRN05GE4Bk8Q7hJdtQfyk3VqaOz7FQ@mail.gmail.com>
 <CABPSWR5cG=xTA72BHayYQTb=24VS3N+=dbsiMcU+gyqTKvNXAQ@mail.gmail.com>
 <2fb11c0970da307cf8cf4f35d35c49f78f82ee72.camel@perches.com>
 <CAJZ5v0iAfgE4RkVXH7GaG9SqvGa0VfVuFi_cLd0utC8oPY0Fkg@mail.gmail.com>
 <99c1c03a9f7fe55b8f73e5574612dc3e1cd1af55.camel@perches.com> <CABPSWR6uKR0fz1-jJcJ1_JCsBbXhHioUe3o02DMSP8T18y1T1Q@mail.gmail.com>
In-Reply-To: <CABPSWR6uKR0fz1-jJcJ1_JCsBbXhHioUe3o02DMSP8T18y1T1Q@mail.gmail.com>
From: vivek yadav <vivekyadav1207731111@gmail.com>
Date: Sun, 14 Sep 2025 20:50:17 +0530
X-Gm-Features: AS18NWA5MnTxW52jaWoActttcI8oI6C9FzhQLxTYHfGoPcsoBk7tygFSKvGAp8w
Message-ID: <CABPSWR4kcdwEvC6zMTOGgME4ZDPpOsdtjheD8ZgTa0iaTqQwhA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: sysfs: Use sysfs_emit/sysfs_emit_at instead of sprintf/scnprintf
To: Joe Perches <joe@perches.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi @Rafael J. Wysocki ,

Is there any update for me on this patch ?

~~Vivek

On Sat, Sep 6, 2025 at 10:52=E2=80=AFPM vivek yadav
<vivekyadav1207731111@gmail.com> wrote:
>
> >On Fri, Sep 5, 2025 at 8:22=E2=80=AFPM Joe Perches <joe@perches.com> wro=
te:
> >>
> >> On Fri, 2025-09-05 at 22:57 +0530, vivek yadav wrote:
> >> > On Mon, Aug 25, 2025 at 8:58=E2=80=AFPM <vivekyadav1207731111@gmail.=
com> wrote:
> >> > > >
> >> > > > From: Vivek Yadav <vivekyadav1207731111@gmail.com>
> >> > > >
> >> > > > The ->show() callbacks in sysfs should use sysfs_emit() or
> >> > > > sysfs_emit_at()
> >> []
> >> > > > diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> >> []
> >> > > > @@ -22,21 +22,21 @@ static ssize_t show_available_governors(stru=
ct device *dev,
> >> > > >                                         struct device_attribute =
*attr,
> >> > > >                                         char *buf)
> >> > > >  {
> >> > > > -       ssize_t i =3D 0;
> >> > > > +       ssize_t len =3D 0;
> >> > >
> >> > > The variable rename is not necessary or even useful AFAICS ->
> >> >
> >> > There is no harm if we leave the variable name as 'i' but it would b=
e better
> >> > if we give it a suitable name like 'offset'. It will definitely impr=
ove
> >> > readability.
> >>
> >> size and len are most commonly used.
> >> I prefer len.
> >
> >Fine, in new code, use whatever you like, but what really is the
> >reason for doing a rename in code that has been almost unchanged since
> >2.6.22?
>
> Hi Rafael,
>
> You are correct that the variable name =E2=80=98i=E2=80=99 has remained u=
nchanged
> since v2.6.22. Its long-standing presence is understandable, but it
> doesn=E2=80=99t necessarily mean it can=E2=80=99t be updated in the futur=
e if needed.
>
> As @Joe pointed out, statistics show that most developers prefer using
> more descriptive names such as =E2=80=98len=E2=80=99 or =E2=80=98size=E2=
=80=99 when possible.
>
> With this in mind, I believe it=E2=80=99s time to bring this discussion t=
o a
> conclusion. Shall we move forward with this change in variable naming
> =E2=80=94 YES or NO?
>
> Looking forward to your input.
>
> Best regards,
> Vivek
>
> On Sat, Sep 6, 2025 at 12:43=E2=80=AFPM Joe Perches <joe@perches.com> wro=
te:
> >
> > On Fri, 2025-09-05 at 20:34 +0200, Rafael J. Wysocki wrote:
> > > On Fri, Sep 5, 2025 at 8:22=E2=80=AFPM Joe Perches <joe@perches.com> =
wrote:
> > > >
> > > > On Fri, 2025-09-05 at 22:57 +0530, vivek yadav wrote:
> > > > > On Mon, Aug 25, 2025 at 8:58=E2=80=AFPM <vivekyadav1207731111@gma=
il.com> wrote:
> > > > > > >
> > > > > > > From: Vivek Yadav <vivekyadav1207731111@gmail.com>
> > > > > > >
> > > > > > > The ->show() callbacks in sysfs should use sysfs_emit() or
> > > > > > > sysfs_emit_at()
> > > > []
> > > > > > > diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.=
c
> > > > []
> > > > > > > @@ -22,21 +22,21 @@ static ssize_t show_available_governors(s=
truct device *dev,
> > > > > > >                                         struct device_attribu=
te *attr,
> > > > > > >                                         char *buf)
> > > > > > >  {
> > > > > > > -       ssize_t i =3D 0;
> > > > > > > +       ssize_t len =3D 0;
> > > > > >
> > > > > > The variable rename is not necessary or even useful AFAICS ->
> > > > >
> > > > > There is no harm if we leave the variable name as 'i' but it woul=
d be better
> > > > > if we give it a suitable name like 'offset'. It will definitely i=
mprove
> > > > > readability.
> > > >
> > > > size and len are most commonly used.
> > > > I prefer len.
> > >
> > > Fine, in new code, use whatever you like, but what really is the
> > > reason for doing a rename in code that has been almost unchanged sinc=
e
> > > 2.6.22?
> >
> > If a sprintf -> sysfs_emit conversion is done, it's IMO better
> > style to be consistent with the typical sysfs_emit uses.

