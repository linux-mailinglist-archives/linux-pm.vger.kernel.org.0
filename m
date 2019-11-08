Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0868F59B9
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 22:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbfKHVUQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 16:20:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbfKHVUP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Nov 2019 16:20:15 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07BC720869;
        Fri,  8 Nov 2019 21:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573248015;
        bh=W/41aRz8a8e9Jzva0r1YTdxOVETPDBmfjwIJpNNiqTo=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=Me4X4kOP6rnHyQzvR7U+RS3BdTpdzXkCGMlKfLEKkPOQQTryEtc5EnICH4UTyxRxe
         L8e3Hx/hWXqBzqJyYQIQV5lINo5swzsVWD3rGH7cP5RgO++f4s6unqKLhuHSGdzE/M
         iEsMjCqCROMDMaZLuXWIkRGnFffYUdUeITafEutM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1565984527-5272-12-git-send-email-skomatineni@nvidia.com>
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com> <1565984527-5272-12-git-send-email-skomatineni@nvidia.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>, jason@lakedaemon.net,
        jonathanh@nvidia.com, linus.walleij@linaro.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, stefan@agner.ch,
        tglx@linutronix.de, thierry.reding@gmail.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        skomatineni@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, mperttunen@nvidia.com,
        spatra@nvidia.com, robh+dt@kernel.org, digetx@gmail.com,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 11/22] clk: tegra: clk-dfll: Add suspend and resume support
User-Agent: alot/0.8.1
Date:   Fri, 08 Nov 2019 13:20:14 -0800
Message-Id: <20191108212015.07BC720869@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Sowjanya Komatineni (2019-08-16 12:41:56)
> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
> index f8688c2ddf1a..c051d92c2bbf 100644
> --- a/drivers/clk/tegra/clk-dfll.c
> +++ b/drivers/clk/tegra/clk-dfll.c
> @@ -1487,6 +1487,7 @@ static int dfll_init(struct tegra_dfll *td)
>         td->last_unrounded_rate =3D 0;
> =20
>         pm_runtime_enable(td->dev);
> +       pm_runtime_irq_safe(td->dev);

Why irq_safe? It would be good to mention it in the commit text or
something.

>         pm_runtime_get_sync(td->dev);
> =20
>         dfll_set_mode(td, DFLL_DISABLED);
> @@ -1513,6 +1514,61 @@ static int dfll_init(struct tegra_dfll *td)
>         return ret;
>  }
> =20
> +/**
> + * tegra_dfll_suspend - check DFLL is disabled
> + * @dev: DFLL device *
> + *
> + * DFLL clock should be disabled by the CPUFreq driver. So, make
> + * sure it is disabled and disable all clocks needed by the DFLL.
> + */
> +int tegra_dfll_suspend(struct device *dev)
> +{
> +       struct tegra_dfll *td =3D dev_get_drvdata(dev);
> +
> +       if (dfll_is_running(td)) {
> +               dev_err(td->dev, "DFLL still enabled while suspending\n");
> +               return -EBUSY;
> +       }
> +
> +       reset_control_assert(td->dvco_rst);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(tegra_dfll_suspend);
> +
> +/**
> + * tegra_dfll_resume - reinitialize DFLL on resume
> + * @dev: DFLL instance

I prefer this description for tegra_dfll_suspend's 'dev' argument.

> + *
> + * DFLL is disabled and reset during suspend and resume.
> + * So, reinitialize the DFLL IP block back for use.
> + * DFLL clock is enabled later in closed loop mode by CPUFreq
> + * driver before switching its clock source to DFLL output.
> + */
> +int tegra_dfll_resume(struct device *dev)
> +{
> +       struct tegra_dfll *td =3D dev_get_drvdata(dev);
> +
> +       reset_control_deassert(td->dvco_rst);
> +
> +       pm_runtime_get_sync(td->dev);
> +
> +       dfll_set_mode(td, DFLL_DISABLED);
> +       dfll_set_default_params(td);
