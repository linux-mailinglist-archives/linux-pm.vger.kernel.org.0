Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2393A15A5D7
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 11:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgBLKLs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 05:11:48 -0500
Received: from mail-eopbgr20067.outbound.protection.outlook.com ([40.107.2.67]:14307
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725767AbgBLKLr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 05:11:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMgBudj7ZF7CgwKzG5aadcBTqvH/xzg3fpmHcbJXntg/qPfwPUJWTJHeYne5aMx9pj2ZnAWtZkGy/s739s2AdYRFvFvOHawVNJVreSGsFFo1IX3uhqqb3V6KgRIHRm/pEQACl6OpyG/RWg25CTzRaZU0rLICTlgEU+zV9AEEDInslldufwlfUIDGAqbSVX7LEU/bxZiVQg5ABIrtPyeVAVtKpHHLUzjdhSoGj24tWyL5MKHf4AlLQxynjf7r0p+tYoBhBS11mMAfktJlo3CYwWKpgZ1IC3iL1w4krnot6BLto2nYE8JjN7+gWm+/dDGUm+45K8VEG0xBduoySWgNxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm9brG9QPuwpiGVm0DgjseoxOWmpSuEUcpntITdAk/4=;
 b=U5yLQEpCRJVx+6qZ6X6GmrOTHQoLMou8XeI8VSSpxG+eTNd+4x7xe/JjNH3nDSm122JQcmAcGpA0oh1yh+1hGGN0Jp/t9AjnCNAAh8NwK5YskXE1cYgFAA6Q7flraD8cA1TuAZY8ry+GGQ6+SXaJVdE/eGUgtJ5MNKg6o95Ir3dE6x4RoWPGjVBwyGaQmk7zqxJtlAc22N/vM3NPmYN839gVNwXSOqW/t9D9yUzNUX535hGu0j+I8t4tntvJTzLQlc1WL4lqMHF3vwFULVy8FYPsbdAPuUGeLkWiz2ef5dhd/Ru5HKuE1d8vlJJwRqz9DN7bdOvLbEbmfeqbDXKYBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm9brG9QPuwpiGVm0DgjseoxOWmpSuEUcpntITdAk/4=;
 b=rE4wLFTm1jQgCNIdY2kgSDmq5U4YCL3Jk2cQt5DP8pWPivC6IosjnDHN/XWYRPdbDJCK/8Hewcxd/17hbFa8MeFoYKNF6z4hCHy4IqFJDXGWL5LCaSU3Uuz5/qivgSEGGl/pH9a/DdSnOYaQ2OPIGgjqXdQARV2aOp+DZFLFzo4=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB3246.eurprd04.prod.outlook.com (10.170.229.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.28; Wed, 12 Feb 2020 10:11:44 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d095:a19c:d6b5:da57]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d095:a19c:d6b5:da57%5]) with mapi id 15.20.2729.021; Wed, 12 Feb 2020
 10:11:44 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [EXT] Re: Ask for help about cpufreq issue
Thread-Topic: [EXT] Re: Ask for help about cpufreq issue
Thread-Index: AdXdcxSxB0cyUSagT5OnSrOpW6FSxAAA6GCAAAAcdEAAA3btAADDOJ9wAANpvoAAAOC7QAAAkWqAADlKDXA=
Date:   Wed, 12 Feb 2020 10:11:43 +0000
Message-ID: <VI1PR04MB43334811F21E85BD9DACE259F31B0@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <VI1PR04MB4333D45D033CB8E33CB9070FF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207052321.povhuxrlm25ueoak@vireshk-i7>
 <VI1PR04MB43334D5868037FCAE4D7631BF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207070544.geurecsy4i22xpzl@vireshk-i7>
 <VI1PR04MB4333E6B3340BADBC737E9CFFF3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211055315.qlqrxiqf72u36ijl@vireshk-i7>
 <VI1PR04MB4333D6A41BD1AB77489E3139F3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211063439.aqc4h6np3wjpsg2j@vireshk-i7>
