Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74291125861
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 01:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLSASR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 19:18:17 -0500
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:30083
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbfLSASR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Dec 2019 19:18:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKEPA6sl7LbqDzKXkAhQxSlW/JzjAy3jaZsxHZdZFMfKIvOPoJyMogsFryHZYrOqhGk6Mrbw17I1Bs8kJcWdtqUzcAuWP42qJGzAO8ifjCD2aDLA7sYF5tSDASA06rkNv3+bkDlyT8wJaNJLpRfvSkY8fOH3VBnxfvLepmKk6VYTLuAuAa9kotqKqBhU2N8qwIoJdrFFrIHbkrT00mWBb18Rf2irGXY8STrvcJW8WoZSNv3NBEiivb4mHI+hkGj1Jma9jceW/jW84zaaEWDUpT6lFhPmCD8/5MHO7hNCdeARqqUs5WU9n+Lbw4OkEu/lHNMumZll2qQyJo2BoTbIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrnGVkzKvzUrsrZNlKOfhRsHgu+SgOG192yoHPWcIZs=;
 b=Q/yVDbSKc2uHuMshHwGw264CtOnC3R+OiRJ0KUheRVRQY4kDvI0vpNnRaekucTq1TjUzIuJJ7CJ1T6INnHVoNDYAMdosgyS5NthvnmSuaPQkzIi8P2px/0TyXGFp3X4VBCL7XpFO55Kte2/jCkmO6Vj4SoIWQz8YN3Yb14RID72uGEyAau5SOk47ZCBehxyAwGKtXup7u2iHXjFd4zsh+163zUq8bFQbwr90sBFuSEQLmyX245rqhQvzproGTd/deR2siN+mvEKBGLfLTHjq0JLvyhPRDWymRSF/FhDWZEHJR781zJewTz+Mdo2N8fWhsAJHjfhFqBKCzy2Y3JNeNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrnGVkzKvzUrsrZNlKOfhRsHgu+SgOG192yoHPWcIZs=;
 b=iEIhRWsXHVu3tIWXpHeRT+z7QOWYBTTQpxBMixhYNOVJaFnGR6QXxit1BwIfVq6oWo4h4U0A3tMbjPvU0Y9LPG5uQSgI0GlT1bbr+S6zGgqvSKrwm+M1H7iPlpN2/dLFAjrKkhn9uP/MExI0yex7lslLchiHqV8LwR2A3W0HRzM=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5216.eurprd04.prod.outlook.com (20.177.51.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.13; Thu, 19 Dec 2019 00:18:10 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2559.015; Thu, 19 Dec 2019
 00:18:10 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jacky Bai <ping.bai@nxp.com>
CC:     =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
Subject: Re: [PATCH RFC v6 4/9] interconnect: Add imx core driver
Thread-Topic: [PATCH RFC v6 4/9] interconnect: Add imx core driver
Thread-Index: AQHVmyeaK7vaeB5iSEWDg4w8jXcbxw==
Date:   Thu, 19 Dec 2019 00:18:10 +0000
Message-ID: <VI1PR04MB702379A8A2A2B2F981EDB9BEEE520@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573761527.git.leonard.crestez@nxp.com>
 <ddfa004340787f8b138c54d89af486d9232dfff9.1573761527.git.leonard.crestez@nxp.com>
 <48136159-21ba-c3b7-52c9-1d9d711644f7@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [2a04:241e:500:9200:180b:59ec:7e1f:6ab4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1332c512-28b0-4e06-d42f-08d78418ee0d
x-ms-traffictypediagnostic: VI1PR04MB5216:|VI1PR04MB5216:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB521655D3CA2FB703A5857A72EE520@VI1PR04MB5216.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(199004)(189003)(33656002)(186003)(7696005)(6506007)(53546011)(91956017)(6636002)(76116006)(7416002)(66476007)(64756008)(66556008)(66446008)(71200400001)(66946007)(4326008)(52536014)(5660300002)(86362001)(110136005)(54906003)(44832011)(8936002)(9686003)(55016002)(81166006)(81156014)(2906002)(478600001)(316002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5216;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z32RROcGqPP9xYnyTYJvffkbeshGM1iMntHX4s+kqbChkQc9V1M/iKlHa2X+sZI64cnvgtnRyVQ/y/I/hL3AWWm6FlOxa/SUtPx6isuEqWTEojgmzthOAgSWHZjXnPb6DKmHOcXY+5BwSqkCIdV587PmPFICgfX99AZOIMyYo1X2KlDmL0YVjpsK3/5ODfgjGi/4CGnfXBo4d6eGBpOhdaq8p0KzMUubr613mrExwljJx2ayWG2h8CV3PTjt8FG8I9pxwAvmMKMSmsTr9TZLwvcnJzCd6dF7QZzxUWiWyVFaUNTMHF5jtFLI4XJJgjAZ0AtsHzKMWOeiCd+qxoqx4QZHTvpbXcEwcFAamwDBiRX1CqYW/Vgh2VF6iboEK3d6SAqsJzh3VsZA8wSjM+Jcfm8fMpDffvGHVMf6FAvbhW0pTKqeLBSiyz53pncgKqyF
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1332c512-28b0-4e06-d42f-08d78418ee0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 00:18:10.1720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ud55QVHI4YJ+ytbbh29pssh655Iym6sptpoLP0/aPo6dEQ/jOZVSWDkuSlxEiznt5RJKJynDWrz+lsC7xSb5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5216
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12.12.2019 09:29, Georgi Djakov wrote:=0A=
> Hi Leonard,=0A=
> =0A=
> Thank you for your continuous work on the patches and sorry for not revie=
wing=0A=
> this earlier.=0A=
> On 11/14/19 22:09, Leonard Crestez wrote:=0A=
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
=0A=
>> +static int imx_icc_node_init_qos(struct icc_provider *provider,=0A=
>> +				 struct icc_node *node)=0A=
>> +{=0A=
>> +	struct imx_icc_node *node_data =3D node->data;=0A=
>> +	struct device *dev =3D provider->dev;=0A=
>> +	struct device_node *dn =3D NULL;=0A=
>> +	struct platform_device *pdev;=0A=
>> +	int i, count;=0A=
>> +	u32 node_id;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	count =3D of_property_count_u32_elems(dev->of_node,=0A=
>> +					    "fsl,scalable-node-ids");=0A=
>> +	if (count < 0) {=0A=
>> +		dev_err(dev, "Failed to parse fsl,scalable-node-ids: %d\n",=0A=
>> +			count);=0A=
>> +		return count;=0A=
>> +	}=0A=
>> +=0A=
>> +	for (i =3D 0; i < count; i++) {=0A=
>> +		ret =3D of_property_read_u32_index(dev->of_node,=0A=
>> +						 "fsl,scalable-node-ids",=0A=
>> +						 i, &node_id);=0A=
>> +=0A=
>> +		if (ret < 0) {=0A=
>> +			dev_err(dev, "Failed to parse fsl,scalable-node-ids[%d]: %d\n",=0A=
>> +				i, ret);=0A=
>> +			return ret;=0A=
>> +		}=0A=
>> +		if (node_id !=3D node->id)=0A=
>> +			continue;=0A=
>> +=0A=
>> +		dn =3D of_parse_phandle(dev->of_node, "fsl,scalable-nodes", i);=0A=
> =0A=
> Why is this needed? I would expect that the interconnect provider driver =
already=0A=
> knows which nodes are scalable based on the platform compatible string.=
=0A=
> Then maybe this driver should create devfreq devices for each node that i=
s scalable?=0A=
=0A=
The scalable nodes are independent devfreq instances which are probed =0A=
through their own DT compat strings. It's even possible to reload =0A=
imx8m-ddrc (the driver scaling the dram controller) at runtime.=0A=
=0A=
The most common solution to fetch other devices on DT systems is via =0A=
phandles and fsl,scalable-nodes is a phandle array. Since the provider =0A=
is platform-specific and knows the topology of the soc it could even use =
=0A=
of_find_node_by_path but that seems very messy. It's also quite brittle, =
=0A=
I've seen several bugs caused by DT node renaming.=0A=
=0A=
This support for arbitrary "scalable nodes" might be excessively generic =
=0A=
and strict DT compatibility might be difficult to maintain if too much =0A=
is exposed. Changing per-soc driver data is otherwise easy.=0A=
=0A=
In vendor tree we only ever scale the main NOC and DDRC anyway so =0A=
equivalent functionality could be achieved with a single "fsl,ddrc" =0A=
phandle property on the noc.=0A=
=0A=
Support for scaling peripheral buses could be implemented by adding =0A=
additional properties like "fsl,display-nic". Such a feature would need =0A=
careful measurement on real hardware anyway.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
