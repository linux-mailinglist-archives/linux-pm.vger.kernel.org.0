Return-Path: <linux-pm+bounces-37028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E0BC1A92D
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 14:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0C80359552
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 13:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD55343D6C;
	Wed, 29 Oct 2025 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wSayh/xO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544CF33B6D2
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743353; cv=none; b=g1ltqLlzgsmOc9fvmo6eWHnnlCwybL8aEk0AT937C29tq7pblUmExvoVdsCJmO9BJvu0FD20HA1eJy3KJy9JTStoh4bI7LJ1FF+aR2aBP569Mhq/GhjA+l9s7m0HP4YElTJ0nnRGbvNpPvtAyFtzMpCp1PHaiza59PJe1uyJKQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743353; c=relaxed/simple;
	bh=fyeNQjPbHba2zQACV1XwHgrmcj9u7mbSw/E0lwVQwQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhixaiLcbRq/kde905ffSnem2/KekVyJhlMVJ6QIG7Ic1/1o5ulsU53a6uTLt9bAy4RmHnIPFHUZbA7cRO+ScqBrO6U17+pyRKKu3P1iwGFGNQgYSqudDmySjRcGVuuXbDvwXLHlUvEbRttCQUSihGFxrDNw/oaoKdKsYr+ILNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wSayh/xO; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-591c98ebe90so7189052e87.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 06:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761743347; x=1762348147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpAhRZEcISe/L4obGO6K/aBf0H3CSDRAh1WJSbvQ7BI=;
        b=wSayh/xOnAy3dXi4ntAukqEAHjvP9ucW73ZNIZyHbw2cHQsLL1Szf+DGPNGYsn58u6
         J0lwB0G/6WXg8TK1O1xAu8Frak99gd/QnbDsG5k9aR5NWpMNTDbuTL7oxRWZPWpRSOFx
         xVvP+51Ubm/kNNqZYitAOZdba2XhAhmt56BKrWjh3RH4FNJICFR+nON5Pti46FzTT5X3
         V25xSseaffbJRROIyrMREOd1AAqVkx51lYyblWTF4trc7wR1xEMOfoXA5rLlso0sYxnx
         sgyo4EO5o2qzKCCrqcLaGoGl+Pw64TwIG1bOSVwYd4/QlwFZqZYmuo7DnuaZmUHhVtZr
         9GHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761743347; x=1762348147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpAhRZEcISe/L4obGO6K/aBf0H3CSDRAh1WJSbvQ7BI=;
        b=bP7KP8e+xDOmqLQT1aQomt7zR0Belp2n2HFrC869oOdnGu9pGlwhcKtghWXr6cNrdO
         7wQJe4nmOBz0JIMODZWb3tM8oe2ck7QGuuymZS9sbHtDkHut2MFHYWkf6OKQuHDUQtBc
         yQuQCiZkgWa5aceKkv3BCxESxCcfPckHRoONqZJSoNFa3YQMteF7ND0YZAnI9RFxtRTG
         Dchrjd2kUqQYJWcuwnldFJh2PwiGvd0O9aRHzYfEA2v4zsbcSPtn3HkY0SnInU8BmpEH
         E5vDl4u+/9eEAdfVtOIk60iFJMkswWMHOeWlHA/X5brho7q45odNvx2KyGOM+U0ORnZv
         01zw==
X-Forwarded-Encrypted: i=1; AJvYcCWRS6dk6ZYWJNp5dy5xUFIEYs7Asya7wMBQFSzS3P5BtqQGDWPAi9H3WPKEC83bTF2VKe+hSnGW2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xW9cOntLOdz6fcPn4+7S9PDVpB0TlD87tbFTHcBvHF63a1AF
	W+k4pSFFGuutuKK/vtq2feo4quuwIa1LTNL326Kvl2Zw7vVzpf3gYqXuNdBnf5djgozwoK4Q2Un
	97oPS5N4+4wHNjIQVMM3AU5OlAk9RCRFD6hli2HQJyg==
