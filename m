Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6682DB973
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 03:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgLPCxj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Dec 2020 21:53:39 -0500
Received: from mail-eopbgr1400110.outbound.protection.outlook.com ([40.107.140.110]:36032
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbgLPCxj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Dec 2020 21:53:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OY6fy3QQMyf+ZmiSOEpLYxioPVLHobq1tZpRT5raW3vFdTt3m1dp4CRRK0t0THOM+iV8FT816cOzi7x3bqhaB5H2/eRSE3MrmaoU7612nut77UP01yI9jV7aPFCLzB02C8gxZAEzfKp5WTWgHSx6o0h2TTbHOuLl61MdohAbQJPUafCGc6zAE5yvmF4uOTtAlcHC/F3a0IXEZqpw2rkRRbKn80QcfQk2LaLFR5k/WilzubujmPR5T9bhtO7RGrqmN53nmGpzDWbPM7QOTWfaLLDtjsAj/zcBSsFEGRLD7we4Qf07WQ/e5m2tZAOmf0tHVbaimtMgG3UJfv5/NaAZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHFlDDoB/JLOzBJq525GWpiakbf14KN8r8YCtvWCRVY=;
 b=ZgUdMQTLZ64yigIzQ+78+7jrMOAwVg7ennJvr2TzneYPNCxpS2wfojnYdsWRNI8oZG18Yf/LK2U/NdTGlW7nWXqtEVHZ3Yn6s72ZZ5/c/YJF66o05fH7xJCGAOmRZp4l9pb45fj/+Lhe8TqtrHChFYhr5u8c7K340XM9sLFsD0FXN+0gOf945FbHS4XMtSiAXlyAndTcxhIF6/YvacfEbk5gZZV83Yaqz1f1XJ0cP1k0o9uyAJTxLUdlt5LiHrEIqtGtye9t7oEskpe2/ZvXhGef65f5HHlvZzt5ra6uLktOHWwFbcEjzDCg2c8K6D7mm9SFLJXIDOsJrL8y0uvhaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHFlDDoB/JLOzBJq525GWpiakbf14KN8r8YCtvWCRVY=;
 b=HxJhqvQUcmWxbYQ7fpi0178t2dePtn/UHjok9Z21zoB0yFShINSIjRoqROsed4XlFRGphzy5v3QpKs1wivsSExgsbhL0NhFUnreM/9G6eSekWOTfeZ7rxqKdirEwu3Pge3cUbHza5iBQS30CzOVWCMTpfpZDZLe7d8/T3Ni0zts=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TYXPR01MB1550.jpnprd01.prod.outlook.com (2603:1096:403:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.20; Wed, 16 Dec
 2020 02:52:50 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::2023:7ed1:37c3:8037]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::2023:7ed1:37c3:8037%5]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 02:52:50 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     =?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: thermal: rcar-gen3-thermal: Add r8a779a0
 support
Thread-Topic: [PATCH 1/3] dt-bindings: thermal: rcar-gen3-thermal: Add
 r8a779a0 support
