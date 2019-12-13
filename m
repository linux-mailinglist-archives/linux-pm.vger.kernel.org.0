Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 725B211DED9
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2019 08:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfLMHr7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Dec 2019 02:47:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38031 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfLMHr6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Dec 2019 02:47:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so5538659wrh.5
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2019 23:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TA8xEFgi43v/06RV/YGzWmDbl5lIq5WRTuhPkCwZvu0=;
        b=vX78r2mH9UPxVjHkyG4FvT7BMYljWMJ8Od+JNnLdiHTafzUADVBNczlCE5IIKUDHTb
         COCXs71RF3ASXSsN+9yclHnO7cx/3bWYJDOUWQRsQ3HyJeysEvqzyqmpJ73ZWtAG+iAX
         7fd6b6qXVnVbUH11LgESqQxv6AYwxLylXClS7Uk6wYsdZICka4nuOiBWrZ0GrbTI6UHV
         Tqxq3B4hfcp+CV1sBzQN2C+xiLCRHsbvkXdTUJPFMSpEpsH5/Pa31VoqbxpjSRQbbF9p
         Q681ggF2/1kGwBj/HdsvXXZYpeJutDh6MrH5wXduufaIT2MeGicirbuB+2L3aR8EclvE
         Hw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TA8xEFgi43v/06RV/YGzWmDbl5lIq5WRTuhPkCwZvu0=;
        b=nXTLmnrlQ9q+PAzauM+rJ/NCEf4jhCC/XEblIKW1m3qSdModA5AM2R5xs22DswCiKY
         xF7jcI8qXkQ/zoyKTJYyG2nTtmlM+Byx1OF03liYWVc5Bl7NfMpZsmeiDzas71b/swf6
         7kkIMwsnzeS2e57cXsYD5ndaSlfiWV4rWzkGGq9hseVlpIPqS2rg6BgN2QUHFWeCxbsI
         LhmWEFOIxNN3tMWI6n+JSINXAAJQzJx0/l+sHmmtnRtppaKBhC5zhtwIAfhqS6dyUzkC
         XHq815Zen2L3VWS0+ipPkNw55ukdbAWB4VHo7dx4sRemFVEmr+uYOuIAEOJ5SOKWPjRx
         gY6w==
X-Gm-Message-State: APjAAAXExDVugzuhw+yDSoPXvFAxR5TGcSfwCT7MsBE087Ly60rL3J/L
        uvVTGAR45VBWLcZl9DIEJTjxEg==
X-Google-Smtp-Source: APXvYqyTANFO6X8pq5XqlNfTnrVFRpCj1F9DnQZkzUnj1+x1hq3RWW3jrx/OCbr9B/djFDKT6Mw0Vg==
X-Received: by 2002:adf:ef03:: with SMTP id e3mr11477900wro.216.1576223273744;
        Thu, 12 Dec 2019 23:47:53 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:7810:4d25:def1:739f? ([2a01:e34:ed2f:f020:7810:4d25:def1:739f])
        by smtp.googlemail.com with ESMTPSA id z20sm8140655wmi.45.2019.12.12.23.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 23:47:53 -0800 (PST)
Subject: Re: [EXT] [PATCH v8 08/12] thermal: qoriq: Convert driver to use
 regmap API
To:     Andy Tang <andy.tang@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Anson Huang <anson.huang@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191210164153.10463-1-andrew.smirnov@gmail.com>
 <20191210164153.10463-9-andrew.smirnov@gmail.com>
 <VI1PR04MB4333FC0E82562CC8D5AE1492F3540@VI1PR04MB4333.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <82dc530b-6e7a-f754-bd75-f923d85b16b5@linaro.org>
Date:   Fri, 13 Dec 2019 08:47:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB4333FC0E82562CC8D5AE1492F3540@VI1PR04MB4333.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/12/2019 07:16, Andy Tang wrote:
> Hi Andrew,
> 
> I failed to apply your patch. Could you please rebase it to the latest code and send me the patch directly?