In-Reply-To: <20200211063439.aqc4h6np3wjpsg2j@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [120.244.236.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef3d3ba9-a08d-45bb-789f-08d7afa3f647
x-ms-traffictypediagnostic: VI1PR04MB3246:
x-microsoft-antispam-prvs: <VI1PR04MB32463F3AFEBCC26AFA46719EF31B0@VI1PR04MB3246.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(189003)(199004)(2906002)(8936002)(66946007)(55016002)(316002)(64756008)(66476007)(6916009)(5660300002)(66446008)(7696005)(66556008)(26005)(9686003)(76116006)(44832011)(6506007)(53546011)(54906003)(52536014)(478600001)(71200400001)(8676002)(86362001)(81156014)(81166006)(4326008)(186003)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3246;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SjfiSoWzguqG/Ka59H0a9ktqYhVmVmOMrVqOINKYK2FrrBizh8itgbkxE7Dty0PIPSiCj7emtzOCKQ/VrTiztQd58ust4VmZH1gq8uX3ZP3G3w6IRtc9JZhVyM9hcUQgR1GKYGmz1pup1L6tJybPkCeHLGWm0PfQlP/y0/BEcDWSwWArLCfRIPlBZ2u/9yOO7FQpqs7cra8+7KC7CrlEvsZef0vabNLs0+EpmI4RDY5wP+v79yYLqLXZhMO2ebGQ44bKy9nD+XSrddK/g6dnRAIwdbM1idL527SFCzGaP4cIeeht/x6NGNX/pXc1uE/KvZtjnUK2kcGc/i8DgQ4FxPGPFfYCj4iL9UZBtz0sK557otkgPSmP/42GtxI/gCzz54t+0Vwgndjo8F296dgERou0PjkZ2SAFolgToiTynCtwVoAo+K31zAmXXvtu7jUo
x-ms-exchange-antispam-messagedata: UCqtIBnI9SVS3B5Hza9saMzGZv96eDV4NIiRoO/AWqbo4y+KGWs9Qn7GNuZ9SilWtUYAvjKCew3o+OvniZLkdflNHTMxIlRDjWs6v2wvw/GAQUmtXEjCQgPJBF+3RZY5d2jnCZKfcsNoEOXQszdHXA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3d3ba9-a08d-45bb-789f-08d7afa3f647
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 10:11:44.1204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q55+hp8ncRNO0Ayho0u24D8IcHEieDwWMXtYsmZJGXhXuHjRPbZcCAI6GFhIPgFFqYS3S7bxbChqXRYsdS73lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3246
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgVmlyZXNoLA0KDQpJIGhhdmUgYW5vdGhlciBjcHVmcmVxIGlzc3VlIG9uIG91ciBseDIxNjBh
IHBsYXRmb3JtIHdoaWNoIGhhcyAxNiBjb3JlcyBhbmQgOCBjbHVzdGVycy4NCg0KQ3B1ZnJlcSB3
b3JrcyB3ZWxsIGZvciBvbmRlbWFuZCwgcGVyZm9ybWFuY2UgZ292ZXJub3IuIA0KQnV0IGZvciBj
b25zZXJ2YXRpdmUgZ292ZXJub3IsIGV2ZW4gdGhvdWdoIGNwdSB1c2FnZSBpcyBhbG1vc3QgemVy
bywgYnV0IHNvbWUgY3B1cyBhcmUgbm90DQp3b3JrIG9uIHRoZSBsb3dlc3QgZnJlcXVlbmN5IHNv
bWV0aW1lcy4gSXQga2VlcHMgYm91bmNpbmcgZnJvbSB0aGUgbG93ZXN0IGZyZXF1ZW5jeQ0KdG8g
dGhlIG90aGVyIGhpZ2hlciBmcmVxdWVuY2llcy4gDQpUaGUgZGVmYXV0IHZhbHVlcyBhcmUgdXNl
ZCBmb3IgdGhlIHR1bmFibGUgZm9yIGNvbnNlcnZhdGl2ZSBnb3Zlcm5vci4NCkluIHN1bW1hcnks
IHdoeSBjcHUgZG9lc24ndCB3b3JrIGF0IHRoZSBsb3dlc3QgZnJlcXVlbmN5IGV2ZW4gdGhlIGNw
dSBsb2FkIGlzIGFsbW9zdCB6ZXJvPw0KDQpyb290QGx4MjE2MGFyZGI6L3N5cy9kZXZpY2VzL3N5
c3RlbS9jcHUjIGNhdCBjcHVmcmVxL2NvbnNlcnZhdGl2ZS8gDQpkb3duX3RocmVzaG9sZCAgICAg
ICAgZnJlcV9zdGVwICAgICAgICAgICAgIGlnbm9yZV9uaWNlX2xvYWQgICAgICBzYW1wbGluZ19k
b3duX2ZhY3RvciAgc2FtcGxpbmdfcmF0ZSAgICAgICAgIHVwX3RocmVzaG9sZCAgICAgICAgICAN
CnJvb3RAbHgyMTYwYXJkYjovc3lzL2RldmljZXMvc3lzdGVtL2NwdSMgY2F0IGNwdWZyZXEvY29u
c2VydmF0aXZlLyoNCjIwDQo1DQowDQoxDQo4MDAwDQo4MA0KDQpyb290QGx4MjE2MGFyZGI6L3N5
cy9kZXZpY2VzL3N5c3RlbS9jcHUjIGNhdCBjcHVbMC05XS9jcHVmcmVxL3NjYWxpbmdfZ292ZXJu
b3INCmNvbnNlcnZhdGl2ZQ0KY29uc2VydmF0aXZlDQpjb25zZXJ2YXRpdmUNCmNvbnNlcnZhdGl2
ZQ0KY29uc2VydmF0aXZlDQpjb25zZXJ2YXRpdmUNCmNvbnNlcnZhdGl2ZQ0KY29uc2VydmF0aXZl
DQpjb25zZXJ2YXRpdmUNCmNvbnNlcnZhdGl2ZQ0KDQpyb290QGx4MjE2MGFyZGI6L3N5cy9kZXZp
Y2VzL3N5c3RlbS9jcHUjIGNhdCBjcHVbMC05XS9jcHVmcmVxL3NjYWxpbmdfY3VyX2ZyZXENCjEw
MDAwMDANCjEwMDAwMDANCjEwMDAwMDANCjEwMDAwMDANCjEwMDAwMDANCjEwMDAwMDANCjIwMDAw
MDAJCS8vLyB0aGlzIGlzIG5vdCB3b3JraW5nIGF0IHRoZSBsb3dlc3QgZnJlcXVlbmN5DQoyMDAw
MDAwDQo3MDAwMDANCjcwMDAwMA0KDQpDb3VsZCB5b3UgcGxlYXNlIGluc3RydWN0IG1lIGhvdyB0
byBkZWJ1ZyB0aGlzIGlzc3VlPw0KVGhhbmtzLA0KDQpCUiwNCkFuZHkNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJv
Lm9yZz4NCj4gU2VudDogMjAyMMTqMtTCMTHI1SAxNDozNQ0KPiBUbzogQW5keSBUYW5nIDxhbmR5
LnRhbmdAbnhwLmNvbT4NCj4gQ2M6IHJqd0Byand5c29ja2kubmV0OyBsaW51eC1wbUB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtFWFRdIFJlOiBBc2sgZm9yIGhlbHAgYWJvdXQgY3B1
ZnJlcSBpc3N1ZQ0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiAxMS0wMi0yMCwg
MDY6MjMsIEFuZHkgVGFuZyB3cm90ZToNCj4gPiBJIGFtIGdvaW5nIHRvIHRyYWNrIHRvIGRldl9w
bV9xb3NfYWRkX3JlcXVlc3QoKSBhcyB5b3Ugc3VnZ2VzdGVkLg0KPiA+IEJlZm9yZSB0aGF0LCBJ
IGFtIGFsc28gd29uZGVyaW5nIHdoYXQgdGhlIGZhY3RvciBpdCBjb3VsZCBiZSB0byBsaW1pdCB0
aGUgY3B1DQo+IG1heCBmcmVxdWVuY3k/DQo+IA0KPiBPbmUgb2YgdGhlbSBpcyB0aGVybWFsLCBi
dXQgdGhlcmUgY2FuIGJlIG90aGVycyBhcyB3ZWxsLiBKdXN0IGRvIGZvbGxvd2luZw0KPiBzZWFy
Y2ggaW4geW91ciBrZXJuZWwgc291cmNlIGNvZGU6DQo+IA0KPiBnaXQgZ3JlcCBmcmVxX3Fvc19h
ZGRfcmVxdWVzdA0KPiANCj4gVGhpcyB3aWxsIGxpc3QgYWxsIHRoZSBzb3VyY2VzIG9mIHRoaXMg
Y29uc3RyYWludC4NCj4gDQo+IC0tDQo+IHZpcmVzaA0K
