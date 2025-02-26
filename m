Return-Path: <linux-pm+bounces-23008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D2AA46574
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 16:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE423B6391
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42B6224B16;
	Wed, 26 Feb 2025 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3Orbq+G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD7224AF9
	for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584556; cv=none; b=oawcEBvnBZEyeSq2+fVUtS7Qcn8vibx//N7gIdECb3Mre/LtusiEyz2nlKXpm/oWt5Leuyyy3z8K9zDJGLFzcJnHKOEVdA9/x3u2meogsgi4IxGAvSKF+dIT3e6fmpu+L+b1OmPvejsBFatBX+5gL8RAg7D2vzGmxXGco0/i/X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584556; c=relaxed/simple;
	bh=yET4WCQ0TidGw46uDqCa2xPxmd6bKwpoScO4cAMic7A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eRIdVI/9kABJyNsDfxKFasFRmFVU8SMLrI20rTbHRuG077JIAv5WLYzA9dG0dRFTf8EpeIeMO6byvRnHEZ9ZMYKR3hgRDfP1PM2IAH0+0WMeMbIDE/C+jbzTVdWeKSjDWcBukxkDrOh9XYqILIHTJ10F/ZAYWvqSzsHhKu9U/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C3Orbq+G; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-438a39e659cso46771075e9.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 07:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740584552; x=1741189352; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yET4WCQ0TidGw46uDqCa2xPxmd6bKwpoScO4cAMic7A=;
        b=C3Orbq+GsIma7v8fPk0cUnsE4cHhspQ4nv6LHjkF6WFdfKFD2QhIMcpMZRhn4en5dZ
         7ZRAibSWpYEEfEm4KluZJGiysahiHnVUZ526Y+e1KhoOYN0/EvxQnZjwhOqQ0olM3wra
         3TZvImZZC26aSTsfUTBjOtPDN/T4vkBW9lf3z6hG3OQeUbWFj9uQFa8d2HyDT8sOKmrf
         JbVZfZZHXoEyUpXg3cwoKbgu09uZqq12R5Z5jvfK9l6rieEVGtABq5Kj3bz3GH3MAUTL
         D7bljuZyuxJpFIgtGCQhtQzatylKo9zNo3hj5gdUBC8nRSw+03x2dU1pr/C4JbjLxz6s
         otIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584552; x=1741189352;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yET4WCQ0TidGw46uDqCa2xPxmd6bKwpoScO4cAMic7A=;
        b=w7Re1vlEueSqbnbvB7NCP9Sj2DYYAxL53AbqdQGB9j/NJLSo2DWnmINN4x8uzW6R3q
         gcyEjMHSBIVRK0re8X9XEarVTbiosL2c7yt4es7XPmNhAayRiGScR4EdJxf+633zxQFl
         +nF/bU6nA9BBLoIj/TqRClJdq4NhifNc8gSZfLFznbmUqGTsBn1u3cUeZ0iT8LIWRTOF
         5fGwz2BwKJDA4qP0KieNPtdoeOe+P2bW0tHIIjqUzXqLnytyrjrGSOnpawzl7zV+AcIn
         5N0HZzwzlHnsWQrYkjiCAyvzZHFQ+rL/LspeEAbOrm3hlVxFSxFh6FZcSvJ8uOzfH6h7
         ebJg==
X-Forwarded-Encrypted: i=1; AJvYcCXwO61rYeEAH2XlhAYtgjkvI56iFqD32HkopG7zTW5zE8brKOB1f4F4gLTAhCC7aoLiDf/eLALX/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJBVmRvnaB3r+yiFz1s/BMV+OFXRxCuszOz4Uada2eABAT64rq
	ybi5mQGouXdYhxGhHYiYk2tWcn+E9uBVaPyNR1UebmRZtgEhwpEcREiif+f66sE=
X-Gm-Gg: ASbGncvLl0GOXGaYF6ox95rlp46Nh/QtIxDMakwtzmEayJ/YAUDqfL+2DEdYriGlzMP
	dMG6xTsLEXwhLnnJjEjWySE1hgnUQ9OE5ueENp+c1wJGzdBYoo73JLuHhYWSPPad0B+TRpdEz2H
	FazEqQzp+KQ2e503NRf2mChmMgEVjqGbdsPg0Zh0dYQNbTsrTrsLWYwbrjD8phCeA5I72/KlgOd
	SZvCZxsA4ghCt6b095yx/rFk1tW5dm/9vhqfqYMYYtACumPfohWEDpCS0D1qP0n2zgKhZuexQPs
	ZJhHpcFSq9JcqTIhTuBV4zdqKHJGxw==
X-Google-Smtp-Source: AGHT+IFBjnTWTZFRw7uykXPFUh9gNCNUIJPbPGaNy6dQmXu2Z2glg7T41KVUH/4tSaNb7DypQgIDsA==
X-Received: by 2002:a05:600c:1c1d:b0:439:9496:181c with SMTP id 5b1f17b1804b1-439aebdc9e1mr174340225e9.29.1740584551612;
        Wed, 26 Feb 2025 07:42:31 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab37403cfsm48020585e9.1.2025.02.26.07.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:42:31 -0800 (PST)
Message-ID: <ba98106d00038a9b2a2bfb27dd49a5915cb93b81.camel@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: reset: syscon-reboot: support reset
 modes
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Will McVicker <willmcvicker@google.com>, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Date: Wed, 26 Feb 2025 15:42:30 +0000
In-Reply-To: <174058375994.2463209.9948592153423144239.robh@kernel.org>
References: <20250226-syscon-reboot-reset-mode-v1-0-91c1b62166ae@linaro.org>
	 <20250226-syscon-reboot-reset-mode-v1-1-91c1b62166ae@linaro.org>
	 <174058375994.2463209.9948592153423144239.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-26 at 09:29 -0600, Rob Herring (Arm) wrote:
>=20
> On Wed, 26 Feb 2025 14:08:20 +0000, Andr=C3=A9 Draszik wrote:
> > Add support for specifying different register/mask/value combinations
> > for different types of reset.
> >=20
> > In particular, update the binding to allow platforms to specify the
> > following reset modes: soft, warm, cold, hard.
> >=20
> > Linux can perform different types of reset using its reboot=3D kernel
> > command line argument, and some platforms also wish to reset
> > differently based on whether or not e.g. contents of RAM should be
> > retained across the reboot.
> >=20
> > The new properties match the existing properties, just prefixed with
> > one of the reset modes mentioned above.
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
> > =C2=A0.../bindings/power/reset/syscon-reboot.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 74 ++++++++++++++++++++++
> > =C2=A01 file changed, 74 insertions(+)
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:

oops, sorry - the script we usually run didn't cover this binding,
I've updated things and will send a v2.

Cheers,
Andre'


