Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03F4B143A5B
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 11:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgAUKEP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 05:04:15 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:14542 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgAUKDl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 05:03:41 -0500
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
IronPort-SDR: YaZ25HCHd9MDL4nrCKqEckPMp9U8nDYrmNcGMIMqjw6ZxtfmXVSoaW9PN4hQHKNTLVlbbHiJwd
 9g180v09PukYAgP7skJdo8LkhHo9cbhYZoQHkdKD1Wy+nUU5k7KcMQ1QESsI3sRYWhIf64cIGT
 8vJPBzptTKKjTsaSf/Q3Er+UcmKxkBzY1bhWML2uB8kmW+86YkDmSrR/cxxx7LewJZQzmALx2s
 U8LoUDafuq3+j1m9uW5QeLgeKMVO/ByVpJaqtQrtqDa9ePzpY3QlWOOc8dj9qA5ApD8FTW9F+3
 wa8=
X-IronPort-AV: E=Sophos;i="5.70,345,1574146800"; 
   d="scan'208";a="61481956"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2020 03:03:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Jan 2020 03:03:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 21 Jan 2020 03:03:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gslh72yMcaJW/kv5f9s2vh89Vk3GHV4SPukRyWuggiitfkA0DsHHkkBdoYaZFBFVqPP/bdUKLQIi7K/kmiId6iY9Nozqw+wOweYKSZqvmOkS76+EjgMvhQuKDrBMBijT67uN2DUD94KcUTHTAWrSRZD5dWwCPOJ8L1dr2OwdfDdweAxZMn+Wxdgza19P1s1ltvXvfHy0Zi3pbuxaBdRLAkIZsWTPWJLTA4S57yyGnLuQnggK2MQjZ01I+4/9y8FAJxffwfkpAvSifXJSONNBvVAOyfb2JH3EX+rX/Tw6vHCqcMy2wpz+xKPfDcBHwnfa516XI0TQhjv8eiTrikBVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSgkQ+QVhd8fNuskSB4YcrNio8Fdt2ZF1VWo+k1UP70=;
 b=ZczlPGrrIBq0lrk38HrajB4fnncilKPcK+W4gq1aqLipmrowG/lhre93mkdmp4JFoSQMTJKGUJyP6m+oXVnxe8SGhYDtyFwy98vV7a1BMIR3C6OI6uMK4q/FFdKmWXtDSyvlGpcMghb4xzDGAIj1hUy92DT88KNqVAT47IbhhRw6s0/IsS7mGfYysOzZ87uV8RiUH8FQSeT0Gfwwa7v/MH45Xqh/Q55jeyBy+7wDBLbN9NCSCeYq9RgZxonjsfdLkH6WOa7h+5P5X0zrS//GzATJrP32SA5RI5C6hJDdRO2e5vAdHkS8qnp1bp2LPpjnGocQYtk7rpBY++bGCUq1xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSgkQ+QVhd8fNuskSB4YcrNio8Fdt2ZF1VWo+k1UP70=;
 b=hfn6Bef9o/lZNPNGVC0QXsHvSCFATcZZEkXf4A7O6dEfo0KEomI6BDoezKKYd22LKQj95P9WB17L63sH46CmDapybWA3xXpXG6Js9yDBUTadjko++dV7md0OzWRfJ8qifSzlKSKfL0BRib3Kp7LgiySrTxscu7JpzIL8GZZYRoU=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB3195.namprd11.prod.outlook.com (20.176.121.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 10:03:38 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a%7]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 10:03:38 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sre@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 13/15] power: reset: at91-reset: keep only one reset function
Thread-Topic: [PATCH 13/15] power: reset: at91-reset: keep only one reset
 function
