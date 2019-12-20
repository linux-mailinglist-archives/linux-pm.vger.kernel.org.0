Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A321272E3
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 02:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLTBku (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 20:40:50 -0500
Received: from mail-eopbgr140084.outbound.protection.outlook.com ([40.107.14.84]:32898
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727024AbfLTBku (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 20:40:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXzfkDsHZQvvAybyER+a+UtT41ci/MiQNCuHKW9vN8R3k2CgfU9gdKa8bKTNxAEB7F8w1WWOjbMgkNmTm7Z9eCArVuJ6V092Ajjc3AqoVP0rjocBGKL/raMVqVnM9o8Lb/6/X7VbF2LZhFZkb7N1oEQSvU5EEF7UTw8fXsbiJdlvZjLMiLzgbagZSf7mXUxUJCD9kpVgd7ej+zzF5mv9/z/Fl1EHFBhpIj06dchUOmDGxQqp3ZHQDBFCj3byEgrYoGb2ixMDquidO9u/VSO8UEbNSIAAec4xZlGcnFq4yNESEcan19TvjLFjNSOAGROfZA1CS8URhlcaJjodPi6tVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGfyoNkDOUhTxHWDgsxnI7Cuzr1LiYe8XTYfCwZNPNo=;
 b=D64N3Io+BK63lq1PeOQtrOhpHQhE1JcNutykdPn/0zELohe9bIgxStQkn2X45lN5baRooX9pAw5kVRwGs6e6Gm/W8Whw3l2SSeBxZ9SpwgfG4aoS4hYB8k40ZKDGPHJaXw5I2ADoWpKzJjjW4RB4Theuqf6OXZAW3K1EE22U0rOUyZXJzAExUc6O8Ht/zTXWlz3HhFImgpXaHaX/5qWu+UYQreOu0iI7KDETqJWTiKEO2DKYa/VTgJK1p4dcgwTHj2EegWLoWRYUu1UhEPxscCLRtjHiK2skAPWhcd5Ilfi3qkc6LgeJ4JxO4+vsGQ7YR7G6BtN/0ENW4VCpFMl09g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGfyoNkDOUhTxHWDgsxnI7Cuzr1LiYe8XTYfCwZNPNo=;
 b=PapXLfr8OExqvruY7NhUuy1FzJ7Rta/+uSJWHZ8Ern8VTZR1BgSR/Bh6MLlOyaITprXxYnLYBZ33/F83agQwuE3wsR4YXCClk0EgSQhsBz9rmfp6epoI4V8WghdKcQmCcKZl7JKGFVRsHHfuGwdytwnbc9FMhQ3WZ4FCrFJQWd8=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5679.eurprd04.prod.outlook.com (20.178.204.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Fri, 20 Dec 2019 01:40:42 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2559.015; Fri, 20 Dec 2019
 01:40:42 +0000
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
Date:   Fri, 20 Dec 2019 01:40:42 +0000
Message-ID: <VI1PR04MB7023160888F88B5800A90189EE2D0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <20191220002430.11995-1-cw00.choi@samsung.com>
 <CGME20191220001759epcas1p4ce1c2017937a35de84eab720b9732df0@epcas1p4.samsung.com>
 <20191220002430.11995-3-cw00.choi@samsung.com>
 <VI1PR04MB70235291D8E40CB6225A0AF0EE2D0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <46e629e0-fee4-21a6-3baa-f347ff6417d8@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.3.179]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac34ac72-32fe-4605-8195-08d784eda011
x-ms-traffictypediagnostic: VI1PR04MB5679:
x-microsoft-antispam-prvs: <VI1PR04MB56798BEF1EEE51081717EEF3EE2D0@VI1PR04MB5679.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(199004)(189003)(53546011)(6506007)(76116006)(2906002)(55016002)(71200400001)(66446008)(66556008)(66946007)(64756008)(66476007)(9686003)(26005)(4001150100001)(186003)(316002)(7696005)(44832011)(5660300002)(4326008)(8676002)(478600001)(33656002)(8936002)(81166006)(7416002)(54906003)(52536014)(86362001)(81156014)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5679;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fXJemzerAYZ1m5hAQJkLaAFUCqvqaOnnyqmsbGa/UfeS0HGYejj2jPrkbkE7EuuTB9QFb/E43d/Ty64pG5I7XKhGWMN9nMcfZaItEgkKizFj5/+xc8brq04n8ixB+6UT0E6Go3bHzbVrxxgddKBdnS/c3CMGc3aCYubi4f+rt5HiuP8rCpkBJkB5SPQORb23G0mJEgt0tE3+ra3qkDh8Z5T6MqWu3lzxmZ6eQE4zG1WxWyOmicQy07k19XcsMlVCuqvC/HD+36/wPEin+CNhmVt+ewR5GAnp5YVPie8D4iMMQxlJalcRZb4xo1JkEUS+HJ4pNMeIG7X6+YYH6aWncG3Fb2lK5p+7Wj2LWuefolqr7oasH/FN4H/MHJVH7XOCe7DpaJ4RXfWP2t7qBMnRubPu4QfqXq9kiQr59ntwZcubaDa2INZ0+Ot01FkIWXn/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac34ac72-32fe-4605-8195-08d784eda011
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 01:40:42.3523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kL/sXX1K8QLkQT3YyKmgrC0OQPrgG4OgV3LJMyScTSK+2JJ4NC7JrN7NmUv6QYv5Dc3cZlm1T5usTadblNNmhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5679
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019-12-20 2:54 AM, Chanwoo Choi wrote:=0A=
> On 12/20/19 9:46 AM, Leonard Crestez wrote:=0A=
>> On 20.12.2019 02:18, Chanwoo Choi wrote:=0A=
>>> Previously, devfreq core support 'devfreq' property in order to get=0A=
>>> the devfreq device by phandle. But, 'devfreq' property name is not prop=
er=0A=
>>> on devicetree binding because this name doesn't mean the any h/w attrib=
ute.=0A=
>>>=0A=
>>> The devfreq core hand over the right to decide the property name=0A=
>>> for getting the devfreq device on devicetree. Each devfreq driver=0A=
>>> will decide the property name on devicetree binding and then get=0A=
>>> the devfreq device by using devfreq_get_devfreq_by_node().=0A=
>>>=0A=
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>=0A=
>>> ---=0A=
>>>    drivers/devfreq/devfreq.c    | 35 ----------------------------------=
-=0A=
>>>    drivers/devfreq/exynos-bus.c | 12 +++++++++++-=0A=
>>>    include/linux/devfreq.h      |  8 --------=0A=
>>>    3 files changed, 11 insertions(+), 44 deletions(-)=0A=
>>>=0A=
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c=0A=
>>> index cb8ca81c8973..c3d3c7c802a0 100644=0A=
>>> --- a/drivers/devfreq/devfreq.c=0A=
>>> +++ b/drivers/devfreq/devfreq.c=0A=
>>> @@ -991,48 +991,13 @@ struct devfreq *devfreq_get_devfreq_by_node(struc=
t device_node *node)=0A=
>>>    =0A=
>>>    	return ERR_PTR(-ENODEV);=0A=
>>>    }=0A=
>>> -=0A=
>>> -/*=0A=
>>> - * devfreq_get_devfreq_by_phandle - Get the devfreq device from device=
tree=0A=
>>> - * @dev - instance to the given device=0A=
>>> - * @index - index into list of devfreq=0A=
>>> - *=0A=
>>> - * return the instance of devfreq device=0A=
>>> - */=0A=
>>> -struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int=
 index)=0A=
>>> -{=0A=
>>> -	struct device_node *node;=0A=
>>> -	struct devfreq *devfreq;=0A=
>>> -=0A=
>>> -	if (!dev)=0A=
>>> -		return ERR_PTR(-EINVAL);=0A=
>>> -=0A=
>>> -	if (!dev->of_node)=0A=
>>> -		return ERR_PTR(-EINVAL);=0A=
>>> -=0A=
>>> -	node =3D of_parse_phandle(dev->of_node, "devfreq", index);=0A=
>>> -	if (!node)=0A=
>>> -		return ERR_PTR(-ENODEV);=0A=
>>> -=0A=
>>> -	devfreq =3D devfreq_get_devfreq_by_node(node);=0A=
>>> -	of_node_put(node);=0A=
>>> -=0A=
>>> -	return devfreq;=0A=
>>> -}=0A=
>>> -=0A=
>>>    #else=0A=
>>>    struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node=
)=0A=
>>>    {=0A=
>>>    	return ERR_PTR(-ENODEV);=0A=
>>>    }=0A=
>>> -=0A=
>>> -struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int=
 index)=0A=
