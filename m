Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86D6512440C
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 11:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfLRKNu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 05:13:50 -0500
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:57336
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbfLRKNu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Dec 2019 05:13:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2UgUqbn1hoZtsEbwueegj+a737V4bzYcUerZzW2qfeHyvnR7wL0o/0POAe+lbHLz0wK7FKmBnsW7qBNrcgp0QGFsSCyjrofMezstatiSqtpnt7nzo2+KqaBFtETVY/bk6kwBZ3oCnb/S3+oL7u9kYSqlGvfLZtT+nBC53SBimRu73ZTBgOO2u9PsRsIGnR+0Te89zTnmQl7x1Tdt5+EKkiccIpZnxbSe6l/nr3FAJv2Ic1Y8o5sRZBJQ6FI8zS0+K8X5t6h+kXpzX7TE5nZKSBF92ANet6q/tMxJmJcAK5y23F8sx7571WZOT/K/tv8eICapqqA5yhphPMve//1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xn/ZxTBaBAaDZAsPjn+2rDktcN7KRP50Wh4CQoSfqqc=;
 b=Nqi3bgRmfNLpMi4Bo9S+PaprvBAl1Kz9pvno+cjhiFCkjy+U46vFIF/ZzXctucmrEtxxW2N9UEtciGGyf+kuXk9YtaXSrFKSf02XEJcebryLMdvmT8WKP6pC4O95mgfG4MRvhjEQBGxZAhhki8MNgmuc8TfqaRCSGOkZf7Ehdz/anDEGtsdCrw7VPi3E+77MfAzU/a3rnBZIX87ygfweqo65n9M6FwDwTvBjoGEYHny5d8/0HlFvq5dJ0d4p+EOYyJwhXqQN99QKT9Ja13VrqvkODpYuEfpNTtCtGAF2G+3YWD+yE6eRqG+52Xf0PbbxU76XznC1v+jgcOXB1LqWcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xn/ZxTBaBAaDZAsPjn+2rDktcN7KRP50Wh4CQoSfqqc=;
 b=GPf2sCHgZzGxueuBYoK8BkyOBWbGIkeo1HepK5b8CSkE48QVnQoziJ/V4Xkvp44yXYgiU3tF8LBXIafjsP8Y+MBFK+1IuxiiyopSzbUrvWRinWFW8LmNitDFQLUHBqpVcAdIwqd6y2VQCR4A41HMqgAc4ukn9aFGdozBfFAEjTE=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5056.eurprd04.prod.outlook.com (20.177.50.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 18 Dec 2019 10:13:44 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 10:13:44 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
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
Date:   Wed, 18 Dec 2019 10:13:44 +0000
Message-ID: <VI1PR04MB7023DAC69C8B4B7CF144F29EEE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573761527.git.leonard.crestez@nxp.com>
 <CGME20191114201049epcas5p370853a1d78584bf00d8493ce20320bf9@epcas5p3.samsung.com>
 <e0e6a1685ccdad95c9d0c922801afdda8adb9f05.1573761527.git.leonard.crestez@nxp.com>
 <4d45cd39-24df-1714-0a27-5019c1367063@samsung.com>
 <VI1PR04MB7023F511BAE7D1EDF971CC48EE510@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <60fe19c6-6e73-4133-ed7e-a13a875589c0@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [2a04:241e:500:9200:9d5e:ad7d:41e0:989]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9dc84553-3088-4dda-f653-08d783a2f6ea
x-ms-traffictypediagnostic: VI1PR04MB5056:|VI1PR04MB5056:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5056853CC7847ED32F5EDA45EE530@VI1PR04MB5056.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(51444003)(189003)(199004)(7696005)(81166006)(81156014)(33656002)(54906003)(5660300002)(86362001)(8676002)(44832011)(4326008)(186003)(7416002)(71200400001)(64756008)(66476007)(53546011)(91956017)(66946007)(52536014)(2906002)(6506007)(316002)(478600001)(76116006)(110136005)(9686003)(8936002)(66446008)(66556008)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5056;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uQs+bnRlX37yPajnJHvrGo8lBFwRM7CZnrZVZNvYzt60o1VPaFR6JribkR20XgI0CjBboBPOlkhVgAWfe1c7IagmYIycs2lCJoBxKedt/M1zYiJQUtX8iYT0MzHNWM9p1L4JzYCzDc/rfSzDAvO9kyglFxtbtO1dfFPoUJsNz336PF503XljLIITNVRjF47IiSv+e8+bZkKCr0FRrn0sWY/rjleBjrwMW5PWq1/oRQ4UpEY0ziFsk0zP5m712tCbDRNWbn4T0/hSd999EZ1W4TKV5D+CZCZl8Z/euIXMi9+BUL0VJC5yM+wChQtogz6LQavejggxxyrfSCxHbPC/upXRAhAYYWT47JCqbANZQYJb7d7S7ENJy5wEdSkhzXsclb10FaWPrjEcubTcRQz+NvQz3IyaBz8D599Xgr8ZAJ+jjfGQIa8d2HBuMlqX9OB59vo81NwIeaI/FobkGXIh7XzNTaFA30REeDL9GN48mtIP574r1gbxnR3hN07QZCrI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc84553-3088-4dda-f653-08d783a2f6ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 10:13:44.4369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OU2doQwDWcqLoO6GYzkuUUAvyDcgCssbfba3djVBGccSBFLzmYWMJBFOXxXe/sEA38CXKXfsUc70DzI73008cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5056
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17.12.2019 02:55, Chanwoo Choi wrote:=0A=
> On 12/17/19 12:00 AM, Leonard Crestez wrote:=0A=
>> On 13.12.2019 06:22, Chanwoo Choi wrote:=0A=
>>> Hi,=0A=
>>>=0A=
>>> On 11/15/19 5:09 AM, Leonard Crestez wrote:=0A=
>>>> There is no single device which can represent the imx interconnect.=0A=
>>>> Instead of adding a virtual one just make the main &noc act as the=0A=
>>>> global interconnect provider.=0A=
>>>>=0A=
>>>> The imx interconnect provider driver will scale the NOC and DDRC based=
=0A=
>>>> on bandwidth request. More scalable nodes can be added in the future,=
=0A=
>>>> for example for audio/display/vpu/gpu NICs.=0A=
>>>>=0A=
>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>>>> ---=0A=
>>>>    drivers/devfreq/imx-devfreq.c | 37 ++++++++++++++++++++++++++++++++=
+++=0A=
>>>>    1 file changed, 37 insertions(+)=0A=
>>>>=0A=
>>>> diff --git a/drivers/devfreq/imx-devfreq.c b/drivers/devfreq/imx-devfr=
eq.c=0A=
>>>> index 620b344e87aa..585d340c0f6e 100644=0A=
>>>> --- a/drivers/devfreq/imx-devfreq.c=0A=
>>>> +++ b/drivers/devfreq/imx-devfreq.c=0A=
>>>> @@ -15,10 +15,11 @@=0A=
>>>>    struct imx_devfreq {=0A=
>>>>    	struct devfreq_dev_profile profile;=0A=
>>>>    	struct devfreq *devfreq;=0A=
>>>>    	struct clk *clk;=0A=
>>>>    	struct devfreq_passive_data passive_data;=0A=
>>>> +	struct platform_device *icc_pdev;=0A=
>>>>    };=0A=
>>>>    =0A=
>>>>    static int imx_devfreq_target(struct device *dev,=0A=
>>>>    			      unsigned long *freq, u32 flags)=0A=
>>>>    {=0A=
>>>> @@ -60,11 +61,40 @@ static int imx_devfreq_get_dev_status(struct devic=
e *dev,=0A=
>>>>    	return 0;=0A=
>>>>    }=0A=
>>>>    =0A=
>>>>    static void imx_devfreq_exit(struct device *dev)=0A=
>>>>    {=0A=
>>>> +	struct imx_devfreq *priv =3D dev_get_drvdata(dev);=0A=
>>>> +=0A=
>>>>    	dev_pm_opp_of_remove_table(dev);=0A=
>>>> +	platform_device_unregister(priv->icc_pdev);=0A=
>>>> +}=0A=
>>>> +=0A=
>>>> +/* imx_devfreq_init_icc() - register matching icc provider if require=
d */=0A=
>>>> +static int imx_devfreq_init_icc(struct device *dev)=0A=
>>>> +{=0A=
>>>> +	struct imx_devfreq *priv =3D dev_get_drvdata(dev);=0A=
>>>> +	const char *icc_driver_name;=0A=
>>>> +=0A=
>>>> +	if (!IS_ENABLED(CONFIG_INTERCONNECT_IMX))=0A=
>>>> +		return 0;=0A=
>>>=0A=
>>> It is not proper to check the enable state of CONFIG_INTERCONNECT_IMX c=
onfiguration=0A=
>>> on device driver. Why don't you add the 'select CONFIG_INTERCONNECT_IMX=
' on Kconfig?=0A=
>>=0A=
>> Because it's optional.=0A=
>>=0A=
>> You can disable interconnect support and just tweak frequencies using=0A=
>> the devfreq sysfs API. But indeed would only really be useful for debugg=
ing.=0A=
> =0A=
> Even if it's optional, I don't prefer to use 'IS_ENABLED' macro.=0A=
> =0A=
> Generally, add or delete the property or value at DT file=0A=
> to either enable or disable the some feature provided by device driver=0A=
> instead of checking the configuration.=0A=
> =0A=
> If user adds the property/value related to interconnect=0A=
> and imx-bus.c configuration is enabled, the behavior=0A=
> related to interconnect on imx-bus.c doesn't work. It make some confusion=
.=0A=
=0A=
Maybe I could print a warning if #interconnect-cells is present but =0A=
CONFIG_INTERCONNECT_IMX is off?=0A=
=0A=
An explicit select in Kconfig seems like a pointless limitation but in =0A=
practice it would almost never be useful to build one without the other.=0A=
=0A=
> The imx-bus.c have to add the 'select CONFIG_INTERCONNECT_IMX'=0A=
> and hand over the right which use the interconnect feature or not, to use=
r.=0A=
> =0A=
> If there are any requirement to add the additional property=0A=
> to check whether interconnect feature will be used or not,=0A=
> you can add the extra property. But, I think that it is enough=0A=
> to check the '#interconnect-cells'.=0A=
> =0A=
> In result, I think that it is right to decide the usage of feature=0A=
> of device driver by user on Devicetree.=0A=
> =0A=
>>=0A=
>>>> +	if (!of_get_property(dev->of_node, "#interconnect-cells", 0))=0A=
>>>> +		return 0;=0A=
>>>> +=0A=
>>>> +	icc_driver_name =3D of_device_get_match_data(dev);=0A=
>>>> +	if (!icc_driver_name)=0A=
>>>> +		return 0;=0A=
>>>> +=0A=
>>>> +	priv->icc_pdev =3D platform_device_register_data(=0A=
>>>> +			dev, icc_driver_name, 0, NULL, 0);=0A=
>>>> +	if (IS_ERR(priv->icc_pdev)) {=0A=
>>>> +		dev_err(dev, "failed to register icc provider %s: %ld\n",=0A=
>>>> +				icc_driver_name, PTR_ERR(priv->devfreq));=0A=
>>>> +		return PTR_ERR(priv->devfreq);=0A=
>>>> +	}=0A=
>>>> +=0A=
>>>> +	return 0;=0A=
>>>>    }=0A=
>>>>    =0A=
>>>>    static int imx_devfreq_probe(struct platform_device *pdev)=0A=
>>>>    {=0A=
>>>>    	struct device *dev =3D &pdev->dev;=0A=
>>>> @@ -120,18 +150,25 @@ static int imx_devfreq_probe(struct platform_dev=
ice *pdev)=0A=
>>>>    		ret =3D PTR_ERR(priv->devfreq);=0A=
>>>>    		dev_err(dev, "failed to add devfreq device: %d\n", ret);=0A=
>>>>    		goto err;=0A=
>>>>    	}=0A=
>>>>    =0A=
>>>> +	ret =3D imx_devfreq_init_icc(dev);=0A=
>>>> +	if (ret)=0A=
>>>> +		goto err;=0A=
>>>> +=0A=
>>>>    	return 0;=0A=
>>>>    =0A=
>>>>    err:=0A=
>>>>    	dev_pm_opp_of_remove_table(dev);=0A=
>>>>    	return ret;=0A=
>>>>    }=0A=
>>>>    =0A=
>>>>    static const struct of_device_id imx_devfreq_of_match[] =3D {=0A=
>>>> +	{ .compatible =3D "fsl,imx8mq-noc", .data =3D "imx8mq-interconnect",=
 },=0A=
>>>> +	{ .compatible =3D "fsl,imx8mm-noc", .data =3D "imx8mm-interconnect",=
 },=0A=
>>>> +	{ .compatible =3D "fsl,imx8mn-noc", .data =3D "imx8mn-interconnect",=
 },=0A=
>>>>    	{ .compatible =3D "fsl,imx8m-noc", },=0A=
>>>>    	{ .compatible =3D "fsl,imx8m-nic", },=0A=
>>>>    	{ /* sentinel */ },=0A=
>>>>    };=0A=
>>>>    MODULE_DEVICE_TABLE(of, imx_devfreq_of_match);=0A=
>>=0A=
>>=0A=
> =0A=
> =0A=
=0A=
