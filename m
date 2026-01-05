Return-Path: <linux-pm+bounces-40214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5B5CF4D18
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 17:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85AAB3068351
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 16:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DE1309EFB;
	Mon,  5 Jan 2026 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hXQSiz1I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925E63093D7
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631647; cv=none; b=qj4Ga9XGx76GJHmOwqKYUpKnikIO0AANfsbYcgM+Vx3foSLv6Qhw68HWZr2B1Cepx02ywo/+RJJpbZMoDMlpjiy12fiIqMLFS8HcCXGzQkKWudv7PafDsQEsCK4s3GhB7WlKwaNKkKbS/e8aJtUILO6AThD8fAGuxgQTIFzVSy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631647; c=relaxed/simple;
	bh=ERyjgMpetsSV7HmNF4hsqF0bdrmrio7r57PRd234Lqw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U5cmfN10JTNT32KB1zyKmy3d8PSMfx7m9c/Kjlf6w15vI83M4jCourR5rTSlOhJz1MUx+0yyAU9wNMmIthIkTUdz4Sx7dXn42d5XW6QDHAmEpxn8INuvEMbHO0TSb5xGDrA+COhnXU8fig1OeLvDxRj62iGGi8wnvfjPHatDtJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hXQSiz1I; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b736ffc531fso32025566b.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 08:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767631644; x=1768236444; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ERyjgMpetsSV7HmNF4hsqF0bdrmrio7r57PRd234Lqw=;
        b=hXQSiz1IbgYsEUmS8z5i1yZH/6aox1AulKzNjsOIcwLeXzKFL8WYcNRDbje1eKtLu7
         d0M795RfyUcvz1hZnCS0HR1MK9lXhNgtrh08XBh8SEGeJtN6+zuhFu8FTKyV1Wn80YdI
         sbSjd7QtQIArli8keY6GmS+GgpUkT9EpqCuDU9jVVogmarmZk3YK4mM+rF6KDTuors55
         buWUKbbtnovQTnZ5lIVgSMW6ngZHVU/IMV9leuTQtU1y+MyWkh9KNFXKhG6PgTwTIlej
         uYg+FbrbY6v36jSRnQmouRcitZZB4wJjYA/oI1h6YgR2NPPHcJ30HIYx3h75eSJpQ4z+
         oVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767631644; x=1768236444;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERyjgMpetsSV7HmNF4hsqF0bdrmrio7r57PRd234Lqw=;
        b=oAuXWqq20OahTJE7qHHVTqXXFmQB02g/mpkMnnHkx+fmJ1/+YSqETYMbXYIQmChjx8
         Rf59Lfm5TtHG/X5BQuHE4c9jGDGljYZActrB/gbhk1fV10rrPDQLJnpZ456eJtIkvlZN
         p1ZoqpbBoz6Bjd3cchiZtFRRtkhFPJ7CXymlQndoEejRboy/kUG5y0epjj0EmRPGCTe3
         ksoUTrVr8KeD6HjgGOup6oz74p/C9pDrmGVn31ccX7x7qXBJ5/eUBN59JzheMh4qMZhH
         bkuKy5xQ7oAdz3H2FN60+myAR4XLvjp1z2TR311c4zmkisRPnmUPWc5l+x9haQ9IJBEK
         YJUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuNPByYk5lMnQX/sm2zxOh2mMdNhdXbnHtJh1LuirMP3AGOF7+aIOHB9lGeXk2SNmQKs/k5dbT3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzerL3EbhIxTgyEO+bt7SyB4wtyk+EU1Qk3mUVGFXTPtQ4DHKaa
	v86XasFeUQSFANNocUTd//WuYHd5y81hJU2PHOwjSiyUAjlzRmzQHohEzuH/1GLYh73PZnakqyt
	ZO421+QjlHQ==
X-Gm-Gg: AY/fxX6mt8Z4xlLdCSztqWpOCYoZwcVVRSoFmcKbA9inVXS4c9bWWPelo8EV/j/RguA
	5Et9Uikc5mv5woU3KuV3ySWePNQOFViwLdcSvRqkYpD14nYn8eL2s92bbmq0thfiEt8FNgRUx4A
	DeZmNU9D/U4FwAq8ZMdOBKARW0j6ezh3/naeRch46Jah/M+buHwHrlZRIo8m72kHE5RpAPvnt7/
	HrmFhCSQaxUTmYI4DKBoXT1kjsMu3Ex6hoHuLKiUfe4VQ5JBCX+fEkFF+9oU5zTNGR2h+mGk8j1
	lq8okXdmoAhpbGgD4ozEg981hI9bwCtlAUBXMsj4rEqbkR9fmhpCw89XnEpw7ZB94zCE9iipaKj
	fh+KeQasF8YiMHo2reIWdRlw0XSfKVuKb+3uNNcmTm9bvfAMie13hIuq2RwrFFBCmcKTs1f4BH+
	JEELZMceY0mAKsiS2wBg==
X-Google-Smtp-Source: AGHT+IH8PrChGbBe3ifcPMF0XNauYBYKXVAb42mE0WG2Oe4GF884wrbNFmqGeNp3hqqHYpAdiAIsJg==
X-Received: by 2002:a17:907:706:b0:b77:f4a:ca1b with SMTP id a640c23a62f3a-b8426a6c79amr36443666b.16.1767631643937;
        Mon, 05 Jan 2026 08:47:23 -0800 (PST)
Received: from draszik.lan ([212.129.74.225])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507618cc59sm255498a12.28.2026.01.05.08.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 08:47:23 -0800 (PST)
Message-ID: <da028427208fc4d515060375fc95f1cc0f64e2ca.camel@linaro.org>
Subject: Re: [PATCH v3 5/5] usb: typec: tcpm/tcpci_maxim: deprecate WAR for
 setting charger mode
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: amitsd@google.com, Sebastian Reichel <sre@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus	 <tudor.ambarus@linaro.org>, Alim
 Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, RD
 Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Date: Mon, 05 Jan 2026 16:47:58 +0000
In-Reply-To: <20251227-max77759-charger-v3-5-54e664f5ca92@google.com>
References: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
	 <20251227-max77759-charger-v3-5-54e664f5ca92@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-12-27 at 00:04 +0000, Amit Sunil Dhamne via B4 Relay wrote:
> From: Amit Sunil Dhamne <amitsd@google.com>
>=20
> TCPCI maxim driver directly writes to the charger's register space to
> set charger mode depending on the power role. As MAX77759 chg driver
> exists, this WAR is not required.
>=20
> Instead, use a regulator interface to source vbus when typec is in
> source power mode. In other power modes, this regulator will be turned
> off if active.
>=20
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
> =C2=A0drivers/usb/typec/tcpm/tcpci_maxim.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 1 +
> =C2=A0drivers/usb/typec/tcpm/tcpci_maxim_core.c | 54 +++++++++++++++++++-=
-----------
> =C2=A02 files changed, 34 insertions(+), 21 deletions(-)

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

