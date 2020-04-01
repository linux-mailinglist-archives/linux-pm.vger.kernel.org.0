Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38ECD19ADAE
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 16:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732787AbgDAOUF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 10:20:05 -0400
Received: from mail-vi1eur05on2076.outbound.protection.outlook.com ([40.107.21.76]:6209
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732852AbgDAOUF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Apr 2020 10:20:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKi9NojMqLuHMjNfVTZ0v+bb/47av/1Ku9nHE7cFOjPnVo6BhnR95kTRoOZOYoyyMIJZ7LedD4/+RLY/DUFlGaGl0E1IKn8TSSIG7uttCFJFw0StnGVZwElSnMsaM/zmIMEiCzcJNQU3+SuShW7eg3b7VRTO889QZRlNSF7gtBwobraGFBtOWxdWondl4Bq61opkr6ft7p/JSlrtteCR3OgV6izPAajFrYcvMHrha1w2VXNqD6h1rKpUk6kjN0ZpH6ZFNO77TiRzIi3C+uYVGNf+cABgl7D6aChxqnKehGNdEjhGEBoAjKB8BDr9OmZZu+3LkbnJmfwkCM6tzIGoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZON0vePQo02YO9wOK93g9/7aoG+gBPSD0Us18yyTo4=;
 b=CKmh2M7sIhloTngceT/kY6h07K+HUTAeZ6SyUQZlYamvWdIuhlU/DcZ9fJtIXg+8TZf5xLctK8mGhojfJEOMPKhiwSk6c+j+731X1Ae8DYm22sbGZ173ex3qqSxHZkrwqi55+v7jEg/FDbQPjU26J06jmcdOIElAuZFtF+qRv4ctBVqxONTBPqZ8s7/EarKDFdbzVZQUQfreU/eqB0B291YRSFI8h1cbccxKjHwj/PJrGIDNtyfLR1PmxSEmeF9pull3avJF2Wt+otG9nygF33DA2MmSUH/FnrYMZknmL7+akpn70MbkXi34oRv3dHf1TQ/6yfSaWZDmsuCRF2M1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZON0vePQo02YO9wOK93g9/7aoG+gBPSD0Us18yyTo4=;
 b=DJmiU5Ak8N/GoSXgNN6WY9M3ocz8kbx10MtmPwbo8LACFVFR32mr4eXymGVD7DQqcYYAsmZb/++rzXq50nkQ66juEbP1vz4N29xXX2XXQcghlugpbJY9BfJMXw1qAQGVLpfnFBMQ4OSiBZksjoPR1hbd0Q3fwzhSVrneCn/qJZ4=
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com (52.133.244.87) by
 VI1PR04MB6960.eurprd04.prod.outlook.com (52.133.244.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Wed, 1 Apr 2020 14:19:25 +0000
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200]) by VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200%2]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 14:19:25 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Kepplinger <martink@posteo.de>
CC:     =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@samsung.com>,
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
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/8] PM / devfreq: imx: Register interconnect device
Thread-Topic: [PATCH 3/8] PM / devfreq: imx: Register interconnect device
Thread-Index: AQHWAxSP9L4B6rBWik25MwbLPhOt4g==
Date:   Wed, 1 Apr 2020 14:19:25 +0000
Message-ID: <VI1PR04MB69415B72B48122BB3B6FC85AEEC90@VI1PR04MB6941.eurprd04.prod.outlook.com>
References: <cover.1585188174.git.leonard.crestez@nxp.com>
 <CGME20200326021638epcas1p1626d266c8dcfa051b7c590838e62b097@epcas1p1.samsung.com>
 <f4553b6aacc88a91ed407eb709097e2cd1bf1a19.1585188174.git.leonard.crestez@nxp.com>
 <ea021693-c22b-27be-8346-011673ae0831@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ece15031-f705-43dd-aeb4-08d7d647ae65
