Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B73DD19CCCD
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 00:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389548AbgDBWZK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 18:25:10 -0400
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:19655
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726963AbgDBWZK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 18:25:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7VCdZ7tdBJM1VOYDGsLAX5zc+Sssfw4wITNFWr+AG3Wwj/A81zcI4+zQxdIL/IRU0anok5vh/+2diT/GXl8blkKY0BskDTmvXsSmcChFh9nxhky60pCuNL4AFXHi1yHvxPQ0FB6fw+kxPWfYvg/y6RYF71FypPg4t4sIKCGkbb0qmkqLq3n5SKFQWpkfS0kiXW1H7rOClnopzAV9W3HZqc6FfdvgJc+kgXqliADhAeViL90cVuSj26YmiwoBaLAbrw3JtZZI94hW18mdwnmTN/N3U/0/mgnU4nVfhrKesZ3ztl30wK6fN+DsyB7CFd1bDJWCpOhmYBfvKD+E0aWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=km2BsHMZLhTaxd/4A61/+SWGTKVKvuFNDfPBK7qroqE=;
 b=BayV+i9BzQXeQbShZiCejE3xwKSOn/vijpkeWuJO6mOYvLRIRJEb5n0izHxoXXt+DNi1gZtEO1e3ZF6hFtU1kYRwT79jX8skj/pVLwMpzmxxYsvL2FFecAaSQMwRVjY2GIUo/NRj3iCSBAmpJO4pxU7QTfwkF3ySVogcZV3w8IjKySvMh3T+p0YUPX0U5LbYX50BkCNXr1j6zWhs/g8leoLptEPVpKS85LVDGxW7GpdjuLUDpEqtFZ4phEb/Pt81yd3Pj0b8X6HFJQ6UZv+9vIukJwRMNk3pV5ulu/B2DxZ+viKUUMxoJotDt/20F7DyXCXwlr+6KbjIyYQM8Xrhlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=km2BsHMZLhTaxd/4A61/+SWGTKVKvuFNDfPBK7qroqE=;
 b=L/Ln6UflczN2Myf2G6Cbfb6BMaAaihzbiasFigFw+aPIhomGWLBuELc5R1Y99BorCGHxYG6L/IIZuitXZlEVNES+SY72IpFOC7+LABBkCbrYV9PWWPcYVHblb2+CqoJXLwDSB/dq+t9HyW5Mz4+jQpKG3isMK3P2yV1DcoThbO8=
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com (2603:10a6:803:12e::23)
 by VI1PR04MB4000.eurprd04.prod.outlook.com (2603:10a6:803:4c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Thu, 2 Apr
 2020 22:24:58 +0000
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200]) by VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200%2]) with mapi id 15.20.2878.016; Thu, 2 Apr 2020
 22:24:58 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@samsung.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 5/8] interconnect: imx: Add platform driver for imx8mm
Thread-Topic: [PATCH v2 5/8] interconnect: imx: Add platform driver for imx8mm
Thread-Index: AQHWCDJ+B2dKXUPn9UGLA0y4/LK8YA==
Date:   Thu, 2 Apr 2020 22:24:57 +0000
Message-ID: <VI1PR04MB6941B0A0FE6FA2F3BD9E4574EEC60@VI1PR04MB6941.eurprd04.prod.outlook.com>
References: <cover.1585751281.git.leonard.crestez@nxp.com>
 <823cd307bea7416cf7df804bbcb77ab2887e0687.1585751281.git.leonard.crestez@nxp.com>
 <512ce59a-5718-3fab-1968-bbe3c5b38120@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82d65e4c-edec-4f80-fcd8-08d7d754ad46
