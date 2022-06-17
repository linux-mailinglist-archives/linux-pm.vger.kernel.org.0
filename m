Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDF654F200
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380430AbiFQHbc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jun 2022 03:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiFQHba (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:31:30 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0716F38DAF;
        Fri, 17 Jun 2022 00:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3T+is12jX7fUPVPgFMxtFt7YkJCIvtsblKAW90k+GGDZwYJrnEF5PGNdckM+CxcXwke/z8AY0xWNGFf7O4Ywyzv2pvllqW5WD8jCQXKmLaJVdpAAUl7i7tRiZYRsqawg959XnJul9cZxtTZbwnxmd1WI74U8hBGZfP0K3oF0pl/s8TuzRPEyvwmbkIzvFu7wA3uekxYBSBt3Sv3c68emnzukaAxVWB1eJv73ASJGVipkdhksjkWyEdoQQdzUBgjjuy92uZF7akR5dERTSiwi0McQdwOmsbTE9soS7BVkBAMP45elqL2RnI681U/1e5FzaTmOaUO86J7RqCyBksybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FipGIhzkH66PHHhaVUDlifw3iCGB2ONtfsxn1fzsFfw=;
 b=ntF0cLEH+U3LGPWUYa/coUs3jOx+pJCWLUHOznMCg+WG6tiwikm/xTbr9xAMilrsBwEu/9rfm0+9jXGo+7CmE3FHdNJdLloG1UV/dns1uRBGQgejDU1vxzhahLy49ggelQ/CK6I3waefv9kSha+xBwfyzfyvgUe1Z2NRgurIFtLMrVVARe0V/p02no1Agh+gKI/Pe6q1N8K6jnqCMbhZC61DMp7HkZGuNJe/YoZ/ahx3Yn9qovvLDSZN1HGLZDbjlOpGu9YmF8F5K8r3T8tPrR8JlofSmpulRPHA/zkhTnNfoN5CM9ByLX3o1Beu3uLS83y4MIKcC6+fkfkopUnrdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FipGIhzkH66PHHhaVUDlifw3iCGB2ONtfsxn1fzsFfw=;
 b=rrO9cy6b/0ieiXEu6/afd3B/GTq7Wiq1OYQYMEfEuaBcGHM/cOOf7rwKTlVRioQbVBL7soeDfnsFk3tBfXHSNZscgTOM7pl5Yuda1HphqHkUXHiJ+FtVCdsgcYahw+7qMYk7ccSThvueTWX7Ju6r6rnwVVoSyNOqKawMVy2gNZY=
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com (2603:10a6:10:24d::9)
 by AM0PR04MB6001.eurprd04.prod.outlook.com (2603:10a6:208:11b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Fri, 17 Jun
 2022 07:31:25 +0000
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::9dbf:79da:79b6:97b6]) by DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::9dbf:79da:79b6:97b6%5]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 07:31:25 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>
CC:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RESEND PATCH v2 0/9] imx: thermal: Allow trip point
 configuration from DT
Thread-Topic: [RESEND PATCH v2 0/9] imx: thermal: Allow trip point
 configuration from DT
