Return-Path: <linux-pm+bounces-20616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2304A14ED7
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 12:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A583A8D5B
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 11:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02AE1FECA6;
	Fri, 17 Jan 2025 11:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJTVlowI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A3C1FE45F;
	Fri, 17 Jan 2025 11:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737114834; cv=none; b=NxcJdkIOsy621Tn5Li8GngTDTWiw0C5FUM497NhWJ3gjUkSeQF1tbfAyhQbkhvVfAaStaxYlftctm8MgUlYG+kPYgh8j7Lvg09kslVicsz6Gn4M7+iITq+afz02Q7jc2qqDjo54vnciWmtG9rlBjNkcgYGfAd2QkucL1jSNUpuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737114834; c=relaxed/simple;
	bh=czFmOPqjuV/Og92CfVO759ZUYmPZ1n3XMxdg4+9Hxes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0xnQQ20XOY8YhLJ3bthUFsWQwnOT1hIu6quozuDw91grwUo1PtKy8xmHXXVNP48sir9RiN5hwX62rCnBokWTOrtotUWc4acaCOnQjoxnZJblUFVD8miuK2/G2yLAL0KhZanOgt4ZeOWVyt1sm/bMyAYOVwb3lNpY3n5AyLWpis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJTVlowI; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86112ab1ad4so479970241.1;
        Fri, 17 Jan 2025 03:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737114832; x=1737719632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3DdFeKyKYxzEcK5cCNGdU/vTMq+Ez0rcnFpSG8fnec=;
        b=gJTVlowIfI2t2VPB+s7ojZZylY2p8Qj6yvqN9lli4tG5AwvMteEj+OMF0x+ha63qxK
         9U4xfZ/r9hEglHN+cYkeEK1G9RcidE/rhy4I9p+X3VkJo654gnjv9G39qOyO8nnDLEKk
         OAbMlsAjkhTmDCcKRj0Ozrp+GTp4k23AGJKRXH4oVPOfKXHcEiNoIQf7xThDf5hif6rB
         YDpYqoD8vhNi5Q1EPpOFv+5S1PmOaIeTCIoz1TiHz0ss3WOugWViQdO2R/hm4ajFhnu1
         oTxpWfddXPRXZXpqimTCKWt4+nDORk6ANpC3pWVsxd/vOXxVavT9Zmrpv/srMJXJN//g
         Yang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737114832; x=1737719632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3DdFeKyKYxzEcK5cCNGdU/vTMq+Ez0rcnFpSG8fnec=;
        b=j6AYRu7g1AM4xS4cTi6rOPpxnBv4zhuRTFTYeOfQKje9obJPO59F4xKC9vysAgC+Ea
         p1JfF62tRIR7okafNjjkCl3/NR8xV0rrirmruoR7WRiQgDMkZ3N/PHFW02SIYTtf8RVy
         p1HsFN1+RmqZU+Poi4OsOAEZRNZ9kS+DeL8rn9w1856OOQm3OvVZjQaxZdkT28fmFmF9
         8bWZvWxjtkKCySgTgJ/n3KfvMr3HzVYpdW6HQuruaV9mSIc4dqFfIsfrqe2r7lKuHgn8
         RdTafxTw4NtbeMFUE1tQ30ClZUdJnyIJLx40kLVRkiElCwwPALa53cci1CScHP2yEf6U
         aRZw==
X-Forwarded-Encrypted: i=1; AJvYcCUbcmSupAN9C/U45XzG94FfUsytiuXPppiFeFTaU82txDbw0ybPPfPdtu5bq1WrvUGL/xfphhMFr1w2W2ZN@vger.kernel.org, AJvYcCV5qHAjDUwl6qU3vEKxSyBLgV8u0OO2Xc+CjVqthfHRnbH8LF/F8yNroKVCIhNsYfNVJ96kxa3o9K+V@vger.kernel.org, AJvYcCVOwC/OthSQc7HJDLNdiTAjOLxDbicPSlYgFQOTlncMFNLdpb7oYREcV7F0N2vp2qsxxCcKnsJV4vE=@vger.kernel.org, AJvYcCWNKCxYfza+PjVQd14gHqS+aXJxOOSaoVVTAV/8mIzG9Ddbs8lDydC/fEMDIfJiFpv/hZinJYac74HcwA==@vger.kernel.org, AJvYcCXF5zJNpM31ismtleU/nP8Ra/iNFYxDvScx1+nUSMg+qJ561C87mPpigDDrdve7G7LGJzu4UP263hqOFzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl/6Q1JoO6V3aOP9BouJipgUmCS5VfkxnhEKUsJ41SqJtloCzz
	lFaYmacH02aUqOlwc0YZz7iAE0dj4ZhL0PNw98vd0mQK1IrDu1FhafJQs0EK6oF3uGwuQtAPkpW
	mX6ZgT9RcISOCNNd9CIx7AvDMT+w=
