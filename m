Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0B1143A4D
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 11:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgAUKDp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 05:03:45 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:14578 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbgAUKDo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 05:03:44 -0500
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
IronPort-SDR: xeVJn7man1HH7FlO7Z0pKUdlvajWaH+Ts5I7TTw/tiRrJXhDz4zKAWAl0RcsvjTdduKZTyVpuw
 om+ee4OhkPfibGP8wxLzufsMxLUWv9lNHB53twwMGZn1XYwD8v1oShGnC1syJdES12aUO0OILF
 oEkOz7AtjOoSuajc1aps9DVUslclZYz3KQkiVVRuTTIliu+/yvqiadIPBJ/41+A7r0/HXylEK+
 EcztduSMeoWeB9WurqNfRvgVp8OftRK2056q+JfEG9mQGA2h+vy6VT6paOe9MYKVWVCB0bm30i
 tt4=
X-IronPort-AV: E=Sophos;i="5.70,345,1574146800"; 
   d="scan'208";a="61481965"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2020 03:03:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Jan 2020 03:03:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 21 Jan 2020 03:03:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCt1omnpWjo92QiON6c6AmJHTdJ3sAOz+KMua4IPsJ+riSg7d5WjqaQy2U8nHYfJEQGRJQAtZHE2hIFHOKnErBwlBEFyw6iXcAYKOcOwGOqDVHOiHLKxeyvKUvnrP4lpyKGsII3Z0ORBom74mXC7D40RbGW9zt0BOo6j3k652S4AWFm9C7umye0TgV0xj96miiofNIgpv83vC0QkuKqHHinH6Mq7jcRzqJXjkabFn3BPBX52EypFNbCdqNWTfztuPY+YF5XeyALK0764o1JhOlbJdM5S0tvoww1o7XnBii9h7Ol0i+Gzw14vaKUjzWYxe+YnGNNyv12lnnHaoMDEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10nCea1OuXGgKhgut2z6FehDPAthGmYp6lnT6XoBvHc=;
 b=cOhBa+n7O4kUnTwC5nCJTC3O2jDSyA7pP0TmS4XsWtzZl4DXThDKjdgoO1AGApzZk2AcArh3cPpWpjDY3RmwMphpdb6jFyjDMzl+3fygjDZxX4mCIk8+wAIs0lFHjLW9rg9Oxb7ogLGvaiykVaB3y00V+OWmgAWIDi9OYaamldbL798LQCGyl2vLrc3E53BQ9j8H0+g4H35lnd1mGwrExw2eRL0Nj61OUcCScNYFlaX3n2y0t4se4KvVXAJOy+m4XSfM6zjXLbcCNmdLhUatop1xLb8Eg8uIsMOMHPNu4lmsvjhnXGKYVFmMsHe+sF5875hNHf0ZHAAhUFKVEFsgCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10nCea1OuXGgKhgut2z6FehDPAthGmYp6lnT6XoBvHc=;
 b=bR+MiqsqZOYP11wRP6DvEK0ZC4eJ3ZbRlLQUSYxcdIMXajf2sZvIdOg510Zcb75kuFTDdteoqnkMpJGZU18VdnlZy6GFJ0gXN2EdRKHrGR3ACP2naLSgYa24mDv4qjm4Jsri8v5jbzxDTs4IZvQOy6xOwvk33OyKGvqzBtOJ79Q=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB3195.namprd11.prod.outlook.com (20.176.121.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 10:03:31 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a%7]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 10:03:31 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sre@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 04/15] power: reset: at91-reset: add notifier block to struct
 at91_reset
Thread-Topic: [PATCH 04/15] power: reset: at91-reset: add notifier block to
 struct at91_reset