Hi Andy,

I'm taking care of the series.

Thanks

  -- Daniel


>> -----Original Message-----
>> From: Andrey Smirnov <andrew.smirnov@gmail.com>
>> Sent: 2019Äê12ÔÂ11ÈÕ 0:42
>> To: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>; Andy Tang
>> <andy.tang@nxp.com>; Anson Huang <anson.huang@nxp.com>; Lucas Stach
>> <l.stach@pengutronix.de>; Chris Healy <cphealy@gmail.com>; Eduardo
>> Valentin <edubezval@gmail.com>; Angus Ainslie <angus@akkea.ca>;
>> dl-linux-imx <linux-imx@nxp.com>; linux-pm@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Subject: [EXT] [PATCH v8 08/12] thermal: qoriq: Convert driver to use regmap
>> API
>>
>> Caution: EXT Email
>>
>> Convert driver to use regmap API, drop custom LE/BE IO helpers and simplify
>> bit manipulation using regmap_update_bits(). This also allows us to convert
>> some register initialization to use loops and adds convenient debug access to
>> TMU registers via debugfs.
>>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Tested-by: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Chris Healy <cphealy@gmail.com>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
>> Cc: linux-imx@nxp.com
>> Cc: linux-pm@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>
>> Yuantian, Anson:
>>
>> I don't have access to Layerscape HW that has v2 register layout, so if you
>> could give this patch a try and verify that I got the 'qoriq_yes_ranges' right,
>> I'd really appreciate it.
>>
>> Thanks,
>> Andrey Smirnov
>>
>>  drivers/thermal/qoriq_thermal.c | 228 ++++++++++++++------------------
>>  1 file changed, 98 insertions(+), 130 deletions(-)
>>
>> diff --git a/drivers/thermal/qoriq_thermal.c
>> b/drivers/thermal/qoriq_thermal.c index 11749c673b3b..6227c940b9b0
>> 100644
>> --- a/drivers/thermal/qoriq_thermal.c
>> +++ b/drivers/thermal/qoriq_thermal.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/io.h>
>>  #include <linux/of.h>
>>  #include <linux/of_address.h>
>> +#include <linux/regmap.h>
>>  #include <linux/thermal.h>
>>
>>  #include "thermal_core.h"
>> @@ -24,85 +25,35 @@
>>  #define TMU_VER1               0x1
>>  #define TMU_VER2               0x2
>>
>> -/*
>> - * QorIQ TMU Registers
>> - */
>> -struct qoriq_tmu_site_regs {
>> -       u32 tritsr;             /* Immediate Temperature Site Register
>> */
>> -       u32 tratsr;             /* Average Temperature Site Register */
>> -       u8 res0[0x8];
>> -};
>> +#define REGS_TMR       0x000   /* Mode Register */
>> +#define TMR_DISABLE    0x0
>> +#define TMR_ME         0x80000000
>> +#define TMR_ALPF       0x0c000000
>>
>> -struct qoriq_tmu_regs_v1 {
>> -       u32 tmr;                /* Mode Register */
>> -       u32 tsr;                /* Status Register */
>> -       u32 tmtmir;             /* Temperature measurement interval
>> Register */
>> -       u8 res0[0x14];
>> -       u32 tier;               /* Interrupt Enable Register */
>> -       u32 tidr;               /* Interrupt Detect Register */
>> -       u32 tiscr;              /* Interrupt Site Capture Register */
>> -       u32 ticscr;             /* Interrupt Critical Site Capture Register
>> */
>> -       u8 res1[0x10];
>> -       u32 tmhtcrh;            /* High Temperature Capture Register
>> */
>> -       u32 tmhtcrl;            /* Low Temperature Capture Register */
>> -       u8 res2[0x8];
>> -       u32 tmhtitr;            /* High Temperature Immediate
>> Threshold */
>> -       u32 tmhtatr;            /* High Temperature Average Threshold
>> */
>> -       u32 tmhtactr;   /* High Temperature Average Crit Threshold */
>> -       u8 res3[0x24];
>> -       u32 ttcfgr;             /* Temperature Configuration Register
>> */
>> -       u32 tscfgr;             /* Sensor Configuration Register */
>> -       u8 res4[0x78];
>> -       struct qoriq_tmu_site_regs site[SITES_MAX];
>> -       u8 res5[0x9f8];
>> -       u32 ipbrr0;             /* IP Block Revision Register 0 */
>> -       u32 ipbrr1;             /* IP Block Revision Register 1 */
>> -       u8 res6[0x310];
>> -       u32 ttrcr[4];           /* Temperature Range Control Register */
>> -};
>> +#define REGS_TMTMIR    0x008   /* Temperature measurement
>> interval Register */
>> +#define TMTMIR_DEFAULT 0x0000000f
>>
>> -struct qoriq_tmu_regs_v2 {
>> -       u32 tmr;                /* Mode Register */
>> -       u32 tsr;                /* Status Register */
>> -       u32 tmsr;               /* monitor site register */
>> -       u32 tmtmir;             /* Temperature measurement interval
>> Register */
>> -       u8 res0[0x10];
>> -       u32 tier;               /* Interrupt Enable Register */
>> -       u32 tidr;               /* Interrupt Detect Register */
>> -       u8 res1[0x8];
>> -       u32 tiiscr;             /* interrupt immediate site capture
>> register */
>> -       u32 tiascr;             /* interrupt average site capture register
>> */
>> -       u32 ticscr;             /* Interrupt Critical Site Capture Register
>> */
>> -       u32 res2;
>> -       u32 tmhtcr;             /* monitor high temperature capture
>> register */
>> -       u32 tmltcr;             /* monitor low temperature capture
>> register */
>> -       u32 tmrtrcr;    /* monitor rising temperature rate capture
>> register */
>> -       u32 tmftrcr;    /* monitor falling temperature rate capture
>> register */
>> -       u32 tmhtitr;    /* High Temperature Immediate Threshold */
>> -       u32 tmhtatr;    /* High Temperature Average Threshold */
>> -       u32 tmhtactr;   /* High Temperature Average Crit Threshold */
>> -       u32 res3;
>> -       u32 tmltitr;    /* monitor low temperature immediate threshold
>> */
>> -       u32 tmltatr;    /* monitor low temperature average threshold
>> register */
>> -       u32 tmltactr;   /* monitor low temperature average critical
>> threshold */
>> -       u32 res4;
>> -       u32 tmrtrctr;   /* monitor rising temperature rate critical
>> threshold */
>> -       u32 tmftrctr;   /* monitor falling temperature rate critical
>> threshold*/
>> -       u8 res5[0x8];
>> -       u32 ttcfgr;     /* Temperature Configuration Register */
>> -       u32 tscfgr;     /* Sensor Configuration Register */
>> -       u8 res6[0x78];
>> -       struct qoriq_tmu_site_regs site[SITES_MAX];
>> -       u8 res7[0x9f8];
>> -       u32 ipbrr0;             /* IP Block Revision Register 0 */
>> -       u32 ipbrr1;             /* IP Block Revision Register 1 */
>> -       u8 res8[0x300];
>> -       u32 teumr0;
>> -       u32 teumr1;
>> -       u32 teumr2;
>> -       u32 res9;
>> -       u32 ttrcr[4];   /* Temperature Range Control Register */
>> -};
>> +#define REGS_V2_TMSR   0x008   /* monitor site register */
>> +
>> +#define REGS_V2_TMTMIR 0x00c   /* Temperature measurement interval
>> Register */
>> +
>> +#define REGS_TIER      0x020   /* Interrupt Enable Register */
>> +#define TIER_DISABLE   0x0
>> +
>> +
>> +#define REGS_TTCFGR    0x080   /* Temperature Configuration Register
>> */
>> +#define REGS_TSCFGR    0x084   /* Sensor Configuration Register */
>> +
>> +#define REGS_TRITSR(n) (0x100 + 16 * (n)) /* Immediate Temperature
>> +                                           * Site Register
>> +                                           */ #define
>> REGS_TTRnCR(n)
>> +(0xf10 + 4 * (n)) /* Temperature Range n
>> +                                          * Control Register
>> +                                          */
>> +#define REGS_IPBRR(n)          (0xbf8 + 4 * (n)) /* IP Block Revision
>> +                                                  * Register n
>> +                                                  */
>> +#define REGS_V2_TEUMR(n)       (0xf00 + 4 * (n))
>>
>>  /*
>>   * Thermal zone data
>> @@ -113,10 +64,8 @@ struct qoriq_sensor {
>>
>>  struct qoriq_tmu_data {
>>         int ver;
>> -       struct qoriq_tmu_regs_v1 __iomem *regs;
>> -       struct qoriq_tmu_regs_v2 __iomem *regs_v2;
>> +       struct regmap *regmap;
>>         struct clk *clk;
>> -       bool little_endian;
>>         struct qoriq_sensor     sensor[SITES_MAX];
>>  };
>>
>> @@ -125,29 +74,13 @@ static struct qoriq_tmu_data
>> *qoriq_sensor_to_data(struct qoriq_sensor *s)
>>         return container_of(s, struct qoriq_tmu_data, sensor[s->id]);  }
>>
>> -static void tmu_write(struct qoriq_tmu_data *p, u32 val, void __iomem
>> *addr) -{
>> -       if (p->little_endian)
>> -               iowrite32(val, addr);
>> -       else
>> -               iowrite32be(val, addr);
>> -}
>> -
>> -static u32 tmu_read(struct qoriq_tmu_data *p, void __iomem *addr) -{
>> -       if (p->little_endian)
>> -               return ioread32(addr);
>> -       else
>> -               return ioread32be(addr);
>> -}
>> -
>>  static int tmu_get_temp(void *p, int *temp)  {
>>         struct qoriq_sensor *qsensor = p;
>>         struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
>>         u32 val;
>>
>> -       val = tmu_read(qdata, &qdata->regs->site[qsensor->id].tritsr);
>> +       regmap_read(qdata->regmap, REGS_TRITSR(qsensor->id), &val);
>>         *temp = (val & 0xff) * 1000;
>>
>>         return 0;
>> @@ -189,12 +122,12 @@ static int qoriq_tmu_register_tmu_zone(struct
>> device *dev,
>>         /* Enable monitoring */
>>         if (sites != 0) {
>>                 if (qdata->ver == TMU_VER1) {
>> -                       tmu_write(qdata, sites | TMR_ME | TMR_ALPF,
>> -                                       &qdata->regs->tmr);
>> +                       regmap_write(qdata->regmap, REGS_TMR,
>> +                                    sites | TMR_ME | TMR_ALPF);
>>                 } else {
>> -                       tmu_write(qdata, sites,
>> &qdata->regs_v2->tmsr);
>> -                       tmu_write(qdata, TMR_ME | TMR_ALPF_V2,
>> -                                       &qdata->regs_v2->tmr);
>> +                       regmap_write(qdata->regmap,
>> REGS_V2_TMSR, sites);
>> +                       regmap_write(qdata->regmap, REGS_TMR,
>> +                                    TMR_ME | TMR_ALPF_V2);
>>                 }
>>         }
>>
>> @@ -223,7 +156,7 @@ static int qoriq_tmu_calibration(struct device *dev,
>>
>>         /* Init temperature range registers */
>>         for (i = 0; i < len; i++)
>> -               tmu_write(data, range[i], &data->regs->ttrcr[i]);
>> +               regmap_write(data->regmap, REGS_TTRnCR(i), range[i]);
>>
>>         calibration = of_get_property(np, "fsl,tmu-calibration", &len);
>>         if (calibration == NULL || len % 8) { @@ -233,9 +166,9 @@ static
>> int qoriq_tmu_calibration(struct device *dev,
>>
>>         for (i = 0; i < len; i += 8, calibration += 2) {
>>                 val = of_read_number(calibration, 1);
>> -               tmu_write(data, val, &data->regs->ttcfgr);
>> +               regmap_write(data->regmap, REGS_TTCFGR, val);
>>                 val = of_read_number(calibration + 1, 1);
>> -               tmu_write(data, val, &data->regs->tscfgr);
>> +               regmap_write(data->regmap, REGS_TSCFGR, val);
>>         }
>>
>>         return 0;
>> @@ -244,20 +177,40 @@ static int qoriq_tmu_calibration(struct device *dev,
>> static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)  {
>>         /* Disable interrupt, using polling instead */
>> -       tmu_write(data, TIER_DISABLE, &data->regs->tier);
>> +       regmap_write(data->regmap, REGS_TIER, TIER_DISABLE);
>>
>>         /* Set update_interval */
>> +
>>         if (data->ver == TMU_VER1) {
>> -               tmu_write(data, TMTMIR_DEFAULT,
>> &data->regs->tmtmir);
>> +               regmap_write(data->regmap, REGS_TMTMIR,
>> TMTMIR_DEFAULT);
>>         } else {
>> -               tmu_write(data, TMTMIR_DEFAULT,
>> &data->regs_v2->tmtmir);
>> -               tmu_write(data, TEUMR0_V2, &data->regs_v2->teumr0);
>> +               regmap_write(data->regmap, REGS_V2_TMTMIR,
>> TMTMIR_DEFAULT);
>> +               regmap_write(data->regmap, REGS_V2_TEUMR(0),
>> TEUMR0_V2);
>>         }
>>
>>         /* Disable monitoring */
>> -       tmu_write(data, TMR_DISABLE, &data->regs->tmr);
>> +       regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
>>  }
>>
>> +static const struct regmap_range qoriq_yes_ranges[] = {
>> +       regmap_reg_range(REGS_TMR, REGS_TSCFGR),
>> +       regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(3)),
>> +       regmap_reg_range(REGS_V2_TEUMR(0), REGS_V2_TEUMR(2)),
>> +       regmap_reg_range(REGS_IPBRR(0), REGS_IPBRR(1)),
>> +       /* Read only registers below */
>> +       regmap_reg_range(REGS_TRITSR(0), REGS_TRITSR(15)), };
>> +
>> +static const struct regmap_access_table qoriq_wr_table = {
>> +       .yes_ranges     = qoriq_yes_ranges,
>> +       .n_yes_ranges   = ARRAY_SIZE(qoriq_yes_ranges) - 1,
>> +};
>> +
>> +static const struct regmap_access_table qoriq_rd_table = {
>> +       .yes_ranges     = qoriq_yes_ranges,
>> +       .n_yes_ranges   = ARRAY_SIZE(qoriq_yes_ranges),
>> +};
>> +
>>  static int qoriq_tmu_probe(struct platform_device *pdev)  {
>>         int ret;
>> @@ -265,18 +218,37 @@ static int qoriq_tmu_probe(struct platform_device
>> *pdev)
>>         struct qoriq_tmu_data *data;
>>         struct device_node *np = pdev->dev.of_node;
>>         struct device *dev = &pdev->dev;
>> +       const bool little_endian = of_property_read_bool(np,
>> "little-endian");
>> +       const enum regmap_endian format_endian =
>> +               little_endian ? REGMAP_ENDIAN_LITTLE :
>> REGMAP_ENDIAN_BIG;
>> +       const struct regmap_config regmap_config = {
>> +               .reg_bits               = 32,
>> +               .val_bits               = 32,
>> +               .reg_stride             = 4,
>> +               .rd_table               = &qoriq_rd_table,
>> +               .wr_table               = &qoriq_wr_table,
>> +               .val_format_endian      = format_endian,
>> +               .max_register           = SZ_4K,
>> +       };
>> +       void __iomem *base;
>>
>>         data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
>>                             GFP_KERNEL);
>>         if (!data)
>>                 return -ENOMEM;
>>
>> -       data->little_endian = of_property_read_bool(np, "little-endian");
>> -
>> -       data->regs = devm_platform_ioremap_resource(pdev, 0);
>> -       if (IS_ERR(data->regs)) {
>> +       base = devm_platform_ioremap_resource(pdev, 0);
>> +       ret = PTR_ERR_OR_ZERO(base);
>> +       if (ret) {
>>                 dev_err(dev, "Failed to get memory region\n");
>> -               return PTR_ERR(data->regs);
>> +               return ret;
>> +       }
>> +
>> +       data->regmap = devm_regmap_init_mmio(dev, base,
>> &regmap_config);
>> +       ret = PTR_ERR_OR_ZERO(data->regmap);
>> +       if (ret) {
>> +               dev_err(dev, "Failed to init regmap (%d)\n", ret);
>> +               return ret;
>>         }
>>
>>         data->clk = devm_clk_get_optional(dev, NULL); @@ -290,10
>> +262,12 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>>         }
>>
>>         /* version register offset at: 0xbf8 on both v1 and v2 */
>> -       ver = tmu_read(data, &data->regs->ipbrr0);
>> +       ret = regmap_read(data->regmap, REGS_IPBRR(0), &ver);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Failed to read IP block version\n");
>> +               return ret;
>> +       }
>>         data->ver = (ver >> 8) & 0xff;
>> -       if (data->ver == TMU_VER2)
>> -               data->regs_v2 = (void __iomem *)data->regs;
>>
>>         qoriq_tmu_init_device(data);    /* TMU initialization */
>>
>> @@ -323,7 +297,7 @@ static int qoriq_tmu_remove(struct platform_device
>> *pdev)
>>         struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
>>
>>         /* Disable monitoring */
>> -       tmu_write(data, TMR_DISABLE, &data->regs->tmr);
>> +       regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
>>
>>         clk_disable_unprepare(data->clk);
>>
>> @@ -332,13 +306,12 @@ static int qoriq_tmu_remove(struct
>> platform_device *pdev)
>>
>>  static int __maybe_unused qoriq_tmu_suspend(struct device *dev)  {
>> -       u32 tmr;
>>         struct qoriq_tmu_data *data = dev_get_drvdata(dev);
>> +       int ret;
>>
>> -       /* Disable monitoring */
>> -       tmr = tmu_read(data, &data->regs->tmr);
>> -       tmr &= ~TMR_ME;
>> -       tmu_write(data, tmr, &data->regs->tmr);
>> +       ret = regmap_update_bits(data->regmap, REGS_TMR, TMR_ME,
>> 0);
>> +       if (ret)
>> +               return ret;
>>
>>         clk_disable_unprepare(data->clk);
>>
>> @@ -347,7 +320,6 @@ static int __maybe_unused
>> qoriq_tmu_suspend(struct device *dev)
>>
>>  static int __maybe_unused qoriq_tmu_resume(struct device *dev)  {
>> -       u32 tmr;
>>         int ret;
>>         struct qoriq_tmu_data *data = dev_get_drvdata(dev);
>>
>> @@ -356,11 +328,7 @@ static int __maybe_unused
>> qoriq_tmu_resume(struct device *dev)
>>                 return ret;
>>
>>         /* Enable monitoring */
>> -       tmr = tmu_read(data, &data->regs->tmr);
>> -       tmr |= TMR_ME;
>> -       tmu_write(data, tmr, &data->regs->tmr);
>> -
>> -       return 0;
>> +       return regmap_update_bits(data->regmap, REGS_TMR, TMR_ME,
>> + TMR_ME);
>>  }
>>
>>  static SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
>> --
>> 2.21.0
> 


-- 
 <http://www.linaro.org/> Linaro.org ©¦ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