X-Gm-Gg: ASbGncvSjlM9U+oOfZns6j6KyVUSmSzqbdW1a1Hs0E+JiAVEHokg0NoWDx8oxlGOZuP
	o0Ix4qWh4ZNMRx/MaXz51GOOcPWLBvaLx8vBmSA==
X-Google-Smtp-Source: AGHT+IHsSVdYBma5CPL0yG8zuR6byIgPcePiTTTkobAfruzMqP7IeXaP31/0PFmLWWGFUVQ6PJVK7/wenzEMa0nl0Do=
X-Received: by 2002:a05:6102:3584:b0:4af:f3bd:51cd with SMTP id
 ada2fe7eead31-4b690cdd7e9mr1189372137.16.1737114832156; Fri, 17 Jan 2025
 03:53:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116-starqltechn_integration_upstream-v15-0-cf229de9f758@gmail.com>
 <20250116-starqltechn_integration_upstream-v15-5-cf229de9f758@gmail.com> <20250117-cordial-hopeful-leopard-4b7ad9@krzk-bin>
In-Reply-To: <20250117-cordial-hopeful-leopard-4b7ad9@krzk-bin>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 17 Jan 2025 14:53:41 +0300
X-Gm-Features: AbW1kvauDMoxHb-HOemALvUFq-vmlIsK81MN7Ookae2wr7GP_eDwoWdHLehW0k0
Message-ID: <CABTCjFAv7sKkgWvr_Bik3G7-6L0Uh5gnhhTDiar7ecjuqEtvJA@mail.gmail.com>
Subject: Re: [PATCH v15 5/7] mfd: Add new driver for MAX77705 PMIC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Hans de Goede <hdegoede@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 17 =D1=8F=D0=BD=D0=B2. 2025=E2=80=AF=D0=B3. =D0=B2 10:55, Krz=
ysztof Kozlowski <krzk@kernel.org>:
>
> On Thu, Jan 16, 2025 at 07:26:07PM +0300, Dzmitry Sankouski wrote:
> >  config MFD_MAX77714
> >       tristate "Maxim Semiconductor MAX77714 PMIC Support"
> >       depends on I2C
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index e057d6d6faef..d981690b5a12 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -168,6 +168,7 @@ obj-$(CONFIG_MFD_MAX77620)        +=3D max77620.o
> >  obj-$(CONFIG_MFD_MAX77650)   +=3D max77650.o
> >  obj-$(CONFIG_MFD_MAX77686)   +=3D max77686.o
> >  obj-$(CONFIG_MFD_MAX77693)   +=3D max77693.o
> > +obj-$(CONFIG_MFD_MAX77705)   +=3D max77705.o
> >  obj-$(CONFIG_MFD_MAX77714)   +=3D max77714.o
> >  obj-$(CONFIG_MFD_MAX77843)   +=3D max77843.o
> >  obj-$(CONFIG_MFD_MAX8907)    +=3D max8907.o
> > @@ -233,6 +234,7 @@ obj-$(CONFIG_MFD_RK8XX_I2C)       +=3D rk8xx-i2c.o
> >  obj-$(CONFIG_MFD_RK8XX_SPI)  +=3D rk8xx-spi.o
> >  obj-$(CONFIG_MFD_RN5T618)    +=3D rn5t618.o
> >  obj-$(CONFIG_MFD_SEC_CORE)   +=3D sec-core.o sec-irq.o
> > +obj-$(CONFIG_MFD_S2DOS05)    +=3D s2dos05.o
>
> Hm? How so? And how does it even work?
>

My bad, sorry seems like rebase issue.

--=20
Best regards and thanks for review,
Dzmitry

