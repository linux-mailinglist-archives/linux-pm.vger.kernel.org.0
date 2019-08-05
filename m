Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19821812B1
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 09:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfHEHCf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 03:02:35 -0400
Received: from mail-eopbgr50076.outbound.protection.outlook.com ([40.107.5.76]:59910
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726375AbfHEHCf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Aug 2019 03:02:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAwSLf0ch1aY7hqJIfVHRHuhJzPw49oJw/s6nx3K4rHLb7HlCjxfrbNWkWi+hVixD2SlxhUcNrDGlYNVivOEvJ+aAMVPsaGgM9NwDsUl/W8O+X1ZJAwna7uTkbWGqxWMx+0f/sE03XcZphwssI9HcXk1v8CR6fo6kiRGO+sJFjrlwXWsFQyTeMNIA3p8kCar2TOdS/D4C7UWJXe84sP0cA84eKThMoSUXYDyqRsG5TJ3jD5ihsK7uFQgBaI9PyQTqGyA9DYbKdHmo9nSVR1rt3IIbqZuRlOmiYWZt7KlfYMS9fQVw4XQeZhz8xwYzhODpVKaZoEJ3TrS2M33mj41eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhPQ/1YihpA86LKtFtSVNSxs8Ka5la6tpPg+MIkXrY0=;
 b=n/fyVZCXai3zFjisEjBcJxUPOSLod0/vl8xYu2tExpzUAPyorKftl20SgsCbbEo7MbFINNxvrHmd0teVkSnzmFxmzBPHamXYtP1lXJLll2hHm3nTAKlbR4fITTinCwiEUxx1V1kHGGgDrrN07r7epLClgOX9Se1jx/as8eyUn2x+bbfAdkK88XN5/hKiXsGR9cUUKFRYxfywCA0sKtuprU68ykM6CHEonwnTABzyHtOeaE+j+xX07ktTOoMEusjmcGaki/M5dk9NwmhdQkQgceZt0MyABI7XrridTsxouBBR+GoV/vnPYv6+pJNg3MeQRrwmBrALr28U1J1WnNXTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhPQ/1YihpA86LKtFtSVNSxs8Ka5la6tpPg+MIkXrY0=;
 b=Fb4phbBKTBziWcjDphoS0sdOj8+V4MAu3CSpcbzRWRY/iKlOFI2gKbvckI4iuHxGfD2VqCvluElDE9pJcZpK3iAOqGEF3ZG34wjOzKTOPrCnypXKWcwMeCc9y+4zwvN6DYTKWPOvMSXXovw5A5cAdM8ScuUfKMwk2NNJzt9U2Ow=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6577.eurprd04.prod.outlook.com (20.179.255.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Mon, 5 Aug 2019 07:02:31 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5553:29b6:d66c:6afe]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5553:29b6:d66c:6afe%5]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:02:31 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 5/5] dt-bindings: thermal: qoriq: Add optional clocks
 property
Thread-Topic: [PATCH V3 5/5] dt-bindings: thermal: qoriq: Add optional clocks
 property
Thread-Index: AQHVRn7WFVqxJm4LuEW+w7KL0Lw4sabsKmuA
Date:   Mon, 5 Aug 2019 07:02:31 +0000
Message-ID: <AM0PR04MB42117687C2604556C2559B4E80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190730022126.17883-1-Anson.Huang@nxp.com>
 <20190730022126.17883-5-Anson.Huang@nxp.com>
In-Reply-To: <20190730022126.17883-5-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bea5f23c-a03b-421d-8c1b-08d71972e2a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6577;
x-ms-traffictypediagnostic: AM0PR04MB6577:
x-microsoft-antispam-prvs: <AM0PR04MB6577E3412C9A05D7E67568BF80DA0@AM0PR04MB6577.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(6436002)(76176011)(81156014)(11346002)(8676002)(478600001)(74316002)(476003)(7736002)(256004)(9686003)(14454004)(66066001)(2501003)(305945005)(55016002)(53936002)(8936002)(71190400001)(71200400001)(33656002)(44832011)(66556008)(66476007)(64756008)(66946007)(66446008)(52536014)(76116006)(81166006)(558084003)(229853002)(110136005)(25786009)(486006)(5660300002)(2906002)(316002)(99286004)(6246003)(2201001)(6506007)(86362001)(186003)(446003)(3846002)(6116002)(102836004)(7696005)(68736007)(4326008)(26005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6577;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bPKwjFvafOLYKcAi0jniSUBAfy1tc8ABggn9RPW/vp9LuA08lZlA1NY+pMdktWbOEk64w9P2NS3oS+06A/RBRYavJ5ZnUn+J5oFF5ETSQbO0PIFwLg/XW0/umwbB57Ej37oiz4lwiaHn2eEC2yLk2lU9j0v2RGgGsI8wlHdsdvv0QHS0P755jNBQsskHk2R7tO5jeDqjiSFiH2nWpVaSX/Q4E8In3cEgUcqw0sUuwdSX28UJAIUlR+EuIilRftCApHv3amtHfcmgeHl1b0gMwEA8ptBcHDfWLypDP0CAvolQXk0x/7y9QFWutHd+OQwd0t/eXlENo9VAjKR93EsQgRX9kbRcxVDIMqyXQAjdr4pjiklDnT/nxs/JyI+fKm8EoAmotiFfQM/si13M8O0iELQYvCoElOTkKqg4LYuLonA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea5f23c-a03b-421d-8c1b-08d71972e2a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:02:31.3999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6577
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBGcm9tOiBBbnNvbi5IdWFuZ0BueHAuY29tIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBKdWx5IDMwLCAyMDE5IDEwOjIxIEFNDQo+IA0KPiBTb21lIHBsYXRmb3JtcyBs
aWtlIGkuTVg4TSBzZXJpZXMgU29DcyBoYXZlIGNsb2NrIGNvbnRyb2wgZm9yIFRNVSwgYWRkDQo+
IG9wdGlvbmFsIGNsb2NrcyBwcm9wZXJ0eSB0byB0aGUgYmluZGluZyBkb2MuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQoNClJldmlld2VkLWJ5OiBEb25nIEFp
c2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpBaXNoZW5nDQo=
