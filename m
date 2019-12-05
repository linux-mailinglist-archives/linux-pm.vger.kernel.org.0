Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1CB6114273
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 15:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfLEOTa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 09:19:30 -0500
Received: from mail-dm6nam10on2090.outbound.protection.outlook.com ([40.107.93.90]:55039
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729236AbfLEOTa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Dec 2019 09:19:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBrVrNzfbfpe6++79mHLU2qGTqRLd/qOHIU5DKUchCHdGahmUNmIYxGy0/3Pojq6QeUB8UCDB763F7vrqjoj7gHEP539wXGv4ZvMUzwHvQJ8kbS1+Gey0fGKr0eFG9AswPpLXRhb+9PMT4+44asHVVnr3y7axhikYJPM8aPPX/73JoR8osk2CJZErSVtddYk4ddHYCraaM2DASSC/4i47ITVqOYuVVpPFqXYLVNjI8CQcAC9B5/O9i1bp8/EZIzAxoGrNGePoyYpEZO/Xx27q+skx7464nMvELa2wikKwjBZQrnuotUvjzfqaLzD8FKjIPoPazQW+s6Rqd+8nrJzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdynIrtC8HT9gpj8HtWcZhkKp9vjuCxTx8MfwqOIV4k=;
 b=XoqZI3COR5ZXtBeIU5+Ot8e8c8hyBUx4SyztBGGKWryHHxaPDz8I3FOpGo3P8lZvyoadicDBkZ5RhkNiyWdj4mxpTyNN62fdIeql8xsJIOlAHYWSL0PY2Bp1LH/k+qqTleAJ0ncJILDpvwBjLsPHln1kBwMYsnvrGM0v2RTNkQ5/Z55hosUdq5jGFkFdUuJu730GF3WMlkFhCEG4xTxDrQLAiRCxfxchBiFBna5wq/IZ6jjkDkn1JaLKEm9+H4N30CugZKCg5wR7AEYP3VPxPuaYmvetUZYBNEZ1rTSSzveacTYPls9oWWVUQQA1y1ZcZvLPAT6wXUyxa9ndce5+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lexmark.com; dmarc=pass action=none header.from=lexmark.com;
 dkim=pass header.d=lexmark.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Lexmark.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdynIrtC8HT9gpj8HtWcZhkKp9vjuCxTx8MfwqOIV4k=;
 b=P0br9JkVziwRPEmIE1j0UuWn36bK7BMXWdehOajf8zH0kNxA9+rGZyH5b99M/cXeePsmFZi+thvKUUwX7uAcM1TOj4l0Q5Hwkp8TCKzRGB3NsjMaQ7e4hHj9gw59EILeZAW1+ZAxb7nMNO3gP+jWr3xDHsdkPRCLiAapQpPKhEw=
Received: from BN8PR10MB3379.namprd10.prod.outlook.com (20.179.140.29) by
 BN8PR10MB3571.namprd10.prod.outlook.com (20.179.77.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 14:19:28 +0000
Received: from BN8PR10MB3379.namprd10.prod.outlook.com
 ([fe80::9d23:4a97:d48a:7f84]) by BN8PR10MB3379.namprd10.prod.outlook.com
 ([fe80::9d23:4a97:d48a:7f84%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 14:19:28 +0000
From:   Zak Hays <zak.hays@lexmark.com>
To:     Zak Hays <zak.hays@lexmark.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] thermal: armada: clear reset in armadaxp_init
Thread-Topic: [PATCH v2 2/2] thermal: armada: clear reset in armadaxp_init
Thread-Index: AQHVqtv+92aJc2qELka5iHoIMltwrqeqbIMp
Date:   Thu, 5 Dec 2019 14:19:28 +0000
Message-ID: <BN8PR10MB3379C4E94DECA65303064D9F8C5D0@BN8PR10MB3379.namprd10.prod.outlook.com>
References: <1575485367-18262-1-git-send-email-zhays@lexmark.com>,<1575485367-18262-2-git-send-email-zhays@lexmark.com>
In-Reply-To: <1575485367-18262-2-git-send-email-zhays@lexmark.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zak.hays@lexmark.com; 
x-originating-ip: [192.146.101.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b17dd87b-5286-4ecb-de5e-08d7798e235e
x-ms-traffictypediagnostic: BN8PR10MB3571:|BN8PR10MB3571:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR10MB35715A0481C56F859B6340808C5C0@BN8PR10MB3571.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:419;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(189003)(199004)(74316002)(11346002)(14444005)(44832011)(305945005)(8936002)(86362001)(5660300002)(9686003)(81156014)(71190400001)(55016002)(33656002)(71200400001)(2906002)(81166006)(229853002)(6200100001)(6506007)(8676002)(99286004)(26005)(102836004)(6862004)(186003)(4326008)(25786009)(478600001)(14454004)(76116006)(66946007)(7696005)(64756008)(66476007)(54906003)(66446008)(66556008)(76176011)(316002)(52536014)(4744005);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR10MB3571;H:BN8PR10MB3379.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: lexmark.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ktMs9wEkYLVcs9mf+NLSMRU6dlDny7oMBFTScPkF8Ux2BTsjg0rFvgAah/gUvlvqkP+9zsT6IA/zldVqStDHM5VgNfKhAHYjGOereDR4h9XlloIy4BweUs5SU6UMun9bAgH8/MfBrvMUw4kVHRw7E+C4Fl5C3io92uFcQj8cFTZVXZ0Gs4v9goK5vdM7siPpTWlM/6pPc7IwFVtdpiO25f0M9MLHPrTvrejDhxFSe7SsIRcSyEjlqPbkOIfJzbjk+lISpb+7gISd5krp+omCOLA3xG0wmtgUYnJN+KKPBnrc0Dl/i1eHYDwf+zZ7aqf0OFWjwescpoROM8C0mezwKJ7q2Sw0TY8yMRXmYZ82b16KcmC7o2EJcR4GGo1tECproFirKqikgWys6D6scBa1kFeQEhkL1A1InPzW9SrBUh7prVXzYKokXXJgepzjgCKv
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Lexmark.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17dd87b-5286-4ecb-de5e-08d7798e235e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 14:19:28.1281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12709065-6e6c-41c9-9e4d-fb0a436969ce
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rIL5boFM14XJDXh90FXp/JT2tqwhWzLGd3lZf3NftTvnEhVBk7hrFdSa41LJx07foiNld7GlUB5w+KyEP+D8GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3571
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
