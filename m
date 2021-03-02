Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D155D32B31B
	for <lists+linux-pm@lfdr.de>; Wed,  3 Mar 2021 04:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbhCCDnP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 22:43:15 -0500
Received: from mail-vi1eur05on2112.outbound.protection.outlook.com ([40.107.21.112]:46880
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1838140AbhCBKIl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Mar 2021 05:08:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcRugx2dk5ANMn6jDY9fCAkHtwIc31/Uwnu2coVe0Jxpz3TRoVfURkKodfbmnDboUJcfdagUNTjOW3LqfHVlpgY27mA2oqkkKSIn3osQrhBqOyFBd7rPP27kW/GHNvEyBqYPmvRc2I806XytNJU0RiARIgT8McjDZff1itmNFJ1vFFVnG2rureUPtpPSSvJyASfTdlsewPzvLhOLan5Ol02aDxEK5Wgg+RcCeOeKMogjdw5xGBAdYonWTAFZQpH4x69P2dALaCiE74QqeT4koPTV+T7LI6i0Ntr2q/+nFNLoI1Qbl1CqzxPZK4otLSOVB6A0JWLJCEKFgwEUg1Qc2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlSQ+6U263tKjIdVJ9vESDlQYmeWwVj/8tW4N04p5fA=;
 b=LshypGp5Hs98RvspThjNg8UxMMgAfyc+8o9JXnopQ4h6lHZb3GQ41DSka/DEwaE6ZV9ystiqAUY8szy6sXizQHIDaG5x2m4Z4/gU+S30vss543JBCFXXf9Ol1p/1E6XDHEnxpKCLuN9h4D3e52LNRJklKhv9zu9fm+38eZhXrCbsPFGVFnGs2Leh41slOydP1oybU0tf/94RaU8B6UHUWNQXJMd6ca64sp0iLMdMAL68MfssEeGjJ2wVRDFjVJ7PHviUa9a/cx110LeEsebReecHF6qtrWgcd5P7HtlB4doThfp9bvQwo6D2TarsF6k+/qBJT5jceaHExnGCmxi4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass action=none
 header.from=leica-geosystems.com.cn; dkim=pass
 header.d=leica-geosystems.com.cn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlSQ+6U263tKjIdVJ9vESDlQYmeWwVj/8tW4N04p5fA=;
 b=H+J4uXvWd4/UpaJDOsP+Qyr1e08Ay2M/p8GdtqhGYmo51IVWP6qDUbNWMQ1GMOAoqHrOzbapkHUroNKVXXY0VJIDBI9kQhQgeuU5MQHuw2YERFST4xwJSXZmt8zjh5qo4bLRzEGtkuq9/KPvuZdPQOQUyT4Mi08NzEYwlOQaI7w=
Received: from DB7PR06MB4571.eurprd06.prod.outlook.com (2603:10a6:10:70::20)
 by DB9PR06MB7722.eurprd06.prod.outlook.com (2603:10a6:10:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.36; Tue, 2 Mar
 2021 10:07:44 +0000
Received: from DB7PR06MB4571.eurprd06.prod.outlook.com
 ([fe80::dcab:24bb:617a:30ee]) by DB7PR06MB4571.eurprd06.prod.outlook.com
 ([fe80::dcab:24bb:617a:30ee%3]) with mapi id 15.20.3890.023; Tue, 2 Mar 2021
 10:07:44 +0000
From:   LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
To:     LI Qingwu <qing-wu.li@leica-geosystems.com.cn>,
        "sre@kernel.org" <sre@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "pali@kernel.org" <pali@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     TERTYCHNYI Grygorii <grygorii.tertychnyi@leica-geosystems.com>,
        ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>
Subject: RE: [PATCH V4 2/2] power: supply: bq27xxx: Add support for BQ78Z100
Thread-Topic: [PATCH V4 2/2] power: supply: bq27xxx: Add support for BQ78Z100
Thread-Index: AQHW+43zF4rTN+6HvEyXTT7OkSUGsKpwoHFQ
Date:   Tue, 2 Mar 2021 10:07:44 +0000
Message-ID: <DB7PR06MB4571F60314A7B11154E5B5F2D7999@DB7PR06MB4571.eurprd06.prod.outlook.com>
References: <20210205071004.26317-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20210205071004.26317-3-Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20210205071004.26317-3-Qing-wu.Li@leica-geosystems.com.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: leica-geosystems.com.cn; dkim=none (message not
 signed) header.d=none;leica-geosystems.com.cn; dmarc=none action=none
 header.from=leica-geosystems.com.cn;
x-originating-ip: [140.207.15.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 22e74009-9e03-4da1-b6d5-08d8dd6305fd
x-ms-traffictypediagnostic: DB9PR06MB7722:
x-ms-exchange-minimumurldomainage: leica-geosystems.com.cn#7686
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB9PR06MB77228FBF425F71DD8E579B5AD7999@DB9PR06MB7722.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nmlhutXr2r+JW0eT53CYhmMCPjiQfMS5LQcycWPongs4weGXvuQ9hen8tcmQ4h4TGWSgpb2n0ZKqlbBjjF6qe7kDnJca8SMB8I+843aa5tMMiQ6avnM+LSqZm6sxTRPytTl5kMjXMzSHKMotnsx6iLoBeT4SHf9zAi6nhqZ1DJqTv24anSHCcSFb/oyP4sYSmibuMnHHrFZ4E+YaoPT8MWKlfnQL7NA5Nix4Z7CWdb1lBG58x3kJqLMwXsmW6IG9Z4NTwTVmCenEdAPqHGwCy1Jk9asb65CAfXiyvyxftJ5QmnyqpZ8/edstkie25QM3qOGNL62umH5Z30pt3c+ZHGf6yZaamndY+5K5IrBR6yleMF6/5dUIUsSEjKhBBnqUnkmHY3JO3yKZz6wRPiPfuldw7CisyMF0fJEAPoZy6f5/94dYvaV3wiNLOfjapfmBv51gleRdWNgczP28DlSfTE615UuLUEUSZyVPoKQrDVzJP83eTw7NwxDmirmAz2eDxJNn/rUIIJCc7b8Rk0CMAirzJrAAtAFAqFIsViRL22Cau+ETAm8azoTapL4VPFJbonSQdQt3SP72C6l3j5N4PjyzVsu3Zpg3UkbRX3SDAqQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR06MB4571.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(5660300002)(52536014)(966005)(83380400001)(7696005)(76116006)(66946007)(107886003)(66556008)(4326008)(66446008)(45080400002)(66476007)(64756008)(15974865002)(478600001)(316002)(71200400001)(110136005)(54906003)(33656002)(8676002)(2906002)(86362001)(8936002)(53546011)(26005)(55016002)(9686003)(186003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mSmTjHXtYrEtUD/caDyfVSbWU9vfHS9KLuYcfLScINUpodB+ci/6TKm/zXDk?=
 =?us-ascii?Q?KJBuowhBSuYOKFjGW4NQtBSK4l/Nq7E93lCXsC1JZsi3XyO/PoDjRq7fHzQa?=
 =?us-ascii?Q?g1iNsSCh+suC9kYrADmVX4z9e1yedTkHskpQ1ciWmYBNnfXw92rNnWq6XoTS?=
 =?us-ascii?Q?1wZ+NeKPKmq2j0HBllm1YSDytoAUAU3tHrHSjRJ9ngkuhdknyh1DEIjkV2pM?=
 =?us-ascii?Q?dQF5hacI0rzZfo3KCppoNMfdKOFWsNndzC5gziuD7e4DgEZLIX9i0fUiNbwv?=
 =?us-ascii?Q?kgn64XiPJD/GBxCS/3ATzdeyKiW3mzRoiUQyjgkLvBuYHJNzgLCxlf75G4aH?=
 =?us-ascii?Q?jaQj/C4XxxsHD4TxQrsjSbm6zPv4QbBD2ATb3B95VdcZfdHetSw0db1EEl9x?=
 =?us-ascii?Q?70KwJicYqygYm2yfG1qE4O/fRvitatUQFCeJeL0r9wBXj5F8zZkBy1tprwMs?=
 =?us-ascii?Q?L6g1oN14STa820DOjuGkR1HkD+xGGjtrXgCHPDzXNlKCdP1UFdgZmrsBDw8w?=
 =?us-ascii?Q?wuWsrDHp9veC6+6qu1drjrc3m0Y+I9fI/ixNnMP6qT8+hecnr5sgB9bID59t?=
 =?us-ascii?Q?G27+in2uZ4ReSKfVqYIdENBHQqxeX+EZtpIc2+kox/ECGgO5HZmMPD6HENZW?=
 =?us-ascii?Q?JGmJ7hZXiztjKoguKRAvGT/joJFER3pxZ33vwRcDB2M2qLMjs/ZYUT8mdgCD?=
 =?us-ascii?Q?Kspvky8NJb2DO73IxAK2i7H4ooqj5Fhu4DIP3eFnFsNOY83tiQqKQBz7UfHv?=
 =?us-ascii?Q?CraEyxePMzwIv7IOlJ4lCbpWx7Hi8KCn2LrHBw617MuI+mRgDbUZCw2UGRLi?=
 =?us-ascii?Q?ROCEa6YJ0uwyF877fEIPtXarm3iMqJk4LdisQrVjJIu3RNGjXh6VXdRTQ6ua?=
 =?us-ascii?Q?vTH19UNnA2NUf+zDAHqPQffBR9hVQ077SwGM/U3qJu0Vwx6d3g+7pmfDeCmM?=
 =?us-ascii?Q?ueW93M/859rd6F1rRu91O9/jBsGAWxHuovYSmTKxO3r25+OuEg76iYIae1ny?=
 =?us-ascii?Q?TYMvJu3vx690X5DYwypULofOp6g4LbwR4ocMJW9Xj89mq0rcE/m0Oxc+ar01?=
 =?us-ascii?Q?3NDcMHuwBP8wEZALwRT3/1j2CRhQGDb8seuWorBse+ZGDr8k4+/h3CsNrue0?=
 =?us-ascii?Q?dafqCPKTqangAXMM6+/H8p8njj4S0kKYCBvnPlERpMIAMPlpDF5mOf3NPm7o?=
 =?us-ascii?Q?TprMBbtITIu0rT4keRmcDKIMZs10hpHc2BsiXDG+Jdes77IbVGPrpFSCJEkM?=
 =?us-ascii?Q?vThhK70Y4+Nm0TgRDCczUU/se9b5t3uQZVg5cM9XBgwYvalmAtBXBfXtXtjY?=
 =?us-ascii?Q?xoY1Rzs0FDm4a6GfgUarv/VV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR06MB4571.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e74009-9e03-4da1-b6d5-08d8dd6305fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 10:07:44.3690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pwEtm/p9YRn8+UMOvaIcFdYHa3/LDSMYibx9eLLyn6YLFMZzCfFSv6W5taOk8e3ZCKT4tkd71Fj05rrnN91DHXrdM4rg0DGrqqIL7yoF7aSGdQpWqz1xFWfICOxJhBah
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7722
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

this is a friendly reminder.




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
From: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>=20
Sent: Friday, February 5, 2021 3:10 PM
To: sre@kernel.org; robh+dt@kernel.org; dmurphy@ti.com; pali@kernel.org; kr=
zk@kernel.org; linux-pm@vger.kernel.org; devicetree@vger.kernel.org; linux-=
kernel@vger.kernel.org
Cc: TERTYCHNYI Grygorii <grygorii.tertychnyi@leica-geosystems.com>; ZHIZHIK=
IN Andrey <andrey.zhizhikin@leica-geosystems.com>; LI Qingwu <qing-wu.li@le=
ica-geosystems.com.cn>
Subject: [PATCH V4 2/2] power: supply: bq27xxx: Add support for BQ78Z100

Add support for TI BQ78Z100, I2C interface gas gauge.
It provides a fully integrated safety protection and authentication for 1 t=
o 2-series cell Li-Ion and Li-Polymer battery packs.

The patch was tested with BQ78Z100 equipment.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/power/supply/bq27xxx_battery.c     | 46 +++++++++++++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c |  2 +
 include/linux/power/bq27xxx_battery.h      |  1 +
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/=
bq27xxx_battery.c
index 315e0909e6a4..c8579ec7a4f8 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -39,6 +39,7 @@
  * https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww=
.ti.com%2Fproduct%2Fbq27z561&amp;data=3D04%7C01%7C%7C9f9bd80e6c4c48b21f0208=
d8c9a5158b%7C1b16ab3eb8f64fe39f3e2db7fe549f6a%7C0%7C0%7C637481058152484173%=
7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw=
iLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dm28d%2BWIxG3uVVBiA1GIYbahvhxe%2BqFFXHC9x=
Fum17wc%3D&amp;reserved=3D0
  * https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww=
.ti.com%2Fproduct%2Fbq28z610&amp;data=3D04%7C01%7C%7C9f9bd80e6c4c48b21f0208=
d8c9a5158b%7C1b16ab3eb8f64fe39f3e2db7fe549f6a%7C0%7C0%7C637481058152484173%=
7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw=
iLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D5f7FlqKszetEP3Uq2rZFIvHAbSsVV%2FUAWS7gOK=
tdzts%3D&amp;reserved=3D0
  * https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww=
.ti.com%2Fproduct%2Fbq34z100-g1&amp;data=3D04%7C01%7C%7C9f9bd80e6c4c48b21f0=
208d8c9a5158b%7C1b16ab3eb8f64fe39f3e2db7fe549f6a%7C0%7C0%7C6374810581524841=
73%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h=
aWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DIK%2Bfiq2ga7dciCQHO5%2FBqKRgRZDgNoM0N=
eVpjmT9YtY%3D&amp;reserved=3D0
+ *=20
+ https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.
+ ti.com%2Fproduct%2Fbq78z100&amp;data=3D04%7C01%7C%7C9f9bd80e6c4c48b21f02
+ 08d8c9a5158b%7C1b16ab3eb8f64fe39f3e2db7fe549f6a%7C0%7C0%7C637481058152
+ 484173%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ
+ BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DewaB4hkn%2Bx7EJPXIA5Uux0P
+ MolDcgFqTHYKCslVYDFs%3D&amp;reserved=3D0
  */
=20
 #include <linux/device.h>
@@ -497,7 +498,27 @@ static u8
 		[BQ27XXX_REG_DCAP] =3D 0x3c,
 		[BQ27XXX_REG_AP] =3D 0x22,
 		BQ27XXX_DM_REG_ROWS,
-	};
+	},
+	bq78z100_regs[BQ27XXX_REG_MAX] =3D {
+		[BQ27XXX_REG_CTRL] =3D 0x00,
+		[BQ27XXX_REG_TEMP] =3D 0x06,
+		[BQ27XXX_REG_INT_TEMP] =3D 0x28,
+		[BQ27XXX_REG_VOLT] =3D 0x08,
+		[BQ27XXX_REG_AI] =3D 0x14,
+		[BQ27XXX_REG_FLAGS] =3D 0x0a,
+		[BQ27XXX_REG_TTE] =3D 0x16,
+		[BQ27XXX_REG_TTF] =3D 0x18,
+		[BQ27XXX_REG_TTES] =3D INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
+		[BQ27XXX_REG_NAC] =3D INVALID_REG_ADDR,
+		[BQ27XXX_REG_FCC] =3D 0x12,
+		[BQ27XXX_REG_CYCT] =3D 0x2a,
+		[BQ27XXX_REG_AE] =3D 0x22,
+		[BQ27XXX_REG_SOC] =3D 0x2c,
+		[BQ27XXX_REG_DCAP] =3D 0x3c,
+		[BQ27XXX_REG_AP] =3D 0x22,
+		BQ27XXX_DM_REG_ROWS,
+};
=20
 static enum power_supply_property bq27000_props[] =3D {
 	POWER_SUPPLY_PROP_STATUS,
@@ -792,6 +813,27 @@ static enum power_supply_property bq34z100_props[] =3D=
 {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
=20
+static enum power_supply_property bq78z100_props[] =3D {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
+	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
+	POWER_SUPPLY_PROP_ENERGY_NOW,
+	POWER_SUPPLY_PROP_POWER_AVG,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
 struct bq27xxx_dm_reg {
 	u8 subclass_id;
 	u8 offset;
@@ -890,6 +932,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] =3D {  #=
define bq27z561_dm_regs 0  #define bq28z610_dm_regs 0  #define bq34z100_dm_=
regs 0
+#define bq78z100_dm_regs 0
=20
 #define BQ27XXX_O_ZERO		BIT(0)
 #define BQ27XXX_O_OTDC		BIT(1) /* has OTC/OTD overtemperature flags */
@@ -948,6 +991,7 @@ static struct {
 	[BQ28Z610]  =3D BQ27XXX_DATA(bq28z610,  0         , BQ27Z561_O_BITS),
 	[BQ34Z100]  =3D BQ27XXX_DATA(bq34z100,  0         , BQ27XXX_O_OTDC | BQ27=
XXX_O_SOC_SI | \
 							  BQ27XXX_O_HAS_CI | BQ27XXX_O_MUL_CHEM),
+	[BQ78Z100]  =3D BQ27XXX_DATA(bq78z100,  0x00000000, BQ27Z561_O_BITS),
 };
=20
 static DEFINE_MUTEX(bq27xxx_list_lock); diff --git a/drivers/power/supply/=
bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index eb4f4284982f..46f078350fd3 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -248,6 +248,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[=
] =3D {
 	{ "bq27z561", BQ27Z561 },
 	{ "bq28z610", BQ28Z610 },
 	{ "bq34z100", BQ34Z100 },
+	{ "bq78z100", BQ78Z100 },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table); @@ -284,6 +285,7 @@ static=
 const struct of_device_id bq27xxx_battery_i2c_of_match_table[] =3D {
 	{ .compatible =3D "ti,bq27z561" },
 	{ .compatible =3D "ti,bq28z610" },
 	{ .compatible =3D "ti,bq34z100" },
+	{ .compatible =3D "ti,bq78z100" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, bq27xxx_battery_i2c_of_match_table);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq=
27xxx_battery.h
index 111a40d0d3d5..ac17618043b1 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -33,6 +33,7 @@ enum bq27xxx_chip {
 	BQ27Z561,
 	BQ28Z610,
 	BQ34Z100,
+	BQ78Z100,
 };
=20
 struct bq27xxx_device_info;
--
2.17.1

