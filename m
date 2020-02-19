Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE00163908
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 02:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgBSBJq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 20:09:46 -0500
Received: from mail-db8eur05on2042.outbound.protection.outlook.com ([40.107.20.42]:6189
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbgBSBJq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Feb 2020 20:09:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBcQOLYq2WxHQ/JLo7kdYv78b3874dWzSY++07r7jGGq00cU23Mm3bpW9z6rFcWMsa4th1ESYKPP+a5yXN8lmefRsHJEY7FeSLeK0OSgFgyH/d/+fvaoUAyR8riuZC3Jriptdqmnf0jTML2188w7dLiko3P2K4vIUqVL5kGgJrtpMitBNijcX1eIUt/KcuVA7gKPk1SHaPxL46P/0inisr4njU/O3/OLEEPpiTycTueltJk6vJlRGjGhnn3ZMKg1Q7KHoCo7CzBxQxh8U0lTiuzBrvF++sBhjKYAQ1YWm5ymR0jA/k2TQevxeDHMa7ItljogmwZfHSYPpcdJgVVP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxKkd/ogCaklC4BHSyOyqan70nCoU0gzqM6lcOBSMX8=;
 b=i9iR6KF/+n8XQDclcqIPDn4rajFgVLiJX7X58SVwMdez/egtLvJ2bm7lmpCPSVspHGhfCWRh+9uD23FJ1Evd/Ns8PSKjWdxd1u0v5Ah1WlVL0BDqas0O+HMlEcad1J/OLzamOzwuOe39e3A0g80ZU/IR0FE97F/OBbUkSohhkWwS7wyNz7TGhiExRyxBABrTpma9MRcLnjUezBpUlziptAROnM/2Ygo8UKhrFnt47GlCRED3DGWjRgWplBatvDt+H/uYdFU0QCo5+CgBcWOC85IyCMtzj4A5vPHB4kjvwgW5jQ1FTVHZAQb7s2o2ZPA+xEV6KXOIDsvGauMIjkA3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxKkd/ogCaklC4BHSyOyqan70nCoU0gzqM6lcOBSMX8=;
 b=FeWzveAS9nGZCszdaAp8Lt/g7rrr7PHbTQmen31i1vky7ExsmOnb6QxnKV/KnnoYUNEI2VlBEF56InIKMPmhfgLr6IC1wyiw8DyzwyEb1P8CIeJ7uvv26q51lhrX0rUDTk/l5plibBKvByc24mEUcVDoqbOU8cYefg+VvcbdniE=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB5757.eurprd04.prod.outlook.com (20.178.126.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Wed, 19 Feb 2020 01:09:42 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e%6]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 01:09:42 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 23/28] drivers: usb: Call cpu_latency_qos_*() instead of
 pm_qos_*()
Thread-Topic: [PATCH 23/28] drivers: usb: Call cpu_latency_qos_*() instead of
 pm_qos_*()
