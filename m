Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 133EE3C993
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 13:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfFKLAn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 07:00:43 -0400
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:53568
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727140AbfFKLAm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Jun 2019 07:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT8pjQngHVRU6TLjykPGtJTaf00Z65BmSzEW9J+cJv4=;
 b=bUPaNwIVxorzfdE7hMw+e2dHMy+ho4d7lTV6WjNuKE+Riu1z2O+suzqPoEvhMNxhndJV+1kcCFg3x80TH3gN7zRbXnDVt0Gn1AxWKYoSkgshYTjtZYREvZgJ4OKikEzdY9JWV8GglJRLEW2jxzMMYQcPl4Rdwkdf0uXsyfKnun4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5844.eurprd04.prod.outlook.com (20.178.118.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Tue, 11 Jun 2019 11:00:38 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::11e1:3bb9:156b:a3e4]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::11e1:3bb9:156b:a3e4%3]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 11:00:38 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V14 1/5] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V14 1/5] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHVHzds3B6qJhqXrUKDEg49ewd/b6aWSyaQ
Date:   Tue, 11 Jun 2019 11:00:37 +0000
Message-ID: <AM0PR04MB4211D325B1AE944F68EA7F5C80ED0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190610025254.23940-1-Anson.Huang@nxp.com>
In-Reply-To: <20190610025254.23940-1-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a071d497-05c9-41e2-919a-08d6ee5c095d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5844;
x-ms-traffictypediagnostic: AM0PR04MB5844:
x-microsoft-antispam-prvs: <AM0PR04MB5844A069D21AF3FD3736F51080ED0@AM0PR04MB5844.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(366004)(376002)(199004)(189003)(4326008)(4744005)(8676002)(81156014)(81166006)(2906002)(7736002)(99286004)(73956011)(3846002)(44832011)(66446008)(64756008)(66556008)(66476007)(68736007)(25786009)(33656002)(476003)(66946007)(5660300002)(76116006)(52536014)(7416002)(8936002)(446003)(11346002)(486006)(6246003)(186003)(53936002)(6116002)(6506007)(229853002)(256004)(86362001)(6436002)(66066001)(55016002)(9686003)(14454004)(26005)(71190400001)(71200400001)(2201001)(7696005)(2501003)(305945005)(76176011)(316002)(110136005)(102836004)(478600001)(74316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5844;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w4uCYPxyenv3+SSwz73XSCi6fFAqEOUz9O+L8VniRLckLT12y7w6pL7Ot62gairj7O4BT750tU62M7vLbJs7L1i0zfpjtBSX7CaGFuvgefXVAxNop9jpt0Di1I78terKgmTcFaKBUAS8bnB6aaEY0F9Sihzf5NEx4niYBQm89H0kEjPyRPvei4iX6ScPygDwLbT6HnfTVM2XjGIQzZfewXf5+uvsVVpoVuZl+6ms/Vbiveb5BHMCKaAWzViDpsoMbpD5JoZkcrueFqdln0Vpc65THhqrl9ITXvi93d408b8rY9akBFYwnow3oPNfyNfD7Z4v4lHj3Hz8KJ7FwZTw1hJTYugFxho42auY1di0KRtt/3fiOp5PC873vQu1oKNrpTyJTpAkuFTM194OknqnqAoTDG0XzrNSJwwtzN7ewIo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a071d497-05c9-41e2-919a-08d6ee5c095d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 11:00:37.9943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5844
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBGcm9tOiBBbnNvbi5IdWFuZ0BueHAuY29tIFttYWlsdG86QW5zb24uSHVhbmdAbnhwLmNvbV0N
Cj4gU2VudDogTW9uZGF5LCBKdW5lIDEwLCAyMDE5IDEwOjUzIEFNDQo+IA0KPiBOWFAgaS5NWDhR
WFAgaXMgYW4gQVJNdjggU29DIHdpdGggYSBDb3J0ZXgtTTQgY29yZSBpbnNpZGUgYXMgc3lzdGVt
DQo+IGNvbnRyb2xsZXIsIHRoZSBzeXN0ZW0gY29udHJvbGxlciBpcyBpbiBjaGFyZ2Ugb2Ygc3lz
dGVtIHBvd2VyLCBjbG9jayBhbmQNCj4gdGhlcm1hbCBzZW5zb3JzIGV0Yy4gbWFuYWdlbWVudCwg
TGludXgga2VybmVsIGhhcyB0byBjb21tdW5pY2F0ZSB3aXRoDQo+IHN5c3RlbSBjb250cm9sbGVy
IHZpYSBNVSAobWVzc2FnZSB1bml0KSBJUEMgdG8gZ2V0IHRlbXBlcmF0dXJlIGZyb20gdGhlcm1h
bA0KPiBzZW5zb3JzLCB0aGlzIHBhdGNoIGFkZHMgYmluZGluZyBkb2MgZm9yIGkuTVggc3lzdGVt
IGNvbnRyb2xsZXIgdGhlcm1hbCBkcml2ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBI
dWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxy
b2JoQGtlcm5lbC5vcmc+DQoNClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9u
Z0BueHAuY29tPg0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcNCg==
