Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABF82D95C5
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 11:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405550AbgLNKEc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 05:04:32 -0500
Received: from mail-eopbgr40086.outbound.protection.outlook.com ([40.107.4.86]:10568
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727982AbgLNKEY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Dec 2020 05:04:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERPWGfFkYQskWhpp7CYVZtsNKmeqD1bP1JR7zqS2gI/EJgxuduaNcsNweJSOQDuTsjmRqWYJZ94qTqQUN0wvRkmLTQUc0pWYDYQnpyvdr66A2f6JBfQLa/TXOFnMjysfGjWPe7wO+N2yo8nM1+ZSod/J9Uk8/1PdUSjhXYxp6Hl1mkfU2H/X8wxYPrgbCEG6s9eFBrqyTnEoweLHqnMP2GCGX2nym582b2yn8C9bI9+h3fqd+owIbalww8/px9nOc0/QRR/2icwJciZ+6OITBMwsakLzNJ/ywCNcCQdH+RyJwTcz5X1Bl0Tycw6pf8GeCfUvIqDTuDMmQK7DhF2BIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmgE8+1WwYRDP3vn4ueQPgitrGHWerGDWrsNBBHQX1M=;
 b=eWeWub+Hla2Zu63t44WCqN/Oqo8wJx7jrcblVjgehxGt8mRrPM+bT7jZOH2PIQGF9LZBC9CUSavQ0C2Wo8FyaUHawhr74gm6kWb2QaXxktJRXypSCr0vkm2dSVmUiYEOsxZviuK4WSzC1ORAyzrl2E7CCmyrGrhxEoQTNyf4M48zKiOYYbJafWQx0JnTrdcfWPSRDLZfz6oYCbKAiJfStNwzXBohE76hxskeq+42OaSHWiLoA92X2mQgpT/649w/GLm3p0MKw7ggohrouO3Oy4pnQjPTX90age7DhLiJLbeRXJkG5EWDTdZgM1MqpPOo7cYhAEREw7Kx6XrsxPI+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmgE8+1WwYRDP3vn4ueQPgitrGHWerGDWrsNBBHQX1M=;
 b=zMx8iFh/5GRIJNa1W9gw1B3ZoI3veCorx5CEB5tP2H3T7XgZwTXl/TIsEeA4lcsQ3l3Epl0HKTnexjHruNb6TG2KXZ05pTwjGKTEouNjIIhXXaY+PD76AA0HaMVfYypwpbJ/AS2fGF1HTnDHbGaOqP6A8sZHfFM2Hstnqb+goNw=
Received: from PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ac::5)
 by PA4PR10MB4543.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Mon, 14 Dec
 2020 10:03:33 +0000
Received: from PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67:233d:68c6:cabc]) by PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67:233d:68c6:cabc%7]) with mapi id 15.20.3654.025; Mon, 14 Dec 2020
 10:03:33 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Tian Tao <tiantao6@hisilicon.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] thermal: da9062/61: fix platform_get_irq.cocci warnings
