Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D8046D315
	for <lists+linux-pm@lfdr.de>; Wed,  8 Dec 2021 13:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhLHMTI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Dec 2021 07:19:08 -0500
Received: from mail-os0jpn01on2096.outbound.protection.outlook.com ([40.107.113.96]:35749
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231674AbhLHMTI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Dec 2021 07:19:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJPKWJ9fss/PJBiJFPULlUpFoYbqR9thtM9ogOhavwN55FcT3zFsXU1fIkfXGutE0YLTkD/smHCmPnxBHN3PPYR76e2GKAMyZ6GJFC22ZgI0A7NZ2ZGECkVujF97J5LSHZn26mpuZ0CJ0Ov7ym7uzPim3qB4cCWioVOZUwCRyHqSullNHGGZurkFI8hLVQoMoR/WmZXaURISZRSSHTGIyi9519eCABVhq0wJk54eUIr+R8KIgOFIGnxz8rzdjgiPLUWYbpxyDg4WG/6xxyOQEf80sCm85HFof2Vqjjk+s5KeONCBkRFRTguD9VF8KwUTlg0JyJpQ7fHJtHZcu+smVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0ymylxovuQjgwpPAN/NXvSZpo9ai9+fQAiY3a+4yeM=;
 b=mzulzX5zVQr/VfUBcoQZQKryQYi6jjyTpEBn6/Du6YtlB6MsEQ3Sq+X6M+EpZHVl65Ax1bINwKiZUqaE0h4aaSdW3+0ipugykiqzAKIZrYzEr5hwQkNk03E5FD79SmRQznEcJ1WtHA9RWYm7Kvml0UVvIsv663bu+fJBuCijbDzTpU2wKE52Jv9R4BCwA2jCl3rtxc8KyO7paijQg+1LYUraEjL4p4t8fHhQ8sHFDncTwY96kFikFrggiUCDwqc7+Lqv9mt8alsn1LRHDYDcSVislpAxZYEEz/ZKwmRQ0AuY3ANopbm5ocBZ9YNTY8O3kunfkvo4fBaq6VRUMpPpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0ymylxovuQjgwpPAN/NXvSZpo9ai9+fQAiY3a+4yeM=;
 b=aHpUTF8uU25Xyl25q8OG4fXHSzM0sMl1Pbj2nDd9GvMSSPjSEgAmL8vCoGZtA/+uZr6lyFbYSlOft0/ERX7AsANPwtNtEwu52m+TJj/edpNInqahKhE0s/yls+jwFd/4/C0J6JzxuGDzQXUtFzBTJWQgJMd/nUclDTDVPzZGmvQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB2802.jpnprd01.prod.outlook.com (2603:1096:603:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Wed, 8 Dec
 2021 12:15:28 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c0bd:405a:cdd3:f153]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c0bd:405a:cdd3:f153%9]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 12:15:28 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] thermal/drivers: Add TSU driver for RZ/G2L
Thread-Topic: [PATCH v3 2/2] thermal/drivers: Add TSU driver for RZ/G2L
Thread-Index: AQHX5gMVkINytEYStU6OMtoTOn+sZqwoi2WAgAAB/aA=
Date:   Wed, 8 Dec 2021 12:15:28 +0000
Message-ID: <OS0PR01MB5922E8E8B654AD439277E140866F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20211130155757.17837-1-biju.das.jz@bp.renesas.com>
         <20211130155757.17837-3-biju.das.jz@bp.renesas.com>
 <d67ac4727317e84116e7d27ebd6af1ea4ed024a3.camel@pengutronix.de>
