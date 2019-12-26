Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4E912ACAE
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2019 15:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLZOEc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Dec 2019 09:04:32 -0500
Received: from mail-eopbgr30051.outbound.protection.outlook.com ([40.107.3.51]:53250
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbfLZOEc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Dec 2019 09:04:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1lEAqOi+u5enHhacTjsCnAhwFhfkjh4QbbAHSZB7Ebq2aVTwbyfI2+M4KjqUS6ec6aR3GOlBONhgJ/oF9KN5vDEQEEGpZc2k1S/wHqPsPkSC4rACcuIsC+nd0BjlMBC/En8muzaKLaQm7xGu34ekka1zBbNZP3SeOHl9jBxNpHN09FyH97ykcdVx505wIj9vZjNxJSiyiJlX076aBX3Ui1r4z0tSd76OsbTcW19zMAlVI1HhdPwluYHpTw5uKQOEjxkcjMBy3zC2TeQPQl9AaLObyCREVOr8T0LZpu0z7jXmkHz/mbtlP10RCfScqG+H1MWpxk9pzR8F1JYChztIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdeEwGufP9ZrXewH9YszJbbm5IsOTiS9gXj7hzsa+DY=;
 b=azwmVgNydjLnh9Zro9CRKwPGelGkN6fDdTBA1lWn8yLTvJspQq6pI3UyO0q5TpQIjezQZl1MvmwvdQYaX7a9lLnoZc1M5o+TLhzY83u5jlQrTUBYbqLH5Sd6l9O8NLuOPUV+871vB6w1WlysXKM7SgeXL/X2sRRoXM45tc+oHvgtgQd3swPZ8g4kBzC5mgS7aqf9bOqBmfCztmu1xy0n+ZksxF9e5S11mBmoJNWGAURSGBlQmjEiRXgzkgtgMNetSCjgU23t8LYJ8q1P71WLpRZDzgZ5LTkCfPRlnBSiYWcEhj8LNG+wPL3R833y6uHAWzIaBTUFUGSPk4ni0MpNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdeEwGufP9ZrXewH9YszJbbm5IsOTiS9gXj7hzsa+DY=;
 b=RNaQ1gJQD0er9jF4aar5VugS4UidfFHafySUZ2eCsjzKEVjHOGClG6z3GFvTlgM2Zh/K5uzFfs5UTPnTiiSSTqZzm0TjScLGOAqJQC4E89wWXacwSnf7InevFUU1A/6Ig4blaOohZjAZtvHS/cGJWjLFovhXd8SDBItSXByJA3s=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5060.eurprd04.prod.outlook.com (20.177.41.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 26 Dec 2019 14:04:28 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::6d52:5678:e02f:95f4]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::6d52:5678:e02f:95f4%3]) with mapi id 15.20.2581.007; Thu, 26 Dec 2019
 14:04:28 +0000
Received: from localhost (89.37.124.34) by AM5PR0601CA0032.eurprd06.prod.outlook.com (2603:10a6:203:68::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Thu, 26 Dec 2019 14:04:27 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] cpufreq: imx-cpufreq-dt: Add i.MX8MP support
Thread-Topic: [PATCH 2/2] cpufreq: imx-cpufreq-dt: Add i.MX8MP support
Thread-Index: AQHVu7mKaZLuFaepI0S7Z4SaC6NlIKfMc1AA
Date:   Thu, 26 Dec 2019 14:04:28 +0000
Message-ID: <20191226140426.ip2vb6dom5hckenc@fsr-ub1664-175>
References: <1577343167-16376-1-git-send-email-Anson.Huang@nxp.com>
 <1577343167-16376-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1577343167-16376-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0601CA0032.eurprd06.prod.outlook.com
 (2603:10a6:203:68::18) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d51eed90-c363-43d2-ff4e-08d78a0c8568
