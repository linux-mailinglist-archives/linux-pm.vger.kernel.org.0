Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E4C110273
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 17:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfLCQhL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 11:37:11 -0500
Received: from mail-eopbgr720091.outbound.protection.outlook.com ([40.107.72.91]:61985
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbfLCQhL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Dec 2019 11:37:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAOJajBQeQnn3jjsWPdC29EfnAnUMQEqBk8omK+hUYzQal54GYZXtp0dtBKe3NBezENuUG6lxWq7sSB+MModKDUxCedfOIn+RwguXJBDRhlx/+T/leT820f+0ZmaErtx4Vz40wFtNDWn0EYe7b65inF/4QHcQJia6vltpn8YMFIqntk9E5ed/SGQzZZBMscU7IVDiXziHPluyUwyP/zeTRk2ppQ+Z+Gl9kS6VCp7TPdopK/LKggX/KULhGvIZYaPpBQEFVAZ7Snh3HYZrqBPe+ceTUwat/vNZsdAPVKVHO2w8L42PKrot2KmT6s8/jy1ZKK7bAk+VJoo/0/pqUQNzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79yWg6ipj2rqJngPInEFgg0STwuUBqhFjiVYFyEFgfM=;
 b=cZZRTedcwJy9DTBuBZXNoWSDGUWUAPT/G5QZt4Kj1WqDd6r6KTge97/FIARGGk/C0ml4VYIq0fQVhgx2Cws3XXx7Bz8f5NIvj9jqebcRURoNkvfrItF0fRh7x0i4ZGT1t4fQFU+BnD/GAxBOhifTRhBu6Ztf8ybgIwRshBEZ/o/q7bKuqxra9qFR+4FPTj3i1GnHm33g/0asgIiiagAjLnUxWrjXm5zzb/iZiAD1Dy0KUAbEpD2rtcFkr4YEXK+UpWZGIdWeg4XYb4ky74W6uCdi9LvFjUI1qa4gdjs0L9PE1aXzpeQwO+6BbF/U99O8002n40/PwCqhfj4Eg5vFDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lexmark.com; dmarc=pass action=none header.from=lexmark.com;
 dkim=pass header.d=lexmark.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Lexmark.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79yWg6ipj2rqJngPInEFgg0STwuUBqhFjiVYFyEFgfM=;
 b=YDNgM7dbB6ERrXa6fcap5BDI8KODObwTHYEYowKbIBUZoCNnkljuetQHI7AB4aDf/0tKP8XoHHh7vNQt59XJWGpsWhbkxgq26G/Otk2apLZATkcQvuZDQCpToRT8E/QD2Of8aF+9CMPh8wzAdvRX7bWlN0AMLzzqEdb8ZmnTlzk=
Received: from BN8PR10MB3379.namprd10.prod.outlook.com (20.179.140.29) by
 BN8PR10MB3316.namprd10.prod.outlook.com (20.179.139.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 16:36:29 +0000
Received: from BN8PR10MB3379.namprd10.prod.outlook.com
 ([fe80::70e5:6f18:2e0f:62e8]) by BN8PR10MB3379.namprd10.prod.outlook.com
 ([fe80::70e5:6f18:2e0f:62e8%2]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 16:36:29 +0000
From:   Zak Hays <zak.hays@lexmark.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] thermal: armada-thermal: clear reset in armadaxp_init
Thread-Topic: [PATCH 2/2] thermal: armada-thermal: clear reset in
 armadaxp_init
Thread-Index: AQHVo+iA1kyC2QuZu06OWcaFrvNw2qedirjRgAFRLACACcfSvg==
Date:   Tue, 3 Dec 2019 16:36:29 +0000
Message-ID: <BN8PR10MB3379AC7EF5E941B9234B7E628C420@BN8PR10MB3379.namprd10.prod.outlook.com>
References: <1574721077-29892-1-git-send-email-zhays@lexmark.com>
        <1574721077-29892-2-git-send-email-zhays@lexmark.com>
        <MWHPR10MB13435C92C02136EE4582B1218C450@MWHPR10MB1343.namprd10.prod.outlook.com>,<20191127120018.679bf947@xps13>
In-Reply-To: <20191127120018.679bf947@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zak.hays@lexmark.com; 
x-originating-ip: [192.146.101.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49288bd2-7192-4cc6-b432-08d7780ef29a
x-ms-traffictypediagnostic: BN8PR10MB3316:
x-microsoft-antispam-prvs: <BN8PR10MB3316502D24DA3CAC21C7CEF18C420@BN8PR10MB3316.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(54534003)(199004)(189003)(8936002)(6246003)(7696005)(55016002)(71190400001)(446003)(229853002)(186003)(44832011)(11346002)(6916009)(14444005)(3846002)(14454004)(4326008)(81156014)(81166006)(8676002)(6116002)(2906002)(256004)(86362001)(7736002)(6506007)(76176011)(26005)(33656002)(102836004)(53546011)(305945005)(71200400001)(99286004)(6436002)(54906003)(25786009)(74316002)(478600001)(52536014)(5660300002)(316002)(66476007)(66446008)(64756008)(66556008)(66946007)(9686003)(66574012)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR10MB3316;H:BN8PR10MB3379.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lexmark.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eR4/nQxg5uvI+ALNv+y/MttpMFeb/4/3jicmOUJP8r0FyZpVxY8kDQNcdczxK9J0YCq8iY8NuYv1zan3xZDVXfklmMTqkf8MqZqTPxp3SO9K+ICwANpvoW6ey1/A9XGbf7yMGIFQiy9KgqBNOFTdVrF9YlLgdNwx55g6kYWFLEQgg0vgrP6JrybcVe6dU4cJExYHD7Zo23dj/ZBIymMDavKrBSQjc+vZkoHccNdrPJAzB9r6lLdTwhTOOqnm2ju3ocXDdk5lzjIcKKa67/62kU/nQXjixDE66ai7NYfgUjQK2wTcWXUQWqo+hsFf0ZSl8TH/CAMXRlf+A0sN2tgQRoxjJTwes1mqqbUyEnb/1dfGa8mCI76SreZb/HpTwDyCgmxzAyYlQQFWyW87hTMK4ZXwnWI3vD8I4vaxCGBiJgxsvWMmNm5iHa34htorI8vl
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Lexmark.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49288bd2-7192-4cc6-b432-08d7780ef29a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 16:36:29.0175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12709065-6e6c-41c9-9e4d-fb0a436969ce
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6sGpgFXEO6Gl4k9hoVnjtpnaK2cZEbxQnIYDA1M4Fk4TRvF6BBukybblWcNdkGytobsOf4cb80lrw1fl19JO4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3316
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Miqu=E8l,=0A=
=0A=
>The format of your patch is strange, there are additional empty lines=0A=
>which are problematic.=0A=
=0A=
Apologies for the formatting. I'll try to fix that in that next patch set.=
=0A=
=0A=
>Do you really want to write this register twice? Shouldn't you get rid=0A=
>of the first regmap_write() above?=0A=
=0A=
I'm writing the register twice in order to pulse the reset line and ensure =
the block is reset at init. This is similar to what was done in the driver =
previously:=0A=
=0A=
        /* Reset the sensor */=0A=
        reg =3D readl_relaxed(priv->control1);=0A=
        writel((reg | PMU_TDC0_SW_RST_MASK), priv->control1);      <=3D Set=
 the reset bit=0A=
=0A=
        writel(reg, priv->control1);                                       =
                <=3D Immediately clear the bit=0A=
=0A=
I'm a little unsure that setting then immediately clearing reset is enough =
time for the block to do a full reset but I can't find anything in AXP's do=
cumentation to indicate a correct reset time. As such, I just emulated the =
original process from earlier kernel versions. If you believe that a udelay=
 should be added, I can add one in the next patch set.=0A=
=0A=
Thanks!=0A=
Zak=0A=
=0A=
=0A=
________________________________________=0A=
From: Miquel Raynal <miquel.raynal@bootlin.com>=0A=
Sent: Wednesday, November 27, 2019 6:00 AM=0A=
To: Zak Hays=0A=
Cc: Zhang Rui; Eduardo Valentin; Daniel Lezcano; Amit Kucheria; linux-pm@vg=
er.kernel.org; linux-kernel@vger.kernel.org=0A=
Subject: Re: [PATCH 2/2] thermal: armada-thermal: clear reset in armadaxp_i=
nit=0A=
=0A=
Hi Zak,=0A=
=0A=
Zak Hays <zak.hays@lexmark.com> wrote on Tue, 26 Nov 2019 14:54:11=0A=
+0000:=0A=
=0A=
> The reset bit needs to be cleared in the init sequence otherwise it=0A=
>=0A=
> holds the block in reset.=0A=
=0A=
"thermal: armada: " is the right prefix for your title=0A=
=0A=
Your Signed-off-by should be here (git commit --amend -s)=0A=
=0A=
The format of your patch is strange, there are additional empty lines=0A=
which are problematic.=0A=
=0A=
>=0A=
> ---=0A=
>=0A=
>  drivers/thermal/armada_thermal.c | 3 +++=0A=
>=0A=
>  1 file changed, 3 insertions(+)=0A=
>=0A=
>=0A=
>=0A=
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_th=
ermal.c=0A=
>=0A=
> index 88363812033c..8c4d1244ee7a 100644=0A=
>=0A=
> --- a/drivers/thermal/armada_thermal.c=0A=
>=0A=
> +++ b/drivers/thermal/armada_thermal.c=0A=
>=0A=
> @@ -155,6 +155,9 @@ static void armadaxp_init(struct platform_device *pde=
v,=0A=
>=0A=
>=0A=
>=0A=
>          regmap_write(priv->syscon, data->syscon_control1_off, reg);=0A=
>=0A=
>=0A=
>=0A=
> +       reg &=3D ~PMU_TDC0_SW_RST_MASK;=0A=
>=0A=
> +       regmap_write(priv->syscon, data->syscon_control1_off, reg);=0A=
>=0A=
> +=0A=
=0A=
Do you really want to write this register twice? Shouldn't you get rid=0A=
of the first regmap_write() above?=0A=
=0A=
>=0A=
>          /* Enable the sensor */=0A=
>=0A=
>          regmap_read(priv->syscon, data->syscon_status_off, &reg);=0A=
>=0A=
>          reg &=3D ~PMU_TM_DISABLE_MASK;=0A=
>=0A=
=0A=
In your next iteration, please use the '-v2' option with=0A=
git-format-patch to get titles starting with "[PATCH v2 x/2] ..."=0A=
automatically. Also write a changelog below the three dots '---'.=0A=
=0A=
Thanks,=0A=
Miqu=E8l=0A=
