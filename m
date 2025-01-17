Return-Path: <linux-pm+bounces-20619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E057A14F5A
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 13:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F629188AE9B
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 12:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E011FF5F1;
	Fri, 17 Jan 2025 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwqMJfdQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BCB1FF1D4;
	Fri, 17 Jan 2025 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117672; cv=none; b=s12JtNfrnMfCPIu2db9QCJawzwrimi5XermVLIjpbMfGg3SxpPpjanSocsRNrJJ6Qi0eAkLUbdPVzvo9kodO5g3ScUUxN8pjJwZupo2D9mLfKzFXEFQzBEXVsgq8eYyUrj4f5nc+qYrSj5sAlCJwqsWXM1ExYbNhxW1vZw7+wFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117672; c=relaxed/simple;
	bh=VXyefM2TCJ60ybpT+hkoPLMAfCu5KHa///q4RWD3ikc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWQMO9kDhrbPFAKnQ3ZGsv8xpheWHSBgTTqTPr6qvahmuKJyFvkBLYCPIlNgiQHm8oxoi+7fP5saSg0RAnQYdVsRVFl8jt5an/rJPbpjponpuGuvtfcuu2O/fhIoMvxkTkOghId/cVJrLWyv0YWgASBRALl+XJMKqbmsbf0bzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwqMJfdQ; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-85ba8b1c7b9so1152342241.1;
        Fri, 17 Jan 2025 04:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737117670; x=1737722470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0En28HZeajOXRzqBdORf4Lv5BaWVuwhVnOPjTlfjtc=;
        b=ZwqMJfdQtBgDg5CWIJPICcFNQjhatvfwGFAa/O149ooHEULog/SezBk0sIR7nCc2Wd
         bI+YtdbyrZMRgTu0XoReNhUzhraApm2uFNU6Crcym/XMkwMz7eWE0tzKYwUGcFys6+xf
         1P85tkp4CG7mc1GCqYwY5dPYxCJYfGHub2oA4zcdifoTFgPQaHp34TvajHyI4Y25Zq1t
         5Vp+10S/0gMrBrxwQVJuq79vKcS5sqgsM9RlNOuEIHUYH4IN4PEyb+rZ8r/eEWx6IyYj
         IdBa7qJ5ee9EIwelgEzPYVRRJyZ2QoIAP7/krPO4AjFu6udKlt8HWuQa7rGJrpvj6xi6
         d1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737117670; x=1737722470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0En28HZeajOXRzqBdORf4Lv5BaWVuwhVnOPjTlfjtc=;
        b=vqxQSsKzfbaePI6SjGOx8H/ogMtT+vtEzReV36N7z7ZQ9Fg6kAaxLOHdnRwmCu1PCG
         R5yzQvKGsoZq40cEnJAguE9g5kR11SFpInJAKPcIlfV2fXlg804pwKVao8TdO/4yFlJ/
         lscWH9MrDCJRpTApi6ejiTmVCDqcRpnCqXzEz6pdlxfkW1Qw+3l3RHa2huDo4rtRtEie
         pmptBEIK70H4DjXm8I5CIVyfVUssBw1Oyn12S8kPeJf6MUhDZcQxCl1OleYmgC6imre9
         hXC/ts9ireIPB4TWi7Uurxz4SQL7vw4oZiq6Yq3qv08xoDby4Jlp4RTAJqmZ9VLvt/RZ
         qEZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+8ogIikugx2UnREu0EJs4BGLweb7tUC4Iio5JByN0QppxkxJUtUJ7/XkAw3g4C4Gq9KGPPEf9H2tDryIL@vger.kernel.org, AJvYcCU0icy96m4kg212s33cv7FxFS8xO6wkzGFEeDOKnkSBaSWQMWYpWl4MEKxZ4zsEtrxg+vT1xjmyryjwFr4=@vger.kernel.org, AJvYcCUG+Lr4ghTgF5lptaHof07ZhRBsIGVdMPES+g4Z18inRly4cObUGscpG81ON1kgZA69eTCL3e2iOuUYGg==@vger.kernel.org, AJvYcCVAPIYOjnDsJc9Dq+JjGIsU4MxozCY3rlwJfyuP5dk5HnZP7t8muO4LuiubeRfI0K1V5/FZ/7h8xSX4@vger.kernel.org, AJvYcCWPqGNYHdglM0TX+M/7bos/CZc8YlXCn+nNq17KUX3tyhUw8qJxH1tc71CgCTukmk3DbRjTYfv/lQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdCQggX9rqM9vLPyWiGls11iJZNATinwxYTUY5r2Opb9d0TgPo
	QURXKnFoXtHWeHVtvbnDy5SBKtkC1s0qaOptnl4J8O07sv6Z9nu/cAGSwzjW5vRTe2SmiUnMIwt
	21K1JmsuLwLQBZKh6sgBO8BcDJh0=
