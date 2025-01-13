Return-Path: <linux-pm+bounces-20358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE408A0BF0F
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 18:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81DBD3A9D55
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 17:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C39F1BD004;
	Mon, 13 Jan 2025 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0K6jGjc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B9F1B0F35;
	Mon, 13 Jan 2025 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736790161; cv=none; b=tKwyJeWaS/IDlsAHKuHZsJvj+KzN88BcTEGYB8mJGgz/7EeveNthzoSftTqsPddKJH+LLI7+SEiYsAIFnvfVl4vy4SD9JEMbjZ+W2bN9WuCnYs9HVdn8YXQQKBJFUt4BFEIi5coZW57Y5qlGsKVfIun2ro1gIZDAnY2WFkoqV1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736790161; c=relaxed/simple;
	bh=9By/cg3WRaJU39H2+KcBel81dQIv17faS7AvhuuC9hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wk/SSGFlUPMm+LjVHhZMoAqAv/js+CjtVNTaO3bCwAE2w5HnLdypu/mUb4iwW+5ZOctAitcAZkKSNd8jIRBq0dyAmYWNd/F/oGVhvvwS8OrVh0WbpzwXvmn6/FdswkYITLuMPukpKMnmKWVAoa2zVh6cA5OVGNYNAwcaGV1iLcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0K6jGjc; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2aa179a8791so2879090fac.1;
        Mon, 13 Jan 2025 09:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736790159; x=1737394959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQZPia2sZAAmybfMLEyqNp4QuNfkcuPO8IQNsllu2Bk=;
        b=Q0K6jGjcTQoWGmIJfM6TM1YKspMMDp0mSZ7sV8/I1oCjLilta5KBFFhQD9hZ8f0pqo
         cGiBzG9HzDMveQxhuZ/Al2td91ZuUysNZY2f5qje8j2UG88FDBqaxHnWuiDSyj/cUiy8
         yTyDs0uFc0cnsgJrmP4dgZDhVnzsmC2EPKHLo0jsNmSyC2KbnzfJjDp3oeuTZU8a37Yu
         wMAH0Q0O1x632YWIHtUOIR6w13eC2kgMUtCNxEVYfgVTf1huMmcszW/JJG2OU3vBKzer
         tRQp56nxrIrtT1bi/cUr38sU7Tr7UWV9EUKOEVV1Vd2hQVVw3O+jPhk7faKHxhvVRZG4
         uFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736790159; x=1737394959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQZPia2sZAAmybfMLEyqNp4QuNfkcuPO8IQNsllu2Bk=;
        b=piU0sDvATKBV2VAyvB9wWWwKYGapItX+n+00R+qJuua0Xit2iguUjHLYv0SWWrgSz9
         97rR4uZcj3tnNdS9IgHns4CtOebcqoxRNNQO6vhAmkPpdaE3q8LdRLQD+SHbV8LNqGDK
         97UwzMOZGJBAUQLRVv1UHxoSrtYubqyL5WIUAKk7xE1U7kVExSMrTh4PAVFMvlEkJ/Xb
         pQQS3k+XiA5lpSjFaUge68BlsjrcL7U/l3slu/4ib5BylG2y+zkILr5TOlcOQghATPFa
         SkOZRdXv8uLgeI56IHYl9M1xU0NEqX1S5WE0JIN0fpnW3qSXe1EMz1K0Ne7hTcSYKupP
         ht3A==
X-Forwarded-Encrypted: i=1; AJvYcCV+g4ypgHvmY+DzJGwrs0KbVGGai1QckjrJVCbvIqsbn7y+dvfh6IuB6xnK+zm1W5VEjYfcLKJaD5z09w==@vger.kernel.org, AJvYcCV0W08Hm9hcU6TJCmU511EGrsIiCzlMpt5PVpangPUlyCaSWJPnRcj8ad9iqK1SHeqU94nGB9dI0jM=@vger.kernel.org, AJvYcCVpPZzUdiM9YUp0lrhbPtEJDEkyjZPjrB+uYz5OMGqjbdRuSbj3VLEXSErPReQXxsr05iM35iiIU0Ch@vger.kernel.org, AJvYcCWdxNku1JGMhrc9pQmR05frYkC/EuiaOGKe0jvD/3bSv0osWaIKR2HjdWPt0yYD9g0doWd5jYiR+oOff2Q=@vger.kernel.org, AJvYcCWnnj/ogJq1p0y/RbSEkIR9u+VIaT9eU+jypj8/BfO9Hjgr4di61by5x6P2epmumyASreK5udga+uw3KpM5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9OtovXg1dtFzssCgPe73nbMW0s1eby3MxIcMUjmLeWFqcR+Bl
	Rah+hys6pFnw/L8zlw4+ccvbZ9tA7a/VtsfiBXSQxIElOV2PbCP3XZVfCraFsmTva3IRp79IKHI
	Q8Q9/axibscCgAImnScDr4rqnck0=
X-Gm-Gg: ASbGncvsZJsYIqzTHlxhhWbfEE6xrcQzlhohNzlCVT7N8bdDtKxl9mElurlaXUDRjuO
	D/zRjBGtvdrlaL/Fb3sITa5sbEQFwUxWH2nrXJw==
X-Google-Smtp-Source: AGHT+IHMB+GGiNJhNGefJ2LWoJuZLtThtPOh9fydXyn/5Rwt5TmKrvnF9R7u9+jTH81xBy2WWWy1ILuMVCmAVSS1zkY=
X-Received: by 2002:a05:6870:1710:b0:29e:1325:760a with SMTP id
 586e51a60fabf-2aa06668e92mr11830484fac.8.1736790158782; Mon, 13 Jan 2025
 09:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
 <20250108-starqltechn_integration_upstream-v14-8-f6e84ec20d96@gmail.com> <20250109122148.GJ6763@google.com>
In-Reply-To: <20250109122148.GJ6763@google.com>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 13 Jan 2025 20:42:27 +0300
X-Gm-Features: AbW1kvb-liGKuGLtkmrjc1H7lITbUJMSGPuUb2fk2sIiLd6fXWjbBtERZBX-Eys
Message-ID: <CABTCjFCaTOLQQ_cU10HNiVUoWT=FreoKYj3yAGQYccDkagcn0g@mail.gmail.com>
Subject: Re: [PATCH v14 08/10] mfd: Add new driver for MAX77705 PMIC
To: Lee Jones <lee@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Hans de Goede <hdegoede@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 9 =D1=8F=D0=BD=D0=B2. 2025=E2=80=AF=D0=B3. =D0=B2 15:21, Lee =
Jones <lee@kernel.org>:
>
> On Wed, 08 Jan 2025, Dzmitry Sankouski wrote:
>
> > Add the core MFD driver for max77705 PMIC. Drivers for sub-devices
> > will be added in subsequent patches.
> >
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> >
(...)
> > +
> > +     /* Unmask interrupts from all blocks in interrupt source register=
 */
> > +     ret =3D regmap_update_bits(max77705->regmap,
> > +                              MAX77705_PMIC_REG_INTSRC_MASK,
> > +                              MAX77705_SRC_IRQ_ALL, (unsigned int)~MAX=
77705_SRC_IRQ_ALL);
>
> I don't see this much.  Are you sure the cast is required?
>

BIT macro creates a 64 bit constant value. When inverted,
it overruns 32 bit value, causing compiler to warn on conversion like
`warning: conversion from =E2=80=98long unsigned int=E2=80=99 to =E2=80=98u=
nsigned int=E2=80=99`.


--=20
Best regards and thanks for review,
Dzmitry

