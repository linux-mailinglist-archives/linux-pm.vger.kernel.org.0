Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB41A209D91
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 13:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404293AbgFYLeV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 07:34:21 -0400
Received: from mail-eopbgr1320138.outbound.protection.outlook.com ([40.107.132.138]:8800
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404239AbgFYLeV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Jun 2020 07:34:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgiGAhRDFvIoo2y6d9UQOpwHEOncSajCcwe5/4dovzbGZFzJc0NFeJDGn74rAhXv08pa70YRJWc9QAEODiIG2U56+3GDx9IG//vxsotF+2xqST9byz0I6jQgmO2nkxlbd3LGzEIM4qqxcGakhPFB3EDW6J281MNGpRWF8MESvXr6W2MsbGWYhHoNLONXhAVC0AiOTCeGhcZlqnaFCKzKvGYf0MiLa6bwG9VjzcbqjtRWdRXbmleKtv85V0ZhfJxj1iNUPCZBF1uwmwg8bS89+icPIoQbuALngvgv1Pdx3XeEl/13o6ZVXq1Pf7XY5NwldwVVmEHFwoLvmoVFkIgP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0/0UvnsL67ncjdCFuKgWmvyJix4LtHHuV1ma/s4VBo=;
 b=b3brZ8yRkYJJ8hVeFPJ0jpQAjnjYX7pyDo00GCZ4eePjUWORrV/GgsNhlgfVZIunZV/MxwbNX8H8i6UBjrT+YoQm6Gzy6kvN2XA7OtElPyHiApC+yQnH3TsMD6w1hnqHWwdiYNGYpL8ak/i0+CY8MBocUNLK1o+VfEcmeOavAP7LMmwKYisDIw4/QztkrwDZikG+/G+i8+0lM4nRRa1m2btbabOYcH+1sO42efjv7zxSnyENaPvU62USFml+VNdALNx1hX96kxfjo52FMsKGLM4rY2u+hpHbtP7s36ma6emUCkkH7+0NO+M6/rq2SxKGy3LOsRpEifqSfx0tR1Gc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0/0UvnsL67ncjdCFuKgWmvyJix4LtHHuV1ma/s4VBo=;
 b=opKa9FEOIiN1ewXMElyTeCjllBKZyN2OzWtLTOSzE4ov5RqsB5ZmRE5Qgjlf8dduGKTtI0IFHhRpioZ/X7AAFPCayKmNywI5iSfIz+t0yxgjBrQqCRbH9/L3Ppa+lnCer+tFlDLWKiSpZo5o52+4nZrVJWJQmdaqC/0v9k2kiAA=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB3290.jpnprd01.prod.outlook.com (2603:1096:404:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Thu, 25 Jun
 2020 11:34:16 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3%6]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 11:34:16 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>
CC:     "niklas.soderlund+renesas@ragnatech.se" 
        <niklas.soderlund+renesas@ragnatech.se>,
        Van Do <van.do.xw@renesas.com>,
        Dien Pham <dien.pham.ry@renesas.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3] thermal: rcar_gen3_thermal: Fix undefined temperature
 if negative
Thread-Topic: [PATCH v3] thermal: rcar_gen3_thermal: Fix undefined temperature
 if negative
Thread-Index: AQHWSpw39QjzWq9LJEeQfL0+FtB5WajpCDcAgAArcNA=
Date:   Thu, 25 Jun 2020 11:34:15 +0000
Message-ID: <TY2PR01MB3692CC45140FF53CACD097BBD8920@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <1593053768-31016-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <db9e3bd3-d3f0-61d2-7ffe-3306003f57d8@cogentembedded.com>
In-Reply-To: <db9e3bd3-d3f0-61d2-7ffe-3306003f57d8@cogentembedded.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cogentembedded.com; dkim=none (message not signed)
 header.d=none;cogentembedded.com; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f63b306-889f-431c-40ce-08d818fbb132
