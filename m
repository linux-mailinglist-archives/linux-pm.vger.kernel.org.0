Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89A41E4239
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 14:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgE0M0d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 08:26:33 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:8261
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbgE0M0d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 May 2020 08:26:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gO7INjzKlkYs6xHM+hpyEtVpRiRMg0e7dv+ryw7II8bs/kV3IAccfWarXGn9My1kGCNk2SCcpP0AljkqUYM8AmDSPRd9AknrF3fkwL3kcmeb1CrE/qIvX+MAYNAOPedWxx6hxrqObJlYnILkrkzlnoF2j9JI9LPs4OIBODF0S35Jg3lpgKlunYyX6xuu6SKBb/QpHzbD2vuMXRDKmC4tSFdvJkXbyhkat1O8+EBluSibzcgkk1PPZEtf+Pm9tWuYYpQCBoZjYJZDPqreDgvfAJ4p2pCqO9JPRQD1z3yV6PUIl8gjdbhXReBEbmFESuCPRZ9H2XG1NgdRZYxZUZLhxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWJqXs6b+E0o0I1cBRPpymP/Sp7WkEjlf7y3u58/8/8=;
 b=Y6sZDqaF3qghf91rc6Nnkr9g7v/4QJHtJ6yiBNduj6IaFrnfWveh1DA7tfgjKV0Fh6Hfte6Y3W6/Ja3oukrORpiiPZSt1dCCgBc3gAe6blMpxS7t5rFiwwHk7fykYqlFWifjHovadwWQU1glxct+pzY0MVSL2h+KQ1zJuEyyCaI8tv5P7No1qh+wR3KCWWNiFXooD8uvDSpHn+yE9/VG+V5zjhtYp8+VJo9bhmYF66iI4cCCF9JvjsFZFZNIrklH0p9vHdizg8Hh1+tNzZ7x6BIhlxCrmQvZM8CypTRRicjQZoPfll8/W3K+4qfN3vf2ycuyBf/ndNBek+DWmTT6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWJqXs6b+E0o0I1cBRPpymP/Sp7WkEjlf7y3u58/8/8=;
 b=jModZNMcw38dVv4ltPEFCP++x+QqK75csXpbA4IfesOCLDL30SyrkSRHbI0H2GN1OS5eMTV09gFpTrcUfT6Mm7t5HcaZBLTEClEGqZ8UbuK35s8rsyc118h33KXP2G/Q1An9zw7bAXR64FXSrVr+MmYO2O5Q75PUljAPV4bTMPQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3868.eurprd04.prod.outlook.com (2603:10a6:8:f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 27 May
 2020 12:26:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 12:26:28 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] thermal: imx8mm: Add get_trend ops
Thread-Topic: [PATCH] thermal: imx8mm: Add get_trend ops
Thread-Index: AQHWKNOp8EPkl0qqRkG+GoQWiQOYA6i0bHgAgABvx3CAAM7gAIAAy+LwgAGwT5CAAI+kAIAAQRqAgAL23OA=
Date:   Wed, 27 May 2020 12:26:28 +0000
Message-ID: <DB3PR0402MB3916978B2D56374FE335E28BF5B10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1589338689-15700-1-git-send-email-Anson.Huang@nxp.com>
 <fccf4197-d0ca-f313-8f70-000ef4731033@linaro.org>
 <DB3PR0402MB3916B6D11328A036BD479D39F5B50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <6a4d31e4-8a24-2e9f-aa49-bec8258ead4c@linaro.org>
 <DB3PR0402MB39167D71ED6979FC33D3747DF5B20@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39162E6A876BA54A80B0DCE2F5B30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <dadf94db-8aa5-d1a7-5818-c56032a44ea4@linaro.org>
 <DB3PR0402MB391695A412B26134060D1D1BF5B30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB391695A412B26134060D1D1BF5B30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62630d33-97bf-47e4-570b-08d802392e5d
