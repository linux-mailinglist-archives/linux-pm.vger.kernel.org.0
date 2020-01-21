Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24DC3143A59
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 11:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgAUKEI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 05:04:08 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:14575 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbgAUKDn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 05:03:43 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: ChmRYHNZ1a8HB/vquRZsN5NbRmpUkCTXaxReL6z8ozkHOEe8Nt78Vzv4OwC1FuzOIdFMDyco+2
 nkyjolzYf5ccvJAKdyHvWgmqXn1dBAQ+GBB8Grnodw4jcZtVLp6PtrHZe+oB0SyZXVSzJySTAq
 qSLx/BM/PBR+fXELuLnjQusw0Qw8tcbUdXpuAvs8N3p9SWVoiHQADN40c4N0aS5gYn+fQZf6GU
 fh1JoTdlq4G4StPy+yKTZH3X7yJUX/PUn5WBbJZIS2GCt1j6l2hx94/3BKNGiaDoNoqt/gAp7a
 vZk=
X-IronPort-AV: E=Sophos;i="5.70,345,1574146800"; 
   d="scan'208";a="61481962"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2020 03:03:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Jan 2020 03:03:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 21 Jan 2020 03:03:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4l6sAMi+zgUt36UNEgi11N2NfyHmr/bxqktPFHK963bvLAfdxr022cD1vpcMqVHRMd24B5F0iTYQGUKWIP7RwBm+1P0hBImYRyACGbzuym+oLBQc4HDROQWmJEAjR40PgQB0DABxWxpc7PTrDWedPYW7YsYL+CDs7UCplhue8Kfr/QEHpYvrXlz+iaSAfsVqXHRooSN6VEkOEMhnavfuEyKPqbv+8Hqi7rS0eLY03yhYIQfYy6kFTD1r5H7trkCqTyUPJ/9YNge4h7MN1lXIvcCDC/dACr2RZKrxc/NAYWAyePQphnkfgyljSm4KgpZ1zRZsVSt4++GevGrXIsLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X50fqRC8vzRm0UoalcRLP7y4LxFJa34i+FZXVLmURY=;
 b=aHebUNJ85H41/XoSxuoLwy2uH9lCupVP56PSjVeFI1wtxR5x0Eb9BvJl9o8wn9G8hG5BrZd2cjBp6eRgz1C1iKwIOg5E0t+pZcTj4XJ5kzmf5ikM7+cf2AgxYohfZCF2Lk16flHSnOxe0K1Ik6RBN2MsHEsZBnbvB80FH2hu8UrH3fb9HpMi6AqpBlDs8lRpHM6UTVZr7eGf4+zSntXK5MuKmYN0cd9S5Y9n2WLqICCrMPdKWr7aRGGKLbMoiPTUX2/O+45ZnmY/NGXDjMnSubzQvCuLH2gWh7XsE5jfbQcEK/v1yFapKkVfaaduI/VkW5tBJUa3J8kF0HLEhSmmDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X50fqRC8vzRm0UoalcRLP7y4LxFJa34i+FZXVLmURY=;
 b=n26XtQ28hEOMOFNuvNeAn8gWoA946qncYcyGTjwnAZzjzJhJ+YsBoAlVTGMsbbxHw5EROiNvJN/NT34McJqoPvXFFTzdduCFZqYDqEYOXqCzSD/y0wUxK1rOc0yN/hkHFleydJ8lYTlpasDlxcLcP56XnuCXGEdfZ+9tnPJ2+xI=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB3195.namprd11.prod.outlook.com (20.176.121.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 10:03:30 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a%7]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 10:03:30 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sre@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 03/15] power: reset: at91-reset: add sclk to struct at91_reset
Thread-Topic: [PATCH 03/15] power: reset: at91-reset: add sclk to struct
 at91_reset
