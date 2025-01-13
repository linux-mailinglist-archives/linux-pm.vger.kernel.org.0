Return-Path: <linux-pm+bounces-20290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27564A0AF91
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 08:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3061C163E5E
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 07:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9B8231A26;
	Mon, 13 Jan 2025 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OA8AXTXd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C218CBFE;
	Mon, 13 Jan 2025 07:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736751747; cv=none; b=j9oC8qNXMzLdpO33sqt0DQsFFknAmzM3tCKnG+DOvYWQ+gtMKvhGWqIhqWtd0ytIE6qaM1Uj8FPuIJti/1rgfG6DaoJxgZ9NwAF2updQeDmqmOx4Qu9erEClnH3tI6LevDPe4hSnDSIfBrKMiFWSzkrKa9XGR4W4hSrTigZLZtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736751747; c=relaxed/simple;
	bh=1e2l0XBBDnEwZNKCub8vHrKY4QTagSun6GLAncKYEM4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HXynyM1g+lyBh7FA5PRJZ9FDFi+5KevDkIj7oWs+LAIAzKzwx8ywEuTQ6UQwDZnMwkTFsVrRk8xKUtKFWRKLBisCbfocdCAhutUMX5hFeglS1rJeR+XDTpcWx7brTvg1C7l/+pThv20Vnl2MU1ROdrsU2DTqxpEI0h05I5GzBcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OA8AXTXd; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso6456941a12.0;
        Sun, 12 Jan 2025 23:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736751744; x=1737356544; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mp3/qUQXLESraR4kRpn8DKp75/AqUs49Ij3IlmcsjIg=;
        b=OA8AXTXdk7BAwO+RXvltFyKsu36Mj5CxHWEqm90gOXCdcZwFqIiiPL+6Pp3nIUrfvs
         Bc1u3pLfHDv0wUmZ5O6pW7gHuoa63tWJVrD5yRZOlYEZr13vT5tke2jv/GWU41mmtPQH
         lT8GxWCUrVc7CJ0RGqqpSBos9q7CkjHyIbNZ/LCoR3pZOIRPJri8F9wpyiG+kSpIJJTL
         aVbCKw8x8Vot77Lv5RESjnyKfgYxJZCOHf/DVR7bFsquw1yb41MWFn+OxkqhuLPzdIvi
         rVvNhwzu1PHHxalbqua4Ylq5haedgESxST66cqcSqldxerv+jzS9NZt35knDFtHmY6QR
         5zLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736751744; x=1737356544;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mp3/qUQXLESraR4kRpn8DKp75/AqUs49Ij3IlmcsjIg=;
        b=UeoJQoT01AQe+J0DU84NZ4fDS2xE5eaI1swqe3SRqYeJ2zsusoH764HR4Mlqy7DDyH
         ni3c0eBra0vXohN6RRX1rHxACoKQXlvfzp+34Hb9N2OERWENP7PpRvu+61jrtlIeFs1X
         WsZjP+wIPftAHFcNuxQVR784y4S9460L+hgGD1XpyiS/2XKTVfHgt/UQ+U4I9P9Y/L/1
         I0DpLystcBTjpEDBmmvoPAAA7StsJDRBW6T4Jq2B27nj3HHJGB+GK/391zTMGC0VirAb
         4yeHn1sm8hTwN0raGqjLoPMvk1hkmL2zzK4cevDzSYkop98CJm4uV/QIOC2vZ8Xje9zZ
         mYWw==
X-Forwarded-Encrypted: i=1; AJvYcCUtZipD+ctsu9uogaQT/KlLzwyx/XGHDXGDgwYsSd1N6nOzwB0mHXzdHNq9FUUkp7NURl+vKGwx0dBN@vger.kernel.org, AJvYcCW2w//5btNvB6MCEc2HR/iYDoGzLJD39mxJ/WxjvWc7YcJsM65/NAUQElj2r6p21H0O5IXbHsf1JgAN@vger.kernel.org, AJvYcCWLW/TiJBXitYBO0J+arwACgM0DjRnAGb/lxEGTEO35lq+mqQXvCO2vHMv5haxZ0EZCn/0jdSwsg+2iPA==@vger.kernel.org, AJvYcCWP6EaLSH3v29xg8eeICWrujzdQFll42cZSwli/LwZWMEmVZUgT+e6VCZfrgim8lWRkp1qF48JCTvo=@vger.kernel.org, AJvYcCXaVuycnCgCuy8S+aAkXYVl7W70FHooHY8Wtb7qMrauG7aqBNs+VNOeJV3zbG22zo96MCuKCIJQPv6E0D5g@vger.kernel.org
X-Gm-Message-State: AOJu0YwII+4pULLNPFQ6QS1nOUSHGPm3TneLlA5a/+tnv8uwX63MPc4o
	5MykQ86Pf3dVQsVGF4uQPJYK1kmvINkecUEEGMIsgBbR0BszOhOiTFnNmcwV
