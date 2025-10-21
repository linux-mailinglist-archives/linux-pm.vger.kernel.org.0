Return-Path: <linux-pm+bounces-36557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B2861BF5D38
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 12:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3FD4834A03A
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 10:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0411E32F75C;
	Tue, 21 Oct 2025 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OV4FJNFQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36A7328B67
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043049; cv=none; b=ZnHdXpB8wT4KlbM6b+rgm762fd1utkTneqCSuLT8uuzFuOxNa/+HHbCjjL/LifDhCcTQYt27yfNmPvbiFUB8s2q48PgV0sqSJ6OPKNWnZp2JgpulUueH9Ww4Xe3W46Gge+luaGaUQX/XjfIl22Df6Jegj0C2edDGbw/1EJzkc80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043049; c=relaxed/simple;
	bh=G8bIrdKOREeaQWFYl+BVblIyK/tNvhnzk9i8+sGZ5Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6dOpnECPj9ue2gsE6d3KpZQz+ZyA94bbWhYi4DoGFD3tD0NX2lqoz1vhC39yhjAE0E1hQhdeiVaWNJHqXjsyzXUVk1SrVK9DLfx/9LlyDtw6ffDUt0eGhlMoTI98UTVy+h4MKc6YIgozbFIJlEpxWdMHCDE5+WZ6quc7ZaI+Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OV4FJNFQ; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63e1591183bso4310052d50.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 03:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761043046; x=1761647846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=du/uiA2g0ruAK2UrT7r+xEuTy7bML0SpAVcY8ooVq04=;
        b=OV4FJNFQ1uapnGqxwNArp1c3sMnou9Gn5Mulg7FgaRBpu3ejO833yxc66+0QPR5qku
         aA6EtTV2yORIXSU8/KOKiCgkLr08ed7m+oB3VG68OcVm4IkfQWuf0NSFnvDvBvHYEmGO
         s7eoCUGrMzgib3JPXWKNfiFjGSXvsakVOwKCpyf53cvuthskb+tI6l295G2g2M067qv0
         G6+Xk1iy4eqtknYhBYxWVNcWvuKiCEb1jHN6XCahAmWGOYfMn+CWYLTXienvZkfJa3Lm
         e+zGW8er2mG1JDxIljGhsR0OOWqP1w+F6NtkkmNhuPT00c+L0r+NcJ0Wx1GHFOjnhc7B
         L2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761043046; x=1761647846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=du/uiA2g0ruAK2UrT7r+xEuTy7bML0SpAVcY8ooVq04=;
        b=MMHEWyK4NTojVp/6lswMp5xImXpHYqkfaynmQZ6ybJ2CvQsmSM7kb0bqztSg+TheIw
         be/XMnmrZRCi0xIVVw39SKkWQ2ATeE2pecF4y0+gbcDcsDMkVAwXwEdI0qnq135XLtlZ
         SHbaYOQv3iiHKHc7fDqsRAgCb2fm5a9pvWO14A7ETnl8+zib18j2NH6KgGuoPPx9q5na
         fgw8Lc/SrS9YxU1I4PRwJX7DvwyZSA4opTyp7A/SqJQmmibH5cyDqlHCcST5/lc0XJAv
         AqqyK3Wfr73vpak8WIe+pf1to3Gn488aqwXsUnxymYKqQvJD97ciu64ZwV4c1EC6kxL2
         uNRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPAmg3jPtLsP43d7TDaZyzXq9w3KgkoOZeZoeUa910NKwI5UjXfMMyqzD1Suu0hUXpIfQ4VhjvNg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Hp1sieWzHegPV7C8vWzlavubwjgrZJaw880Xr7Ndv9xV4mVw
	EEcRFO2H6uXFnQKZgzKWAkBzhXT+s0E2Q5jLmPgVimygtrMY7t9JfxnpE9LbDzcJKM3qPubmJiS
	+MQjjTaKoMwOYDyiTUWGYQh+Mbp5ufWKMXtQrdrqL4w==
X-Gm-Gg: ASbGncttDoV9JCZpGNYpDyuwVJ2AKwtSjVQCPEmdVich3us5Wnz8+qkpEWGQlu4Gb12
	osmssuow41vKcvRmf3VGWluBZK2mxJ2RdTbrK/+Kyr4csZdknGqC/a+MM22Q2RSXStWTxoMwzQ2
	rxgkgyX3XaOeI+msDZCyx+8jzz7SOjy7YW39v3+UdwahltWFD/hZMbPtNPGayRSKJZ5KfPxluKv
	GFBF5i4f3VZNMS1hyX7H0qh1Y4BROv1TqUyLNcKW7agyyH4e/U37i+uti1maA==
X-Google-Smtp-Source: AGHT+IFFOhRKu4kQW/XKD1Pm8VUPug9hRZQumhyHTlK9vebZPyquvLC0TgCPXJX5yR8+F8jVszRXlOsVXxUxv7obTms=
X-Received: by 2002:a05:690e:4090:b0:63e:3e77:a7c4 with SMTP id
 956f58d0204a3-63e3e77a7fdmr3660188d50.1.1761043045615; Tue, 21 Oct 2025
 03:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015071420.1173068-1-herve.codina@bootlin.com> <20251015071420.1173068-10-herve.codina@bootlin.com>
In-Reply-To: <20251015071420.1173068-10-herve.codina@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 Oct 2025 12:36:49 +0200
X-Gm-Features: AS18NWAi-o77CPd71JT42D3mLl8vqFN7eYPAV53oOUDllJc5eKGrXIzOLUEhLMM
Message-ID: <CAPDyKFrkJp4Ny1kUoWy6LHmv6zCOGK-jVEYk95s2ayhqEbDOpw@mail.gmail.com>
Subject: Re: [PATCH v4 09/29] drivers: core: Use fw_devlink_set_device()
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
	Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
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

On Wed, 15 Oct 2025 at 09:18, Herve Codina <herve.codina@bootlin.com> wrote:
>
> The code set directly fwnode->dev field.
>
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3e81b1914ce5..9da630d75d17 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3739,7 +3739,7 @@ int device_add(struct device *dev)
>          * device and the driver sync_state callback is called for this device.
>          */
>         if (dev->fwnode && !dev->fwnode->dev) {
> -               dev->fwnode->dev = dev;
> +               fw_devlink_set_device(dev->fwnode, dev);
>                 fw_devlink_link_device(dev);
>         }
>
> @@ -3899,7 +3899,7 @@ void device_del(struct device *dev)
>         device_unlock(dev);
>
>         if (dev->fwnode && dev->fwnode->dev == dev)
> -               dev->fwnode->dev = NULL;
> +               fw_devlink_set_device(dev->fwnode, NULL);
>
>         /* Notify clients of device removal.  This call must come
>          * before dpm_sysfs_remove().
> --
> 2.51.0
>

