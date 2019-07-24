Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC74672538
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 05:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfGXDRI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 23:17:08 -0400
Received: from mail-eopbgr40057.outbound.protection.outlook.com ([40.107.4.57]:15942
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbfGXDRI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jul 2019 23:17:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8qcp6rPfc7/zvm5FT4pwVD+0AtEG4mpGkDmJ7Bp871psDAMZ1o4rsuTedG/2Dnu9WNa1UTbmqBjfNvs5f+xnnAYdgkBvFMJTX0xgHdfQ4+osW0dTfurlbIgxqNm2HTQrgzpPN0860UoqGdLTPFjWEVO/DgOgBwOI7m9oYmc1R2FjAJuDcDBt1b1vP0crK+4E523i3nJyawMfgFHb2HJHH5UKTkAC20reazgRjQ23pVoroz5MPNfmUnIoa/mDdGFseQ68800qs3++cU0ERvF5JTTt/KPg+PUxQ2TTiWgN/GgXWWzKWGzq2uJF2kB42HXGP5jVwdlEswpuosQ+Gaquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4s6gOeuodSoyUOPUAU23lLZHe+QbUK8IOOoLOZxYCk=;
 b=PK4zgwDWETOoyVN6+OySX+PTmUEoKOTjTYMXXEI/NFm5tyHwDcfUvYj2fXvGi1lu/UPCOwasmJ+Hw86QLGI2PzjxpZCgyd7Zm1SkU+LoJ/nA/5ApnRd17N/ka3oFYBqzYTPkB12fFq8gGOvcr0MJnyjtixnIXQN4cDQ3oUvVF47FUyl7stK6X63Q6+bM71QXFXkUYEfqaiItcsp/Ai/RnRih1YYd5azcsjsiZ3gH3KamRoi2XUqdcqYHoj76uwYvm9vLmoLdhkYJ2ayCQy3JSSpw9/CkEdY3sT8HMCh9cqxv+LegfY1EMSFFgGZJP0U/fKNddhSupcymBUm7VTgfDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4s6gOeuodSoyUOPUAU23lLZHe+QbUK8IOOoLOZxYCk=;
 b=N/ryaTxl7yn6LUEGEJM+VvHdpKO94DT6NuUf1JN3OBFWxUUona36WunMS7Sc+9kUZsvUiNurEa8s9IwtmtJUAMUUMUYn44rKyvkHQ/1Qu8gO6/G9PXy3R7OqTt90+44E+jlukKfW7VHT2W9joYI32EQIObxN1yDF8xNTlvG9PuM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3769.eurprd04.prod.outlook.com (52.134.71.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Wed, 24 Jul 2019 03:17:00 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2094.017; Wed, 24 Jul 2019
 03:16:59 +0000
From:   Anson Huang <anson.huang@nxp.com>
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
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "olof@lixom.net" <olof@lixom.net>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V15 1/5] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V15 1/5] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHVJXvnLQPj9qjL2U2LZTWuyBDONqaqeq9ggC7WvJA=
Date:   Wed, 24 Jul 2019 03:16:59 +0000
Message-ID: <DB3PR0402MB39162EB555CD7AE75D58C582F5C60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190618021820.14885-1-Anson.Huang@nxp.com>
 <DB3PR0402MB39162C5B5AF828B127DD871EF5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39162C5B5AF828B127DD871EF5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31936f57-d2e2-4326-9e48-08d70fe5643a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3769;