X-Gm-Gg: ASbGncvDuzqocV0wL85xt7MqVYzIjJ32Dr6MODBX+LPGRqHe0ZJOteiB/LjxWHpbP27
	FPYwSd5cULNTzRbRDgNBug4UWKMBLC/vmJrhepijVJgdvzdf0JMnocQN4I0Rne3ttPMecYh3hLr
	ESpE/kY+HaXHC8qJLi0KKoNa7dYOplwF9Tb9+dISRs8FvHl6uk1YrDN8pPxw/5wKor5OyCTu6er
	kj0zhTNJ0zbTYkL6a7YYOhtSsRFpUwPs/TfNcVa3lGbe+DRvxFDLU3LOB+7J2saqPwEl/T3B7rZ
	Gq4keSI0V0iMdWmrV+QF1KS5
X-Google-Smtp-Source: AGHT+IEdbQkU8UjVmzUUdbYKBPe34Hd3H6alrK+lAeP3uFioAdztQzne4JSDv6lfgqNHpEvaeL0MQQ==
X-Received: by 2002:a17:907:94c2:b0:aa6:824c:4ae5 with SMTP id a640c23a62f3a-ab2abc9f6e0mr1698225066b.56.1736751743583;
        Sun, 12 Jan 2025 23:02:23 -0800 (PST)
Received: from smtpclient.apple (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9060bccsm455865966b.22.2025.01.12.23.02.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jan 2025 23:02:23 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH 06/12] dt-bindings: clk: sunxi-ng: add V853 CCU
 clock/reset
From: =?utf-8?B?QW5kcsOhcyBTemVtesWR?= <szemzo.andras@gmail.com>
In-Reply-To: <tttj7va4hzpqugah4rhm2u5kganuix5iy7373h62b3rgfwvdbt@53vexrsfmskk>
Date: Mon, 13 Jan 2025 08:02:11 +0100
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maxime Ripard <mripard@kernel.org>,
 Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org,
 linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7DD6AE5-833C-41AC-8B7F-2772BEB065EF@gmail.com>
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
 <20250110123923.270626-7-szemzo.andras@gmail.com>
 <tttj7va4hzpqugah4rhm2u5kganuix5iy7373h62b3rgfwvdbt@53vexrsfmskk>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)

Thanks for your comments for the whole series!
Not everything is clear for me yet, but I=E2=80=99ll clarify with sunxi =
community, and
fix it based on your suggestions.

> On 11 Jan 2025, at 11:34, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>=20
> On Fri, Jan 10, 2025 at 01:39:17PM +0100, Andras Szemzo wrote:
>> As the device tree needs the clock/reset indices, add them to DT =
binding
>> headers.
>>=20
>> Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
>> ---
>> include/dt-bindings/clock/sun8i-v853-ccu.h   | 132 =
+++++++++++++++++++
>=20
> Please use full compatible as filename.
>=20
>> include/dt-bindings/clock/sun8i-v853-r-ccu.h |  16 +++
>> include/dt-bindings/reset/sun8i-v853-ccu.h   |  62 +++++++++
>> include/dt-bindings/reset/sun8i-v853-r-ccu.h |  14 ++
>> 4 files changed, 224 insertions(+)
>> create mode 100644 include/dt-bindings/clock/sun8i-v853-ccu.h
>> create mode 100644 include/dt-bindings/clock/sun8i-v853-r-ccu.h
>> create mode 100644 include/dt-bindings/reset/sun8i-v853-ccu.h
>> create mode 100644 include/dt-bindings/reset/sun8i-v853-r-ccu.h
>>=20
>> diff --git a/include/dt-bindings/clock/sun8i-v853-ccu.h =
b/include/dt-bindings/clock/sun8i-v853-ccu.h
>> new file mode 100644
>> index 000000000000..a405b982f914
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/sun8i-v853-ccu.h
>> @@ -0,0 +1,132 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>=20
> BTW, also checkpatch warns about this...
>=20
> Best regards,
> Krzysztof
>=20


