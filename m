Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3641DAC73
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 09:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgETHm4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 03:42:56 -0400
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:21857
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726486AbgETHm4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 May 2020 03:42:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ug2NoFfAwd0mGYInWzRrPu67Eo+8lG5h6na2BzTWr3cOdrfVc4hSts206Q2/sjwRfTB2ppcj+3Gu0XXocoE7pxXf0m0fAMueHnB7Qd0j3aDNYUJnshGNxIxIVMLCK/ofVKK81ddYkReR3ripJ0N4cxnBLk/0INBG5JcyXN/zZQfKfJTfT+GeRd26OQ9U/Y7lRrE/PZsGUcpft0VVw7FnjTPQ0Cv6ORDs2gHcXoAZTo5QI/f/Smvpp1/ImpVTXdbkNkbphRFUVSkkyfC1bWuUfB7xzyUnEbeoZlGH0j7ujpiMXmMwkdR1kHF7yeeY5WhptAYGgVvocK+RsXUgA1dPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSRZPCDbufUmrgsnWbTbxZb7wFvANVs0jaOrNKGtgZI=;
 b=CF0e5c+r2euFrM6HoXIp6y35xSFO0b9uMtcn7yTeMDBB2XuoERMtBYCUZqAuBntLXxvnpbOYxi59AyMA3F1vrWNgPNBkTiclc2taQch933fCLmD+wUCrra2Gy/89Ca5bC2Enh4t/BF+0flcJFIQcJM434p+hqP6jSoCbgTHA7hE4ai9oRo+uAGipY8W4ZQdS9Go79I4IPlEsu5vzQu6nho8cC4crk5zwX2L1jVKhVUkjFUk6XkWL08sklBuGrx+xRrC1KQcn+yNDLMSJ+Iw9m9Ye21tr4uXAy5xyR66A6I6th0EzY4UaxrAOfg1Brhy/F/Zw4y4jXK3Hq1FfDbwVYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSRZPCDbufUmrgsnWbTbxZb7wFvANVs0jaOrNKGtgZI=;
 b=QksjmZXwvVI0U/EYPsJ7AiZr+7I+1/SgDA+S4pmtP9GSH98VQzhpudzzi+oYrQvulVGqaWyRn4yKo/zYxb+SUjRuoezH0eaft40fA/CMYfVklYX5GrfG1o3oe60rZb5UWo1GiidiTQ75tHBXUYcTVcnfEZPCROHPYT5qz9vvRjk=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6166.eurprd04.prod.outlook.com (2603:10a6:20b:b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Wed, 20 May
 2020 07:42:50 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 07:42:50 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] dt-bindings: thermal: Convert i.MX to json-schema