Thread-Index: AQHV0EIIU8blIOUR0kO6jGES0k9GCw==
Date:   Tue, 21 Jan 2020 10:03:31 +0000
Message-ID: <1579601001-5711-5-git-send-email-claudiu.beznea@microchip.com>
References: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f44131d3-80af-4cec-f347-08d79e592b5b
x-ms-traffictypediagnostic: DM6PR11MB3195:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3195423B702A715B2D125495870D0@DM6PR11MB3195.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:172;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(199004)(189003)(107886003)(26005)(186003)(36756003)(5660300002)(110136005)(54906003)(4326008)(66556008)(66476007)(6506007)(2906002)(76116006)(91956017)(6486002)(86362001)(64756008)(6512007)(66946007)(66446008)(8676002)(81156014)(2616005)(81166006)(8936002)(6636002)(71200400001)(316002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3195;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jeS5xRDwExHm+0+bdy1E4p7zOPhtxDS3rVQYxVPFoci8dDKpRYF6m9ANfFClCqz1Wfd+ey0BpnMy2njeE+Wjc/bXFelcq/dWQgOgTi3b6YzULLHKhVP/thcJalN2/gP+Z7+Fx5NW1DuG+pPHPKpQAuJBqcUEPJTtI1R7lHi4uBLWk50oyDpjb7VpMRCdu52eRW/y1hUDO//xeOVZI+d2cAP166Dj0lHJvzcT43+p8wTPcZi2C5PwJHgLzZwNUle8JSwxL9A8lTPGEv4yfPPxnbKPy0sosN7y8i/Xv4W0nvrjNk0mBS4ERu7A3+POiQVPCv2tDVrJC6e6Ep2+Gk/GmfWyOo6CcjNQDRErJ6uAMI44kYdv+xFPblHSDliUPrDeWliceAX5C4S9xyiDKnFJtY49oLm4Dl0zQh8fqvhT6KeY3P1W9ybceT8vUXWnE3j9
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f44131d3-80af-4cec-f347-08d79e592b5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 10:03:31.1809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vDFweXCYr09a6tWK+1JmOYbOf7GDda25npKit1YKobKUoIt/ZvtfESHfxgBN11f0T0uwtryvD+q33U6FGxjjlne63bNVah+PX7LZBVF1vRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3195
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add struct notifier_block to struct at91_reset.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-re=
set.c
index 1bc39bfda0aa..e8840193620d 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -53,6 +53,7 @@ struct at91_reset {
 	void __iomem *rstc_base;
 	void __iomem *ramc_base[2];
 	struct clk *sclk;
+	struct notifier_block nb;
 };
=20
 static struct at91_reset reset;
@@ -205,10 +206,6 @@ static const struct of_device_id at91_reset_of_match[]=
 =3D {
 };
 MODULE_DEVICE_TABLE(of, at91_reset_of_match);
=20
-static struct notifier_block at91_restart_nb =3D {
-	.priority =3D 192,
-};
-
 static int __init at91_reset_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
@@ -235,7 +232,8 @@ static int __init at91_reset_probe(struct platform_devi=
ce *pdev)
 	}
=20
 	match =3D of_match_node(at91_reset_of_match, pdev->dev.of_node);
-	at91_restart_nb.notifier_call =3D match->data;
+	reset.nb.notifier_call =3D match->data;
+	reset.nb.priority =3D 192;
=20
 	reset.sclk =3D devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(reset.sclk))
@@ -247,7 +245,7 @@ static int __init at91_reset_probe(struct platform_devi=
ce *pdev)
 		return ret;
 	}
=20
-	ret =3D register_restart_handler(&at91_restart_nb);
+	ret =3D register_restart_handler(&reset.nb);
 	if (ret) {
 		clk_disable_unprepare(reset.sclk);
 		return ret;
@@ -260,7 +258,7 @@ static int __init at91_reset_probe(struct platform_devi=
ce *pdev)
=20
 static int __exit at91_reset_remove(struct platform_device *pdev)
 {
-	unregister_restart_handler(&at91_restart_nb);
+	unregister_restart_handler(&reset.nb);
 	clk_disable_unprepare(reset.sclk);
=20
 	return 0;
--=20
2.7.4