x-ms-traffictypediagnostic: DB3PR0402MB3868:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38680A641AEF2628FA78F7A5F5B10@DB3PR0402MB3868.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jk4rb98s2bzy5A4s1xAKJZcHA7bcAhhg8Z5SwOcesQQFfg/vWbDpEqIduEe9eJr2nYJrBcwgaNtkCe0pU/MEbBUrga9DJTxFHkqpZq8UBDVCeF+ncaiWloquuXZLsNVoNj6hygc+NRvvVd8vreQ+I599vEHsSfZ3Ia+6QPzeeALqmQEgGZCZptsdQ7Qm90fO3xDobyMlroH0j12keo4DjmGCNMuY9o2LM8362A61UoaNR/uFrraHZt3djO5ykc8G+FvntoUrHqRmMRZX2AKY6WgZhaYVJbZGkf8TOm96bhNGewRL7opRyeB8T+VbxLsquEA9gUUaWUY1atptluiul4tftwC4uPthsautIX3pMWfGPRlN0PmUgav+20VBVrtBr3qsjVXgk0LztdDJEgOdfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(4326008)(33656002)(8936002)(7416002)(86362001)(83380400001)(110136005)(2906002)(478600001)(52536014)(76116006)(6506007)(53546011)(66946007)(55016002)(316002)(186003)(26005)(9686003)(7696005)(66556008)(66476007)(44832011)(64756008)(66446008)(5660300002)(8676002)(71200400001)(921003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: XPAW/yYcl8pKfYdg3BXgcdaYKpOh2y4BikxQtjjQ+M5kUEMn/UwopkLFFuhe0G5TxdOvUsGD+PrTyceHBXZWfbaMIk1oF2vuxBTkUNWK84QtOMfz0PYyQJbfxjsA8vS8MTv5l+nRqsmxSIGLyck5CmFFbVxWCrqc/am3N16/t1v0Ctzhxauh+PG55ogjzrvzWRVELbH0weXZvo+6fOjbG8rF2bhqhW/BMYXo0lpRos5Wha7Df2yx+QbY3+hob0YD1OVGU+mOZOqBMcbTwuk3mRu11MtcSX+OtpkUc0yYW9VvJCw2Dlsg2kADWsPLsp426eVe+UaJpI1IWKBispks1a7eexpfbHJk83WwltnowUs6YlT0Dn+bZ+9sBkFjC6YNKek5auuXnLoeXegCa4ZafesHHkSTNV0lF5dVGGGuaLJNbTHY2QdStLujY2MXLDJuJYPf+SdIHFs4a/PFQvcfO/zz3XRPh1M6vSebfbA37gyVyEYZ2aM7lEKDG3YB85TV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62630d33-97bf-47e4-570b-08d802392e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 12:26:28.5346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OeJpThftn0JpiOPInBU7bnvo5TqfS6Xc8GtB8lx4yDkhSMNxpyfGhAJdhadwqflCwWCzRaWy2OZhrTLD8N4Eiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3868
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbA0KDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIHRoZXJtYWw6IGlteDhtbTogQWRk
IGdldF90cmVuZCBvcHMNCj4gDQo+IEhpLCBEYW5pZWwNCj4gDQo+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gdGhlcm1hbDogaW14OG1tOiBBZGQgZ2V0X3RyZW5kIG9wcw0KPiA+DQo+ID4gT24gMjUv
MDUvMjAyMCAwNDo0NiwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gPiBIaSwgRGFuaWVsDQo+ID4N
Cj4gPiBbIC4uLiBdDQo+ID4NCj4gPiA+IEkgdHJpZWQgbW9kaWZ5aW5nIHRoZSBtaW4vbWF4IHRv
ICcyJyBpbiBjb29saW5nIG1hcCwgaXQgd29ya3MgdGhhdA0KPiA+ID4gd2hlbmV2ZXIgY29vbGlu
ZyBhY3Rpb24gaXMgbmVlZGVkLCB0aGUgbWF4IGNvb2xpbmcgYWN0aW9uIHdpbGwgYmUNCj4gPiA+
IGFwcGxpZWQuIEJ1dCBJIGFsc28gbm90aWNlZCBzb21lIGJlaGF2aW9ycyB3aGljaCBOT1QgYXMg
ZXhwZWN0ZWQ6DQo+ID4gPg0KDQpBZnRlciBsb29raW5nIGZ1cnRoZXIgaW50byB0aGUgbWluL21h
eCBzZXR0aW5nIGluIGNvb2xpbmcgbWFwLCBpdCBsb29rcyBsaWtlIE5PVA0Kc3VpdGFibGUgZm9y
IG91ciBpLk1YIHBsYXRmb3JtcywgYWx0aG91Z2ggT1BQIHRhYmxlIGlzIGRlZmluZWQgaW4gRFQs
IGJ1dCB0aGUgT1BQDQp0YWJsZSBpcyBhIGZ1bGwgbGlzdCBvZiBhbGwgYXZhaWxhYmxlIHNldCBw
b2ludHMsIGFuZCBjaGlwcyB3aXRoIGRpZmZlcmVudCBmdXNlIHNldHRpbmdzDQp3aWxsIE9OTFkg
ZW5hYmxlIHNvbWUgb2Ygc2V0IHBvaW50cyBpbiB0aGUgT1BQIHRhYmxlLCB0aGF0IGludHJvZHVj
ZXMgdGhlIHRyb3VibGUNCm9mIGNhbGN1bGF0aW5nIHRoZSBtYXggc3RhdGUgb2YgY3B1ZnJlcSBj
b29saW5nLCBmb3IgZXhhbXBsZSwgb24gaS5NWDhNTSwgdGhlcmUgYXJlDQozIHNldCBwb2ludHMg
ZGVmaW5lZCBpbiBPUFAgdGFibGUsIGJ1dCBpZiB0aGUgY2hpcCBpcyB3aXRoIHNwZWVkX2dyYWRp
bmcgZnVzZSBzZXQgdG8NCjEuNkdIeiwgdGhlbiBPTkxZIDEuMkdIei8xLjZHSHogYXJlIGF2YWls
YWJsZSBmb3IgY3B1ZnJlcSwgc28gdGhlIHJlYWwgbWF4IHN0YXRlDQpmb3IgY3B1ZnJlcSBjb29s
aW5nIGlzICcxJyBhY3R1YWxseSwgc28gaG93IGRvIEkgaGFuZGxlIHN1Y2ggc2NlbmFyaW8/DQoN
CklmIHRoZXJtYWxfem9uZV9iaW5kX2Nvb2xpbmdfZGV2aWNlKCkgY2FuIHN1cHBvcnQgcGFyc2lu
ZyBvdGhlciBtYWNybyBuZXcgZGVmaW5pdGlvbg0KbGlrZSAnVEhFUk1BTF9NQVhfU1RBVEUnIGlu
IERULCB0aGVuIGluIHRoZXJtYWxfY29yZS5jLCBpdCBjYW4gZ2V0IHJlYWwgbWF4IHN0YXRlIHZp
YQ0KY2Rldi0+b3BzLT5nZXRfbWF4X3N0YXRlKGNkZXYsICZtYXhfc3RhdGUpIGFuZCBzZXQgdG8g
bG93ZXIvdXBwZXIgc3RhdGUsIHRoYXQgd2lsbCBoZWxwDQphIGxvdCBmb3IgdGhlIGNhc2Ugb2Yg
b3VyIGkuTVggcGxhdGZvcm1zLiBEbyB5b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbj8NCg0KMTIyICAg
ICAgICAgICAgICAgICBvcHAtMTIwMDAwMDAwMCB7DQoxMjMgICAgICAgICAgICAgICAgICAgICAg
ICAgb3BwLWh6ID0gL2JpdHMvIDY0IDwxMjAwMDAwMDAwPjsNCjEyNCAgICAgICAgICAgICAgICAg
ICAgICAgICBvcHAtbWljcm92b2x0ID0gPDg1MDAwMD47DQoxMjUgICAgICAgICAgICAgICAgICAg
ICAgICAgb3BwLXN1cHBvcnRlZC1odyA9IDwweGU+LCA8MHg3PjsNCjEyNiAgICAgICAgICAgICAg
ICAgICAgICAgICBjbG9jay1sYXRlbmN5LW5zID0gPDE1MDAwMD47DQoxMjcgICAgICAgICAgICAg
ICAgICAgICAgICAgb3BwLXN1c3BlbmQ7DQoxMjggICAgICAgICAgICAgICAgIH07DQoxMjkNCjEz
MCAgICAgICAgICAgICAgICAgb3BwLTE2MDAwMDAwMDAgew0KMTMxICAgICAgICAgICAgICAgICAg
ICAgICAgIG9wcC1oeiA9IC9iaXRzLyA2NCA8MTYwMDAwMDAwMD47DQoxMzIgICAgICAgICAgICAg
ICAgICAgICAgICAgb3BwLW1pY3Jvdm9sdCA9IDw5MDAwMDA+Ow0KMTMzICAgICAgICAgICAgICAg
ICAgICAgICAgIG9wcC1zdXBwb3J0ZWQtaHcgPSA8MHhjPiwgPDB4Nz47DQoxMzQgICAgICAgICAg
ICAgICAgICAgICAgICAgY2xvY2stbGF0ZW5jeS1ucyA9IDwxNTAwMDA+Ow0KMTM1ICAgICAgICAg
ICAgICAgICAgICAgICAgIG9wcC1zdXNwZW5kOw0KMTM2ICAgICAgICAgICAgICAgICB9Ow0KMTM3
DQoxMzggICAgICAgICAgICAgICAgIG9wcC0xODAwMDAwMDAwIHsNCjEzOSAgICAgICAgICAgICAg
ICAgICAgICAgICBvcHAtaHogPSAvYml0cy8gNjQgPDE4MDAwMDAwMDA+Ow0KMTQwICAgICAgICAg
ICAgICAgICAgICAgICAgIG9wcC1taWNyb3ZvbHQgPSA8MTAwMDAwMD47DQoxNDEgICAgICAgICAg
ICAgICAgICAgICAgICAgb3BwLXN1cHBvcnRlZC1odyA9IDwweDg+LCA8MHgzPjsNCjE0MiAgICAg
ICAgICAgICAgICAgICAgICAgICBjbG9jay1sYXRlbmN5LW5zID0gPDE1MDAwMD47DQoxNDMgICAg
ICAgICAgICAgICAgICAgICAgICAgb3BwLXN1c3BlbmQ7DQoxNDQgICAgICAgICAgICAgICAgIH07
DQoNClRoYW5rcywNCkFuc29uDQo=