x-ms-traffictypediagnostic: DB3PR0402MB3769:
x-microsoft-antispam-prvs: <DB3PR0402MB37696D24A8E05080CFCC8D18F5C60@DB3PR0402MB3769.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(199004)(189003)(9686003)(14454004)(55016002)(53936002)(6436002)(33656002)(7416002)(478600001)(305945005)(7736002)(74316002)(2501003)(256004)(44832011)(446003)(2906002)(11346002)(486006)(476003)(66066001)(3846002)(6116002)(186003)(26005)(6506007)(102836004)(68736007)(81166006)(8676002)(81156014)(76176011)(8936002)(229853002)(316002)(71190400001)(71200400001)(110136005)(99286004)(7696005)(2201001)(6246003)(25786009)(4326008)(66446008)(76116006)(52536014)(66946007)(5660300002)(66476007)(66556008)(86362001)(64756008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3769;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bj1vxS/qyAckNIUkEfG27smZ76qHrrvIwsf02G4wQrsroiaKC48WWpYmJdQYatEf5WDSXzFN1nxXEE/ag86VSGE+//6P1BkNRP1NxJJN9dMW/fKXByXNbEW7Ty0uyYcX3nhg4OQjCD+1Z2fhN2JVKqgDJQTSTO1yoFq69GwIfq/d5U7Yao4nEeN0eYAREEXDXVOX4ZJQk1naWtDePXOsbgHUQ4MbxlhO1ZLqMiCHeyCdgBd3AmGRoMmvaFRi8ydwVlJRpX0vwmDek5hULQQc6Seeefan+PLMOsgTH/eFEDnI0ikNuR7U0hbMNnxnuQ3CCePai6hmSXhWZRe6j0mjZegEtjOUzGzU7DaHI2iRFt6zEBvOsGvOz+BtbvhfQvqVbCpUD9PoXqe1RiOQGy4nEiRAaZp8YcDw8V7yrWVAhNM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31936f57-d2e2-4326-9e48-08d70fe5643a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 03:16:59.9045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3769
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

UGluZy4uLg0KDQo+IEhpLCBEYW5pZWwvUnVpL0VkdWFyZG8NCj4gCUNvdWxkIHlvdSBwbGVhc2Ug
dGFrZSBhIGxvb2sgYXQgdGhpcyBwYXRjaCBzZXJpZXM/DQo+IA0KPiBBbnNvbg0KPiANCj4gPiBG
cm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPg0KPiA+IE5YUCBpLk1Y
OFFYUCBpcyBhbiBBUk12OCBTb0Mgd2l0aCBhIENvcnRleC1NNCBjb3JlIGluc2lkZSBhcyBzeXN0
ZW0NCj4gPiBjb250cm9sbGVyLCB0aGUgc3lzdGVtIGNvbnRyb2xsZXIgaXMgaW4gY2hhcmdlIG9m
IHN5c3RlbSBwb3dlciwgY2xvY2sNCj4gPiBhbmQgdGhlcm1hbCBzZW5zb3JzIGV0Yy4gbWFuYWdl
bWVudCwgTGludXgga2VybmVsIGhhcyB0byBjb21tdW5pY2F0ZQ0KPiA+IHdpdGggc3lzdGVtIGNv
bnRyb2xsZXIgdmlhIE1VIChtZXNzYWdlIHVuaXQpIElQQyB0byBnZXQgdGVtcGVyYXR1cmUNCj4g
PiBmcm9tIHRoZXJtYWwgc2Vuc29ycywgdGhpcyBwYXRjaCBhZGRzIGJpbmRpbmcgZG9jIGZvciBp
Lk1YIHN5c3RlbQ0KPiA+IGNvbnRyb2xsZXIgdGhlcm1hbCBkcml2ZXIuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiBSZXZpZXdl
ZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gPiBSZXZpZXdlZC1ieTogRG9u
ZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBObyBjaGFuZ2Uu
DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNs
LHNjdS50eHQgICAgICAgIHwgMTYNCj4gKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCj4g
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxz
Y3UudHh0DQo+ID4gaW5kZXggYTU3NWU0Mi4uZmMzODQ0ZSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0K
PiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxl
L2ZzbCxzY3UudHh0DQo+ID4gQEAgLTE1NSw2ICsxNTUsMTcgQEAgUmVxdWlyZWQgcHJvcGVydGll
czoNCj4gPiAgT3B0aW9uYWwgcHJvcGVydGllczoNCj4gPiAgLSB0aW1lb3V0LXNlYzogY29udGFp
bnMgdGhlIHdhdGNoZG9nIHRpbWVvdXQgaW4gc2Vjb25kcy4NCj4gPg0KPiA+ICtUaGVybWFsIGJp
bmRpbmdzIGJhc2VkIG9uIFNDVSBNZXNzYWdlIFByb3RvY29sDQo+ID4gKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICsNCj4g
PiArUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiArLSBjb21wYXRpYmxlOgkJCVNob3VsZCBiZSA6
DQo+ID4gKwkJCQkgICJmc2wsaW14OHF4cC1zYy10aGVybWFsIg0KPiA+ICsJCQkJZm9sbG93ZWQg
YnkgImZzbCxpbXgtc2MtdGhlcm1hbCI7DQo+ID4gKw0KPiA+ICstICN0aGVybWFsLXNlbnNvci1j
ZWxsczoJU2VlDQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwv
dGhlcm1hbC50eHQNCj4gPiArCQkJCWZvciBhIGRlc2NyaXB0aW9uLg0KPiA+ICsNCj4gPiAgRXhh
bXBsZSAoaW14OHF4cCk6DQo+ID4gIC0tLS0tLS0tLS0tLS0NCj4gPiAgYWxpYXNlcyB7DQo+ID4g
QEAgLTIyMiw2ICsyMzMsMTEgQEAgZmlybXdhcmUgew0KPiA+ICAJCQljb21wYXRpYmxlID0gImZz
bCxpbXg4cXhwLXNjLXdkdCIsICJmc2wsaW14LXNjLXdkdCI7DQo+ID4gIAkJCXRpbWVvdXQtc2Vj
ID0gPDYwPjsNCj4gPiAgCQl9Ow0KPiA+ICsNCj4gPiArCQl0c2VuczogdGhlcm1hbC1zZW5zb3Ig
ew0KPiA+ICsJCQljb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLXNjLXRoZXJtYWwiLCAiZnNsLGlt
eC1zYy0NCj4gPiB0aGVybWFsIjsNCj4gPiArCQkJI3RoZXJtYWwtc2Vuc29yLWNlbGxzID0gPDE+
Ow0KPiA+ICsJCX07DQo+ID4gIAl9Ow0KPiA+ICB9Ow0KPiA+DQo+ID4gLS0NCj4gPiAyLjcuNA0K
DQo=
