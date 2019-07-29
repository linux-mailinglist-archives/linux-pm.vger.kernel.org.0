Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1701078BD0
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 14:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfG2Mbd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 08:31:33 -0400
Received: from mail-eopbgr140057.outbound.protection.outlook.com ([40.107.14.57]:35077
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726281AbfG2Mbc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 08:31:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZL2px7wgLCjkaqPqxuXabyJbjWAfQKP6FbtFns3yDvUWtdfFnJIqa+x6zCDi0sn4bj5mtHYdHhfYZkkyPT1WsKLThwN5Tuo/8mTWRL6SibA4s4+zf8Xdzot+ddepoxWSs4+nq0jqCdk+c/ARhproL7Mnd1+W5lE8Dqh9QE3ZO7MJj/0I1MGakAz7mz0LV1tVo623/m8hWGRS+5HFQoMEWp/Kra3p5UF3r8oW6l7JgaA8R2V4OdTCcJptXdwkmD0bUEaFeqPum37cJQg9jvU48Ms+Z+ieRBBBM1Rbyg6yFob8HhoDhDCCHQvULpdNZBDoCCssB2n9ItqOLxkS2OVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLKZH5l9t4ufxRL31RjNwsj/8SJm0yvB1I0gH+EqERs=;
 b=mvrvCk/hdoTGy2bUEBc6OogC5RaPNbdnZ4SA4WoUF+TL3jIhC9FAZY+yQBVi0hcmnjSXPnnGTf4K66X7Hx6LextdF9ps2CjqF/H6u4UcNmGHfAMaP01OfhmoQvOXSA8VYCrAjYleA9kzwhCZbREskhJY/I7mRdBMwj0hQVO5HwE895Ug1qMhrBZ2ai1ZRM9OlToucQnRiSV67RoG6Gn5Tcn3n2pWXxMDbRga9a+84HWMMnzkS6uq5cEAjMQ9dHz5l4cDQ23C7pdFR76YLTqkR3zxzxKoEQxPMIwjR2r/O630o+BnxClzIDgASXb0Jy7flwsm5alOWmTkokDerVYN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLKZH5l9t4ufxRL31RjNwsj/8SJm0yvB1I0gH+EqERs=;
 b=FfRFC2drj2dy3N+nCqaMCYo/zVSaklXv6IMdSDbd5ZCd7kUBbjbOITx40aRpzQ4H/qxvyHzt+70BrTa4ukKkKVlgv19Y7KmE1eWVV37q3RJUeJ44odUzVvIfTk3YWw2Pgvgme7+cTRrECLaBRBV6czWYDyVL5MT3x3iytbEgMo0=
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com (52.133.13.160) by
 VI1PR04MB4109.eurprd04.prod.outlook.com (52.133.14.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Mon, 29 Jul 2019 12:31:29 +0000
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::c85e:7409:9270:3c3c]) by VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::c85e:7409:9270:3c3c%7]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 12:31:29 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Anson Huang <anson.huang@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 3/4] dt-bindings: thermal: qoriq: Add optional clocks
 property
Thread-Topic: [PATCH V2 3/4] dt-bindings: thermal: qoriq: Add optional clocks
 property
Thread-Index: AQHVRepz3jd36eTKFkuG7BwzhmVEnKbhh0EA
Date:   Mon, 29 Jul 2019 12:31:28 +0000
Message-ID: <127ec2189686771665366910eae3e1f256bd2a7a.camel@nxp.com>
References: <20190729083915.4855-1-Anson.Huang@nxp.com>
         <20190729083915.4855-3-Anson.Huang@nxp.com>
