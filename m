Return-Path: <linux-pm+bounces-37167-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1B0C23F7D
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 10:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A20A564904
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 08:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5DC31A049;
	Fri, 31 Oct 2025 08:58:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813CB3128BC
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901087; cv=none; b=IkFOhnDT+2tVM8D52L0RhHOX7dH9FAMpSlf6z75iD1eiYU0RevwwNzD08/4sAjqNcrZHYsibDgk0Lx6AHHDg94JGV2+hh+eMLR+7LMlKT3448a7ILPxupkSX/zzDGzch9zdSj3Q7lVzUKPTpI1GktTcBsz/Rb9J/b07xWxrPiU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901087; c=relaxed/simple;
	bh=NYbl8HJcgb3R5SVJ9GXGI/Jq2+mOIag8w0HzHBPHPoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kleahjPSBy4CvMImJotsER+Cj/EsxawiL5a06YBPGMsPDYdZ0DebX4d0T5NO8WH4T3Wva47dBB1WHQmjkxmsBnbzGmJ5rstWfj7sKQCUMfaR3tlBCMDQQPKjUSSR2uPk+yBTepFSGZ5ypLDQhfpl/I6u/Mfnqnlf6/eYeIgWgHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-89ec7919c71so220660085a.1
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 01:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901083; x=1762505883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQVVX5c2GB+a2QgL3UYe6DKU+bmVaydohzEFkpxq/1c=;
        b=BzZgIikQBqAZ8yg/bGvfTDx2XTT/W/Vw0hs7DrnvgR4/PLpayNv3sIBFycVlYHzG7m
         noSnn0URQSknIgewcHtO3WUyh0iN6vUzzoOqfru0htUnkVHBHUDtozcaRnWb34QEnU99
         Eag/DPmFer5M8ow/76Sh7UiQH0CSH9ihG2lISlrlrnqwnO3c6MY6lgvp9+zN5I0vqqGs
         +yjpBVP7VnaxFNB13D7eAXR46R0Vt2dA+/QwhHfSlKC0f+VMKfLwOcj7aIjdSeMBab8Y
         QdZV6hC2jNgr6gXPf7OipX9OKhD50oOEMpBVu8Qh6S9xPlqhMEXOeTcghdntgmSA5+/x
         9tnA==
X-Forwarded-Encrypted: i=1; AJvYcCVitr6Rc7aybQJVl/vh46jBApK1gFEkJWRBjZKgPh+dHYwoj3G9NES/b5bzWtQ54gZJqSycwVNpvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0yH3Z8wnQO78B2Y0MCBCLefqQ114BbQFM3db7hjgCs3wWYflp
	SQWHkr3QWZU4VZz9Qk0k0kDwjj0FK+r1J5BYgPmg4HYvInRuYcn1mDbHIeRiPxPa
X-Gm-Gg: ASbGnctsiL0eGX07pwkxF6PnS8oY6hpnsi/8fKefNuzUQ7gSQNswhKqhO622HhiE2i/
	ti4g/Q6agRqtvE1pr5GU1aEqTW1cGV6VWEK01e9HhPy3efAYTRPLVvFc68waUUlqbYZbYkS/Cqo
	D+1QWARVgX6Dg7aUY/bqj+UFTs3Rp85c54B5wZO+zgKmLUX1PtVuGKtiYHudr88I8fx7VO1iO5g
	CYKHJr12EUOC/Ps0JqN4jQYCVjqyv9m8286VyGoJy5oOx0gyxc6pEhtRMzRYCTCsJoN4jV9WPCQ
	aA5N6L7nO5fOgE+in/bxw/fClVKOYsGGyuHyNaPFYkjAm7g2J9onro7SKbzKqrqi5g+/wWvYlTf
	5HbcaKwytgf5MyCCopoGYRnRE4W3ep/SueyZPvEMyVV2GTPB68A7PluSOvVTA9fzQm/xKC1Velj
	pmALfKFA5N+odlCCwhkPsIt0cVDn1RZ7k9DZxdD7AeZg==
X-Google-Smtp-Source: AGHT+IGy4DyALOB5JSApMPkKpUGXMbuxgL9Ihco8TCYJYghFrN8yz7vkARu+tZi2w1LjvBOeH0CANQ==
X-Received: by 2002:a05:620a:31a5:b0:863:42ea:d69d with SMTP id af79cd13be357-8ab9b59ad37mr271643285a.63.1761901083110;
        Fri, 31 Oct 2025 01:58:03 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ac005b1521sm75754785a.2.2025.10.31.01.58.02
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 01:58:02 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8a84ba42abbso225155985a.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 01:58:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTi8nu+m01dCa6fi4FI3vNMJzxGJUIazn2Bxyxcd68kIYFqYA7U2XnR7xlBhA/7JqTQbvc1JRMKg==@vger.kernel.org
X-Received: by 2002:a05:6102:c13:b0:5d5:f6ae:38c6 with SMTP id
 ada2fe7eead31-5dbb136ecc7mr717064137.37.1761900747573; Fri, 31 Oct 2025
 01:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015071420.1173068-1-herve.codina@bootlin.com> <20251015071420.1173068-6-herve.codina@bootlin.com>
In-Reply-To: <20251015071420.1173068-6-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 31 Oct 2025 09:52:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVnsWMB24BTFKwggEXKOtqJ96GWZh2Xz+ogocQHM+=+6Q@mail.gmail.com>
X-Gm-Features: AWmQ_bm5vGlc5XXZic8RvnXrZNNcCRnf0-7M9Km7uh4sqx0Aign1FjKoX2MZmow
Message-ID: <CAMuHMdVnsWMB24BTFKwggEXKOtqJ96GWZh2Xz+ogocQHM+=+6Q@mail.gmail.com>
Subject: Re: [PATCH v4 05/29] dt-bindings: bus: Add simple-platform-bus
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Wed, 15 Oct 2025 at 09:17, Herve Codina <herve.codina@bootlin.com> wrote=
:
> A Simple Platform Bus is a transparent bus that doesn't need a specific
> driver to perform operations at bus level.
>
> Similar to simple-bus, a Simple Platform Bus allows to automatically
> instantiate devices connected to this bus.
>
> Those devices are instantiated only by the Simple Platform Bus probe
> function itself.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/simple-platform-bus.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/simple-platform-bus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple Platform Bus
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description: |
> +  A Simple Platform Bus is a transparent bus that doesn't need a specifi=
c
> +  driver to perform operations at bus level.
> +
> +  Similar to simple-bus, a Simple Platform Bus allows to automatically
> +  instantiate devices connected to this bus. Those devices are instantia=
ted
> +  only by the Simple Platform Bus probe function itself.

So what are the differences with simple-bus? That its children are
instantiated "only by the Simple Platform Bus probe function itself"?
If that is the case, in which other places are simple-bus children
instantiated?

Do we need properties related to power-management (clocks, power-domains),
or will we need a "simple-pm-platform-bus" later? ;-)

FTR, I still think we wouldn't have needed the distinction between
"simple-bus" and "simple-pm-bus"...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

