Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C124127289
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 01:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfLTArC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 19:47:02 -0500
Received: from mail-eopbgr20066.outbound.protection.outlook.com ([40.107.2.66]:17759
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726986AbfLTArC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 19:47:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmQ3X+Jub1TiczYr/rs2cEpD8gyE98ozKlvAPewzURVJ+tgcDd/utsc4hv0fnkMRaYuxu0oGzgDvdHv5bHUm6fMe2kxvTuW4gLGlYsg6kkDKc8ZbWlW+W6sHMMxUGgHhm8r3Ev/ZkVd+dpzSRj+G6JoMsaS6ewi+7eFT1MOcTHL9aOk5k/+PgxJu3KQJnX5jwuMuh+HdmAPjD6G6qBuGWalv8PaPMCdLV1Ra4nkr7i2SifMTToFOLP+3BFZDM62X/o1SQewyZntOzgxIwiYNIafd1eKcLIWpPR+w2HEI7aIIAs7ETqX2ck/ocj/R6YB82FO2jhqTvZUlvlzvsznLow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IYQhJ5t8iIeO1QLyP707096MFdjnkNprb9e5jTf9Vs=;
 b=Us8jGh07DfD40S/H0ckJMDHsfMrnOeklm7ztiGEn3f+pThVMfuE/gCQSB5t/m6t6r4fQzLm6+so0ZJqxHXBErOUhbg8pqpLvnC1KCcdnE2cfHvw0vL700Y/2DVoBB2BBz/l8I2OU1OVW8+eii0fKUtd9hp/sHREA9WTdQtDX1axyCO0xifqG5NuNsAm47qevPOcT/B3UhzLZVNXmYuv3REl+DsohbCg/0gGzI5s9hRnYxSL4aSZqmXqMnvJ2gy9kr0PadCBqn7bnFRlLaj1hzXjEXxIPh0ygi9MyeeXcgY8JzIU7NwxlGfyIWz6EBTVo9/FmAhf5+57Pr9FZppv3JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IYQhJ5t8iIeO1QLyP707096MFdjnkNprb9e5jTf9Vs=;
 b=KDAyDJt0j2Y1eIwDGck6pOndv3XP5jzODbxVo1hQpP57nLUalQNXAeL/q1E66riE8eHKdykrmU1iBFBvGo7N5gSO9VyASsLKY8J8i7oPY8K+MsMkRKgwrc04axep3SudNZw7XryIEv5CaqlITvh3jLZ9DjMPP4P0w8bVGXQot0Y=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4813.eurprd04.prod.outlook.com (20.177.48.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Fri, 20 Dec 2019 00:46:56 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2559.015; Fri, 20 Dec 2019
 00:46:56 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        "krzk@kernel.org" <krzk@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "a.swigon@samsung.com" <a.swigon@samsung.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "kgene@kernel.org" <kgene@kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v2 02/11] PM / devfreq: Remove
 devfreq_get_devfreq_by_phandle function
Thread-Topic: [PATCH v2 02/11] PM / devfreq: Remove
 devfreq_get_devfreq_by_phandle function
Thread-Index: AQHVtsr1Ef7RVp7/TE+8KfVTQarunQ==
Date:   Fri, 20 Dec 2019 00:46:55 +0000
Message-ID: <VI1PR04MB70235291D8E40CB6225A0AF0EE2D0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <20191220002430.11995-1-cw00.choi@samsung.com>
 <CGME20191220001759epcas1p4ce1c2017937a35de84eab720b9732df0@epcas1p4.samsung.com>
 <20191220002430.11995-3-cw00.choi@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [2a04:241e:500:9200:f805:7bf1:bfb9:4857]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6f70206-b096-4fe2-2e45-08d784e61d0f
x-ms-traffictypediagnostic: VI1PR04MB4813:
x-microsoft-antispam-prvs: <VI1PR04MB4813879429BF351C8A62246BEE2D0@VI1PR04MB4813.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(189003)(199004)(6506007)(53546011)(54906003)(5660300002)(2906002)(76116006)(66946007)(66476007)(7416002)(478600001)(186003)(7696005)(4326008)(44832011)(8676002)(8936002)(86362001)(81156014)(33656002)(81166006)(64756008)(52536014)(316002)(66446008)(66556008)(55016002)(9686003)(110136005)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4813;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I2lpvE5Z2Vg/tuhjjk0FI8Vu0SBeqtpeQSzAC8/JegKrepEKxkmf3kox//m/mi0L2cQR7ec/dPEGySlOkY8luARpqHj4McvZ8OX7JF+tuDd1UaWkO8L2lEH7bhlMOeHBbVOoX6neCt6+jpX0fm+BOxDrGNlUBDZLFsvNGHu5cEiDtRv1flnZfPYar6Ib3mEMTK4gVuWsQ6OjdD/OIMW4mbnQbL1HF2unsdLKaNGwtIJou8hOFml/Kqc1zXalAK0g4PQmyDE2VMDlrfFSAVbuxS+avCkbeJ0JWG0B+NIObPNswEst7X1jHcTW27MUFRpRaKtHFrOFAwm4s+pV8YVkqPZEWRbmKuAKyqcQj2o0Eh2KARWsRAhTy6jDuxHhBPKY4kWK4ZwESEFs8VUu8MAbsMrpAyoZkuZkK4+ejp0uRt/EcV75dyl74mn4jwdXn9Mr
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f70206-b096-4fe2-2e45-08d784e61d0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 00:46:55.9818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j21ZvpiOti20U8qq9H2DNxfyWiOA4g2hempYu20DHj6Tojn90aXvpJ1ox6mLg0FiZkHWU+ywqo/NkJViHihQeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4813
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20.12.2019 02:18, Chanwoo Choi wrote:=0A=
> Previously, devfreq core support 'devfreq' property in order to get=0A=
> the devfreq device by phandle. But, 'devfreq' property name is not proper=
=0A=
> on devicetree binding because this name doesn't mean the any h/w attribut=
e.=0A=
> =0A=
> The devfreq core hand over the right to decide the property name=0A=
> for getting the devfreq device on devicetree. Each devfreq driver=0A=
> will decide the property name on devicetree binding and then get=0A=
> the devfreq device by using devfreq_get_devfreq_by_node().=0A=
> =0A=
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>=0A=
> ---=0A=
>   drivers/devfreq/devfreq.c    | 35 -----------------------------------=
=0A=
>   drivers/devfreq/exynos-bus.c | 12 +++++++++++-=0A=
>   include/linux/devfreq.h      |  8 --------=0A=
>   3 files changed, 11 insertions(+), 44 deletions(-)=0A=
> =0A=
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c=0A=
> index cb8ca81c8973..c3d3c7c802a0 100644=0A=
> --- a/drivers/devfreq/devfreq.c=0A=
> +++ b/drivers/devfreq/devfreq.c=0A=
> @@ -991,48 +991,13 @@ struct devfreq *devfreq_get_devfreq_by_node(struct =
device_node *node)=0A=
>   =0A=
>   	return ERR_PTR(-ENODEV);=0A=
>   }=0A=
> -=0A=
> -/*=0A=
> - * devfreq_get_devfreq_by_phandle - Get the devfreq device from devicetr=
ee=0A=
> - * @dev - instance to the given device=0A=
> - * @index - index into list of devfreq=0A=
> - *=0A=
> - * return the instance of devfreq device=0A=
> - */=0A=
> -struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int i=
ndex)=0A=
> -{=0A=
> -	struct device_node *node;=0A=
> -	struct devfreq *devfreq;=0A=
> -=0A=
> -	if (!dev)=0A=
> -		return ERR_PTR(-EINVAL);=0A=
> -=0A=
> -	if (!dev->of_node)=0A=
> -		return ERR_PTR(-EINVAL);=0A=
> -=0A=
> -	node =3D of_parse_phandle(dev->of_node, "devfreq", index);=0A=
> -	if (!node)=0A=
> -		return ERR_PTR(-ENODEV);=0A=
> -=0A=
> -	devfreq =3D devfreq_get_devfreq_by_node(node);=0A=
> -	of_node_put(node);=0A=
> -=0A=
> -	return devfreq;=0A=
> -}=0A=
> -=0A=
>   #else=0A=
>   struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)=
=0A=
>   {=0A=
>   	return ERR_PTR(-ENODEV);=0A=
>   }=0A=
> -=0A=
> -struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int i=
ndex)=0A=
> -{=0A=
> -	return ERR_PTR(-ENODEV);=0A=
> -}=0A=
>   #endif /* CONFIG_OF */=0A=
>   EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_node);=0A=
> -EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_phandle);=0A=
>   =0A=
>   /**=0A=
>    * devm_devfreq_remove_device() - Resource-managed devfreq_remove_devic=
e()=0A=
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c=
=0A=
> index 7f5917d59072..1bc4e3c81115 100644=0A=
> --- a/drivers/devfreq/exynos-bus.c=0A=
> +++ b/drivers/devfreq/exynos-bus.c=0A=
> @@ -86,6 +86,16 @@ static int exynos_bus_get_event(struct exynos_bus *bus=
,=0A=
>   	return ret;=0A=
>   }=0A=
>   =0A=
> +static struct devfreq *exynos_bus_get_parent_devfreq(struct device_node =
*np)=0A=
> +{=0A=
> +	struct device_node *node =3D of_parse_phandle(np, "devfreq", 0);=0A=
> +=0A=
> +	if (!node)=0A=
> +		return ERR_PTR(-ENODEV);=0A=
> +=0A=
> +	return devfreq_get_devfreq_by_node(node);=0A=
=0A=
You need to call of_node_put(node) here and in several other places.=0A=
=0A=
The old devfreq_get_devfreq_by_phandle API handled this internally but =0A=
devfreq_get_devfreq_by_node doesn't.=0A=
=0A=
Maybe the _by_phandle API could be kept and just take the property name =0A=
instead of always using "devfreq"?=0A=
=0A=
> +}=0A=
> +=0A=
>   /*=0A=
>    * devfreq function for both simple-ondemand and passive governor=0A=
>    */=0A=
> @@ -353,7 +363,7 @@ static int exynos_bus_profile_init_passive(struct exy=
nos_bus *bus,=0A=
>   	profile->exit =3D exynos_bus_passive_exit;=0A=
>   =0A=
>   	/* Get the instance of parent devfreq device */=0A=
> -	parent_devfreq =3D devfreq_get_devfreq_by_phandle(dev, 0);=0A=
> +	parent_devfreq =3D exynos_bus_get_parent_devfreq(dev->of_node);=0A=
>   	if (IS_ERR(parent_devfreq))=0A=
>   		return -EPROBE_DEFER;=0A=
>   =0A=
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h=0A=
> index 1dccc47acbce..a4351698fb64 100644=0A=
> --- a/include/linux/devfreq.h=0A=
> +++ b/include/linux/devfreq.h=0A=
> @@ -254,8 +254,6 @@ extern void devm_devfreq_unregister_notifier(struct d=
evice *dev,=0A=
>   				struct notifier_block *nb,=0A=
>   				unsigned int list);=0A=
>   extern struct devfreq *devfreq_get_devfreq_by_node(struct device_node *=
node);=0A=
> -extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev=
,=0A=
> -						int index);=0A=
>   =0A=
>   #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)=0A=
>   /**=0A=
> @@ -413,12 +411,6 @@ static inline struct devfreq *devfreq_get_devfreq_by=
_node(struct device_node *no=0A=
>   	return ERR_PTR(-ENODEV);=0A=
>   }=0A=
>   =0A=
> -static inline struct devfreq *devfreq_get_devfreq_by_phandle(struct devi=
ce *dev,=0A=
> -							int index)=0A=
> -{=0A=
> -	return ERR_PTR(-ENODEV);=0A=
> -}=0A=
> -=0A=
>   static inline int devfreq_update_stats(struct devfreq *df)=0A=
>   {=0A=
>   	return -EINVAL;=0A=
> =0A=
=0A=
