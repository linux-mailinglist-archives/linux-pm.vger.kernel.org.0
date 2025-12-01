Return-Path: <linux-pm+bounces-38968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 095DCC97912
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 14:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6DC13423C3
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 13:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9781331328E;
	Mon,  1 Dec 2025 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtZEf828"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAAE313289
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595327; cv=none; b=X5Cao7RcXZ6KPAcJT9LWdS+9NE2Mt5GzVluVcnZ+URn71kWllRtOhJS025iiWwOIl51BFIQIrjqhyyvCnBw+xz+DzFWe2/KOhz7JG1PhRUWYjFQaAoHCEBIpAYUzucwdRErRgPCXMQ42wX7BdWfeE0f/o/VoMSaxCLzT6mJ1pJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595327; c=relaxed/simple;
	bh=8h9yCHGAj/WZKkvWlesMNxBy5OVWMI/wgD5mesbnUqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oB6B+yzafN55iBbWs8vE3DDXadVU8SWKq7zvlm3tC8DEhVaZBendtfTVZSbqYkSW8xoXgXJv6/ogSbxOEpKq5UHFnmqXLUxArXpChtsUEit53AEMMS6qw/fgmKX03el1gxCpIIyVlF1MFESPHbm48Y2Nf/Y9RO9SJxfAfyMvc/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtZEf828; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E34C2BC9E
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 13:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764595326;
	bh=8h9yCHGAj/WZKkvWlesMNxBy5OVWMI/wgD5mesbnUqc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QtZEf828yWVchOf84NtWlCA6QLTXOU4MA6S3mmnrJR0y1A3pG1M6trrSX4j3BthRz
	 GZtS8SkkyPd9CYA7Uize1ZW0T3R2lU1wR4rpCh8OMzEeAQu1UDpMVYgHdL8Lxh++h5
	 TJWLLhyeNo4bjedeafD3XFhQvzIapx3nouUe/9cj1TWpKDkgypJ+4RSFa9Uu3TeVPt
	 ynYgMKgrEsm/K9JjnFiXAbq9CucJHQLTwqteRhlbzQvv4SMq+mQllQczJhZHmDR1K3
	 6+jU9IlcPHs+3uNBG0rufHGXOHcK7zbN0llgsWNkhWg9nvCPDfxaAtPMCOT0kDLlrG
	 1RCbVHiozjtVg==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78aa642f306so37244717b3.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 05:22:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWt9xczMFYUMW8iuYILQzKXLcAZAHfDyLaGnoxRggbhOsJsfcDvtyJ+mIKm5Sy/Z50ChLXnERRfhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGVvNoNbjosoQ+XVYVAQytLWoK3/gwX6Wv5RECWyAMtHnsFe31
	4iL3HcPpU53mWJ1Z/qhppUC7smjxLld61gfpfUak5hppp7S8Uh4xD9sxWY0Fw9LWAumI1U3qfL7
	ZW3U7lzxs0ZytKmCWrNJX6lKflatPFHs=
X-Google-Smtp-Source: AGHT+IHLOH6LrIYHGrddhM5Q4CyWt4mjaZmkxDOJux9LJ/n1RXYLsEzRooHrxHrIrxvaKH6FwntB0APJ8RGC7VVQJYg=
X-Received: by 2002:a05:690c:6a83:b0:787:f545:c353 with SMTP id
 00721157ae682-78ab6dd731fmr230733317b3.16.1764595326030; Mon, 01 Dec 2025
 05:22:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1764241265.git.mazziesaccount@gmail.com> <3f1e43285f58630eb0164857533ccfea9ea628ab.1764241265.git.mazziesaccount@gmail.com>
In-Reply-To: <3f1e43285f58630eb0164857533ccfea9ea628ab.1764241265.git.mazziesaccount@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 1 Dec 2025 14:21:54 +0100
X-Gmail-Original-Message-ID: <CAD++jL=2BdOuJ5+B0QEg8zuX+UGO=sRTrL7oOb0BkqBtfCGZgQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmrb-tgsojhuxdtfBeOytyQdHZYIlasYeSxeuTT8yXfw0hX_xhbCuFx-Dg
Message-ID: <CAD++jL=2BdOuJ5+B0QEg8zuX+UGO=sRTrL7oOb0BkqBtfCGZgQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/17] dt-bindings: battery: Voltage drop properties
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org, 
	Andreas Kemnade <andreas@kemnade.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 12:18=E2=80=AFPM Matti Vaittinen
<matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
>
> ROHM has developed a so called "zero-correction" -algorithm to improve
> the fuel-gauging accuracy close to the point where battery is depleted.
> This relies on battery specific "VDR" (voltage drop rate) tables, which
> are measured from the battery, and which describe the voltage drop rate.
> More thorough explanation about the "zero correction" and "VDR"
> parameters is here:
> https://lore.kernel.org/all/676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohme=
urope.com/
>
> Document the VDR zero-correction specific battery properties used by the
> BD71815, BD71828, BD72720 and some other ROHM chargers. (Note, charger
> drivers aren't upstream yet).
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

I like this even more!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

