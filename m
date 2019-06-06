Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1599637A76
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 19:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfFFRFG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 13:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFRFG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Jun 2019 13:05:06 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39C5B20693;
        Thu,  6 Jun 2019 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559840705;
        bh=uHOnF18rQ1x4hUh7PQwXCuloLsMPslXGMYzeeFg/e18=;
        h=In-Reply-To:References:To:Subject:From:Cc:Date:From;
        b=LJouhF834bm0oyjp4K3HMzEfmeO/CynTLHON+s66xYLMS9rlFer55d4RIjFRsHe0h
         sKukE1s08fJcwj3HnI+19EmuFXk7pOcCRuTS5VjlCZQhSB64usa6fFp9BL+hN4jdCs
         OtnljmrrtAcwblV5a0vLj2vb6pEVb4Bf3VNMrNAA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190606142255.29454-6-nsaenzjulienne@suse.de>
References: <20190606142255.29454-1-nsaenzjulienne@suse.de> <20190606142255.29454-6-nsaenzjulienne@suse.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, stefan.wahren@i2se.com
Subject: Re: [PATCH v2 5/7] clk: raspberrypi: register platform device for raspberrypi-cpufreq
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        eric@anholt.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 10:05:04 -0700
Message-Id: <20190606170505.39C5B20693@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Nicolas Saenz Julienne (2019-06-06 07:22:58)
> diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-rasp=
berrypi.c
> index b1365cf19f3a..052296b5fbe4 100644
> --- a/drivers/clk/bcm/clk-raspberrypi.c
> +++ b/drivers/clk/bcm/clk-raspberrypi.c
> @@ -63,6 +63,8 @@ struct raspberrypi_firmware_prop {
>         __le32 disable_turbo;
>  } __packed;
> =20
> +static struct platform_device *rpi_cpufreq;

Why can't this be stored in platform driver data?

> +
>  static int raspberrypi_clock_property(struct rpi_firmware *firmware, u32=
 tag,
>                                       u32 clk, u32 *val)
>  {
> @@ -285,6 +287,17 @@ static int raspberrypi_clk_probe(struct platform_dev=
ice *pdev)
>                 return ret;
>         }
> =20
> +       rpi_cpufreq =3D platform_device_register_data(dev, "raspberrypi-c=
pufreq",
> +                                                   -1, NULL, 0);
> +
> +       return 0;
> +}
> +
> +static int raspberrypi_clk_remove(struct platform_device *pdev)
> +{
> +       platform_device_unregister(rpi_cpufreq);
> +       rpi_cpufreq =3D NULL;

This assignment to NULL looks unnecessary.

> +
>         return 0;
>  }
> =20
