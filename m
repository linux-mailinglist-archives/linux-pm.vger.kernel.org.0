Return-Path: <linux-pm+bounces-20540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF41A13A25
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 13:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E96E18899BD
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 12:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76411DE89E;
	Thu, 16 Jan 2025 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOpj/2KQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460E61DE2C7;
	Thu, 16 Jan 2025 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737031484; cv=none; b=FBDPMqErt+WczjA65AuxeW8N62UMh0dly2/y6HZhpbi6Fx/2hiw0PunVKSQLtIc8LU0GjJR6P7X4CIh5/yE3j+1i+P2hPo0pobJaFopHWUSyiTjBicFgwCKv1O46vzBQP/fwBroUHN0q7Z0NjkzsWrwxWnFnxe0Lh+rmHXy9IXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737031484; c=relaxed/simple;
	bh=8rttl077c4rRAThosPUpTETXNpVuOJo7DhsTEoeL4SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BzYcn4KVEac61oTL15+0xa0/rDPvMpjbwOlYvoNVAOA2hZpkW8STKe6lRyq138XGWP/dP09Z/MnFFJmby+2DsTCJ/79Sd7IfOkXgZu87B/4M4RdhqH8oW9eairT+lxEZlF1VfiwbxPlZ3apgDtL2///VPQL374Lwkofyc/At8eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOpj/2KQ; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4affd0fb6adso158904137.1;
        Thu, 16 Jan 2025 04:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737031482; x=1737636282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rttl077c4rRAThosPUpTETXNpVuOJo7DhsTEoeL4SE=;
        b=NOpj/2KQjbVzy7pxm3AxAKFqazB6CIdnvDfqohPyTzGT9HYFMBJfw0pC3GRuXayW54
         T4elbQqRhW4Ql8DabTNmCPapnoqM10+Ag4dGnSnrY1Y08Jr1lmYRvc0TBrrobVeguOv4
         oQSeXwXALnZEUB/izEInSVgEKZxTyJikZfPFIwqVi3LWmMLp/2Vd9yp5Zxz+SzvACYk5
         KrO9sidRBwlJwh07kfGYwUR1IQmihK5wRThFWmg+MzrDFphSf19rqPWnN1oH/Itn+dhq
         2U08GaxumwtiBaODB9ixo87W+GVglY9c5aWas3EjFBLqfWQ5NKdNdRpEsk1zyJWGdsLE
         5SzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737031482; x=1737636282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rttl077c4rRAThosPUpTETXNpVuOJo7DhsTEoeL4SE=;
        b=RPA3Ggk+DhiRzriTh4AOj0ekR5gtvKLUF2sOpQyo+B+552t+VynU7aBcGk/XEJa74m
         WJ7QrAjV+IFjUwyhQWj2ohhrglUBOEF4SYe/a24Tg9Hxcv9oVmdAZOASA/vHLWQjiunP
         Unm9laSciHiMMcaWtGM2YXUMoe76w6K2JZdktYwtQeqzMwlalfuUg9o01hoosa2oT/HS
         n9lO0jIJisi0eoPXeoCnT6RNIOvmWf67GklpgD3jpt4HCJujHExb2PeTkOI04XwC6Cl4
         g89/mfefqzG0zu4sfojWGfHRD/ZOPFlVHWcv7vDCl1BYD8ZAtCVRKVq7HzVTQjIQYIl7
         PFjg==
