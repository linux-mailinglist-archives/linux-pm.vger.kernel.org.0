Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6D8BBF69
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 02:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391686AbfIXAkm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 20:40:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:18971 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbfIXAkm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Sep 2019 20:40:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 17:40:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,542,1559545200"; 
   d="scan'208";a="188299941"
Received: from pengfeiw-mobl.ccr.corp.intel.com ([10.249.170.134])
  by fmsmga008.fm.intel.com with ESMTP; 23 Sep 2019 17:40:39 -0700
Message-ID: <d4c45941ef2ebbc4ac11ce199e3e8ae527a34df9.camel@intel.com>
Subject: Re: [PATCH] thermal: qoriq: add thermal monitor unit version 2
 support
From:   Zhang Rui <rui.zhang@intel.com>
To:     Andy Tang <andy.tang@nxp.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 24 Sep 2019 08:40:38 +0800
In-Reply-To: <VI1PR04MB433332B34EF758457365AE91F3850@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20190604025114.46085-1-andy.tang@nxp.com>
         <VI1PR04MB433382A830BE0857134ABF5BF3D50@VI1PR04MB4333.eurprd04.prod.outlook.com>
         <VI1PR04MB4333D4FAA6F25AD30CADF0D4F3A20@VI1PR04MB4333.eurprd04.prod.outlook.com>
         <VI1PR04MB433332B34EF758457365AE91F3850@VI1PR04MB4333.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2019-09-23 at 09:24 +0000, Andy Tang wrote:
> Hi Rui, Edubezval,
> 
> Would you please review this patch?
> 
CC Anson Huang.
I'd prefer all the qoriq thermal patches go through his review first.

thanks,
rui

