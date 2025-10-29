Return-Path: <linux-pm+bounces-37012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D79EC187C3
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 07:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8551F1C66B2F
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 06:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F702F0C62;
	Wed, 29 Oct 2025 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHGiotsU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E21B21ABDC
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761719563; cv=none; b=h44xQ3hY+yJYhUDyuwRuo2XB1c8lyCqqwLbMAJ4RcSf827jaBOWRq1tjkHA4NB7iP1oyHEgGmcUGD+XN2IWKukRlq0tnFO1Ol+TecIGW8+tqbDF6Z+fDVXGjgLcP6LffDs91a59fJPelBclmdCejFNQ2NpFDKuWZwqiFzimyf4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761719563; c=relaxed/simple;
	bh=8fqX1yNSZKPOAEeYYcZLsQwxSr8mhllePdhz+qlw4hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtOpj3E2+iz+ThA637B8G2waQXSypnuxJEkNlMNeiOU92MJfqP1BK0exPiRrdcvDoh6L5aM632vRy4X/WbjN2Fb/tgfqGgNasPEsYYqwdSY8G5zhNBPFPc3e2bmxonp+DIsEYaqpkB7OhP7gY+tDf4kTwzMFQ0pB4PgnYHaPWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHGiotsU; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so6675285a91.2
        for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 23:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761719561; x=1762324361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8fqX1yNSZKPOAEeYYcZLsQwxSr8mhllePdhz+qlw4hc=;
        b=EHGiotsUp2Abm7ooDXmMwop+Qir+8ydQKxShv4MhnIxUXdq1DxH1gd296PswilMPbP
         CoSI2TzlIqcooeg0IBwB2RSV+aQLcGoofxoBjFVHI7wmakawJF3Z0dWzTl9XaVniDC3z
         P9qlp/fn+gi5u2GMBB8K6WgCdRy1hrxelrTiE3rTahKzEx5o4dDYhzWrU3IpbaN9oJ2c
         e2QM8BIT+HrgKxU75AYMkftALXw/jk9Y3VgzPkl0ihg/vYbrj0QR0IAzTMgQytXMILn8
         tRaWBRNFSZ4WllpbZs+b1xPHbCpu4woDtx4Z3AFzXZev1a3KXGw4sJ3X6nI3Js28PQN9
         T8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761719561; x=1762324361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fqX1yNSZKPOAEeYYcZLsQwxSr8mhllePdhz+qlw4hc=;
        b=RnHsXVtDD8ygTnanE5M1vaw8nH/un/ezGquAA83On6Ent5PKKyOHQUGA5cdPZ3SyKl
         mKKo0UsL7rSaJtWPdCQ9OOuhJDW8Nmdr0r5qkdFHnYY/yq9DuOJvPClh7HFKIhAAkEsM
         zisGg2rS8BJSGqcdscgXvTMht6BUcuzoLBqowrl0JTNL/D4gr28CcfJZf9eFC67UMuhp
         cWkRMhF4J40nHQwDwP2PjO0fVmLe3cYOzXjzW1ft16DV/JJi6T+4ioSk9X0HGwYlREbZ
         4bV7RBc6cgJwv2SrOJYIUWyc+R4pmDDMeyrLt0tXidqBhxZlkgGHBg2ftIXw1qKazAp4
         4bQg==
X-Forwarded-Encrypted: i=1; AJvYcCXfjyPiH8pr6fvEim8M83wfb+S6iSktpPJdkY7Uh77aXG4qyHEWaLsnZZToudlZ6SRlfRAphC7Q0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHju0Z86SRh7IgZ5YVfcAB9jOy6PIXgT2UzCTbn0khtReZaERM
	Lur9d1a/2CpzQL69FR+RQKsg/tgzK5Ec0wvVkofQ8DgRscwO5hj2EFA9NFLzjcLUnP1iwOXqwCL
	2V7BRnlTF9zdVBkEw/ZiYqiseOX76Org=
X-Gm-Gg: ASbGncvjcVGwBU/MTwES7xpOkOjuvx7NeV0HUkG/xdGY/U5dfJ/jhI5CxyguAPrQb+v
	uKJuqOWwTbUD/tFLTc/Zy74NSMW9G8+o9bUI+7TrKgOkXKOsJzwzxJs2VMkV8zUS0SA9hrCk/42
	WbFULvqddgPqvueOlEQN75xwONjANsBFyntobr8pTaHSUaY1RtH8QBBFcjIUaiAWUZoQ79eHk2T
	09xabbenBz0VwKRJEnnsnzrw/KMHapUHfQctMPf4OED72PZoe8FqnkVybZjmApr9atIbDTHNA==
X-Google-Smtp-Source: AGHT+IFFVo3TxCbMkZ5UI77sKbgoDsW97wn27M6ulWZD7oeWngePKzAxdda7IduW8N2Ts8l3ViDHxq6u4X6dWfeQ2as=
X-Received: by 2002:a17:90b:586c:b0:339:a323:30fe with SMTP id
 98e67ed59e1d1-3403a15c2eemr2084010a91.14.1761719561334; Tue, 28 Oct 2025
 23:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761564043.git.mazziesaccount@gmail.com>
 <b13b733e7e0fba05652f49f727412fed9e0ceb02.1761564043.git.mazziesaccount@gmail.com>
 <20251029-adamant-mamba-of-patience-cddb65@kuoka> <a81fba66-adf0-440f-96e1-bf3a83d504d8@gmail.com>
In-Reply-To: <a81fba66-adf0-440f-96e1-bf3a83d504d8@gmail.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Wed, 29 Oct 2025 08:32:30 +0200
X-Gm-Features: AWmQ_bmRIxkt0_0lmeBnGc_3ozd43KhfedH0KHXGki9EADGblZUmvI-2tDAdlfI
Message-ID: <CANhJrGOpH2=h4M5MPM2XwVf0DqfM+5SSvK3Rse7+UaoDyvkUsA@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] dt-bindings: Add trickle-charge upper limit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andreas Kemnade <andreas@kemnade.info>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ke 29.10.2025 klo 8.22 Matti Vaittinen (mazziesaccount@gmail.com) kirjoitti:
>
> On 29/10/2025 08:03, Krzysztof Kozlowski wrote:
> > On Mon, Oct 27, 2025 at 01:45:05PM +0200, Matti Vaittinen wrote:
> >> Some of the chargers for lithium-ion batteries use a trickle-charging as
> >> a first charging phase for very empty batteries, to "wake-up" the battery.
> >
>This is already reflected by existing bindings:
> trickle-charge-current-microamp, Please, see:
> bbcecd1b9335 ("dt-bindings: Add trickle-charge upper limit")
>
Sorry, wrong commit! It should have been the
e3420b49949c ("dt-bindings: battery: add new battery parameters")
as you found out.

(Just a clarification for anyone reading this thread)