X-Gm-Gg: ASbGncv8iBIyHtMVeg4hGyqfr/rOjvG9YB3mg/IVz5NNb4xje31EItN+4wbfs7egEH8
	1fopZH0uFxZDa3AwdR60Y86iOhOhX9yad9UHrJg==
X-Google-Smtp-Source: AGHT+IFjxmYd1PvAupqoAlwFutVixFvbdT6Tazz8Zek/4wlUMGeADFdVneUAyUnYbC3kselWCIf5rRMj0zQFK5jO4vY=
X-Received: by 2002:a05:6102:54a8:b0:4af:d48d:5142 with SMTP id
 ada2fe7eead31-4b669ed53f6mr10191574137.3.1737117669814; Fri, 17 Jan 2025
 04:41:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116-starqltechn_integration_upstream-v15-0-cf229de9f758@gmail.com>
 <20250116-starqltechn_integration_upstream-v15-6-cf229de9f758@gmail.com>
 <20250117-chubby-convivial-axolotl-29e2df@krzk-bin> <10f0fdac-65fb-4232-9d39-d6ecb2560b45@kernel.org>
In-Reply-To: <10f0fdac-65fb-4232-9d39-d6ecb2560b45@kernel.org>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 17 Jan 2025 15:40:59 +0300
X-Gm-Features: AbW1kvY2SixGYmSdp-6SfoPLDH8ccQCKi4IhnV0vyGqMnZqxj1WYhJkEuq11syk
Message-ID: <CABTCjFDOFjRtxvAjWy4dRcqrMKevVfH=No_-OzSvOUQAB1+M3A@mail.gmail.com>
Subject: Re: [PATCH v15 6/7] input: max77693: add max77705 haptic support
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

=D0=BF=D1=82, 17 =D1=8F=D0=BD=D0=B2. 2025=E2=80=AF=D0=B3. =D0=B2 11:02, Krz=
ysztof Kozlowski <krzk@kernel.org>:
>
> On 17/01/2025 09:01, Krzysztof Kozlowski wrote:
> >
> >>      case TYPE_MAX77843:
> >>              haptic->regmap_haptic =3D max77693->regmap;
> >>              break;
> >> @@ -407,6 +418,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(max77693_haptic_pm=
_ops,
> >>
> >>  static const struct platform_device_id max77693_haptic_id[] =3D {
> >>      { "max77693-haptic", },
> >> +    { "max77705-haptic", },
> >>      { "max77843-haptic", },
>
>
> ... and also drop this change, since compatible is going away and we
> expect matching by OF.
>
> >>      {},
> >>  };
> >> @@ -414,6 +426,7 @@ MODULE_DEVICE_TABLE(platform, max77693_haptic_id);
> >>
> >>  static const struct of_device_id of_max77693_haptic_dt_match[] =3D {
> >>      { .compatible =3D "maxim,max77693-haptic", },
> >> +    { .compatible =3D "maxim,max77705-haptic", },
> >
> > So the device looks fully compatible with max77693. Drop this change an=
d
> > express compatibility with fallback.

Cannot be done, because config_reg is different.

--=20
Best regards and thanks for review,
Dzmitry

