Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93AB7EB25F
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 15:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfJaOW4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 10:22:56 -0400
Received: from mail-eopbgr20084.outbound.protection.outlook.com ([40.107.2.84]:62542
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726741AbfJaOW4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Oct 2019 10:22:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVx2aKrVtjRMmloqKvFq+kKLyIhD228+iuQkBRE+QWCx+x8XmnbzHlNtdJGwYTVcIR8RkWNcI2dBmHzBOFoPSICoh5/WGwhsFq53koVuMcg++I9dkROG86u2n7k87j84J11ePgscwwaqsutuiUMs8ZO63ElLRzRGGiyI0l4m6zQSZdnuNh2XyHOJbxV89g5xE6If0MhPj3BKDhBF/tPpalMTnyk1F2FeJd9HBe8rQLIYo39FEPJW3V79T9T64sE3RkbWmztbQxVjLk07qou9altV6tw56TkuyWYeGKDGIIZDDswJJoUxf2yRTIjrUCwcEAYHb5q9eHWkuspfd55zhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJDkspaZ1tbaiuYzTK6HCL4TX+62eTaxgRB84kjbGXA=;
 b=iKul02b6zKYAq68GUh+qkQQxxCK0PxvkKkBc2HwaFvUG+UmZ02xbJwpIm0Dj1rt5VOWFs30Z/YcasizNkJd8OTP9D//iaH8+Rg5hic1v2x3OcwDvCk/hmEpYequ63yUgLpRsngDb4+S/IVariGnVB2RCCdZLWxr2kaNR8E6K2K8Vm7i0HXvGlEUMN42LSe2cWHtTDjiRffkwZQhKtyRb41rrhlp5uKScnGvu9SZk1vLDMFkv1HmBVQMZb/+8Q6NHBcL0oJZbvgaD8v3YhLWlWm/3mujGANgyVU9f5TqtuJtQXAWu4WLXqAZgfgeqKjjjyvsaEgP3QOZxCWVmf5P2lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJDkspaZ1tbaiuYzTK6HCL4TX+62eTaxgRB84kjbGXA=;
 b=SuTIRGruYGMgYCA4LCKwQSWogsrwYtWOzuI4WnyJ0BvrpSGJjWeZixupovPiR+cpPszpb0ghB2Smn93FVAQIR58YJ29HZo0BXBREf+d+2udemEsjqT42ylkvLhyt/ptYwFj9Fomopgb1AljEnYgEBzVyI3OYDEmpDpXK1HN0DjY=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB7166.eurprd04.prod.outlook.com (10.186.156.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 31 Oct 2019 14:22:52 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 14:22:51 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] PM / devfreq: Check NULL governor in
 available_governors_show
Thread-Topic: [PATCH v2] PM / devfreq: Check NULL governor in
 available_governors_show
Thread-Index: AQHVcqlz8mBQO8LnZUW2xGpsUnk7Sw==
Date:   Thu, 31 Oct 2019 14:22:51 +0000
Message-ID: <VI1PR04MB7023C870D21D89C523101A70EE630@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <921db734cb5c92875c3f81250126e2027bf6144b.1569309756.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0f64108f-e0a2-44a4-ec45-08d75e0dd05b
x-ms-traffictypediagnostic: VI1PR04MB7166:|VI1PR04MB7166:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB716644EB89AAC06BAA09D3B8EE630@VI1PR04MB7166.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(25786009)(99286004)(305945005)(26005)(6506007)(45080400002)(102836004)(76176011)(53546011)(110136005)(54906003)(486006)(52536014)(8936002)(81166006)(81156014)(8676002)(66066001)(316002)(33656002)(7696005)(86362001)(186003)(74316002)(7736002)(76116006)(66446008)(66476007)(66946007)(91956017)(66556008)(64756008)(14454004)(6116002)(229853002)(71200400001)(44832011)(3846002)(6436002)(55016002)(6306002)(476003)(9686003)(6246003)(446003)(256004)(14444005)(2906002)(5660300002)(4326008)(966005)(71190400001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB7166;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hG8vJY4+shWhLt3tB47dM8rbndmNZ54nUvhbMq2WPPEiMf7vJYijOmvmi62TQrRgFallIrmNenDBqOAEIgk1ulJeYih5MKWydmEXP6/yW8sUSrdV3PGkjAErjy8Or7NpjXNUSx1Pl4KqHXByhEshjH/SfTYKb5Ax9zqrOMa/EYQ5BChdEjMccrAqSqg4obnUJVMQMs4tSEzJv02G54bQnvSiwiB5oWA+ePbdD5Hjy6XEtf11N12TIWmidu7ez040+Cn1prDCPC3vLsgZx5ghLrR1W6dwGaxHqxupLnu8rQRONeUFlz/lrzj6sdM/lzK2hf8sQouUzUzen6HmmEKSPQ6vi/oE6iZrD/oGpZr/5K/Z42AppnETXlUUSw0GdXY13TO6YK8F81eCj8zAZDfqY43ghifR/ocMoJAT+o5JQ7TPiDtGsVuLy5InHjqMN7AsJiDbBI+GlndPjjLgSgkUiMEOTmGlnghS3zIVkuoe/Qk=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f64108f-e0a2-44a4-ec45-08d75e0dd05b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 14:22:51.8420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7JoFrASbc9kpLG2Dlsj0CBw2AIlIdGd4wafcLcD8XjWFJVNu4drJbwFkUtmIOT2MkolM1T2UW3ATXIG64zBIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7166
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24.09.2019 10:26, Leonard Crestez wrote:=0A=
> The governor is initialized after sysfs attributes become visible so in=
=0A=
> theory the governor field can be NULL here.=0A=
> =0A=
> Fixes: bcf23c79c4e46 ("PM / devfreq: Fix available_governor sysfs")=0A=
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>=0A=
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>=0A=
=0A=
Gentle ping?=0A=
=0A=
This is a very simple bugfix with no dependencies which has already been =
=0A=
reviewed. Same applies to the following patch:=0A=
=0A=
https://patchwork.kernel.org/patch/11158225/=0A=
=0A=
> ---=0A=
>   drivers/devfreq/devfreq.c | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> Changes since v1:=0A=
> * Add Fixes tag and Reviewed-by=0A=
> Link to v1: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fpatchwork.kernel.org%2Fpatch%2F11157333%2F&amp;data=3D02%7C01%7Cleon=
ard.crestez%40nxp.com%7C857374c5be41480ec9ad08d740c09549%7C686ea1d3bc2b4c6f=
a92cd99c5c301635%7C0%7C0%7C637049068194432556&amp;sdata=3DBIV9uq2WOBIrDLwGB=
WiM2wvHPselZnqdtOUV1uzzBsQ%3D&amp;reserved=3D0=0A=
> =0A=
> Don't add cc: stable since it's a theoretical race condition.=0A=
> =0A=
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c=0A=
> index b905963cea7d..60859a2400bc 100644=0A=
> --- a/drivers/devfreq/devfreq.c=0A=
> +++ b/drivers/devfreq/devfreq.c=0A=
> @@ -1193,11 +1193,11 @@ static ssize_t available_governors_show(struct de=
vice *d,=0A=
>   =0A=
>   	/*=0A=
>   	 * The devfreq with immutable governor (e.g., passive) shows=0A=
>   	 * only own governor.=0A=
>   	 */=0A=
> -	if (df->governor->immutable) {=0A=
> +	if (df->governor && df->governor->immutable) {=0A=
>   		count =3D scnprintf(&buf[count], DEVFREQ_NAME_LEN,=0A=
>   				  "%s ", df->governor_name);=0A=
>   	/*=0A=
>   	 * The devfreq device shows the registered governor except for=0A=
>   	 * immutable governors such as passive governor .=0A=
> =0A=
=0A=
