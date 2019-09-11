Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85FABB0466
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2019 21:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfIKTFo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 15:05:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43254 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbfIKTFo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 15:05:44 -0400
Received: by mail-io1-f65.google.com with SMTP id r8so23446517iol.10;
        Wed, 11 Sep 2019 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CRqcj7+NuoI4D3cZX40T5TKikuDO93RhQlD6Y+l1eos=;
        b=TFQM0ojamkh1ySloLepkw4Vnnp+z3PWbYhYVqfkdh4RxgGEuHC8TPTbpPbHy6x2JD0
         JRUofNZKnBYbutyDTigYjqzOBsaCkSSp2rSl7dz9AfUYw8IZrQ5RGdVORUbixBiivPyC
         4We9ZWshElKuWJ4fE3UjLaRxLawGRNLiFCDws2ba2evyAajjVJrUdSZU/0jqB3xkeLkD
         hw3FRKk6X/U5TAhBdki7UmmeY8N76FyqymbXsNA/JGyt+cYmtdrsN94M7mM7DTwRm4ZJ
         ZngIcxjzCos1Tl9aSuDs9N8sMuShcXcZ5ykpNKaAi0c9WhRK14DBUow1s2/49M/VHyx4
         ZBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CRqcj7+NuoI4D3cZX40T5TKikuDO93RhQlD6Y+l1eos=;
        b=j6H7by2tByfOYiXdO3MfJS8ZNIYTtxunrzZ6hdvJevuKSxRjA9/ZUMZ6/jFLlWM/8f
         BTsPrWllCJTBeyuaET1raa2R67qIwvcg6SIatPjIooLM/ouZBrt5MFIN1qWhB61sT+MO
         FZwWjxqu4EsGaQtQIqB7LyhqHYPdFHL7hXqSQE+b8u5VisIgO2n023cml6LNOsbmNg0N
         HRxwxtRtsyjxwn0A0AvAnJYK6GrV58Ou5qy7JbkMh0RSC2QIlD90utba/0BwGQuX57v+
         ALl8CEYDMoui677JPortJUUhlcheRQzbs2TqumCMX3l80i2DK5VUbCtrV8V1ndFYwkxA
         zLEg==
X-Gm-Message-State: APjAAAUM8FGwVArkWyKNo2LTOOdo3oOb5SJYJNe2ZJ7/m5w5dRb7P4UP
        62AAXkB0s8tFThzdGhKwZ5VmFIsh6qVwtSBY8qzjI9Z0
X-Google-Smtp-Source: APXvYqyW3zpytIyyY4lkLih9aeq6GQUikYQE55Vk06YhYYlczXfzgPpsPg7ZSwNMCyW0TtkF3zR3Lv4zwFuvzF0J46Y=
X-Received: by 2002:a02:b395:: with SMTP id p21mr40570622jan.52.1568228743054;
 Wed, 11 Sep 2019 12:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568224032.git.hns@goldelico.com> <9254e741d1b43d824f0697ec54fe9c132903e244.1568224033.git.hns@goldelico.com>
In-Reply-To: <9254e741d1b43d824f0697ec54fe9c132903e244.1568224033.git.hns@goldelico.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 11 Sep 2019 14:05:31 -0500
Message-ID: <CAHCN7x+rK3aoLN7bKOn69JDsfJX69VSJBTuSRe78_YidmbOzEA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] cpufreq: ti-cpufreq: add support for omap34xx and omap36xx
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Roger Quadros <rogerq@ti.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@pyra-handheld.com,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 11, 2019 at 12:47 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> This adds code and tables to read the silicon revision and
> eFuse (speed binned / 720 MHz grade) bits for selecting
> opp-v2 table entries.
>
> Since these bits are not always part of the syscon register
> range (like for am33xx, am43, dra7), we add code to directly
> read the register values using ioremap() if syscon access fails.
>
> The format of the opp-supported-hw entries is that it has
> two 32 bit bitfields. E.g.:
>
>         opp-supported-hw = <0xffffffff 3>
>
> The first value is matched against the bit position of the
> silicon revision which is (see TRM)
>
> omap34xx:
> BIT(0)  ES1.0
> BIT(1)  ES2.0
> BIT(2)  ES2.1
> BIT(3)  ES3.0
> BIT(4)  ES3.1
> BIT(7)  ES3.1.2
>
> omap36xx:
> BIT(0)  ES1.0
> BIT(1)  ES1.1
> BIT(2)  ES1.2
>
> The second value is matched against the speed grade eFuse:
>
> BIT(0)  no high speed OPP
> BIT(1)  high speed OPP
>
> This means for the example above that it is always enabled
> while e.g.
>
>         opp-supported-hw = <0x1 2>
>
> enables the OPP only for ES1.0 BIT(0) and if the high speed
> eFuse is set BIT(1).
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Reviewed-by: Tony Lindgren <tony@atomide.com>

For the entire series, I tested on the Logic PD devices:
DM3730 Torpedo, OMAP3530 SOM-LV, DM3730 SOM-LV and AM3517-EVM

Tested-by: Adam Ford <aford173@gmail.com>

