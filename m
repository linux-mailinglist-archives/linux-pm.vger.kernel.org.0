Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D0137BC2D
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 14:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhELMCA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 08:02:00 -0400
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:14814
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230182AbhELMCA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 May 2021 08:02:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOFd6oUegx64n9jeniKGT4F5uzh0krEkn7f+yopGc9CelIxnedaV75AAcKKb83TaIuQqJNR+3Ls0fh9OnHiB1QUs33Wom2FBMZSXvs09QNqx+rC1XAysEmwCGgozDu83ymNzbPx42RuPpqamer5oouvxTpvcg9XipMNRA18afNDOeuNpINpQRCPk4AaJeGRbBsFjFSo0H5IohdL0GKtmwYfQtB1ivoPPFlZ8XJRn1kSHA9q+1wic+ANA7d0Xb12z5bWRUEq58Ri8J4NEdGxTJqP5xdp0jQqDXrm3wPlItmUw890jy3Ood8BY0tKPsIKyN3w/axXEnARjFlbchkewbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfvJ2Vtj4hHp6N9poS8zISuoXe5W2mV9xo41XU5JVbs=;
 b=Nq2JemmDpDoqb1fu/pE7BbcdBhuuLF/NIfwCrtUc0b8bDKEh1oNIoQEEucatLlDOD7DlFmWEeaT1Z+QZmPE+j5eHVDbbQgfLzmbnX4b7Y1aa9bw6PX3sD8vAoHXv9dD9Rk9DwbMpXKWhQCy9zzDe8WDlKRISKCtqNY02cc4L4PfEmsjq/MIUsyNHHErG03RTCKdIgtS0mRuBR+9LGb9lrL2ig/YqwS+WKntsYIXw8u7TBy/KXov3AfTub8jWEZ7MgSYyAlw/udJ6H8gSOCzg1eqFE1wSxSeogjymi4gTOLYryRISYVoh6jP3fWIaN36EsVSDqGHynfvyQMFdTuUOdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfvJ2Vtj4hHp6N9poS8zISuoXe5W2mV9xo41XU5JVbs=;
 b=GFMLO2n49y8kZDq/870JAYH6X1oyfHhYnMJkz5k1taohQqE3r0+5wFhfn0T5chwGhnZJH/n6uR3lstYmZX02sPWGG8xKarEqLQY2+Jgf6EIpIO9hvLLew40Q+f8wEPssUIMhfo4/tmgeUn2+fQWANCQuK/zcJU3OabXkDooKEmM=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2172.eurprd03.prod.outlook.com (2603:10a6:3:1e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.29; Wed, 12 May 2021 12:00:46 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::89f0:ff95:a73a:cf4b]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::89f0:ff95:a73a:cf4b%7]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 12:00:46 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "pmladek@suse.com" <pmladek@suse.com>
CC:     "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "mcroce@microsoft.com" <mcroce@microsoft.com>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v9 02/10] reboot: Add hardware protection power-off
Thread-Topic: [PATCH v9 02/10] reboot: Add hardware protection power-off
Thread-Index: AQHXRY+gOOJorqm9zUieXqbzwTTWAqrfhCcAgAA9moA=
Date:   Wed, 12 May 2021 12:00:46 +0000
Message-ID: <2149df3f542d25ce15d049e81d6188bb7198478c.camel@fi.rohmeurope.com>
References: <cover.1620645507.git.matti.vaittinen@fi.rohmeurope.com>
         <97260f8e150abb898a262fade25860609b460912.1620645507.git.matti.vaittinen@fi.rohmeurope.com>
         <YJuPwAZroVZ/w633@alley>