Thread-Index: AQHYghncxdtsw65aHEeNmV298Qzo4a1TMnpw
Date:   Fri, 17 Jun 2022 07:31:25 +0000
Message-ID: <DB9PR04MB84123FC6272AF3C2DAE306D687AF9@DB9PR04MB8412.eurprd04.prod.outlook.com>
References: <20220617071411.187542-1-francesco.dolcini@toradex.com>
In-Reply-To: <20220617071411.187542-1-francesco.dolcini@toradex.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d77c79cd-3535-438e-77c4-08da50336285
x-ms-traffictypediagnostic: AM0PR04MB6001:EE_
x-microsoft-antispam-prvs: <AM0PR04MB6001C2872E738A75A3ECF97887AF9@AM0PR04MB6001.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9QSy9yIbkRm4rFk7zmcqmd/9H1ZCKGOhO7glUPqwQmXYxaaRBdHtmuz44kBvCf1EPUMZEPnbQQd41ZLpPSrgbYTCVtCMdiAtFl644BgIgtGbRQVpoenck7IpGgzC2hQA+6oYA1/D9nu16uFCXPNK2umkJM+2PIx4Gho8xpEkvlEx7LZKmV8Mf21bmvjwLaYyBsw8aKldzH0ryUcfgvHtA8rclWoi/iOgklSjdK/9/VByemlR4Rok9tD9YhPSSwOLJ8PbQPyj/BgJHx2EIHMDM+zx6nuKH3dYwIyxg8NGxcGFkXG6e5SOzt3TfUaTKtv0nWsFuJ0H6u9trtri7zbOjAAMxOjBdzy64kX5SmCtV8BdbwCTOWeZfdxLjwME64p0y3pLz3Vio3ik2sVsezIHXTbeJgBwQmEq2rEcAvpxtga7Zeb/k6RNWiJ7ZCecgEjIXzpvRWsLt9W0q47X8o0hUDo1xox456aRZbhFEZW690gI7qTpbjz+yIiOEbevCwsQDgJrFAOvSS6vFRhkQVXGBNaOOuWC6OMnDGLXrc4kJ6ourzxgYGQxVrqGoquCn9EYAld5j89M5i2wEyr3paKfhK0J7f0iXeyHk9GUyCY6I4bmSwkGDvgFLSSG/MsQP42N4dGSvze2Xr7pSoe8Mct/hMbGY+eexhZcuQQ3IJkmzUQhQxQ9aD+3VVYhVKkLBK7gvHBfDmDNnP4YCs0R4TBNDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8412.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6636002)(8936002)(33656002)(316002)(54906003)(508600001)(6506007)(26005)(2906002)(7696005)(110136005)(8676002)(52536014)(4326008)(66946007)(83380400001)(76116006)(66476007)(66446008)(64756008)(66556008)(45080400002)(71200400001)(5660300002)(38100700002)(86362001)(38070700005)(7416002)(9686003)(966005)(186003)(122000001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pw3gsVuv5naqjL3Dh20kNQDmQcBId2YiCorpeKdervFYHgIuTXNEbFWhQ7FV?=
 =?us-ascii?Q?bvNpWzcqJV+ein2sBvYDJDqH+puJ3P5mQawjRaQ3WahjAm4zA4r4CY05KD2c?=
 =?us-ascii?Q?FweGsIUHtjKqDxOnaPWr624YWtgmccRzpRW2hZCZ51GdEPYly+/jHWifqPW4?=
 =?us-ascii?Q?QJb/svQhpiPzFnSLEFw5+XoC7CSfkS+2enmUocYX/J/Qw0yTnYoALI+3poVp?=
 =?us-ascii?Q?BwKNdkhfpfk5kPB6xfTi51n1SjyARYYxMtWuWjygmw8LVSZciOxwPqdWtQv9?=
 =?us-ascii?Q?Fat39PS/rwK6FJytArAGeQ//SDe7sh8RKIJNSQIpT9X5fBUzDKmKQogDW++s?=
 =?us-ascii?Q?g0hk6kKjDdy6pofav1cGLWs9gBVlOMe9YtbGtK/GP7vSY4vNZVP2LNLREE3E?=
 =?us-ascii?Q?MrgYnrB2wA57/npZC4LKFNjbS6lHcW5FQFwNrvw0+tDGongI6zsxDlOsKFzS?=
 =?us-ascii?Q?mHoFIxZ35DiQR1n+cUhC3iWcBHRYAPhDBEN2JWJ6nBR0GXVS3SFuKJAG55Sm?=
 =?us-ascii?Q?uxwWnEn94kl6M6oPbqeXdb7C57YgS36gMbuKC5/XJkLClmx6ANArqWUzHJT9?=
 =?us-ascii?Q?LzHzlTkh7aI+VazEEsc0IvyOSh4nzFibm4yGdzsPwJQU5ivxXP74hVKQ7qsf?=
 =?us-ascii?Q?eS5CTWPJTuoAFEFomn/eCv7w96eJCuuhQ7YFEVsAGgsXLfRDwFqS0je8dXOt?=
 =?us-ascii?Q?mZ8nYIS2YKH3TkKdszC9rGyFX/QLyPBWFbWhYmnzqFwZcNaaM8XhIE7kPSZ6?=
 =?us-ascii?Q?SqveA1ub5aR1BUEdQ3bf3yOO1hJ/lpIUDxR5yeo/pNzNcagMVb3skchxoSr4?=
 =?us-ascii?Q?4qf0o7qfJj4f0SAHEnM1//Uv3922Z5CSwGRiUyF+MUT0NgrP9u1D4yIT26Pt?=
 =?us-ascii?Q?iSc/iaQ2kBUSYK5fncB4ykyyCb0GwWac2usXVu6tbOk5HGe+HIIrBCgQM+UO?=
 =?us-ascii?Q?0hDmG0TMf32OAySmR5KI36NEykikLKqmozl9THdhg7+vWBcxxisgLHdYreo9?=
 =?us-ascii?Q?bZN+a0SpeTlcIu4B9ZBRUK7ANx7Lqm3DreEMQmJQaWjPN9m/qUXJ437eHuoV?=
 =?us-ascii?Q?K4MWoi1W3tNvAmB9MkuUYaLVvRhcdsp/vES5LWfc7kSauKZl0vqElDfrTHs6?=
 =?us-ascii?Q?vkfDPaN4Wt5ytvMrwr5xY5EZtAcfGI9yVPJyZo4eq/Lwfesb33N2ejyZykV6?=
 =?us-ascii?Q?T5yXzcvRMHRXUmLlBdlDMQN9DeiTk/oDdR3XT4MJz80t+WgNA6AIRS3ydcT6?=
 =?us-ascii?Q?5Tad3IHiZSqe1CBknBRiu1vcAK4UxhzPYv+4T9pzByvLGmbd1jamfD7FJSYZ?=
 =?us-ascii?Q?NHPkyaPiPebYK1XxKws3AGylTyqCN+ScROrS2hat+cImjgyo7tFZOjoLSpXv?=
 =?us-ascii?Q?igAe9DOGHql36SZoq8AQ5LmakdUBtu9Hln5iLbCHcTv+EFh6AfB3X8d3eoRt?=
 =?us-ascii?Q?2Qr1bvPbCEhopbnzxBjCzZXtCc/UHDaXU/M7d/va3eTiQDIygc019ApQk/VI?=
 =?us-ascii?Q?8OAXvxfTIW3/apzXqSUlTcixaFrMHXS8zGZHQa5GgSzKMez22UvVDZoo/oDI?=
 =?us-ascii?Q?eoL4N7b1522EgaxJA+LCT9Rx8CwrYOR123kYZUgCIa7EcKv5yMWYitec8ww3?=
 =?us-ascii?Q?kT7JHmVYt4/KLhXEFmj7+IF0PktguKG9TpcdplTn5gBv7AnEFj8ooCJOVAa1?=
 =?us-ascii?Q?QOb9txKpJpUu4JQY6eoRo5oM6VhNhx/UN0nWlByTeVaPf98B?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8412.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77c79cd-3535-438e-77c4-08da50336285
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 07:31:25.2658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QDhPCQvMR5LvhSNl+c96zGiUX14fFbgizEIx6cg7xk3K5mIc9ZpI11sZN3BzW4Kmt4K/vmjYOCi9yOKh+T1lFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Subject: [RESEND PATCH v2 0/9] imx: thermal: Allow trip point configurati=
on
> from DT
>=20
> This series allows to specify the imx thermal drivers trip point from the=
 device
> tree, without this change the threshold are hard-coded and this might not=
 be
> correct given the thermal design of the final system.
>=20

The threshold is set dynamically based on the part market temp grade. I am =
little confused why need to specify it in DT?
I saw in 'PATCH 5/9', you provide a threshold table based temp grade, why n=
ot use the threshold from ' imx_init_temp_grade'?

BR
Jacky Bai

> This change is backward compatible with the existing device tree, and eve=
n
> with this change in by default the thresholds are the same as before.
>=20
> Toradex board are also updated to use a system-specific thresholds.
>=20
> Discussion on the current design is here:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
ke
> rnel.org%2Fall%2F4ba1d7d2-3e8c-ba60-37fd-9598f415c076%40linaro.org%2
> F&amp;data=3D05%7C01%7Cping.bai%40nxp.com%7C3bd9173c93184270acee
> 08da5030fdfb%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6379
> 10468593014918%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
> LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&
> amp;sdata=3DL0T4514vcK0Nl1Vv9EVNdhDJMpBGqIRP68GFKVeBvwg%3D&amp
> ;reserved=3D0
>=20
> One side note, after this change the dtbs checker starts complaining with=
 this
> message
>=20
> ```
> linux/arch/arm/boot/dts/imx6dl-alti6p.dtb: tempmon:
> '#thermal-sensor-cells' does not match any of the regexes:
> '^(automotive|commercial|extended-commercial|industrial)-thermal$',
> 'pinctrl-[0-9]+'
> 	From schema:
> linux/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> ```
>=20
> to my understanding this is just a side effect, '#thermal-sensor-cells' i=
s not
> changed in any way by this series. I can fix that, I wonder if I should r=
emove
> the property from the imx dtsi files or add it to the binding yaml defini=
tion, not
> sure about it.
> Anybody can advise?
>=20
> Changes in v2:
>  - fix build error without CONFIG_THERMAL_OF
>  - more verbose error reporting in case the dts is not correct
>  - additional comment on the threshold fixup in case the passive threshol=
d is
>    higher than critical
>  - while parsing the dts thermal, return immediately if the node is not t=
here
>=20
>=20
> Francesco Dolcini (9):
>   dt-bindings: thermal: Define trips node in $defs
>   thermal: thermal: Export OF trip helper function
>   dt-bindings: thermal: imx: Add trips point
>   imx: thermal: Configure trip point from DT
>   ARM: dts: imx[67]: Add trips points
>   ARM: dts: imx6qdl-apalis: Set CPU critical trip point
>   ARM: dts: imx7-colibri: Set CPU critical trip point
>   ARM: dts: imx6ull-colibri: Set CPU critical trip point
>   ARM: dts: imx6qdl-colibri: Set CPU critical trip point
>=20
>  .../bindings/thermal/imx-thermal.yaml         |  27 ++++
>  .../bindings/thermal/thermal-zones.yaml       | 130 +++++++++---------
>  arch/arm/boot/dts/imx-thermal.dtsi            |  61 ++++++++
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi         |  12 ++
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi        |  12 ++
>  arch/arm/boot/dts/imx6qdl.dtsi                |   2 +
>  arch/arm/boot/dts/imx6sl.dtsi                 |   2 +
>  arch/arm/boot/dts/imx6sll.dtsi                |   2 +
>  arch/arm/boot/dts/imx6sx.dtsi                 |   2 +
>  arch/arm/boot/dts/imx6ul.dtsi                 |   2 +
>  arch/arm/boot/dts/imx6ull-colibri.dtsi        |  12 ++
>  arch/arm/boot/dts/imx7-colibri.dtsi           |  12 ++
>  arch/arm/boot/dts/imx7s.dtsi                  |   2 +
>  drivers/thermal/imx_thermal.c                 |  58 ++++++++
>  drivers/thermal/thermal_core.h                |   7 +
>  drivers/thermal/thermal_of.c                  |   5 +-
>  16 files changed, 283 insertions(+), 65 deletions(-)  create mode 100644
> arch/arm/boot/dts/imx-thermal.dtsi
>=20
> --
> 2.25.1