x-ms-traffictypediagnostic: TY2PR01MB3290:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB32903B772A8363E3EECEA63ED8920@TY2PR01MB3290.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0445A82F82
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cmDSpDQ7UoQDddDjhAyszY6JjlsFiN9tGP3PMPk+zxOp0JQ/Cr3OMxXUhJHa30p4UAIt44lmuybwr7814lwXw5TaxzENA4MUK55wNzTC945E4BN1HVGLNu36EOtWPHr4RoZp56zltrmHormVrYZBrCZGO9kLPX9L/0HZM3l43lRdhw7MwLkfgkj0SeYYF/Bgip8Ux27zUIjTxMXfUwAuSWBNtqhP8PG0B3+BQrYiKbyL0f3b9zuLsSner88AdTqzJu0BvJ1NvZMIoCyMeZ4zGpF0xwTT2+/haoNGxXLCwWhw+22FPTfjVAPQTsJphg5Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(9686003)(76116006)(7696005)(66446008)(64756008)(86362001)(110136005)(66476007)(478600001)(83380400001)(66556008)(5660300002)(54906003)(316002)(8936002)(55236004)(55016002)(26005)(6506007)(186003)(4326008)(71200400001)(66946007)(8676002)(2906002)(4744005)(52536014)(33656002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MgBq+rtpD+TLa7P1HCbJaLX2QszxWYwSmI/pZ1N9fcHTg51fSvMR3RdhCuUxgvsLAz2zNOHo49aXQNcC1dnBUhi5baS5HZJutQdPl1hbD6RJZ4YfIYaradjA1aGMpGibyraq0VWYxmjW1pPZFE0snMZSDrv9tjuLvSx8Rn/UH2oRp2obnZpPPFURfsEq48d/cgAZRRhiphacdBWQr6nF8MEiBMvK2TkEgd61KvsVhOItgRAi+m2ZguHJXrREvEthKw1FX7tuCqsyEiVZ/Zy5UMgzaexhSqYXk+aDdYH78hRSUB5prB4Un4QoAlzJgtFAmOkCH37+vFi8fHNaNndD2sdtvEwor/0TYqcBTQN1MK/Pv9LHw7hiYNjMJeUeUb7kGyY7bJKAAdEHYdp0U7OjbaT6r9Wx19B/E2JqAfwyJrjp2L4VULbNbWfumtYVebW/dLkl1n2C+pQ+hxJuI82uPqrYf2B2/28BEXrRGrUStY5y3c7eyXXItXAUf0dMD4pm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f63b306-889f-431c-40ce-08d818fbb132
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2020 11:34:16.0264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zDajThmS+go6jiuLoMMNimnFPlLILFZeQxXIFiWod6S8vaHbEem05MIZ9PxZnMAyhAQb3RmJPpd4g1a2w832bDmsNAO33KS1F3CIZYlfb498sMyhDq//+o1k2GzH+FHt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3290
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGVsbG8hDQoNCj4gRnJvbTogU2VyZ2VpIFNodHlseW92LCBTZW50OiBUaHVyc2RheSwgSnVuZSAy
NSwgMjAyMCA1OjU4IFBNDQo+IA0KPiBIZWxsbyENCj4gDQo+IE9uIDI1LjA2LjIwMjAgNTo1Niwg
WW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+IA0KPiA+IEZyb206IERpZW4gUGhhbSA8ZGllbi5w
aGFtLnJ5QHJlbmVzYXMuY29tPg0KPiA+DQo+ID4gQXMgZGVzY3JpcHRpb24gZm9yIERJVl9ST1VO
RF9DTE9TRVNUIGluIGZpbGUgaW5jbHVkZS9saW51eC9rZXJuZWwuaC4NCj4gPiAgICAiUmVzdWx0
IGlzIHVuZGVmaW5lZCBmb3IgbmVnYXRpdmUgZGl2aXNvcnMgaWYgdGhlIGRpdmlkZW5kIHZhcmlh
YmxlDQo+ID4gICAgIHR5cGUgaXMgdW5zaWduZWQgYW5kIGZvciBuZWdhdGl2ZSBkaXZpZGVuZHMg
aWYgdGhlIGRpdmlzb3IgdmFyaWFibGUNCj4gPiAgICAgdHlwZSBpcyB1bnNpZ25lZC4iDQo+ID4N
Cj4gPiBJbiBjdXJyZW50IGNvZGUsIHRoZSBGSVhQVF9ESVYgdXNlcyBESVZfUk9VTkRfQ0xPU0VT
VCBidXQgaGFzIG5vdA0KPiA+IGNoZWNrZWQgc2lnbiBvZiBkaXZpc29yIGJlZm9yZSB1c2luZy4g
SXQgbWFrZXMgdW5kZWZpbmVkIHRlbXBlcmF0dXJlDQo+ID4gdmFsdWUgaW4gY2FzZSB0aGUgdmFs
dWUgaXMgbmVnYXRpdmUuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGZpeGVzIHRvIHNhdGlzZnkgRElW
X1JPVU5EX0NMT1NFU1QgZGVzY3JpcHRpb24NCj4gPiBhbmQgZml4IGJ1ZyB0b28uIE5vdGUgdGhh
dCB0aGUgdmFyaWFibGUgbmFtZSAicmVnIiBpcyBub3QgZ29vZA0KPiA+IGJlY2F1c2UgaXQgc2hv
dWxkIGJlIHRoZSBzYW1lIHR5cGUgYXMgcmNhcl9nZW4zX3RoZXJtYWxfcmVhZCgpLg0KPiA+IEhv
d2V2ZXIsIHRoZXJlIGlzIGJldHRlciB0byByZW5hbWUgaXQgaW4gYSBmdXJ0aGVyIHBhdGNoIGFz
DQo+IA0KPiAgICAgSXQncyBiZXR0ZXIuDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXchIEkn
bGwgZml4IGl0Lg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo=