In-Reply-To: <YJuPwAZroVZ/w633@alley>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25cee087-89f9-4951-7419-08d9153d93dc
x-ms-traffictypediagnostic: HE1PR0301MB2172:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0301MB2172A9955DEC827CCE070B09AD529@HE1PR0301MB2172.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +SocqYr1krH1CGnQ6dk4TKaPadSTEN3M2efP4P4TfgLNt5L4XqpWg4lpfbopeSqHW0/DAPPJ7c7lyk6OsFed+lZ1Vf+wI2ALmaC/w9sqLFt2nXAI84Bc7v1g4xr7oCi1sW1588l2X/0T0Egmecma4Txbt9xMB1bV5OBADRRTTRmaBUY4k0nDWa0yRuukUw70JfQNszgmF9DKK21D1PgBWmdh2FmHC2wvnIiU2Btb+qoIRNv12+j93iK+AnI91704aVpUBea1LwWvcb7Qadxu/GG5effSOhrBFRQeBzNtr+j8Ll7cAYu3gIC53dTyAAuE4zlLiFkXt/EqODVaKNw35NMfh/kMN5624b7+/91ckKHG92Mygj1m2zfx3Vh2qblwV4mVhLS+yEg03o+jQwTGl3tlTE5HrBfZ1aM6Eeuk8URtw+l9dOTr+lAPu72YZTi1nAXD/WIlFhSvTYu0DFTIckXSLvUkZD84e3593mrD3EVaPuLr34/I4k2f/13J0TX5hMfFlzc13GoJ1PJ8GW2cw4OXZsX+cZVvbiVLMa+3bhBENzqr0IjluxOBuW06oLP1satZ7D4W+1+8X+EdT7Fpshy4YaVoFTh1HGVrrjrmkfU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(346002)(376002)(136003)(366004)(54906003)(86362001)(38100700002)(6512007)(8936002)(8676002)(64756008)(6506007)(6486002)(71200400001)(4326008)(66946007)(66556008)(66476007)(66446008)(122000001)(76116006)(5660300002)(316002)(6916009)(2616005)(186003)(2906002)(7416002)(3450700001)(83380400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?a0dTTVJUdEloaGRXbW1pQXpnY29QV2VqQ3lXMVRQNzhTL1htNDN6Q3B6Ymh6?=
 =?utf-8?B?emVnNDVxV2xwZ3U2ZzRSTUhWOEVBeHZqclZyRy9MOXhqQ0hRUVhSNXJZMm9Y?=
 =?utf-8?B?ak5VR0VSYWNJQzB0ZTRSY0VKZzFmb2R4MmUwNVBxVDBqNktLRC9GbjRuVFRy?=
 =?utf-8?B?VGwwYzFGVUpSYXR6YkdHOHpyZzEvOXh0RTBWMm8rWlZncGgzeGFGZXIwVjdQ?=
 =?utf-8?B?UmNZRXdSMXgvYjhneGJmMXNwUnF3bWgwbHhhN3k2aHo2RW4vQkg3Tis2Z3o3?=
 =?utf-8?B?VTRRRkVwdk9hc2NjSS9tUGJWK1hrMWU4S0pGMzBhdUhJVk1ISU03YjZoSDR2?=
 =?utf-8?B?aVhqRWhWM201d0RuOHRCM0tYa1dKWTd1eVZoYU5ZQ0dZNitXdFMxeEs5aFNO?=
 =?utf-8?B?YXpNVUpTYm0yeDhpcGVvL21ScU5Cai8zSEY3RTFYanoxeXlTQ3d4ZGFKeEEx?=
 =?utf-8?B?R3VTSldIdlpjQzlWSjhpbHo1ekpyTlVwSElVcUJTZFl4dmJoVGVPSVU1Ly9o?=
 =?utf-8?B?STdockt5UFI4MGM3VE9EWmw5SVdEU3ZGQVFONjcrSCtLdkwySFViR0E5bjZl?=
 =?utf-8?B?R0ZWM3d1SmplV3REZ0lyWi85SG4weGdsOW5QUmp2cjVuQXdhMXphemg1VUw5?=
 =?utf-8?B?cEFKdmN6TDlITk8wbzhsSi9nQUk4dlJHVUpNdzM3MzRkWGNaN1l1QktiK1dm?=
 =?utf-8?B?REg1VzZEajB2dVJPcWJFU3lCNlpMNjJnMWhYNGhId3ZJQW1hQWRIaWVKamo2?=
 =?utf-8?B?VnVPeFB4MDQ2RGFoMmtyV09HNXA4S2FocFQrTnB4dmgzR3dDWHFnM1M0K05u?=
 =?utf-8?B?S0kxT1dqNXBuM0Y5YU95WHdJK0t0ek5pSUtTME55RzBDdFo1V0kyMUQvWnh3?=
 =?utf-8?B?L0lqMjgvU0xQQWIxYmRndFJvSndOSm53blhlK3B6S0hwNG9keFR0MGdETEtF?=
 =?utf-8?B?OXBMdkp3Y1AzS0VoNXlyVjlKYVprMkJPQ3Zwa1J6RzVWNFNQZEtHSVcvR3lr?=
 =?utf-8?B?ZFNUNFVOMHIxQkpDZTEzQ1hNY2pGV2pDMnBjUVpjSnMyeTZlOElJZThZNUJY?=
 =?utf-8?B?eTdLZnZOUnNUODdnY3RYOS90UkFTQVVQckpNc0ZuMDJFYjZZb3FZbTZYbnVk?=
 =?utf-8?B?R2ZZakNvbDlEOEV2UndmaC9yYm9XN2ZUb3ZTazBpN2RRMGtXcFhSUmllVmhh?=
 =?utf-8?B?TGdVcDJ3dGdEa09OUE1NREtTRlg2N2ZKQXpQd2hSZmx4YThzS3VUYWpVdFJW?=
 =?utf-8?B?WTNUY0NTdCtYUmhWOWxCdUgwRUNBZ0RKdG1QNFZRU2cxZE8wR2I3QnhXWFBX?=
 =?utf-8?B?WFZPeXdUckNCZVV2MWVGODI5QnJ5K045N1IwNGxmNjVTaFVQeE0veCt2L2Nr?=
 =?utf-8?B?K2E1eXRHdDlWekxtMlhKS2pWY1BzQ2Z4blNCSVdMeURvUnZCNVRyelhUUUJw?=
 =?utf-8?B?ZjJkcXlobkVRU1BwaS85NUhyN2JSaUFwZlVPOHVaSWl2bjJZV1dIcEp5c2h3?=
 =?utf-8?B?UGhSd2VuZVV2RUU0WThoMUZRVlI0c0tGZG12bDNUYnY5U0VHMTNoYkh0cXF1?=
 =?utf-8?B?bXV5UkZ1RUd0MzBYN1ZPaktUZXExckw5YmNaN2Y5N2h4ZVZ0dWN4QnNVYXBN?=
 =?utf-8?B?VHN6dEV4bURlMWZPU3Rsa2M4L0Z4MDhmc3h2SXlDM1FGZC9uREhmVGdjU09D?=
 =?utf-8?B?NDJNNDBDUE5Pc0tXYnFaRDhlTU5NbW53Rk11L0JZNW9OeU1hRG5FUmUzMndw?=
 =?utf-8?B?VlhWVjBlaG40UEN2MHh2aW9SeE9obGxuU3lTcGNyOTNDdEV3MHFUVXJaVi8r?=
 =?utf-8?Q?w6HOR0X7QWusXBlT5kNfD+Iu+MI1paO/mcwdk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D27CA566F5F6B2488A14DDFC74D06B84@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cee087-89f9-4951-7419-08d9153d93dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 12:00:46.6063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWDBX1rCgym28Sl4cOZ+Qjv9jkbJc8caU1Pm3GP+FlTVKNlW7DGtqM3CnofqZFYriCpD7BkRfxAOx8Am4cEroPojclE6zvpNsaFBQRKzpebSaGbQgtVKjdawG7riw8iu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2172
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgUGV0ciwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IQ0KDQpPbiBXZWQsIDIwMjEtMDUtMTIg
YXQgMTA6MjAgKzAyMDAsIFBldHIgTWxhZGVrIHdyb3RlOg0KPiBPbiBNb24gMjAyMS0wNS0xMCAx
NDoyODozMCwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPiA+IFRoZXJlIGNhbiBiZSBmZXcgY2Fz
ZXMgd2hlbiB3ZSBuZWVkIHRvIHNodXQtZG93biB0aGUgc3lzdGVtIGluDQo+ID4gb3JkZXIgdG8N
Cj4gPiBwcm90ZWN0IHRoZSBoYXJkd2FyZS4gQ3VycmVudGx5IHRoaXMgaXMgZG9uZSBhdCBlYXN0
IGJ5IHRoZSB0aGVybWFsDQo+ID4gY29yZQ0KPiA+IHdoZW4gdGVtcGVyYXR1cmUgcmFpc2VzIG92
ZXIgY2VydGFpbiBsaW1pdC4NCj4gPiANCj4gPiBTb21lIFBNSUNzIGNhbiBhbHNvIGdlbmVyYXRl
IGludGVycnVwdHMgZm9yIGV4YW1wbGUgZm9yIG92ZXItDQo+ID4gY3VycmVudCBvcg0KPiA+IG92
ZXItdm9sdGFnZSwgdm9sdGFnZSBkcm9wcywgc2hvcnQtY2lyY3VpdCwgLi4uIGV0Yy4gT24gc29t
ZQ0KPiA+IHN5c3RlbXMNCj4gPiB0aGVzZSBhcmUgYSBzaWduIG9mIGhhcmR3YXJlIGZhaWx1cmUg
YW5kIG9ubHkgdGhpbmcgdG8gZG8gaXMgdHJ5IHRvDQo+ID4gcHJvdGVjdCB0aGUgcmVzdCBvZiB0
aGUgaGFyZHdhcmUgYnkgc2h1dHRpbmcgZG93biB0aGUgc3lzdGVtLg0KPiA+IA0KPiA+IEFkZCBz
aHV0LWRvd24gbG9naWMgd2hpY2ggY2FuIGJlIHVzZWQgYnkgYWxsIHN1YnN5c3RlbXMgaW5zdGVh
ZCBvZg0KPiA+IGltcGxlbWVudGluZyB0aGUgc2h1dGRvd24gaW4gZWFjaCBzdWJzeXN0ZW0uIFRo
ZSBsb2dpYyBpcyBzdG9sZW4NCj4gPiBmcm9tDQo+ID4gdGhlcm1hbF9jb3JlIHdpdGggZGlmZmVy
ZW5jZSBvZiB1c2luZyBhdG9taWNfdCBpbnN0ZWFkIG9mIGEgbXV0ZXgNCj4gPiBpbg0KPiA+IG9y
ZGVyIHRvIGFsbG93IGNhbGxzIGRpcmVjdGx5IGZyb20gSVJRIGNvbnRleHQuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogTWF0dGkgVmFpdHRpbmVuIDxtYXR0aS52YWl0dGluZW5AZmkucm9obWV1
cm9wZS5jb20+DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yZWJvb3QuYyBiL2tlcm5l
bC9yZWJvb3QuYw0KPiA+IGluZGV4IGE2YWQ1ZWIyZmE3My4uNWRhOGM4MGEyNjQ3IDEwMDY0NA0K
PiA+IC0tLSBhL2tlcm5lbC9yZWJvb3QuYw0KPiA+ICsrKyBiL2tlcm5lbC9yZWJvb3QuYw0KPiA+
IEBAIC01MTgsNiArNTE5LDg1IEBAIHZvaWQgb3JkZXJseV9yZWJvb3Qodm9pZCkNCj4gPiAgfQ0K
PiA+ICBFWFBPUlRfU1lNQk9MX0dQTChvcmRlcmx5X3JlYm9vdCk7DQo+ID4gIA0KPiA+ICsvKioN
Cj4gPiArICogaHdfZmFpbHVyZV9lbWVyZ2VuY3lfcG93ZXJvZmZfZnVuYyAtIGVtZXJnZW5jeSBw
b3dlcm9mZiB3b3JrDQo+ID4gYWZ0ZXIgYSBrbm93biBkZWxheQ0KPiA+ICsgKiBAd29yazogd29y
a19zdHJ1Y3QgYXNzb2NpYXRlZCB3aXRoIHRoZSBlbWVyZ2VuY3kgcG93ZXJvZmYNCj4gPiBmdW5j
dGlvbg0KPiA+ICsgKg0KPiA+ICsgKiBUaGlzIGZ1bmN0aW9uIGlzIGNhbGxlZCBpbiB2ZXJ5IGNy
aXRpY2FsIHNpdHVhdGlvbnMgdG8gZm9yY2UNCj4gPiArICogYSBrZXJuZWwgcG93ZXJvZmYgYWZ0
ZXIgYSBjb25maWd1cmFibGUgdGltZW91dCB2YWx1ZS4NCj4gPiArICovDQo+ID4gK3N0YXRpYyB2
b2lkIGh3X2ZhaWx1cmVfZW1lcmdlbmN5X3Bvd2Vyb2ZmX2Z1bmMoc3RydWN0IHdvcmtfc3RydWN0
DQo+ID4gKndvcmspDQo+ID4gK3sNCj4gPiArCS8qDQo+ID4gKwkgKiBXZSBoYXZlIHJlYWNoZWQg
aGVyZSBhZnRlciB0aGUgZW1lcmdlbmN5IHNodXRkb3duIHdhaXRpbmcNCj4gPiBwZXJpb2QgaGFz
DQo+ID4gKwkgKiBleHBpcmVkLiBUaGlzIG1lYW5zIG9yZGVybHlfcG93ZXJvZmYgaGFzIG5vdCBi
ZWVuIGFibGUgdG8NCj4gPiBzaHV0IG9mZg0KPiA+ICsJICogdGhlIHN5c3RlbSBmb3Igc29tZSBy
ZWFzb24uDQo+ID4gKwkgKg0KPiA+ICsJICogVHJ5IHRvIHNodXQgZG93biB0aGUgc3lzdGVtIGlt
bWVkaWF0ZWx5IHVzaW5nDQo+ID4ga2VybmVsX3Bvd2VyX29mZg0KPiA+ICsJICogaWYgcG9wdWxh
dGVkDQo+ID4gKwkgKi8NCj4gPiArCVdBUk4oMSwgIkhhcmR3YXJlIHByb3RlY3Rpb24gdGltZWQt
b3V0LiBUcnlpbmcgZm9yY2VkDQo+ID4gcG93ZXJvZmZcbiIpOw0KPiA+ICsJa2VybmVsX3Bvd2Vy
X29mZigpOw0KPiANCj4gV0FSTigpIGxvb2sgbGlrZSBhbiBvdmVya2lsbCBoZXJlLiBJdCBwcmlu
dHMgbWFueSBsaW5lcyB0aGF0IGFyZSBub3QNCj4gbXVjaCB1c2VmdWwgaW4gdGhpcyBjYXNlLiBU
aGUgZnVuY3Rpb24gaXMgY2FsbGVkIGZyb20gd2VsbC1rbm93bg0KPiBjb250ZXh0ICh3b3JrcXVl
dWUgd29ya2VyKS4NCg0KVGhpcyB3YXMgdGhlIGV4aXN0aW5nIGNvZGUgd2hpY2ggSSBzdG9sZSBm
cm9tIHRoZSB0aGVybWFsX2NvcmUuIEkga2luZA0Kb2YgdGhpbmsgdGhhdCBleWUtY2F0Y2hpbmcg
V0FSTiBpcyBhY3R1YWxseSBhIGdvb2QgY2hvaWNlIGhlcmUuIERvaW5nDQphdXRvbm9tb3VzIHBv
d2VyLW9mZiB3aXRob3V0IGEgV0FSTmluZyBkb2VzIG5vdCBzb3VuZCBnb29kIHRvIG1lIDopDQoN
Cj4gQWxzbyBiZSBhd2FyZSB0aGF0ICJwYW5pY19vbl93YXJuIiBjb21tYW5kbGluZSBvcHRpb24g
d2lsbCB0cmlnZ2VyDQo+IHBhbmljKCkgaGVyZS4NCg0KSG1tLi4gSWYgcGFuaWMoKSBoYW5ncyB0
aGUgc3lzdGVtIHRoYXQgbWlnaHQgaW5kZWVkIGJlIGEgcHJvYmxlbS4gTm93DQp3ZSBhcmUgKGFn
YWluKSBvbiBhIHRlcnJpdG9yeSB3aGljaCBJIGRvbid0IGtub3cgd2VsbC4gSSdkIGFwcHJlY2lh
dGUNCmFueSBpbnB1dCBmcm9tIHRoZXJtYWwgZm9sa3MgYW5kIE1hcmsuIEkgZG9uJ3QgbGlrZSB0
aGUgaWRlYSBvZiBtYWtpbmcNCmV4dHJlbWUgdGhpbmdzIGxpa2UgcG93ZXItb2ZmIHcvbyB3ZWxs
IHZpc2libGUgbG9nLXRyYWNlLiBUaHVzIEkgd291bGQNCmxpa2UgdG8gaGF2ZSBXQVJOKCktbGlr
ZSBleWUtY2F0Y2hlciwgZXZlbiBpZiB0aGUgY2FsbC10cmFjZSB3YXMgbm90DQp0b28gdmFyeWlu
Zy4gSXQgd2lsbCBhdCBsZWFzdCBwb2ludCB0byB0aGlzIHdvcmtlci4gQW55IGJldHRlcg0Kc3Vn
Z2VzdGlvbnMgdGhhbiBXQVJOKCk/DQoNCj4gDQo+ID4gKwkvKg0KPiA+ICsJICogV29yc3Qgb2Yg
dGhlIHdvcnN0IGNhc2UgdHJpZ2dlciBlbWVyZ2VuY3kgcmVzdGFydA0KPiA+ICsJICovDQo+ID4g
KwlXQVJOKDEsDQo+ID4gKwkgICAgICJIYXJkd2FyZSBwcm90ZWN0aW9uIHNodXRkb3duIGZhaWxl
ZC4gVHJ5aW5nIGVtZXJnZW5jeQ0KPiA+IHJlc3RhcnRcbiIpOw0KPiA+ICsJZW1lcmdlbmN5X3Jl
c3RhcnQoKTsNCj4gDQo+IFR3byBjb25zZWN1dGl2ZSBXQVJOKCkgY2FsbHMgYXJlIGV2ZW4gbGVz
cyB1c2VmdWwuIFRoZXkgYXJlIGV5ZQ0KPiBjYXRjaGluZyBidXQgaXQgaXMgaGFyZCB0byBmaW5k
IHRoZSBvbmx5IHVzZWZ1bCBsaW5lIHdpdGgNCj4gdGhlIGN1c3RvbSBtZXNzYWdlLg0KDQpJIHRo
aW5rIHlvdSBhcmUgcmlnaHQuIE9uZSBXQVJOIHNob3VsZCBiZSBlbm91Z2ggdG8gcG9pbnQgaGVy
ZS4gVGhpcw0KbGFzdCBvbmUgY291bGQgYmUganVzdCBhbiBhZGRpdGlvbmFsIHByaW50Lg0KDQpC
ZXN0IFJlZ2FyZHMNCgktLU1hdHRpIFZhaXR0aW5lbg0K
