Return-Path: <linux-pm+bounces-12201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49792951AB6
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 14:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58341F2327E
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 12:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB601B010A;
	Wed, 14 Aug 2024 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qyKM256q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D412D1AED58
	for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637948; cv=none; b=a0gkcviYa4TWFUp/348KJZFOgQppLvP4ChppT/8SDeUwHwMoRgbZyb//LcAfJN6p9aKftsEePfSvIzJ/P4rs0J4FiuSAhtCDtYkMrWwf84Yi/73krQBIrNzA4YfM5Q6bw9wsuBgyho67HnE6CmTvAjT0yZwLP/yOzArJ5UO/5I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637948; c=relaxed/simple;
	bh=i0Tg4p47BN7aquPosNjUnPC3DF7o8lYYr4SPlV6dRHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUtgGT8zryJNtxWH6SqRORhiL2A9ASP2U90EnNBgHl0DK070AlthUV4EZPd9qghVDHBYTrufzWvjICjfyoh9bDg/bb07Q0BwgacQx+0ooTkJnxr07vUJ5wXlCJ4bbnvU/CUzadJf/r9BNaSaV9JLqHQerUV5e8ooysPrbmIOUQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qyKM256q; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e04196b7603so6617081276.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723637946; x=1724242746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GkO7BE2UO9+ru7pUnpn1jnINQAT3cICAUmPfXNrgDqo=;
        b=qyKM256qCXzkM4FSGq/uaAk1f4SfvZegBNqva2URXVXpy+BqbLP1x2Ujy+5ww2kDog
         LHD3FlHcz7YOZJlkvbcNsbZNQIZ9VheFnib9WP3rnLFSsgC8sgofiSIsdlNgllnto2ye
         ws1z5H6ihR8RkH0Z2b63tv+32G4cl0z2kHOLrRsaCvIqh/jh+rOgbOEjxxIQbwxc0PWj
         0J4J+VYzrH/V2Ymzvl1vJlSVi3iQr0x6WT6SZ/S8r4L9Si9RXRrCFM9VgaOwGqCCm/QM
         C8ZpAkXviMDUhsQdkkUkvMOlC1QUXYmOcVFOuSxwR4xGdnvOk/eDGekU8lRcijJOG2Ax
         xuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637946; x=1724242746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkO7BE2UO9+ru7pUnpn1jnINQAT3cICAUmPfXNrgDqo=;
        b=D6/qvKdLqNdFSas5U+pZavw5HSgMkJ1FvsJ9LRfBSUyCXG8lQJiLwgon2wtaS3zUqq
         7jUQ8VLftErYzH/2+tCeAu1T7R9aYpH8IS328ZYd4laPrcwnZm7hT8LS6dEQAnFTakS/
         hbLz1b2fiAUf83bhQFMpX8JQ4cH5qbAVzmvrV4IJLze7TQf36RBsNy5nPdJngmti+Yh9
         0rQz55KVm8QMlqysrvYRVJJsOaN8HTrfl13uQsSnYiFkUHtFp62aX5Ftj9Ys4a8xRPWT
         51up5oz2epMLj/MpnbO9C4aF2vikNnLr8uJzuLC4hpViE4FYLtK0i5Lkd6iIw0UmiiXf
         tUYw==
X-Forwarded-Encrypted: i=1; AJvYcCX3UyjAHs9iHq70tLdNoxLDrBhbPAFP12tJzpmB4JDKUQNhmy55z6IaBP2ytmyqXPTagDhjrBL+//WIUoWbamnQPBLd2edwJoc=
X-Gm-Message-State: AOJu0Ywsq6U7/nZM1sCsyUToFnzgFI1yZY1hBZ4ahmOITsWWe9bhXnHe
	M9RV3CnDMkTRiMtwM3ToqGfh6XJzZqvjOD2o08Zxa86IyxGn0uWdglPFzNnXVO3x5bZuaasRYKD
	bu4ev61Lh02QeVE43XZJBWoT8M+oq+TLvm8b5zQ==
X-Google-Smtp-Source: AGHT+IGjt5Gtd47+v4F9si1piYkQh5EGe0K9dfdnK1s/935m+Ubkmif2Bq5NIc2x2lXYaVSpzgpxhQW9gwzCUMfPSuo=
X-Received: by 2002:a05:6902:1895:b0:e03:a6b3:9f28 with SMTP id
 3f1490d57ef6-e1155a38eb4mr3847917276.10.1723637945672; Wed, 14 Aug 2024
 05:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728114200.75559-1-wahrenst@gmx.net> <20240728130029.78279-1-wahrenst@gmx.net>
 <20240728130029.78279-7-wahrenst@gmx.net>
In-Reply-To: <20240728130029.78279-7-wahrenst@gmx.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 Aug 2024 14:18:29 +0200
Message-ID: <CAPDyKFoJh3j8xSeXZ9o031YZLTCDYVA+dgvURuwozjDpU_aauA@mail.gmail.com>
Subject: Re: [PATCH V2 15/16] serial: 8250_bcm2835aux: add PM suspend/resume support
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Maxime Ripard <mripard@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Minas Harutyunyan <hminas@synopsys.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, 
	Artur Petrosyan <Arthur.Petrosyan@synopsys.com>, Peter Robinson <pbrobinson@gmail.com>, 
	dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel-list@raspberrypi.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jul 2024 at 15:07, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> This adds suspend/resume support for the 8250_bcm2835aux
> driver to provide power management support on attached
> devices.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/tty/serial/8250/8250_bcm2835aux.c | 37 +++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
> index 121a5ce86050..36e2bb34d82b 100644
> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
> @@ -13,6 +13,7 @@
>   */
>
>  #include <linux/clk.h>
> +#include <linux/console.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -213,11 +214,47 @@ static const struct acpi_device_id bcm2835aux_serial_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, bcm2835aux_serial_acpi_match);
>
> +static int bcm2835aux_suspend(struct device *dev)
> +{
> +       struct bcm2835aux_data *data = dev_get_drvdata(dev);
> +       struct uart_8250_port *up = serial8250_get_port(data->line);
> +
> +       serial8250_suspend_port(data->line);
> +
> +       if (device_may_wakeup(dev))
> +               return 0;
> +
> +       if (uart_console(&up->port) && !console_suspend_enabled)
> +               return 0;
> +
> +       clk_disable_unprepare(data->clk);
> +       return 0;
> +}
> +
> +static int bcm2835aux_resume(struct device *dev)
> +{
> +       struct bcm2835aux_data *data = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = clk_prepare_enable(data->clk);

Doesn't this create clk prepare/enable - unprepare/disable imbalance
problem when the uart is configured for system wakeup?

> +       if (ret)
> +               return ret;
> +
> +       serial8250_resume_port(data->line);
> +
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops bcm2835aux_dev_pm_ops = {
> +       SYSTEM_SLEEP_PM_OPS(bcm2835aux_suspend, bcm2835aux_resume)
> +};
> +
>  static struct platform_driver bcm2835aux_serial_driver = {
>         .driver = {
>                 .name = "bcm2835-aux-uart",
>                 .of_match_table = bcm2835aux_serial_match,
>                 .acpi_match_table = bcm2835aux_serial_acpi_match,
> +               .pm = pm_ptr(&bcm2835aux_dev_pm_ops),
>         },
>         .probe  = bcm2835aux_serial_probe,
>         .remove_new = bcm2835aux_serial_remove,
> --
> 2.34.1
>

Kind regards
Uffe

