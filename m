Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5B43143A5D
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 11:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgAUKEU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 05:04:20 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:18601 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbgAUKDk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 05:03:40 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Jj9WMdqFKgbTvwH7G69heyaBL5lbExi9NOf5zAStpjdDizh97/q3WrDywq6utgxn+lbkgbyei1
 VWRaSEp07T2in/3u3rAmZge9+mKvWGuJdP4i1c1vcCr6+7kAO925dFxBsxbFfa0W+xO+b0YxaT
 uXB9JUWTYhoh6+rMQg8oIHGvxpEXyLhSsSzR2aQFujDyIlMmqy650m/BUNhUTTzmWlvESOJvfc
 cOJAgkAmqVXbRIwaxqB81W9tzJQ9bzqT3mga22E1qV0ZARXJ0iL1OV93KiR0m5xemMygS5CeEp
 +5Y=
X-IronPort-AV: E=Sophos;i="5.70,345,1574146800"; 
   d="scan'208";a="61695327"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2020 03:03:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Jan 2020 03:03:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 21 Jan 2020 03:03:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cz62TYtwnyWf5blg8fzH2C8IabLtTs6I47GDBMc/hlhYOJDwbt9poWIKVmfCLZNscrIE4KCiYW3OD2pl7YCnyyTgunkXdlXV41oQ7t9LXTcqZGlxjG3A4yZ9B5AS5hqYKPx/Xiy72nDNzN0L980P34YjV7A8Neeorbn79IBqJpit3fY3PwZNbODnlE0B+I4RHrkmpgQTXbcrpnmaS/hl5Z09wqGMoWiZaruemwqvVrfsUJ84diVnVJj2HE+eg3gWOU1MsvMxqdZg2pZQlJkeAIfyFLbIi22HeTaQ3dvbexUnCSrs9JrvNT/QaqPFFThP879GNM8onXKiC5VgePXN4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMcpTnRpNDfhHT2wymsc6dU5234DF4BKqlDWQNyCDeM=;
 b=EcodIfkb27pSqQG781okNHLgeNA4juWK4BFM7hwKf0fWMS9zgxPot+wulVkQvMsj+9l8i9Vm7dkis2Ax0OUvG5ONyyScspcZRNv+keJ3r2N9X4EnO2U+urOrFXdrh3GLliQgZHa5CPYMUUmdKMLPYzvAptw+DLlGw5P3zE4W/rL/G0V2FTkQtZ/qDxViPN9tpf9Pdel4un+ctC9MGo7bYbbnS5JUxcmgDJMLl03uR44qUBRBshFtNCLAjOoXFcbzw0LaOQwbqR7sq+8knnux40BOb93Ya5V9KTRQk+/phfNmwtwwbHCxWhpJgjv/rbOyZPtt0ag8nC7FpEdIylWfIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMcpTnRpNDfhHT2wymsc6dU5234DF4BKqlDWQNyCDeM=;
 b=juTXbXjRb+w7qSJFKvepdNpFZkeWEjPlDAwMAAePsiY6VRkK0g8V0rn4oKCBezqMSTFym+ByO/eJEa/hcESvkZDyylrkXCHQeBKm1CG9a1MKCHlnj1wzkM2afrOosaKTAHI5gPEHI/70sgGuC/0j7WfPYz1gb9Wv3Oc/+XjFSm4=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB3195.namprd11.prod.outlook.com (20.176.121.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 10:03:34 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a%7]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 10:03:34 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sre@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 10/15] power: reset: at91-reset: use r4 as tmp argument
Thread-Topic: [PATCH 10/15] power: reset: at91-reset: use r4 as tmp argument
Thread-Index: AQHV0EIKM+vXaMTl1kiHr7N4AxR9eg==
Date:   Tue, 21 Jan 2020 10:03:33 +0000
Message-ID: <1579601001-5711-11-git-send-email-claudiu.beznea@microchip.com>
References: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6db67617-c740-40b6-9e53-08d79e592d23
x-ms-traffictypediagnostic: DM6PR11MB3195:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3195DDECFF94D1AA2D09E7E3870D0@DM6PR11MB3195.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:561;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(199004)(189003)(107886003)(26005)(4744005)(186003)(36756003)(5660300002)(110136005)(54906003)(4326008)(66556008)(66476007)(6506007)(2906002)(76116006)(91956017)(6486002)(86362001)(64756008)(6512007)(66946007)(66446008)(8676002)(81156014)(2616005)(81166006)(8936002)(6636002)(71200400001)(316002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3195;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k/novEyKnmINP36cBYPt/jOFfTqLwi67rdEs1OFtZyvbvS6oDPn3gqpW5UKyvNuqKeoI8/7oRAzsgJWDhBHpQTYNZdlmxEmx32hG/Hj3VLyfOyZ2Qdxj0Oq5ej1TLiRZAKrDxNdAHG9oGzNFu0+Loh+AKmm8waF6FRG27yjHxWELvKO6MDMylXXrq3IvZr1MXA1dD02byxaGuSJTLlo0wJTGBLLkCoYrjAQ7wO/uQCv/utV6xwbY9J3+aGAqrft6hQMmR9UNN/4mpUglAszsAB9YVQkNI/NNaqWhh8zhbrFIySv3LN89okwnc6rjecFs21jqzLxiOnDrgmPMIRKVPalIW2LwVq1aDJicdB72R39alwkj+jWIa9aT4ECI8KptyEbn5bZbA70cms+uKRo4LSpaPg3E4eNkErwo7VbSxwD3IpRCZIAv75bxX3X/SDd/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db67617-c740-40b6-9e53-08d79e592d23
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 10:03:33.9893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fue9FFBbyXxuBiCCORQ30/smmvQUUc+01mwoApgvSP/hpE0zF3CzWFjMHmk4PMzBIb1gVeuAGwajFgWsYpACQa09QS2Z1cuQt2g74rWKQ8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3195
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use r4 as temporary register. On ARM r0-r3 should be used to hold
function arguments.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-re=
set.c
index dc48f6850796..3b1d566350f4 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -113,8 +113,8 @@ static int at91sam9g45_restart(struct notifier_block *t=
his, unsigned long mode,
 		"beq	1f\n\t"
=20
 		/* Then, test that the RAM controller is enabled */
-		"ldr	r0, [%1]\n\t"
-		"cmp	r0, #0\n\t"
+		"ldr	r4, [%1]\n\t"
+		"cmp	r4, #0\n\t"
=20
 		/* Align to cache lines */
 		".balign 32\n\t"
@@ -138,7 +138,7 @@ static int at91sam9g45_restart(struct notifier_block *t=
his, unsigned long mode,
 		  "r" (1),
 		  "r" cpu_to_le32(AT91_DDRSDRC_LPCB_POWER_DOWN),
 		  "r" (reset->args)
-		: "r0");
+		: "r4");
=20
 	return NOTIFY_DONE;
 }
--=20
2.7.4
