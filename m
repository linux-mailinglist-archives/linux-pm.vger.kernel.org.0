Return-Path: <linux-pm+bounces-34072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD43AB475CB
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 19:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82939566AEC
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 17:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7930269B01;
	Sat,  6 Sep 2025 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njJ4kGuJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A50266EEA;
	Sat,  6 Sep 2025 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757179347; cv=none; b=DnevCofxN5YnPt2luHX2Hwh7t+MM0J5nu9JpeUx/spgHPzpHwSmi8vjQ7oDcAet03CMMgp+piJASnJROCW6ZsBw4e1HC3dfJlX7f3nO4jMDWLInYMepr/eSofjb0yCROvdJb/VBVNVfUVHb3GssTMMM6I6adwMzuCw4AdQQLpL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757179347; c=relaxed/simple;
	bh=MJPdRrONakWXxOxEQWgsQYVE/bfwQLRKAPlHNaeeTlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8yJzD59d15wTsdsi80NxA/nk7l6uZe/z3qo+UBpS15ouhe5qwd2edNl4N3m0PQFjr+cF9dLp3WR2tGA7obq7oJI15GuZXZU+IgSov9U+vYRrMD1ZHqtsonDvey5xbv1znyMJk8Vtfp1jCKohwIE5JE4VxVZjsQTDP74zD6kCc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njJ4kGuJ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b04b869abb9so62792866b.1;
        Sat, 06 Sep 2025 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757179343; x=1757784143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/hMIupBscvuO4EPQ/Tt0MsH4XbYqSn2Fhm3xvRpI+s=;
        b=njJ4kGuJmZtNI/Vo7pyQPqP1fopcQ13SCBZEkGxNkgxnT5SWblmxbwrzt+hJgBe8jH
         Wo+Gp5ZT3mGu/jIMb7rZwhi1I0AFcrNyFC0xaHHT8OANboPnANxZSJNHQMpn1FmBzmT7
         4MYfqCgWwFyvBcJIB2G5n+ixaOOOkdXL7HNHhRX7reThmbPnKxz+U0I1PVpBqFZ/ISLs
         JtsQVFk6UnWw4Qz9TZ5YJxwg2iH0vRSaaT9NqHB404g/kZ7nDanAQbkmmgHw97TelpJH
         MFZCpvFV8f7iLyvaE97elUDxHV8Sb48P6S4HjmkO8hVK3k1uWuoPOnE/aeQVrA2itzVM
         axjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757179343; x=1757784143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/hMIupBscvuO4EPQ/Tt0MsH4XbYqSn2Fhm3xvRpI+s=;
        b=QzEBnFhR8CLOEbh8tfBf4DxvCaNs41w/zJG74atC2c2lTjvLje4R7aGo7d/zgEyxDR
         7sXuzkX8XxAmjCMCkaF8xkKKRTG/JCPZDbVM/iFN9ojVyuUKUCRae0h0x/z56dft2Fx9
         UjtOJ+r50OjfQH0p6NwwXA3zsL3zVDNkl/6123DDi8JLcrq/eIulBquIILEt1Zc6z8Ai
         cO0suOrsnd8KiOcxFrSmylXLeVWsLqPL/xsK3Wnc3Kb2iWJxwx3rEcSIkoryYlJtulqI
         YWaNeMnpqu2ndasf/eVr1Tf0LvW5mXtQMFY+dtxgSNv6tHLxdQk73CpV5nfKcJSJKuXV
         ssoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcxnkhCpSi1CZBL6jeTrE6VK43U6bOhjMIbkqBg4Gz8GCSwLfd3qxXc9vvGPWMzzw/MlHLYL7UwMRyZK4=@vger.kernel.org, AJvYcCWhTS4iOeuTZLWXg/Pq8S0sCB1I5EUPrrCT3W0qQyiOYmVXTkMR82Up78ZwZ5X7GD/72rr1pfUf0Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeYDsn0MZ2oQ0gicKnqfeSivKrYqMP1x2kQM+GDCAGrWv76Yw2
	hLnToPxowDLYGo3F3M9wTn5bK2+jBnnbMOX1PPvtEoy/DBfNxivLGqATGoFdDbnIeFj5JMnthtz
	W32QwjreiHmUIF4TYmIopkesiOZ+aIpA=
X-Gm-Gg: ASbGncuN/NZHnIofffKJy9CVlI6ziGN99Ij6iteeenm8t2bvWaTW7rjbiAaG4ynGfDn
	ssGPiPZ0HGGHFOvCbE4Ph6mSZXZAXf7UxLDH1oC5vFgWyFGE0JuVQQljQqqarg5KIuaLcWbIdFy
	Hi132NoAnUFKqT6DrrfbRexKwfKcuaTwjbEVVgYctzgSYEJQ8k5OM1yLhLrld+iWJQsZ5zxjIe1
	iZSxeEpWDE+PzeENEbpQBe3McENOQVffZ5rI0fOC2a6IaiRiQ==
