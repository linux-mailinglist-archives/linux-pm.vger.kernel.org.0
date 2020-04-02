Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E90319CCB0
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 00:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389342AbgDBWQH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 18:16:07 -0400
Received: from mail-eopbgr70041.outbound.protection.outlook.com ([40.107.7.41]:11466
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388218AbgDBWQH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 18:16:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVEE5YTML+BLLpnfmxcW+iD/dMcd1YSHblH479GZ0/DxjMBru1kUyFOAl8LnAMZ8DlarAQxkAd8TPLg5sKNyYf24if+V+vwz7WQNEZ2Y7mcr7cjUb70EUan1F61l8Gc0q6EOrb1PRS+MzhbRX3OCil/fl9SWafpycehPC1MeTVn4EB1zbDXm8qF+Q+56TMGIvepyWsfhFBTrMhdq9X0cGR6RCavqPpLlbwxlspECwX+JC0gI23UjtS2fguKTMEHwm0NMKE6rw37WiXKjFxj2eKdaVVSfehVlhY9Pp77szQj9xqRc5y0Cqaeinf2nfGAVQBf1s97SwdwskxKKkfUuyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMyIFJfD0CzsEdthvfXRXtb14eyGTXlTvJNeKxsYmrU=;
 b=NuM5+IpQkQhWzmfAVupdz8dosVcQsQt3PBR492uAGYEhiUDFn6o87gteWjaUGtJjoCW/7stoU/jceCx61suL03HtN58ONCY9+B3bB4/aKhHATAHGR9V+ExoWKiwSo+2wPgSFo+oDQ2pZcqlxTfq+Zo/+BprF7Ahuxt6Y/22wxmXzVeCL055Jyp4fzAfaUnzZWoWDvKJSDOO4Nbkyyt59Bmv/QyQX75rdaqSDtzepL33w2EKCpYC9bEfxqScNVnHCGD2Rhf8PRMtRPLSnMDbQIhAUaviCvdrI8jaQTYYLpr6U9STYqq07yImnWDFkVNxIGnyONpFOvyhPjFOk44WENw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMyIFJfD0CzsEdthvfXRXtb14eyGTXlTvJNeKxsYmrU=;
 b=lPO1xL5p33oYt2Nuljqo0M3Mxdhm+27ki+Ma+U5+EXJEiqAsPoUUsdY9PE4uG1mCwPOIVfz5uBpsapCFAHRU06pfy3sPSkA+WRPGqT+YgQo347ShKZpwMc2Fqx+0MC4fmc32r3SIJ0oQwZoToMgoUe9Stsxyi7OKPdFvjaXpu2Q=
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com (2603:10a6:803:12e::23)
 by VI1PR04MB5824.eurprd04.prod.outlook.com (2603:10a6:803:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Thu, 2 Apr
 2020 22:00:56 +0000
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200]) by VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200%2]) with mapi id 15.20.2878.016; Thu, 2 Apr 2020
 22:00:56 +0000
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
Subject: Re: [PATCH v2 4/8] interconnect: Add imx core driver
Thread-Topic: [PATCH v2 4/8] interconnect: Add imx core driver
Thread-Index: AQHWCDJ+vtFSR3fKPE6a5fasnP96Gg==
Date:   Thu, 2 Apr 2020 22:00:56 +0000
Message-ID: <VI1PR04MB6941080388058184401EDB5EEEC60@VI1PR04MB6941.eurprd04.prod.outlook.com>
References: <cover.1585751281.git.leonard.crestez@nxp.com>
 <50e6bdb1aab7d8f73cb10d11a4ea1e55056448fc.1585751281.git.leonard.crestez@nxp.com>
 <4464d011-5948-61ef-97bb-173f428021ad@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0b992d9-07c8-470a-e086-08d7d751521d
