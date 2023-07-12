Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62AC750D4F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jul 2023 17:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjGLP7K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jul 2023 11:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjGLP7K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2023 11:59:10 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F113A198A
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 08:59:08 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 344AB1BF20E;
        Wed, 12 Jul 2023 15:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689177547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DUzp60t0a9OWXd9S5Cm1RIfJW+31mfVu50N3eQMaBpA=;
        b=Eq+72p7SG3fVBj8c0xDoOa9DFPUTeSt/MqASbUhIxKGbU5JiUdcnLFf2AGLBwIMJBp8Z5F
        7QiapYceVziaFPYVQee9q852yZM0adebFsMO6Gac7B4A56njTNCQpTl2F8yfn6HS5N6dx3
        F0+xFU6ozmchM+RXvzGNtuQnlj+4GRKPpqJLgc0/WfWMaNEw0dZnvHp3mIOHHU+2KqSQHj
        WszwTT1Q7tCbLYFqR2IXelM+CZ4a8QjNKbznDIUsSrjn1PcVFI8iHzXE53qLz2dgDXd1XP
        G1B6MIzS2BwrefGL/SIYMsXwS53zY8HUL8xioLbKdYjXSJm8TmDC/7j6MYzxYg==
Date:   Wed, 12 Jul 2023 17:58:53 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-pm@vger.kernel.org, <linux-arm-kernel@lists.infradead.org>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v4] power: reset: at91-reset: add sysfs interface to the
 power on reason
Message-ID: <20230712175853.35184e92@xps-13>
In-Reply-To: <20230620062657.3127468-1-miquel.raynal@bootlin.com>
References: <20230620062657.3127468-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

miquel.raynal@bootlin.com wrote on Tue, 20 Jun 2023 08:26:57 +0200:

> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
>=20
> Introduce a list of generic reset sources and use them to export the
> power on reason through sysfs. Update the ABI documentation to describe
> this new interface.

I just rebased this patch on top of -rc1, no conflict whatsoever, do
you need a resend or are you still considering this version?

> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> [Miquel Raynal: Follow-up on Kamel's work, 4 years later]
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Cheers,
Miqu=C3=A8l

> ---
>=20
> Changes in v4:
> * Patch 1/2 was merged.
> * Changed the "low-power condition" into a "brown-out reset" as
>   suggested by Sebastian.
>=20
> Changes in v3:
> * Made the series bisectable.
> * Updated the date and kernel version for this new feature.
> * Changed a few definitions as discussed with Sebastian.
>=20
> Changes in v2:
> * Collected Nicolas' Acked-by
> * Dropped the Xtal frequency information (as this may change between
>   platforms of course).
>=20
>  .../testing/sysfs-platform-power-on-reason    | 12 ++++++
>  drivers/power/reset/at91-reset.c              | 37 ++++++++++++++-----
>  include/linux/power/power_on_reason.h         | 19 ++++++++++
>  3 files changed, 58 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-power-on-rea=
son
>  create mode 100644 include/linux/power/power_on_reason.h
>=20
> diff --git a/Documentation/ABI/testing/sysfs-platform-power-on-reason b/D=
ocumentation/ABI/testing/sysfs-platform-power-on-reason
> new file mode 100644
> index 000000000000..c3b29dbc64bf
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-power-on-reason
> @@ -0,0 +1,12 @@
> +What:		/sys/devices/platform/.../power_on_reason
> +Date:		June 2023
> +KernelVersion:	6.5
> +Contact:	Kamel Bouhara <kamel.bouhara@bootlin.com>
> +Description:	Shows system power on reason. The following strings/reasons=
 can
> +		be read (the list can be extended):
> +		"regular power-up", "RTC wakeup", "watchdog timeout",
> +		"software reset", "reset button action", "CPU clock failure",
> +		"crystal oscillator failure", "brown-out reset",
> +		"unknown reason".
> +
> +		The file is read only.
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-=
reset.c
> index d6884841a6dc..aa9b012d3d00 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -18,6 +18,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/reboot.h>
>  #include <linux/reset-controller.h>
> +#include <linux/power/power_on_reason.h>
> =20
>  #include <soc/at91/at91sam9_ddrsdr.h>
>  #include <soc/at91/at91sam9_sdramc.h>
> @@ -149,44 +150,54 @@ static int at91_reset(struct notifier_block *this, =
unsigned long mode,
>  	return NOTIFY_DONE;
>  }
> =20
> -static const char * __init at91_reset_reason(struct at91_reset *reset)
> +static const char *at91_reset_reason(struct at91_reset *reset)
>  {
>  	u32 reg =3D readl(reset->rstc_base + AT91_RSTC_SR);
>  	const char *reason;
> =20
>  	switch ((reg & AT91_RSTC_RSTTYP) >> 8) {
>  	case RESET_TYPE_GENERAL:
> -		reason =3D "general reset";
> +		reason =3D POWER_ON_REASON_REGULAR;
>  		break;
>  	case RESET_TYPE_WAKEUP:
> -		reason =3D "wakeup";
> +		reason =3D POWER_ON_REASON_RTC;
>  		break;
>  	case RESET_TYPE_WATCHDOG:
> -		reason =3D "watchdog reset";
> +		reason =3D POWER_ON_REASON_WATCHDOG;
>  		break;
>  	case RESET_TYPE_SOFTWARE:
> -		reason =3D "software reset";
> +		reason =3D POWER_ON_REASON_SOFTWARE;
>  		break;
>  	case RESET_TYPE_USER:
> -		reason =3D "user reset";
> +		reason =3D POWER_ON_REASON_RST_BTN;
>  		break;
>  	case RESET_TYPE_CPU_FAIL:
> -		reason =3D "CPU clock failure detection";
> +		reason =3D POWER_ON_REASON_CPU_CLK_FAIL;
>  		break;
>  	case RESET_TYPE_XTAL_FAIL:
> -		reason =3D "32.768 kHz crystal failure detection";
> +		reason =3D POWER_ON_REASON_XTAL_FAIL;
>  		break;
>  	case RESET_TYPE_ULP2:
> -		reason =3D "ULP2 reset";
> +		reason =3D POWER_ON_REASON_BROWN_OUT;
>  		break;
>  	default:
> -		reason =3D "unknown reset";
> +		reason =3D POWER_ON_REASON_UNKNOWN;
>  		break;
>  	}
> =20
>  	return reason;
>  }
> =20
> +static ssize_t power_on_reason_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct at91_reset *reset =3D platform_get_drvdata(pdev);
> +
> +	return sprintf(buf, "%s\n", at91_reset_reason(reset));
> +}
> +static DEVICE_ATTR_RO(power_on_reason);
> +
>  static const struct of_device_id at91_ramc_of_match[] =3D {
>  	{
>  		.compatible =3D "atmel,at91sam9260-sdramc",
> @@ -391,6 +402,12 @@ static int __init at91_reset_probe(struct platform_d=
evice *pdev)
>  	if (ret)
>  		goto disable_clk;
> =20
> +	ret =3D device_create_file(&pdev->dev, &dev_attr_power_on_reason);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Could not create sysfs entry\n");
> +		return ret;
> +	}
> +
>  	dev_info(&pdev->dev, "Starting after %s\n", at91_reset_reason(reset));
> =20
>  	return 0;
> diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/=
power_on_reason.h
> new file mode 100644
> index 000000000000..95a1ec0c403c
> --- /dev/null
> +++ b/include/linux/power/power_on_reason.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Author: Kamel Bouhra <kamel.bouhara@bootlin.com>
> + */
> +
> +#ifndef POWER_ON_REASON_H
> +#define POWER_ON_REASON_H
> +
> +#define POWER_ON_REASON_REGULAR "regular power-up"
> +#define POWER_ON_REASON_RTC "RTC wakeup"
> +#define POWER_ON_REASON_WATCHDOG "watchdog timeout"
> +#define POWER_ON_REASON_SOFTWARE "software reset"
> +#define POWER_ON_REASON_RST_BTN "reset button action"
> +#define POWER_ON_REASON_CPU_CLK_FAIL "CPU clock failure"
> +#define POWER_ON_REASON_XTAL_FAIL "crystal oscillator failure"
> +#define POWER_ON_REASON_BROWN_OUT "brown-out reset"
> +#define POWER_ON_REASON_UNKNOWN "unknown reason"
> +
> +#endif /* POWER_ON_REASON_H */