Thread-Index: AQHV0EIN4pR9JeMnZ0SqGReN+xq8tA==
Date:   Tue, 21 Jan 2020 10:03:38 +0000
Message-ID: <1579601001-5711-14-git-send-email-claudiu.beznea@microchip.com>
References: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 410ba330-7a36-4660-97e6-08d79e592fd6
x-ms-traffictypediagnostic: DM6PR11MB3195:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB319588F877D9C361FFDCD4F4870D0@DM6PR11MB3195.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(199004)(189003)(107886003)(26005)(186003)(36756003)(5660300002)(110136005)(54906003)(4326008)(66556008)(66476007)(6506007)(2906002)(76116006)(91956017)(6486002)(86362001)(64756008)(6512007)(66946007)(66446008)(8676002)(81156014)(2616005)(81166006)(8936002)(6636002)(71200400001)(316002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3195;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CNDJtTCStd+S0w2ha4ceIfKYX0tjsy/WEWbdYVABmAXPZQRB56u60n0HTUeTdD90XWpfMPZnD6c+B6oW/AWShHIQyyS1JeAS1sNm6/2QtC4F0SmskigcE7z9OA6/cu2k1HEMiDpshlR8DnY6/DAzf1pGSAN8YlFpkpKq/gBw5XDQusrCMuv0CaAV39mjEQLMcBIhx7RRAT8BV73RRAPdYjo7U2T6XWlBK+Znib4BFG9I24NwAcDuXU+8AeTC61Q1tkIhCAjmGzN5F8lOj1tXMSXiojDvmGfLWg6ACJ6BrlS/LEQj0vGf/qoxuC8n3Wl+Hp1J++GnG4D7QXpTGCHfWQXmNaxf0n+3dLHIb8jo68n15J8JVZCov40GFflzCOKnnONepDiGz+NTLP0OhrKJSU+2vvgyv+m3j5w1Vldhyt8XRIiY92Tgz0ZB4BwYue6v
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 410ba330-7a36-4660-97e6-08d79e592fd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 10:03:38.3327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1a4RQn737anXI1+YlaxSprpJCVE/xu+hOxBhLelakFqk+CbxUX8cc5aSlnD7crskUqGUlCfm3cULhhfHvngUnKw3rJYT8VAm5pp1JWOLic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3195
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Keep only one reset function. With this, notifier_call member of
struct at91_reset_data could be removed.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 52 +++---------------------------------=
----
 1 file changed, 3 insertions(+), 49 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-re=
set.c
index 61433060d784..9c1b69f76a01 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -50,8 +50,6 @@ enum reset_type {
 };
=20
 struct at91_reset_data {
-	int (*notifier_call)(struct notifier_block *this, unsigned long mode,
-			     void *cmd);
 	u32 args;
 };
=20
@@ -69,38 +67,8 @@ struct at91_reset {
 * reset register it can be left driving the data bus and
 * killing the chance of a subsequent boot from NAND
 */
-static int at91sam9260_restart(struct notifier_block *this, unsigned long =
mode,
-			       void *cmd)
-{
-	struct at91_reset *reset =3D container_of(this, struct at91_reset, nb);
-
-	asm volatile(
-		/* Align to cache lines */
-		".balign 32\n\t"
-
-		/* Disable SDRAM accesses */
-		"str	%2, [%0, #" __stringify(AT91_SDRAMC_TR) "]\n\t"
-
-		/* Power down SDRAM */
-		"str	%3, [%0, %5]\n\t"
-
-		/* Reset CPU */
-		"str	%4, [%1, #" __stringify(AT91_RSTC_CR) "]\n\t"
-
-		"b	.\n\t"
-		:
-		: "r" (reset->ramc_base[0]),
-		  "r" (reset->rstc_base),
-		  "r" (1),
-		  "r" cpu_to_le32(AT91_SDRAMC_LPCB_POWER_DOWN),
-		  "r" (reset->args),
-		  "r" (reset->ramc_lpr));
-
-	return NOTIFY_DONE;
-}
-
-static int at91sam9g45_restart(struct notifier_block *this, unsigned long =
mode,
-			       void *cmd)
+static int at91_reset(struct notifier_block *this, unsigned long mode,
+		      void *cmd)
 {
 	struct at91_reset *reset =3D container_of(this, struct at91_reset, nb);
=20
@@ -137,16 +105,6 @@ static int at91sam9g45_restart(struct notifier_block *=
this, unsigned long mode,
 	return NOTIFY_DONE;
 }
=20
-static int sama5d3_restart(struct notifier_block *this, unsigned long mode=
,
-			   void *cmd)
-{
-	struct at91_reset *reset =3D container_of(this, struct at91_reset, nb);
-
-	writel(reset->args, reset->rstc_base);
-
-	return NOTIFY_DONE;
-}
-
 static void __init at91_reset_status(struct platform_device *pdev,
 				     void __iomem *base)
 {
@@ -199,22 +157,18 @@ static const struct of_device_id at91_ramc_of_match[]=
 =3D {
 };
=20
 static const struct at91_reset_data at91sam9260_reset_data =3D {
-	.notifier_call =3D at91sam9260_restart,
 	.args =3D AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST,
 };
=20
 static const struct at91_reset_data at91sam9g45_reset_data =3D {
-	.notifier_call =3D at91sam9g45_restart,
 	.args =3D AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST,
 };
=20
 static const struct at91_reset_data sama5d3_reset_data =3D {
-	.notifier_call =3D sama5d3_restart,
 	.args =3D AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST,
 };
=20
 static const struct at91_reset_data samx7_reset_data =3D {
-	.notifier_call =3D sama5d3_restart,
 	.args =3D AT91_RSTC_KEY | AT91_RSTC_PROCRST,
 };
=20
@@ -277,7 +231,7 @@ static int __init at91_reset_probe(struct platform_devi=
ce *pdev)
=20
 	match =3D of_match_node(at91_reset_of_match, pdev->dev.of_node);
 	reset_data =3D match->data;
-	reset->nb.notifier_call =3D reset_data->notifier_call;
+	reset->nb.notifier_call =3D at91_reset;
 	reset->nb.priority =3D 192;
 	reset->args =3D reset_data->args;
=20
--=20
2.7.4
