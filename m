Return-Path: <linux-pm+bounces-1245-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2BB815F98
	for <lists+linux-pm@lfdr.de>; Sun, 17 Dec 2023 15:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8551F21E06
	for <lists+linux-pm@lfdr.de>; Sun, 17 Dec 2023 14:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE8C44394;
	Sun, 17 Dec 2023 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ad7ET35A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E3344C65;
	Sun, 17 Dec 2023 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c824b199fso11532215e9.1;
        Sun, 17 Dec 2023 06:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702822595; x=1703427395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QE9LT5uKY7JsupABUBOBD9RMHYXjaUg8xO88EJrYaiI=;
        b=ad7ET35At84zRVG5iBN9bHnBzMCm5UonhOYE/Igc7vy3MHULFqYlw4kbaqJkZ8+n44
         ZN8/mfGNtylQJgSOjztV7J3spuR/PTgPUn20sEj7QjK3FibupqmZBYyrJCr6oKd8tWti
         UDPbJeocZPBxmBaqvrBsVZn1oEKPUvEqf+R+xLmfnF0jHZymNdRE684INZCLhkukBVsw
         ZevkxNuvdDaoO53e5ST409Z1V2RYVSOHFzzjnIG4hH0ZP808rHkSL7tzLZZEUXhWOLl0
         F5M6w7WYj9KoIG0YRiIcGlVh/aaUS+GecXCAXC2LcXSAm2DY5kQItfT5dXGtfwdlxb6u
         hjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702822595; x=1703427395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QE9LT5uKY7JsupABUBOBD9RMHYXjaUg8xO88EJrYaiI=;
        b=oDVWHamIO96GVciKpwORNUmU1CnrvBZseMW6zo+K1qx4kEAV3TAmpymW48WmNceTfn
         xDnchN9BFKPG4+j2o026AYi1BUbLROHtQmJ+ulm2MSqClA0VSsbe3AKXOVhyJlt1cRmh
         3mJNSO1i6BCKemdC1xumCC0fdxD85P42DFX+jKD+QyrL/tWhVJa5hdnuR+/KL5+yFC/H
         IvJaeCJZVuBT80YlH8uuXCHlPdZBh8t5fpf4stoFplO6ZTF1nGVeeyW38sUESwboPCWw
         9LV1+ovdhsLFgjHuLk2W9VsNE1hehmNIO0xUl+7FVbA4gyROJmhiRP40A1c9tzabl4j0
         aDYQ==
X-Gm-Message-State: AOJu0YxqaIhL88OjcO1DIerKTwLjhQ3DUzlkFSeLvZK8iJMF14nJuMGQ
	BtsqvBXE/goWvP8vklQQfP2XUC2Q+dKeXA3x2jM=
X-Google-Smtp-Source: AGHT+IExjfuW3jpa3SoAweUUhttwxY1n4WMOilHgVfSu02tbiEGYUETmuPVXW8HjArsYt2iXhbv/LkNJ28MdXpL/zFs=
X-Received: by 2002:a05:600c:21d4:b0:40c:36ff:7513 with SMTP id
 x20-20020a05600c21d400b0040c36ff7513mr7155285wmj.164.1702822595053; Sun, 17
 Dec 2023 06:16:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128005849.19044-6-andre.przywara@arm.com>
 <a14fb458-caf0-4a4a-b76b-c2503b0840d2@gmail.com> <20231211000528.57cb646c@minigeek.lan>
 <CALHCpMjz4YiE_=6Cxq7RqF_3qPaw8UCA=6eLy9ZZuofRhr7mcA@mail.gmail.com> <20231214095914.4a98ba8c@donnerap.manchester.arm.com>
In-Reply-To: <20231214095914.4a98ba8c@donnerap.manchester.arm.com>
From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Sun, 17 Dec 2023 18:16:23 +0400
Message-ID: <CALHCpMj6+J7xDO0EGut=hmJxXONXrgQoHTQ3vVzdk_97g6BzkA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] thermal: sun8i: add support for H616 THS controller
To: Andre Przywara <andre.przywara@arm.com>
Cc: anarsoul@gmail.com, bob@electricworry.net, conor+dt@kernel.org, 
	daniel.lezcano@linaro.org, devicetree@vger.kernel.org, 
	jernej.skrabec@gmail.com, krzysztof.kozlowski+dt@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, lukasz.luba@arm.com, martin.botka@somainline.org, 
	rafael@kernel.org, robh+dt@kernel.org, rui.zhang@intel.com, 
	samuel@sholland.org, tiny.windzz@gmail.com, wens@csie.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andre,

=D1=87=D1=82, 14 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3. =D0=B2 13:59, And=
re Przywara <andre.przywara@arm.com>:
>
> On Tue, 12 Dec 2023 21:09:45 +0300
> Maxim Kiselev <bigunclemax@gmail.com> wrote:
>
> Hi Maksim,
>
> sorry for the delay.

Now it's my turn to apologize for the delay :)

>
> > =D0=BF=D0=BD, 11 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3. =D0=B2 02:48,=
 Andre Przywara <andre.przywara@arm.com>:
> > >
> > > On Sat, 9 Dec 2023 13:44:34 +0300
> > > Maksim Kiselev <bigunclemax@gmail.com> wrote:
> > >
> > > Hi Maksim,
> > >
> > > > Hi Martin, Andre.
> > > >
> > > > May I inquire? Why do we need a separate sun50i_h616_ths_calibrate(=
)
> > > > function? Why can't we just extend an existing sun50i_h6_ths_calibr=
ate()?
> > > >
> > > > At my glance the calculations in both functions are the same. We ju=
st
> > > > need to handle a special case for the 4th sensor.
> > >
> > > You seem to be right, they are indeed the same, just written slightly
> > > differently. Do you already have any patches that unify that?
> >
> > No, I don't have any patches for that yet. But I can do it if you told
> > me where to
> > send the patch. Should I put it here as a reply?
>
> Can you make one patch on top of mainline, that prepares the existing
> sun50i_h6_ths_calibrate() function to deal with four sensors? I would the=
n
> include this patch of yours in the next submission, and put Martin's H616
> patch (now probably just the struct ths_thermal_chip) on top then.
>
> Please send this patch just to the list (CC:ing people like Martin and
> me), starting a new thread.

You can find my patch here:
https://lore.kernel.org/all/20231217133637.54773-1-bigunclemax@gmail.com/

Best regards,
Maksim

> Many thanks,
> Andre
>
> > > I don't know if Martin or I find time to do it this week, but we coul=
d
> > > also optimise this later.
> > >
> > > Cheers,
> > > Andre
> >
> > Best regards,
> > Maksim
>