Thread-Index: AQHWxEPRDKDBRM9kGE2clyfRQ2Ts/qn5IexQ
Date:   Wed, 16 Dec 2020 02:52:49 +0000
Message-ID: <TY2PR01MB36920FA5AC2EF98CD6BB08B5D8C50@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20201126223028.3119044-1-niklas.soderlund+renesas@ragnatech.se>
 <20201126223028.3119044-2-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20201126223028.3119044-2-niklas.soderlund+renesas@ragnatech.se>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ragnatech.se; dkim=none (message not signed)
 header.d=none;ragnatech.se; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [240f:60:5f3e:1:68c8:85be:c13a:922b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ccac2bc6-ac7d-4d22-d124-08d8a16dad11
x-ms-traffictypediagnostic: TYXPR01MB1550:
x-microsoft-antispam-prvs: <TYXPR01MB1550CAC34163A113731E2D8FD8C50@TYXPR01MB1550.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0pjNnVLyqx1YXWf8CYWNXjSiJ1I1wVEFgVXPr8pnPfFcKSamK2xwNSrHql9tUeuqLteaEfa/+VN7RguGfcayNO52ig2vsHc8QsoFfhAW5lAVB7eAYjTm0ScepTbiCU/twfHrLIPcyUyZmVwWonLZptGSQFoyi6VQf6WKcOJAmUV9IH0MyxLtD51MH1KFVVZ+u+InXVOM2v8/KYa1G7kE4480fukcAiMID+TgbdVnGr5iWXe0yBN9dTaYe1enSETk0Gxz3bYZVxlHXLdPfeZKH+JaY66rFPv0vLUptr8ZjtabQl+Sf9ImJRYb33cQltAl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(316002)(83380400001)(478600001)(186003)(2906002)(86362001)(7696005)(6506007)(4744005)(4326008)(66446008)(66574015)(8676002)(66556008)(110136005)(64756008)(55016002)(9686003)(66476007)(76116006)(71200400001)(52536014)(8936002)(66946007)(5660300002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YWIyeStoTEFmanBjNzdoUmlNSzdMRTJ6ak02c08rOUdpNGpKeE9EYStlQ0FM?=
 =?utf-8?B?UlZFWkZESzA5cFVnNWFpRVc2QnhTRlQzbTZ3ejh1OGJESXNBem4zM0pJQndD?=
 =?utf-8?B?dzVLQVpqOElkMC9xR0RPL1B3UmJVR2tseS9hNDFxcEd6L2loNitaUkdJZzYx?=
 =?utf-8?B?VitYRjcyRVhJZ2dEMytuUGJ2aC9vOVJGbmdrWTNXYWYwbXAwNG1Ralhmcncz?=
 =?utf-8?B?ak44N3lsK1lnMHBLNUZiRmwvYzdZRmJ5N2lRVktremVDZ2hsRVFaL1A2RHlD?=
 =?utf-8?B?Z0xQNlhjd0Z2UGlPOEJKSFBCV2FKc01LZThHQmFrbnJOdktHL3E4QXVBdUlG?=
 =?utf-8?B?Nll1OUZXQzAvMDh1VktYSlFUQXVkanZ3MUNLbkNFOWk5bXRGT2xidVo5S01k?=
 =?utf-8?B?anpjVEVNTDRMQmQvWVhENGxNV3VQbjQzVUVZelU2N0cvK1I1SnROdWFuVlNV?=
 =?utf-8?B?ajZUOWUybytDZzNXbHdkNWhBenIyZjcvaXNYT21IdHY1N1pDdXdhRm53dG1X?=
 =?utf-8?B?Qlhsbm9KTWdnNTFmT3hqdGRNVlRWRWd1WFJkMC9MMUk2MWpqQ3lUVUdSM2RX?=
 =?utf-8?B?WnBLekZGR0dJK3dXWW05MjBjVnhJcTNLQnhnUE16V1dzNkptZDNKOEFIOU5N?=
 =?utf-8?B?aktlYy9SNEk4YU8xbzlVS1NVbWdjWVBqSkJla29hN2Vkd0wrUlNLTGc5WVh4?=
 =?utf-8?B?cTJxMjFoaHZOMlRaZVpzaVhtSkd2ZG9FRlZaWlBhZUFPTGkrdVVLWStmRito?=
 =?utf-8?B?UHBlWFd3L1pYZ1Z1ZHNwRG9LSU9BS3Zqb3BLTzVHeVkrM1NxNTBYckNaS3g1?=
 =?utf-8?B?VkhSeTJReFFKN1BwbVNyRlFlZDNkQitGZE1jZzBQUDVrWHhEdjNCc1JVeGlK?=
 =?utf-8?B?QVZyTmtOemkzU28yVjA2cDRvNFh2alM1cHVtQXkxN3RRZzNPMnphOE8vVEUy?=
 =?utf-8?B?Y096UmUrNWJrcDFDS2FocnJNM0FYWFg0VU1HNGdrZHlTZkE0b3JXQ01La3k4?=
 =?utf-8?B?OWFaYTNkMEp5Q0dZWmZBcnFseUhiT2wzNHZoU01vTGlqVFlzVjVIUmRRK2tG?=
 =?utf-8?B?OVZHeGhNVTNMeVVsVUl3dFgvZWxOc1FoTnM5UlJoTEkzaWFTMmpkU3VBUUQ1?=
 =?utf-8?B?dWV0ZVE5dHZweG83MjJod0QyZ1YwM2JvQVJXd09qZVhXSHVnUEtxaDUvbHJJ?=
 =?utf-8?B?MUtVK1g2T2FLbU41SHNoZ0U5SWFwcGJSZjMwSUoyeC9DcDcyYzE1VDN0dkp1?=
 =?utf-8?B?dXBPZklCYVlDY3VNWWNXUDB1UkJpMHM4U05nVkV5R3BBZmNJNnNmcm9RRnNu?=
 =?utf-8?B?WktidXNHenFEaFNmWGxMTWdaL3kxK2ttZkYwa05ZL3pBbStTV1pKa3Ixa2FG?=
 =?utf-8?Q?EP62B0MWAVmCG3kGrlCukkggCgRB7ShU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccac2bc6-ac7d-4d22-d124-08d8a16dad11
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 02:52:49.8109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oRFtSC3C6URFUKgUU6ZAZnuwtIX/Gv5YTBkcuxpPiyNRQPLM2HTF5BRAKJoKiYcYNAhg7yaTwYUHj+TxWOKFgb2k9niSKh2XFELhBPQZFuw+GVeeNb4UEAZsTP6hbYrQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1550
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgTmlrbGFzLXNhbiwNCg0KVGhhbmsgeW91IGZvciB0aGUgcGF0Y2ghDQoNCj4gRnJvbTogTmlr
bGFzIFPDtmRlcmx1bmQsIFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMjcsIDIwMjAgNzozMCBBTQ0K
PiANCj4gQWRkIHN1cHBvcnQgZm9yIFItQ2FyIFYzVS4gVGhlIFYzVSBJUCBkaWZmZXJzIGEgYml0
IGZyb20gaXRzIHNpYmxpbmdzIGluDQo+IHN1Y2ggd2F5IHRoYXQgaXQgaGF2ZSA0IFRTQyBub2Rl
cyBhbmQgdGhlIGludGVycnVwdHMgYXJlIG5vdCByb3V0ZWQgdG8NCg0KQWNjb3JkaW5nIHRvIHRo
ZSBkYXRhc2hlZXQsIFYzVSBoYXMgNSBUU0Mgbm9kZXMuIEFuZCwgbmFtaW5nIG9yZGVyIGRpZmZl
cnMNCmJldHdlZW4gVjNVIGFuZCBvdGhlciBTb0NzLg0KIC0gVjNVOiBUU0MwIHRvIFRTQzQNCiAt
IG90aGVyIFNvQ3M6IFRTQzEgdG8gVFNDMiBvciAzDQoNClNvLCBwZXJoYXBzLCB3ZSBuZWVkIHRv
IG1vZGlmeSAiaXRlbXMiIG9mICJyZWciIHNvbWVob3cuDQoNCkJlc3QgcmVnYXJkcywNCllvc2hp
aGlybyBTaGltb2RhDQoNCg==
