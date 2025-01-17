Return-Path: <linux-pm+bounces-20598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1ABA14A1B
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 08:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C4916632E
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 07:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09611F7908;
	Fri, 17 Jan 2025 07:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp6RfAG0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E1C1F78FD;
	Fri, 17 Jan 2025 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737098824; cv=none; b=D+RIIi/n84aFsPWEiLzCCQBWFu7Yr5XMiOI66wBNUAkEFg56BsudwkIsbLJhjP+MB6xA9Xjmw8J3sFUwRLcAmsS4SXChrWBs+ej8cqPoCCEOJ4GUR4f88Xyu7onxjKskhOcH8yf7aH1baCKjf4KH7fp3Lwb1+WTK6FuDisDfJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737098824; c=relaxed/simple;
	bh=8ZoHB3c7Wja3OoOz4RgpQxXimVh8mCkNOGXye7svh3s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kNjo0rSgJEKFr5EuUR4dgPPxq8RbYjZDvkKrGbBhytuVxHUyxqtx9mFybuQrFVlxCuTpnDvBCsaembIIE9DJMXlxH1USCoJ0EH1EYCOr415JgkLY3+3YO+j9G1+ucjcY2/SWzSLzRWu62G9YipDAQDEGUdURMGK6SJktGKobRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hp6RfAG0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso2669994a12.3;
        Thu, 16 Jan 2025 23:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737098820; x=1737703620; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F24Ywam/p+ofkibybtKEAiJQBVKXbmYXTkvfrfJmGwk=;
        b=hp6RfAG0/y9XnzfTkyQtULRRVpkaXRCARYDnOM7u8M5ObDVEz9KWUTSw0ssvcBwZ3q
         aqQjzKfalnJde5VSaA3md5J5Lzods8XdvUcH31GPygt8KRMXTYs8cc7iH3oLrvHnWpDa
         0vt2Nwp8xx6c2jtm7tgm/hRkguzDzNWA42g53LNEwdvgF+cCNNs3RiOpKYn+cgLxHNCz
         jVkX2MZiPmuQX32N8PZQ3X+y21UpSgdTcvRxchMZZSd9VaX2uiAl4okp0m6EVMWRwHc+
         8Upj8SyyVRjfJhsvjhktty/400Z9GJNwDW04H9Zo0Oo+nJyBhdV07fne3nLeYf8cZoGM
         q4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737098820; x=1737703620;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F24Ywam/p+ofkibybtKEAiJQBVKXbmYXTkvfrfJmGwk=;
        b=oheogE3wI9m/3ZJpQ9OlhD8Bdq2KwSP77tizIxKsckxSF3ICZfSNmjT2wAgFvcGSk1
         lo30wzeEaJqcfFPyuBW4dvVtb9wm0kW9a3LNyYjGCN/RzEOLCCYXnbHyr6PxaReuaZoJ
         nomJvT3D77ijzL1ObMFdKhD53Z0QbURa6PVxekvOwogp07Nr8+XZczZyAFUVe1m2quhu
         GkdfC4RzncloN2xZYEgbsO80qhdgERmIFHtQqHdNwegIKw+1ECief83Nvzp7sGC7jqCN
         sdBNIiGrDg2H7NXjiyTMbP9Q+19dhOaYqW5rUjDceTnol4PEmIwH5bXTfwB4WtC0QO3g
         6y3g==
X-Forwarded-Encrypted: i=1; AJvYcCUReP1EKKOpXB+BXv8TWxnURibxeSdJ/odSSVBy/DdmyUPXcSgslYxXhvMLHL3jGYy91JyL0GuHNVbSDbpZ@vger.kernel.org, AJvYcCUWUaNoxL08Kp+PjK7uZQxkjgUaeNF72YbL3dF+ekT4bfhjNVFWgEnEresAtlVCOdhhMLhNQjFx+p3EaQ==@vger.kernel.org, AJvYcCUaCZ2pMf/NHKVFnx+9TiLCghwy1Ty/Nza64S9Z3mABLK8OYuzUmEYVZDU35wVA1qlZrjDs5V6wIxlL@vger.kernel.org, AJvYcCUlKPDTt5Xsm8mNM0Sr5jMhDpHVWaXiwXiwdF+2drw5aEMBENR5+qbtn0MZtPaFaffZZ0SBi31YIxI7@vger.kernel.org, AJvYcCXOvU8MbflDTks5r6mRA0yRbH/+7+MNWabGGEeRJGUwxhaVaDWVpA597SLw6JFnn5qEejLW3QZeEEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz81y5PX99gbzs1WZdAntbqwXb3I+ZrtAvtEhhXt5+zFPxCj0yQ
	v6yYNK2l4gdsF5zdC0X4Da+N2uBqHVdTkK7A9UATiXh7kcI31tgW
