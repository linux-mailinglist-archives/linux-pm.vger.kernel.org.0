Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F43F423A7B
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 11:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbhJFJ0p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 6 Oct 2021 05:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhJFJ0p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 05:26:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72314C061749
        for <linux-pm@vger.kernel.org>; Wed,  6 Oct 2021 02:24:53 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mY3AD-00058X-K4; Wed, 06 Oct 2021 11:24:37 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mY3AA-0007WP-J2; Wed, 06 Oct 2021 11:24:34 +0200
Message-ID: <59334bc1f64926f8106a9b1e885dd88971d34117.camel@pengutronix.de>
Subject: Re: [PATCH 3/7] soc: apple: Add driver for Apple PMGR power state
 controls
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
Date:   Wed, 06 Oct 2021 11:24:34 +0200
In-Reply-To: <20211005155923.173399-4-marcan@marcan.st>
References: <20211005155923.173399-1-marcan@marcan.st>
         <20211005155923.173399-4-marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Hector,

On Wed, 2021-10-06 at 00:59 +0900, Hector Martin wrote:
> Implements genpd and reset providers for downstream devices. Each
> instance of the driver binds to a single register and represents a
> single SoC power domain.
> 
> The driver does not currently implement all features (auto-pm,
> clockgate-only state), but we declare the respective registers for
> documentation purposes. These features will be added as they become
> useful for downstream devices.
> 
> This also creates the apple/soc tree and Kconfig submenu.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  MAINTAINERS                             |   1 +
>  drivers/soc/Kconfig                     |   1 +
>  drivers/soc/Makefile                    |   1 +
>  drivers/soc/apple/Kconfig               |  21 ++
>  drivers/soc/apple/Makefile              |   2 +
>  drivers/soc/apple/apple-pmgr-pwrstate.c | 281 ++++++++++++++++++++++++
>  6 files changed, 307 insertions(+)
>  create mode 100644 drivers/soc/apple/Kconfig
>  create mode 100644 drivers/soc/apple/Makefile
>  create mode 100644 drivers/soc/apple/apple-pmgr-pwrstate.c
> 
[...]
> diff --git a/drivers/soc/apple/apple-pmgr-pwrstate.c b/drivers/soc/apple/apple-pmgr-pwrstate.c
> new file mode 100644
> index 000000000000..a0338dbb29b8
> --- /dev/null
> +++ b/drivers/soc/apple/apple-pmgr-pwrstate.c
> @@ -0,0 +1,281 @@
[...]
> +static int apple_pmgr_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct apple_pmgr_ps *ps = rcdev_to_apple_pmgr_ps(rcdev);
> +
> +	mutex_lock(&ps->genpd.mlock);
> +
> +	if (ps->genpd.status == GENPD_STATE_OFF)
> +		dev_err(ps->dev, "PS 0x%x: asserting RESET while powered down\n", ps->offset);
> +
> +	dev_dbg(ps->dev, "PS 0x%x: assert reset\n", ps->offset);
> +	/* Quiesce device before asserting reset */
> +	regmap_set_bits(ps->regmap, ps->offset, APPLE_PMGR_DEV_DISABLE);
> +	regmap_set_bits(ps->regmap, ps->offset, APPLE_PMGR_RESET);
> +
> +	mutex_unlock(&ps->genpd.mlock);
> +
> +	return 0;
> +}
> +
> +static int apple_pmgr_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct apple_pmgr_ps *ps = rcdev_to_apple_pmgr_ps(rcdev);
> +
> +	mutex_lock(&ps->genpd.mlock);
> +
> +	dev_dbg(ps->dev, "PS 0x%x: deassert reset\n", ps->offset);
> +	regmap_clear_bits(ps->regmap, ps->offset, APPLE_PMGR_RESET);
> +	regmap_clear_bits(ps->regmap, ps->offset, APPLE_PMGR_DEV_DISABLE);
> +
> +	if (ps->genpd.status == GENPD_STATE_OFF)
> +		dev_err(ps->dev, "PS 0x%x: RESET was deasserted while powered down\n", ps->offset);
> +
> +	mutex_unlock(&ps->genpd.mlock);
> +
> +	return 0;
> +}
> +
> +static int apple_pmgr_reset_reset(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	int ret;
> +
> +	ret = apple_pmgr_reset_assert(rcdev, id);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(APPLE_PMGR_RESET_TIME, 2 * APPLE_PMGR_RESET_TIME);

Is this delay known to be long enough for all consumers using the
reset_control_reset() functionality? Are there any users at all?

Is it ok for a genpd transition to happen during this sleep?

> +	return apple_pmgr_reset_deassert(rcdev, id);
> +}

regards
Philipp
