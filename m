Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBB82DE0D8
	for <lists+linux-pm@lfdr.de>; Fri, 18 Dec 2020 11:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgLRKRv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Dec 2020 05:17:51 -0500
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:56230
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbgLRKRv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Dec 2020 05:17:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6ktqwunKdXdOVbGJAP+XMpbFhTYPsgE5XeZIHtZ8rjtBf+fhlUTaDg9V6hBftLXSMfxpJRmIfDqVyAl7nzHJQL/kissxlopIrlIh5mwMhv0/13MOLq1YT/8H5wEmVwWeJGRZY7o/+8Lrkp5XvVXd3m/9MtgVz+GdLUl4ECFnhO/x1K899IwLaiLAkUBBdqizmmvIDIzLuvDArUN+V1EfHGCJdCbd7mSjIAxqeuw+9SOj31DgGtRLq/0S3JNbdgWw5KTYaVROQ8Unh0oRk46GlH6WG3UFud1Pnga0f/Wl27q3FRWjBpK51F7l1PoZFeeiNQZdFCeDMbSLRsYy2mseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvDB7ZDrjKCRlx15pvQ12/l1jQwGxlzsDf4GLxgaDCQ=;
 b=cOihb5fl0aZ3wn0u0o6mjs6K/JmEfzbGNX5Oy0zwycCVml8SpST6BFdWvr19Mv/+GCfuNbM6rtBIUs4PZ6BMKuIzpzLEh+jlSvXVJBjOe/7N6894+MTpCLz5awM4V8ox3MhRJQQWBrQeuT1136AB60UlJaKCB4jfa6yDXXEe21kjgTGOCsT8eIbGDN2yeCX800H+GadzQ8Wz8sa8C+fNB+KTXWTjRP1G9oWxSDLnqjq9eYeIvcICLmc3/EXPP8f4Lahw0FFSahBIkIwIgJs7rJN/pKERHbVcUIFL0x2KntsjkI0K72cxhqM4JvqsWkse4UuvJz/BAiNLpjPnyqURlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvDB7ZDrjKCRlx15pvQ12/l1jQwGxlzsDf4GLxgaDCQ=;
 b=XJchKKuhun8KqThLWrSYXRJ67d4pqEdC95LMQIv7Q2qopLRJQhGRDBYWNH4fqEvFX+zipr00+E93dsPGAjo1I2JtQqP24gjxyhGNAFjhQDGCVEdy9xFKRO6a7jSCua1VQE3mzRUuSZIJcIq1AiTkAJqJgWt3U4Yp7NBhjSIP1Ds=
Received: from PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ac::5)
 by PA4PR10MB4430.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Fri, 18 Dec
 2020 10:16:58 +0000
Received: from PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9d4e:b196:aa2b:8890]) by PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9d4e:b196:aa2b:8890%6]) with mapi id 15.20.3676.025; Fri, 18 Dec 2020
 10:16:58 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
CC:     "amitk@kernel.org" <amitk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        "open list:ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] thermal/core: Remove ms based delay fields
Thread-Topic: [PATCH v2 3/3] thermal/core: Remove ms based delay fields
Thread-Index: AQHW0/dddwj6ndFqe0GzdWQRg6m6dKn8pRZg
Date:   Fri, 18 Dec 2020 10:16:58 +0000
Message-ID: <PR3PR10MB414206497B833D717BC627A280C30@PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM>
References: <20201216220337.839878-1-daniel.lezcano@linaro.org>
 <20201216220337.839878-3-daniel.lezcano@linaro.org>