X-Forwarded-Encrypted: i=1; AJvYcCU8eUKDG9ih6JlK+ebA5p7YNEnuKCiLPJloDaQWTIzAyX8HxP1oqviNh+pCDXTK/n3UF+0f29NHSLA=@vger.kernel.org, AJvYcCUKGI/sy3ywtFRSMhV4aTsf526/jZcg9YkgkmK5PInU7Bwkgdm+XNZVdiX20pbhUR/874DiAec/WBm/JA==@vger.kernel.org, AJvYcCWsF6oDy4dIKar8piVdkkps6D+CDGEz6JJYLflpVSlv91g4nntmCKCOZ5rc4repIhEHHB4W/8Ll4XcF@vger.kernel.org, AJvYcCX/GwDyBhARw1vXurWCa2oHShm3FdLJpACJpyNtca99+qeX9BkmBu5EghEp8LFqWUzwTTp1UNHh8aOJe6+u@vger.kernel.org, AJvYcCXlmNwwLlrlmJ17y8ujhuI7OOI/f2OMD15ZbbwY2Nkvpzp3xuD0knfiFCPs07vFUPP5x12tbo4SwCuLY6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrJOTeFifAcnkUagpT/nYdmm8IT7tRet7+L6qNSlhi5wdVBCG+
	3Pqit8Rd4rR1JjHTudhAkU1uEzZlMwGWI5I7amJKMZLcrjKIRu6kUKs0ywqXTpTyVGuz4mEY+uC
	5KCej8hhytdgTamrIF69xK/NbMMc=
X-Gm-Gg: ASbGnctrP8JyiVkXkjeLyeAcVmMNlEIIk+ZusY/KQgayIS4chNNK4PzcUY/WinDWcWf
	kDow3PLVU/6k0Toe70jnyRTMDMOor3YLwY4/7QA==
X-Google-Smtp-Source: AGHT+IGEBvsAJQ3innhzVGqdogiKvw1ASDLCbr2ZSD46Wnd+OKTzA9lhQk8Nnfnn0T/wzN3vH4BtFj+h3nvLbzcsDeA=
X-Received: by 2002:a05:6102:509f:b0:4b2:bc6b:c845 with SMTP id
 ada2fe7eead31-4b3d0d763b1mr25657602137.6.1737031482085; Thu, 16 Jan 2025
 04:44:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
 <20250108-starqltechn_integration_upstream-v14-6-f6e84ec20d96@gmail.com> <i6vrezzvaieutxf2cq7hd5vhkbn5so7nlw36hja5iqihv7irch@wpvyxgqkdglz>
In-Reply-To: <i6vrezzvaieutxf2cq7hd5vhkbn5so7nlw36hja5iqihv7irch@wpvyxgqkdglz>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 16 Jan 2025 15:44:30 +0300
X-Gm-Features: AbW1kvbg9cji6OF6xOpJrlkLUXVZ2e6SihmmckQNvYdrhXHsvs3wzPAOa3y9w9s
Message-ID: <CABTCjFA+dws6d4fKOvRNAu3Yj=9=_P5yQpo6JVQoppkehyBYfw@mail.gmail.com>
Subject: Re: [PATCH v14 06/10] power: supply: max77705: Add charger driver for
 Maxim 77705
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Hans de Goede <hdegoede@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 16 =D1=8F=D0=BD=D0=B2. 2025=E2=80=AF=D0=B3. =D0=B2 03:17, Seb=
astian Reichel
<sebastian.reichel@collabora.com>:
>
> Hi,
>
> On Wed, Jan 08, 2025 at 05:13:50PM +0300, Dzmitry Sankouski wrote:
> > Add driver for Maxim 77705 switch-mode charger.
> > It providing power supply class information to userspace.
> >
> > The driver is configured through DTS (battery and system related
> > settings).
> >
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > ---
(...)
> > +++ b/include/linux/power/max77705_charger.h
> > @@ -0,0 +1,194 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Maxim MAX77705 definitions.
> > + *
> > + * Copyright (C) 2015 Samsung Electronics, Inc.
> > + * Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.com>
> > + */
>
> Please put all of it at the head of the driver, like any of the
> recent power-supply drivers do.
>

Samsung is unrelated to the driver code, except for that header.
I would leave their copyright sign only in the header, to make that clear.

--=20
Best regards and thanks for review,
Dzmitry