X-Google-Smtp-Source: AGHT+IHPrzgQMbrXWR06J3+2IY2pmoNozG9f+sOFa1muRT0XJT0J6CNFJbzQzFAMI7vcEmflXtRpDCuqd7TNeACKbpI=
X-Received: by 2002:a17:907:9410:b0:b04:ac31:cd31 with SMTP id
 a640c23a62f3a-b04b1451f7fmr257815766b.18.1757179343315; Sat, 06 Sep 2025
 10:22:23 -0700 (PDT)
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
 <CAJZ5v0iAfgE4RkVXH7GaG9SqvGa0VfVuFi_cLd0utC8oPY0Fkg@mail.gmail.com> <99c1c03a9f7fe55b8f73e5574612dc3e1cd1af55.camel@perches.com>
In-Reply-To: <99c1c03a9f7fe55b8f73e5574612dc3e1cd1af55.camel@perches.com>
From: vivek yadav <vivekyadav1207731111@gmail.com>
Date: Sat, 6 Sep 2025 22:52:11 +0530
X-Gm-Features: AS18NWATrau_XSgNpQXKBMdEXPkIlXn_qvi-65LrRfyCeYLtq6uJjOq-XKj3GvA
Message-ID: <CABPSWR6uKR0fz1-jJcJ1_JCsBbXhHioUe3o02DMSP8T18y1T1Q@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: sysfs: Use sysfs_emit/sysfs_emit_at instead of sprintf/scnprintf
To: Joe Perches <joe@perches.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>On Fri, Sep 5, 2025 at 8:22=E2=80=AFPM Joe Perches <joe@perches.com> wrote=
:
>>
>> On Fri, 2025-09-05 at 22:57 +0530, vivek yadav wrote:
>> > On Mon, Aug 25, 2025 at 8:58=E2=80=AFPM <vivekyadav1207731111@gmail.co=
m> wrote:
>> > > >
>> > > > From: Vivek Yadav <vivekyadav1207731111@gmail.com>
>> > > >
>> > > > The ->show() callbacks in sysfs should use sysfs_emit() or
>> > > > sysfs_emit_at()
>> []
>> > > > diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
>> []
>> > > > @@ -22,21 +22,21 @@ static ssize_t show_available_governors(struct=
 device *dev,
>> > > >                                         struct device_attribute *a=
ttr,
>> > > >                                         char *buf)
>> > > >  {
>> > > > -       ssize_t i =3D 0;
>> > > > +       ssize_t len =3D 0;
>> > >
>> > > The variable rename is not necessary or even useful AFAICS ->
>> >
>> > There is no harm if we leave the variable name as 'i' but it would be =
better
>> > if we give it a suitable name like 'offset'. It will definitely improv=
e
>> > readability.
>>
>> size and len are most commonly used.
>> I prefer len.
>
>Fine, in new code, use whatever you like, but what really is the
>reason for doing a rename in code that has been almost unchanged since
>2.6.22?

Hi Rafael,

You are correct that the variable name =E2=80=98i=E2=80=99 has remained unc=
hanged
since v2.6.22. Its long-standing presence is understandable, but it
doesn=E2=80=99t necessarily mean it can=E2=80=99t be updated in the future =
if needed.

As @Joe pointed out, statistics show that most developers prefer using
more descriptive names such as =E2=80=98len=E2=80=99 or =E2=80=98size=E2=80=
=99 when possible.

With this in mind, I believe it=E2=80=99s time to bring this discussion to =
a
conclusion. Shall we move forward with this change in variable naming
=E2=80=94 YES or NO?

Looking forward to your input.

Best regards,
Vivek

On Sat, Sep 6, 2025 at 12:43=E2=80=AFPM Joe Perches <joe@perches.com> wrote=
:
>
> On Fri, 2025-09-05 at 20:34 +0200, Rafael J. Wysocki wrote:
> > On Fri, Sep 5, 2025 at 8:22=E2=80=AFPM Joe Perches <joe@perches.com> wr=
ote:
> > >
> > > On Fri, 2025-09-05 at 22:57 +0530, vivek yadav wrote:
> > > > On Mon, Aug 25, 2025 at 8:58=E2=80=AFPM <vivekyadav1207731111@gmail=
.com> wrote:
> > > > > >
> > > > > > From: Vivek Yadav <vivekyadav1207731111@gmail.com>
> > > > > >
> > > > > > The ->show() callbacks in sysfs should use sysfs_emit() or
> > > > > > sysfs_emit_at()
> > > []
> > > > > > diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> > > []
> > > > > > @@ -22,21 +22,21 @@ static ssize_t show_available_governors(str=
uct device *dev,
> > > > > >                                         struct device_attribute=
 *attr,
> > > > > >                                         char *buf)
> > > > > >  {
> > > > > > -       ssize_t i =3D 0;
> > > > > > +       ssize_t len =3D 0;
> > > > >
> > > > > The variable rename is not necessary or even useful AFAICS ->
> > > >
> > > > There is no harm if we leave the variable name as 'i' but it would =
be better
> > > > if we give it a suitable name like 'offset'. It will definitely imp=
rove
> > > > readability.
> > >
> > > size and len are most commonly used.
> > > I prefer len.
> >
> > Fine, in new code, use whatever you like, but what really is the
> > reason for doing a rename in code that has been almost unchanged since
> > 2.6.22?
>
> If a sprintf -> sysfs_emit conversion is done, it's IMO better
> style to be consistent with the typical sysfs_emit uses.

