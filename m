Return-Path: <linux-pm+bounces-38193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E1BC6BF1D
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 00:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC77F4E72EB
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 23:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E369D31062E;
	Tue, 18 Nov 2025 23:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UfvYck1u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D183B308F23
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 23:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763507201; cv=none; b=cGf1uAL5NVOEkFftPOoKk09wl88rLAaK+9lHQGmmlttKjYZesVvJBtxaMvfOXWVMSiIFd4N0XQECOUgi6w+6tyVbxf0P43kQo9ugb0pJALVUPGtyYt1lEP14+o486PT5JxB1bpCw1JZraLJQMON/xD4PEM0GhxI3kAg0+RArjks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763507201; c=relaxed/simple;
	bh=njsPLW5+sRAcBfyQAXjbkM6oMwgJ0E/jrmQ49WJzmtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2IQOh3Y6RPNMjjyy9RsC2dOnLLn4X58ftUliwKTmkDXgn5DJZhro7T9zwGRwv+Jyeg8UwLc6YlJrdXDesEWY7eOymiX25wcwcGpAETgll4KSJYljQW3XhGODDi6IYmwmBqse+sCigQhV7tOH7T8RODizEbudEwK9bPnME+UZb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UfvYck1u; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-594330147efso6012661e87.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 15:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763507197; x=1764111997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njsPLW5+sRAcBfyQAXjbkM6oMwgJ0E/jrmQ49WJzmtY=;
        b=UfvYck1uNz8mqIo13JFGwzFX9VIkjKIEo9RmRV4QPX5MnAX+9ywoIUDmVoPkCRVIiG
         3fxyN53ckBdXcvwPWw89T7UAoRuOIys+10yKO3sA++4R44slzYgRUir+QbRn2769mnk4
         UnUwnfec1xgR4Xn6p22g6kaT7AUAac4rXo6Lmu/xf/BLJjfEXH5eFSFC9uHxVF9+UTu/
         HGU5ktezAOQtZ36HJxwuWEjhQul4Gcn10kzddMrXMmazzT9msgcv/l0C71FGD5mXbrDK
         x9lKdHGi+prGGXgWm8LMMM/Td90mu1ZLW+L7bVuf4z9Kl5kYjL1Q39LHBi+TKA/57TK+
         TdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763507197; x=1764111997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=njsPLW5+sRAcBfyQAXjbkM6oMwgJ0E/jrmQ49WJzmtY=;
        b=UJU70tXjCtYJH+Wjua5uaws/fZBMzZlfNvLNEoc6DUcstwG3OIw3vylY+WwwIhLSej
         66t3xYXjTNzW6HwtMoEJcA+fnkMPVi1ECOFhFt1gT4r3zFmTqtkA6CqgBX6S367nUBCo
         n4OcnQXKG7T4yXDilAm68DLy45Ymx5rKujz7tRi1tdLE4nV2rhgsL7cyMFWaeWL63fFY
         kqtINJxp3SNofdiuorfER0LuQZQ+Toc+wlS5app33ijJJ7qrIVF8mhUPAoAQnbTkzaTY
         G9CvCoRQZ4IyuJ8z2SMfBU0rH/CkcLnsJsP7qZ08zAWA9+3IqjS2TUkkrfiu90ZoD1FH
         59Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUKG8G0OiWhbIGg7HdIRZm++tEXvA0UQ0WgibYgFZKbvQwRlmh9H9lhRWSlr+ScCCY4f/LRJ4EjVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYhlKtrjan/bdy6SidlsESnPaHSl3WeoIbY2nj3ok6WiXD6Med
	SrZVoxdUCXYJDi7C+yi6lCIuSS6nlHsbhO3qaNUVbRizyz881cPZhWaIRnTo33Gk9py/LpQ5rON
	j7xPYtjN3L4DRRfhCf2/YtzHzF7QNejjCXTdYRwMuUA==
X-Gm-Gg: ASbGncvQj84U68OGB8A4r/2NbINHPck3Ua6rQ0IpXpwZLVBM2ldTsER1tkVgiU36zv6
	hMg2XDkYKKegclMjRg+Dv+GpEqGOmPeC/JhTDF1mNC07Y2LWPiaiLWxAw2irpaehJhnPuOxu6Df
	Iieq7Wxkyi2ewYOU77z1BYJAtoq+CbD7MN2DK7JHKzO0SfQU1yZdPJ+en3HNYaOIE+sHdcMu7S5
	rvoe25LHi/fqqA4Mdls5pI2X4DH3XSkXR2c/Hn6QOT3ExN2CLxMlCF7HPDw/4qPypxtsDmj+gg8
	7UKC/g==
X-Google-Smtp-Source: AGHT+IHgvWgHNR1n7HikNfbECM3QMJGErQNkGV7PI3jzhreQtbR/8j6SX6DzkJAmHt+W6Slk62x/gQ3zMskh1FFfiGU=
X-Received: by 2002:ac2:4c4b:0:b0:592:fe0f:d9e with SMTP id
 2adb3069b0e04-5958419866amr5810310e87.7.1763507196990; Tue, 18 Nov 2025
 15:06:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763022807.git.mazziesaccount@gmail.com> <ec2cb44d9d00f5edaed2fbe17fd9ddbed914ff37.1763022807.git.mazziesaccount@gmail.com>
In-Reply-To: <ec2cb44d9d00f5edaed2fbe17fd9ddbed914ff37.1763022807.git.mazziesaccount@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 19 Nov 2025 00:06:25 +0100
X-Gm-Features: AWmQ_bnx0kL6TQjG1WBAuJJp0XRB0JYUZxqe_CZgABTVpH_anNv9ed5mp--DLwo
Message-ID: <CACRpkdaa_DuXbLYqOV3aOSGywz1wSPc3-7SN8FtwTdVza6-omg@mail.gmail.com>
Subject: Re: [PATCH v4 05/16] dt-bindings: mfd: ROHM BD72720
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-rtc@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 9:52=E2=80=AFAM Matti Vaittinen
<matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
>
> The ROHM BD72720 is a power management IC integrating regulators, GPIOs,
> charger, LEDs, RTC and a clock gate.
>
> Add dt-binding doc for ROHM BD72720.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

This is looking good!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