> BR,
> Andy
> 
> > -----Original Message-----
> > From: Andy Tang
> > Sent: 2019年8月29日 16:38
> > To: 'edubezval@gmail.com' <edubezval@gmail.com>; 
> > 'rui.zhang@intel.com'
> > <rui.zhang@intel.com>
> > Cc: 'daniel.lezcano@linaro.org' <daniel.lezcano@linaro.org>; Leo Li
> > <leoyang.li@nxp.com>; 'linux-pm@vger.kernel.org'
> > <linux-pm@vger.kernel.org>; 'linux-kernel@vger.kernel.org'
> > <linux-kernel@vger.kernel.org>
> > Subject: RE: [PATCH] thermal: qoriq: add thermal monitor unit
> > version 2
> > support
> > 
> > Hi Rui, Edubezval,
> > 
> > Almost three monthes passed, I have not got your comments from you.
> > Could you please take a look at this patch?
> > 
> > BR,
> > Andy
> > 
> > > -----Original Message-----
> > > From: Andy Tang
> > > Sent: 2019年8月6日 10:57
> > > To: edubezval@gmail.com; rui.zhang@intel.com
> > > Cc: daniel.lezcano@linaro.org; Leo Li <leoyang.li@nxp.com>;
> > > linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: RE: [PATCH] thermal: qoriq: add thermal monitor unit
> > > version
> > > 2 support
> > > 
> > > Any comments?
> > > 
> > > BR,
> > > Andy
> > > 
> > > > -----Original Message-----
> > > > From: Yuantian Tang <andy.tang@nxp.com>
> > > > Sent: 2019年6月4日 10:51
> > > > To: edubezval@gmail.com; rui.zhang@intel.com
> > > > Cc: daniel.lezcano@linaro.org; Leo Li <leoyang.li@nxp.com>;
> > > > linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; Andy
> > > > Tang
> > > > <andy.tang@nxp.com>
> > > > Subject: [PATCH] thermal: qoriq: add thermal monitor unit
> > > > version 2
> > > > support
> > > > 
> > > > Thermal Monitor Unit v2 is introduced on new Layscape SoC.
> > > > Compared to v1, TMUv2 has a little different register layout
> > > > and
> > > > digital output is fairly linear.
> > > > 
> > > > Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> > > > ---
> > > >  drivers/thermal/qoriq_thermal.c | 122
> > > > +++++++++++++++++++++++++-------
> > > >  1 file changed, 98 insertions(+), 24 deletions(-)
> > > > 
> > > > diff --git a/drivers/thermal/qoriq_thermal.c
> > > > b/drivers/thermal/qoriq_thermal.c index
> > > > 3b5f5b3fb1bc..0df6dfddf804
> > > > 100644
> > > > --- a/drivers/thermal/qoriq_thermal.c
> > > > +++ b/drivers/thermal/qoriq_thermal.c
> > > > @@ -13,6 +13,15 @@
> > > >  #include "thermal_core.h"
> > > > 
> > > >  #define SITES_MAX	16
> > > > +#define TMR_DISABLE	0x0
> > > > +#define TMR_ME		0x80000000
> > > > +#define TMR_ALPF	0x0c000000
> > > > +#define TMR_ALPF_V2	0x03000000
> > > > +#define TMTMIR_DEFAULT	0x0000000f
> > > > +#define TIER_DISABLE	0x0
> > > > +#define TEUMR0_V2	0x51009C00
> > > > +#define TMU_VER1	0x1
> > > > +#define TMU_VER2	0x2
> > > > 
> > > >  /*
> > > >   * QorIQ TMU Registers
> > > > @@ -23,17 +32,55 @@ struct qoriq_tmu_site_regs {
> > > >  	u8 res0[0x8];
> > > >  };
> > > > 
> > > > -struct qoriq_tmu_regs {
> > > > +struct qoriq_tmu_regs_v2 {
> > > > +	u32 tmr;		/* Mode Register */
> > > > +	u32 tsr;		/* Status Register */
> > > > +	u32 tmsr;		/* monitor site register */
> > > > +	u32 tmtmir;		/* Temperature measurement
> > > > interval Register
> > 
> > */
> > > > +	u8 res0[0x10];
> > > > +	u32 tier;		/* Interrupt Enable Register */
> > > > +	u32 tidr;		/* Interrupt Detect Register */
> > > > +	u8 res1[0x8];
> > > > +	u32 tiiscr;		/* interrupt immediate site
> > > > capture register */
> > > > +	u32 tiascr;		/* interrupt average site
> > > > capture register */
> > > > +	u32 ticscr;		/* Interrupt Critical Site
> > > > Capture Register */
> > > > +	u32 res2;
> > > > +	u32 tmhtcr;		/* monitor high temperature
> > > > capture register */
> > > > +	u32 tmltcr;		/* monitor low temperature
> > > > capture register */
> > > > +	u32 tmrtrcr;	/* monitor rising temperature rate
> > > > capture register
> > 
> > */
> > > > +	u32 tmftrcr;	/* monitor falling temperature rate
> > > > capture register
> > 
> > */
> > > > +	u32 tmhtitr;	/* High Temperature Immediate Threshold
> > > > */
> > > > +	u32 tmhtatr;	/* High Temperature Average Threshold
> > > > */
> > > > +	u32 tmhtactr;	/* High Temperature Average Crit
> > > > Threshold */
> > > > +	u32 res3;
> > > > +	u32 tmltitr;	/* monitor low temperature immediate
> > > > threshold */
> > > > +	u32 tmltatr;	/* monitor low temperature average
> > > > threshold
> > 
> > register */
> > > > +	u32 tmltactr;	/* monitor low temperature average
> > > > critical
> > 
> > threshold */
> > > > +	u32 res4;
> > > > +	u32 tmrtrctr;	/* monitor rising temperature rate
> > > > critical threshold
> > 
> > */
> > > > +	u32 tmftrctr;	/* monitor falling temperature rate
> > > > critical
> > 
> > threshold*/
> > > > +	u8 res5[0x8];
> > > > +	u32 ttcfgr;	/* Temperature Configuration Register
> > > > */
> > > > +	u32 tscfgr;	/* Sensor Configuration Register */
> > > > +	u8 res6[0x78];
> > > > +	struct qoriq_tmu_site_regs site[SITES_MAX];
> > > > +	u8 res7[0x9f8];
> > > > +	u32 ipbrr0;		/* IP Block Revision Register 0
> > > > */
> > > > +	u32 ipbrr1;		/* IP Block Revision Register 1
> > > > */
> > > > +	u8 res8[0x300];
> > > > +	u32 teumr0;
> > > > +	u32 teumr1;
> > > > +	u32 teumr2;
> > > > +	u32 res9;
> > > > +	u32 ttrcr[4];	/* Temperature Range Control Register
> > > > */
> > > > +};
> > > > +
> > > > +struct qoriq_tmu_regs_v1 {
> > > >  	u32 tmr;		/* Mode Register */
> > > > -#define TMR_DISABLE	0x0
> > > > -#define TMR_ME		0x80000000
> > > > -#define TMR_ALPF	0x0c000000
> > > >  	u32 tsr;		/* Status Register */
> > > >  	u32 tmtmir;		/* Temperature measurement
> > > > interval Register
> > 
> > */
> > > > -#define TMTMIR_DEFAULT	0x0000000f
> > > >  	u8 res0[0x14];
> > > >  	u32 tier;		/* Interrupt Enable Register */
> > > > -#define TIER_DISABLE	0x0
> > > >  	u32 tidr;		/* Interrupt Detect Register */
> > > >  	u32 tiscr;		/* Interrupt Site Capture
> > > > Register */
> > > >  	u32 ticscr;		/* Interrupt Critical Site
> > > > Capture Register */
> > > > @@ -53,10 +100,7 @@ struct qoriq_tmu_regs {
> > > >  	u32 ipbrr0;		/* IP Block Revision Register 0
> > > > */
> > > >  	u32 ipbrr1;		/* IP Block Revision Register 1
> > > > */
> > > >  	u8 res6[0x310];
> > > > -	u32 ttr0cr;		/* Temperature Range 0 Control
> > > > Register */
> > > > -	u32 ttr1cr;		/* Temperature Range 1 Control
> > > > Register */
> > > > -	u32 ttr2cr;		/* Temperature Range 2 Control
> > > > Register */
> > > > -	u32 ttr3cr;		/* Temperature Range 3 Control
> > > > Register */
> > > > +	u32 ttrcr[4];		/* Temperature Range Control
> > > > Register */
> > > >  };
> > > > 
> > > >  struct qoriq_tmu_data;
> > > > @@ -71,7 +115,9 @@ struct qoriq_sensor {  };
> > > > 
> > > >  struct qoriq_tmu_data {
> > > > -	struct qoriq_tmu_regs __iomem *regs;
> > > > +	int ver;
> > > > +	struct qoriq_tmu_regs_v1 __iomem *regs;
> > > > +	struct qoriq_tmu_regs_v2 __iomem *regv2;
> > > >  	bool little_endian;
> > > >  	struct qoriq_sensor	*sensor[SITES_MAX];
> > > >  };
> > > > @@ -111,7 +157,7 @@ static const struct
> > > > thermal_zone_of_device_ops
> > > > tmu_tz_ops = {  static int qoriq_tmu_register_tmu_zone(struct
> > > > platform_device *pdev)  {
> > > >  	struct qoriq_tmu_data *qdata =
> > > > platform_get_drvdata(pdev);
> > > > -	int id, sites = 0;
> > > > +	int id, sites = 0, sv2 = 0;
> > > > 
> > > >  	for (id = 0; id < SITES_MAX; id++) {
> > > >  		qdata->sensor[id] = devm_kzalloc(&pdev->dev, @@
> > > > -130,12
> > > > +176,24 @@ static int qoriq_tmu_register_tmu_zone(struct
> > > > +platform_device
> > > > *pdev)
> > > >  				return PTR_ERR(qdata-
> > > > >sensor[id]->tzd);
> > > >  		}
> > > > 
> > > > -		sites |= 0x1 << (15 - id);
> > > > +		if (qdata->ver == TMU_VER1)
> > > > +			sites |= 0x1 << (15 - id);
> > > > +		else
> > > > +			sv2 |= 0x1 << id;
> > > >  	}
> > > > 
> > > >  	/* Enable monitoring */
> > > > -	if (sites != 0)
> > > > -		tmu_write(qdata, sites | TMR_ME | TMR_ALPF,
> > > > &qdata->regs->tmr);
> > > > +	if (qdata->ver == TMU_VER1) {
> > > > +		if (sites != 0)
> > > > +			tmu_write(qdata, sites | TMR_ME |
> > > > TMR_ALPF,
> > > > +					&qdata->regs->tmr);
> > > > +	} else {
> > > > +		if (sv2 != 0) {
> > > > +			tmu_write(qdata, sv2, &qdata->regv2-
> > > > >tmsr);
> > > > +			tmu_write(qdata, TMR_ME | TMR_ALPF_V2,
> > > > +					&qdata->regv2->tmr);
> > > > +		}
> > > > +	}
> > > > 
> > > >  	return 0;
> > > >  }
> > > > @@ -148,16 +206,20 @@ static int qoriq_tmu_calibration(struct
> > > > platform_device *pdev)
> > > >  	struct device_node *np = pdev->dev.of_node;
> > > >  	struct qoriq_tmu_data *data =
> > > > platform_get_drvdata(pdev);
> > > > 
> > > > -	if (of_property_read_u32_array(np, "fsl,tmu-range",
> > > > range, 4)) {
> > > > -		dev_err(&pdev->dev, "missing calibration
> > > > range.\n");
> > > > -		return -ENODEV;
> > > > +	len = of_property_count_u32_elems(np, "fsl,tmu-range");
> > > > +	if (len == -ENODATA || len == -EINVAL || len > 4) {
> > > > +		dev_err(&pdev->dev, "invalid range data.\n");
> > > > +		return len;
> > > >  	}
> > > > 
> > > > -	/* Init temperature range registers */
> > > > -	tmu_write(data, range[0], &data->regs->ttr0cr);
> > > > -	tmu_write(data, range[1], &data->regs->ttr1cr);
> > > > -	tmu_write(data, range[2], &data->regs->ttr2cr);
> > > > -	tmu_write(data, range[3], &data->regs->ttr3cr);
> > > > +	val = of_property_read_u32_array(np, "fsl,tmu-range",
> > > > range, len);
> > > > +	if (val != 0) {
> > > > +		dev_err(&pdev->dev, "invalid range data.\n");
> > > > +		return val;
> > > > +	}
> > > > +
> > > > +	for (i = 0; i < len; i++)
> > > > +		tmu_write(data, range[i], &data->regs-
> > > > >ttrcr[i]);
> > > > 
> > > >  	calibration = of_get_property(np, "fsl,tmu-
> > > > calibration", &len);
> > > >  	if (calibration == NULL || len % 8) { @@ -181,7 +243,12
> > > > @@ static
> > > > void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
> > > >  	tmu_write(data, TIER_DISABLE, &data->regs->tier);
> > > > 
> > > >  	/* Set update_interval */
> > > > -	tmu_write(data, TMTMIR_DEFAULT, &data->regs->tmtmir);
> > > > +	if (data->ver == TMU_VER1) {
> > > > +		tmu_write(data, TMTMIR_DEFAULT, &data->regs-
> > > > >tmtmir);
> > > > +	} else {
> > > > +		tmu_write(data, TMTMIR_DEFAULT, &data->regv2-
> > > > >tmtmir);
> > > > +		tmu_write(data, TEUMR0_V2, &data->regv2-
> > > > >teumr0);
> > > > +	}
> > > > 
> > > >  	/* Disable monitoring */
> > > >  	tmu_write(data, TMR_DISABLE, &data->regs->tmr); @@
> > > > -190,6
> > 
> > +257,7
> > > @@
> > > > static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
> > > > static int qoriq_tmu_probe(struct platform_device *pdev)  {
> > > >  	int ret;
> > > > +	u32 ver;
> > > >  	struct qoriq_tmu_data *data;
> > > >  	struct device_node *np = pdev->dev.of_node;
> > > > 
> > > > @@ -214,6 +282,12 @@ static int qoriq_tmu_probe(struct
> > > 
> > > platform_device
> > > > *pdev)
> > > >  		goto err_iomap;
> > > >  	}
> > > > 
> > > > +	/* version register offset at: 0xbf8 on both v1 and v2
> > > > */
> > > > +	ver = tmu_read(data, &data->regs->ipbrr0);
> > > > +	data->ver = (ver >> 8) & 0xff;
> > > > +	if (data->ver == TMU_VER2)
> > > > +		data->regv2 = (void __iomem *)data->regs;
> > > > +
> > > >  	qoriq_tmu_init_device(data);	/* TMU initialization
> > > > */
> > > > 
> > > >  	ret = qoriq_tmu_calibration(pdev);	/* TMU
> > > > calibration */
> > > > --
> > > > 2.17.1
> 
> 