X-Gm-Gg: ASbGncsbewwfKrXulFLuagk1DOQQY/WxdL0xdLIpadGAnbFwdlUgdSH/eMOp7VoOfbZ
	YcJ7SyXvAPKxSQxAtGUNPeRkhFX7VTPfl8wGCphhgTpLbJP6jS+jIObDwvnvvjm+mFOXMWVdhUZ
	AogygcnU1K1v2v3m+MZqGsJUo58Raf1meKtozVtt10FBZotyuLUCCJUHcORzFz8O5lqoN7hRAP0
	EkGD/XxHp8CWIRPMkVj8m35i67KCyxZi/0bNnIXtL2doM68P41KcAq4tQu7
X-Google-Smtp-Source: AGHT+IHoNXhvs7nAEQT1Pr7YoG6bCNTomzDjqEik5GRK5GTNnbmdXX4kn01zdcQcoosBSkAxyYQ6vANHvlPp3vj1L2g=
X-Received: by 2002:a05:6512:3a8a:b0:592:f449:cbae with SMTP id
 2adb3069b0e04-594128617a3mr1173473e87.11.1761743347041; Wed, 29 Oct 2025
 06:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761564043.git.mazziesaccount@gmail.com>
 <a5957c4f83724d4f32527fb892fc340af4eeddde.1761564043.git.mazziesaccount@gmail.com>
 <CACRpkdYEUdJRvNPKhxx7orYHH3OE6BXXjrG9JVJo5MDHGKE88A@mail.gmail.com> <8b5dbbf6-bbde-4015-b0d1-12d6ec770ceb@gmail.com>
In-Reply-To: <8b5dbbf6-bbde-4015-b0d1-12d6ec770ceb@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Oct 2025 14:08:55 +0100
X-Gm-Features: AWmQ_bmctKf4r03BFEQZEB7--T8kdCIHNsOEFNutvbq6JrwVjRi4Ptn1KMtyXrQ
Message-ID: <CACRpkdaK52wY7MYhnqCqzOAFVu2V=NejDTjAAhkxhf9rmrV8iA@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] dt-bindings: mfd: ROHM BD72720
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andreas Kemnade <andreas@kemnade.info>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 1:30=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
> On 28/10/2025 00:42, Linus Walleij wrote:
> > Hi Matti,
> >
> > thanks for your patch!
> >
> > On Mon, Oct 27, 2025 at 12:45=E2=80=AFPM Matti Vaittinen
> > <mazziesaccount@gmail.com> wrote:
> >
> >> +  rohm,clkout-open-drain:
> >> +    description: clk32kout mode. Set to 1 for "open-drain" or 0 for "=
cmos".
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    minimum: 0
> >> +    maximum: 1
> >
> > I think CMOS is the same as "push-pull" ( I could be wrong, but I think=
 I've
> > seen that before) so I would probably try to use the pin config standar=
d
> > names as strings here but I'm not sure.
> >
> > rohm,clkout-bias-open-drain;
> > rohm,clkout-bias-push-pull;
> >
> > Mutually exclusive.
> >
> > Or maybe use the pattern from rohm,pin-dvs0
> > with string enumerators?
> >
> > rohm,clkout-bias =3D "open-drain";
> > rohm,clkout-bias =3D "push-pull";
> >
>
> Hmm. I kind of agree with you. Still, the way it was done in this patch
> is used by the other existing ROHM PMICs (bd71815, bd71828, bd71879). I
> am kind of reluctant to support another way in the same driver - and I
> am also reluctant to change the existing bindings as that sounds a bit
> like asking for a nose-bleed :) (I've in the past worked with some
> devices which didn't update the device-trees when kernel was updated...)
>
> Do you think you could live with using this existing convention? :)

Yeah if there are precedents, either we can reuse that or we need to
change them all, and that invariably involves deprecation and re-implementi=
ng
the parsing in several drivers in that case, which is annoying and
takes time.

It's fine with me to keep like this.

Yours,
Linus Walleij

