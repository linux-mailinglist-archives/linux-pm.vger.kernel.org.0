Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A687E1DACD5
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 10:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgETIEH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 04:04:07 -0400
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:48546
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbgETIEG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 May 2020 04:04:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqLs0R8aHFD0Z+Qp2p0lij3Keg0ABREXz/faUS4y9a/WqSXNPfqkc0JILTt3+xKzcr2SK2nMmyHXjbuh4pcbZgOWOj1//T0cGqm/mGFUwtOcPpGppdkXH2AYCto3zZC6rSZ8X16n8tDODrc6pxmbV2Wbynx1i9Yu0pPaPhONcUcGt7qHTXx1FAsiKo+T5Z91JkfY0twdwIoyD+wkj8wvqVk546JNGmuJvAbC2Tb5SWdBzB9UEpGavOD8Tx4uRvhLQHUHLHucr2ZuDjq8nvTfZjtlVqY0f60/I9y/kH+7m4dtPu7X5S2wEIUKF/PEgT8Sp4rurK2C4tt/bhOGKeiMfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djm4ykrzIh685Ihgr1jovCY6GBt92z40W4Z1dgXLTA0=;
 b=DNlatJ/6PlPXvj5dIepaEHBWIAWm/21kxWqtCVTkBHJvxnTOm8dU4qbwhpSAGerrYAbSLnlaK8IhjbvJNFc2nIpKFuaUgAcLCyeMQiXa18h4/AezSa4FC+S1KqSdPgc51N8Im1MiINcAoougymlmR/0AkoF63VrfUOnv3sJbIY1HOTRPECANquBMxufjzH8HWNL85KHUVHFrWI5j+W7PVPQyaWqjkQhOzPa/q5euAQYR0cKkpmaVgabfrhtfDqd7PF7S2ffMJZyDqaZXMzZxGspjBufhbVMRwHqLpRzPxt8IqF017Czy27XkOVy21/hSm76h8pksMjaouf3m2kGyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djm4ykrzIh685Ihgr1jovCY6GBt92z40W4Z1dgXLTA0=;
 b=ldprSHueqUk82/1HnNWzTkQQfEYCZe+npYvPEqA0IaoQKx6lzNpHvovF7r4ZAcPJt9YY0BENFussw1vNH8SQClsWUidGbntzwHJ6bmKClRMunT667LwogrhbfGvoB2YoXCwDZru57Bf8kkRGpWW0pYfP8jQ1ryUNUsZgVRzIXQ0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3915.eurprd04.prod.outlook.com (2603:10a6:8:e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Wed, 20 May
 2020 08:03:57 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 08:03:57 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
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
Thread-Index: AQHWLm2mA+HT3r0LW0SOVkVMMBmKlqiwl6oAgAAEz2A=
Date:   Wed, 20 May 2020 08:03:57 +0000
Message-ID: <DB3PR0402MB3916B45468AD8B69D6F318FDF5B60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1589954560-10810-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB4966F875F2E04D0F6FC3AE3A80B60@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4966F875F2E04D0F6FC3AE3A80B60@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 648a8d58-57b9-45a8-d64d-08d7fc945918
x-ms-traffictypediagnostic: DB3PR0402MB3915:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3915AF9944B3370F89F6DE21F5B60@DB3PR0402MB3915.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:586;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VaI6P/am5P3RPjFyDIiPyHD9nOBDHcVz7/QXIyzJvCWUXW/FNmndzvYF6k72GN0jVKYen+HepSobEzllurSaAJsbMP9AoFTETNR5vauqYZgCn8Sklkul+P5KegI2Tdj66o1g9rvkrmpnjWVQReDiTGqOZ3UjgJVURi4bpbmlbxk+iRHjM7SbL2fGQfFXAFPGzklYmcFxKnfQv2vgd7bTlfjIMLKYjNze6bE1nLeYKGcFSpXCV2JAtfqNsEpreXWooapGRuHzZw8+zHYeq+4OKR0nYVJf5WBkz1mObkUto4+oDGSS6g9Gj3Mq32ZJnH35BOg9EGuQb1Wo0kkgpA0NI8yEFBX9BvVOIfD8y1Y6EKixrytPyn1IzP1dg4g89tC0hn4wIaleCuBMGaAFfLQrysH2uATNtwg0BUyI0H6DOLmWwLJBLbujCek8QmUc8LuRi8eXbMmt6veX1L08ObPCJsPDwM+EZa2HJRYuBea7s7M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(7696005)(8676002)(71200400001)(9686003)(55016002)(7416002)(478600001)(86362001)(5660300002)(33656002)(8936002)(52536014)(186003)(44832011)(26005)(2906002)(4326008)(6506007)(316002)(66446008)(66476007)(110136005)(66556008)(64756008)(66946007)(76116006)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: DemBxdYx0BqvVLntZz29OkGFlRBg8OBKp975Gmi0ZVmN56cgL9Ata7dQPrWrCea2m+eaaVplsZ1OktxYNM0wKp6pWcDZfH1z7rpTsfGxslEwdXmjaS9k7GFKDvb4OeqCM9AoXxsq7SKLTFe12BoHZQuBxIEkxTZYJBnLG1TJW9FUN5DpeKfKzqBD7KrHsHtgIjFx7rZwILuYSvZFCAKBDSBsZKUlvTl0xQHtGVqfRIX+wsnbmN1G4Y6KaM8FDN+BDj3WPkDXiaJblPVaZL/dRIHxZcW80XEWXxG+Cs+lqvz6zA977ecpYj5rLjVF8Xo/Dou3USCKt9B8D2TqPebeDUsMxmf6A5gYCABRZ4P22GFvpfiTRUqtfM5tOnFWcm4E+HfYzDs43f+EJKOeFRRV7JtVFUcqCnxxna+/5/HLEo1FW/n2Jc35dpg9Z/II3TFmmBBnJxwEB7tTeZNb39mxIg93ApOVUjHGe2LVzR9se3fbCYS1Ua/kaLBJPyHOOlXJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648a8d58-57b9-45a8-d64d-08d7fc945918
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 08:03:57.5444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tpn6d5SYV1SAfH2TNMmOXfICd44NwKJxhmkGaxaTUYn3lBgGAqImL4dkd4jOVf+G8OzVkD8BfUZUukWR14HkHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3915
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSCBWMl0gZHQtYmluZGluZ3M6IHRoZXJtYWw6IENvbnZl
cnQgaS5NWCB0byBqc29uLXNjaGVtYQ0KPiANCj4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24u
SHVhbmdAbnhwLmNvbT4NCj4gPiBTZW50OiBXZWRuZXNkYXksIE1heSAyMCwgMjAyMCAyOjAzIFBN
DQo+ID4NCj4gPiBDb252ZXJ0IHRoZSBpLk1YIHRoZXJtYWwgYmluZGluZyB0byBEVCBzY2hlbWEg
Zm9ybWF0IHVzaW5nIGpzb24tc2NoZW1hDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBI
dWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIHNpbmNlIFYx
Og0KPiA+IAktIG1vdmUgdGVtcG1vbiBub2RlIGludG8gaXRzIHBhcmVudCBub2RlIGFuYXRvcCBp
biBleGFtcGxlOw0KPiA+IAktIGltcHJvdmUgImZzbCx0ZW1wbW9uIiBkZXNjcmlwdGlvbi4NCj4g
PiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvdGhlcm1hbC9pbXgtdGhlcm1hbC50
eHQgICAgfCAgNjEgLS0tLS0tLS0tLS0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy90
aGVybWFsL2lteC10aGVybWFsLnlhbWwgICB8IDEwMA0KPiANCj4gWy4uLl0NCj4gDQo+ID4gK3Rp
dGxlOiBOWFAgaS5NWCBUaGVybWFsIEJpbmRpbmcNCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0K
PiA+ICsgIC0gU2hhd24gR3VvIDxzaGF3bi5ndW9AbGluYXJvLm9yZz4NCj4gPiArICAtIEFuc29u
IEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4g
PiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgb25lT2Y6DQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+
IA0KPiBEcm9wIFVubmVjZXNzYXJ5IHByb3BlcnRpZXMNCg0KV2lsbCB1c2UgZW51bSBkaXJlY3Rs
eS4NCg0KPiANCj4gPiArICAgICAgICAgIC0gZW51bToNCj4gPiArICAgICAgICAgICAgICAtIGZz
bCxpbXg2cS10ZW1wbW9uDQo+ID4gKyAgICAgICAgICAgICAgLSBmc2wsaW14NnN4LXRlbXBtb24N
Cj4gPiArICAgICAgICAgICAgICAtIGZzbCxpbXg3ZC10ZW1wbW9uDQo+ID4gKw0KPiA+ICsgIGlu
dGVycnVwdHM6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICBUaGUgaW50ZXJy
dXB0IG91dHB1dCBvZiB0aGUgY29udHJvbGxlciwgdGhlIElSUSB3aWxsIGJlIHRyaWdnZXJlZA0K
PiA+ICsgICAgICB3aGVuIHRlbXBlcmF0dXJlIGlzIGhpZ2hlciB0aGFuIGhpZ2ggdGhyZXNob2xk
Lg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gDQo+IFlvdSdkIGJldHRlciBleHBsYWluIHdoeSBp
bnRlcnJ1cHRzIG51bWJlciBpcyBjaGFuZ2VkIGluIHRoZSBuZXcgYmluZGluZw0KPiBjb21wYXJl
ZCB0byB0aGUgb3JpZ2luYWwgb25lLiBQcm9iYWJseSBhZGQgaW4gY29tbWl0IG1lc3NhZ2UgaWYg
cmVhbGx5DQo+IG5lZWRlZC4NCg0KVGhlcmUgaXMgT05MWSAxIGludGVycnVwdCBvdXRwdXQgZnJv
bSB0ZW1wZXJhdHVyZSB0byBHSUMsIHNvbWUgcGxhdGZvcm1zIGxpa2UNCmkuTVg2U1gvaS5NWDdE
IGhhcyAyIG1vcmUgc2Vjb25kYXJ5IGludGVycnVwdHMgaW5zaWRlIGFuYXRvcCB3aGljaCBzaGFy
ZXMgc2FtZSBvdXRwdXQNCmludGVycnVwdCB0byBHSUMsIHRoZXNlIDIgaW50ZXJydXB0cyBhcmUg
Tk9UIHVzZWQgZm9yIG5vdywgc28gZnJvbSB0aGUgaGlnaCBsZXZlbA0KZGVzY3JpcHRpb24gb2Yg
dGhlIGludGVycnVwdCwgc2hvdWxkIGJlIE9OTFkgMSBpbnRlcnJ1cHQgaXRlbSBJIHRoaW5rLg0K
DQo+IA0KPiA+ICsNCj4gPiArICBudm1lbS1jZWxsczoNCj4gPiArICAgIGRlc2NyaXB0aW9uOiB8
DQo+ID4gKyAgICAgIFBoYW5kbGUgdG8gdGhlIGNhbGlicmF0aW9uIGNlbGxzIHByb3ZpZGVkIGJ5
IG9jb3RwIGZvciBjYWxpYnJhdGlvbg0KPiA+ICsgICAgICBkYXRhIGFuZCB0ZW1wZXJhdHVyZSBn
cmFkZS4NCj4gDQo+IEJldHRlciBkZXNjcmliZSBmb3IgZWFjaCBvZiB0aGVtIGFzIHlvdSBkaWQg
Zm9yIGNsb2Nrcw0KDQpXaWxsIGRvIGluIFYzLg0KDQo+IA0KPiA+ICsgICAgbWF4SXRlbXM6IDIN
Cj4gPiArDQo+ID4gKyAgbnZtZW0tY2VsbC1uYW1lczoNCj4gPiArICAgIG1heEl0ZW1zOiAyDQo+
ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBjb25zdDogY2FsaWINCj4gPiArICAgICAgLSBj
b25zdDogdGVtcF9ncmFkZQ0KPiA+ICsNCj4gPiArICBmc2wsdGVtcG1vbjoNCj4gPiArICAgICRy
ZWY6ICcvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlJw0KPiA+ICsgICAg
ZGVzY3JpcHRpb246IFBoYW5kbGUgdG8gdGhlIHJlZ2lzdGVyIG1hcCBub2RlLg0KPiANCj4gV2hh
dCByZWdpc3RlciBtYXA/IEEgYml0IGFtYmlndW91cy4uDQoNClRlbXBlcmF0dXJlIHNlbnNvciBy
ZWdpc3RlcnMsIHdpbGwgYWRkIG1vcmUgZGV0YWlsIGluIFYzLg0KDQpBbnNvbg0KDQo=
