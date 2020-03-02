Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 790E717567C
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 10:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgCBJBB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 04:01:01 -0500
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:35010
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726313AbgCBJBB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Mar 2020 04:01:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYAulKD/BQdaV0qHyGakbwj8i4Sp0lEx9zU1pcvQzGjry+G2KB06OVr+/PmwoPSG0ZR/KUr08reSsFOr2cgArTg0UW5yBE42EHkIM3/oxnJ7JVFrTsFdSqfkzJ+K10YGDHtsu9L9rolBIA+qxy141vo1AHrVS6c2Rn4X5JefPXsXS+LCHZHQS9x75s1mV8hBe0ZMIW29MzBEFWb+j0mq4fAnBuqb1f5OlDaPY362DplP//sFMf4oKm9FnF7nXi9r95QrAoFmB+ndFPYQgHXnJAAZZ+0B0+f3bFQoCGzw7U1Ydzfns6+PBV8llUpwWsOBstP/ZJ2gJso1jMNanikydQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLrz6EsHgr54oA/cMoc474o7ePAtWXLpndimx86aork=;
 b=PeSwiQzjroGoLLpGUcPFcA6X9BFk8f8c99UfLpmou8S7sGKksfCg5S3s02zAgbYCdWUsSeKblGvHZSXLiHN264HutYhW20pkQA7GaonMXmIcmDBfsevyj6n5PqTYAwocVcTyVDTJjIiZrT3UMjvoWTVBKayaA8Ikla1MFwn9MUuJ6SyJjheu0M9K+BUPjRS2I7zhZsR73MfEPKuej22X4YdXa14JorPF9Xvg4bG0MmTCmZg1doo/BCkisVHwZGftBVwrv3aZc7BkBKwHQ1g+4rpJ0l+Uj9/rfqV+NfseVawP3R33p7F6Zz77hLVWT6NZ2BnZdxYC/jOVsU3oM01f3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLrz6EsHgr54oA/cMoc474o7ePAtWXLpndimx86aork=;
 b=Fn1+PYpxpTSVa8szXmKC8XsZ89uIGT+A4yHTqrKhHxoAjzTCYpGDC4zywq56IJn+e4wQXVIVHh/brPmbY+X6TGjeJ4iJxS6ryGTvYB8FAUPyXraVyFn4+Do3M7ELThWimZ5bIAJzf+0Pyv5cf6aB4KV+uobeMtbIJzC3lEci1vc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3820.eurprd04.prod.outlook.com (52.134.65.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.16; Mon, 2 Mar 2020 09:00:56 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 09:00:56 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] thermal: imx_thermal: Use __maybe_unused instead of
 CONFIG_PM_SLEEP
Thread-Topic: [PATCH V2] thermal: imx_thermal: Use __maybe_unused instead of
 CONFIG_PM_SLEEP
Thread-Index: AQHV8GgP/M8Ol/PK50WikUZ0uCvNYqg08kkAgAAFMJCAAAgaAIAAAaMw
Date:   Mon, 2 Mar 2020 09:00:56 +0000
Message-ID: <DB3PR0402MB3916B0641DB884CD3DA63754F5E70@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1583135410-7496-1-git-send-email-Anson.Huang@nxp.com>
 <20200302080700.ubnboqklhbva7bas@pengutronix.de>
 <DB3PR0402MB3916DC28A21BE0B9B8BFFC25F5E70@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <c5ecab57-cc38-762c-ae06-fed0433e0246@linaro.org>