x-ms-traffictypediagnostic: AM0PR04MB5060:|AM0PR04MB5060:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB50609D366D9596CAD6282654F62B0@AM0PR04MB5060.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02638D901B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(366004)(346002)(136003)(39860400002)(376002)(189003)(199004)(5660300002)(66446008)(186003)(16526019)(2906002)(66476007)(8936002)(6862004)(86362001)(1076003)(52116002)(81166006)(6496006)(8676002)(53546011)(66946007)(64756008)(66556008)(26005)(81156014)(71200400001)(54906003)(316002)(44832011)(6486002)(4326008)(956004)(478600001)(33716001)(6636002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5060;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CEhE1rkYukRZOPVEANut4o4U8hFudjiGvGqIt2XArQr0PBaWE1cvDjR6ZE6qQ0Y5nYlzXx7tGZkZmBzzKGC6i0hWyd/PMS0cUK/le6r7/uV3cf1ajohvQ5T9/S+u8+oJ/T6FVe/P9t3TIr72H/9Dejb3dgCTIN2GXW2iNtyO6+6LtyxcIZLyRLjBPobjTn4m+RebxoJyk2LQSfUoWXFa8feBeaHPjlJrUG08/JYb638sWXKJiDZXLyMNrY2Lm4Zf0aFfP8dpvegzxjwkGfBlO7Nq0D4Lxz8Co+NvoaEVWtu0RkGfypEInz/Ez93X5rlzapxnQmsPYu3xufq2LDwFrGbkwLWgRwPFR2sPAbP1napU7JAjsENtjjKAvBTcUSzoVgBXP8KBt+TuSCkqWu8cnsHiUEO4sRYnA5GzIIfKankMqQrj53AVNODsoj+gg97K
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8F23C618A82F824C80C1441332F2773D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51eed90-c363-43d2-ff4e-08d78a0c8568
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2019 14:04:28.1254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BCiT2gmbSgN40DgIsZSYRCnUW5fHfLnfeJwjKRtrNQcUQzEwQScM5pkTc3WsjQGWDiekjn9UbaBKWY8SAST0aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5060
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-12-26 14:52:47, Anson Huang wrote:
> Add i.MX8MP cpufreq DT support for speed grading and market
> segment check.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/cpufreq/imx-cpufreq-dt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufr=
eq-dt.c
> index 85a6efd..912e93d 100644
> --- a/drivers/cpufreq/imx-cpufreq-dt.c
> +++ b/drivers/cpufreq/imx-cpufreq-dt.c
> @@ -35,7 +35,7 @@ static int imx_cpufreq_dt_probe(struct platform_device =
*pdev)
>  	if (ret)
>  		return ret;
> =20
> -	if (of_machine_is_compatible("fsl,imx8mn"))
> +	if (of_machine_is_compatible("fsl,imx8mn") || of_machine_is_compatible(=
"fsl,imx8mp"))

Is there a way we could do this more generic so we won't have to add
another of_machine_is_compatible if a new imx8m comes around ?

If not, please drop the second one on a new line to follow the 80 chars rul=
e.

Then you can add:
Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

>  		speed_grade =3D (cell_value & IMX8MN_OCOTP_CFG3_SPEED_GRADE_MASK)
>  			      >> OCOTP_CFG3_SPEED_GRADE_SHIFT;
>  	else
> @@ -54,7 +54,8 @@ static int imx_cpufreq_dt_probe(struct platform_device =
*pdev)
>  		if (of_machine_is_compatible("fsl,imx8mm") ||
>  		    of_machine_is_compatible("fsl,imx8mq"))
>  			speed_grade =3D 1;
> -		if (of_machine_is_compatible("fsl,imx8mn"))
> +		if (of_machine_is_compatible("fsl,imx8mn") ||
> +			of_machine_is_compatible("fsl,imx8mp"))
>  			speed_grade =3D 0xb;
>  	}
> =20
> --=20
> 2.7.4
>=20
