Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0004E41EDD3
	for <lists+linux-pm@lfdr.de>; Fri,  1 Oct 2021 14:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353342AbhJAMwt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Oct 2021 08:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353510AbhJAMwr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Oct 2021 08:52:47 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D925C0613E3
        for <linux-pm@vger.kernel.org>; Fri,  1 Oct 2021 05:51:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y23so3771510lfj.7
        for <linux-pm@vger.kernel.org>; Fri, 01 Oct 2021 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U3g3FVHcAfq2CjS/tDBEgPrTjvgAlik1UmRsepWrO/M=;
        b=AzjhIKsGc5F00nF8gT49XgOerH2kylziofl1fTWdcLRpswV4wNz8DKK5xJ7On0pP/7
         FUfZ1Wgbt1/fuaxVdMYCvvgTtIGVXfv0UoK33+IzBB+zOi+jh2jn6j2wyaLjswS/IOzw
         SQjTg3BAouTPEqyD9JFdD9cYzi69CQhCoGH5fKvFHMMepL7XM0KGl/OrspTiy4mR9WhP
         foe5FrlQSoXx4OG2RW+Mn3fWJuth6XGpzQJ4ILLPGQ/0+fTYG3YwXfmnYk9SirlbmFbB
         VWqNGRy6BMbC7o4y9fE4zK6CBmWtNh3bv3/HT2LLpsFmdOSr7meyX9U8IJw0f7EYsu6v
         RPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U3g3FVHcAfq2CjS/tDBEgPrTjvgAlik1UmRsepWrO/M=;
        b=HeF19x/+WyJbh504UvgQ3/dttcMOXVntKtGq1AmHMeHKQ3lJZfPo1QqKb6u+HeJT0R
         xoB7uSdl/c3uxino9bSbPXIKpfzh+KXRmQuKjd7UhcH2ekzivCuBketwkCJGVinB6faN
         Z/iUxM8L7a5LuYEwwDBEAU6imlc+dLZK75NmvGt5NcQb05+ULjuSLKo76jZge5q+SAvm
         nkZGD0tk/GbmSFrBpxHjTDxySfusPxTOsNgA1YjXk4mOORBQtMYmml5OrGtt01HHO5js
         E1KOKRBBZ+uGJmRWt2vtLvk40hrTCKNn/1K1Sel2vp7ZdAbx/hK1Eiij7vSJ07ydlQrw
         CXDw==
X-Gm-Message-State: AOAM533QgfmlwKjUQ9UzyP1XP83mcBF3om5z7SONJumCP/auTuJ3J/BI
        lKriT9GnUV6GYqjntwKgdUdGyXKstI2BUVAZfIpmsA==
X-Google-Smtp-Source: ABdhPJwqqw8e12Oj8Mbs+ZBogohxgciqSKBUNXiyR2zo3nKqwCJ61Gsrw5pb7r1VVcKkZcvnXQuH+1x0Dzep9YUsgPg=
X-Received: by 2002:a19:5f4b:: with SMTP id a11mr5158365lfj.373.1633092661107;
 Fri, 01 Oct 2021 05:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210926224058.1252-1-digetx@gmail.com> <20210926224058.1252-3-digetx@gmail.com>
In-Reply-To: <20210926224058.1252-3-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 1 Oct 2021 14:50:25 +0200
Message-ID: <CAPDyKFrtE75Tf-vefM0isj52PJ5_v525AjqU2TMUpc4__rYLhA@mail.gmail.com>
Subject: Re: [PATCH v13 02/35] soc/tegra: Add devm_tegra_core_dev_init_opp_table_common()
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 27 Sept 2021 at 00:42, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Only couple drivers need to get the -ENODEV error code and majority of
> drivers need to explicitly initialize the performance state. Add new
> common helper which sets up OPP table for these drivers.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/soc/tegra/common.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/include/soc/tegra/common.h b/include/soc/tegra/common.h
> index af41ad80ec21..5b4a042f60fb 100644
> --- a/include/soc/tegra/common.h
> +++ b/include/soc/tegra/common.h
> @@ -39,4 +39,28 @@ devm_tegra_core_dev_init_opp_table(struct device *dev,
>  }
>  #endif
>
> +/*
> + * This function should be invoked with the enabled runtime PM of the device
> + * in order to initialize performance state properly. Most of Tegra devices
> + * are assumed to be suspended at a probe time and GENPD require RPM to be
> + * enabled to set up the rpm-resume state, otherwise device is active and
> + * performance state is applied immediately. Note that it will initialize
> + * OPP bandwidth if it's wired in a device-tree for this device, which is
> + * undesirable for a suspended device.
> + */
> +static inline int
> +devm_tegra_core_dev_init_opp_table_common(struct device *dev)
> +{
> +       struct tegra_core_opp_params opp_params = {};
> +       int err;
> +
> +       opp_params.init_state = true;
> +
> +       err = devm_tegra_core_dev_init_opp_table(dev, &opp_params);
> +       if (err != -ENODEV)
> +               return err;
> +
> +       return 0;
> +}

Just want to share a few thoughts around these functions.

So, I assume it's fine to call
devm_tegra_core_dev_init_opp_table_common() or
devm_tegra_core_dev_init_opp_table() from consumer drivers during
->probe(), as long as those drivers are tegra specific, which I assume
all are in the series!?

My point is, a cross SoC consumer driver that needs to initiate OPP
tables can get rather messy, if it would need to make one specific
function call per SoC.

That said, I hope we can tackle this as a separate/future problem, so
the series can get merged as is.

> +
>  #endif /* __SOC_TEGRA_COMMON_H__ */
> --
> 2.32.0
>

Kind regards
Uffe