Thread-Index: AQHV0EIIYocZzik2O02q6OLYBPiBsQ==
Date:   Tue, 21 Jan 2020 10:03:30 +0000
Message-ID: <1579601001-5711-4-git-send-email-claudiu.beznea@microchip.com>
References: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86485129-78fa-4ddc-99c1-08d79e592b09
x-ms-traffictypediagnostic: DM6PR11MB3195:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB319525AC4A099CD20D58E48C870D0@DM6PR11MB3195.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(199004)(189003)(107886003)(26005)(186003)(36756003)(5660300002)(110136005)(54906003)(4326008)(66556008)(66476007)(6506007)(2906002)(76116006)(91956017)(6486002)(86362001)(64756008)(6512007)(66946007)(66446008)(8676002)(81156014)(2616005)(81166006)(8936002)(6636002)(71200400001)(316002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3195;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MIhDO18h+VS4ejEBDbzZnG7jJD+vLA0ueXtZjAZRujJwVq6Dk+KqC8ixpr+MCWOZTfeqAeuyX6XDrVdI6V+viaFOJDhyQeVyeS66hS//HPvAA0L/4rzvHCQUDW/bBfeFHk+lmWs6pbqUWbR2FpjwBCPYWVTYPqh7GBZV2FxoW2AgsJosT4/MPhquoxs7pS9s1GehImfC5EZJmKgkgwPcDKQl/rQxUJ9AsWm0nhbxH1Pc956h7yW3dAtE49OTW66uwbxRmBA3hTOTkpC7tynYJzUdI0CP8P7mEWlqbUtcdpaT0c+ubM2JAPGNMbjOQQPAMR02Eg8q+5pvpMs5C/mogorNPnvcJaBZMDf0AzAJw9qx5kgvriRuskbv9MjS4hc93rtFwkNXL0+c3ITQZ8HxRdCtfbtpxtnmZ/cxfHHQZbDNO0ns0tLBIdnD1LMviPPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 86485129-78fa-4ddc-99c1-08d79e592b09
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 10:03:30.7202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t0rqAsV8B4Knsb4lQawZOvHO33FfwSoR0m9qkIo1Qw7rcMBat/P0euNDjl5nqNp2bNXjUSmUSPgstOwh1nMpLAd57GomPo4X7zZWamilkTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3195
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add sclk to struct at91_reset.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-re=
set.c
index 999d3a1653d2..1bc39bfda0aa 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -52,12 +52,11 @@ enum reset_type {
 struct at91_reset {
 	void __iomem *rstc_base;
 	void __iomem *ramc_base[2];
+	struct clk *sclk;
 };
=20
 static struct at91_reset reset;
=20
-static struct clk *sclk;
-
 /*
 * unless the SDRAM is cleanly shutdown before we hit the
 * reset register it can be left driving the data bus and
@@ -238,11 +237,11 @@ static int __init at91_reset_probe(struct platform_de=
vice *pdev)
 	match =3D of_match_node(at91_reset_of_match, pdev->dev.of_node);
 	at91_restart_nb.notifier_call =3D match->data;
=20
-	sclk =3D devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(sclk))
-		return PTR_ERR(sclk);
+	reset.sclk =3D devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(reset.sclk))
+		return PTR_ERR(reset.sclk);
=20
-	ret =3D clk_prepare_enable(sclk);
+	ret =3D clk_prepare_enable(reset.sclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not enable slow clock\n");
 		return ret;
@@ -250,7 +249,7 @@ static int __init at91_reset_probe(struct platform_devi=
ce *pdev)
=20
 	ret =3D register_restart_handler(&at91_restart_nb);
 	if (ret) {
-		clk_disable_unprepare(sclk);
+		clk_disable_unprepare(reset.sclk);
 		return ret;
 	}
=20
@@ -262,7 +261,7 @@ static int __init at91_reset_probe(struct platform_devi=
ce *pdev)
 static int __exit at91_reset_remove(struct platform_device *pdev)
 {
 	unregister_restart_handler(&at91_restart_nb);
-	clk_disable_unprepare(sclk);
+	clk_disable_unprepare(reset.sclk);
=20
 	return 0;
 }
--=20
2.7.4