Thread-Topic: [PATCH V2] dt-bindings: thermal: Convert i.MX to json-schema
Thread-Index: AQHWLm2m6ex6T4CMsEaus6xk71vL56iwk9PQ
Date:   Wed, 20 May 2020 07:42:50 +0000
Message-ID: <AM6PR04MB4966F875F2E04D0F6FC3AE3A80B60@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589954560-10810-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589954560-10810-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78aac862-b1ac-4c6a-6394-08d7fc916618
x-ms-traffictypediagnostic: AM6PR04MB6166:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB61660E81F655D01B1112CF8E80B60@AM6PR04MB6166.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qDoalGnqg1eKaubOet3u+6z/YDc/rNd0dudept8v+9dSH/J7HsrJ0kiZu58QP6XJK7LMseR7Yw773EIpOL9/LmyhOxfQrnWtYqR8iTvApJaBA+EvQskrLGWcmsfo0m/WKX2HQSja24ntvTrdIk9smlFjiSMrKy0AMm1I82TH8Y5NzpkqE0qUt7V4LGGM2ZLeW0T+v8+Oj0yk8u37SP0gzBIcdu06+246z95KFtbFXN+SngJyUZrmfEVI1eOfLB7FnbcJdcTuiPjx4yo5oxsonR08KShWqw2DJjgIYxwntwJ+CgMV/uimYraxlM2g+D9XcSrEK4GTxkrluPbAH9t7ZJwM9TxKGFqLhMqhCY6XFeZLeE6FU6uCQscFDJ1cWMQIlWk2qYYgtvfvJXOcqq6f73PyqWniz0QkkftpBjcdywjvTC1exnGJgbJ6lsvlELnfObh9nZAJQZaSho74IrtdY8VK+GYMMc+kjcNlhpeMTCQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(9686003)(7416002)(2906002)(26005)(5660300002)(52536014)(4326008)(186003)(33656002)(110136005)(66946007)(478600001)(8936002)(7696005)(71200400001)(66556008)(55016002)(6506007)(44832011)(66476007)(86362001)(64756008)(76116006)(66446008)(316002)(8676002)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Fo1D9B+xq0mOIiBPfJSgd006kDJT2ZML1WT0utDnwoTmY9jGnfiWcCV4xuMMIghZ45/PakGx7FPdqT5NMVkupBzMLYo33krSM+TiIGWTvgXU3rYCHax8C/jvuIXagnDknusCcWs2gp9UbVyg1WCrDxkULQQK6q8nyXAKY39v5dGfgzLOX17yVGOvHcl0LA4cBtFvDPapX95udljR4IdnYnA7sjtixYuO+nRnfXF+asW+Ec2FkBkq2EWB/smXrv1INp9sfJ7EC41eGX3K4FZ6SZRaQDhX5ldDjg1KhiAp80e07p4wa4Eyz7eMxaL23FpLoGXfxg/wOwfqQ0/ezkE+bqMhbr8Zzx00MKmoTjDDhga1ZAiNpxNPCoqAQKT7o//vVQPNizo5+H+mo0Gz64kpKo7HlPulm6MO4b5aeSY1Fen8dfyncmWoL6jZe9kvPTotGqZi0tn84YWIBVUopV9AiiCduZSoRH3WiWHielVrfsFNd4Dxs3yH0i+fNnkU+YWl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78aac862-b1ac-4c6a-6394-08d7fc916618
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 07:42:50.9006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pElSNhcAj+BNq4DELE9OuqCHbml1RdjrTsv9GRrMuj7+SEacX4DsQqmNJNDzMZmX4vQ6akRfJjuUl1rh1Lcf9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6166
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogV2VkbmVz
ZGF5LCBNYXkgMjAsIDIwMjAgMjowMyBQTQ0KPiANCj4gQ29udmVydCB0aGUgaS5NWCB0aGVybWFs
IGJpbmRpbmcgdG8gRFQgc2NoZW1hIGZvcm1hdCB1c2luZyBqc29uLXNjaGVtYQ0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+IC0tLQ0KPiBD
aGFuZ2VzIHNpbmNlIFYxOg0KPiAJLSBtb3ZlIHRlbXBtb24gbm9kZSBpbnRvIGl0cyBwYXJlbnQg
bm9kZSBhbmF0b3AgaW4gZXhhbXBsZTsNCj4gCS0gaW1wcm92ZSAiZnNsLHRlbXBtb24iIGRlc2Ny
aXB0aW9uLg0KPiAtLS0NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvaW14LXRo
ZXJtYWwudHh0ICAgIHwgIDYxIC0tLS0tLS0tLS0tLS0NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3RoZXJtYWwvaW14LXRoZXJtYWwueWFtbCAgIHwgMTAwDQoNClsuLi5dDQoNCj4gK3RpdGxl
OiBOWFAgaS5NWCBUaGVybWFsIEJpbmRpbmcNCj4gKw0KPiArbWFpbnRhaW5lcnM6DQo+ICsgIC0g
U2hhd24gR3VvIDxzaGF3bi5ndW9AbGluYXJvLm9yZz4NCj4gKyAgLSBBbnNvbiBIdWFuZyA8QW5z
b24uSHVhbmdAbnhwLmNvbT4NCj4gKw0KPiArcHJvcGVydGllczoNCj4gKyAgY29tcGF0aWJsZToN
Cj4gKyAgICBvbmVPZjoNCj4gKyAgICAgIC0gaXRlbXM6DQoNCkRyb3AgVW5uZWNlc3NhcnkgcHJv
cGVydGllcw0KDQo+ICsgICAgICAgICAgLSBlbnVtOg0KPiArICAgICAgICAgICAgICAtIGZzbCxp
bXg2cS10ZW1wbW9uDQo+ICsgICAgICAgICAgICAgIC0gZnNsLGlteDZzeC10ZW1wbW9uDQo+ICsg
ICAgICAgICAgICAgIC0gZnNsLGlteDdkLXRlbXBtb24NCj4gKw0KPiArICBpbnRlcnJ1cHRzOg0K
PiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ICsgICAgICBUaGUgaW50ZXJydXB0IG91dHB1dCBvZiB0
aGUgY29udHJvbGxlciwgdGhlIElSUSB3aWxsIGJlIHRyaWdnZXJlZA0KPiArICAgICAgd2hlbiB0
ZW1wZXJhdHVyZSBpcyBoaWdoZXIgdGhhbiBoaWdoIHRocmVzaG9sZC4NCj4gKyAgICBtYXhJdGVt
czogMQ0KDQpZb3UnZCBiZXR0ZXIgZXhwbGFpbiB3aHkgaW50ZXJydXB0cyBudW1iZXIgaXMgY2hh
bmdlZCBpbiB0aGUgbmV3IGJpbmRpbmcgY29tcGFyZWQgdG8NCnRoZSBvcmlnaW5hbCBvbmUuIFBy
b2JhYmx5IGFkZCBpbiBjb21taXQgbWVzc2FnZSBpZiByZWFsbHkgbmVlZGVkLg0KDQo+ICsNCj4g
KyAgbnZtZW0tY2VsbHM6DQo+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gKyAgICAgIFBoYW5kbGUg
dG8gdGhlIGNhbGlicmF0aW9uIGNlbGxzIHByb3ZpZGVkIGJ5IG9jb3RwIGZvciBjYWxpYnJhdGlv
bg0KPiArICAgICAgZGF0YSBhbmQgdGVtcGVyYXR1cmUgZ3JhZGUuDQoNCkJldHRlciBkZXNjcmli
ZSBmb3IgZWFjaCBvZiB0aGVtIGFzIHlvdSBkaWQgZm9yIGNsb2Nrcw0KDQo+ICsgICAgbWF4SXRl
bXM6IDINCj4gKw0KPiArICBudm1lbS1jZWxsLW5hbWVzOg0KPiArICAgIG1heEl0ZW1zOiAyDQo+
ICsgICAgaXRlbXM6DQo+ICsgICAgICAtIGNvbnN0OiBjYWxpYg0KPiArICAgICAgLSBjb25zdDog
dGVtcF9ncmFkZQ0KPiArDQo+ICsgIGZzbCx0ZW1wbW9uOg0KPiArICAgICRyZWY6ICcvc2NoZW1h
cy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlJw0KPiArICAgIGRlc2NyaXB0aW9uOiBQ
aGFuZGxlIHRvIHRoZSByZWdpc3RlciBtYXAgbm9kZS4NCg0KV2hhdCByZWdpc3RlciBtYXA/IEEg
Yml0IGFtYmlndW91cy4uDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiArDQo+ICsgIGZzbCx0ZW1w
bW9uLWRhdGE6DQo+ICsgICAgJHJlZjogJy9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25z
L3BoYW5kbGUnDQo+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gKyAgICAgIERlcHJlY2F0ZWQgcHJv
cGVydHksIHBoYW5kbGUgcG9pbnRlciB0byBmdXNlIGNvbnRyb2xsZXIgdGhhdCBjb250YWlucw0K
PiArICAgICAgVEVNUE1PTiBjYWxpYnJhdGlvbiBkYXRhLCBlLmcuIE9DT1RQIG9uIGlteDZxLiBU
aGUgZGV0YWlscyBhYm91dA0KPiArICAgICAgY2FsaWJyYXRpb24gZGF0YSBjYW4gYmUgZm91bmQg
aW4gU29DIFJlZmVyZW5jZSBNYW51YWwuDQo+ICsgICAgZGVwcmVjYXRlZDogdHJ1ZQ0KPiArDQo+
ICsgIGNsb2NrczoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICtyZXF1aXJlZDoNCj4gKyAg
LSBjb21wYXRpYmxlDQo+ICsgIC0gaW50ZXJydXB0cw0KPiArICAtIGZzbCx0ZW1wbW9uDQo+ICsg
IC0gbnZtZW0tY2VsbHMNCj4gKyAgLSBudm1lbS1jZWxsLW5hbWVzDQo+ICsNCj4gK2FkZGl0aW9u
YWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiArDQo+ICtleGFtcGxlczoNCj4gKyAgLSB8DQo+ICsgICAg
I2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL2lteDZzeC1jbG9jay5oPg0KPiArICAgICNpbmNs
dWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ICsNCj4g
KyAgICBlZnVzZUAyMWJjMDAwIHsNCj4gKyAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0K
PiArICAgICAgICAgI3NpemUtY2VsbHMgPSA8MT47DQo+ICsgICAgICAgICBjb21wYXRpYmxlID0g
ImZzbCxpbXg2c3gtb2NvdHAiLCAic3lzY29uIjsNCj4gKyAgICAgICAgIHJlZyA9IDwweDAyMWJj
MDAwIDB4NDAwMD47DQo+ICsgICAgICAgICBjbG9ja3MgPSA8JmNsa3MgSU1YNlNYX0NMS19PQ09U
UD47DQo+ICsNCj4gKyAgICAgICAgIHRlbXBtb25fY2FsaWI6IGNhbGliQDM4IHsNCj4gKyAgICAg
ICAgICAgICByZWcgPSA8MHgzOCA0PjsNCj4gKyAgICAgICAgIH07DQo+ICsNCj4gKyAgICAgICAg
IHRlbXBtb25fdGVtcF9ncmFkZTogdGVtcC1ncmFkZUAyMCB7DQo+ICsgICAgICAgICAgICAgcmVn
ID0gPDB4MjAgND47DQo+ICsgICAgICAgICB9Ow0KPiArICAgIH07DQo+ICsNCj4gKyAgICBhbmF0
b3BAMjBjODAwMCB7DQo+ICsgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDZxLWFuYXRvcCIs
ICJzeXNjb24iLCAic2ltcGxlLW1mZCI7DQo+ICsgICAgICAgIHJlZyA9IDwweDAyMGM4MDAwIDB4
MTAwMD47DQo+ICsgICAgICAgIGludGVycnVwdHMgPSA8MCA0OSBJUlFfVFlQRV9MRVZFTF9ISUdI
PiwNCj4gKyAgICAgICAgICAgICAgICAgICAgIDwwIDU0IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0K
PiArICAgICAgICAgICAgICAgICAgICAgPDAgMTI3IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiAr
DQo+ICsgICAgICAgIHRlbXBtb24gew0KPiArICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZnNs
LGlteDZzeC10ZW1wbW9uIjsNCj4gKyAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkg
NDkgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ICsgICAgICAgICAgICAgZnNsLHRlbXBtb24gPSA8
JmFuYXRvcD47DQo+ICsgICAgICAgICAgICAgbnZtZW0tY2VsbHMgPSA8JnRlbXBtb25fY2FsaWI+
LA0KPiA8JnRlbXBtb25fdGVtcF9ncmFkZT47DQo+ICsgICAgICAgICAgICAgbnZtZW0tY2VsbC1u
YW1lcyA9ICJjYWxpYiIsICJ0ZW1wX2dyYWRlIjsNCj4gKyAgICAgICAgICAgICBjbG9ja3MgPSA8
JmNsa3MgSU1YNlNYX0NMS19QTEwzX1VTQl9PVEc+Ow0KPiArICAgICAgICB9Ow0KPiArICAgIH07
DQo+IC0tDQo+IDIuNy40DQoNCg==