In-Reply-To: <d67ac4727317e84116e7d27ebd6af1ea4ed024a3.camel@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e18eef7e-904d-487c-84e1-08d9ba446c0b
x-ms-traffictypediagnostic: OSAPR01MB2802:EE_
x-microsoft-antispam-prvs: <OSAPR01MB28021276D4C8FFF830CF68CC866F9@OSAPR01MB2802.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PaCA5Cho4OngrEEt3FHwvi9SBTh2/okJYwNpdWG4iooqvLS6TlgRz1AzuZwDIVa3mDXbafvTuz3n+9siv3np7gbfUHXJeHL7iEF2OqEzZ9/hDcQsj7cPbxm2soMDIAFxt6C8paXdKFVwT+WA5WkOPhla8I33cqStQdOvEZNXf3inS/J4UhIFcgXRyQTzp7P8qVM6XArDDt1sa6xdU0vqUgfyPiUVnnRQ/ET97pcUwTa2CWsWNfsjLtYNg/li3g53i+OsR2eFhf/LQ3U20bOT3yft4VcoF7bXCH+POtf9NI2kfkZpoqgn1uh+/cjbqcb9jigpRa76O1XCGgWgswcIrqyWK3Bm5NhdpI0F1cbZCxDdgHayJqKZjew09qSlR0A/Ec3D6il8kQgh4ez5Smwf/Vp198UfEss69GjcXSJdazauTl13MogEVRFBKXRNGgg/dyD6UA6vqYnn4OBjlU6LJKaNRpL4YPaU/ToJfkgoLMWyB8bvaEsXLCgNKvfthaBbF1KMfOUVik4iuj7kOZJuvxzTo4tmXw6tteOExRA67vYtMa3vTaoFw6dlE+nmBT0D3qVwqVw3vLNKG7YV7FlKMyycQdLVfU6Iv7WJQr3JNiKer+F3TrqS/YbrZQjH2DrNeAjorm7sZo+HVsBDv7P/zYKwnUFO/GLZlsZrV/uhR/157olJKn/wj8U17iO5F23BefOY8J50wlKHFuKJUtMcXLT5mtvqFzCn4wEuimVCgV2wXOjDCXeDoz0c613uX6VM0UfPoivdIQM5ZTFt8DURSQKykmZp6jqImOK8FfZ29kA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(7696005)(38070700005)(4001150100001)(64756008)(2906002)(66556008)(66446008)(8936002)(86362001)(8676002)(66946007)(316002)(76116006)(122000001)(6506007)(6916009)(33656002)(9686003)(508600001)(71200400001)(55016003)(52536014)(966005)(4326008)(186003)(5660300002)(54906003)(38100700002)(83380400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWVJL1VOTVB4UFE1ZHJhTi9TODBWMW9ibStqODRRc2xZODlMVGtZZEZKNng2?=
 =?utf-8?B?ZDgvcmRuMmM1dW0vRXphQkllZW9RdE8vcCsxTGV6WWxHWUs0QUFPM3h0TjM2?=
 =?utf-8?B?QTU4T2hkdlpHSGpJNVY3dkVTeERacDAyczliVzVZQ0svM1F0QkwrRzR6eUhG?=
 =?utf-8?B?WlBGbncvUG5nL05QdXgvSDlWM0dQU0RzdGJUYlZ3Rk9DRTlEZ3hSZFhlQ0Vw?=
 =?utf-8?B?SmFQWjFIYnpjOU4rQzlsem9QaWxJYi9saXJBOElibFVPNkdTb0dyMEs0ZGs5?=
 =?utf-8?B?a25tdnA4cEtUdjRXbE1SUjJyd2FlYnFCOHJnbm5rU1hVZkZpS2piZEhBWmFo?=
 =?utf-8?B?VG5XenREc3ZPemh3RU16cUhCQzRxcEVSbmpOdG9OcStYQTlwVnl5SXA4SEsv?=
 =?utf-8?B?bmFnR05CTnQ5VG5zc3cwc1VKUGxwSmJ4U1dRUWlMeS9IRHNJNXdqbkZNRThN?=
 =?utf-8?B?b1J5M0luQ3JsZ3JFNmIzOE05TURQSnRJRy90bk5TOW0vV1dneDdlT253ekpv?=
 =?utf-8?B?VTdHOVN3UzRYSWhNNlNwVk9kSS9DMFNNS0VDeWFIUGlKMTV1RVdnYjNUdWR6?=
 =?utf-8?B?Ri9Ud2YzY1cxK0RnVGl0dmV3dzhHTUg1NzV3ZzZDTk5ETC9keG54cS8wdkFi?=
 =?utf-8?B?WkZwYTh0dS9GV0JDOW1heUhTb3d1TFJjN1Q4SENyLzQ4aGRETHphclFzaTBj?=
 =?utf-8?B?MHEvV0JMdnNWaFZITmNhNGh2V0tBMGpWTEg1V3dMd0VUK2N3RVYySU5ERERU?=
 =?utf-8?B?Yk1Ia3dTdmFQcDI1WDZaQ2kvdS9uWVBQL1JDcXMxc3RQVjkydUpZSnJBOUsv?=
 =?utf-8?B?RUp4Mkt0T2hNMG43VVFqRWl3SFk1QTJUaXg0STBvQmIwaktjTWlPZ2p1a1pS?=
 =?utf-8?B?NFdNQXVRK3ExeUl1amhMVC9iRmxQS0F1c21DRlRwZmx3Q2U3ekdWcktCZ0FP?=
 =?utf-8?B?Si9sbWcvRmVPSDRGM0FOcFdXcmwwRFlaeGQrSFFEd1BIVkw2aHNkY2lOeHFU?=
 =?utf-8?B?TGRQUUN1RlcwU3NmWVhlbU12YSs1V0twTmFjcUFjM0hsYjZNSXk5dG56eEdT?=
 =?utf-8?B?L2xyM1pFRkZLbWJscnBSMVRNM09ObEd6aTI5L1JkNVhSVFNkVnA3eFdZOTZ0?=
 =?utf-8?B?NTJyWWZDdGxSQlhjbWhMWUg3WTJsZWRHRWRvRVJ4RHg2Ri9Uempyc0UwSy95?=
 =?utf-8?B?ZHptTjFxVmVUZ3dmbm0wT1ZkWEpXT1c5U0RSeGQ0cmtxeW0xeGFuTmMwRktk?=
 =?utf-8?B?eEZQd0NoN052VzR0Yjhic3hpZDc1MjRUVVhCRG92WE0yVS9YNDRoRnJSbmRV?=
 =?utf-8?B?Z1JFU1FLR1g2bDA3eWdsNEFQd0lPOG0xR3ZpcitmNU1kK3FGNHgvQm9lRWdr?=
 =?utf-8?B?dlBRZTMvLzY3RzVlOGI2cTkwSWtXVUFCYTlNdjVlR0NtWXQxRzhWOHozQ1VW?=
 =?utf-8?B?c2lVZWtoRWl0ZDFVak1FVGVUSVVWQWJHa1JiTGRZcW5Ub2VtME42TlNuRU90?=
 =?utf-8?B?RTFhYnRaTDA2TmxrT2NSZ016blE1QU9iODluTk9la0QydU9UUCtvd1BUQ29D?=
 =?utf-8?B?R3ROVnQyMTc4Zkt6V296TzVmWG5TeUFJM2cxMnk5YjVBWmpBeC9uQTh6UW9y?=
 =?utf-8?B?aTljd2hXSU9saFkzQmlPQkc4NlA5YjdEVGN4cDMrSFV5QmwvbU5EWWd1a3Zi?=
 =?utf-8?B?ZkE4SnZvSmNxWG1GS1E1QlYxeHZVRWJZWVpMeWY3cXMwMXVYZlFHbXRBY3U0?=
 =?utf-8?B?OWcrMmZkNnRhY3lHNW5pODg2ZTFuSkxXUGs4cG1yRVVJbDB6M2FSbzdjcC9h?=
 =?utf-8?B?K3pwZkhsanZFMUU3OHhhUTByMzJTUk00c1JpOEoxNFhVYW9Zd3JOdlh3VmxG?=
 =?utf-8?B?eElKbmtuYXErYVhpOEZtS3YyRHlZQ0pvd3ZoNE9QbksweUhsVGxiRTk5NEZO?=
 =?utf-8?B?bDlqU3cwQS9rNmtyanVnQnVISWhueHhwNDZnWjJWbUJpMUI5WUtUZTBqbHVn?=
 =?utf-8?B?MWhnODNSci9GblY0cmZzSWN0d3FmOHNNWU9ISDRGSjdnQWtMaWUvdGJrOXRh?=
 =?utf-8?B?QlMzOWlUTHZoQlpIYlVjTERuTGIrQWp5UHNVV21HelFBWUw0V3RMeVlJcDdj?=
 =?utf-8?B?eVdwb3JUZmRnM0Rqa2NKSnpGMzBWNWQzTmdaSGJIZ0JIWmlWZkNZZ2dXK01O?=
 =?utf-8?B?VjZ3ZjdsRjdLdmNVRW04aHZQYWJjd0E3aEs1dHFqUmtSTVRnY2ZYWFVHWGdy?=
 =?utf-8?B?bGZIZGlzampMeWg1SllIS1FacnZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18eef7e-904d-487c-84e1-08d9ba446c0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 12:15:28.1438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8cFP0nA+9xu+FXwS47wtdkC9xQY/ipsXTVrExELTzSDruTgG8oIjxLM17hnPaXQRa92fqocwumIIhNR1/KHY9MRw2aYK7aoQEDf+lccFnkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2802
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgUGhpbGlwcCwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MyAyLzJdIHRoZXJtYWwvZHJpdmVyczogQWRkIFRTVSBkcml2ZXIgZm9yIFJaL0cy
TA0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IE9uIFR1ZSwgMjAyMS0xMS0zMCBhdCAxNTo1NyArMDAw
MCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gVGhlIFJaL0cyTCBTb0MgaW5jb3Jwb3JhdGVzIGEgdGhl
cm1hbCBzZW5zb3IgdW5pdCAoVFNVKSB0aGF0IG1lYXN1cmVzDQo+ID4gdGhlIHRlbXBlcmF0dXJl
IGluc2lkZSB0aGUgTFNJLg0KPiA+DQo+ID4gVGhlIHRoZXJtYWwgc2Vuc29yIGluIHRoaXMgdW5p
dCBtZWFzdXJlcyB0ZW1wZXJhdHVyZXMgaW4gdGhlIHJhbmdlDQo+ID4gZnJvbQ0KPiA+IOKIkjQw
IGRlZ3JlZSBDZWxzaXVzIHRvIDEyNSBkZWdyZWUgQ2Vsc2l1cyB3aXRoIGFuIGFjY3VyYWN5IG9m
IMKxM8KwQy4gVGhlDQo+ID4gVFNVIHJlcGVhdHMgbWVhc3VyZW1lbnQgYXQgMjAgbWljcm9zZWNv
bmRzIGludGVydmFscyBhbmQgYXV0b21hdGljYWxseQ0KPiA+IHVwZGF0ZXMgdGhlIHJlc3VsdHMg
b2YgbWVhc3VyZW1lbnQuDQo+ID4NCj4gPiBUaGUgVFNVIGhhcyBubyBpbnRlcnJ1cHRzIGFzIHdl
bGwgYXMgbm8gZXh0ZXJuYWwgcGlucy4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBUaGVybWFs
IFNlbnNvciBVbml0KFRTVSkgZHJpdmVyIGZvciBSWi9HMkwgU29DLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IFJldmll
d2VkLWJ5OiBMYWQgUHJhYmhha2FyIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNh
cy5jb20+DQo+ID4gLS0tDQo+IFsuLi5dDQo+ID4gK3N0YXRpYyBpbnQgcnpnMmxfdGhlcm1hbF9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSB7DQo+IFsuLi5dDQo+ID4gKwlwcml2
LT5yc3RjID0gZGV2bV9yZXNldF9jb250cm9sX2dldF9leGNsdXNpdmUoJnBkZXYtPmRldiwgTlVM
TCk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF5eXl5eXl5eXl4gQ291bGQgdXNlDQo+IGRldiBoZXJlLg0KPiANCj4gPiArCWlmIChJU19F
UlIocHJpdi0+cnN0YykpDQo+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJS
KHByaXYtPnJzdGMpLA0KPiA+ICsJCQkJICAgICAiZmFpbGVkIHRvIGdldCBjcGcgcmVzZXQiKTsN
Cj4gPiArDQo+ID4gKwlyZXNldF9jb250cm9sX2RlYXNzZXJ0KHByaXYtPnJzdGMpOw0KPiANCj4g
SSdkIHJldHVybiBpZiByZXNldF9jb250cm9sX2RlYXNzZXJ0KCkgdGhyb3dzIGFuIGVycm9yLiBF
aXRoZXIgd2F5LA0KDQpPSywgSSB3aWxsIHNlbmQgYW4gaW5jcmVtZW50YWwgcGF0Y2ggdG8gYWRk
cmVzcyB0aGUgYWJvdmUgMiBjb21tZW50cywgYXMgdGhpcyBwYXRjaCBpcyBhbHJlYWR5IGluIG5l
eHRbMV0NCg0KWzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L25leHQvbGludXgtbmV4dC5naXQvY29tbWl0Lz9oPW5leHQtMjAyMTEyMDgmaWQ9NjczYzY4
YmQ0ODM5MGRhZDAxZjdkMTc2NzBkZTNlMzNiNjA4NjBhYw0KDQpSZWdhcmRzLA0KQmlqdQ0KDQo+
IA0KPiBSZXZpZXdlZC1ieTogUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT4N
Cj4gDQo+IHJlZ2FyZHMNCj4gUGhpbGlwcA0K