In-Reply-To: <20201216220337.839878-3-daniel.lezcano@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [147.161.166.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3e0048e-4fbf-4481-5166-08d8a33e0da0
x-ms-traffictypediagnostic: PA4PR10MB4430:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PA4PR10MB443070C80376247DEDC5DC2EA7C30@PA4PR10MB4430.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWd+OP58+ajRHfFxjf5Svlwvtqq9ovdvFwHGq5/G+2iQ0FbuvTcgPLky2hm+baUyREOpI6cL62EZSIol0n5jpqM58W+BVH4YpzegDiZRpXQHe9Ik1A1Ob+DoUPey0NPRAJQcVeLxlHiyZy6Ln8cGH3ySVaKZ9r1l6aoQ7ZhEqL+Wnd5nhLT5zrT/g69D/9lJx+FXu/JZFhqNr9xNGnv/ouyamy3MDyt2mZ53RD66poqhJngvWVssT7i5Ye64JFkmkWYtYr7sADd5LZB5LV6WrCu5M0ZPNj4MyRy/+AegPPYuhIk/xpkTKnA7Tf7KW6eFAz3/RnqeqTLFBWIiOFF1oQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(366004)(136003)(346002)(376002)(26005)(4744005)(55016002)(53546011)(8936002)(186003)(6506007)(71200400001)(76116006)(9686003)(66946007)(66556008)(66446008)(64756008)(7696005)(86362001)(66476007)(4326008)(316002)(52536014)(478600001)(5660300002)(33656002)(110136005)(54906003)(7416002)(2906002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DkaEP+oABcRq+0bsw2eDlZsmOVzBuXQ2R/ifmbAwTtmySHVzMoDYVcsiV8+L?=
 =?us-ascii?Q?mV5PHVKikg+5Mhlm0VsvQ3KP8fbpyKNG/VX9K3bt+kzS7QzEEfKJEcO8bBf1?=
 =?us-ascii?Q?v64znkK83lSqriaA79l4z07p2T53AEez1u3FV/Gh6nv4rEpJMIWNHvKFutqx?=
 =?us-ascii?Q?E6VE1Suyd/fJjD0iAFLDjkFYA6oSJ3O2fHJGd9o5nijGJhk9w1XmA/aFsOfJ?=
 =?us-ascii?Q?Y0weCS/H2JDPInI/7d1vKnskE1KUIP4ULL5msGoGHzt0R6NpxEeIN4ytIkSW?=
 =?us-ascii?Q?MbLWsDro3IxQyFlG8iH9Cfng0ENGmTTtXrHT8ywNwXJdk9Vtdo97fz7bmbzL?=
 =?us-ascii?Q?5hShPqxq/EuyffC5pZS9Hul/oQs9FNtQY2NpI8UrzvwrFuwfMtEUXkL2xZ9v?=
 =?us-ascii?Q?4tgcuCWEf4THtcERPlOydOdkkkuO7WW42B9WvYOMbgXiCH6IDQnWD7xwgSOV?=
 =?us-ascii?Q?t3F6UeEDxjUKDSJM2cV577wOYE8VRRftLDHbIIg+CN87eM/iK0s8I+L1KbEH?=
 =?us-ascii?Q?zValV1hzmpCQuVhL1TlmmWDwdDjY528uHSzBAoCUNYnoAYSCqQ39YQrFIgQf?=
 =?us-ascii?Q?35H8JLWfTcZniAiMEyLh+Fu0UHAxTrW1yC8KtFjyBN8BaW8kjBQ09W+h4vTi?=
 =?us-ascii?Q?9c0BcPqRUPP5Irxd2b0fycogB/6XOEbyTB2kNVmcVbB96I+GqgbA1w+T0LxD?=
 =?us-ascii?Q?6J+m4Dm7NQVTXCMxYkQUqsMXs2bDrGMdPps+1gi9EzExgh0E+luhIDFYpb5w?=
 =?us-ascii?Q?ytkPDZmsBapq7UBeySpfNhL7r1BYE0+Q9j4inS3y1be/23IdAQV3zV1Oh1dV?=
 =?us-ascii?Q?EYlsQh8W2dRRQF76w9+M1bXTRGPvWGbMHbmSqT2v6H6tbWXkNYkgaHZWeQnw?=
 =?us-ascii?Q?zrjvKRF4usud/lYV2QW6+L0i8CAN33AiLbmVi5Gfps9bh514RnuBVE7Nrh/R?=
 =?us-ascii?Q?9VT3lHFfVWJKKuy9AgzuVddn8nFq9yfokhJ01GpfIiQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e0048e-4fbf-4481-5166-08d8a33e0da0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 10:16:58.3889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u3ZSJGOGkPrhaWDR2nLVe5EVnNRoQ0Hh2d1BjN70mNuQSzChVcBCMOkUFUjQZcuVV3iRuRPiiYkqCsEOqzrFVi0SR2AOyM/TvFwHVdEpLmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4430
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16 December 2020 22:04, Daniel Lezcano wrote:

> The code does no longer use the ms unit based fields to set the
> delays as they are replaced by the jiffies.
>=20
> Remove them and replace their user to use the jiffies version instead.
>=20
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

For DA9062: Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
