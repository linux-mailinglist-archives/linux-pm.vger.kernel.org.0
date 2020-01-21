Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 698DD143A54
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 11:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgAUKDw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 05:03:52 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:14578 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729609AbgAUKDv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 05:03:51 -0500
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
IronPort-SDR: jiRiUdriH6fooGUBe7iwl9WoBzf4bwWUEldyEi3ggEBjOQ+6ev9cGg3bD75OjmO7RIDUDCidr9
 06SGTgNA6tOhpLqkLnHxZ/HbBq4tTgHbl8nc/G62BwDYb+/VN/ZL1mGbk2pQ6vw3zRkRozbYRf
 k1KotOvjcPaRJ6rT6oNsFGxa5iBIU/QW7nzBfgKlA9E71scW6lejHeEKWu2UpUPVoRPvu4hw2Z
 1BUBLUuBaFvvzGORjyRQ4bq5+653dW/pbE8qV5wzSgK4Hpkz2+4Q2yuGfla583ALoXl48i0FQK
 V6Y=
X-IronPort-AV: E=Sophos;i="5.70,345,1574146800"; 
   d="scan'208";a="61482013"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2020 03:03:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Jan 2020 03:03:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 21 Jan 2020 03:03:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egD5L33uChgUe9f2/fGWwAFJ+K+Wc1eT2q5z8clrlPc9o5nkyb3d03JjTiOYm0NoRhtuYQAg7JJVpZk3F4IJrcPDk2DRA9JYLJPDYKkjkbXiMXUWL0vFTxmeQJ1T+mH4Zz28GXzhVAy4NRzeBG91lQDPkxT6OShqEMy07shkoTKMDHYIHRriPTOAnOQ6GUVmcmw+8hHsJtCCav8TWIm90amwP3RgFSsTOBpCnNGCQ6j+FGAqzIliJPkDRxO8uBkMNFY9XyIgcZ4PkGet0FAWrWgLY6Oo66WnBMuz42NgyXPpSu46yNBEpvcJ2MKdMMtaERT+8cACcKUWffxA0VfV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTDz3/gEuQTOjIc8iOtlt7s25+PU0XWggdpv+NKrLBU=;
 b=j2nEUtxb1F+QpKiavi74JAQzLYz13VhJZKvvz/b2eY/Eua8ji6AxeqR6h6aa9YUwizlQmEzLQ1mM1cQy+QXWI4SLmPqSIstVfQ6GmlLIfgKjffNf8cA8pnnAfuFwfxI+aUGvblAcHqk0TrTNCPwkJt6NsilCEGWADZu3hlI0BGu9K2CmmHxtSj9IFQH3EP/HEPn5+7ckfiYlSobwF3CWmShtQYka5jCbwNa4uM2ep97Re/k6ILX8JzK/qAbIVCmRRDNPJpqdA2NaCC3xWvErlVbdkEucj/47QbPOU8KONNYRn9OwETb7uav6moS7+VzxkuKA/KrrD8HjnPwAE+HwCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTDz3/gEuQTOjIc8iOtlt7s25+PU0XWggdpv+NKrLBU=;
 b=i8BXzg69OE70+mPTg2DaIbIYbeK/39KRTIuKTat6kBgX6j/bWqEnd1vuYWsyqxtIMHA34zEIs3jRPtq+/ye0w5t62oy8KRC4+oeN/je5Qj35Gf2+mNQ+/+Me0oz1WZBJibowu2tRIBLdgOchHlNrIS5iKk6/N5GpY1JyQdRL0Uc=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB3195.namprd11.prod.outlook.com (20.176.121.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 10:03:39 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a%7]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 10:03:39 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sre@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 15/15] power: reset: at91-reset: handle nrst async for sam9x60
Thread-Topic: [PATCH 15/15] power: reset: at91-reset: handle nrst async for
 sam9x60
