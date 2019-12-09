Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D48001174F9
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 19:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfLIS50 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 13:57:26 -0500
Received: from mail-dm6nam11on2117.outbound.protection.outlook.com ([40.107.223.117]:32321
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbfLIS5Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Dec 2019 13:57:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2w6ZXTE8zQiKMx1q6aTQ99YWUVNHW0k4H9nUDdlY+52AOmcGNLU9mDIOilHWXlG3ta5aUTS2bXx2q0FUGzh3tXmSgIiPLUqyL31MOPaa2i80F9kgEPaF/xJ1P8K2RG3qfL2mz3KvvsHl5BsLtrSk6Hsco5bKD/4VgC0WUCNcnGoy9/ftA3z/E3MlUJAgYZYftT9gmeAwfF5vbMQsTPFFJ/4gFNJfoKIdQe/k6CbKDMSnRJFurzgKoHUDwPWXAcXRX88Ss/w7SVf7pV0WTd+RZGr7w9jgow/dqDGLehEjCxH7cpnKcSGgjCK5nBbm0UAeokbeX2rAHW6kU0DyzVAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjP6Sw6SMOiyxFiTos0s8WzN7ZhAQOqI0eNAkHnxay4=;
 b=EHaGJmEuLJUeiEafQKN+mpR4JEJZoK+t+Elz5oOAxuCpgZpIrP+TvjO9QiifqRUDAZsx0ibEswmoJvOlmsz+AYIdldBpIS5o0jDUdmBoghpX3OqPaQ3p23Y4xSV8jLr5Cg8Dyk3ihcgexThC42PB3BpdVD6vymukHMIfB5cEAes6u+TExt8TvJWCXXcoPBSfuTPZ1j5GqhPQOvg7ExXWy+7crg0Of3Aw6VSV9VHsOwSt/gTAimuz6K1ohQUcKKsYXJvuBz9AEGBjHLKSkfsVFXce8mW+5F5995o5VGigNbDsJk/4bUNVUUJe/u0LS4XoffcleqNKdKfP4THdx1er6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lexmark.com; dmarc=pass action=none header.from=lexmark.com;
 dkim=pass header.d=lexmark.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Lexmark.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjP6Sw6SMOiyxFiTos0s8WzN7ZhAQOqI0eNAkHnxay4=;
 b=YH9VoDK2ntESyCABwGlIMONZWBKGC0Ma4CT7Ru6KdJS2RSu9dwTDIBratPj2W0P9JUAYqJdFdv4o3YttOdNz7KvoHzk1pSePG9s+dcKRwuoNkO9jsS1oHoJM0g9KI77UfZh+tZ4mU3LDiKhOA2xaf4fuPFrzIch8/oXBR8fjMOY=
Received: from BN8PR10MB3379.namprd10.prod.outlook.com (20.179.140.29) by
 BN8PR10MB3603.namprd10.prod.outlook.com (20.179.96.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Mon, 9 Dec 2019 18:57:23 +0000
Received: from BN8PR10MB3379.namprd10.prod.outlook.com
 ([fe80::9d23:4a97:d48a:7f84]) by BN8PR10MB3379.namprd10.prod.outlook.com
 ([fe80::9d23:4a97:d48a:7f84%7]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 18:57:23 +0000
From:   Zak Hays <zak.hays@lexmark.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] thermal: armada: clear reset in armadaxp_init
Thread-Topic: [PATCH v3 2/2] thermal: armada: clear reset in armadaxp_init
Thread-Index: AQHVrsGMMfmUV7zSrUWgfyKlL9CT4aeyJweT
Date:   Mon, 9 Dec 2019 18:57:23 +0000
Message-ID: <BN8PR10MB33797EECAC557B5018A0A6628C580@BN8PR10MB3379.namprd10.prod.outlook.com>
References: <1575917171-11085-1-git-send-email-zhays@lexmark.com>,<1575917171-11085-2-git-send-email-zhays@lexmark.com>
In-Reply-To: <1575917171-11085-2-git-send-email-zhays@lexmark.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zak.hays@lexmark.com; 
x-originating-ip: [192.146.101.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc3f8f70-5ae2-4f46-4ed2-08d77cd9a03f
x-ms-traffictypediagnostic: BN8PR10MB3603:
x-microsoft-antispam-prvs: <BN8PR10MB3603BF2BC87BDD0FB23DCF3E8C580@BN8PR10MB3603.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:428;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(189003)(199004)(7696005)(478600001)(54906003)(64756008)(66556008)(66476007)(316002)(9686003)(8676002)(2906002)(4326008)(33656002)(109986005)(44832011)(305945005)(81166006)(81156014)(71200400001)(71190400001)(55016002)(76116006)(86362001)(6506007)(52536014)(66946007)(5660300002)(26005)(4744005)(8936002)(66446008)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR10MB3603;H:BN8PR10MB3379.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: lexmark.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fjlgU4pD+ww3o5DMqvq6mL6oPhZWsJzbZBUgAh90XTSBv3l+OJ+rZcvtQgL0ctWf/5Maxt+bcaGt/xxq9p1X+xzsyC7kGR+hnRZEflhId5QNlghqlUeHpPCje1RBRRt671INqOkrmc0X79G5U09UM9U9RCfUMZfKhKFV3VXE0XveUTJw85BkCt9EWL7VZGCuf2BUFgRwnn189UWtjF+e4M0VXVBLhTpl7VL9ntgwXuukQWQAbljllMD5QydJFFsXw0OL26yxH+GZogCTCLyIDEV6q/MgFJuK+1hw7To+7v4jhWKJXoxeVDY1KbsZW10mx/wfkIv8PPVQDc49KJtHFaV/r9KhL8TEE3Cv5+Sbzqmpnt8osfOFuX1+b7DRSp0d/CR6XBMsI+ZjI9ChA3VbFnVOIs/EuQkCVvm5HsJcJckr6Wq+53mHhGtyxvHCuc9M
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Lexmark.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3f8f70-5ae2-4f46-4ed2-08d77cd9a03f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 18:57:23.3685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12709065-6e6c-41c9-9e4d-fb0a436969ce
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eXwS9LBF80UXkW0v0MJK6Heu6oWOlPHmuRQn0M3B7y7A6GTwqQOLe0tnMuVmD5r464SBTqY6B81pqYezEz3T2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3603
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The reset bit needs to be cleared in the init sequence otherwise it=0A=
holds the block in reset.=0A=
=0A=
Signed-off-by: Zachary Hays <zhays@lexmark.com>=0A=
---=0A=
v2: update commit title and add "Signed-off-by"=0A=
v3: resend for clarification=0A=
---=0A=
 drivers/thermal/armada_thermal.c | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_ther=
mal.c=0A=
index 88363812033c..8c4d1244ee7a 100644=0A=
--- a/drivers/thermal/armada_thermal.c=0A=
+++ b/drivers/thermal/armada_thermal.c=0A=
@@ -155,6 +155,9 @@ static void armadaxp_init(struct platform_device *pdev,=
=0A=
=0A=
        regmap_write(priv->syscon, data->syscon_control1_off, reg);=0A=
=0A=
+       reg &=3D ~PMU_TDC0_SW_RST_MASK;=0A=
+       regmap_write(priv->syscon, data->syscon_control1_off, reg);=0A=
+=0A=
        /* Enable the sensor */=0A=
        regmap_read(priv->syscon, data->syscon_status_off, &reg);=0A=
        reg &=3D ~PMU_TM_DISABLE_MASK;=0A=
--=0A=
2.7.4=0A=
=0A=
