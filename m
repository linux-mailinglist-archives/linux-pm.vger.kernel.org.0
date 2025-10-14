Return-Path: <linux-pm+bounces-36066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AF4BD97C0
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 14:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F7C7352B52
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 12:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0889313E20;
	Tue, 14 Oct 2025 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HD+nY9Ki"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929E9313532
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446726; cv=none; b=ArUQMR61MW3q6g667CBXK4AQJDJCVF3Rq+u6bQcQ74RQKKBfNzVfC/lOodURCOtu7Cl2j3GdW4ClLJWsIma42zU6JyKyfbztzEwc7CE5i9aNannw97BpYXym1EQ5pgUHKXgKw+B8hmg0EvqBhoUfTrAHWNZKDOnWaC4XVvq+FiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446726; c=relaxed/simple;
	bh=ERKaxZi856JIVKreXO7sribpAgoWkWL8cPcVypMRmHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MenBvHJ5egod0jwoWBrNmUdHN/pLKarATQ5eNo5ImT5C8WdzrTT0+pmYukdgiacD0kDj6OgGNZTvWcD8M745lxHYW80ktQpJteLPCY78OJj5qTkZnCUFoOpP8lG5JHiTx9RmYj+A4bEVseUmypRdUNWCWEs6+3pS7PqUdX8moW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HD+nY9Ki; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-635349b6fe6so5114142d50.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 05:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760446723; x=1761051523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERKaxZi856JIVKreXO7sribpAgoWkWL8cPcVypMRmHo=;
        b=HD+nY9Ki9ZCU+ZBbai3sK4TlP+Gj4PeD5IBvNbVgmRwrXEMP1rH1Kq7Wd2U4DC9ql2
         mmbSs/sedO+Z+pqNh178iwTUljJhUPXdoP+VQFu2ruyAZTpafom4Dgb3i9C7kLT30HMb
         nugdcECozBZLP8w6AumLU59dnaaYGy11Vk23pFabxvZWzNmDF8nOoZlM5WedT3ES7DKS
         D/cB7mXIddWy/q7Wje43ITkR6khfIHEjDiCwmec977cTp60w5mWUdbX6XXjhJUkrWeWO
         j4ESkWjq0mWBEgaoWoQnKZzyhE+qXTM8zA+qwVIdhoT3qqyvhnb1qjF3AFb5czRRY0iT
         BJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446723; x=1761051523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERKaxZi856JIVKreXO7sribpAgoWkWL8cPcVypMRmHo=;
        b=ags+SRxz00IRwzsr8zQIphKw6v9ID+FHK+OtgsZTRGSFj/fkFmjcuVN98aiaM5ElVH
         PNaBHz0WWX9zt3ccr6i3cWGMUeYCurpyL9eiG0A71WGTpYCTKYUFiGK8ago49EWlbbUR
         poqCNmollT3XqqzWLWtztpyb+kHFfVa4I3CUtXz2BgATgrlA9tkU5bOyxMF8F2XoIkOL
         YxkIlk6OmHeEj0CqIF84nrd5Od+CslrbtJGBD+RJyQvo/UpaQ55/QMcEnFFpLfI5UkYv
         ps20LjBGh+TpgmQ2UcDZtQoMDs3a4kUDJUZgYtlMkAZELU0yiGEg0zlwdKchiUN3HWvH
         AOoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIyqH1W0kt6ba4MYuh7401qwn0lVyW5Vh2WdIZwBj7yU3sXIZHoPfAiqjwTkInnxBu9YOiEHiTtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDE93Um+qoannjn/mKqvNtpZoc0jSqzvMA/u+Mk+zjbViJRFbF
	0BQK66SoXT+GticRFOOucavWbVB1x9ljYSdE1xF7CDbMew++tTOcVWTih525yBF3V7RJ5wIzRvh
	hkfiexcQ3RKucN/8TsbV6L475jhPaM2atkJHMayJXgA==
X-Gm-Gg: ASbGncsCbb32HSraet9gcHBrYK0eTDOZzHJKxEdQRjzOAInU1HQbdm+gcQS+dAczj7D
	u0IaZq3CTfu9LQeANJ98lttnl+f3cP2q8aw05v1Fo5e/G0UvnwSrZNj1597gKfbEcyObY9YIdPf
	O6UqLLpBWCxf9bcmS0a2i5O5yN/VzXdBVzA5Ay0QTl6jwIe2OIyUjT9wteT+QQ2xf9yV0s5sRgk
	2jJiKbHeh2VnqBLFdgMnqM3E6j1zw==
X-Google-Smtp-Source: AGHT+IG7Kofwx6n9tYMDxUa5Z04wJalhfP6YJEHLa4yTiQQEa2UVqFp3ownpK3FKUhmGBn3Yg5tzw6HGtBhEHg9/vxk=
X-Received: by 2002:a53:ba8d:0:b0:63d:24f9:5332 with SMTP id
 956f58d0204a3-63d24f953d8mr775113d50.55.1760446723523; Tue, 14 Oct 2025
 05:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759824376.git.mazziesaccount@gmail.com>
 <fe1f4a0947c864496f4eeec8eef806afcf6094a4.1759824376.git.mazziesaccount@gmail.com>
 <CACRpkdZnoMvYBXN7b6dw+uPs=f1WXr9wX-0VF1c1qd-rq+17LQ@mail.gmail.com> <cac4222e-1f66-40e1-abf8-7d4661d43bbf@gmail.com>
In-Reply-To: <cac4222e-1f66-40e1-abf8-7d4661d43bbf@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Oct 2025 14:58:28 +0200
X-Gm-Features: AS18NWAzYGkVtZF2eWYQ8i62TI7iWUixyj6KHyQnG8bjFDuI6exLbunxibrSSZs
Message-ID: <CACRpkdbOKNPFxNJM-r+HdnfKYisWJrQXvG21EL9w4UQVP74D5A@mail.gmail.com>
Subject: Re: [RFC PATCH 04/13] dt-bindings: mfd: ROHM BD72720
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andreas Kemnade <andreas@kemnade.info>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 2:11=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> > These are a bit idiomatic, not using the actual framework for such
> > things (pin control) BUT: they are on the other hand crystal
> > clear for an integrator working with this device tree, and only
> > four pins so why over-engineer it. I am fine
> > with them if the DT people are.
>
> I kind of like to emphasize the fact that this is not really a pin-mux
> in a traditional sense. We can't change the routing after OTP is
> written. As such, it more resembles "wiring" of the signal inside the
> PMIC, and this property is not a control but tells us how the signal is
> wired. But yeah, let's see what others think of it.

Just that the muxing is controlled by OTP and not by runtime
software doesn't make it not pinmux. It is, because it is
(one time) PROGRAMMED to a certain purpose. In a factory,
nevertheless.

But the pin control muxing subsystem is designed for muxing
that is controlled by software at runtime, and as such, indeed
not a good fit.

Let's go with this!

Yours,
Linus Walleij

