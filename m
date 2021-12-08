Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB09F46D2E4
	for <lists+linux-pm@lfdr.de>; Wed,  8 Dec 2021 13:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhLHMH5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 8 Dec 2021 07:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhLHMH5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Dec 2021 07:07:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654A8C061746
        for <linux-pm@vger.kernel.org>; Wed,  8 Dec 2021 04:04:25 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1muvgD-0005J6-IA; Wed, 08 Dec 2021 13:04:13 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1muvgC-0009dk-1x; Wed, 08 Dec 2021 13:04:12 +0100
Message-ID: <d67ac4727317e84116e7d27ebd6af1ea4ed024a3.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/2] thermal/drivers: Add TSU driver for RZ/G2L
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Date:   Wed, 08 Dec 2021 13:04:11 +0100
In-Reply-To: <20211130155757.17837-3-biju.das.jz@bp.renesas.com>
References: <20211130155757.17837-1-biju.das.jz@bp.renesas.com>
         <20211130155757.17837-3-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Biju,

On Tue, 2021-11-30 at 15:57 +0000, Biju Das wrote:
> The RZ/G2L SoC incorporates a thermal sensor unit (TSU) that measures the
> temperature inside the LSI.
> 
> The thermal sensor in this unit measures temperatures in the range from
> −40 degree Celsius to 125 degree Celsius with an accuracy of ±3°C. The
> TSU repeats measurement at 20 microseconds intervals and automatically
> updates the results of measurement.
> 
> The TSU has no interrupts as well as no external pins.
> 
> This patch adds Thermal Sensor Unit(TSU) driver for RZ/G2L SoC.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
[...]
> +static int rzg2l_thermal_probe(struct platform_device *pdev)
> +{
[...]
> +	priv->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
                                                      ^^^^^^^^^^
Could use dev here.

> +	if (IS_ERR(priv->rstc))
> +		return dev_err_probe(dev, PTR_ERR(priv->rstc),
> +				     "failed to get cpg reset");
> +
> +	reset_control_deassert(priv->rstc);

I'd return if reset_control_deassert() throws an error. Either way,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
