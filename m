Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C26415D512
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 11:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgBNKAY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 05:00:24 -0500
Received: from mail-eopbgr150055.outbound.protection.outlook.com ([40.107.15.55]:48206
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728807AbgBNKAY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Feb 2020 05:00:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3E+mqnfh+023pdHtxnzIuLWcnqaX3OvKjOm9yrFKG9noonOjTkuRmlk53mxLd5NsXisIZHtHkYwQEzyqyDawmLR+nxsoO+55aIorFNtedU4l0zu7fWeF/cAmbAwccVyt6qwz/s+rUQJA2AGKkxCbrvnK+XhvjANiTSrpyzddsuA3njAh79gFGhuLFVJ9/5CXtr+E4k+mp2NOvhvf/aqTB0aR7Y0MNiGUwyxSAi4PDV2RN3dN07yUtf0sb243eaSvpid/3PfgUswIOgAmZ1yj4qWZ+SzmCkMgrD2DRsQdxSee5JZc+fnTe1HnsDZXI+vU+4qmDZiX9R8mELNFQ40/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itFCaPSD3dK0gxFQWub/6sq9wEh5K+hob8GgnDy7Co8=;
 b=Oz8PetOJlf0k6I/2/Z7P4zYbXkbn/gr75K/w5ooC4cAvLnPGIomN2Yv1KNz69wbHN0LfW1lEDSqpayKVxa0GfAAchWH41RQlh4DofxLNHnDjYqBQjkBztdRj/Olf33bPjX/VpbLGZkCnkid074xkak7o7irqq1gHATiwjkx7DgvLds9OBUsCdVMt1eELxeaAzjCF3y0TBFtkUiXexhxPl0KNfd7hLV3BVbbwjrC5+39ZzHbzEN7YazIiuEOS3bLtQxOdjgkyK1uDNx/4aGb7kBVvj/dYp/F7i+ZwBOzdui02gawSvMXXBhkMh5C5lfJtAEfhn92ng82xXBGgLnIijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itFCaPSD3dK0gxFQWub/6sq9wEh5K+hob8GgnDy7Co8=;
 b=caPpVRXrAU0jgakcTRwfrOBWu1w0JiuLZJOdkK/JDO39GNAVFGRf8f5qn3dI+L4Na5DG79ilLJcGS9mnmSdwh1FviGoEieDtO25qWSsVMpmeYgNK+o8NuxLSbOKbJODc1yLdGaSMlvR/w5Xfb1TuzdNuwqXGiiRZQvj7zOeI6jg=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB4111.eurprd04.prod.outlook.com (52.134.122.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Fri, 14 Feb 2020 10:00:20 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d095:a19c:d6b5:da57]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d095:a19c:d6b5:da57%5]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 10:00:20 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [EXT] Re: Ask for help about cpufreq issue
Thread-Topic: [EXT] Re: Ask for help about cpufreq issue
Thread-Index: AdXdcxSxB0cyUSagT5OnSrOpW6FSxAAA6GCAAAAcdEAAA3btAADDOJ9wAANpvoAAAOC7QAAAkWqAADlKDXAABAwMAAAokcIQAANYbIAANJ3YwA==
Date:   Fri, 14 Feb 2020 10:00:19 +0000
Message-ID: <VI1PR04MB4333A771266A447FB8682E2FF3150@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20200207052321.povhuxrlm25ueoak@vireshk-i7>
 <VI1PR04MB43334D5868037FCAE4D7631BF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207070544.geurecsy4i22xpzl@vireshk-i7>
 <VI1PR04MB4333E6B3340BADBC737E9CFFF3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211055315.qlqrxiqf72u36ijl@vireshk-i7>
 <VI1PR04MB4333D6A41BD1AB77489E3139F3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211063439.aqc4h6np3wjpsg2j@vireshk-i7>
 <VI1PR04MB43334811F21E85BD9DACE259F31B0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200212115054.eouh7e42uqlcweo3@vireshk-i7>
 <VI1PR04MB43332FB8B9FAD91160D91A0CF31A0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200213084819.jveurrsvtv72ssug@vireshk-i7>