x-ms-traffictypediagnostic: VI1PR04MB4000:|VI1PR04MB4000:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4000B9C7BA1C3BBAA063018EEEC60@VI1PR04MB4000.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(53546011)(26005)(81166006)(5660300002)(8676002)(478600001)(7416002)(44832011)(81156014)(54906003)(71200400001)(8936002)(4326008)(52536014)(6916009)(7696005)(86362001)(66556008)(186003)(66946007)(66446008)(64756008)(6506007)(9686003)(66476007)(2906002)(76116006)(316002)(55016002)(91956017)(33656002)(32563001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6BKanj23XycIKITV9m5OfwJ5E9uB5XR1R0u11m3S9dGSX2Bz+LvXdhaYvyfpBAS5dF9ZQ2ccHxIIqnyQ42dKavv17EGXIdjaKMx/mxNpos31qdmz8oeBzD5k072TfxgpiPunlHolioBfwFu/OeAvKQr2a0b2n/JP6sYp8Dh7yibFBLrzCJxlqhAAKLjT6xQdXAQI0q3qeo9KytFlZ8x2PLQSCRQb4uN99RiGoyaUNTid+wqezmijZr1aT7Bov5VFag76cwKy0Bfw3Q4K/LWQr1jQC4dsGPf0lyteIcx3K+JmotvS3a+gmtQmGPvRLj0/24SAapI/qmB435QtlkrpzxgxfD1SyDp9uDysBy2hDNu/0BwyIe1prPMBFAMqUOuXN7w7wI6aLJPCfDJIRbyBZJ6erKhQJ7iLmWEObtvyIgYUK11f5YyDorJ3x5mdWmAuSRND5P/JgC21iXVxTqgcAGlq41o54oScxLcNIFo3Q3o=
x-ms-exchange-antispam-messagedata: ENvHPY+tOXqCi5vT2MHvazWv74FNdhBtiJHSYsgBsfQujCSxwQg4Sk0H3KmffH3XgXCUGMibM5KWrmcZI1GldmGMS7hg74mHTnPoa0ZExXyvZpA7wzQkFKk3zUEiwf3IMNerWPhVs0W0tDgVo4Oyjg==
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d65e4c-edec-4f80-fcd8-08d7d754ad46
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 22:24:57.8110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aaag1iSSLzfat9EzMc5Le9mdiQ5Nh2BhUQulwshx3S76Wwgl0deZ0UGJnjDKt8n7akfQYyFPISUl2FIoyQGY2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4000
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-04-02 2:14 PM, Georgi Djakov wrote:=0A=
> Hi Leonard,=0A=
> =0A=
> On 4/1/20 17:33, Leonard Crestez wrote:=0A=
>> Add a platform driver for the i.MX8MM SoC describing bus topology.=0A=
>>=0A=
>> Bandwidth adjustments is currently only supported on the DDRC and main=
=0A=
>> NOC. Scaling for the vpu/gpu/display NICs could be added in the future.=
=0A=
>>=0A=
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   drivers/interconnect/imx/Kconfig          |   4 +=0A=
>>   drivers/interconnect/imx/Makefile         |   2 +=0A=
>>   drivers/interconnect/imx/imx8mm.c         | 108 ++++++++++++++++++++++=
=0A=
>>   include/dt-bindings/interconnect/imx8mm.h |  49 ++++++++++=0A=
>>   4 files changed, 163 insertions(+)=0A=
>>   create mode 100644 drivers/interconnect/imx/imx8mm.c=0A=
>>   create mode 100644 include/dt-bindings/interconnect/imx8mm.h=0A=
>>=0A=
>> diff --git a/drivers/interconnect/imx/Kconfig b/drivers/interconnect/imx=
/Kconfig=0A=
>> index f39336f8d603..2cd4fad4976a 100644=0A=
>> --- a/drivers/interconnect/imx/Kconfig=0A=
>> +++ b/drivers/interconnect/imx/Kconfig=0A=
>> @@ -1,5 +1,9 @@=0A=
>>   config INTERCONNECT_IMX=0A=
>>   	tristate "i.MX interconnect drivers"=0A=
>>   	depends on ARCH_MXC || COMPILE_TEST=0A=
>>   	help=0A=
>>   	  Generic interconnect drivers for i.MX SOCs=0A=
>> +=0A=
>> +config INTERCONNECT_IMX8MM=0A=
>> +	tristate "i.MX8MM interconnect driver"=0A=
>> +	depends on INTERCONNECT_IMX=0A=
>> diff --git a/drivers/interconnect/imx/Makefile b/drivers/interconnect/im=
x/Makefile=0A=
>> index 86ae0bd28d8c..c234e5d3dfd1 100644=0A=
>> --- a/drivers/interconnect/imx/Makefile=0A=
>> +++ b/drivers/interconnect/imx/Makefile=0A=
>> @@ -1,3 +1,5 @@=0A=
>>   imx-interconnect-objs			:=3D imx.o=0A=
>> +imx8mm-interconnect-objs       		:=3D imx8mm.o=0A=
>>   =0A=
>>   obj-$(CONFIG_INTERCONNECT_IMX)		+=3D imx-interconnect.o=0A=
>> +obj-$(CONFIG_INTERCONNECT_IMX8MM)	+=3D imx8mm-interconnect.o=0A=
>> diff --git a/drivers/interconnect/imx/imx8mm.c b/drivers/interconnect/im=
x/imx8mm.c=0A=
>> new file mode 100644=0A=
>> index 000000000000..ee3783a98c01=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/interconnect/imx/imx8mm.c=0A=
>> @@ -0,0 +1,108 @@=0A=
>> +// SPDX-License-Identifier: GPL-2.0=0A=
>> +/*=0A=
>> + * Interconnect framework driver for i.MX SoC=0A=
>> + *=0A=
>> + * Copyright (c) 2019, BayLibre=0A=
>> + * Copyright (c) 2019, NXP=0A=
>> + * Author: Alexandre Bailon <abailon@baylibre.com>=0A=
>> + * Author: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> + */=0A=
>> +=0A=
>> +#include <linux/device.h>=0A=
> =0A=
> Is this used?=0A=
=0A=
>> +#include <linux/module.h>=0A=
>> +#include <linux/of_platform.h>=0A=
> =0A=
> Is this used?=0A=
>> +#include <linux/platform_device.h>=0A=
>> +=0A=
>> +#include <dt-bindings/interconnect/imx8mm.h>=0A=
=0A=
Trimmed=0A=
>> +=0A=
>> +#include "imx.h"=0A=
>> +=0A=
>> +static const struct imx_icc_node_adj_desc imx8mm_dram_adj =3D {=0A=
>> +	.bw_mul =3D 1,=0A=
>> +	.bw_div =3D 16,=0A=
>> +	.phandle_name =3D "fsl,ddrc",=0A=
>> +};=0A=
>> +=0A=
>> +static const struct imx_icc_node_adj_desc imx8mm_noc_adj =3D {=0A=
>> +	.bw_mul =3D 1,=0A=
>> +	.bw_div =3D 16,=0A=
>> +	.main_noc =3D true,=0A=
>> +};=0A=
>> +=0A=
>> +/*=0A=
>> + * Describe bus masters, slaves and connections between them=0A=
>> + *=0A=
>> + * This is a simplified subset of the bus diagram, there are several ot=
her=0A=
>> + * PL301 nics which are skipped/merged into PL301_MAIN=0A=
>> + */=0A=
>> +static struct imx_icc_node_desc nodes[] =3D {=0A=
>> +	DEFINE_BUS_INTERCONNECT("NOC", IMX8MM_ICN_NOC, &imx8mm_noc_adj,=0A=
>> +			IMX8MM_ICS_DRAM, IMX8MM_ICN_MAIN),=0A=
>> +=0A=
>> +	DEFINE_BUS_SLAVE("DRAM", IMX8MM_ICS_DRAM, &imx8mm_dram_adj),=0A=
>> +	DEFINE_BUS_SLAVE("OCRAM", IMX8MM_ICS_OCRAM, NULL),=0A=
>> +	DEFINE_BUS_MASTER("A53", IMX8MM_ICM_A53, IMX8MM_ICN_NOC),=0A=
>> +=0A=
>> +	/* VPUMIX */=0A=
>> +	DEFINE_BUS_MASTER("VPU H1", IMX8MM_ICM_VPU_H1, IMX8MM_ICN_VIDEO),=0A=
>> +	DEFINE_BUS_MASTER("VPU G1", IMX8MM_ICM_VPU_G1, IMX8MM_ICN_VIDEO),=0A=
>> +	DEFINE_BUS_MASTER("VPU G2", IMX8MM_ICM_VPU_G2, IMX8MM_ICN_VIDEO),=0A=
>> +	DEFINE_BUS_INTERCONNECT("PL301_VIDEO", IMX8MM_ICN_VIDEO, NULL, IMX8MM_=
ICN_NOC),=0A=
>> +=0A=
>> +	/* GPUMIX */=0A=
>> +	DEFINE_BUS_MASTER("GPU 2D", IMX8MM_ICM_GPU2D, IMX8MM_ICN_GPU),=0A=
>> +	DEFINE_BUS_MASTER("GPU 3D", IMX8MM_ICM_GPU3D, IMX8MM_ICN_GPU),=0A=
>> +	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MM_ICN_GPU, NULL, IMX8MM_ICN_=
NOC),=0A=
>> +=0A=
>> +	/* DISPLAYMIX */=0A=
>> +	DEFINE_BUS_MASTER("CSI", IMX8MM_ICM_CSI, IMX8MM_ICN_MIPI),=0A=
>> +	DEFINE_BUS_MASTER("LCDIF", IMX8MM_ICM_LCDIF, IMX8MM_ICN_MIPI),=0A=
>> +	DEFINE_BUS_INTERCONNECT("PL301_MIPI", IMX8MM_ICN_MIPI, NULL, IMX8MM_IC=
N_NOC),=0A=
>> +=0A=
>> +	/* HSIO */=0A=
>> +	DEFINE_BUS_MASTER("USB1", IMX8MM_ICM_USB1, IMX8MM_ICN_HSIO),=0A=
>> +	DEFINE_BUS_MASTER("USB2", IMX8MM_ICM_USB2, IMX8MM_ICN_HSIO),=0A=
>> +	DEFINE_BUS_MASTER("PCIE", IMX8MM_ICM_PCIE, IMX8MM_ICN_HSIO),=0A=
>> +	DEFINE_BUS_INTERCONNECT("PL301_HSIO", IMX8MM_ICN_HSIO, NULL, IMX8MM_IC=
N_NOC),=0A=
>> +=0A=
>> +	/* Audio */=0A=
>> +	DEFINE_BUS_MASTER("SDMA2", IMX8MM_ICM_SDMA2, IMX8MM_ICN_AUDIO),=0A=
>> +	DEFINE_BUS_MASTER("SDMA3", IMX8MM_ICM_SDMA3, IMX8MM_ICN_AUDIO),=0A=
>> +	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MM_ICN_AUDIO, NULL, IMX8MM_=
ICN_MAIN),=0A=
>> +=0A=
>> +	/* Ethernet */=0A=
>> +	DEFINE_BUS_MASTER("ENET", IMX8MM_ICM_ENET, IMX8MM_ICN_ENET),=0A=
>> +	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MM_ICN_ENET, NULL, IMX8MM_IC=
N_MAIN),=0A=
>> +=0A=
>> +	/* Other */=0A=
>> +	DEFINE_BUS_MASTER("SDMA1", IMX8MM_ICM_SDMA1, IMX8MM_ICN_MAIN),=0A=
>> +	DEFINE_BUS_MASTER("NAND", IMX8MM_ICM_NAND, IMX8MM_ICN_MAIN),=0A=
>> +	DEFINE_BUS_MASTER("USDHC1", IMX8MM_ICM_USDHC1, IMX8MM_ICN_MAIN),=0A=
>> +	DEFINE_BUS_MASTER("USDHC2", IMX8MM_ICM_USDHC2, IMX8MM_ICN_MAIN),=0A=
>> +	DEFINE_BUS_MASTER("USDHC3", IMX8MM_ICM_USDHC3, IMX8MM_ICN_MAIN),=0A=
>> +	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MM_ICN_MAIN, NULL,=0A=
>> +			IMX8MM_ICN_NOC, IMX8MM_ICS_OCRAM),=0A=
>> +};=0A=
>> +=0A=
>> +static int imx8mm_icc_probe(struct platform_device *pdev)=0A=
>> +{=0A=
>> +	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes));=0A=
>> +}=0A=
>> +=0A=
>> +static int imx8mm_icc_remove(struct platform_device *pdev)=0A=
>> +{=0A=
>> +	return imx_icc_unregister(pdev);=0A=
>> +}=0A=
>> +=0A=
>> +static struct platform_driver imx8mm_icc_driver =3D {=0A=
>> +	.probe =3D imx8mm_icc_probe,=0A=
>> +	.remove =3D imx8mm_icc_remove,=0A=
>> +	.driver =3D {=0A=
>> +		.name =3D "imx8mm-interconnect",=0A=
>> +	},=0A=
>> +};=0A=
>> +=0A=
>> +module_platform_driver(imx8mm_icc_driver);=0A=
>> +MODULE_AUTHOR("Alexandre Bailon <abailon@baylibre.com>");=0A=
>> +MODULE_LICENSE("GPL v2");=0A=
>> +MODULE_ALIAS("platform:imx8mm-interconnect");=0A=
>> diff --git a/include/dt-bindings/interconnect/imx8mm.h b/include/dt-bind=
ings/interconnect/imx8mm.h=0A=
>> new file mode 100644=0A=
>> index 000000000000..5404f2af15c3=0A=
>> --- /dev/null=0A=
>> +++ b/include/dt-bindings/interconnect/imx8mm.h=0A=
>> @@ -0,0 +1,49 @@=0A=
>> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>> +/*=0A=
>> + * Interconnect framework driver for i.MX SoC=0A=
>> + *=0A=
>> + * Copyright (c) 2019, BayLibre=0A=
>> + * Author: Alexandre Bailon <abailon@baylibre.com>=0A=
>> + */=0A=
>> +=0A=
>> +#ifndef __IMX8MM_ICM_INTERCONNECT_IDS_H=0A=
>> +#define __IMX8MM_ICM_INTERCONNECT_IDS_H=0A=
> =0A=
> Nit: Some people make this match the path, but it's up to you.=0A=
=0A=
OK=0A=
=0A=
>> +=0A=
>> +#define IMX8MM_ICN_NOC		1=0A=
>> +#define IMX8MM_ICS_DRAM		2=0A=
>> +#define IMX8MM_ICS_OCRAM	3=0A=
>> +#define IMX8MM_ICM_A53		4=0A=
>> +=0A=
>> +#define IMX8MM_ICM_VPU_H1	5=0A=
>> +#define IMX8MM_ICM_VPU_G1	6=0A=
>> +#define IMX8MM_ICM_VPU_G2	7=0A=
>> +#define IMX8MM_ICN_VIDEO	8=0A=
>> +=0A=
>> +#define IMX8MM_ICM_GPU2D	9=0A=
>> +#define IMX8MM_ICM_GPU3D	10=0A=
>> +#define IMX8MM_ICN_GPU		11=0A=
>> +=0A=
>> +#define IMX8MM_ICM_CSI		12=0A=
>> +#define IMX8MM_ICM_LCDIF	13=0A=
>> +#define IMX8MM_ICN_MIPI		14=0A=
>> +=0A=
>> +#define IMX8MM_ICM_USB1		15=0A=
>> +#define IMX8MM_ICM_USB2		16=0A=
>> +#define IMX8MM_ICM_PCIE		17=0A=
>> +#define IMX8MM_ICN_HSIO		18=0A=
>> +=0A=
>> +#define IMX8MM_ICM_SDMA2	19=0A=
>> +#define IMX8MM_ICM_SDMA3	20=0A=
>> +#define IMX8MM_ICN_AUDIO	21=0A=
>> +=0A=
>> +#define IMX8MM_ICN_ENET		22=0A=
>> +#define IMX8MM_ICM_ENET		23=0A=
>> +=0A=
>> +#define IMX8MM_ICN_MAIN		24=0A=
>> +#define IMX8MM_ICM_NAND		25=0A=
>> +#define IMX8MM_ICM_SDMA1	26=0A=
>> +#define IMX8MM_ICM_USDHC1	27=0A=
>> +#define IMX8MM_ICM_USDHC2	28=0A=
>> +#define IMX8MM_ICM_USDHC3	29=0A=
>> +=0A=
>> +#endif /* __IMX8MM_ICM_INTERCONNECT_IDS_H */=0A=
>>=0A=
> =0A=
> Looks good!=0A=
> =0A=
> Thanks,=0A=
> Georgi=0A=
> =0A=
> =0A=
=0A=
