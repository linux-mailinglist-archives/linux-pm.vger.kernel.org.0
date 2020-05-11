Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53D51CDB13
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 15:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgEKNUa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 09:20:30 -0400
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]:3716
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbgEKNUa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 May 2020 09:20:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGY4X7uGRR/pIi4iWspZBWlAB3R0Jw4s9iJCqn/1AsidqfO+pIiFcPSKy3N77/QMfZ3LNLfzuPjKyMdaq+Dj1svccX/KEfXbkJ50iE4rkqv6S5bEUuNAAfsI1X7RGRdXOJTAZSgmFwp5avyOVtS/0mjtsSzDelYl8+XudSs8MPqAeiY4+i1WYp2uWM0wEuzvEcFPElqBCsDhmD/BTYknycE0bOxtM0cOsnnnGEvuQaJUEHXbBa0JMzm8WEPuGwtUIfY85O6nG4PXGjoKpEXjD+6FxPHGr1j4uVHemXnsfI7x1MNbN+MxeB7QAzeueCB0VAXdC/IQLtQ1Z1yHj/i1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8skQfuzwOlDUAsyUg6p+34Tb1f9ovt9wZHYRtHg0fmE=;
 b=JVLKGrIdQOtiCGe+XRFyKWhIrLgKTPnBJdSbebbov2r1GdMzZfRtk/YPq2N+cz2EDNObUN4ZzY+KldZChCUuXPbNjLYiirdMX0XJ1TBv73DkShC/es7l1rKwUirFQUfSQlwTq5u/Uh4o94UKgBC6dYDRGEj/t8bmNLj9I/X9mZ3PHWRNwJqZtBuzI2SK+doNOKDfG5rq0bXJLFJi3j4mcVedn1eCZRo34vM1+7i1JX/seKINHCOJJ0/SKKvrblTFqaC5zyYGgLKXmZg5dR/7HWwCPu1DuJOB6nZq6Cg+aLCISCwDtTWhzBglei3pzt9+CrDY4DkbkwMxiYmMd8fWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8skQfuzwOlDUAsyUg6p+34Tb1f9ovt9wZHYRtHg0fmE=;
 b=glYpxoHXjkqVNF5so1A2Pdby+Mu0aeqdbJO204v5oz/wXmhNMT68iV6yxJhD90xugufcnitJu41plJOOMqHmOaA5tIqcM4wUtBvuuNVQW4uowVQ4R+61Dmk/f68fWLT656lV8cfFRl7WtO0UX0k+BLoDUbxjdHTl1fuCkUYnIbo=
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com (2603:10a6:803:12e::23)
 by VI1SPR01MB0358.eurprd04.prod.outlook.com (2603:10a6:803:8d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Mon, 11 May
 2020 13:20:27 +0000
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::8de5:8c61:6e4d:9fe9]) by VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::8de5:8c61:6e4d:9fe9%9]) with mapi id 15.20.2958.035; Mon, 11 May 2020
 13:20:26 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Georgi Djakov <georgi.djakov@linaro.org>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] interconnect: imx: Fix return value check in
 imx_icc_node_init_qos()
Thread-Topic: [PATCH -next] interconnect: imx: Fix return value check in
 imx_icc_node_init_qos()