x-ms-traffictypediagnostic: VI1PR04MB5824:|VI1PR04MB5824:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5824F17362CE4E490B3D8E72EEC60@VI1PR04MB5824.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:785;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(66946007)(66556008)(26005)(33656002)(316002)(6506007)(66446008)(9686003)(64756008)(2906002)(66476007)(86362001)(91956017)(76116006)(55016002)(8676002)(81156014)(71200400001)(52536014)(44832011)(186003)(53546011)(478600001)(4326008)(30864003)(8936002)(7416002)(5660300002)(81166006)(6916009)(7696005)(54906003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WF2cBX51crgkTkVDPdZxv36Hp3SxA4VJCsyniGnj4wPWh17M0/n/PJzRoz9wtovYwopjhGuiPZM+cWckTSRqlqzn6Am23LB8tickLhAjAtYSDo5que576XadNb8ee/lZsWfLAivEExOyeoF24lO1atTS784Z/PhDd0Ek4dwq82r7xLcZJ6oyDQmuaOYKY6Hr5q/5W5+0GnRi260O9RnJ6z080DN4mJwM1/+GofgcEJ8jAPVDi6GZGtKRJo0dG9H1ocnncV1FJYgATdmv1nNyPTO3WCun8G6TdBUBElaA91kkoC0F8TZRXrvkfhvwf9Nsk6ytqJhvmssDbV4OBTTxiZZrmKc7nUxkAnFXRJg8c24/lCc2DmrAUS/JHdn5CDgZmSGmHeFAcTDEqAPDcpFDaNeBdR9PuafXRv5eHnvXAQpf+CptbmFVgyHkXpE0Srm7
x-ms-exchange-antispam-messagedata: q3lpjJlRe9LEvvX6lm0Q2H3zXmwWXECaDe4jLFAaUjBTAhQrx7UDxjy48geogxub7jtmghuIR0rLwQHYmHX4icURkD81+PybPEZcTSA/kLBgY9uWqtucAa7vm/wgWhJ3rprSYC3gQzlXlvSVkF83/g==
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b992d9-07c8-470a-e086-08d7d751521d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 22:00:56.3986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p96gIEPCqsMIw7eH4flYiNW9XUxD3hOogKcS2xQ7KyIcwjmcKFzXhr0W8PM22/voXQU6gci+8JLPKjCZH37caA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5824
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-04-02 2:06 PM, Georgi Djakov wrote:=0A=
> Hi Leonard,=0A=
> =0A=
> Thank you for updating the patches!=0A=
> =0A=
> On 4/1/20 17:33, Leonard Crestez wrote:=0A=
>> This adds support for i.MX SoC family to interconnect framework.=0A=
>>=0A=
>> Platform drivers can describe the interconnect graph and several=0A=
>> adjustment knobs where icc node bandwidth is converted to a=0A=
>> DEV_PM_QOS_MIN_FREQUENCY request.=0A=
>>=0A=
>> The interconnect provider is probed through the main NOC device and=0A=
>> other adjustable nodes on the same graph are found from a=0A=
>> fsl,scalable-nodes phandle array property.=0A=
>>=0A=
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>=0A=
>> ---=0A=
>>   drivers/interconnect/Kconfig      |   1 +=0A=
>>   drivers/interconnect/Makefile     |   1 +=0A=
>>   drivers/interconnect/imx/Kconfig  |   5 +=0A=
>>   drivers/interconnect/imx/Makefile |   3 +=0A=
>>   drivers/interconnect/imx/imx.c    | 298 ++++++++++++++++++++++++++++++=
=0A=
>>   drivers/interconnect/imx/imx.h    |  62 +++++++=0A=
>>   6 files changed, 370 insertions(+)=0A=
>>   create mode 100644 drivers/interconnect/imx/Kconfig=0A=
>>   create mode 100644 drivers/interconnect/imx/Makefile=0A=
>>   create mode 100644 drivers/interconnect/imx/imx.c=0A=
>>   create mode 100644 drivers/interconnect/imx/imx.h=0A=
>>=0A=
>> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig=
=0A=
>> index bfa4ca3ab7a9..e61802230f90 100644=0A=
>> --- a/drivers/interconnect/Kconfig=0A=
>> +++ b/drivers/interconnect/Kconfig=0A=
>> @@ -10,7 +10,8 @@ menuconfig INTERCONNECT=0A=
>>   	  If unsure, say no.=0A=
>>   =0A=
>>   if INTERCONNECT=0A=
>>   =0A=
>>   source "drivers/interconnect/qcom/Kconfig"=0A=
>> +source "drivers/interconnect/imx/Kconfig"=0A=
> =0A=
> Nit: Please move it up to make it sorted.=0A=
> =0A=
>>   =0A=
>>   endif=0A=
>> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefi=
le=0A=
>> index 725029ae7a2c..6998288a7d98 100644=0A=
>> --- a/drivers/interconnect/Makefile=0A=
>> +++ b/drivers/interconnect/Makefile=0A=
>> @@ -3,5 +3,6 @@=0A=
>>   CFLAGS_core.o				:=3D -I$(src)=0A=
>>   icc-core-objs				:=3D core.o=0A=
>>   =0A=
>>   obj-$(CONFIG_INTERCONNECT)		+=3D icc-core.o=0A=
>>   obj-$(CONFIG_INTERCONNECT_QCOM)		+=3D qcom/=0A=
>> +obj-$(CONFIG_INTERCONNECT_IMX)		+=3D imx/=0A=
> =0A=
> Ditto.=0A=
> =0A=
>> diff --git a/drivers/interconnect/imx/Kconfig b/drivers/interconnect/imx=
/Kconfig=0A=
>> new file mode 100644=0A=
>> index 000000000000..f39336f8d603=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/interconnect/imx/Kconfig=0A=
>> @@ -0,0 +1,5 @@=0A=
>> +config INTERCONNECT_IMX=0A=
>> +	tristate "i.MX interconnect drivers"=0A=
>> +	depends on ARCH_MXC || COMPILE_TEST=0A=
>> +	help=0A=
>> +	  Generic interconnect drivers for i.MX SOCs=0A=
>> diff --git a/drivers/interconnect/imx/Makefile b/drivers/interconnect/im=
x/Makefile=0A=
>> new file mode 100644=0A=
>> index 000000000000..86ae0bd28d8c=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/interconnect/imx/Makefile=0A=
>> @@ -0,0 +1,3 @@=0A=
>> +imx-interconnect-objs			:=3D imx.o=0A=
>> +=0A=
>> +obj-$(CONFIG_INTERCONNECT_IMX)		+=3D imx-interconnect.o=0A=
>> diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/i=
mx.c=0A=
>> new file mode 100644=0A=
>> index 000000000000..527b1de1c41a=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/interconnect/imx/imx.c=0A=
>> @@ -0,0 +1,298 @@=0A=
>> +// SPDX-License-Identifier: GPL-2.0=0A=
>> +/*=0A=
>> + * Interconnect framework driver for i.MX SoC=0A=
>> + *=0A=
>> + * Copyright (c) 2019, BayLibre=0A=
>> + * Copyright (c) 2019, NXP=0A=
> =0A=
> Maybe update it to 2020.=0A=
> =0A=
>> + * Author: Alexandre Bailon <abailon@baylibre.com>=0A=
>> + * Author: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> + */=0A=
>> +=0A=
>> +#include <linux/device.h>=0A=
>> +#include <linux/interconnect-provider.h>=0A=
>> +#include <linux/module.h>=0A=
>> +#include <linux/of.h>=0A=
>> +#include <linux/of_platform.h>=0A=
>> +#include <linux/platform_device.h>=0A=
>> +#include <linux/pm_qos.h>=0A=
>> +=0A=
>> +#include "imx.h"=0A=
>> +=0A=
>> +/* private icc_node data */=0A=
>> +struct imx_icc_node {=0A=
>> +	const struct imx_icc_node_desc *desc;=0A=
>> +	struct device *qos_dev;=0A=
>> +	struct dev_pm_qos_request qos_req;=0A=
>> +};=0A=
>> +=0A=
>> +static int imx_icc_aggregate(struct icc_node *node, u32 tag,=0A=
>> +			     u32 avg_bw, u32 peak_bw,=0A=
>> +			     u32 *agg_avg, u32 *agg_peak)=0A=
>> +{=0A=
>> +	*agg_avg +=3D avg_bw;=0A=
>> +	*agg_peak =3D max(*agg_peak, peak_bw);=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
> =0A=
> Please remove and use the common library function:=0A=
> icc_std_aggregate().=0A=
=0A=
OK=0A=
=0A=
>> +=0A=
>> +static int imx_icc_node_set(struct icc_node *node)=0A=
>> +{=0A=
>> +	struct device *dev =3D node->provider->dev;=0A=
>> +	struct imx_icc_node *node_data =3D node->data;=0A=
>> +	u64 freq;=0A=
>> +=0A=
>> +	if (!node_data->qos_dev)=0A=
>> +		return 0;=0A=
>> +=0A=
>> +	freq =3D (node->avg_bw + node->peak_bw) * node_data->desc->adj->bw_mul=
;=0A=
>> +	do_div(freq, node_data->desc->adj->bw_div);=0A=
>> +	dev_dbg(dev, "node %s device %s avg_bw %ukBps peak_bw %ukBps min_freq =
%llukHz\n",=0A=
>> +		node->name, dev_name(node_data->qos_dev),=0A=
>> +		node->avg_bw, node->peak_bw, freq);=0A=
>> +=0A=
>> +	if (freq > S32_MAX) {=0A=
>> +		dev_err(dev, "%s can't request more than S32_MAX freq\n",=0A=
>> +				node->name);=0A=
> =0A=
> Please align with the open parenthesis.=0A=
=0A=
Fixed all instances.=0A=
=0A=
>> +		return -ERANGE;=0A=
>> +	}=0A=
>> +=0A=
>> +	dev_pm_qos_update_request(&node_data->qos_req, freq);=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static int imx_icc_set(struct icc_node *src, struct icc_node *dst)=0A=
>> +{=0A=
>> +	return imx_icc_node_set(dst);=0A=
>> +}=0A=
>> +=0A=
>> +/* imx_icc_node_destroy() - Destroy an imx icc_node, including private =
data */=0A=
>> +static void imx_icc_node_destroy(struct icc_node *node)=0A=
>> +{=0A=
>> +	struct imx_icc_node *node_data =3D node->data;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	if (dev_pm_qos_request_active(&node_data->qos_req)) {=0A=
>> +		ret =3D dev_pm_qos_remove_request(&node_data->qos_req);=0A=
>> +		if (ret)=0A=
>> +			dev_warn(node->provider->dev, "failed to remove qos request for %s\n=
",=0A=
>> +				 dev_name(node_data->qos_dev));=0A=
>> +	}=0A=
>> +=0A=
>> +	put_device(node_data->qos_dev);=0A=
>> +	icc_node_del(node);=0A=
>> +	icc_node_destroy(node->id);=0A=
>> +}=0A=
>> +=0A=
>> +static int imx_icc_node_init_qos(struct icc_provider *provider,=0A=
>> +				 struct icc_node *node)=0A=
>> +{=0A=
>> +	struct imx_icc_node *node_data =3D node->data;=0A=
>> +	const struct imx_icc_node_adj_desc *adj =3D node_data->desc->adj;=0A=
>> +	struct device *dev =3D provider->dev;=0A=
>> +	struct device_node *dn =3D NULL;=0A=
>> +	struct platform_device *pdev;=0A=
>> +=0A=
>> +	if (adj->main_noc) {=0A=
>> +		node_data->qos_dev =3D dev;=0A=
>> +		dev_info(dev, "icc node %s[%d] is main noc itself\n",=0A=
>> +			 node->name, node->id);=0A=
> =0A=
> Should this be dev_dbg()?=0A=
> =0A=
>> +	} else {=0A=
>> +		dn =3D of_parse_phandle(dev->of_node, adj->phandle_name, 0);=0A=
>> +		if (IS_ERR(dn)) {=0A=
>> +			dev_warn(dev, "Failed to parse %s: %ld\n",=0A=
>> +					adj->phandle_name, PTR_ERR(dn));=0A=
> =0A=
> Please align with the open parenthesis.=0A=
> =0A=
>> +			return PTR_ERR(dn);=0A=
>> +		}=0A=
>> +		/* Allow scaling to be disabled on a per-node basis */=0A=
>> +		if (!dn || !of_device_is_available(dn)) {=0A=
>> +			dev_warn(dev, "Missing property %s, skip scaling %s\n",=0A=
>> +					adj->phandle_name, node->name);=0A=
> =0A=
> Please align with the open parenthesis.=0A=
> =0A=
>> +			return 0;=0A=
>> +		}=0A=
>> +=0A=
>> +		pdev =3D of_find_device_by_node(dn);=0A=
>> +		of_node_put(dn);=0A=
>> +		if (!pdev) {=0A=
>> +			dev_warn(dev, "node %s[%d] missing device for %pOF\n",=0A=
>> +					node->name, node->id, dn);=0A=
> =0A=
> Please align with the open parenthesis.=0A=
> =0A=
>> +			return -EPROBE_DEFER;=0A=
>> +		}=0A=
>> +		node_data->qos_dev =3D &pdev->dev;=0A=
>> +		dev_info(dev, "node %s[%d] has device node %pOF\n",=0A=
>> +			 node->name, node->id, dn);=0A=
> =0A=
> dev_dbg() again maybe? Unless you think that it make sense to print this=
=0A=
> information to the user?=0A=
> =0A=
>> +	}=0A=
>> +=0A=
>> +	return dev_pm_qos_add_request(node_data->qos_dev,=0A=
>> +				      &node_data->qos_req,=0A=
>> +				      DEV_PM_QOS_MIN_FREQUENCY, 0);=0A=
>> +}=0A=
>> +=0A=
>> +static struct icc_node *imx_icc_node_add(struct icc_provider *provider,=
=0A=
>> +					 const struct imx_icc_node_desc *node_desc)=0A=
>> +{=0A=
>> +	struct device *dev =3D provider->dev;=0A=
>> +	struct imx_icc_node *node_data;=0A=
>> +	struct icc_node *node;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	node =3D icc_node_create(node_desc->id);=0A=
>> +	if (IS_ERR(node)) {=0A=
>> +		dev_err(dev, "failed to create node %d\n", node_desc->id);=0A=
>> +		return node;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (node->data) {=0A=
>> +		dev_err(dev, "already created node %s id=3D%d\n",=0A=
>> +				node_desc->name, node_desc->id);=0A=
> =0A=
> Please align with the open parenthesis.=0A=
> =0A=
>> +		return ERR_PTR(-EEXIST);=0A=
>> +	}=0A=
>> +=0A=
>> +	node_data =3D devm_kzalloc(dev, sizeof(*node_data), GFP_KERNEL);=0A=
>> +	if (!node_data) {=0A=
>> +		icc_node_destroy(node->id);=0A=
>> +		return ERR_PTR(-ENOMEM);=0A=
>> +	}=0A=
>> +=0A=
>> +	node->name =3D node_desc->name;=0A=
>> +	node->data =3D node_data;=0A=
>> +	node_data->desc =3D node_desc;=0A=
>> +	icc_node_add(node, provider);=0A=
>> +=0A=
>> +	if (node_desc->adj) {=0A=
>> +		ret =3D imx_icc_node_init_qos(provider, node);=0A=
>> +		if (ret < 0) {=0A=
>> +			imx_icc_node_destroy(node);=0A=
>> +			return ERR_PTR(ret);=0A=
>> +		}=0A=
>> +	}=0A=
>> +=0A=
>> +	return node;=0A=
>> +}=0A=
>> +=0A=
>> +static void imx_icc_unregister_nodes(struct icc_provider *provider)=0A=
>> +{=0A=
>> +	struct icc_node *node, *tmp;=0A=
>> +=0A=
>> +	list_for_each_entry_safe(node, tmp, &provider->nodes, node_list)=0A=
>> +		imx_icc_node_destroy(node);=0A=
>> +}=0A=
>> +=0A=
>> +static int imx_icc_register_nodes(struct icc_provider *provider,=0A=
>> +				  const struct imx_icc_node_desc *descs,=0A=
>> +				  int count)=0A=
>> +{=0A=
>> +	struct icc_onecell_data *provider_data =3D provider->data;=0A=
>> +	int ret;=0A=
>> +	int i;=0A=
>> +=0A=
>> +	for (i =3D 0; i < count; i++) {=0A=
>> +		struct icc_node *node;=0A=
>> +		const struct imx_icc_node_desc *node_desc =3D &descs[i];=0A=
>> +		size_t j;=0A=
>> +=0A=
>> +		node =3D imx_icc_node_add(provider, node_desc);=0A=
>> +		if (IS_ERR(node)) {=0A=
>> +			ret =3D PTR_ERR(node);=0A=
>> +			if (ret !=3D -EPROBE_DEFER)=0A=
>> +				dev_err(provider->dev, "failed to add %s: %d\n",=0A=
>> +					node_desc->name, ret);=0A=
>> +			goto err;=0A=
>> +		}=0A=
>> +		provider_data->nodes[node->id] =3D node;=0A=
>> +=0A=
>> +		for (j =3D 0; j < node_desc->num_links; j++) {=0A=
>> +			ret =3D icc_link_create(node, node_desc->links[j]);=0A=
>> +			if (ret) {=0A=
>> +				dev_err(provider->dev, "failed to link node %d to %d: %d\n",=0A=
>> +					node->id, node_desc->links[j], ret);=0A=
>> +				goto err;=0A=
>> +			}=0A=
>> +		}=0A=
>> +	}=0A=
>> +=0A=
>> +	return 0;=0A=
>> +=0A=
>> +err:=0A=
>> +	imx_icc_unregister_nodes(provider);=0A=
>> +=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
>> +static int get_max_node_id(struct imx_icc_node_desc *nodes, int nodes_c=
ount)=0A=
>> +{=0A=
>> +	int i, ret =3D 0;=0A=
>> +=0A=
>> +	for (i =3D 0; i < nodes_count; ++i)=0A=
>> +		if (nodes[i].id > ret)=0A=
>> +			ret =3D nodes[i].id;=0A=
>> +=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
>> +int imx_icc_register(struct platform_device *pdev,=0A=
>> +		     struct imx_icc_node_desc *nodes, int nodes_count)=0A=
>> +{=0A=
>> +	struct device *dev =3D &pdev->dev;=0A=
>> +	struct icc_onecell_data *data;=0A=
>> +	struct icc_provider *provider;=0A=
>> +	int max_node_id;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	/* icc_onecell_data is indexed by node_id, unlike nodes param */=0A=
>> +	max_node_id =3D get_max_node_id(nodes, nodes_count);=0A=
>> +	data =3D devm_kzalloc(dev, struct_size(data, nodes, max_node_id),=0A=
>> +			    GFP_KERNEL);=0A=
>> +	if (!data)=0A=
>> +		return -ENOMEM;=0A=
>> +	data->num_nodes =3D max_node_id;=0A=
>> +=0A=
>> +	provider =3D devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);=0A=
>> +	if (!provider)=0A=
>> +		return -ENOMEM;=0A=
>> +	provider->set =3D imx_icc_set;=0A=
>> +	provider->aggregate =3D imx_icc_aggregate;=0A=
> =0A=
> provider->aggregate =3D icc_std_aggregate;=0A=
> =0A=
>> +	provider->xlate =3D of_icc_xlate_onecell;=0A=
>> +	provider->data =3D data;=0A=
>> +	provider->dev =3D dev->parent;=0A=
>> +	platform_set_drvdata(pdev, provider);=0A=
>> +=0A=
>> +	ret =3D icc_provider_add(provider);=0A=
>> +	if (ret) {=0A=
>> +		dev_err(dev, "error adding interconnect provider: %d\n", ret);=0A=
>> +		return ret;=0A=
>> +	}=0A=
>> +=0A=
>> +	ret =3D imx_icc_register_nodes(provider, nodes, nodes_count);=0A=
>> +	if (ret)=0A=
>> +		goto provider_del;=0A=
>> +=0A=
>> +	return 0;=0A=
>> +=0A=
>> +provider_del:=0A=
>> +	icc_provider_del(provider);=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +EXPORT_SYMBOL_GPL(imx_icc_register);=0A=
>> +=0A=
>> +int imx_icc_unregister(struct platform_device *pdev)=0A=
>> +{=0A=
>> +	struct icc_provider *provider =3D platform_get_drvdata(pdev);=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	if (provider->users) {=0A=
>> +		dev_warn(&pdev->dev, "interconnect provider still has %d users\n",=0A=
>> +			provider->users);=0A=
>> +		return -EBUSY;=0A=
>> +	}=0A=
> =0A=
> The above check already exists in icc_provider_del(). But i assume you do=
n't=0A=
> want to delete any nodes from the provider if it still has users. Maybe i=
t will=0A=
> be sensible to add this check into icc_nodes_remove() instead, so that su=
ch=0A=
> cases are handled on a framework level.=0A=
=0A=
Actually device removal is not allowed to fail, for example doing an =0A=
explicit unbind will ignore errors coming from the unregister function:=0A=
=0A=
echo imx8mm-interconnect > =0A=
/sys/bus/platform/drivers/imx8mm-interconnect/unbind=0A=
=0A=
results in the following stack trace where device_driver_detach actually =
=0A=
continues even if remove returns an error:=0A=
=0A=
[   24.017901]  imx_icc_unregister+0x24/0x80=0A=
[   24.021925]  imx8mm_icc_remove+0x18/0x28=0A=
[   24.025863]  platform_drv_remove+0x34/0x58=0A=
[   24.029974]  device_release_driver_internal+0x104/0x1d8=0A=
[   24.035213]  device_driver_detach+0x20/0x30=0A=
[   24.039409]  unbind_store+0xe8/0x110=0A=
[   24.042999]  drv_attr_store+0x2c/0x40=0A=
[   24.046677]  sysfs_kf_write+0x54/0x80=0A=
=0A=
I'm not sure how the framework should handle provider removal. Right now =
=0A=
icc_path holds icc_node pointers so when nodes are freed any consumer =0A=
calling into icc will corrupt memory.=0A=
=0A=
One option would be to reference count the allocation of struct =0A=
icc_node, this way icc_path functions could safely check for =0A=
node->provider =3D=3D NULL and return an error.=0A=
=0A=
I'll remove this check from the imx driver because it does not solve =0A=
anything.=0A=
=0A=
> =0A=
>> +	imx_icc_unregister_nodes(provider);=0A=
>> +=0A=
>> +	ret =3D icc_provider_del(provider);=0A=
>> +	if (ret)=0A=
>> +		return ret;=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +EXPORT_SYMBOL_GPL(imx_icc_unregister);=0A=
>> +=0A=
>> +MODULE_LICENSE("GPL v2");=0A=
>> diff --git a/drivers/interconnect/imx/imx.h b/drivers/interconnect/imx/i=
mx.h=0A=
>> new file mode 100644=0A=
>> index 000000000000..aa811e4ebb7e=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/interconnect/imx/imx.h=0A=
>> @@ -0,0 +1,62 @@=0A=
>> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>> +/*=0A=
>> + * Interconnect framework driver for i.MX SoC=0A=
>> + *=0A=
>> + * Copyright (c) 2019, BayLibre=0A=
>> + * Copyright (c) 2019, NXP=0A=
>> + * Author: Alexandre Bailon <abailon@baylibre.com>=0A=
>> + * Author: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> + */=0A=
>> +#ifndef __DRIVERS_INTERCONNECT_IMX_H=0A=
>> +#define __DRIVERS_INTERCONNECT_IMX_H=0A=
>> +=0A=
>> +#include <linux/kernel.h>=0A=
>> +=0A=
>> +#define IMX_ICC_MAX_LINKS	4=0A=
>> +=0A=
>> +/*=0A=
>> + * struct imx_icc_node_adj - Describe a dynamic adjustable node=0A=
>> + */=0A=
>> +struct imx_icc_node_adj_desc {=0A=
>> +	unsigned int bw_mul, bw_div;=0A=
>> +	const char *phandle_name;=0A=
>> +	bool main_noc;=0A=
>> +};=0A=
>> +=0A=
>> +/*=0A=
>> + * struct imx_icc_node - Describe an interconnect node=0A=
>> + * @name: name of the node=0A=
>> + * @id: an unique id to identify the node=0A=
>> + * @links: an array of slaves' node id=0A=
>> + * @num_links: number of id defined in links=0A=
>> + */=0A=
>> +struct imx_icc_node_desc {=0A=
>> +	const char *name;=0A=
>> +	u16 id;=0A=
>> +	u16 links[IMX_ICC_MAX_LINKS];=0A=
>> +	u16 num_links;=0A=
>> +=0A=
> =0A=
> Why the blank line?=0A=
=0A=
Removed=0A=
=0A=
>> +	const struct imx_icc_node_adj_desc *adj;=0A=
>> +};=0A=
>> +=0A=
>> +#define DEFINE_BUS_INTERCONNECT(_name, _id, _adj, ...)			\=0A=
>> +	{								\=0A=
>> +		.id =3D _id,						\=0A=
>> +		.name =3D _name,						\=0A=
>> +		.adj =3D _adj,						\=0A=
>> +		.num_links =3D ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\=0A=
>> +		.links =3D { __VA_ARGS__ },				\=0A=
>> +	}=0A=
>> +=0A=
>> +#define DEFINE_BUS_MASTER(_name, _id, _dest_id)				\=0A=
>> +	DEFINE_BUS_INTERCONNECT(_name, _id, NULL, _dest_id)=0A=
>> +=0A=
>> +#define DEFINE_BUS_SLAVE(_name, _id, _adj)				\=0A=
>> +	DEFINE_BUS_INTERCONNECT(_name, _id, _adj)=0A=
>> +=0A=
>> +int imx_icc_register(struct platform_device *pdev,=0A=
>> +		     struct imx_icc_node_desc *nodes,=0A=
>> +		     int nodes_count);=0A=
>> +int imx_icc_unregister(struct platform_device *pdev);=0A=
>> +=0A=
>> +#endif /* __DRIVERS_INTERCONNECT_IMX_H */=0A=
=0A=
