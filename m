Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C990E33ACC8
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 08:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhCOHwl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Mar 2021 03:52:41 -0400
Received: from mail-eopbgr60105.outbound.protection.outlook.com ([40.107.6.105]:47776
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230113AbhCOHwU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Mar 2021 03:52:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7FJrjzlntPvew0G9vxkDjaU2r8R55lm30FvIAErSVeZZcyf4WHVjEpgdfMNhOAi7HLSpOhej+tr6h/ssiNNJvXFSL9PBXhK55wFMwO9wglK79yyIpZILuBpUTQ1lxzCzagi/aajR88bv2K+RLEBdvVwi1lUP3AsXAwTFFw7Qri571tzBUZoqKRSbzRODhdgNHa5CDQWrYpNmWGmuBdsdMYwo4I1ATdGC43cEq7/mRUhy8dIGiHoaKaOGQstW8xNMhD0bQJp8txGpr6sp1xrQUe8so55ZL/tVzMb2bfNTWTtL6wXTXunlg5BQ5C0vuqImcXMW3NzkmkXbv1heDXOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXeEq/lVqIOwwcU6DjtqOEEc772xq46Qg71NWSeCUw0=;
 b=K+srvuGTTu3niEXBdb9tn30R46j4URYJ+sZ46IgDJDCgZ+M8HY+AxAZ/03B7M2AL/D83hWUfwfBPF8xpTpK+23cKuqdL4/qj/b+QGbSCFDLHDKtn8oU3/qtxYJdXd1a1+yXtajlZC7ctVUlaremxetLQBzoJSJDWVBjZduYMJobVEXk4lId/KGNgKjdFpujblk0JkPy1bxtu6lrMfO0YMYtVrw8N/Inv7+x35bVokKVjPqotOmHWmhtNNRbdUb8GJHRfjBKYu7rY3kOFz0UQGPvostRvn4jk/S50lsvfu+qJ0iAS6bMxx5vOPmwirEfZ/zROksAo2i+zlARoMS3dow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass action=none
 header.from=leica-geosystems.com.cn; dkim=pass
 header.d=leica-geosystems.com.cn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXeEq/lVqIOwwcU6DjtqOEEc772xq46Qg71NWSeCUw0=;
 b=D8R1J79pPM4AUCoaMCdkbHoi698zRbPDGK+oESImX3RwJQN16gEhGoK3Tc2AyFTY6jZLcwX3UGwr9z8GydqOChX7R3yTgB1+cvMXtm5no5xmUPnJMTlmDih+j9cRJjMoTJdkTk8FYBYh5POOUy+ehaNqQIMbCDMaaeGBqnQPBP4=
Received: from DB7PR06MB4571.eurprd06.prod.outlook.com (2603:10a6:10:70::20)
 by DB6PR0602MB3336.eurprd06.prod.outlook.com (2603:10a6:6:4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 07:52:18 +0000
Received: from DB7PR06MB4571.eurprd06.prod.outlook.com
 ([fe80::dcab:24bb:617a:30ee]) by DB7PR06MB4571.eurprd06.prod.outlook.com
 ([fe80::dcab:24bb:617a:30ee%3]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 07:52:18 +0000
From:   LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
To:     Sebastian Reichel <sre@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>, "afd@ti.com" <afd@ti.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        TERTYCHNYI Grygorii <grygorii.tertychnyi@leica-geosystems.com>,
        ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>
Subject: RE: [PATCH V5 0/2] power: bq27xxx: add bq78z100
Thread-Topic: [PATCH V5 0/2] power: bq27xxx: add bq78z100
Thread-Index: AQHXEYvBE1Tk4NaU40mHgN1zwl9D2aqENCwAgACIgIA=
Date:   Mon, 15 Mar 2021 07:52:17 +0000
Message-ID: <DB7PR06MB4571E4F1F919E51227C75639D76C9@DB7PR06MB4571.eurprd06.prod.outlook.com>
References: <20210305064949.2680-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20210314234202.xijndjgltdcyuggh@earth.universe>
In-Reply-To: <20210314234202.xijndjgltdcyuggh@earth.universe>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=leica-geosystems.com.cn;
x-originating-ip: [140.207.15.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d9fe314-dd9b-49db-1047-08d8e78741b3
x-ms-traffictypediagnostic: DB6PR0602MB3336:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0602MB3336021FABEC86D0DEAA99D9D76C9@DB6PR0602MB3336.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LkrGgmtw85gbMK69bFbP4+JzEyq4TPg1S+Q2R2bE1JknZo9qPo+qcFO8GcziR+dv81FaYkuy58h72pj5H2JZvRuwx6hzg8hYOAghel91ZwldB0C2j/eKoEzHzEEnUtERYyhe1kswUOX8/3q9dY0KIiDhbGRDXpTTZWqLIi8wX0Wl6tsijks6O6U1WdR2MCon8zQ3RHT0SmtvUt9QyquvB2RvZcPYM7mkbRYPMLadRc8YdX47nkTaL/bJrB+1n1ZgeKvrBSosUNap/+uJon/QAwvrlpfaKNVYP0SijMmXI/BqTgWKacFXRKYi1MSqrW9e7Lto3oyzyGVv4WkQv6aAkMidpYuIMaNViZWvtQMUiGjnUf12d3kfewHaaolDjbKzJrQsyS8474AlZu/G0MkgNfgaj6+UrGeihn+NYs+eNYSrKYavGbMaQSFu7vQlr536P2iuZX+hk1q+O/7TzLcSxPKX5y5jImigOhq8luH2WLhzV5coJGmD8nX5a3RFtTY6ibZmuPif1PRlNO49QuNU4VuH1NyampkWfdeZR7PSQbwd1vkQW5O7Z0ov2Svq4qoDT/+HlJVzWgZSjOt7bJpjwpZ0mPvQBBp2uTWR4qA0gu/k8iE4fYJ9yxTOW0CkuPQabYN9Wux5Z20NHCMreuRmIAkD3t0N+DGg3wacC078T1i14BDZ34OUTODYR1db1SOR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR06MB4571.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(52536014)(33656002)(7696005)(83380400001)(15974865002)(4326008)(6916009)(76116006)(66446008)(8936002)(66556008)(64756008)(5660300002)(53546011)(71200400001)(6506007)(86362001)(107886003)(66476007)(54906003)(9686003)(316002)(2906002)(186003)(8676002)(26005)(55016002)(66946007)(478600001)(138113003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tUhWRz0QZcuIzqoA1k6hqcNRYTgnng0am3mG2+vxIdJ2BmUXkImHcqtay0he?=
 =?us-ascii?Q?FVBOjH8nGI0eLuRmgpDG2TbOZwaje18U2AGHwb/yKdrYn6573dvRSPVS3rP1?=
 =?us-ascii?Q?SfDEMlvnqUgazqGaiGLBCVlFTA6vFVWXFbkac3/7DDqpGOgPSFsJ6gPTR3tz?=
 =?us-ascii?Q?SMpk3UfW1bcR/yljEFfygCHhg3PmWQbDrZ5MWNbtoYyIN9cdU1ieqR5iK1es?=
 =?us-ascii?Q?TIYSc5P8UTf779AuBFpmdYhKVBAeI5/DlthulfJLuJWhKHfleU+Ue52ATW1R?=
 =?us-ascii?Q?j02V+fSz49Td4im3GA0AhJu0ZWjjUQJVKx1RcbVJVq0F1UDqLfGRpgrw9V6U?=
 =?us-ascii?Q?zofHTddOd/gcdoGTz9YX+qAaWAzsAA5sf9I+wsvLm1mK99cvZtqgcz1JvS5V?=
 =?us-ascii?Q?MHLsXghF3RxBDyWiwFEnVZqsZ77DR9TH/LJNSeJLo7vXLhhj8WId+Ej2zf+u?=
 =?us-ascii?Q?IEveRJgrcIkwPB7gWUSd3wJXnV/pdH6oy4x4PnwBCOmweCEGIlXMjPCmK2Rk?=
 =?us-ascii?Q?UmqRXewlwqoYs09D2UpAAc8c+1+bmm+IPNb2sRo265679R9nkmQC0BGV/km8?=
 =?us-ascii?Q?+/KsMutn5kdSpVWh8doW1cEKo3edl24xgl9M8nr/JzyMeF78v9KvrYD0BwBS?=
 =?us-ascii?Q?tW0gRE9o+7159I5HEAnc04/TaLHRibLLGuXwkDrM0kYUVYAOCm6oseaUl6So?=
 =?us-ascii?Q?/hitGq2UJIYnswhAmaWUb7R0lMabXN6kkZYYeqpeNCKN2Ece7CsJC6gRm4/U?=
 =?us-ascii?Q?auZTZ3rLXbgo5B5o+D7a7qSFOae0UwXFVywuK+LXoul8mlIUea+ypoRHjkVH?=
 =?us-ascii?Q?BNN3rtz+slR1oePtYuJCJb0syyyU5f8y6aklG39q2lKCqXiKbtJ9XzEBEhIA?=
 =?us-ascii?Q?iwn5J6e4rjQpS47XcjfKKUaEmqxBn/IzRxAYCAWoOyqJLB04lppL6wVWVrKN?=
 =?us-ascii?Q?DM4QpCutlXUpx1Z2tJ3BrWP8xsRSVB4gC8+P05E/+e/r0bY9wzuWCqpqmoF/?=
 =?us-ascii?Q?QSFXfuJRB8Mc5KHDaGbqPH/CDTrZprv+ms0e/Id8mZYCrDIsSGdlzud96Aw0?=
 =?us-ascii?Q?zJtHJkbi64tT9t9pxB/5HNKQXd9ruecXQMudtY5fmtohd3HELnsmpQNy1Don?=
 =?us-ascii?Q?U8aON1lLVXuoTaR/Bi2lFzgW583VmgrP2Oby7BlLGg2DBDvulqT3JDCcPNOa?=
 =?us-ascii?Q?qt1kcC9Q5z5JpZhk9E43FpP2ZfhdAgNlcHYLoWAmyFSJV5BDV/Mam6f35uDe?=
 =?us-ascii?Q?62FBjEghW31ByT3Tgk7olQ3NmlNEmETXLaqE+HyD1jyxti+/TDryESzou3Ni?=
 =?us-ascii?Q?fOjixncri/m3mddYSeMaD5kp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR06MB4571.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9fe314-dd9b-49db-1047-08d8e78741b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 07:52:17.9971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5QP+nLK6mT9FsJMn5tWC93F/5QcJn9Hjlpja1BG59fuzWvI6CB02kdrFYPgOjVg+wwILbc551f6o97Lg745FBLiuDYdgb1Nln62C2FDQrF8CC3/bcGPRXuL7MeIgeHEg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0602MB3336
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Sebastian,

Thanks for your input, I will and dump message into next version patch.



Best Regards

**********************************************
Li Qingwu (Terry)
Senior Embedded Software Engineer=20
Leica Geosystems(Shanghai)Co.,Limited
(Tel): +86 21 61061036
(FAX): +86 21 61061008
(Mobile): +86 187 0185 9600
E-mail: Qing-wu.Li@leica-geosystems.com.cn
Http: www.leica-geosystems.com.cn
**********************************************

-----Original Message-----
From: Sebastian Reichel <sre@kernel.org>=20
Sent: Monday, March 15, 2021 7:42 AM
To: LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
Cc: robh+dt@kernel.org; pali@kernel.org; krzk@kernel.org; afd@ti.com; linux=
-pm@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.o=
rg; TERTYCHNYI Grygorii <grygorii.tertychnyi@leica-geosystems.com>; ZHIZHIK=
IN Andrey <andrey.zhizhikin@leica-geosystems.com>
Subject: Re: [PATCH V5 0/2] power: bq27xxx: add bq78z100

Hi,

On Fri, Mar 05, 2021 at 06:49:47AM +0000, LI Qingwu wrote:
> Changes in V5:
>=20
> 1. Change [BQ27XXX_REG_TTES] from INVALID_REG_ADDR to 0x1c, the=20
> StandbyTimeToEmpty command of bq78z100.
> 2. Add [BQ27XXX_REG_RC] =3D 0x10. the RemainingCapacity command of=20
> bq78z100.
> 3. Set [BQ27XXX_REG_AE] to INVALID_REG_ADDR, support by bq78z100.
> 4. Delete property POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG, not support by=20
> bq78z100

I also asked to check other exposed properties and to provide a dump of the=
 power-supply uevent in commit message or cover letter to verify chip works=
 as expected. I cannot see the dump and you are exposing at least one prope=
rty that always reports -ENODATA. I intentionally will not point out the ex=
act property, so that you have to properly test your patch before submittin=
g.

Thanks,

-- Sebastian

> LI Qingwu (2):
>   dt-bindings: power: bq27xxx: add bq78z100
>   power: supply: bq27xxx: Add support for BQ78Z100
>=20
>  .../bindings/power/supply/bq27xxx.yaml        |  1 +
>  drivers/power/supply/bq27xxx_battery.c        | 44 +++++++++++++++++++
>  drivers/power/supply/bq27xxx_battery_i2c.c    |  2 +
>  include/linux/power/bq27xxx_battery.h         |  1 +
>  4 files changed, 48 insertions(+)
>=20
> --
> 2.17.1
>=20