X-Gm-Gg: ASbGnctPHAqtR3fWaC+FKYWyIfXKtTqXaBTzwZ9sWaHZChWr9klZw4c9gz9NtWaQr4A
	IFmvKVN+XvMrl0Bq0QFy8kwCGc06kayg8w4DEXlbBEetnFaAxzzLn6CbvqgVuho+rKWZ8C1z3JX
	8cx7JXKgUM2quF8fzU1nU3HuvC8Zcgtao2SIriGNVpYs5pLsIOwW4QnwZ0QkdLn0gHCLBbZGP6I
	xm8reJNs2NaLqUicqT0vrY2HMDjIOtQheTyHKdHVQfXaz99IXEbW+JwS8TpgV/8urIuYPv0buPZ
	9rl8vAf//ykFlffQZGM=
X-Google-Smtp-Source: AGHT+IEJ47ULSJP3koS5kB9oV3dzXmmnz2xu5B2PxtVsCDw5X7zWmfzS9Fwll8RLJEa/W2eN3Ozjlw==
X-Received: by 2002:a05:6402:26c2:b0:5d2:7199:ae5 with SMTP id 4fb4d7f45d1cf-5db7d2e3014mr1246401a12.5.1737098819744;
        Thu, 16 Jan 2025 23:26:59 -0800 (PST)
Received: from smtpclient.apple (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73edccd4sm1072439a12.77.2025.01.16.23.26.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jan 2025 23:26:59 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH 10/12] dt-bindings: phy: allwinner: add v853 usb phy
From: =?utf-8?B?QW5kcsOhcyBTemVtesWR?= <szemzo.andras@gmail.com>
In-Reply-To: <Z4dpFqffMJ31ml2y@vaman>
Date: Fri, 17 Jan 2025 08:26:46 +0100
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
Message-Id: <2D99DF28-4CC0-443D-8E5F-A2AC12EE47B7@gmail.com>
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
 <20250110123923.270626-11-szemzo.andras@gmail.com> <Z4dpFqffMJ31ml2y@vaman>
To: Vinod Koul <vkoul@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)



> On 15 Jan 2025, at 08:51, Vinod Koul <vkoul@kernel.org> wrote:
>=20
> On 10-01-25, 13:39, Andras Szemzo wrote:
>> Document Allwinner v853 USB phy.
>>=20
>> Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
>> ---
>> .../phy/allwinner,sun8i-v853-usb-phy.yaml     | 89 =
+++++++++++++++++++
>> 1 file changed, 89 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml
>>=20
>> diff --git =
a/Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml =
b/Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml
>> new file mode 100644
>> index 000000000000..773c3f476db8
>> --- /dev/null
>> +++ =
b/Documentation/devicetree/bindings/phy/allwinner,sun8i-v853-usb-phy.yaml
>> @@ -0,0 +1,89 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: =
http://devicetree.org/schemas/phy/allwinner,sun8i-v853-usb-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Allwinner V853 USB PHY
>> +
>> +maintainers:
>> +  - Chen-Yu Tsai <wens@csie.org>
>> +  - Maxime Ripard <mripard@kernel.org>
>> +
>> +properties:
>> +  "#phy-cells":
>> +    const: 1
>> +
>> +  compatible:
>> +    const:
>> +	- allwinner,sun8i-v853-usb-phy
>=20
> Does this really need a new binding document, if so why... Cant this =
be
> added to one of the existing docs which driver uses?
>=20

Yes, that was my first intention too, but didn=E2=80=99t know how to do =
it propery, but I=E2=80=99ll remove it
and add to one of the existing doc.

> --=20
> ~Vinod


