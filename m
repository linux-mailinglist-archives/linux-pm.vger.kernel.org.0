Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E6936A2B6
	for <lists+linux-pm@lfdr.de>; Sat, 24 Apr 2021 20:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhDXS6d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Apr 2021 14:58:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51686 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhDXS6c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Apr 2021 14:58:32 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 260D11F4310A
Message-ID: <7786c76ae276ee7bb5885592231a8089c9bfbdf9.camel@collabora.com>
Subject: Re: [PATCH 2/2] thermal/rockchip: Support RK3568 SoCs in the
 thermal driver
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Finley Xiao <finley.xiao@rock-chips.com>, kernel@collabora.com
Date:   Sat, 24 Apr 2021 15:57:43 -0300
In-Reply-To: <ef9140da-c996-512a-b459-53461bd8198e@linaro.org>
References: <20210421200445.32977-1-ezequiel@collabora.com>
         <20210421200445.32977-2-ezequiel@collabora.com>
         <ef9140da-c996-512a-b459-53461bd8198e@linaro.org>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

Thanks for the review.

On Sat, 2021-04-24 at 16:14 +0200, Daniel Lezcano wrote:
> On 21/04/2021 22:04, Ezequiel Garcia wrote:
> > From: Finley Xiao <finley.xiao@rock-chips.com>
> > 
> > The RK3568 SoCs have two Temperature Sensors, channel 0 is for CPU,
> > channel 1 is for GPU.
> > 
> > Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > ---
> >  drivers/thermal/rockchip_thermal.c | 107 +++++++++++++++++++++++++++++
> >  1 file changed, 107 insertions(+)
> > 
> > diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> > index aa9e0e31ef98..8e26f2685003 100644
> > --- a/drivers/thermal/rockchip_thermal.c
> > +++ b/drivers/thermal/rockchip_thermal.c
> > @@ -211,7 +211,11 @@ struct rockchip_thermal_data {
> >  #define TSADCV3_AUTO_PERIOD_TIME               1875 /* 2.5ms */
> >  #define TSADCV3_AUTO_PERIOD_HT_TIME            1875 /* 2.5ms */
> >  
> > +#define TSADCV5_AUTO_PERIOD_TIME               1622 /* 2.5ms */
> > +#define TSADCV5_AUTO_PERIOD_HT_TIME            1622 /* 2.5ms */
> > +
> >  #define TSADCV2_USER_INTER_PD_SOC              0x340 /* 13 clocks */
> > +#define TSADCV5_USER_INTER_PD_SOC              0xfc0 /* 97us, at least 90us */
> >  
> >  #define GRF_SARADC_TESTBIT                     0x0e644
> >  #define GRF_TSADC_TESTBIT_L                    0x0e648
> > @@ -219,6 +223,12 @@ struct rockchip_thermal_data {
> >  
> >  #define PX30_GRF_SOC_CON2                      0x0408
> >  
> > +#define RK3568_GRF_TSADC_CON                   0x0600
> > +#define RK3568_GRF_TSADC_ANA_REG0              (0x10001 << 0)
> > +#define RK3568_GRF_TSADC_ANA_REG1              (0x10001 << 1)
> > +#define RK3568_GRF_TSADC_ANA_REG2              (0x10001 << 2)
> > +#define RK3568_GRF_TSADC_TSEN                  (0x10001 << 8)
> > +
> >  #define GRF_SARADC_TESTBIT_ON                  (0x10001 << 2)
> >  #define GRF_TSADC_TESTBIT_H_ON                 (0x10001 << 2)
> >  #define GRF_TSADC_VCM_EN_L                     (0x10001 << 7)
> > @@ -474,6 +484,45 @@ static const struct tsadc_table rk3399_code_table[] = {
> >         {TSADCV3_DATA_MASK, 125000},
> >  };
> >  
> > +static const struct tsadc_table rk3568_code_table[] = {
> > +       {0, -40000},
> > +       {1584, -40000},
> > +       {1620, -35000},
> > +       {1652, -30000},
> > +       {1688, -25000},
> > +       {1720, -20000},
> > +       {1756, -15000},
> > +       {1788, -10000},
> > +       {1824, -5000},
> > +       {1856, 0},
> > +       {1892, 5000},
> > +       {1924, 10000},
> > +       {1956, 15000},
> > +       {1992, 20000},
> > +       {2024, 25000},
> > +       {2060, 30000},
> > +       {2092, 35000},
> > +       {2128, 40000},
> > +       {2160, 45000},
> > +       {2196, 50000},
> > +       {2228, 55000},
> > +       {2264, 60000},
> > +       {2300, 65000},
> > +       {2332, 70000},
> > +       {2368, 75000},
> > +       {2400, 80000},
> > +       {2436, 85000},
> > +       {2468, 90000},
> > +       {2500, 95000},
> > +       {2536, 100000},
> > +       {2572, 105000},
> > +       {2604, 110000},
> > +       {2636, 115000},
> > +       {2672, 120000},
> > +       {2704, 125000},
> > +       {TSADCV2_DATA_MASK, 125000},
> > +};
> > +
> >  static u32 rk_tsadcv2_temp_to_code(const struct chip_tsadc_table *table,
> >                                    int temp)
> >  {
> > @@ -701,6 +750,35 @@ static void rk_tsadcv4_initialize(struct regmap *grf, void __iomem *regs,
> >         regmap_write(grf, PX30_GRF_SOC_CON2, GRF_CON_TSADC_CH_INV);
> >  }
> >  
> > +static void rk_tsadcv7_initialize(struct regmap *grf, void __iomem *regs,
> > +                                 enum tshut_polarity tshut_polarity)
> > +{
> > +       writel_relaxed(TSADCV5_USER_INTER_PD_SOC, regs + TSADCV2_USER_CON);
> > +       writel_relaxed(TSADCV5_AUTO_PERIOD_TIME, regs + TSADCV2_AUTO_PERIOD);
> > +       writel_relaxed(TSADCV2_HIGHT_INT_DEBOUNCE_COUNT,
> > +                      regs + TSADCV2_HIGHT_INT_DEBOUNCE);
> > +       writel_relaxed(TSADCV5_AUTO_PERIOD_HT_TIME,
> > +                      regs + TSADCV2_AUTO_PERIOD_HT);
> > +       writel_relaxed(TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT,
> > +                      regs + TSADCV2_HIGHT_TSHUT_DEBOUNCE);
> > +
> > +       if (tshut_polarity == TSHUT_HIGH_ACTIVE)
> > +               writel_relaxed(0U | TSADCV2_AUTO_TSHUT_POLARITY_HIGH,
> > +                              regs + TSADCV2_AUTO_CON);
> > +       else
> > +               writel_relaxed(0U & ~TSADCV2_AUTO_TSHUT_POLARITY_HIGH,
> > +                              regs + TSADCV2_AUTO_CON);
> > +
> > +       if (!IS_ERR(grf)) {
> 
> That is strange to do this check with a parameter. Is the sensor
> functional if the regmap failed ?
> 

Indeed, it seems it's optional. The same check is in rk_tsadcv3_initialize,
and also in rockchip_configure_from_dt():

        /* The tsadc wont to handle the error in here since some SoCs didn't     
         * need this property.                                                   
         */                                                                      
        thermal->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");      
        if (IS_ERR(thermal->grf))                                                
                dev_warn(dev, "Missing rockchip,grf property\n"); 

But I completely agree it looks strange without a comment,
might be better to add one.

> > +               regmap_write(grf, RK3568_GRF_TSADC_CON, RK3568_GRF_TSADC_TSEN);
> > +               udelay(15);
> > +               regmap_write(grf, RK3568_GRF_TSADC_CON, RK3568_GRF_TSADC_ANA_REG0);
> > +               regmap_write(grf, RK3568_GRF_TSADC_CON, RK3568_GRF_TSADC_ANA_REG1);
> > +               regmap_write(grf, RK3568_GRF_TSADC_CON, RK3568_GRF_TSADC_ANA_REG2);
> > +               usleep_range(100, 200);
> 
> Is it possible to put a comment on why these delays are necessary (if
> you have the info) ?
> 

Sure, I'll add a comment there. It is described in RK3568 Part1 TRM,
section 18.5.2.

Thanks,
Ezequiel