Thread-Index: AQHWJa29mXPWwTufek+ikA2u4wg9vw==
Date:   Mon, 11 May 2020 13:20:26 +0000
Message-ID: <VI1PR04MB694150C03CC158988F7124A4EEA10@VI1PR04MB6941.eurprd04.prod.outlook.com>
References: <20200509030214.14435-1-weiyongjun1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [95.76.3.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb8b1648-599f-4c12-add1-08d7f5ae11e7
x-ms-traffictypediagnostic: VI1SPR01MB0358:|VI1SPR01MB0358:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1SPR01MB0358160C9F273B167C7EF680EEA10@VI1SPR01MB0358.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c1vQa+6g6VonddA+eXM2cc7MTm3t9YEwLXZB74IoElKOXjkmkfAySoSOHRChE4qfW0fHVVzA8E5Lkx2BwLnS7fwD38vgIWpMP7u5R5J5g6x89FSIL8+m8yQ3j9m8UkKAwqUhphcuHKzoU0a8InsotsB4z60ZfTjOdjtam7h0HI39xfzKHgf3W0hhkzKpW9nMGjMGfx6BfgN4nOXRZLl+WlvAz48VqBIk7wknKsXqZzne1nR98J4Gsq+hLlUNXcrNvAxCXpBpcKto0YPxIjFfxHuYcPmkg22xULvDb7zD5Vjs3hfoZey0CIrYNYaGMULmcT0IJ50zdtXW367KVTBJJciIWFOKURI1PT4oqplf10/SKyg9lvIW5MZXQBKt2KFgVp7lKlK65zQkXoQa/olNZqO5zekAnGSJr6zsBphSLlTCNDsIsz7oYoxHssqlOc4NdEVdp+2jTeWtgLrI6I7kBQHVUw0ZBke6AtCQMsF0Lq9oCfw3SeSZuZ6eJhmdWz2/geLeUvOmTzp1JFZEnnycsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(33430700001)(26005)(53546011)(5660300002)(8936002)(316002)(186003)(52536014)(8676002)(66446008)(4326008)(91956017)(54906003)(9686003)(478600001)(66476007)(66556008)(64756008)(55016002)(66946007)(76116006)(110136005)(2906002)(71200400001)(33440700001)(7696005)(6506007)(33656002)(44832011)(7416002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: mbK3G43Egfnm1/RIFt4/2VSI3mI0+YV7b1V72Q0wS9w1Z/j2yD4LUjRrQdbjJ7vLoeP1vD+ZPSDMDXEk3KABN+4Af+gZQt+eY93rsAWMwvdYRrflI83RQKO08ThCZmaykif/6l8BhX2GtdJPhyfXWnL+ha296gtKeqoYcd0negNWsS3TABIPB3EeA/KslGsHo7YXKa2fgzhXEUPY/D4PwJMeXN86KVsSVmHp0bOzOvdCN+FK+OIQPFmbh4+1jkQSQe9I6PlmONFqzIGGcEwxfBcsq8l8umsTzsuQTZrGZ1wfxSd02WOMQ+fF4UB76QfDo6gJu1fk/zAXRl4fUWG7iVAoYoqKxKZ8w1Y6+MnrJUsgp7xgq3jAXxQ9SV1gRwPjvMFBgcqUgtoM/Bgjmq/RZo6IgC8yYuPUsN07XpIgdrIW+0XkSpS+zxtX0pBNYdQFyPh6JnMPkBVqI96/an6w4cOWuJYzXzIfm12MWFtc/MM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8b1648-599f-4c12-add1-08d7f5ae11e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 13:20:26.8729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sx2/F39cpUY4i3bmB3XZH8uX2MqLxcCdg2jFq0AD9ZXxPRLdik26gzwXeFcBEODmknFl1dBLtqYZ6BLNU1Pn1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR01MB0358
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-05-09 5:58 AM, Wei Yongjun wrote:=0A=
> In case of error, the function of_parse_phandle() returns NULL pointer=0A=
> not ERR_PTR(). The IS_ERR() test in the return value check should be=0A=
> replaced with NULL test.=0A=
> =0A=
> Fixes: f0d8048525d7 ("interconnect: Add imx core driver")=0A=
> Reported-by: Hulk Robot <hulkci@huawei.com>=0A=
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>=0A=
> ---=0A=
>   drivers/interconnect/imx/imx.c | 8 ++++----=0A=
>   1 file changed, 4 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/im=
x.c=0A=
> index 6884212511f0..ac420f86008e 100644=0A=
> --- a/drivers/interconnect/imx/imx.c=0A=
> +++ b/drivers/interconnect/imx/imx.c=0A=
> @@ -90,10 +90,10 @@ static int imx_icc_node_init_qos(struct icc_provider =
*provider,=0A=
>   			node->name, node->id);=0A=
>   	} else {=0A=
>   		dn =3D of_parse_phandle(dev->of_node, adj->phandle_name, 0);=0A=
> -		if (IS_ERR(dn)) {=0A=
> -			dev_warn(dev, "Failed to parse %s: %ld\n",=0A=
> -				 adj->phandle_name, PTR_ERR(dn));=0A=
> -			return PTR_ERR(dn);=0A=
> +		if (!dn) {=0A=
> +			dev_warn(dev, "Failed to parse %s\n",=0A=
> +				 adj->phandle_name);=0A=
> +			return -ENODEV;=0A=
>   		}=0A=
>   		/* Allow scaling to be disabled on a per-node basis */=0A=
>   		if (!dn || !of_device_is_available(dn)) {=0A=
=0A=
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
