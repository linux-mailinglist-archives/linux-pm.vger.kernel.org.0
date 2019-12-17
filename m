Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1CB122ED3
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2019 15:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfLQOd6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 09:33:58 -0500
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:10086
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727029AbfLQOd6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Dec 2019 09:33:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAFNgzKIJoRvNuhTqtN+AEnIfYt3BaHIb1xlz63RafhKFB2Py6AkQXj/+SbW/pxo6Q+8rGUAkhEB+kRuRewuw+3d17s2pyGE28rt+vJ5FNq1D5rIlJh9aiduIXfPI/R1rEicjACSg7qaBvc4Am3WlM2epSseZPZc3BsT0CkcHUnCyFoM4GpsiwXmRfOQld1dFZurCwg2kJ60O9IbgOP/MOfe0l92y7YIJEu2BqlBKSA1iFg+TJzSqBwLmCbLRvmQO1gRg0G07bnQktg11SJABmQGz8zYW/NhB8YvUyJT0YXkrpticDkElEFy1C80f1YgC+Vb5tAvwkp8vkkDhV347Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a67BXvFyL5lSprSXzZpMAHmyDRdW/sb9BrE3UvsM554=;
 b=m8zkFz++YpeGQyTjQQPJqRfzZGfJbPM+sVDcbR2yRbsWQgBIfAMVEWmrFioHaPDpPMjINNOfJ/x9eifLUqpSDypc/wXlykBqumV4i3kcPUKD+hsjDiBWbfyffw2hKlL4mfXlKM2V9ekZNWoqa059342EOREogCyipKX/owCec5r2kKi65ysSHvhcMnX8uQ+WfA92bDuuSpf9njNcHBejpE1wnyHvzXQrZGgv++QZZVp69EQQT/2NmQXAkI/uC9zwNRNMqKAstjhUDMAuTek/u1T/q40mctWEZSb1VCCZ8h6fdk4pmIMZdFa0tV23puBpyZvzIWPRKGzjcpUTnQ+hyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a67BXvFyL5lSprSXzZpMAHmyDRdW/sb9BrE3UvsM554=;
 b=VZf0Iayo2fYacEUCid43vgViRZXQiK8CcDk2PbIhvsAGmu4PPoTG8Hfg7vvU7CPbpBVuTzMUJ4thqz+m+rWw0LCWrRb6ziP2aHyDZ9NGUZdX5GCRvoCVWIdPoSamG6meOZpoTlt3AoZWIxdarLULrVPhxApFPDoSDj4JjMSAkEo=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5359.eurprd04.prod.outlook.com (20.178.122.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Tue, 17 Dec 2019 14:33:52 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 14:33:52 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
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
Subject: Re: [PATCH 2/9] PM / devfreq: Remove devfreq_get_devfreq_by_phandle
 function
Thread-Topic: [PATCH 2/9] PM / devfreq: Remove devfreq_get_devfreq_by_phandle
 function
Thread-Index: AQHVtJ3+QgbB6+oDD0SBl418fSrNCQ==
Date:   Tue, 17 Dec 2019 14:33:52 +0000
Message-ID: <VI1PR04MB70231FA16F12ACA3A3C01772EE500@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <20191217055738.28445-1-cw00.choi@samsung.com>
 <CGME20191217055105epcas1p2d2930402a559e381a7854f515a683d15@epcas1p2.samsung.com>
 <20191217055738.28445-3-cw00.choi@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87c4335f-9303-4162-ffab-08d782fe2352
x-ms-traffictypediagnostic: VI1PR04MB5359:
x-microsoft-antispam-prvs: <VI1PR04MB53598C0A2E09F242C3EBE713EE500@VI1PR04MB5359.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(8676002)(478600001)(6506007)(53546011)(86362001)(52536014)(5660300002)(186003)(8936002)(4326008)(81156014)(91956017)(55016002)(316002)(7416002)(76116006)(54906003)(110136005)(66946007)(66446008)(9686003)(64756008)(26005)(66556008)(66476007)(2906002)(44832011)(33656002)(7696005)(71200400001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5359;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kaGmMq+qiqRfPVQdn72HkdkScAhoAYVLa3DcRyr26+4wclZT/udrnlICDOwuJOQqkqtzG7CjIGdL/xd4wPPMoFdH+kPvaR6QCkX5ya+reIsDyD3Fr9YjVgnuxlgCNu8+YByclMIf9eGhjMDVvwtFuLY3BdryN/2Nasdawn81ZRyegeSJptP0puza1I0c2bTUPcear6VZwEYt5jfwIkrENCrxdyav2YCA7IXzFzZJ3ji6XZi5r7inpnSAlEMZt2Wsg0gUBwmyMI849UyT2j9n3j83CsXwCj9tJEe6gKms8JtmhbV96xaOp2u44cwVSyQ6lS89E8LxK8ogXmrnv5dUN/LfcLWnZlkFAq21h1IKutnIWV7PQwS9MrvDz/YCO+GRINmssKz97y/Pfub4QksBK+fBpIbpuUDEOHjUr7gTmVM9VAlw7g/kFvh9OEKZ3Q+V
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c4335f-9303-4162-ffab-08d782fe2352
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 14:33:52.0428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hD8RERiaMu7LEB27PHVR24KtbWvJDBWmUGf0gwwyfvvy1uHj12fk8lTfZXyEPD8VpnL3ycjOkskGVRqsYz35yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5359
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17.12.2019 07:51, Chanwoo Choi wrote:=0A=
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
>   drivers/devfreq/exynos-bus.c | 14 ++++++++++++--=0A=
>   include/linux/devfreq.h      |  8 --------=0A=
>   3 files changed, 12 insertions(+), 45 deletions(-)=0A=
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
> index 7f5917d59072..9aac2db956d5 100644=0A=
> --- a/drivers/devfreq/exynos-bus.c=0A=
> +++ b/drivers/devfreq/exynos-bus.c=0A=
> @@ -146,6 +146,16 @@ static int exynos_bus_get_dev_status(struct device *=
dev,=0A=
>   	return ret;=0A=
>   }=0A=
>   =0A=
> +static struct devfreq *get_parent_devfreq_by_node(struct device_node *np=
)=0A=
> +{=0A=
> +	struct device_node *node =3D of_parse_phandle(np, "devfreq", 0);=0A=
> +=0A=
> +	if (!node)=0A=
> +		return ERR_PTR(-ENODEV);=0A=
> +=0A=
> +	return devfreq_get_devfreq_by_node(node);=0A=
> +}=0A=
=0A=
The _by_node suffix here is confusing because it actually fetches a =0A=
property of the node unlike devfreq_get_devfreq_by_node. Maybe call this =
=0A=
get_parent_devfreq_from_node?=0A=
=0A=
Since it's a static function it could just be called get_parent_devfreq?=0A=
=0A=
> +=0A=
>   static void exynos_bus_exit(struct device *dev)=0A=
>   {=0A=
>   	struct exynos_bus *bus =3D dev_get_drvdata(dev);=0A=
> @@ -353,8 +363,8 @@ static int exynos_bus_profile_init_passive(struct exy=
nos_bus *bus,=0A=
>   	profile->exit =3D exynos_bus_passive_exit;=0A=
>   =0A=
>   	/* Get the instance of parent devfreq device */=0A=
> -	parent_devfreq =3D devfreq_get_devfreq_by_phandle(dev, 0);=0A=
> -	if (IS_ERR(parent_devfreq))=0A=
> +	parent_devfreq =3D get_parent_devfreq_by_node(dev->of_node);=0A=
> +	if (IS_ERR(parent_devfreq)) {=0A=
>   		return -EPROBE_DEFER;=0A=
>   =0A=
>   	passive_data =3D devm_kzalloc(dev, sizeof(*passive_data), GFP_KERNEL);=
=0A=
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h=0A=
> index e3633ae43349..3ed96426302e 100644=0A=
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
> @@ -413,12 +411,6 @@ struct devfreq *devfreq_get_devfreq_by_node(struct d=
evice_node *node)=0A=
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
