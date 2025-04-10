Return-Path: <linux-pm+bounces-25095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B249A83FC1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 12:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48FAB18964B6
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 10:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37EE26A0D1;
	Thu, 10 Apr 2025 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cFMo5xIY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA9204F81
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744279149; cv=none; b=dlQJs/1KpdMslEhcI8C7K/m/7D7AMng2Kf/DLjEIot0vfVbeaV/AHe6SZT4VZYvZq0EyY9GBr+PFfYsldT4FjDheZ1R4WPkCoF5GkXDfYH+MZPycior7pkmaJEVqqYoZxXiY+0fR7GSJF3ut8KbF1yVY7sfG7VvSWQztI3QJKg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744279149; c=relaxed/simple;
	bh=to6vm0rC1fbCpBMfSCTmB7z9mZRggxqxOXHu7KnOZC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvJkYeB4N++VSjKsJbHzzXOyECpQ1rue6LMYaanS853KXe2VAIMn2jtBt6s+ZXNOSppbMT2/Nxdxhagn1XSCpVpIcxgotzH23jvm9l/BqbpO55/Iuub44hOvlRREIPO1ORqaQuanPTD5RCndcmrawd3+UUNzaX0aUezyIET7s1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cFMo5xIY; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac73723b2d5so126064366b.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 02:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744279146; x=1744883946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SL0HpDhrZM9n98xZWp9B/ltCY9esMwVPBh6P4iWMURc=;
        b=cFMo5xIYrAr2c5HeWlSfp7z8gUDjwxqpsIX34Is9Ta5jN7oHCCJktI7g9Xo+x1MQQW
         t+nE/7CavbhFwJVgPYWy9p4J8a7ht4TbwYDYt3ELDMBzqjJL8/0hU8iARetGs3IFyR8s
         eUseRaHA9kuDetXm0s0QbFPLLufjm+UHzKOaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744279146; x=1744883946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SL0HpDhrZM9n98xZWp9B/ltCY9esMwVPBh6P4iWMURc=;
        b=TPw5vALtYwdk7vTbhziX8dFX/lGFzKKoi7HgcROOP5qFolP8l6SgmxffixvrmpBTn4
         P35yXQOrLqFsfcBdzQp3C+ubOJ97ltLfvNPcG3TZdrlA6dcAmOEhHKSWknSv1UxCHXtf
         FaZ3d4089iBiJvixGNTZAvy2V/3QbCI1pKRLmRmDANQTOWArQtaGslKey9nu6zXelkUn
         3wvFxHTcWeguSUSofMmtMgSkTCylGFgeVs2KZwIJL9kzsPpd25opUBNkOOrzL64//U61
         FvAzVmEsbN1nxU2mhZVSSWQieshWKN/fZDXVEDvh/Ynb77kRPYx7xpyRoruecZbL2H9P
         GNsA==
X-Forwarded-Encrypted: i=1; AJvYcCX6hZFhuSZUpcvRK9He1qOqz1GE1eODxuOA29kIZ4mwUV2yJIn+VslKBoIWbYN+OZf9hcvcuerwag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf9cjG0OYV3Ld/QfNtG3xKZPljvCeeNNed/JVVE6D3JjsqRMEh
	yUrTxkqhb/oi/8wg5PCGWNpdSc3ZE35eNp8Kj87sY4llHcoglGv/GyYYOk4oJ8sUqQocT+99/dQ
	=
X-Gm-Gg: ASbGnctEQncOnkftRqQZr2fKP45cQfes7H85NVrfr2NspfTtafh519R7kZeqzLlZpTk
	cK9OYcO+VBY18sGk2DoYqSYCYPew6zieYIz0W2HdxVoRVFT6S0ot94Ial0AIY+I3mIRxmybzcHF
	X+9DTuuSG9AhBCqQHh8BdIcVn83aCtvDQet+2CUm1HI+TnnWLrtVrYzvmapA/E7F2pK/VKYKCzP
	dCLucBSnuefn6kc328p1IcBqJs+IcRuruHjnP+jPwPFapZ913Jr1MUAehqtDfZENZNL1NAfkF0+
	vaV/6GlQVH2dL1JkGzxKhO60y4oCyTch2Ny8JwoCn+njJIKFLFL4mJPHzzby5rjHLP0X9bo7p9Y
	J8g8Rjq4=