In-Reply-To: <20200213084819.jveurrsvtv72ssug@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [120.244.236.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be39daa8-80fc-43de-39dd-08d7b134b365
x-ms-traffictypediagnostic: VI1PR04MB4111:
x-microsoft-antispam-prvs: <VI1PR04MB41118C872F3F55EE75D07231F3150@VI1PR04MB4111.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(189003)(199004)(4326008)(76116006)(33656002)(478600001)(64756008)(66556008)(66446008)(66946007)(66476007)(52536014)(5660300002)(55016002)(9686003)(6916009)(8936002)(316002)(71200400001)(7696005)(86362001)(44832011)(81166006)(8676002)(81156014)(186003)(6506007)(53546011)(26005)(2906002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4111;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SDfMzfjniTusF5DgDzp7NFSZyirPXJZpJQ/VjqxJb0bn3ptstS1MgM30od1HXVnu/cEoxDbb1D6Xd0jiJ4CZi+jrauD8fTKvXYWEaDrThj84y2lojRCCQ9PQD60UbM6vjecjBKwyspXOijUwu/qbB4wGOx02Oji9CriEXL81Z1AeD9aI1jejNzm7ziqp0EDHLGrEcccypRMVsc5Z1zlAFFNsxf1tkre2DEZJcVUeFyfiEvrmWqaNM9sSvQ3wylnzj8WgHAZbnnYDW/Vi7SIVvNFQyiTNg8EnJJ71jvHAESTbltYQqmWIupU/JBxgmjmGqD9QW6leBtssj8hbBEHDxM54/dhGs6V4raxrFB0odO2QfCJqb4cTduOIk6Honmdgemy+iN6Af29bwGVcLhqdwxhjfmUDHKis3gpmw99SyHJ5QbGVEDTEBWOg2a4h6ZKi
x-ms-exchange-antispam-messagedata: 6/XDZjGw005dS081STTzIQ+zyFzYcipeYWBO4m72F6oRLpisLDkjR/4xiAPN69Las0XDkvHTQdyMmibx4W/dMYkhS6tuvY4wZT194Zymh5r4zPpV2pxyQq/T1auEE33bmeev+EB/IqcfL+hzE8Ygyw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be39daa8-80fc-43de-39dd-08d7b134b365
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 10:00:19.6229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Si/GN9v7dEmUihd4iJW5iKlT4GPP9oIo+gL1u1PUmcZ1bsk6WULcDb/1V+/QoClmEYVypTQJ+ztNE5f7gRCHBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4111
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgVmlyZXNoLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpcmVz
aCBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjDE6jLUwjEzyNUg
MTY6NDgNCj4gVG86IEFuZHkgVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+IENjOiByandAcmp3
eXNvY2tpLm5ldDsgbGludXgtcG1Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhU
XSBSZTogQXNrIGZvciBoZWxwIGFib3V0IGNwdWZyZXEgaXNzdWUNCj4gDQogDQo+IE9uIDEzLTAy
LTIwLCAwODoxOCwgQW5keSBUYW5nIHdyb3RlOg0KPiA+IEkga2VlcCBtb25pdG9yaW5nIGNwdSB1
c2FnZSBmb3Igc2V2ZXJhbCBtaW51dGVzLCBieSB0b3AgYW5kIG1wc3RhdA0KPiA+IHRvb2wsIGFu
ZCBmb3VuZCBtb3N0IG9mIHRoZSBjcHVzIGFyZSAxMDAlIGlkbGUsIG9uY2UgaW4gYSB3aGlsZSBv
bmUgb2YgdGhlDQo+IGNwdXMgaW5jcmVhc2VzIHRoZSBsb2FkIHRvIGFib3V0IDE4JS4NCj4gDQo+
IEkgZG9uJ3QgdGhpbmsgdG9wIHdpbGwgYmUgYSBnb29kIHdheSBmb3IgZG9pbmcgdGhpcyB0ZXN0
IGFzIHdlIGFyZSB0YWxraW5nIGFib3V0DQo+IGxvYWQgb24gYSBDUFUgaW4gaW50ZXJ2YWwgaW4g
bWlsbGlzZWNvbmRzLiBQbGVhc2UgY2hlY2sgd2l0aCB0cmFjaW5nIGFuZCBzZWUNCj4gd2hhdCdz
IGtlZXBpbmcgdGhlIENQVSBidXN5Li4NCj4gDQo+ID4gVGVjaG5pY2FsbHkgaWYgdGhlIGNwdSB1
c2FnZSBpcyBub3QgbW9yZSB0aGFuIHVwX3RocmVzaG9sZCg4MCksIGNwdQ0KPiA+IHdvbid0IGlu
Y3JlYXNlIGl0cyBmcmVxdWVuY3kgYW5kIGtlZXAgYXQgdGhlIGxvd2VzdCBmcmVxdWVuY3kgd2hl
biBjcHUgaXMNCj4gYXQgdGhlIGxvd2VzdCBmcmVxdWVuY3kgYW5kIGNvbnNlcnZhdGl2ZSBnb3Zl
cm5vciBpcyB1c2VkLg0KPiANCj4gSSBhZ3JlZS4gV2hpY2ggbWVhbnMgdGhhdCB0aGVyZSBhcmUg
c29tZSBzcGlrZXMgb2Ygd29yayBnZXR0aW5nIHNjaGVkdWxlZA0KPiBvbiBDUFVzLiBUaGUgbG9h
ZCB3aWxsIGluY3JlYXNlIHNsb3dseSBhbmQgd2lsbCBhbHNvIGRlY3JlYXNlIHNsb3dseQ0KPiAo
c3RlcC1ieS1zdGVwKSB3aXRoIGNvbnNlcnZhdGl2ZSBnb3Zlcm5vci4NCj4gDQo+ID4gU28gSSBj
YW4ndCB1bmRlcnN0YW5kIHdoeSBjcHUgZnJlcXVlbmN5IGluY3JlYXNlZD8NCj4gDQo+IFRyYWNp
bmcgb3IgZGVidWdnaW5nIGNzX2Ric191cGRhdGUoKSBpbiBjb25zZXJ2YXRpdmUgZ292ZXJub3Ig
aXMgdGhlIG9ubHkNCj4gd2F5IG91dCBJIHdvdWxkIHN1Z2dlc3QuDQpGcm9tIGNzX2Ric191cGRh
dGUoKSBmdW5jdGlvbiwgSSBkaWQgc2VlIHRoYXQgc29tZXRpbWVzIHRoZSBMT0FEIGlzIGF0IDEw
MCUgdXNhZ2UuDQpUaGVyZSBpcyBhbG1vc3Qgbm8gYXBwbGljYXRpb24gcnVubmluZy4gVGhhdCBt
dXN0IGJlIHNvbWUgc3Bpa2VzIG9mIHdvcmtpbmcgcnVubmluZy4NClVuZm9ydHVuYXRlbHkgSSBj
YW4ndCB0cmFjayB0aGVtIGJ5IGNzX2Ric191cGRhdGUoKSBvciBmdHJhY2UgdG9vbC4NCkkgZG91
YnQgdGhlIGZ0cmFjZSBjYW4gYmUgdXNlZCB0aGlzIHdheS4gRG8geW91IGhhdmUgYW55IG90aGVy
IHN1Z2dlc3Rpb25zPyBNYXliZSBhbm90aGVyIHRvb2xzPw0KDQpCUiwNCkFuZHkNCj4gDQo+IC0t
DQo+IHZpcmVzaA0K
