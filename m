Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07CB1DFCA9
	for <lists+linux-pm@lfdr.de>; Sun, 24 May 2020 05:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388282AbgEXD04 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 May 2020 23:26:56 -0400
Received: from mail-am6eur05on2061.outbound.protection.outlook.com ([40.107.22.61]:40158
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388290AbgEXD04 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 23 May 2020 23:26:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdAGxd6rC/vW+q6PjLaAzVNiR89KdAS5fo+hHSm6mrP//FpQKkNQlaRvepQFX2IXfz3IHzVP5PHAdkEW+1Egd4xd+wFe4MjAB1ijhzOrjWPUe0ko+uw5aRHOyUOzg2QPeclLVMqxMUs/HJEdvm2pgmyNV01JRQgxxbme3D5LAMeczcOBXJe8wgu/TYJJsMJCjXHQHkPbZnjNaSqdoQCQycY7W488sRRIQ7mfKGmA4j/Rpc0Itu/aFI5fFvYgh9673FMIPJ7PsRj5ZVJeJ7y9ZXeewVYBHazIpConM5rQxMAPoOiSO8+wDVifv8tcXo1s8rbocSsMTxi/WhTk/e8D3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk4pjYqmdIem2fzxp5lW9xnmTG9QQpDUmIykYa3wW9g=;
 b=MKHH316qhltu08pfUZC9cvFymPQV210kNzrWLlsIihy42XFbevmNbL1GLT8HEDdRuOwG3kE9pkBOWDVDZR0VwQSWfWeQ3iaH885AcAMbUf35jjssCPhyRo4oRUwqSahc+O+zue7qWEc2neYOmPOkHO/3SfcSa6fGpt8eN5JMz1SFVZItZVPg55PhqNO/jGc22JOh8Ni9H+wemYVCf7oeY+197kDHYonc6q56QBnp5GC6CcFXa1TK0Gsx+KEGCM6x5P+fjpYZS3pCbfnE3BmEMa/dUuFndwWc1A+ib+KQMR+rqAMSSgAg3/c7knu1kM8HimrrD4Ay3g2BYmm8MKnqrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk4pjYqmdIem2fzxp5lW9xnmTG9QQpDUmIykYa3wW9g=;
 b=My9KlHE19/sCQcCEtITnh8zZYEwca9c30S7w9jKGFaJZ0SoRHfBg8TvxtJGOQsftSvRimgTOs13ZfG0v79PlM/QWVGJKy4Hja04mwxEyF4zQ2RXhSGI5RO761CKJxXY9rFs6Qz3St3gEZ0qIS2mvKpJHipLaBmOxkNElQoN87Uo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3676.eurprd04.prod.outlook.com (2603:10a6:8:d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Sun, 24 May
 2020 03:26:50 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3021.027; Sun, 24 May 2020
 03:26:50 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3] thermal: imx: Add missing of_node_put()
Thread-Topic: [PATCH V3] thermal: imx: Add missing of_node_put()
Thread-Index: AQHWHdINpRSpu2HCw02EbBMkbedAtKi2unvA
Date:   Sun, 24 May 2020 03:26:50 +0000
Message-ID: <DB3PR0402MB391639FE30CD00F3371A0763F5B20@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1588128570-12917-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1588128570-12917-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e80e2e57-b3bf-4c60-e21a-08d7ff924c68
x-ms-traffictypediagnostic: DB3PR0402MB3676:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB367677E2F9D3C0C91099D75DF5B20@DB3PR0402MB3676.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-forefront-prvs: 0413C9F1ED
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lNkoQfY3KcoRpfk6iemcy/hks7NMs33vsT5qdW/e6bdx0nsMQkD5AEixxs0jUB1ASODUoNH+meRCHk17qSPQTU0O2eVJKLi1OZ5U1/zVPdyyrhPHR6NxDru8vGSDYjCyU4dt6t8VCFUgrvMe5VIdnOXWJT5hzVTtEijImdpDX+P++8haORC4DYe/rRL3pBMahc8MyBBqY0X8TclJ2xzxzSXScPW0mLC7RWCQAFAIznd8gVLMEZxGeb6UXCVN6+vhQxrhmSbuOoxx2gy7YgFBriKs763LZHxLhHbmZFBYYHSWbEgQheaRHIrR5yGsvGsIFOzkSFn5T/60eEtqQN86krYgd7u0KfqSQUu8WZ/uc2S5BfS2AMoOuJIYFb91abOt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(316002)(2906002)(6506007)(66476007)(8676002)(8936002)(86362001)(186003)(66556008)(64756008)(66946007)(76116006)(52536014)(110136005)(44832011)(66446008)(55016002)(5660300002)(7416002)(4326008)(7696005)(9686003)(478600001)(71200400001)(26005)(33656002)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: I2/f1bDBK+MXB/TDWPy6uz8RsBz0FjDTKnNjCSAqAi9ydDwk8PnyRYsnRJS4TKSC6vCbKj+GzlXF3k6IfxH1M30w8ijHkoJXAXWYXV++s1wZkXCUfNNN75u3SiLl26J7GAU3mWmIMBSPj+2q6TJgiK5hK7ntFY3PZ9isT2pgsJHqIdBFXBdezECx1YM/pP9wN/5T9XZoYd1yLVUuFLytTPo/3gnL+PD9GZh5Hye9P5jyjkZf/PxCoYFNFxSEpbrGqe7lhPg8UVmu3zWJpKNp2uQQhgzesdW7GQri7+FrYIX0KMzmaqyL2x+LpSdAVANtD/0IrHTFVS7MvmhxGAoDkJaKYmwwjBsU9kT5Bm7yTVj+u+BCBsDJpsrr00/jqAiiBvbMxeg1eu5QyDPxIAFoIGNaL5Bocrlc3A80mKqrdHl1mUvg/1klRgKEGPvGYQvT1VOTw0RRpfKMgyejpp7zPZEdPlf8mEpTm551PJczs/OB2w3KfdfiVKn9FR4QSz22
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80e2e57-b3bf-4c60-e21a-08d7ff924c68
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2020 03:26:50.7275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7tdjqSFf5a93JLl9f+yeDLjuK7B4YuQ/01h0MlOBPJ4e2BfuLTv6KNbzEJ+aFzpoXxscggs1lW3f7mH0jf7Ymg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3676
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Gentle ping...


> Subject: [PATCH V3] thermal: imx: Add missing of_node_put()
>=20
> After finishing using cpu node got from of_get_cpu_node(), of_node_put()
> needs to be called, the cpufreq policy also needs to be put unconditional=
ly.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V2:
> 	- call cpufreq_cpu_put() unconditionally after cooling register done.
> ---
>  drivers/thermal/imx_thermal.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.=
c
> index e761c9b..8764cb5 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -649,7 +649,7 @@ MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
> static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *d=
ata)
> {
>  	struct device_node *np;
> -	int ret;
> +	int ret =3D 0;
>=20
>  	data->policy =3D cpufreq_cpu_get(0);
>  	if (!data->policy) {
> @@ -661,20 +661,19 @@ static int
> imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
>=20
>  	if (!np || !of_find_property(np, "#cooling-cells", NULL)) {
>  		data->cdev =3D cpufreq_cooling_register(data->policy);
> -		if (IS_ERR(data->cdev)) {
> +		if (IS_ERR(data->cdev))
>  			ret =3D PTR_ERR(data->cdev);
> -			cpufreq_cpu_put(data->policy);
> -			return ret;
> -		}
>  	}
>=20
> -	return 0;
> +	cpufreq_cpu_put(data->policy);
> +	of_node_put(np);
> +
> +	return ret;
>  }
>=20
>  static void imx_thermal_unregister_legacy_cooling(struct imx_thermal_dat=
a
> *data)  {
>  	cpufreq_cooling_unregister(data->cdev);
> -	cpufreq_cpu_put(data->policy);
>  }
>=20
>  #else
> --
> 2.7.4