Thread-Index: AQHV4TRn3BXs86jgkEan911jMn55C6ghwCCA
Date:   Wed, 19 Feb 2020 01:09:42 +0000
Message-ID: <20200219010943.GA8602@b29397-desktop>
References: <1654227.8mz0SueHsU@kreacher> <19064076.ICumzjfW0v@kreacher>
In-Reply-To: <19064076.ICumzjfW0v@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 942975e1-3920-4f8a-7c1d-08d7b4d866ac
x-ms-traffictypediagnostic: VI1PR04MB5757:
x-microsoft-antispam-prvs: <VI1PR04MB575732C5C22E9787BA9FEE618B100@VI1PR04MB5757.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(366004)(376002)(396003)(136003)(346002)(189003)(199004)(8936002)(81156014)(66476007)(8676002)(64756008)(316002)(66556008)(66446008)(4326008)(6486002)(76116006)(186003)(81166006)(66946007)(44832011)(9686003)(6512007)(71200400001)(33656002)(5660300002)(91956017)(2906002)(86362001)(1076003)(6916009)(6506007)(26005)(54906003)(478600001)(33716001)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5757;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9jC6apnwgX/iHK3crz0lbp6n9qCiQw3W9ygpwtyI5FVJes0IuRWsEzIjAdwdl4Sstuy28RE6nnmGXoIabtVvP4nHdTSJQ9tt4Wn/QFcATiYjYdaS5f68ClT3on8mRCLPUeOVADnLgzYolSBO8fBR0MqlnhQx8xuoNZGrN3wqpdsd3VJj/3pgg7pby2SfS0zZ/N7wyJ1RqIS6LRGEbRlDyaF3pYsThJqyrhcaQ6Li2GU5g8nP0QCxxoaMjV5y+PW3dBNajtw9uZ+tPSBN8D37RBqMJ3ArXTFH4USM9hlZq2L+R3anMEUHSe5jL6UFx0AnLy4drA0sFUZ23/r0HFVbC5FpGvCGfVYh7BS9pOK+H/D0ZxEmt8TJK73PQkB1e7VKb+lBxd5KPpr7JaoWXWASON553f8vUXyCtJcUircrWP7LUvaUROARenBqu55x9f5b
x-ms-exchange-antispam-messagedata: 3X978MQ+C9apvw02I+ViPPhsPoINZ0Q/bUpLFBzbDm1ytynn+tvx5VBKu113W3IhCSDGOlQsWL9njuZbwns1Cf4xgYnM876jCxvwi5GRKiYd1vvyPDdqZ7yyu/t9sKIeDl15tbAgovruUgt4/c+hVw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6BF50EE27DE8B4FA0F5FBF8A2854802@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942975e1-3920-4f8a-7c1d-08d7b4d866ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 01:09:42.4000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6tNNwKL/N9gbgau5CyhqXQnYSQHP4S9LqPqpa4JblEvWxojsdns8p7haPNDC3vTzHBNfr6hu4aidsqRD4tUC3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5757
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-02-12 00:28:44, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> Call cpu_latency_qos_add/remove_request() instead of
> pm_qos_add/remove_request(), respectively, because the
> latter are going to be dropped.
>=20
> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci=
_hdrc_imx.c
> index d8e7eb2f97b9..a479af3ae31d 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -393,8 +393,7 @@ static int ci_hdrc_imx_probe(struct platform_device *=
pdev)
>  	}
> =20
>  	if (pdata.flags & CI_HDRC_PMQOS)
> -		pm_qos_add_request(&data->pm_qos_req,
> -			PM_QOS_CPU_DMA_LATENCY, 0);
> +		cpu_latency_qos_add_request(&data->pm_qos_req, 0);
> =20
>  	ret =3D imx_get_clks(dev);
>  	if (ret)
> @@ -478,7 +477,7 @@ static int ci_hdrc_imx_probe(struct platform_device *=
pdev)
>  		/* don't overwrite original ret (cf. EPROBE_DEFER) */
>  		regulator_disable(data->hsic_pad_regulator);
>  	if (pdata.flags & CI_HDRC_PMQOS)
> -		pm_qos_remove_request(&data->pm_qos_req);
> +		cpu_latency_qos_remove_request(&data->pm_qos_req);
>  	data->ci_pdev =3D NULL;
>  	return ret;
>  }
> @@ -499,7 +498,7 @@ static int ci_hdrc_imx_remove(struct platform_device =
*pdev)
>  	if (data->ci_pdev) {
>  		imx_disable_unprepare_clks(&pdev->dev);
>  		if (data->plat_data->flags & CI_HDRC_PMQOS)
> -			pm_qos_remove_request(&data->pm_qos_req);
> +			cpu_latency_qos_remove_request(&data->pm_qos_req);
>  		if (data->hsic_pad_regulator)
>  			regulator_disable(data->hsic_pad_regulator);
>  	}
> @@ -527,7 +526,7 @@ static int __maybe_unused imx_controller_suspend(stru=
ct device *dev)
> =20
>  	imx_disable_unprepare_clks(dev);
>  	if (data->plat_data->flags & CI_HDRC_PMQOS)
> -		pm_qos_remove_request(&data->pm_qos_req);
> +		cpu_latency_qos_remove_request(&data->pm_qos_req);
> =20
>  	data->in_lpm =3D true;
> =20
> @@ -547,8 +546,7 @@ static int __maybe_unused imx_controller_resume(struc=
t device *dev)
>  	}
> =20
>  	if (data->plat_data->flags & CI_HDRC_PMQOS)
> -		pm_qos_add_request(&data->pm_qos_req,
> -			PM_QOS_CPU_DMA_LATENCY, 0);
> +		cpu_latency_qos_add_request(&data->pm_qos_req, 0);
> =20
>  	ret =3D imx_prepare_enable_clks(dev);
>  	if (ret)
> --=20
> 2.16.4
>=20

Acked-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=