> ---
>  drivers/cpufreq/ti-cpufreq.c | 91 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 89 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 2ad1ae17932d..f2f58d689320 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -31,6 +31,11 @@
>  #define DRA7_EFUSE_OD_MPU_OPP                  BIT(1)
>  #define DRA7_EFUSE_HIGH_MPU_OPP                        BIT(2)
>
> +#define OMAP3_CONTROL_DEVICE_STATUS            0x4800244C
> +#define OMAP3_CONTROL_IDCODE                   0x4830A204
> +#define OMAP34xx_ProdID_SKUID                  0x4830A20C
> +#define OMAP3_SYSCON_BASE      (0x48000000 + 0x2000 + 0x270)
> +
>  #define VERSION_COUNT                          2
>
>  struct ti_cpufreq_data;
> @@ -84,6 +89,13 @@ static unsigned long dra7_efuse_xlate(struct ti_cpufreq_data *opp_data,
>         return calculated_efuse;
>  }
>
> +static unsigned long omap3_efuse_xlate(struct ti_cpufreq_data *opp_data,
> +                                     unsigned long efuse)
> +{
> +       /* OPP enable bit ("Speed Binned") */
> +       return BIT(efuse);
> +}
> +
>  static struct ti_cpufreq_soc_data am3x_soc_data = {
>         .efuse_xlate = amx3_efuse_xlate,
>         .efuse_fallback = AM33XX_800M_ARM_MPU_MAX_FREQ,
> @@ -111,6 +123,56 @@ static struct ti_cpufreq_soc_data dra7_soc_data = {
>         .multi_regulator = true,
>  };
>
> +/*
> + * OMAP35x TRM (SPRUF98K):
> + *  CONTROL_IDCODE (0x4830 A204) describes Silicon revisions.
> + *  Control OMAP Status Register 15:0 (Address 0x4800 244C)
> + *    to separate between omap3503, omap3515, omap3525, omap3530
> + *    and feature presence.
> + *    There are encodings for versions limited to 400/266MHz
> + *    but we ignore.
> + *    Not clear if this also holds for omap34xx.
> + *  some eFuse values e.g. CONTROL_FUSE_OPP1_VDD1
> + *    are stored in the SYSCON register range
> + *  Register 0x4830A20C [ProdID.SKUID] [0:3]
> + *    0x0 for normal 600/430MHz device.
> + *    0x8 for 720/520MHz device.
> + *    Not clear what omap34xx value is.
> + */
> +
> +static struct ti_cpufreq_soc_data omap34xx_soc_data = {
> +       .efuse_xlate = omap3_efuse_xlate,
> +       .efuse_offset = OMAP34xx_ProdID_SKUID - OMAP3_SYSCON_BASE,
> +       .efuse_shift = 3,
> +       .efuse_mask = BIT(3),
> +       .rev_offset = OMAP3_CONTROL_IDCODE - OMAP3_SYSCON_BASE,
> +       .multi_regulator = false,
> +};
> +
> +/*
> + * AM/DM37x TRM (SPRUGN4M)
> + *  CONTROL_IDCODE (0x4830 A204) describes Silicon revisions.
> + *  Control Device Status Register 15:0 (Address 0x4800 244C)
> + *    to separate between am3703, am3715, dm3725, dm3730
> + *    and feature presence.
> + *   Speed Binned = Bit 9
> + *     0 800/600 MHz
> + *     1 1000/800 MHz
> + *  some eFuse values e.g. CONTROL_FUSE_OPP 1G_VDD1
> + *    are stored in the SYSCON register range.
> + *  There is no 0x4830A20C [ProdID.SKUID] register (exists but
> + *    seems to always read as 0).
> + */
> +
> +static struct ti_cpufreq_soc_data omap36xx_soc_data = {
> +       .efuse_xlate = omap3_efuse_xlate,
> +       .efuse_offset = OMAP3_CONTROL_DEVICE_STATUS - OMAP3_SYSCON_BASE,
> +       .efuse_shift = 9,
> +       .efuse_mask = BIT(9),
> +       .rev_offset = OMAP3_CONTROL_IDCODE - OMAP3_SYSCON_BASE,
> +       .multi_regulator = false,
> +};
> +
>  /**
>   * ti_cpufreq_get_efuse() - Parse and return efuse value present on SoC
>   * @opp_data: pointer to ti_cpufreq_data context
> @@ -127,7 +189,17 @@ static int ti_cpufreq_get_efuse(struct ti_cpufreq_data *opp_data,
>
>         ret = regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset,
>                           &efuse);
> -       if (ret) {
> +       if (ret == -EIO) {
> +               /* not a syscon register! */
> +               void __iomem *regs = ioremap(OMAP3_SYSCON_BASE +
> +                               opp_data->soc_data->efuse_offset, 4);
> +
> +               if (!regs)
> +                       return -ENOMEM;
> +               efuse = readl(regs);
> +               iounmap(regs);
> +               }
> +       else if (ret) {
>                 dev_err(dev,
>                         "Failed to read the efuse value from syscon: %d\n",
>                         ret);
> @@ -158,7 +230,17 @@ static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
>
>         ret = regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,
>                           &revision);
> -       if (ret) {
> +       if (ret == -EIO) {
> +               /* not a syscon register! */
> +               void __iomem *regs = ioremap(OMAP3_SYSCON_BASE +
> +                               opp_data->soc_data->rev_offset, 4);
> +
> +               if (!regs)
> +                       return -ENOMEM;
> +               revision = readl(regs);
> +               iounmap(regs);
> +               }
> +       else if (ret) {
>                 dev_err(dev,
>                         "Failed to read the revision number from syscon: %d\n",
>                         ret);
> @@ -190,6 +272,11 @@ static const struct of_device_id ti_cpufreq_of_match[] = {
>         { .compatible = "ti,am33xx", .data = &am3x_soc_data, },
>         { .compatible = "ti,am43", .data = &am4x_soc_data, },
>         { .compatible = "ti,dra7", .data = &dra7_soc_data },
> +       { .compatible = "ti,omap34xx", .data = &omap34xx_soc_data, },
> +       { .compatible = "ti,omap36xx", .data = &omap36xx_soc_data, },
> +       /* legacy */
> +       { .compatible = "ti,omap3430", .data = &omap34xx_soc_data, },
> +       { .compatible = "ti,omap3630", .data = &omap36xx_soc_data, },
>         {},
>  };
>
> --
> 2.19.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
