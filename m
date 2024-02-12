Return-Path: <linux-pm+bounces-3844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A29B0851EDB
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 21:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C7F0B2505F
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 20:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D217248795;
	Mon, 12 Feb 2024 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a+Yb7tEC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A6247A7A
	for <linux-pm@vger.kernel.org>; Mon, 12 Feb 2024 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770883; cv=none; b=kklCE3cyhDYsA5AcPBkJFXlYU3m9EEJGhAR0Po7azzEujM8O41ojW6f7cItNGpT0FSzWfBzDLAHpDYp8tks1w6oYOQvxMzrDKa5U6sdFgLen+fwfJ2VYl8kdWG0iqsYRnLWJIkb41s71oYzf9RDERI7ZW12F4xPtHAmActprtDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770883; c=relaxed/simple;
	bh=sMYBJYjLm8YsiiGaWfwhHa/Xio+UaZ439FcuhwQ9JVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeJuxKnLYIllzbP/uR9mtKuKspZjEN/Gp4GkBxV6O2DJQ/aLuni9YLgeQLjV7otpOI2x5f32zkl97NaufSKFnJ6cJ15zc85gmzhA7idONaThW+SsM6Yx6gIyJaIGE4iYQHMYi6IUH895Y78+9iC8AOpWEg38/BEbMSDpnzKtqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a+Yb7tEC; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc74897bf61so3681981276.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Feb 2024 12:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707770881; x=1708375681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PY3cqSsBwNpTxKZXjc6hWsn0tIs/KUkTAVHRiL48yE4=;
        b=a+Yb7tECEsxUlJG9pZBQ4yYsQJfwSb8/Dp7q9QQg/oUfwoRoVm7+sAHVAPASxRcUO4
         jnfIjeb/hO2y3ZxtQZUcFVB7T9nv0p3SHMmAhI4++ZlDRp4Lf2/JBYBt1sn27BXWHRIH
         //eg1gydfBzXBgUcScNBllJ9VXAceIq+IJG0miyzlR85sSSl7F9NtMmmRt3J2rfKTzvs
         ErPJtzQLXWAWNN2di9UwfCUoudZO2FTHZ8g9RZjQfHRk0KGFcLRhOnX9Gpvc44YfZhAg
         nAJ+CzzXA/N45fz67vDcWlUGXrHxlsL2xzsrtTHkQKMMtrm84syYBNZKJV4HiiPhyOtS
         rUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707770881; x=1708375681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PY3cqSsBwNpTxKZXjc6hWsn0tIs/KUkTAVHRiL48yE4=;
        b=ZLsiP3i9O8/Z9MjSMyfV+gFpKTMpHT9FaggKbK8kGv8VV8vOp59oY0wgmER3OJyot0
         L+tBtS6Ro++5U4OSPcC3Mh887AGILd9AIdtICHX+C545cuN1LORo97pHP4gECdFtbN7U
         zyexwINh/EQZiNrPoDCGlJ82n37EYTqq172OtFWY6v/ljb9FfJ2YrJolJzSGiFmObATq
         SGIyxIa6Qar7USUMAF7glmJ6ypIPVrOfIk4woviN5lCv9Qihmqy4v17F7jmzYQd30Nyl
         bEh368P7GNpt6RI4hWYSnfWm0EPmU3TFEq6Q9z17UjpvMoUwXT2EJ/Pcw/cBWImu6SQ5
         MH4w==
X-Forwarded-Encrypted: i=1; AJvYcCURUO7WQBYMKOHeNPv5bfEgBgFrubD2eBzKizmAgpN4tvT2qgDAW69Ps8ARTA3hGUtrtOoadddUirOxS9BRbskysQRpm03IAPs=
X-Gm-Message-State: AOJu0YxzyMjIZ0lpslFwF9XeRziwGv5m9jqCB74phQI7SE6jM+61ZHQS
	LQg4YxIqVw//T2q+NtXHkd3YaxCjgPUljwzVzGCIxYYdRipSHiP18yK+bhhFIjnW6D66cD4yKxU
	4jgYiR8otSoR1uWADNc5jDG+pQXZhxuZpBERW0w==
X-Google-Smtp-Source: AGHT+IHpuGZC6SrLdNnZki7WawOfEUwxb557/rUhxkGHMzuDzurgn+uKQ9WrdUdXaiN7gnBNgrqdYeHN6a/77FI22dc=
X-Received: by 2002:a25:ad82:0:b0:dc2:2f4f:757 with SMTP id
 z2-20020a25ad82000000b00dc22f4f0757mr6478822ybi.7.1707770880839; Mon, 12 Feb
 2024 12:48:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org> <20240129115216.96479-5-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240129115216.96479-5-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 12 Feb 2024 21:47:49 +0100
Message-ID: <CACRpkdbMFHPK0SBSxiZ3FOqChQFCBdOny0yYG--6V+1S=CKgiw@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] reset: Instantiate reset GPIO controller for
 shared reset-gpios
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, Sean Anderson <sean.anderson@seco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 12:53=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Devices sharing a reset GPIO could use the reset framework for
> coordinated handling of that shared GPIO line.  We have several cases of
> such needs, at least for Devicetree-based platforms.
>
> If Devicetree-based device requests a reset line, while "resets"
> Devicetree property is missing but there is a "reset-gpios" one,
> instantiate a new "reset-gpio" platform device which will handle such
> reset line.  This allows seamless handling of such shared reset-gpios
> without need of changing Devicetree binding [1].
>
> To avoid creating multiple "reset-gpio" platform devices, store the
> Devicetree "reset-gpios" GPIO specifiers used for new devices on a
> linked list.  Later such Devicetree GPIO specifier (phandle to GPIO
> controller, GPIO number and GPIO flags) is used to check if reset
> controller for given GPIO was already registered.
>
> If two devices have conflicting "reset-gpios" property, e.g. with
> different ACTIVE_xxx flags, this would allow to spawn two separate
> "reset-gpio" devices, where the second would fail probing on busy GPIO
> request.
>
> Link: https://lore.kernel.org/all/YXi5CUCEi7YmNxXM@robh.at.kernel.org/ [1=
]
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I can't think of anything better, that is reasonable to ask for.

I feel slightly icky about the way the code reaches into gpiolib, and I thi=
nk
regulators should be able to reuse the code, but unfortunately only the day
they have no board files left :/

I do feel the core code handling "reset-gpios" could as well have been
used to handle "enable-gpios" in regulators, just that the regulator code
has more requirements, and would be really hard to rewrite, and deals
with descriptors passed in from drivers instead of centralizing it.

Like regulators, reset grows core support for handling GPIO for resets
which is *long due*, given how common it must be. We really need
something like this, and this is certainly elegant enough to do the job.

Yours,
Linus Walleij