x-ms-traffictypediagnostic: VI1PR04MB6960:|VI1PR04MB6960:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6960BD37AB24134FE9D18BDEEEC90@VI1PR04MB6960.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(6506007)(71200400001)(26005)(44832011)(66946007)(91956017)(186003)(33656002)(7696005)(5660300002)(66476007)(66446008)(52536014)(76116006)(478600001)(2906002)(53546011)(316002)(81156014)(86362001)(7416002)(8676002)(55016002)(81166006)(64756008)(54906003)(110136005)(4326008)(9686003)(66556008)(8936002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dsn7uqGUvSINYnBRO1RISB8rbaKjL3E3VKaCOiQOtw7pdoZlS/y0ko2vQJvSzGjaP5SZmKqHVB56AAbUCnZdJIDo7iZEz47y2vZHpc+jmkFD5kBuEPhIOg0hEi/4CK11bhGE3Xio+AOVVuoUBwqtJzx4E9DSFOizkwTqL6EujL4VFUs+CljnaRktGQRYPlHfNEI/kUEUSSWogfVg9cCeDg22KWVdIPgUF3IptDg2RJyrjJVxayYZlpA8fpYGuqjGzZ1F6701ABuZb82ArAp/9hp3auV6AeUV4Ym4CwUsR2aH8acfwpzkf8U+SlbCwgTvUS8+w4QBa2MYKdkxBXD7NY7Ewws9iPgsrj0qEZfvQev6YptPCgNutgOPbLEMoztnx5VKlGiURpeWXiBJx5JlxpmLJyY9eRG3CRKurpgN0+Qhz+rhOFOyu1gGZydHupV+
x-ms-exchange-antispam-messagedata: UGKzLKN1sWh82zfGXenZgpsoH1Z/0UKp1YCORweF3eJmsLWGQYXZRMkSJ+mSwUGlvXSnXcwbt6G/AjsRlQkacHIj+w65oBS3VDQkOOd8JO/JHs2SFqhRAjmfAQjm8tIiVquz+hwQ7xen9Cda5vluKg==
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece15031-f705-43dd-aeb4-08d7d647ae65
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 14:19:25.1040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iCiCm/P5rGYcURX7aX7Te/GGlT1tBAUJjPSZxzbDmJZ4t3KMJxZfvmDtHSwr9K58JsB42oX8VSP80W/wilYqwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6960
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-04-01 2:00 AM, Chanwoo Choi wrote:=0A=
> Hi Leonard,=0A=
> =0A=
> On 3/26/20 11:16 AM, Leonard Crestez wrote:=0A=
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
>>   drivers/devfreq/imx-bus.c | 39 +++++++++++++++++++++++++++++++++++++++=
=0A=
>>   1 file changed, 39 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c=0A=
>> index 285e0f1ae6b1..e9b13e43bf0a 100644=0A=
>> --- a/drivers/devfreq/imx-bus.c=0A=
>> +++ b/drivers/devfreq/imx-bus.c=0A=
>> @@ -15,10 +15,11 @@=0A=
>>   struct imx_bus {=0A=
>>   	struct devfreq_dev_profile profile;=0A=
>>   	struct devfreq *devfreq;=0A=
>>   	struct clk *clk;=0A=
>>   	struct devfreq_passive_data passive_data;=0A=
>> +	struct platform_device *icc_pdev;=0A=
>>   };=0A=
>>   =0A=
>>   static int imx_bus_target(struct device *dev,=0A=
>>   		unsigned long *freq, u32 flags)=0A=
>>   {=0A=
>> @@ -60,11 +61,42 @@ static int imx_bus_get_dev_status(struct device *dev=
,=0A=
>>   	return 0;=0A=
>>   }=0A=
>>   =0A=
>>   static void imx_bus_exit(struct device *dev)=0A=
>>   {=0A=
>> +	struct imx_bus *priv =3D dev_get_drvdata(dev);=0A=
>> +=0A=
>>   	dev_pm_opp_of_remove_table(dev);=0A=
>> +	platform_device_unregister(priv->icc_pdev);=0A=
>> +}=0A=
>> +=0A=
>> +/* imx_bus_init_icc() - register matching icc provider if required */=
=0A=
> =0A=
> Better to add following comments without 'imx_bus_init_icc() -' comment.=
=0A=
> /* Register matching icc provider if required */=0A=
=0A=
This form looks like standard kernel-doc=0A=
=0A=
=0A=
>> +static int imx_bus_init_icc(struct device *dev)=0A=
>> +{=0A=
>> +	struct imx_bus *priv =3D dev_get_drvdata(dev);=0A=
>> +	const char *icc_driver_name;=0A=
>> +=0A=
>> +	if (!of_get_property(dev->of_node, "#interconnect-cells", 0))=0A=
>> +		return 0;=0A=
>> +	if (!IS_ENABLED(CONFIG_INTERCONNECT_IMX)) {=0A=
>> +		dev_warn(dev, "imx interconnect drivers disabled\n");=0A=
>> +		return 0;=0A=
>> +	}=0A=
>> +=0A=
>> +	icc_driver_name =3D of_device_get_match_data(dev);=0A=
>> +	if (!icc_driver_name)=0A=
>> +		return 0;=0A=
> =0A=
> Recommend to add the error or warning message.=0A=
=0A=
Makes sense, imx8m-nic shouldn't have #interconnect-cells so if this =0A=
condition is reach an error should be printed.=0A=
=0A=
>> +=0A=
>> +	priv->icc_pdev =3D platform_device_register_data(=0A=
>> +			dev, icc_driver_name, -1, NULL, 0);=0A=
>> +	if (IS_ERR(priv->icc_pdev)) {=0A=
>> +		dev_err(dev, "failed to register icc provider %s: %ld\n",=0A=
>> +				icc_driver_name, PTR_ERR(priv->devfreq));=0A=
>> +		return PTR_ERR(priv->devfreq);=0A=
>> +	}=0A=
>> +=0A=
>> +	return 0;=0A=
>>   }=0A=
>>   =0A=
>>   static int imx_bus_probe(struct platform_device *pdev)=0A=
>>   {=0A=
>>   	struct device *dev =3D &pdev->dev;=0A=
>> @@ -112,18 +144,25 @@ static int imx_bus_probe(struct platform_device *p=
dev)=0A=
>>   		ret =3D PTR_ERR(priv->devfreq);=0A=
>>   		dev_err(dev, "failed to add devfreq device: %d\n", ret);=0A=
>>   		goto err;=0A=
>>   	}=0A=
>>   =0A=
>> +	ret =3D imx_bus_init_icc(dev);=0A=
>> +	if (ret)=0A=
> =0A=
> Recommend to add the error message.=0A=
=0A=
imx_bus_init_icc already prints errors. Printing again here would always =
=0A=
result in a second message.=0A=
=0A=
>> +		goto err;=0A=
>> +=0A=
>>   	return 0;=0A=
>>   =0A=
>>   err:=0A=
>>   	dev_pm_opp_of_remove_table(dev);=0A=
>>   	return ret;=0A=
>>   }=0A=
>>   =0A=
>>   static const struct of_device_id imx_bus_of_match[] =3D {=0A=
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
>>   MODULE_DEVICE_TABLE(of, imx_bus_of_match);=0A=
>>=0A=