Thread-Topic: [PATCH] thermal: da9062/61: fix platform_get_irq.cocci warnings
Thread-Index: AQHW0cCa7S4KjoE410O4gRu/ca7Uxqn2XP/g
Date:   Mon, 14 Dec 2020 10:03:33 +0000
Message-ID: <PR3PR10MB4142BA80AE30A6FE17A3810180C70@PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM>
References: <1607912820-48593-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1607912820-48593-1-git-send-email-tiantao6@hisilicon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3623e7a1-26b8-4b20-f5be-08d8a0178455
x-ms-traffictypediagnostic: PA4PR10MB4543:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PA4PR10MB4543539C6D70587D81C57644A7C70@PA4PR10MB4543.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XbhXwu4F52d2XXwf4BUgNkGHAWifLtKii0h8j50TY492CvysbnmYAZ4XnQx2e6GM/CgSalT2DssnnXoNuUIP9jpzAnhSFLFUQvB+hqzsSMr/SNoZNO/PdY+fn9ZKBieg8BJrphfaC5kPIkFojYQrLB185IGvqW8qRyNHO2/Rrgul2NIvHyiN0BS8+ygQ9JNofXt0LtIennn2T2G7II3FCaAfAXSOm2K3Zt/05jD17pPHIg2kfcqA4aJtv6oStnNGh3J4eHwVQ2U75Qw0iIRz4PDT0JdY+ub8YA7cxMm+0Sc7kjC5C+1zLF/4wCUahI2ybjFQ3Xjqsk4Rt13NuqmFqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(136003)(346002)(396003)(376002)(6506007)(26005)(33656002)(52536014)(186003)(55236004)(4744005)(53546011)(110136005)(66556008)(9686003)(7696005)(66446008)(86362001)(71200400001)(316002)(2906002)(83380400001)(66476007)(66946007)(64756008)(478600001)(55016002)(5660300002)(4326008)(8936002)(76116006)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FHW34QoClbTUO7ghKIGiDJUBYvJ2urfvcgJCvz/JC2OGXWf+k4iYis0badG3?=
 =?us-ascii?Q?+GX2jHZrvYD7pibpLXi/Wq5Tg26spVynSKxPUXh90RzP9SPwZhneNDqm5o1c?=
 =?us-ascii?Q?KYAMN0GIiyBNT4D/u9POEX3Fx5WeFUH8JkOJwFRzJxqhHDfiLlyQjnv9uDwQ?=
 =?us-ascii?Q?YpzURWar/S7ar5K3EptEdGaAdQRuBt8ygt1YiJSa2m++IeRQF5eV3205AGD7?=
 =?us-ascii?Q?/+z8Xd1gCJ+vuWs5CINXZPVzjooaomlSkhfPbL97P5eT2Yl8E8Abqrv01680?=
 =?us-ascii?Q?L4+u4wnR+dSP3Cd073kyI8ggo0aX51Dg0m4B9Wk3YtbHWxDtwpX0XxML8dRC?=
 =?us-ascii?Q?BpLI/MIPWCJ3COn5vX72GADfpmpUdkKlO6DgeWxcsUSL2LS2eNBO0IRZ7ZDE?=
 =?us-ascii?Q?FxZ/6vcnbBPlJiIhCgbUoesKYYGFwiJbmeynkbR7sJ4du/qhjC9A23UMr8Os?=
 =?us-ascii?Q?5Ju0ZDAzkGqXsPvbtgTUoxYc6veRLxL83FzdXbjUVgLZG8SZieEA+mlDv8nE?=
 =?us-ascii?Q?cyAuDizkrQxlHkQiwPespsaVXOjBTmEbujEaQFiaugryk0LH0/66K6YrREW1?=
 =?us-ascii?Q?SiO3F0b7wyf2TM5PfiAhwirk7wokvfnC3HyuwDmK/d+0qBAIwyifx7X81aOu?=
 =?us-ascii?Q?QMZRpq7xOGTdQNsd0QRBzQDLBynzTYmAOwSRhnX6UVxsLxWn0sp+TBXfq5WX?=
 =?us-ascii?Q?Zl+KRmeanbSOa33L3UEMGmLN2CJOuwRpiZinE4YWz3DdBerI31JQosD8897g?=
 =?us-ascii?Q?+mgHlesJyccsfqKR6h+z37DzKqFB1g4tq6p5PoNr2ogO+TFZzO2ffcmLh2Yy?=
 =?us-ascii?Q?NUsHypCV1rUV8WMNoVehR8Zv1TWoFS/3qFr9K8Tzll3H2BifErmenU0eO36b?=
 =?us-ascii?Q?S90lxLrTOBhkeJ9D4MHwSvdQI9SRUTll4+wNjZTLukQyCUwABv53EU2XLWuW?=
 =?us-ascii?Q?x3WEgk+4Fb+UYUA3p9MZJCVkmz8aTkzjioUtXO7c2Pk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3623e7a1-26b8-4b20-f5be-08d8a0178455
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2020 10:03:33.6767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pyKECYUHL0eh7SnaBTSEvG5OHIg6H8rquLBbInVHO876Dloo7v7jyFJbtLx7dNur2oHgec2i4+DSWKI2r5MNgm+16VhJLaAbtZaPE5p6noE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4543
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14 December 2020 02:27, Tian Tao wrote:

> Remove dev_err() messages after platform_get_irq*() failures.
> Line 248 redundant because platform_get_irq() already prints
> an error.
>=20
> Generated by: scripts/coccinelle/api/platform_get_irq.cocci
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

I'm not sure stating line 248 is overly helpful in a commit message, especi=
ally
if this were to be cherry-picked (not that this is likely given the kind of
change being made).

That aside, the change itself is fine so:

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
