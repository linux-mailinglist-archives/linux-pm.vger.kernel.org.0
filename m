Return-Path: <linux-pm+bounces-16195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F629A9CF5
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 10:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327A71C21718
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 08:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BFF176AA9;
	Tue, 22 Oct 2024 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEqFll4F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D312B157487;
	Tue, 22 Oct 2024 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586266; cv=none; b=OKv6H8Oh/rrNzUozpyGdzn+/VV/nWQLsJfo2KL5CcbPl3YcujGp0PRX2+qbd5GLUnU1u12gXqK0uZ8PSf3zIm2YP6vP7YW6J66oj94yUsTxOeHaCvXT/JahdejKudhOkDtBrKCV1zb+QyUuP653Mdgaqr6UY5oOze3YXCYR2Awo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586266; c=relaxed/simple;
	bh=hqESUoeCOtAgPVeowsanTRwsfMFY5c1n3Vj5MXcewyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkVUR49qPj30j63zz7c0byCIsGj+onrp4kcGGL7+kTvDSF5XCFtTfMjpYONYKBSO0hs3UKhhJ/Wg14LCUp1gemYgZpj1ZJ9OyxB/jfeeTS+hAVpBt9NCVREaiX+C2p6uLFaUbfxOnMCaUygkugi0iVoMu+wE6C/knEOLnxsrz/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEqFll4F; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4a479773730so1221244137.2;
        Tue, 22 Oct 2024 01:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729586264; x=1730191064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O4MGPxvsvh3KaI++oWEtd2LMAnjDvHPtuX1tYTzn8o=;
        b=hEqFll4FbOdFoZxPyKuGzO4fGvRhUzJ7N/MFdrkiSbFIZccojp33EyVUPeK8lgO4Vb
         LXnYKY3phXroIeBjhLUj0q4GW7tS7IfTdpTxh3XzZ/R0hBc6CQVmOgt/vrsx1azvei88
         76QAAcnXEV8MDJIjRDotYQiyZtJNqiMyuJMQx7g06Dv6ujzkNkV4PWLK3G0F1ihW7sWn
         xeIiwxDqq5azx8499l++Tdj0IOv83RWVoQ5AIsQjJSwGe9yaKZlVfOzQWaioVPbKk3sp
         wuVVVkV0bjYRDhZ6EvLto/pqMEebKbRJCHS1+pSqvNFJkjujVQfSHgR0PgqoEkSfuWiy
         GxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729586264; x=1730191064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/O4MGPxvsvh3KaI++oWEtd2LMAnjDvHPtuX1tYTzn8o=;
        b=k3WxjzKb/tJGeTiyIhi65vojZJ5M1WjUdxuxijb5TZMUptM60/Sredzdi9lGTSTBtm
         rH7t18ZOpiU/wk4CagODHPqum1N03+nT+A7oYx4yAbanuC3Jhd6mpmcQC3bOgexILvnL
         /YyYUAU4deSu0CkV+lqR99+1PVvd7mzMaY58hGfVvfvQ8ggpk07dCaf1wF7Fb8RVhTOC
         cuEOmAho14XzAoXh1bxgoPNbHF+N5Bbi+/zp7x9al4BPd5hKCe4OtwNtmWel2XSowL/H
         akLfgNQB9c5tMt0nIiORO2vLttQAvlA8lUy/CQ12zGUYisW0RBG6CnCkiSon+vnDXTHC
         UbXg==
X-Forwarded-Encrypted: i=1; AJvYcCU+XZciSD0d9B7k+IC6H7DDTji2mFK+OsTAFQYpblk16J+HW/Ust7ujGptZJNxzgwtdA3wWZevhJWpgOLVD@vger.kernel.org, AJvYcCUCf1jWD+mgN3EVUQp2+V869znrub45ZKO56twoUgTayYO5vwRefKW/BXUQnGxZ/2TmnIlEJzQQ8aA=@vger.kernel.org, AJvYcCUG8plWlzCYIeR4U4RE0sIm+EITgUGJn8PQ0XX87nW7XBT5tfoFoiWlZtcw5MMVJzSXr68/kCnax0Lo@vger.kernel.org, AJvYcCUTg2mc/FUMKVy+Gtrg/nBU9r3ACpt8sgCdoXsWIXg8VX441eBI8cMW40IXfVYcoyXgulBbw2iteQZJnmc=@vger.kernel.org, AJvYcCUl7oRyWRdsB1D9ZceRYIacZfvu8gapwARfcdWE1UI9N1pFnR7soFYst1sU4djKbY6/RRlzZsmN/YXn3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4GPCbCT25FtCPln8ATbzeiKGJxqWov8w5uwQnNjGH54KX1ylU
	e+HrC+cBFOsseVXXb+7wNyne9DVnlPGtTANUrkpDjBZvBXm/3dbJYHSTl/SgqpJZ2NTAPzrWrBO
	jMQUP/LnerrY00L0WHkhzDtgc440=
X-Google-Smtp-Source: AGHT+IE+cqda+uQBNaMUBayVyYnL2hd8JWUNI/WpzZQ5XAIlV+fvhML5xaeQ8JrQbL8UGyVS29+gz6jO0CHGrVeFWpQ=
X-Received: by 2002:a05:6102:3f02:b0:4a3:ad8f:4fd9 with SMTP id
 ada2fe7eead31-4a5d6bfc9ccmr12481047137.29.1729586263778; Tue, 22 Oct 2024
 01:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007-starqltechn_integration_upstream-v6-0-0d38b5090c57@gmail.com>
 <20241007-starqltechn_integration_upstream-v6-3-0d38b5090c57@gmail.com> <20241015140224.GI8348@google.com>
In-Reply-To: <20241015140224.GI8348@google.com>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 22 Oct 2024 11:37:33 +0300
Message-ID: <CABTCjFDEEcuJtiK0d8gVM3Zf7vWL-rpsqH5AndeAuPbBMT=Www@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] mfd: Add new driver for MAX77705 PMIC
To: Lee Jones <lee@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > +     /* Unmask interrupts from all blocks in interrupt source register=
 */
> > +     ret =3D regmap_update_bits(max77705->regmap,
> > +                              MAX77705_PMIC_REG_INTSRC_MASK,
> > +                              MAX77705_SRC_IRQ_ALL, (unsigned int)~MAX=
77705_SRC_IRQ_ALL);
>
> Why the cast?
>

BIT macro creates a 64 bit constant value. When inverted,
it overruns 32 bit value, causing compiler to warn on conversion like
`warning: conversion from =E2=80=98long unsigned int=E2=80=99 to =E2=80=98u=
nsigned int=E2=80=99`.

--=20

Best regards,
Dzmitry

