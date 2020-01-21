Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8E5143A52
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 11:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgAUKDv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 05:03:51 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:14578 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbgAUKDu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 05:03:50 -0500
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
IronPort-SDR: Nt9o4RTF/6Kz909nL6JxvzZG3+GtFb5GmgME64bOVqLvQ0uxESpZvH0iawSjLjEIgBlBEm8Whs
 RjE9hlmDr7AWOBE/KVidRpqJ/tvmZ5blU22Y9S0NLbix0vDJ+ncfJkQECqSJiMZyEii5BSZy7m
 LFOYQrJ5EFKOaqOJTIml/XtupNaGhxP7Y8nvG/DTY6hKuxCN7UNho4Ea+ebA9/CIlfiarQd+Qd
 /nH7nmTdLT06JAThciDWI+S6L/7Fn1pAO24uE/xuNi/0vjk2ge+Fzs4K5e4b+nJt9KZMM9O+l+
 XIg=
X-IronPort-AV: E=Sophos;i="5.70,345,1574146800"; 
   d="scan'208";a="61482009"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2020 03:03:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Jan 2020 03:03:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 21 Jan 2020 03:03:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2fS4C7XGqQb9rqYbyDT5g4/q9X1q8sddgWFR7qzUAjW8auURlX47wP0QB8p+mXcbru0wxp/QD4iJ44szj/EFDrHx9uOBL7e1WgyhkkfXtlpUj7TLIsyXJsolcalVOnMQRnVe86vI3g4VuHzJbZQiuTbylvjqC06xfLqeX93L1DI8XurN9ROO86Q2qiZYaihwElvM9rQ1lsoeJKo4YCRhQRh7ujSCPMmVeo4vWgprREFWcumxoIf5aHG+c6xkTQuYJXeKsL7HngplRTXICxnldqnEpzRxldqE+7iDq8+ueRqLrIT5wkJUNugLNvJjLn6asO8LAX0W2qFnYZ2F+xnHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2vpdduo2XNpb06Z4rYtE/JZqZJ/hudWwYY+A9yxMQo=;
 b=GN2QoE1lVz5cqVOQbLZSgMqEwDQHbT9BD/w/TCPfLc5ztP6gmdVppjOLyKmwE3lwOtjtZdHefcomM1/DEiQMDOeATIS9homwjk5uZYcAC6OVFqAUMXMFJjZNiGbCAza3EeZPDZWk72s9/KxKTRrIVPMM/NjcHeFYY8D6ktlpo72F32N49R6MCYIB94y/ujAF2BZEsu31g8NQtZo6Ymh69hlEfSfzlVQKCC4hjCWDOZYJCZwYgaTJriJYI3A/QVA6DAC0y7Tb7Qk9rbWbey6XVtttTAoz8uHW9AJVyTNXFo1P6nkCFLJeLLSXJRKTwMUdUjYq8dn3HjT/BlaGFaAbhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2vpdduo2XNpb06Z4rYtE/JZqZJ/hudWwYY+A9yxMQo=;
 b=YOwmVkvKhA2UCLqZ9eIL1MaycLuI4EtazoX8jrLjtS+0Ry0RvAaZzHIr7zZJdOMv/vDdCWNQfqJohx2dq03s5d3LFZLpbUQtueOEJzyJMA/hH4k0eCdNyJEJqV/cgTpAbdJSSAWfE0jauqtzyjJ53tR3QcDN8vqY7QIwvVfQOxk=
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
Subject: [PATCH 14/15] power: reset: at91-reset: get rid of at91_reset_data
Thread-Topic: [PATCH 14/15] power: reset: at91-reset: get rid of
 at91_reset_data
