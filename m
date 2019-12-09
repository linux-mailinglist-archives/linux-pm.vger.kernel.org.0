Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D800F1174F2
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 19:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfLISzy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 13:55:54 -0500
Received: from mail-dm6nam11on2139.outbound.protection.outlook.com ([40.107.223.139]:57152
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbfLISzy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Dec 2019 13:55:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jp0MXB7JcWiIdKuaBpA8uubD8AUciI7rOqHGXVtaLfYb5pl+OYPFKNir1PsUkrHL2GSlFA2O4CFzYsElareMJJSSnmbyGbEGbbEBI5vbfrfOiOfqj0rGeYct1lvUMIEP8Klov7Hqvv7aaVkMc6ETOLpsBxxU9tveAzAh3gh97dZMJuajDAuxIRebOBUg5YjnEI+OZCO3g9UElOwY6hMUwPliVsVmz0O0vNy5r3WFqIr1ReBSQ9UcXKcIbUBxMKxS1nXPCVJcsOp1Iyv/GvGE3efI/jZRcZPitgekHUcJPgnXJ4ZDonXU2IWrdSOt54eE9wd9ABy9NyDrMu+OMJih6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxDNNClZfQCL0R47wiZ/1Fv9Gg6U5Ak35uIKya487cM=;
 b=avh9Lma8b2N361nj8PF2RIvkEZ+jWNP/ScJ4/U1PfP+zOhwE4gW64hCRBySsedogYFAtUqcoXYsTD8c2OdBPclGPH1rBrB/WJRF8gnxJTLh3qShxb+Z3raYFs2H2N4bnPZ+7C+AFpHtw3DTYFmPCnQXUT3ZntD9WWGp2Q6U3eU5mKRZR0k5V6KIEoSw0suUNiUY4uJk6vzIY1Hfx5+D1kiNXthjbhtF2dS5bt9fmw97d8FUBRmeB3y/xknZLkgxaC9ZhrgyETwxWpdl9YOocvkZsx7pRe6h0h+e8SDXSkYLFzZVpaHpEPeSDUJMvQh8IufuR1y2etO1PtYYS4aSE7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lexmark.com; dmarc=pass action=none header.from=lexmark.com;
 dkim=pass header.d=lexmark.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Lexmark.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxDNNClZfQCL0R47wiZ/1Fv9Gg6U5Ak35uIKya487cM=;
 b=csd9z9S5eYeoJwS/pAjx6SlGahhGOWFffpxMvlJJQxarfSmU2qyKWX+SkHwA8WseRfAj4YPVft3V4XYoxmQNQO51HVlXXEIj75jz4CzoklwRmy3cznR/Dfxs/gH9wkLz4CmqpcNfm2bSWuyapdEcl/jTCzMJ2fyVsUw4ieIz7So=
Received: from BN8PR10MB3379.namprd10.prod.outlook.com (20.179.140.29) by
 BN8PR10MB3603.namprd10.prod.outlook.com (20.179.96.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Mon, 9 Dec 2019 18:55:51 +0000
Received: from BN8PR10MB3379.namprd10.prod.outlook.com
 ([fe80::9d23:4a97:d48a:7f84]) by BN8PR10MB3379.namprd10.prod.outlook.com
 ([fe80::9d23:4a97:d48a:7f84%7]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 18:55:51 +0000
From:   Zak Hays <zak.hays@lexmark.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] thermal: armada: fix register offsets for AXP
Thread-Topic: [PATCH v3 1/2] thermal: armada: fix register offsets for AXP
Thread-Index: AQHVrsGLD999I+sXU02u/nnKx+JFe6eyJbMn
Date:   Mon, 9 Dec 2019 18:55:51 +0000
Message-ID: <BN8PR10MB337990B7688320D736760BB68C580@BN8PR10MB3379.namprd10.prod.outlook.com>
References: <1575917171-11085-1-git-send-email-zhays@lexmark.com>
In-Reply-To: <1575917171-11085-1-git-send-email-zhays@lexmark.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zak.hays@lexmark.com; 
x-originating-ip: [192.146.101.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c26f6332-5a16-45b1-8ac7-08d77cd9696f
x-ms-traffictypediagnostic: BN8PR10MB3603:
x-microsoft-antispam-prvs: <BN8PR10MB36031E66E21C0210EF6E1C858C580@BN8PR10MB3603.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:372;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(189003)(199004)(7696005)(498600001)(54906003)(64756008)(66556008)(66476007)(9686003)(8676002)(2906002)(4326008)(33656002)(109986005)(44832011)(305945005)(81166006)(81156014)(71200400001)(71190400001)(55016002)(76116006)(86362001)(6506007)(52536014)(66946007)(5660300002)(26005)(4744005)(8936002)(66446008)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR10MB3603;H:BN8PR10MB3379.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: lexmark.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HxTtjJhEiV5il5nrE4yEKVKhwfe02le5OYoE7YMPw8LkQZkynORCaZjHeS/ljPz9HzQvSzy5WeJOlQGuVpxhXRtp14pvEVWiHiHJK4IyPi5XxdsNBLDQbm3EvcMxGV4Zbl4TUdkTZ9OOvZ0RZPqs2/DzsRo+Sk/Eh/3p/boQVCE+gIpZ+ZXJWlSg0XrbRcyIi8TGw8ggwvF9vDXLtE88q3rh0LOoU+LAd41wSjlmdcCvdRa4r6QYXVkxs5TDD/POmQpOI27FUhtXaRmVwcPudIi8eONruR9bysDFRhILrdeRwSl1OEAm8UYB+w1nFrP6cKgAlaTlwVeYAo20rD5x5DtGNswI4E6ZpPEo0rxLcqApdBpox4fm3ERGzVijQqjiW14eC/PP/+FlSpUClu9WosfZp2KAevYJ/NpXB5gVtM0OOK2ATRi5U8n/uLN/Uy8H
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Lexmark.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26f6332-5a16-45b1-8ac7-08d77cd9696f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 18:55:51.4149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12709065-6e6c-41c9-9e4d-fb0a436969ce
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 995rhOEEKowYK3vWjoaiDs4scSJfUGgOg3CBbFHVdX0FxovsgrsaIooq2YcImNeAinMVdGEpGg3xlD024+zE5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3603
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As shown in its device tree, Armada XP has the control1 register at=0A=
0x184d0, not 0x182d0.=0A=
=0A=
Signed-off-by: Zachary Hays <zhays@lexmark.com>=0A=
---=0A=
v2: update commit title and add "Signed-off-by"=0A=
v3: resend for clarification=0A=
---=0A=
 drivers/thermal/armada_thermal.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_ther=
mal.c=0A=
index 709a22f455e9..88363812033c 100644=0A=
--- a/drivers/thermal/armada_thermal.c=0A=
+++ b/drivers/thermal/armada_thermal.c=0A=
@@ -578,7 +578,7 @@ static const struct armada_thermal_data armadaxp_data =
=3D {=0A=
        .coef_m =3D 10000000ULL,=0A=
        .coef_div =3D 13825,=0A=
        .syscon_status_off =3D 0xb0,=0A=
-       .syscon_control1_off =3D 0xd0,=0A=
+       .syscon_control1_off =3D 0x2d0,=0A=
 };=0A=
=0A=
 static const struct armada_thermal_data armada370_data =3D {=0A=
--=0A=
2.7.4=0A=
=0A=
