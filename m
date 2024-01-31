Return-Path: <linux-pm+bounces-3064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AD3843FB0
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 13:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BB928F136
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 12:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8157BAE6;
	Wed, 31 Jan 2024 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y1MJ9Uz1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561897B3FD
	for <linux-pm@vger.kernel.org>; Wed, 31 Jan 2024 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705450; cv=none; b=K27xWexggCKCp3MLJAISl6pdT+TPO0ohPHeq6Y52zTjOt8RmqDNMvoonrD20QSwZyKR6V23Su0IrTkwn9mWsU9YvlpQZ1CSUJBTD2Relpb37GxPSKVI+8H1VfI8LqBqyCm7am3xGIXiRwHATo1mPfRTdc7xGQb9INYg8QDIknJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705450; c=relaxed/simple;
	bh=yebtIyQCYDZ5e+sLn4mg7pl47yIXsLOdVhcRWu+i57I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJE1FXQcJKKeaZeePJ3d6UCceusbXplU4pWIhB0qtRiganbdZK3rpJsmAiHRCgG0F3dH5l4Ic4kQW6XBJjTw1DqOAuQgnivQ+3T4A7qKGWEIWt5VJSFgdNIlDH6AmhKNhWIn6XfOrbhpjixK44ZEArTKvrK/8pZxZ+vrIq0p+OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y1MJ9Uz1; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-602d222c078so52603097b3.0
        for <linux-pm@vger.kernel.org>; Wed, 31 Jan 2024 04:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706705447; x=1707310247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yebtIyQCYDZ5e+sLn4mg7pl47yIXsLOdVhcRWu+i57I=;
        b=y1MJ9Uz1MsjC/W9kArtu7ja9OR5QPxqKHE5mvsWZCNX2eNrUSRJ/QWYP0HtOWuomam
         0X1gpJs+UpgGW46IFSYi8VWrk4GhdnV0WHf08SyRfkZQCrVXrBwrgAThk6rSvrdKDqhZ
         pbhB6R38O0s3h1X9380CWdJsAIy7NqAYBwy9z8keTVSjq9erwFvToO6CoSgoUZ2+giXN
         BQ9fXxJ6Ux1KVBxa8lVAKKgxERvqevyi8TsA5GPRfmi9Cy5V2pPnq0xfhjFwt7nlI6BV
         7xj7JSfEi/g3rB/+u9M60b5C1RvMuOaYfU7Gk35DU+btf3U/k1wqpD9nPpUIxs8kyp9k
         z+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705447; x=1707310247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yebtIyQCYDZ5e+sLn4mg7pl47yIXsLOdVhcRWu+i57I=;
        b=PirqhNgHByKGPqJB+iTFoBpQ6J1D1wcVC9cvFOxIf7Y9l2TCyDazFWZ0P3quw0vMEs
         gSqKX/3ZV7ZD2IKjRy+D8GtFQEWx5OQ3/hiZ0UQvcT6A2rg5veCdEs/ENseRH19uay+X
         gVhNPguh+l9JJvtarXQe0meJP0O2STyill2poi//L+ZG8EPDj2vygz9z08jheB0UkJTv
         La/2LxKUx76piQdy2JjtB9LERQNML0xVI+NRgDlBnYS2v8rpiENsmBjXfKVmtSyvVcNw
         4pQCvGeUSQInxQMbsOoCwWjTlgyODB/L7wcZoIIyXUinRSxFPDeMKL0AKAUmUBKHS2HZ
         aL5A==
X-Gm-Message-State: AOJu0YxPwtE+OKQNba+PTVB96DnUPbjPZRw2aqHAa7pE0RRUriIRBU2x
	eL72xqNYPr3JnlTbXCXSrSJvq0Z3ki5q3MKIEMoU081ZbJtes7LASVP54i68MGITGnANRiXaA4T
	sLU2OgepJaUUgkJb/Mw9KuCzqdPVa916WRZX1Vg==