Thread-Index: AQHV0EINUPsFdrOD60ihk98/gadShw==
Date:   Tue, 21 Jan 2020 10:03:39 +0000
Message-ID: <1579601001-5711-16-git-send-email-claudiu.beznea@microchip.com>
References: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbcdb102-e729-47ce-17bc-08d79e59306f
x-ms-traffictypediagnostic: DM6PR11MB3195:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3195625509C5A1C2C5895160870D0@DM6PR11MB3195.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(199004)(189003)(107886003)(26005)(186003)(36756003)(5660300002)(110136005)(54906003)(4326008)(66556008)(66476007)(6506007)(2906002)(76116006)(91956017)(6486002)(86362001)(64756008)(6512007)(66946007)(66446008)(8676002)(81156014)(2616005)(81166006)(8936002)(6636002)(71200400001)(316002)(478600001)(138113003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3195;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vJ0QTMB2AAPZlb99tjCmIk+MkE9KZIfbWvu/+kq/c+RR/5SCrW2YEKEAvJl6ByI4P676SPXwHZW/+lCa2oiw4nQILxKkO/wYC4b2wHOx1oHNosJguSbRIX0i5kccPTj/gonGzEKrQ6QWRJ72iK04VpySkYQTu8BJ1uor/YZlyiGL3uHHqbarZZ0ItitFMU0HzwOe+xd0rJzwFidIPMEmFqsN9/SSntvCSa+44nXJCCqtrSEX8x55ov5uHzn3lwlnh+BfCUsQXzL7zEJU+57TqAsixUl9KgSr+I/V/3DmwMgV+1qayY0II4hVFNGpNii2IveKZ5lKChFu+mNhWWfir9c//kFHcnVatZY3X7ujV7mEP8qmVv5/HbV9vXatx3LI8i7DPUxl7oAamuU6zLL/KnE8Ua4bisaLd92US62n8zKCdvU5kJ9t7KpRcSmbYcd9ydr8dRAaNTSqRPZf4nG/LjCd3Sh3vreXoWfANRkPyS5slmG4YhwNBDV+xbyJ1B/o
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcdb102-e729-47ce-17bc-08d79e59306f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 10:03:39.5540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /MVJzzMJjKdLdxT96bEgdMeS5DsAyDRqsD4f3IErNarbqClc3F6Yd5dwTt9Y9LCwli05nJS8NuqbnvflWBtSfttWsF7CFTfZEl+ERziwo24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3195
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Handle NRST asynchronously for SAM9X60 to avoid problem with fast drop of
VDDCORE on shutdown operations in the first 100 us after CPU is shutdown.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-re=
set.c
index 537ccb180568..3ff9d93a5226 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -35,6 +35,7 @@
=20
 #define AT91_RSTC_MR	0x08		/* Reset Controller Mode Register */
 #define AT91_RSTC_URSTEN	BIT(0)		/* User Reset Enable */
+#define AT91_RSTC_URSTASYNC	BIT(2)		/* User Reset Asynchronous Control */
 #define AT91_RSTC_URSTIEN	BIT(4)		/* User Reset Interrupt Enable */
 #define AT91_RSTC_ERSTL		GENMASK(11, 8)	/* External Reset Length */
=20
@@ -228,6 +229,13 @@ static int __init at91_reset_probe(struct platform_dev=
ice *pdev)
=20
 	platform_set_drvdata(pdev, reset);
=20
+	if (of_device_is_compatible(pdev->dev.of_node, "microchip,sam9x60-rstc"))=
 {
+		u32 val =3D readl(reset->rstc_base + AT91_RSTC_MR);
+
+		writel(AT91_RSTC_KEY | AT91_RSTC_URSTASYNC | val,
+		       reset->rstc_base + AT91_RSTC_MR);
+	}
+
 	ret =3D register_restart_handler(&reset->nb);
 	if (ret) {
 		clk_disable_unprepare(reset->sclk);
--=20
2.7.4