In-Reply-To: <c5ecab57-cc38-762c-ae06-fed0433e0246@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d867fcb-189c-47be-610b-08d7be88387d
x-ms-traffictypediagnostic: DB3PR0402MB3820:|DB3PR0402MB3820:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38200436F811AD86FC6303DBF5E70@DB3PR0402MB3820.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(189003)(199004)(66946007)(66476007)(52536014)(4326008)(66556008)(64756008)(66446008)(86362001)(2906002)(7416002)(76116006)(33656002)(55016002)(71200400001)(9686003)(478600001)(5660300002)(8676002)(7696005)(53546011)(54906003)(81166006)(8936002)(81156014)(44832011)(6506007)(316002)(26005)(110136005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3820;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DJBpp1vDY2sNjVwkiCgxiTiTAieCALcnh166VsWdCiqs7vZYn3UDbPGbuhZpthSq0B8ItiRUgD9DcfJFZx3ZhCxTXRqVPHE4v0oseAwe6LxJLpOhivl5+4ScoDtpyHl2J/11HnEgBvNES6aBQix6pphQCCPDEgZs0Qe81pwVeqR8vpLOpS37GgVfFFldinnoj26wO7l4D8Kj/gBQaNO5ChhruWDI6UZb58bpblqXL67MUG9/kaGqMtHxozDyk2inYlDhYO7iTG8et4kspXLJbI711UQRHb874coD0b4ZAb24Le5uWIQ9O3oKrZXQjLSfn5iWB3Ril+2j9OEt9olZSgv9TAHUbelZby3Sxf4osBRQYJEOuYtVHKznC3osSsf7QqkKjcjM2d4jes/FAOqSlvtt4cDEvjiE1KASMYGwBR44Ys+ATsPAWdAWQXw70vKr
x-ms-exchange-antispam-messagedata: c+J2EbzReSd+y4GmrOTBJcTQ/9gQ/5u3uPqVv+S1CEChX4Obrz+6jR2H/o8fRJYaUfvpGyLXJHn6YpQE87p+xWFeJMlgJuq6GMR/zTEoU8YZVbPt+kbeWNIeyYgXtkvMUJ9on+6SAtVD46Jxxc42iA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d867fcb-189c-47be-610b-08d7be88387d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 09:00:56.6876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZ+3IdOyS6CyBN12yZVZllq6EjrJI+MWWKegFthFeTUJ0xACcwe8pu/ypSvmI619MaS2jNNnzBknE+rG5QHoBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3820
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMl0gdGhlcm1hbDogaW14X3RoZXJtYWw6IFVzZSBf
X21heWJlX3VudXNlZCBpbnN0ZWFkDQo+IG9mIENPTkZJR19QTV9TTEVFUA0KPiANCj4gT24gMDIv
MDMvMjAyMCAwOToyNiwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gSGksIFV3ZQ0KPiA+DQo+ID4N
Cj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMl0gdGhlcm1hbDogaW14X3RoZXJtYWw6IFVzZSBf
X21heWJlX3VudXNlZA0KPiA+PiBpbnN0ZWFkIG9mIENPTkZJR19QTV9TTEVFUA0KPiA+Pg0KPiA+
PiBPbiBNb24sIE1hciAwMiwgMjAyMCBhdCAwMzo1MDoxMFBNICswODAwLCBBbnNvbiBIdWFuZyB3
cm90ZToNCj4gPj4+IFVzZSBfX21heWJlX3VudXNlZCBmb3IgcG93ZXIgbWFuYWdlbWVudCByZWxh
dGVkIGZ1bmN0aW9ucyBpbnN0ZWFkDQo+IG9mDQo+ID4+PiAjaWYgQ09ORklHX1BNX1NMRUVQIHRv
IHNpbXBsaWZ5IHRoZSBjb2RlLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1
YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+Pj4gUmV2aWV3ZWQtYnk6IFV3ZSBLbGVpbmUt
S8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+DQo+ID4+DQo+ID4+IElNSE8g
dHJhbnNsYXRpbmcgbXkgIm90aGVyd2lzZSBsb29rcyBmaW5lIiBpbiBhICJSZXZpZXdlZC1ieSIg
aXMgYSBiaXQNCj4gYm9sZC4NCj4gPj4gUGxlYXNlIGRvbid0IGFzc3VtZSB0aGlzLg0KPiA+DQo+
ID4gT0ssIHdpbGwga2VlcCBpdCBpbiBtaW5kIG5leHQgdGltZSwgdGhhbmtzLg0KPiANCj4gV2hl
biBhcHBseWluZyBhIHBhdGNoLCBub3cgd2UgYWRkIHRoZSBsaW5rIHRvIHRoZSBsa21sIGFyY2hp
dmUgYXV0b21hdGljYWxseS4NCj4gSSBjYW4ndCBhcHBseSB0aGlzIHBhdGNoIGlmIHRoZSBSZXZp
ZXdlZC1ieSBpcyBub3QgYWNjZXB0ZWQuDQo+IA0KPiBPciB0aGUgUmV2aWV3ZWQtYnkgdGFnIGlz
IGNvbmZpcm1lZCBvciBhIFYzIHdpdGhvdXQgdGhlIFJldmlld2VkLWJ5IG11c3QNCj4gYmUgcmVz
ZW50Lg0KDQpJIGp1c3Qgc2VudCBhIFYzIHBhdGNoIHRvIGRyb3AgdGhlIHJldmlld2VkLWJ5IHRh
ZywgdGhhbmtzLg0KDQpBbnNvbg0K