X-Google-Smtp-Source: AGHT+IFRSU9w1zRrdHbJcJCYqCSrYAoOV1MiQgaqBk9Y+Gvph7b4F0E+eyUKljpNB45qUnX3uDUarVJh+rLHzPjrEnc=
X-Received: by 2002:a25:6943:0:b0:dbd:7491:368f with SMTP id
 e64-20020a256943000000b00dbd7491368fmr1373182ybc.7.1706705447230; Wed, 31 Jan
 2024 04:50:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
 <20240129115216.96479-5-krzysztof.kozlowski@linaro.org> <CACRpkdYf4HUaV-Pjr81WjLbzy9zdAnyFWs9gPayPC6-3OjHQwA@mail.gmail.com>
 <6473952d-893d-4591-9bfd-dd983313bee9@linaro.org>
In-Reply-To: <6473952d-893d-4591-9bfd-dd983313bee9@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 13:50:35 +0100
Message-ID: <CACRpkdZ6GH94EdBsoB61FbEW5dV1+dRCV9O7TUFCMBBdVJBPuQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] reset: Instantiate reset GPIO controller for
 shared reset-gpios
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Sean Anderson <sean.anderson@seco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:50=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Nothing is odd - I use get_maintainers.pl which just don't print your
> names. I can add your addresses manually, no problem, but don't blame
> the contributor that get_maintainers.pl has a missing content-regex. If
> you want to be Cced on usage of GPIOs, you need to be sure that
> MAINTAINERS file has appropriate pattern.

I think that is over-reliance on tooling, I think if I author a patch
creating a struct gpio_chip it's natural to CC the GPIO maintainers,
just by intuition. Maybe that's just me.

I guess if one wants to automate maybe get_maintainers should
CC GPIO maintainers on patches that has a + #include <linux/gpio/driver.h>
in the patch body but it seems like stretching it to me, it's just too
much process.

> > reset -> virtual "gpio" -> many physical gpios[0..n]
>
> It does not, there is no single GPIO here. There is a single reset
> controller, though, but still multiple GPIOs in DTS.

Aha so this is problem similar to what regulators are doing,
where they had this problem that a single GPIO can contain a
regulator used by many devices?

There the solution is something along the line that the first
consumer turns on the light when it arrives and the last consumer
turns it off when it leaves, at least that is the idea.

That solution isn't the pretties either :/

But if we find a solution for the reset controller, it appears to
me that the pattern should be re-usable for regulators too?

I think Bartosz says in another reply that *_NONEXCLUSIVE that
the regulators are using is broken so if we are to invent something
new we should make it available for everyone.

> > This supports a 1-to-1 map: one GPIO in, one GPIO out, same offset.
> > So if that is extended to support 1-to-many, this problem is solved.
>
> It does not match the hardware thus I don't know how to implement it in
> DTS while keeping the requirement that we are describing hardware, not
> OS abstractions.

OK fair enough I got it wrong.

(the rest of comments are probably fallouts from the misunderstanding).

> So none of these ideas were posted in previous threads, just because you
> were not CCed (except one thread)?
>
> https://lore.kernel.org/lkml/20191030120440.3699-1-peter.ujfalusi@ti.com/
> https://lore.kernel.org/all/9eebec9b-e6fd-4a22-89ea-b434f446e061@linaro.o=
rg/
> https://lore.kernel.org/all/20231018100055.140847-1-krzysztof.kozlowski@l=
inaro.org/
> https://social.treehouse.systems/@marcan/111268780311634160
>
> Please implement some custom lei filter, so you will get such
> notifications earlier. We keep discussing this for many months on
> various attempts and this specific attempt already reached v6.

Yeah I should really look at lei!

I just haven't had time to get into it, because it appears it appeals
most to people who use local clients like mutt. And I use gmail
(yeah ...) I guess I would have to change my whole workflow to
accomodate for lei, but it may very well be the right thing to do, I
did change everything for b4 already.

Yours,
Linus Walleij