Thread-Index: AQHV0EINUSutYpQLDkidNc7mZapi4g==
Date:   Tue, 21 Jan 2020 10:03:39 +0000
Message-ID: <1579601001-5711-15-git-send-email-claudiu.beznea@microchip.com>
References: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bbe64d4-1c8d-436b-fe33-08d79e59302b
x-ms-traffictypediagnostic: DM6PR11MB3195:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB31957417C64CA0280DC48D98870D0@DM6PR11MB3195.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:120;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(199004)(189003)(107886003)(26005)(186003)(36756003)(5660300002)(110136005)(54906003)(4326008)(66556008)(66476007)(6506007)(2906002)(76116006)(91956017)(6486002)(86362001)(64756008)(6512007)(66946007)(66446008)(8676002)(81156014)(2616005)(81166006)(8936002)(6636002)(71200400001)(316002)(478600001)(26583001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3195;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XTagG1G7wxtXMVUccmBFui9wySdWRkmB+h6iehYcTDzRvASN9JI/dmzabMCYvpiNieARHdmetCmE6gaPr9JoWrXmqtZkErVUUoomg75dVHoNvfahJRZyj8IfEX737UNJp4o5LmfiAmXDLjS71fp/76XoFI0bK/GD0aDkl74ILMtr8F7RBDcEy0kDGl/3VrD9aFRUr/DDJYLFvn77dv62/L/JanmxNxwOmH9C3/7+gAX+uCBGTOcLnjXtn2+eMuqi7R9TSe6nTST+1s8K+f98o/a317DtP47wx647PIh7wSwuBOjEZ7r+ikDjHwp5EOksT20491Dol9iv+Cw7+1ajZLnDO6goDkLkcURmPhtxGHctCHsNVka0QsImcKVCher6fH8/E4Cbf61ahZsw0VOSSHPtbMahd2kmbO9ivgbT0e2Ws9djoXJoJj0SHyTn9bNohhj1qsumPNbPHLn55w1oHORC1WK6K1gvtTPrNm8eSdtTrxwHXX2ny12kvNYrRhgn
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbe64d4-1c8d-436b-fe33-08d79e59302b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 10:03:39.0174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjRxwkVi/GjgFfLUgsygcRzCLh+B0k2vodkSX5ZtzHHSnOVdZK7v5yG/V4LZOPkA68NZ/FKtX0u30LHgGQWXizuRHw4vqvbY5PH+Nqez0oE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3195
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

After refactoring struct at91_reset_data and
struct at91_reset_data at91sam9260_reset_data are not needed anymore.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 37 +++++++++---------------------------=
-
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-re=
set.c
index 9c1b69f76a01..537ccb180568 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -49,10 +49,6 @@ enum reset_type {
 	RESET_TYPE_ULP2		=3D 8,
 };
=20
-struct at91_reset_data {
-	u32 args;
-};
-
 struct at91_reset {
 	void __iomem *rstc_base;
 	void __iomem *ramc_base[2];
@@ -156,42 +152,29 @@ static const struct of_device_id at91_ramc_of_match[]=
 =3D {
 	{ /* sentinel */ }
 };
=20
-static const struct at91_reset_data at91sam9260_reset_data =3D {
-	.args =3D AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST,
-};
-
-static const struct at91_reset_data at91sam9g45_reset_data =3D {
-	.args =3D AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST,
-};
-
-static const struct at91_reset_data sama5d3_reset_data =3D {
-	.args =3D AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST,
-};
-
-static const struct at91_reset_data samx7_reset_data =3D {
-	.args =3D AT91_RSTC_KEY | AT91_RSTC_PROCRST,
-};
-
 static const struct of_device_id at91_reset_of_match[] =3D {
 	{
 		.compatible =3D "atmel,at91sam9260-rstc",
-		.data =3D &at91sam9260_reset_data
+		.data =3D (void *)(AT91_RSTC_KEY | AT91_RSTC_PERRST |
+				 AT91_RSTC_PROCRST),
 	},
 	{
 		.compatible =3D "atmel,at91sam9g45-rstc",
-		.data =3D &at91sam9g45_reset_data
+		.data =3D (void *)(AT91_RSTC_KEY | AT91_RSTC_PERRST |
+				 AT91_RSTC_PROCRST)
 	},
 	{
 		.compatible =3D "atmel,sama5d3-rstc",
-		.data =3D &sama5d3_reset_data
+		.data =3D (void *)(AT91_RSTC_KEY | AT91_RSTC_PERRST |
+				 AT91_RSTC_PROCRST)
 	},
 	{
 		.compatible =3D "atmel,samx7-rstc",
-		.data =3D &samx7_reset_data
+		.data =3D (void *)(AT91_RSTC_KEY | AT91_RSTC_PROCRST)
 	},
 	{
 		.compatible =3D "microchip,sam9x60-rstc",
-		.data =3D &samx7_reset_data
+		.data =3D (void *)(AT91_RSTC_KEY | AT91_RSTC_PROCRST)
 	},
 	{ /* sentinel */ }
 };
@@ -199,7 +182,6 @@ MODULE_DEVICE_TABLE(of, at91_reset_of_match);
=20
 static int __init at91_reset_probe(struct platform_device *pdev)
 {
-	const struct at91_reset_data *reset_data;
 	const struct of_device_id *match;
 	struct at91_reset *reset;
 	struct device_node *np;
@@ -230,10 +212,9 @@ static int __init at91_reset_probe(struct platform_dev=
ice *pdev)
 	}
=20
 	match =3D of_match_node(at91_reset_of_match, pdev->dev.of_node);
-	reset_data =3D match->data;
 	reset->nb.notifier_call =3D at91_reset;
 	reset->nb.priority =3D 192;
-	reset->args =3D reset_data->args;
+	reset->args =3D (u32)match->data;
=20
 	reset->sclk =3D devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(reset->sclk))
--=20
2.7.4