X-Google-Smtp-Source: AGHT+IH7E71Fge67ntd1MjojJ5GI7mGqRu26tN7CdSryn9asreTf5KXANLTh+HloGkFMef+5wnL22g==
X-Received: by 2002:a17:907:6d05:b0:ac7:1be2:1a79 with SMTP id a640c23a62f3a-acabd123a94mr151674966b.4.1744279145828;
        Thu, 10 Apr 2025 02:59:05 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be9404sm248468566b.56.2025.04.10.02.59.05
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 02:59:05 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e789411187so6468a12.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 02:59:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmGyzjFTW/yj/lL9hRXmGwMOT2AtgIXcXyREk89+cfVX/uDX5Alzq4nP6QErZoU/S47AyLmyRVcw==@vger.kernel.org
X-Received: by 2002:a50:955a:0:b0:5de:bcd9:4aa with SMTP id
 4fb4d7f45d1cf-5f32be7ca56mr44710a12.3.1744279144410; Thu, 10 Apr 2025
 02:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-temp-v1-1-9a391d8c60fd@chromium.org> <CAJZ5v0ixiiSiGvc_8D8YxK22yKOAzkdrNaMNjydOHD7gQVc9tQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0ixiiSiGvc_8D8YxK22yKOAzkdrNaMNjydOHD7gQVc9tQ@mail.gmail.com>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Thu, 10 Apr 2025 17:58:27 +0800
X-Gmail-Original-Message-ID: <CAHc4DNJs-tq+KbukyovABkp8-GEbia3KfgEURcNqqRiJ2vvwyA@mail.gmail.com>
X-Gm-Features: ATxdqUH6chIPMhKRb7zUFrIDu_id5vmjZQ0E6lQUwzdQ0QTxOC9fNvtyIJfZVTE
Message-ID: <CAHc4DNJs-tq+KbukyovABkp8-GEbia3KfgEURcNqqRiJ2vvwyA@mail.gmail.com>
Subject: Re: [PATCH] thermal: sysfs: Return ENODATA instead of EAGAIN for reads
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 1:31=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Apr 9, 2025 at 11:13=E2=80=AFAM Hsin-Te Yuan <yuanhsinte@chromium=
.org> wrote:
> >
> > When userspace nonblocking reads temperature via sysfs, EAGAIN error
> > returned by thermal driver will confuse user from the usual meaning of
> > EAGAIN, the read would block.
>
> Why would it block?

I mean EAGAIN returned by nonblocking read implies the read would
block (source: manpage of read)
>
> > Change to throw ENODATA instead of EAGAIN to userspace.
>
> Casting error codes tends to be confusing.
>
> > Also, ENODATA more accurately reflects that data is not currently avail=
able.
>
> It means something else, "try again" vs "no data available (possibly at a=
ll)".
>
> The error code comes from the thermal driver and if it wants to say
> "try again" then this is what it wants to say.

Yes, but EAGAIN has special meaning when returned by nonblocking read.
Hence, we need to avoid returning EAGAIN to userspace and ENODATA is
the most suitable alternative in my opinion.

>
> > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> > ---
> >  drivers/thermal/thermal_sysfs.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_=
sysfs.c
> > index 24b9055a0b6c515b865e0d7e2db1d0de176ff767..3d1713e053dfb867933d951=
31f1f2491d2ecd07e 100644
> > --- a/drivers/thermal/thermal_sysfs.c
> > +++ b/drivers/thermal/thermal_sysfs.c
> > @@ -40,8 +40,11 @@ temp_show(struct device *dev, struct device_attribut=
e *attr, char *buf)
> >
> >         ret =3D thermal_zone_get_temp(tz, &temperature);
> >
> > -       if (ret)
> > +       if (ret) {
> > +               if (ret =3D=3D -EAGAIN)
> > +                       return -ENODATA;
> >                 return ret;
> > +       }
> >
> >         return sprintf(buf, "%d\n", temperature);
> >  }
> >
> > ---
> > base-commit: a24588245776dafc227243a01bfbeb8a59bafba9
> > change-id: 20250409-temp-6ebd13ad0dbd
> >
> > Best regards,
> > --
> > Hsin-Te Yuan <yuanhsinte@chromium.org>
> >
> >

