Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2ED411A8A9
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 11:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfLKKMJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 05:12:09 -0500
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:29623
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727829AbfLKKMJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Dec 2019 05:12:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRi9746DAw6Uvaihy45HEp80D/WjDy11erv4v4yShQzauukbEh1Ho6jnXBOufKb+nz/WrK80QEtKFWXeNwsk4VTafJb+ZSYZqI2MjY3gA4VkjYca0u56tLyNHeSI7AtuGS34BHsL24f3yJuJQDnnqS5/TV07rAmN+5R1569TQFRxS7Mkvq02XSL8RhA8CASGXY3qrULzZYrtGNz7zn1iTSg7w+LHkCm9ReT+/hzD46NDUk8ILqTDpNhLQWgKgZ/oRJW20YW58JzqaMVVfoECbleg673SfeA6k1HaKolzXTrEt/l0wIcoPjHRCuvZQdIfmTQ+h3Zg4fez4TgPkA+PzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7wtuBXlS7tEL5+TERLghWGLtt37FNCLpDr3Na3vQh4=;
 b=UxVMHln0V0LTl0/1i6D7o3ZTMXutLez1OHuACyy+zCHWk5eRWljfxg4uvD3xoRZdgR2t1dvVo2HvhERkTtjaXmzZyVzlyzYg3urXlVh1v5+9+fEtAGmm3HU3DqUoLcqciKccvG4K/KKvGePl2aLe1pJOBCrstx9/OcZRZeXOJxh6pr/zJIeMV7zJNZX1YjSJ7arT5YtbrdPTCPJYcEEwZA2OC+OUfXXO4g6kHrKt0BTz3W4Tzr3QdPjl3Obzg2Zrocjwu2AW1gkjQf4FFeCe+jV/4K4jmxKOOHmXJsrytBjXn5HKAZHG3E3WdAGXWDU2V9JsmUmX+GQP8F9IZUw0RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7wtuBXlS7tEL5+TERLghWGLtt37FNCLpDr3Na3vQh4=;
 b=jpo9h2ht1KY+3lbDcBql+Zgc7tM6BPmUJGv9YtqN8Bfe6AoG3YtzIUGcsQtzrhZxgEKCKN39X73KbvydVTQW6L4sDx1GuIjORcQnZfeiUtQxXuTBg7CHIUz3KOfhR3V/+ihgbLqYlEuEQgVvccjPbcYZ8TyJWyq0qRnaGd7LUFI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5299.eurprd04.prod.outlook.com (20.177.42.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Wed, 11 Dec 2019 10:11:59 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 10:11:59 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: RE: About CPU hot-plug stress test failed in cpufreq driver
Thread-Topic: About CPU hot-plug stress test failed in cpufreq driver
Thread-Index: AdWgM3EuFQeyF1SHRka5sBhDxaFShQAG6J6AAAAKxPAAAq52AAAAFLaAACYwDoAACh8qAAAASXeAAJxYEgAAxubCAAAEUtUgASMyDZAABHGSAAAFLgggAAVyLYAAvd+WYAAA3omQAAEGDYAAAmWbRgAAcGGAACPMEXAAAqbAgAACrQEAAAAfUXAAAG2mAAAAIzIAAABNT4AAAAalAAADxrOAAACJ1gAALbeWIAAB0/sAAAAOURAAAIKGAAAAqIOQ
Date:   Wed, 11 Dec 2019 10:11:59 +0000
Message-ID: <AM0PR04MB4481F7024F2794FDCAA17447885A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916C7E77C885343B2B961CFF55B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <5310126.hg2rr5Fjtk@kreacher> <7233060.oySJ2cjCuV@kreacher>
 <AM0PR04MB4481EDA9EB0374E698A6754C885A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAJZ5v0g15AupBe05kN5Mp8NRQYgTEwd80QoJ3kTajnnfD51O6w@mail.gmail.com>
 <AM0PR04MB4481ACE3187E2698145A7784885A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAJZ5v0iZj+J=HonFqyThPHgPz=Eifw4Cbuws8r6F4ZA3Svf5Lw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iZj+J=HonFqyThPHgPz=Eifw4Cbuws8r6F4ZA3Svf5Lw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec122cc9-6c16-4896-4ea2-08d77e228f6b
x-ms-traffictypediagnostic: AM0PR04MB5299:|AM0PR04MB5299:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5299B5A63EAC2644156C5F11885A0@AM0PR04MB5299.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(199004)(189003)(44832011)(66946007)(33656002)(186003)(478600001)(53546011)(86362001)(8676002)(76116006)(9686003)(6916009)(4326008)(81156014)(64756008)(26005)(52536014)(5660300002)(2906002)(8936002)(55016002)(316002)(7696005)(4744005)(66446008)(71200400001)(66476007)(66556008)(6506007)(81166006)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5299;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y9jcXTwl7C0q/p7rQayfGAs4G7n2j8i/f5yrdUWaB0EAPUDQpy265YIMfYb1L9XnJ345C2KGYuhln8eQ+1OxkHG0bPCYBiKEne5ktUuk1BUiieIMO91jdKnbOAg3y+eSbk8oNKJRdQ1j1BqMv+EnswJr+zgBa1Djip72rGSVSzcdGwuKhCtw+2OThnrGMjEQEPLP8y/qOPTvAI/CGFfzh8bhs3lbz/6dZw+bA/hQ6HzpmBF0ukeRP4Go2boUai1iQ9WNN/lBwKa6tXkocbzc1j5f3B3TiWNSheBzNOgp1jiAsofJxB88Z5+6wfoDtLRw4USyigis+hCSsTichl3m9NZVZHdUQNPd1mkYtuoESv/5CctwJ5ss4lZ/r5GV009xnWlMBC94BoCZvIQUquQXhfYo8k+uqc8qA6hZCfUIoa+fTHEXx3SiRaeA5CZxFpZn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec122cc9-6c16-4896-4ea2-08d77e228f6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 10:11:59.5197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dB6ntnbrKp7QKVeSCPAXXP1vR66xrZ/3iio5kX0jnGHD57ZcQcI/E4Fw24a8A1ff38nZZN/J4x30C1PbAw5d9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5299
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBTdWJqZWN0OiBSZTogQWJvdXQgQ1BVIGhvdC1wbHVnIHN0cmVzcyB0ZXN0IGZhaWxlZCBpbiBj
cHVmcmVxIGRyaXZlcg0KPiANCj4gT24gV2VkLCBEZWMgMTEsIDIwMTkgYXQgMTA6NDMgQU0gUGVu
ZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiBTdWJqZWN0OiBSZTog
QWJvdXQgQ1BVIGhvdC1wbHVnIHN0cmVzcyB0ZXN0IGZhaWxlZCBpbiBjcHVmcmVxIGRyaXZlcg0K
PiA+ID4NCj4gPiA+IE9uIFdlZCwgRGVjIDExLCAyMDE5IGF0IDk6NTkgQU0gUGVuZyBGYW4gPHBl
bmcuZmFuQG54cC5jb20+IHdyb3RlOg0KPiANCj4gW2N1dF0NCj4gDQo+ID4gPiBCdXQgcHJldmVu
dGluZyBDUFVzIHdpdGggTlVMTCBjcHVmcmVxX3VwZGF0ZV91dGlsX2RhdGEgcG9pbnRlcnMgZnJv
bQ0KPiA+ID4gcnVubmluZyBjcHVmcmVxIHV0aWxpemF0aW9uIHVwZGF0ZSBjb2RlIGF0IGFsbCAo
bGlrZSBpbiB0aGUgbGFzdA0KPiA+ID4gcGF0Y2gpIHNob3VsZCBiZSBzdWZmaWNpZW50IHRvIGFk
ZHJlc3MgdGhpcyBwcm9ibGVtIGVudGlyZWx5LiAgQXQNCj4gPiA+IGxlYXN0IEkgZG9uJ3Qgc2Vl
IHdoeSBub3QuDQo+ID4NCj4gPiBJIGp1c3QgdGhpbmsgdGhlIHNjaGVkdWxlciB3YW50IHRvIGlu
amVjdCBpcnFfd29yayBvbiB0aGUgY3B1IGV2ZW4NCj4gPiBkdXJpbmcgdGhlIGNwdSBvZmZsaW5p
bmcgcHJvY2VzcywgYnV0IHdlIG5vdCBpbmplY3QgaXJxIHdvcmsgd2l0aCB5b3VyIHBhdGNoLg0K
PiBJcyB0aGlzIHJpZ2h0Pw0KPiANCj4gWWVzLCBidXQgdGhhdCBtZWFucyB0aGF0IHdlIGp1c3Qg
YXZvaWQgYSBjcm9zcy11cGRhdGUgd2hpY2ggd291bGQgYmUNCj4gZGlzY2FyZGVkIGR1ZSB0byB0
aGUgcG9saWN5LT5jcHVzIG1hc2sgY2hlY2sgd2l0aG91dA0KPiBkdmZzX3Bvc3NpYmxlX2Zyb21f
YW55X2NwdS4NCg0KVW5kZXJzdGFuZC4NCg0KPiANCj4gVGhlIHRhcmdldCBvbmxpbmUgQ1BVIHdp
bGwgcnVuIHRoaXMgdXBkYXRlIGJ5IGl0c2VsZiBldmVudHVhbGx5IGFueXdheS4NCg0KWWVzLiBU
aGFua3MgZm9yIGV4cGxhbmF0aW9uLg0KDQpUaGFua3MsDQpQZW5nLg0K
