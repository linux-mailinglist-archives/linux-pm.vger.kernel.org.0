Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B768120925
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 16:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfLPPAU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 10:00:20 -0500
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:46557
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728190AbfLPPAT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Dec 2019 10:00:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJzWFNHLOmfw/JcGnGFm4VFcX7VLWZA/Sk1nASY+LC1F6oSqCrwGp2wApvquYLcyxs9XKQbNne0FYWT3gdAc587yZfW7iMY7Y+AAyQFCiJHE8z5HyTqBDbnvF5Zh2/mij/QB05FKG0EHpKFNvdYnu6ENK5YDaDt5yEfrLIYVP34sMDXSFuIsnqaMSAAuv6+wKzKGhjzI54MumDfWwd3ww34PNPBvZ8bRsanh8WsdPz37EdyDSGfL8EpqKperHkUG9fooXtVRtILIyzp2+h1Fc+55ohUpaFFz7uLc09/yYfWz8WwiWB9CwI76nTVmaCIQWKKWH201UL8JEqEMR9GcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfNepnL8buTDc+Hu8Ko6tEcLEA07C7uyvIytlRIfbWY=;
 b=LuwECGLuXh1DbEf2FyBrUT7gbk4meDslmZh2NvWLXLlTnvebJr+65olKjpxAeBKWky3U6gte/KXFuKgwwnir6155c7Ptfho0MhM01HKMP36u4mB69xaFtIhQ8qT8I7d8WkopcMKVORn+d2K7x5/omMJvq08iWsdlVPvgv8BXFBvg3p33wbJLlqrZPNdoUxsgyG41Srsr2VyN/kWjbT/BjBbxoMBO9uoweXsmg50tHqzeztKc95Om53mcwL3Aq8bCK7hQmAknnwi7P20S3eDuUTH3s3cD+JUsH4eZ7vRzanYGIJLWRx3yoTyN6+D/Uq7pgNyWWENI8AdPukaJtggJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfNepnL8buTDc+Hu8Ko6tEcLEA07C7uyvIytlRIfbWY=;
 b=NNvLXvEbTVCauem5wRQBkuKfQ7UHvS16uqQtSToy/HYJSU+iq4+KIEnQGZ4ft42trJLUXexJ7Qaz7AEE6+m/vj3zrm+IJuVRzFqevDpxQ8n0ibAO/Yfqz0R6YO9/53tcEzzZ/bvDILPHhzMO8AkUq++s7BfExtcG2MgRw927M7o=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6925.eurprd04.prod.outlook.com (52.133.246.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Mon, 16 Dec 2019 15:00:15 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 15:00:15 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
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
Subject: Re: [PATCH RFC v6 3/9] PM / devfreq: imx: Register interconnect
 device
Thread-Topic: [PATCH RFC v6 3/9] PM / devfreq: imx: Register interconnect
 device
Thread-Index: AQHVmyeZRYeaOo08e0y/DVNQANceVQ==
Date:   Mon, 16 Dec 2019 15:00:14 +0000
Message-ID: <VI1PR04MB7023F511BAE7D1EDF971CC48EE510@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573761527.git.leonard.crestez@nxp.com>
 <CGME20191114201049epcas5p370853a1d78584bf00d8493ce20320bf9@epcas5p3.samsung.com>
 <e0e6a1685ccdad95c9d0c922801afdda8adb9f05.1573761527.git.leonard.crestez@nxp.com>
 <4d45cd39-24df-1714-0a27-5019c1367063@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3f674cc-8aff-4354-56a5-08d78238a861
x-ms-traffictypediagnostic: VI1PR04MB6925:|VI1PR04MB6925:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB692515D8FD41DBC1CB4F8154EE510@VI1PR04MB6925.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(189003)(199004)(76116006)(91956017)(110136005)(52536014)(55016002)(54906003)(44832011)(66946007)(26005)(66476007)(66556008)(64756008)(66446008)(2906002)(316002)(71200400001)(5660300002)(7696005)(8936002)(6506007)(81156014)(8676002)(81166006)(9686003)(4326008)(53546011)(478600001)(186003)(33656002)(86362001)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6925;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KX1vIoyuYZcVylHjekncO4NrM7Y5IS/vlJnxNXPdimBaZGRoTr1Q+r5c00DJc+kWxe102vvGtibaZ0jZvr8KcP6Sw90ggJTGuzJYvRRlQC3zqqvL23EUbJnFBlQCBZJ9QjjKPPHdx34KaOl9yGwK9X42MoDljdyb5wGfvicsXum1tdf9QXrdONM4QJQOkUtGCipRyvwgykpFf/cGob9Qa1Ozk5Rya575yXMExDbagr67/lPXkVdPGfXy635bgGZtMibcAJNzEN6F5hMLaa8XSo7zB4ufplWeMuE7IWi/pBaAUk81KwhTOpc5ytv1Gbg+EGPVMjqySAXikCHyz22qgpRu1Yj05ujFSnfpM/r4+afIpMJTgLICFFi4EnyGLM5JyDgp4KECnQZmYvj93EVXiRZuOInK4Kul+zoBKJx0xUQtBdiEfbb5ISKZ4W9ZkJDy
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f674cc-8aff-4354-56a5-08d78238a861
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 15:00:14.9382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: enHazzlzv3gDECOvlX2xslXJzmLJqQlxzPlJkRbqm0DGhR86G68xZfeIR+sjUHOn55iqlF1G6yEKXdSMianGWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6925
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13.12.2019 06:22, Chanwoo Choi wrote:=0A=
> Hi,=0A=
> =0A=
> On 11/15/19 5:09 AM, Leonard Crestez wrote:=0A=
>> There is no single device which can represent the imx interconnect.=0A=
>> Instead of adding a virtual one just make the main &noc act as the=0A=
>> global interconnect provider.=0A=
>>=0A=
>> The imx interconnect provider driver will scale the NOC and DDRC based=
=0A=
>> on bandwidth request. More scalable nodes can be added in the future,=0A=
>> for example for audio/display/vpu/gpu NICs.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   drivers/devfreq/imx-devfreq.c | 37 +++++++++++++++++++++++++++++++++++=
=0A=
>>   1 file changed, 37 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/devfreq/imx-devfreq.c b/drivers/devfreq/imx-devfreq=
.c=0A=
>> index 620b344e87aa..585d340c0f6e 100644=0A=
>> --- a/drivers/devfreq/imx-devfreq.c=0A=
>> +++ b/drivers/devfreq/imx-devfreq.c=0A=
>> @@ -15,10 +15,11 @@=0A=
>>   struct imx_devfreq {=0A=
>>   	struct devfreq_dev_profile profile;=0A=
>>   	struct devfreq *devfreq;=0A=
>>   	struct clk *clk;=0A=
>>   	struct devfreq_passive_data passive_data;=0A=
>> +	struct platform_device *icc_pdev;=0A=
>>   };=0A=
>>   =0A=
>>   static int imx_devfreq_target(struct device *dev,=0A=
>>   			      unsigned long *freq, u32 flags)=0A=
>>   {=0A=
>> @@ -60,11 +61,40 @@ static int imx_devfreq_get_dev_status(struct device =
*dev,=0A=
>>   	return 0;=0A=
>>   }=0A=
>>   =0A=
>>   static void imx_devfreq_exit(struct device *dev)=0A=
>>   {=0A=
>> +	struct imx_devfreq *priv =3D dev_get_drvdata(dev);=0A=
>> +=0A=
>>   	dev_pm_opp_of_remove_table(dev);=0A=
>> +	platform_device_unregister(priv->icc_pdev);=0A=
>> +}=0A=
>> +=0A=
>> +/* imx_devfreq_init_icc() - register matching icc provider if required =
*/=0A=
>> +static int imx_devfreq_init_icc(struct device *dev)=0A=
>> +{=0A=
>> +	struct imx_devfreq *priv =3D dev_get_drvdata(dev);=0A=
>> +	const char *icc_driver_name;=0A=
>> +=0A=
>> +	if (!IS_ENABLED(CONFIG_INTERCONNECT_IMX))=0A=
>> +		return 0;=0A=
> =0A=
> It is not proper to check the enable state of CONFIG_INTERCONNECT_IMX con=
figuration=0A=
> on device driver. Why don't you add the 'select CONFIG_INTERCONNECT_IMX' =
on Kconfig?=0A=
=0A=
Because it's optional.=0A=
=0A=
You can disable interconnect support and just tweak frequencies using =0A=
the devfreq sysfs API. But indeed would only really be useful for debugging=
.=0A=
=0A=
>> +	if (!of_get_property(dev->of_node, "#interconnect-cells", 0))=0A=
>> +		return 0;=0A=
>> +=0A=
>> +	icc_driver_name =3D of_device_get_match_data(dev);=0A=
>> +	if (!icc_driver_name)=0A=
>> +		return 0;=0A=
>> +=0A=
>> +	priv->icc_pdev =3D platform_device_register_data(=0A=
>> +			dev, icc_driver_name, 0, NULL, 0);=0A=
>> +	if (IS_ERR(priv->icc_pdev)) {=0A=
>> +		dev_err(dev, "failed to register icc provider %s: %ld\n",=0A=
>> +				icc_driver_name, PTR_ERR(priv->devfreq));=0A=
>> +		return PTR_ERR(priv->devfreq);=0A=
>> +	}=0A=
>> +=0A=
>> +	return 0;=0A=
>>   }=0A=
>>   =0A=
>>   static int imx_devfreq_probe(struct platform_device *pdev)=0A=
>>   {=0A=
>>   	struct device *dev =3D &pdev->dev;=0A=
>> @@ -120,18 +150,25 @@ static int imx_devfreq_probe(struct platform_devic=
e *pdev)=0A=
>>   		ret =3D PTR_ERR(priv->devfreq);=0A=
>>   		dev_err(dev, "failed to add devfreq device: %d\n", ret);=0A=
>>   		goto err;=0A=
>>   	}=0A=
>>   =0A=
>> +	ret =3D imx_devfreq_init_icc(dev);=0A=
>> +	if (ret)=0A=
>> +		goto err;=0A=
>> +=0A=
>>   	return 0;=0A=
>>   =0A=
>>   err:=0A=
>>   	dev_pm_opp_of_remove_table(dev);=0A=
>>   	return ret;=0A=
>>   }=0A=
>>   =0A=
>>   static const struct of_device_id imx_devfreq_of_match[] =3D {=0A=
>> +	{ .compatible =3D "fsl,imx8mq-noc", .data =3D "imx8mq-interconnect", }=
,=0A=
>> +	{ .compatible =3D "fsl,imx8mm-noc", .data =3D "imx8mm-interconnect", }=
,=0A=
>> +	{ .compatible =3D "fsl,imx8mn-noc", .data =3D "imx8mn-interconnect", }=
,=0A=
>>   	{ .compatible =3D "fsl,imx8m-noc", },=0A=
>>   	{ .compatible =3D "fsl,imx8m-nic", },=0A=
>>   	{ /* sentinel */ },=0A=
>>   };=0A=
>>   MODULE_DEVICE_TABLE(of, imx_devfreq_of_match);=0A=
