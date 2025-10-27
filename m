Return-Path: <linux-pm+bounces-36935-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC20C11E08
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 23:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B10F4FADC9
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 22:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C7032E124;
	Mon, 27 Oct 2025 22:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZZdxYt0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D66D32E128
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604954; cv=none; b=VKbqSAoF249j0KasqJhapkdTat6ArRKWlXeOj7aGQcelI4OkcSwmatxqcFyWg90QhZEqvYyQT+c3Ll9LK8rcVjXUILeGaCGgqqyYwmG4xFfvm6JxGBG3YIB0eAIgDEuP8huZgxUcRDBEtf7EnRbv4bp5qoez82zQeTn3lrOIu0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604954; c=relaxed/simple;
	bh=mdMs/b0H8ZKYdk7N+cLM+Uj/aE/vejpLNMBlaSFUExo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKOXYYX4mMq3VmmC6TNttCXzp66Fe+ktBgiekGvWVGJDoivJVqn+7OmEYU/mNYmJ9k/b2Q31ks8KZGlVuEMWkLfpBLtetE7oaFSGIDYD5i95SrNRYsZlUHi4vK8514rvY2EbQJ6mYtWwpmvOfeNdtYAbMJ3UuYxJr2aDnfBHUwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KZZdxYt0; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78356c816fdso54575157b3.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 15:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761604951; x=1762209751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEbWuq+sA3qayyKc6Q0Zwp+mZTGvAg5r2iKjERsSY7s=;
        b=KZZdxYt0Z2WZKZuPgT5rRan52bxSrRh4T492YeoJIxeDY4LeXNDR+R3yOnRnZyzVb8
         KBlWPmFy+95MRsIPWWq05i/z4Vn8LC7vRp0/hibWv4bpyEPuRJpN8p04JKGNALA59BXB
         r3b3PPsDTPdzYTJGjWqbufP1y7+F4e3Z/hYN3mc3SqLZRCp6/byeKiquedgj54rR/WoW
         zQl9+qIucwctk7wZ2brLUUZ0eQi/1r9U9SISaTDla8dXL6QC8+0YkkCn12F12/lVVHm5
         EdDcsB2o5zlBZs5CEApaknmyKahuQv4I3nfHGGpBcs/xheH7rog0kOa5jFGtyALH4ZMW
         qI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761604951; x=1762209751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEbWuq+sA3qayyKc6Q0Zwp+mZTGvAg5r2iKjERsSY7s=;
        b=aZaLeSBi80fgF809eETo3DfSXJK282it+toEhTlxSNk7q/U4RN7dM+B50OoJAAb/Qm
         T3dWANhlBNrHoy/2E3T0yFWCZhNnCy0cgZQOiNlQkvEMtsWCjQBLQE1USGzO/jBvSKL/
         QB/XhA4hMxtbD6Cgi00Woys4g6oq6xb4srQg7I3uvyj1G1MxpzQrWqPZSYFZmRTAj59Z
         LEvXI55JF31m3nAZy2u2Y+EY0LBzagp4m4tiEH4vxxSUoXu/yR0uL5JUvy6HUpM0q8Av
         9v9ROV961SonljWYc7K1GNpVPTS8jnwCvrE1ZKKAk7SDLJzsypeKn7MYSY+IsfyBXyqL
         3p4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXA5yHcfg6z6z9Wm433xi3JVidr+NBOUVsDq7xun7xA7Yhgi0N62eEHnM9XGZDyii697KIfWqmNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4LEgvROPcWaxrsqp7v3f6l24cSU2eu8EHPGyQ7YI+u9p/1mjD
	aJAnGhHWYP8RE507QHMYvbuDgV0KREm85H3FFjqg09jWFIeIz2GcEYpTSsAVJrkejwoPb6O39rw
	lhtYKbDFSvRlNp5KlKkel7bdoLhnkqMONpyzaBRXbdg==
X-Gm-Gg: ASbGncvB3N13/UpwqQhGOEYkSBZCaLf5bE55uhVgU1OoBWJy+KSjWq1YhnQjCIJ6fbW
	siulbBnE7gnCEi0vH11LRcva/vtOTSgofKtCBGOonilJLQqyFDwtCQC4otuthQl6pQtDoRGh6vZ
	SF24XTOgDkA0xxGvgjWkAk8BKdNFU2RFYBKelTWpoFiP4ovbTD+wFhKhfPnTBN0FlD4XTUESAHd
	29X6lU626txKHZDlwn8A0SNc3q9L+4wbWsPIqlH5FZmRG3ulj7e+mWiRKjQ
X-Google-Smtp-Source: AGHT+IFea0a7SdSezzmFvdSfx4jiKtpkMteXYqF7MqSlxI3OsRPCoABiY/0t3pyhk2zywEU29O2vl188K3Ur1ROhIiE=
X-Received: by 2002:a05:690c:3684:b0:783:697a:5daa with SMTP id
 00721157ae682-78617ed7dc7mr16221547b3.30.1761604951123; Mon, 27 Oct 2025
 15:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761564043.git.mazziesaccount@gmail.com> <a5957c4f83724d4f32527fb892fc340af4eeddde.1761564043.git.mazziesaccount@gmail.com>
In-Reply-To: <a5957c4f83724d4f32527fb892fc340af4eeddde.1761564043.git.mazziesaccount@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 23:42:18 +0100
X-Gm-Features: AWmQ_bnqjdOEx6PHBZRMUEpMuG3EOvSnhd1cnxA8WMLK3e2WMcsLHGdno_I3fzM
Message-ID: <CACRpkdYEUdJRvNPKhxx7orYHH3OE6BXXjrG9JVJo5MDHGKE88A@mail.gmail.com>
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

Hi Matti,

thanks for your patch!

On Mon, Oct 27, 2025 at 12:45=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> +  rohm,clkout-open-drain:
> +    description: clk32kout mode. Set to 1 for "open-drain" or 0 for "cmo=
s".
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 1

I think CMOS is the same as "push-pull" ( I could be wrong, but I think I'v=
e
seen that before) so I would probably try to use the pin config standard
names as strings here but I'm not sure.

rohm,clkout-bias-open-drain;
rohm,clkout-bias-push-pull;

Mutually exclusive.

Or maybe use the pattern from rohm,pin-dvs0
with string enumerators?

rohm,clkout-bias =3D "open-drain";
rohm,clkout-bias =3D "push-pull";

?

> +examples:

Maybe add some of the exotic string options into the example so
people will get it right?

Yours,
Linus Walleij