>>> -{=0A=
>>> -	return ERR_PTR(-ENODEV);=0A=
>>> -}=0A=
>>>    #endif /* CONFIG_OF */=0A=
>>>    EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_node);=0A=
>>> -EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_phandle);=0A=
>>>    =0A=
>>>    /**=0A=
>>>     * devm_devfreq_remove_device() - Resource-managed devfreq_remove_de=
vice()=0A=
>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.=
c=0A=
>>> index 7f5917d59072..1bc4e3c81115 100644=0A=
>>> --- a/drivers/devfreq/exynos-bus.c=0A=
>>> +++ b/drivers/devfreq/exynos-bus.c=0A=
>>> @@ -86,6 +86,16 @@ static int exynos_bus_get_event(struct exynos_bus *b=
us,=0A=
>>>    	return ret;=0A=
>>>    }=0A=
>>>    =0A=
>>> +static struct devfreq *exynos_bus_get_parent_devfreq(struct device_nod=
e *np)=0A=
>>> +{=0A=
>>> +	struct device_node *node =3D of_parse_phandle(np, "devfreq", 0);=0A=
>>> +=0A=
>>> +	if (!node)=0A=
>>> +		return ERR_PTR(-ENODEV);=0A=
>>> +=0A=
>>> +	return devfreq_get_devfreq_by_node(node);=0A=
>>=0A=
>> You need to call of_node_put(node) here and in several other places.=0A=
>>=0A=
>> The old devfreq_get_devfreq_by_phandle API handled this internally but=
=0A=
>> devfreq_get_devfreq_by_node doesn't.=0A=
> =0A=
> Thanks. I'll fix it.=0A=
> =0A=
>>=0A=
>> Maybe the _by_phandle API could be kept and just take the property name=
=0A=
>> instead of always using "devfreq"?=0A=
> =0A=
> Do you mean like below?=0A=
> devfreq_get_devfreq_by_phandle(struct device *dev, int index)=0A=
> -> devfreq_get_devfreq_by_phandle(struct device *dev, char *property_name=
, int index)=0A=
> =0A=
> In case of devfreq-event.c,=0A=
> struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(=0A=
> 						struct device *dev,=0A=
> 						char property_name,=0A=
> 						int index)=0A=
> int devfreq_event_get_edev_count(struct device *dev, char *property_name)=
=0A=
=0A=
Yes. These helpers would avoid the need for explicit of_node_put.=0A=
=0A=
> =0A=
>>=0A=
>>> +}=0A=
>>> +=0A=
>>>    /*=0A=
>>>     * devfreq function for both simple-ondemand and passive governor=0A=
>>>     */=0A=
>>> @@ -353,7 +363,7 @@ static int exynos_bus_profile_init_passive(struct e=
xynos_bus *bus,=0A=
>>>    	profile->exit =3D exynos_bus_passive_exit;=0A=
>>>    =0A=
>>>    	/* Get the instance of parent devfreq device */=0A=
>>> -	parent_devfreq =3D devfreq_get_devfreq_by_phandle(dev, 0);=0A=
>>> +	parent_devfreq =3D exynos_bus_get_parent_devfreq(dev->of_node);=0A=
>>>    	if (IS_ERR(parent_devfreq))=0A=
>>>    		return -EPROBE_DEFER;=0A=
>>>    =0A=
>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h=0A=
>>> index 1dccc47acbce..a4351698fb64 100644=0A=
>>> --- a/include/linux/devfreq.h=0A=
>>> +++ b/include/linux/devfreq.h=0A=
>>> @@ -254,8 +254,6 @@ extern void devm_devfreq_unregister_notifier(struct=
 device *dev,=0A=
>>>    				struct notifier_block *nb,=0A=
>>>    				unsigned int list);=0A=
>>>    extern struct devfreq *devfreq_get_devfreq_by_node(struct device_nod=
e *node);=0A=
>>> -extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *d=
ev,=0A=
>>> -						int index);=0A=
>>>    =0A=
>>>    #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)=0A=
>>>    /**=0A=
>>> @@ -413,12 +411,6 @@ static inline struct devfreq *devfreq_get_devfreq_=
by_node(struct device_node *no=0A=
>>>    	return ERR_PTR(-ENODEV);=0A=
>>>    }=0A=
>>>    =0A=
>>> -static inline struct devfreq *devfreq_get_devfreq_by_phandle(struct de=
vice *dev,=0A=
>>> -							int index)=0A=
>>> -{=0A=
>>> -	return ERR_PTR(-ENODEV);=0A=
>>> -}=0A=
>>> -=0A=
>>>    static inline int devfreq_update_stats(struct devfreq *df)=0A=
>>>    {=0A=
>>>    	return -EINVAL;=0A=
=0A=
