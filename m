Return-Path: <linux-pm+bounces-37765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86053C49B24
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 00:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB163A28F1
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 23:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF90E301006;
	Mon, 10 Nov 2025 23:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UhQ1D1Km"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B6F2FB988
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815867; cv=none; b=Kwnzr8bnQcBnXOOjwF8LKFy8mIdwWFHUDpBrIW0QehKpFt2LXUV/cSrEDPUPK1ZirmjlW6l1VBVStGoiHkL51vMPa45tFoso0IFWxbTbWjhSe+t2Bu1Cbc5qeOEELHSL24VXrvBqTHoWTbbxtV81f1Z9Zh1lTB+iFoCJ9U8k9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815867; c=relaxed/simple;
	bh=iJtkiZUOo775Ftb6cLEsbpL0tmdErWFS9CRdvdq4yBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLssv6GrEzAKtiu9tQVfH9xSw6L07mgdFHc9xNHOXdcusGYU+R6mUWhWWHePEbdfLEJLvrCDfppNp53l7BVQ3lEkWzi6Yy6osj/4Y7fVguc0MuFyJMzRQXfWV0rq01y63zZqwx0etfoRiNzjhgYHvpARjFtvJ4UABq93YMtUg7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UhQ1D1Km; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7869deffb47so35045887b3.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 15:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762815864; x=1763420664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJtkiZUOo775Ftb6cLEsbpL0tmdErWFS9CRdvdq4yBY=;
        b=UhQ1D1KmPSyna4F/76ZCUiG8KhIv95nF4dhc49qrIM3p2GzZR8fl4PtKw6Yk5uaenr
         Jxo6B1MPDizlQu/eAzhlHvAjPysa3NgZUqffrBat8sUZCey95AmWJHKnSMiP9zRpfVwn
         yDf7hD9zPMNJY5K/TDMfIBp874x/FBBHi88+dxfp8g2/um8X8UHQj372t+OGfbo82eR1
         O1hbOAThw5oCk4Sy/TkWbTHXa+HDjeRny+D/HCyIsPlxXxKrnhIkL79zMZOuophqGxN7
         HEm1Hqzly5dxGv5sdqIOUUxBQAtVaiVswEfsuQw5gUpO4MhmxEB5Nma4Cgn7+HcHKITN
         65kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762815864; x=1763420664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iJtkiZUOo775Ftb6cLEsbpL0tmdErWFS9CRdvdq4yBY=;
        b=dHvHjV9qBCL32qGj7uX3qFISpVa88nOWb/PgK7sP5iLbKNj1C3LmqD76gbB8qOoAR3
         xNmHoWl5GNF3RSlR936aaLiyb5nfmuk6c4184AFonOd6ulK2M7IUbROb7RX2kRQZg9zj
         Uv56zXbdWjCio5ziZ7XorJt2CJQ+EdQ15p+CSyXBIx/TWta2zUTWvfDfy7dntCreX8LR
         gX6PNcW7wvvsvGK3zKQzTVjuCNKu4sovjEZqgYRAtbONOiC0RjJL+GzrVc5t/0JbbkO/
         ki23k/oNzwQrTZqRkOaIrz1vrKxwCOnw45X/dkqbpOm+yJf4ZzdxpywCnUSfWKdG27sJ
         18qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfLDc/Nt8ZDIpG61ZROXirXTvR5Labse1ZNHMaj/6UmRLZEwlbQfn2nrpxCcjd/tqXKcygrsFEBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3LU5iEg+WuWr1bzklLOW6iXIGBtr2V9RUgrbZTun6Tc+GaQxS
	ZurnCgx2BseNbXqHpIUYF5yWwUyjHuq223B6Dfy1lZ8z+EmPI+q7OdFCtp5KIVOUIkIS0lMjwYl
	o3Wnx2gAHXaNE68kVjg0TmjPNEk+OVz5Q2K/FFYkL1g==
X-Gm-Gg: ASbGnctXMsLV9yopDOxdWGVMZSTh9fXcXSayduG4WsqzlU0ADm2GVIGdtXIyqn30h1b
	ilyjri8evgxtBEpdCLqUplOWOUmjmkQVy1ux7/Y4EvrJuL08BHmU8TL3yuYLKe4rduCoCv5Vani
	MeoNHvwolAC/lBqPOr2i/UU2vy4RhEZ2TsPe063TJ748dDUqMXFuxbwm/mAlSnCiVnOCCyLTKiW
	JPX3WJKUAVkxRMCzCcIoehTbWtZsdrX0KO/8OGneLvTyJN05/zCw8W0Xa7+Opgp0dB9W0I=
X-Google-Smtp-Source: AGHT+IHoC/R8TGWkSsRmVYTrTznpjr4STw1JDCmsU2sbR9qoad5PnTy6Rrlwiey4S9ikwN3xlZNQtXBlBuI95lMoqZY=
X-Received: by 2002:a05:690c:6385:b0:786:4fd5:e5cb with SMTP id
 00721157ae682-787d541b7f3mr90568307b3.35.1762815864323; Mon, 10 Nov 2025
 15:04:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762327887.git.mazziesaccount@gmail.com> <742fcdcc8b6dcb5989418e8c1cf5a7d7ba5434a5.1762327887.git.mazziesaccount@gmail.com>
In-Reply-To: <742fcdcc8b6dcb5989418e8c1cf5a7d7ba5434a5.1762327887.git.mazziesaccount@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 00:04:09 +0100
X-Gm-Features: AWmQ_blNtjThswk7W8THjiE7tdsgu2zFtwGMw_ARgVxMcfWy78tjHu1U0YBhMO0
Message-ID: <CACRpkdbP-GZXtj_-AuZ=q8zUKwt0qWQ1L6v7WsoQ50JwTs6JUA@mail.gmail.com>
Subject: Re: [PATCH v3 02/16] dt-bindings: battery: Clarify trickle-charge
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

On Wed, Nov 5, 2025 at 8:36=E2=80=AFAM Matti Vaittinen
<matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
>
> The term 'trickle-charging' is used to describe a very slow charging
> phase, where electrons "trickle-in" the battery.
>
> There are two different use-cases for this type of charging. At least
> some Li-Ion batteries can benefit from very slow, constant current,
> pre-pre phase 'trickle-charging', if a battery is very empty.
>
> Some other batteries use top-off phase 'trickle-charging', which is
> different from the above case.
>
> The battery bindings use the term 'trickle-charge' without specifying
> which of the use-cases properties are addressing. This has already
> caused some confusion.
>
> Clarify that the 'trickle-charge-current-microamp' refers to the first
> one, the "pre-pre" -charging use-case.
>
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

