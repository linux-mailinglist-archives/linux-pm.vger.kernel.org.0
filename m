Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E2610A0C4
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 15:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfKZOyO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 09:54:14 -0500
Received: from mail-eopbgr770139.outbound.protection.outlook.com ([40.107.77.139]:3502
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728056AbfKZOyO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Nov 2019 09:54:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMfs2nMezD2y3s+RykUfxt1qfrtpNF3f+Jab5mEUef0jKjI+fcB8Do3HiuvyevkmdB2BzA3I761e3gZQmPhnucxbR4Drx/QjhEXCVUg4Heq9npa37fzZ78w3YCzi65tbjY1DDfhAtTWPeKEIS0zsGXlK8tVCy6lH4yl4sYkgzUyt60hLw1vNwSlFjEBn267LhRjRJ410vphG1RFWixiqlKXiVuNKGK6iMd1OcPVLWGvpa25BSo+PDenLDYISq+SBU8wzgN80L5iRy7ck6ZrgCGmxTIAOfoqSfAsTosTMMR1GpdRzsW2YLGu811YQkvfvcNFZ+gw301sp3nMpIMHBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCCgt1trB2OJrilvW8rjGr4V9YnFNJ+O6+izJctTlAQ=;
 b=SeMZtNy3SeE6aW+y1CTG3K4z0RHpVdJH5fD+Y4U7pa89R4zNYQi+GnSxLjBI4UZS4qXLXneHAfWNZ7n0CrkrYD4TpnM/5rH+OWZp+NqPH5i5sIxCRWTV09AYAQoiKsJdNCcvwtZLOJEEI+37z8TQ4dtdXEp3XH5IsTueptN28yc+IswS7G+IDg/tuoeAYFtgJIZZDW6OCQxFpVsj6/JKq3roPnoENkVWHTHUFou6OLGBJY0lkNGqrer7BRFPEitEm8JLc9hYkOCxmlppwbmSf6oC3gY1lBBwtoVFRVWJH6G2v+rWu1RozCNeGoWsLTIK/M3qy2Arij8/jrZRBBS74A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lexmark.com; dmarc=pass action=none header.from=lexmark.com;
 dkim=pass header.d=lexmark.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Lexmark.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCCgt1trB2OJrilvW8rjGr4V9YnFNJ+O6+izJctTlAQ=;
 b=kiwgZJe4tG/7AvOa/MW+j03J4/PJn4dNTdRnqm3x2WqQ/8O611udg2G4d6gER0UpEK7qVSHdgeMTFmKgwJd4voeZ720v1jUT1q++s/1v6VsSIJViHKXnxyRQXTqAiSJ3fO+tQfwzgjhSdZ3cGvnBQ5Ohbf//BdFmlET5TtUqBEs=
Received: from MWHPR10MB1343.namprd10.prod.outlook.com (10.169.233.144) by
 MWHPR10MB1328.namprd10.prod.outlook.com (10.169.232.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 14:54:11 +0000
Received: from MWHPR10MB1343.namprd10.prod.outlook.com
 ([fe80::f806:6c17:ea13:b9e2]) by MWHPR10MB1343.namprd10.prod.outlook.com
 ([fe80::f806:6c17:ea13:b9e2%11]) with mapi id 15.20.2474.023; Tue, 26 Nov
 2019 14:54:11 +0000
From:   Zak Hays <zak.hays@lexmark.com>
To:     Zak Hays <zak.hays@lexmark.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] thermal: armada-thermal: clear reset in armadaxp_init
Thread-Topic: [PATCH 2/2] thermal: armada-thermal: clear reset in
 armadaxp_init
Thread-Index: AQHVo+iA1kyC2QuZu06OWcaFrvNw2qedirjR
Date:   Tue, 26 Nov 2019 14:54:11 +0000
Message-ID: <MWHPR10MB13435C92C02136EE4582B1218C450@MWHPR10MB1343.namprd10.prod.outlook.com>
References: <1574721077-29892-1-git-send-email-zhays@lexmark.com>,<1574721077-29892-2-git-send-email-zhays@lexmark.com>
In-Reply-To: <1574721077-29892-2-git-send-email-zhays@lexmark.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zak.hays@lexmark.com; 
x-originating-ip: [192.146.101.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a67b891f-6569-46cb-a393-08d772807f78
x-ms-traffictypediagnostic: MWHPR10MB1328:|MWHPR10MB1328:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1328A528F053F288C185E8C58C450@MWHPR10MB1328.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(199004)(189003)(305945005)(7736002)(4744005)(86362001)(186003)(2906002)(3846002)(6116002)(81166006)(74316002)(6200100001)(99286004)(6436002)(102836004)(14454004)(44832011)(25786009)(6506007)(81156014)(478600001)(8936002)(54906003)(52536014)(71190400001)(26005)(256004)(316002)(5660300002)(8676002)(9686003)(76176011)(71200400001)(7696005)(11346002)(4326008)(6862004)(66066001)(446003)(66446008)(55016002)(76116006)(64756008)(66556008)(33656002)(66476007)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR10MB1328;H:MWHPR10MB1343.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lexmark.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CINjPW5wipwRljh7/ISKtX+7Nwz3GU8ZXH3uAGqIHynvarcbC9I9q9mqsYzi9q1GXQ3nzAc8Bl8z9+R49/P3IWVzgIAUzwU7g8jf32anzndx/LszXKOmnDJw513bfVYVAC+lL+vosipIHXATudNQWpBaasMqIjzrR59Jj7kpjiKLUsk/aA4IFpCPV6/ENtKBkLjt4Vf+OC7gRaqglj2WVvD30mBYYP+uC6joa2V/AiXjF03Q4fumOcYwYN3ad9THnsMg+Ef3Kqufq26zEKMWMqm6kWLJteiy3JbbLKSvRhxMuefQTzPRcwKY8NseNgWXoZhPXFLQGQWpzF51qq5XCJAhz3G36Fyx9uhMCVfD2iY17+n7UKkXbzKQBWnyHUQH3D35oHAUVfbqzS+8lIeXpjpFRLtvwuM/54xKqqV2u6kOG0MIQ3/p5tkF9gt21K7P
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Lexmark.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67b891f-6569-46cb-a393-08d772807f78
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 14:54:11.4708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12709065-6e6c-41c9-9e4d-fb0a436969ce
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WOf8Hc5zd4LWz9wZ9INliEWARDSEhVbrrbm32tQy2qTmJQY6GiI0xnfGbXAoxT+R7muh8HyVsFzsFqA1zuD8Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1328
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The reset bit needs to be cleared in the init sequence otherwise it=0A=
=0A=
holds the block in reset.=0A=
=0A=
---=0A=
=0A=
=A0drivers/thermal/armada_thermal.c | 3 +++=0A=
=0A=
=A01 file changed, 3 insertions(+)=0A=
=0A=
=0A=
=0A=
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_ther=
mal.c=0A=
=0A=
index 88363812033c..8c4d1244ee7a 100644=0A=
=0A=
--- a/drivers/thermal/armada_thermal.c=0A=
=0A=
+++ b/drivers/thermal/armada_thermal.c=0A=
=0A=
@@ -155,6 +155,9 @@ static void armadaxp_init(struct platform_device *pdev,=
=0A=
=0A=
=A0=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 regmap_write(priv->syscon, data->syscon_control1_o=
ff, reg);=0A=
=0A=
=A0=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 reg &=3D ~PMU_TDC0_SW_RST_MASK;=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 regmap_write(priv->syscon, data->syscon_control1_off, r=
eg);=0A=
=0A=
+=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 /* Enable the sensor */=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 regmap_read(priv->syscon, data->syscon_status_off,=
 &reg);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 reg &=3D ~PMU_TM_DISABLE_MASK;=0A=
=0A=
-- =0A=
=0A=
2.7.4=0A=
=0A=
=0A=
=0A=