In-Reply-To: <20190729083915.4855-3-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a496099-f213-4cec-7686-08d71420ae44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4109;
x-ms-traffictypediagnostic: VI1PR04MB4109:
x-microsoft-antispam-prvs: <VI1PR04MB41090BD7678D186779F8170EF9DD0@VI1PR04MB4109.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(189003)(199004)(6636002)(71200400001)(2906002)(66556008)(64756008)(66946007)(66476007)(6116002)(66446008)(6246003)(76116006)(91956017)(7736002)(305945005)(36756003)(256004)(53936002)(6506007)(14454004)(4326008)(478600001)(3846002)(86362001)(110136005)(6512007)(118296001)(99286004)(316002)(229853002)(102836004)(76176011)(71190400001)(446003)(25786009)(66066001)(44832011)(8936002)(11346002)(476003)(81156014)(81166006)(2616005)(8676002)(486006)(2201001)(50226002)(6486002)(2501003)(68736007)(5660300002)(6436002)(26005)(4744005)(186003)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4109;H:VI1PR04MB4094.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SpPyTLDaLibo1dh1F8Xi+6Sb4SRPLcaQ2CA0lPYOgkx0wnVFuJtGcUVp6qfb1XxY8RQDRxHQZiDbxHJVaDw8fKR3CwUNVbgayXJESocm5/TQGgbQGaXl8n/BH0TcCgR1ShskghpNRYWYAYWut9UI6HRnjlVmcUyoOuKoRGdgppcHlH0S0pDCsY77Th5gHfler3l8HecEYuBm/SpKH9xWdzybx6PCvLm7ltl9Ira6sF12MSRLgCOZdA2f+28v+NJPa2ByP27u0kFlWKnF0MEsPq0ot4GjN4zYnIE613IBOZNv1T4ViXorr7VQhS0PobtQOLC8n9/qoGT2cP564L1GEzHwIQkkiSQXYix4XrNNEkB2SrzAvID2YqGZM+LRDXBe2sMKDxyny8K6jMcBnaKFWFcRN7peAIXw/HNyMKQOmuk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02BDA005D5788C4DB4219D6A98D0F0A2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a496099-f213-4cec-7686-08d71420ae44
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 12:31:29.0156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: daniel.baluta@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4109
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gTW9uLCAyMDE5LTA3LTI5IGF0IDE2OjM5ICswODAwLCBBbnNvbi5IdWFuZ0BueHAuY29tIHdy
b3RlOg0KPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gDQo+IFNv
bWUgcGxhdGZvcm1zIGhhdmUgY2xvY2sgY29udHJvbCBmb3IgVE1VLCBhZGQgb3B0aW9uYWwNCj4g
Y2xvY2tzIHByb3BlcnR5IHRvIHRoZSBiaW5kaW5nIGRvYy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KDQpQbGVhc2UgYWxzbyBwaWNrIFJv
YidzIFJldmlld2VkLWJ5IGZyb20gbGFzdCByZXZpc2lvbi4NCg0KPiAtLS0NCj4gTm8gY2hhbmdl
cy4NCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGhlcm1hbC9x
b3JpcS10aGVybWFsLnR4dCB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Ro
ZXJtYWwvcW9yaXEtDQo+IHRoZXJtYWwudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3RoZXJtYWwvcW9yaXEtDQo+IHRoZXJtYWwudHh0DQo+IGluZGV4IDA0Y2JiOTAuLjI4
ZjJjYmEgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90
aGVybWFsL3FvcmlxLXRoZXJtYWwudHh0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy90aGVybWFsL3FvcmlxLXRoZXJtYWwudHh0DQo+IEBAIC0yMyw2ICsyMyw3IEBA
IFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ICBPcHRpb25hbCBwcm9wZXJ0eToNCj4gIC0gbGl0dGxl
LWVuZGlhbiA6IElmIHByZXNlbnQsIHRoZSBUTVUgcmVnaXN0ZXJzIGFyZSBsaXR0bGUgZW5kaWFu
Lg0KPiBJZiBhYnNlbnQsDQo+ICAJdGhlIGRlZmF1bHQgaXMgYmlnIGVuZGlhbi4NCj4gKy0gY2xv
Y2tzIDogdGhlIGNsb2NrIGZvciBjbG9ja2luZyB0aGUgVE1VIHNpbGljb24uDQo+ICANCj4gIEV4
YW1wbGU6DQo+ICANCg==
