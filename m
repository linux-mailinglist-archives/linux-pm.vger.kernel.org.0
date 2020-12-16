Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D548A2DC1EF
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 15:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgLPONX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Dec 2020 09:13:23 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:36360 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLPONW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2020 09:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1608128001; x=1639664001;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7aFXycUr/Ef5ERvRXYJHmY5IZFHPe0UOsvrHQnx4iQg=;
  b=Ny/h1XLuQb+ryX7yoYiTOliB9NZdoTWcAXYDAhBjFPQtJtErKiX2nfOj
   joPasgLWMdR4o3Vm1gOCMd3n4jhtoNDorFm+P3K4N0vVWWX7CSbA2h7o6
   7usV5IzCxR1frgsWARuY0EPqXnM8yim2xap8OmyqMJcXwenuqroIINq+2
   wASgnDx76Lx5vfEmGPci+2dcYql9KR1A6AqxGBz5bmfv+doAuGiqg4i5O
   kNzGCHoQAwKUv/Zni39l/G7BBQb0G5vgHllHCIWAG6xwxuaFWfHxQnzLb
   PhDNi72VbczbbPLF6yQdFScWvfvRmraXZz8FAasIlR9QRxuQK8mEci3ya
   g==;
IronPort-SDR: Z3lS6T+D1dlkpV9Gx78KMO8o7svpYar+9UlWm/ajSwf+epaJHR6QWfnB6H4Hm47ZmPOy4G/jaJ
 kaHDl90L657RtDP1217WxwOVBBbyuFr9zdyBEPcy60eSPIgzu+h+I5Hn1exm317ikD2mCLowfm
 isd5bSZIaQNrWDu9NA0Qf2grMbBpISVeny1T/dYDbAOhA40tzhgIOuSkqSY9cscMUxXAbRwdz0
 gKOvmZdv+Hl4e4VaVu5Zj6qNOWqnOn9X2XPLlo6t5wLixdZTUJJ04d8i4Y0TLLgmZwy7sv2HHO
 P2M=
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="103001700"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2020 07:11:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Dec 2020 07:11:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 16 Dec 2020 07:11:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AC3472RxUb8qBfcBoFGfRse7xL8qD1cm/Ot72yl1MK3cGjRz7EXxIwEyy/C1Oj54AmQy/DkooOaOKI1INQgBzEgNEoTRFY0s0x2QPqk4ssHqFxAdlOw9VwJIaDBPfeJT9/Bn2R6EdojxQ2zOMDwzHqoaKPuQPRayqcN+UrWR9CwQ5YF34aGcTXhkQjp6fY0baBragoMzUIbzGOUxtn1LpXdYuslf9LzQoENfSg51szZkWonHjMBjMqceGoT+reQkd8c3G49/3dGFP9OAkj7UmUd5yFaEk0bkl7k+EmbWtEWGt9ACHygKsNAgegD6x7rp9h3tdNKbeTrbzi/N/Yl5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aFXycUr/Ef5ERvRXYJHmY5IZFHPe0UOsvrHQnx4iQg=;
 b=F5h5/ynR43d8GZDE8mf8WUqvUmbrVIN1VhQAg5FXDNpSJIVQqHeSXPQwguXAYNaGznDgJpBGhW0Hs0wrwZzJTkgQMUaCUxab5/RHAXro0eFXdrXXF/frm1d89z3M56FqMGe8IvcNBGcJd6EzV+yAaDN23wgDnVyXnfuDo5e35T8dTkhLQ61+qbqo9Md1E3mwLDtp4JnD9tbmB8cS54dbUHQ0jlHHITGcwnBHZpVxskZFJLW1xdHOrwaTckvgT1KRseRzTC16xZlouYNeRvRDSvapnFzRoYQgXqke+onA//FnpXBGyf0CcFxjLOFxHoLRWU6hJyM9t3Ik3eNCndHfUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aFXycUr/Ef5ERvRXYJHmY5IZFHPe0UOsvrHQnx4iQg=;
 b=BiHuQOZpKRB1s9GQBx8SN10xozKtXn5vGyS0+xPnrKRxGXUccnpaBLbg05LqCBTVfTt12PFHcxqbz1rXWlTDja/p6CpeY7XtJEvQ/Xq0NqYakIxQnbzEbL8gJsoWfkoM9aFRqGiBwo0Hcoz05EyzbWSE3CQ5Yb4aBg2o8+jWFYM=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB4722.namprd11.prod.outlook.com (2603:10b6:5:2a7::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Wed, 16 Dec 2020 14:11:51 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::eded:bdb6:c6f1:eb3e]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::eded:bdb6:c6f1:eb3e%4]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 14:11:51 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <sre@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 3/3] power: reset: at91-sama5d2_shdwc: add support for
 sama7g5
Thread-Topic: [PATCH 3/3] power: reset: at91-sama5d2_shdwc: add support for
 sama7g5
Thread-Index: AQHW07Vm8svOvDAvX0CwyDsoq7Wrnw==
Date:   Wed, 16 Dec 2020 14:11:51 +0000
Message-ID: <0e2b56e3-500b-f66d-ae32-c394e4d101fe@microchip.com>
References: <1608123453-1423-1-git-send-email-claudiu.beznea@microchip.com>
 <1608123453-1423-4-git-send-email-claudiu.beznea@microchip.com>
 <20201216134532.GH2814589@piout.net>
In-Reply-To: <20201216134532.GH2814589@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.76.227.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 202b122a-b2c5-4ee0-0894-08d8a1cc8903
x-ms-traffictypediagnostic: DM6PR11MB4722:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4722F3D160B938C43D99BD9187C50@DM6PR11MB4722.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gYkZ3/qtxTR08B5lb/GqSyYAharoFW5dKhKjXfqdUX+ugpXr2csHBoD7Und3AnguiJFNHFx83ONm7AGtBflI3Rd5uywoiQq4igSIwhx+MyHOSF6UUtoMnUrGnZoQHzcGAVEMC+nYEJjOi6xrwxFH2jVJD0KMCO/rnPN9b/SpU8vLVk5SZBRPJftaUa3/rhIAE4yJTQ4BUmmJIVhduERK09GGEPMX8s2WQL5yrF+TK2EJaExlCQd1nP8vZrvn/m71G0NtUXXx8q3fKbVjXlPqpE6+JNXHlPfqd59eIMY7lRDrquwZqBVOsEkITrvZIGGYAk5eA3N+/McF8aHA2FsYcCGHq16RCDQkO3zd8hWcSlzWmPhWoHqkL536MX4v4Pg7WgVO/92mCBFfTVDE8Vwzuv4JdjMU64NUEqiSSMhWY9ZSVH0V7Hh9StiaYHsMmdIw4fOr+sctwytkRjpBp7TAhF4bMnpc+rBzJ/UmSzZ0dCS16O3VWAP7oWowuqEED3X3ihXGm8XGUaUp5rNn2ouQ3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(136003)(366004)(346002)(8936002)(66476007)(66446008)(66556008)(4326008)(54906003)(83380400001)(26005)(6486002)(36756003)(316002)(91956017)(31686004)(8676002)(76116006)(966005)(71200400001)(64756008)(86362001)(2616005)(478600001)(31696002)(66946007)(6512007)(186003)(5660300002)(6506007)(2906002)(6916009)(53546011)(138113003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WU1lUUJPZEladytON0NYeUx0WVRlZTg5SkszMThHWFU2MlBSak44SzRtMmpn?=
 =?utf-8?B?bWY0MEdCNGx1cForMlJXL3JBRVZud0V4MG1GS01udUYvTzlqRHMrcGF1N2tj?=
 =?utf-8?B?VTNJdHlqbUVsRzVEWU1vM0czV0RqSGdPWjdzK3dCbTYxWDB1OW0wVi9QSkxj?=
 =?utf-8?B?cmd5SlJWbmZjM1JNbEZSTGlQbUpjVERTY1N5dUFsb0JEZUFGaDB3WGduaUVh?=
 =?utf-8?B?N1AvZk53UzF1aURtb0lDQXA0djFPWFJ4aWl3Z0NZNVNGY2x0WHFoUVozYno3?=
 =?utf-8?B?d0ozNFpSUko2cVg2U01HaFRuUkxtQmorZEo3VkdkNnU3VE5kOUJ2Nm1VdVRC?=
 =?utf-8?B?a0c3ZGhsOVBtOVVTUDJPS1NtVnU5eTBVMWhpREVaVi9WS3FHbEhhbTd0MFl4?=
 =?utf-8?B?K3VzTzJHRXViaEJQUktKalBYV2pVRFlGMkI0ZFk3TGhMQjViNVdCZXVDMUtM?=
 =?utf-8?B?aEJEcTY1ZXN1MEJ3bmNxUzJZOUM1R29aUCs1V0pkMmtLTm8zREJTUWFXWXgz?=
 =?utf-8?B?UHRMak5iQnV1NUR5T1NiWEdGTENDVkdkQjRBTVc2RjFGdGdqamxqSFpEN3lz?=
 =?utf-8?B?VFdnZ09sNzQwSkhHUi8rVmhvYSsxazNkY1d6RTliVnZWNVZoR0RSTlZJM1Nj?=
 =?utf-8?B?MEVVWjFTRkMxWjdkTTV1My8wZ3d2YWlvZ2R1dmNSSjZvWUV6WFdsQW83OUdF?=
 =?utf-8?B?TGVUbXlyYmNkd1V4SlFxM1d6RnF6SjhzUUpHdWNPM1NkWTNmSjlxckVpUGVC?=
 =?utf-8?B?UXlHN2dxSThpUU8yZk9QUS8rT0RCZEFzV01xZ2xpU3BRdFhFVW9FNldLQi93?=
 =?utf-8?B?RWV0R3kxc0V4NTJ2UC9JaGNQby9CVCtsY2xRYThzY0VMTHpQRU1RN2VqeHNw?=
 =?utf-8?B?cEEwSkhKSWIvNmUrK0RwOXB4YTBxWXl6T0xwTTk2bkgrbzFlb3ZXRGw5eDln?=
 =?utf-8?B?NVRUbHJ2UGZiM3JQVWpRM2ZZVlUvNW5RWkFKV0d0a0lVYTl6RjJiRmlXR0ti?=
 =?utf-8?B?b2pDMHBxc3ZGVUxIck5zMk11MXE5M3laelA0dGVwc3FyNEtoOHY1RGpGMXBr?=
 =?utf-8?B?cC95VlhlRklVYVd0RjlCYnAybFFzQWRIYkEybTl1S2Mxd0t2VHRQOUphM2dX?=
 =?utf-8?B?SVQva1lzUnVaKzJVYXdxcS9WUzFLUCtzOTR6a0ZYSXhvTGxkV0t4YkdXdGNI?=
 =?utf-8?B?bkgxWjM2bnh0QWZZejF6TVpFRkdsakJhWHYrd2wyS04vSmtYTHV4Q0JDUjQ0?=
 =?utf-8?B?ZXpCdDNTbUVjbk90MlFtRkVRaXFDcGVGZDl0N3dGUTdJUmJOKzJnTnBuekZK?=
 =?utf-8?Q?eqm3AFcJITIB6sb2yjCogcZJ0DE3yIlZRb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <778570044C2C054E950C97F9B0C40164@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 202b122a-b2c5-4ee0-0894-08d8a1cc8903
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 14:11:51.5753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lnMyEoE6nbw5hL2EG952RMbGiajImBCPTc1gq6/0hXexD834ov+5/xLwXn4rG5ZzVOEA6sUmZs8MRX6IaMuOzLMyn8REUmytWKYWBb7J2SM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4722
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCk9uIDE2LjEyLjIwMjAgMTU6NDUsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDE2LzEyLzIwMjAgMTQ6NTc6
MzMrMDIwMCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+PiBBZGQgc3VwcG9ydCBmb3IgU0FNQTdH
NSBieSBhZGRpbmcgcHJvcGVyIHN0cnVjdCByZWdfY29uZmlnIHN0cnVjdHVyZQ0KPj4gYW5kIHNp
bmNlIFNBTUE3RzUgaXMgbm90IGN1cnJlbnRseSBvbiBMUEREUiBzZXR1cHMgdGhlIGNvbW1pdCBh
bHNvDQo+PiBhdm9pZCB0aGUgbWFwcGluZyBvZiBERFIgY29udHJvbGxlci4NCj4+DQo+IA0KPiBI
b25lc3RseSwgSSB3b3VsZG4ndCBsZWF2ZSB0aGUgTFBERFIgcGFydCBvdXQgYmVjYXVzZSB0aGVy
ZSBpcyBubw0KPiBndWFyYW50ZWUgYW55b25lIHdpbGwgdGhpbmsgYWJvdXQgaXQgd2hlbiB0aGV5
IGhhdmUgYSBkZXNpZ24gd2l0aCBMUEREUg0KPiBhbmQgYXMgYSBjb25zZXF1ZW5jZSwgdGhlaXIg
ZGV2aWNlIHdpbGwgYmVoYXZlIHByb3Blcmx5IGJ1dCB3aWxsIGJlDQo+IHZlcnkgc2hvcnQgbGl2
ZWQuDQoNClRoZSBpZGVhIHdhc24ndCB0byBsZWF2ZSBpdCBvdXQuIEl0IGhhcyB0byBiZSBoYW5k
bGVkIGRpZmZlcmVudGx5IG9uDQpTQU1BN0c1IGFzIGl0IGVtYmVkcyBhIGRpZmZlcmVudCBERFIg
Y29udHJvbGxlci4NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdQ0KDQo+IA0KPj4gU2lnbmVkLW9mZi1i
eTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0N
Cj4+ICBkcml2ZXJzL3Bvd2VyL3Jlc2V0L2F0OTEtc2FtYTVkMl9zaGR3Yy5jIHwgNzIgKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgNTQgaW5zZXJ0
aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93
ZXIvcmVzZXQvYXQ5MS1zYW1hNWQyX3NoZHdjLmMgYi9kcml2ZXJzL3Bvd2VyL3Jlc2V0L2F0OTEt
c2FtYTVkMl9zaGR3Yy5jDQo+PiBpbmRleCAzOTk2MTY3ZjY3NmYuLmEzMzQyYzhjMzcyOCAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1zYW1hNWQyX3NoZHdjLmMNCj4+
ICsrKyBiL2RyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1zYW1hNWQyX3NoZHdjLmMNCj4+IEBAIC03
OCw5ICs3OCwxNSBAQCBzdHJ1Y3QgcG1jX3JlZ19jb25maWcgew0KPj4gICAgICAgdTggbWNrcjsN
Cj4+ICB9Ow0KPj4NCj4+ICtzdHJ1Y3QgZGRyY19yZWdfY29uZmlnIHsNCj4+ICsgICAgIHUzMiB0
eXBlX29mZnNldDsNCj4+ICsgICAgIHUzMiB0eXBlX21hc2s7DQo+PiArfTsNCj4+ICsNCj4+ICBz
dHJ1Y3QgcmVnX2NvbmZpZyB7DQo+PiAgICAgICBzdHJ1Y3Qgc2hkd2NfcmVnX2NvbmZpZyBzaGR3
YzsNCj4+ICAgICAgIHN0cnVjdCBwbWNfcmVnX2NvbmZpZyBwbWM7DQo+PiArICAgICBzdHJ1Y3Qg
ZGRyY19yZWdfY29uZmlnIGRkcmM7DQo+PiAgfTsNCj4+DQo+PiAgc3RydWN0IHNoZHdjIHsNCj4+
IEBAIC0yNjIsNiArMjY4LDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmVnX2NvbmZpZyBzYW1h
NWQyX3JlZ19jb25maWcgPSB7DQo+PiAgICAgICAucG1jID0gew0KPj4gICAgICAgICAgICAgICAu
bWNrciAgICAgICAgICAgPSAweDMwLA0KPj4gICAgICAgfSwNCj4+ICsgICAgIC5kZHJjID0gew0K
Pj4gKyAgICAgICAgICAgICAudHlwZV9vZmZzZXQgICAgPSBBVDkxX0REUlNEUkNfTURSLA0KPj4g
KyAgICAgICAgICAgICAudHlwZV9tYXNrICAgICAgPSBBVDkxX0REUlNEUkNfTUQNCj4+ICsgICAg
IH0sDQo+PiAgfTsNCj4+DQo+PiAgc3RhdGljIGNvbnN0IHN0cnVjdCByZWdfY29uZmlnIHNhbTl4
NjBfcmVnX2NvbmZpZyA9IHsNCj4+IEBAIC0yNzUsNiArMjg1LDIzIEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgcmVnX2NvbmZpZyBzYW05eDYwX3JlZ19jb25maWcgPSB7DQo+PiAgICAgICAucG1jID0g
ew0KPj4gICAgICAgICAgICAgICAubWNrciAgICAgICAgICAgPSAweDI4LA0KPj4gICAgICAgfSwN
Cj4+ICsgICAgIC5kZHJjID0gew0KPj4gKyAgICAgICAgICAgICAudHlwZV9vZmZzZXQgICAgPSBB
VDkxX0REUlNEUkNfTURSLA0KPj4gKyAgICAgICAgICAgICAudHlwZV9tYXNrICAgICAgPSBBVDkx
X0REUlNEUkNfTUQNCj4+ICsgICAgIH0sDQo+PiArfTsNCj4+ICsNCj4+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IHJlZ19jb25maWcgc2FtYTdnNV9yZWdfY29uZmlnID0gew0KPj4gKyAgICAgLnNoZHdj
ID0gew0KPj4gKyAgICAgICAgICAgICAud2t1cF9waW5faW5wdXQgPSAwLA0KPj4gKyAgICAgICAg
ICAgICAubXJfcnRjd2tfc2hpZnQgPSAxNywNCj4+ICsgICAgICAgICAgICAgLm1yX3J0dHdrX3No
aWZ0ID0gMTYsDQo+PiArICAgICAgICAgICAgIC5zcl9ydGN3a19zaGlmdCA9IDUsDQo+PiArICAg
ICAgICAgICAgIC5zcl9ydHR3a19zaGlmdCA9IDQsDQo+PiArICAgICB9LA0KPj4gKyAgICAgLnBt
YyA9IHsNCj4+ICsgICAgICAgICAgICAgLm1ja3IgICAgICAgICAgID0gMHgyOCwNCj4+ICsgICAg
IH0sDQo+PiAgfTsNCj4+DQo+PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYXQ5
MV9zaGR3Y19vZl9tYXRjaFtdID0gew0KPj4gQEAgLTI4NSw2ICszMTIsMTAgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYXQ5MV9zaGR3Y19vZl9tYXRjaFtdID0gew0KPj4gICAg
ICAgew0KPj4gICAgICAgICAgICAgICAuY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1z
aGR3YyIsDQo+PiAgICAgICAgICAgICAgIC5kYXRhID0gJnNhbTl4NjBfcmVnX2NvbmZpZywNCj4+
ICsgICAgIH0sDQo+PiArICAgICB7DQo+PiArICAgICAgICAgICAgIC5jb21wYXRpYmxlID0gIm1p
Y3JvY2hpcCxzYW1hN2c1LXNoZHdjIiwNCj4+ICsgICAgICAgICAgICAgLmRhdGEgPSAmc2FtYTdn
NV9yZWdfY29uZmlnLA0KPj4gICAgICAgfSwgew0KPj4gICAgICAgICAgICAgICAvKnNlbnRpbmVs
Ki8NCj4+ICAgICAgIH0NCj4+IEBAIC0yOTQsNiArMzI1LDcgQEAgTU9EVUxFX0RFVklDRV9UQUJM
RShvZiwgYXQ5MV9zaGR3Y19vZl9tYXRjaCk7DQo+PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9k
ZXZpY2VfaWQgYXQ5MV9wbWNfaWRzW10gPSB7DQo+PiAgICAgICB7IC5jb21wYXRpYmxlID0gImF0
bWVsLHNhbWE1ZDItcG1jIiB9LA0KPj4gICAgICAgeyAuY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAs
c2FtOXg2MC1wbWMiIH0sDQo+PiArICAgICB7IC5jb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYW1h
N2c1LXBtYyIgfSwNCj4+ICAgICAgIHsgLyogU2VudGluZWwuICovIH0NCj4+ICB9Ow0KPj4NCj4+
IEBAIC0zNTUsMzAgKzM4NywzNCBAQCBzdGF0aWMgaW50IF9faW5pdCBhdDkxX3NoZHdjX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiAgICAgICAgICAgICAgIGdvdG8gY2xr
X2Rpc2FibGU7DQo+PiAgICAgICB9DQo+Pg0KPj4gLSAgICAgbnAgPSBvZl9maW5kX2NvbXBhdGli
bGVfbm9kZShOVUxMLCBOVUxMLCAiYXRtZWwsc2FtYTVkMy1kZHJhbWMiKTsNCj4+IC0gICAgIGlm
ICghbnApIHsNCj4+IC0gICAgICAgICAgICAgcmV0ID0gLUVOT0RFVjsNCj4+IC0gICAgICAgICAg
ICAgZ290byB1bm1hcDsNCj4+IC0gICAgIH0NCj4+ICsgICAgIGlmIChhdDkxX3NoZHdjLT5yY2Zn
LT5kZHJjLnR5cGVfbWFzaykgew0KPj4gKyAgICAgICAgICAgICBucCA9IG9mX2ZpbmRfY29tcGF0
aWJsZV9ub2RlKE5VTEwsIE5VTEwsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgImF0bWVsLHNhbWE1ZDMtZGRyYW1jIik7DQo+PiArICAgICAgICAgICAgIGlm
ICghbnApIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRU5PREVWOw0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgIGdvdG8gdW5tYXA7DQo+PiArICAgICAgICAgICAgIH0NCj4+DQo+
PiAtICAgICBhdDkxX3NoZHdjLT5tcGRkcmNfYmFzZSA9IG9mX2lvbWFwKG5wLCAwKTsNCj4+IC0g
ICAgIG9mX25vZGVfcHV0KG5wKTsNCj4+ICsgICAgICAgICAgICAgYXQ5MV9zaGR3Yy0+bXBkZHJj
X2Jhc2UgPSBvZl9pb21hcChucCwgMCk7DQo+PiArICAgICAgICAgICAgIG9mX25vZGVfcHV0KG5w
KTsNCj4+DQo+PiAtICAgICBpZiAoIWF0OTFfc2hkd2MtPm1wZGRyY19iYXNlKSB7DQo+PiAtICAg
ICAgICAgICAgIHJldCA9IC1FTk9NRU07DQo+PiAtICAgICAgICAgICAgIGdvdG8gdW5tYXA7DQo+
PiArICAgICAgICAgICAgIGlmICghYXQ5MV9zaGR3Yy0+bXBkZHJjX2Jhc2UpIHsNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICByZXQgPSAtRU5PTUVNOw0KPj4gKyAgICAgICAgICAgICAgICAgICAg
IGdvdG8gdW5tYXA7DQo+PiArICAgICAgICAgICAgIH0NCj4+ICsNCj4+ICsgICAgICAgICAgICAg
ZGRyX3R5cGUgPSByZWFkbChhdDkxX3NoZHdjLT5tcGRkcmNfYmFzZSArDQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYXQ5MV9zaGR3Yy0+cmNmZy0+ZGRyYy50eXBlX29mZnNldCkg
Jg0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF0OTFfc2hkd2MtPnJjZmctPmRk
cmMudHlwZV9tYXNrOw0KPj4gKyAgICAgICAgICAgICBpZiAoZGRyX3R5cGUgIT0gQVQ5MV9ERFJT
RFJDX01EX0xQRERSMiAmJg0KPj4gKyAgICAgICAgICAgICAgICAgZGRyX3R5cGUgIT0gQVQ5MV9E
RFJTRFJDX01EX0xQRERSMykgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGlvdW5tYXAoYXQ5
MV9zaGR3Yy0+bXBkZHJjX2Jhc2UpOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGF0OTFfc2hk
d2MtPm1wZGRyY19iYXNlID0gTlVMTDsNCj4+ICsgICAgICAgICAgICAgfQ0KPj4gICAgICAgfQ0K
Pj4NCj4+ICAgICAgIHBtX3Bvd2VyX29mZiA9IGF0OTFfcG93ZXJvZmY7DQo+Pg0KPj4gLSAgICAg
ZGRyX3R5cGUgPSByZWFkbChhdDkxX3NoZHdjLT5tcGRkcmNfYmFzZSArIEFUOTFfRERSU0RSQ19N
RFIpICYNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgQVQ5MV9ERFJTRFJDX01EOw0KPj4gLSAg
ICAgaWYgKGRkcl90eXBlICE9IEFUOTFfRERSU0RSQ19NRF9MUEREUjIgJiYNCj4+IC0gICAgICAg
ICBkZHJfdHlwZSAhPSBBVDkxX0REUlNEUkNfTURfTFBERFIzKSB7DQo+PiAtICAgICAgICAgICAg
IGlvdW5tYXAoYXQ5MV9zaGR3Yy0+bXBkZHJjX2Jhc2UpOw0KPj4gLSAgICAgICAgICAgICBhdDkx
X3NoZHdjLT5tcGRkcmNfYmFzZSA9IE5VTEw7DQo+PiAtICAgICB9DQo+PiAtDQo+PiAgICAgICBy
ZXR1cm4gMDsNCj4+DQo+PiAgdW5tYXA6DQo+PiAtLQ0KPj4gMi43LjQNCj4+DQo+IA0KPiAtLQ0K
PiBBbGV4YW5kcmUgQmVsbG9uaSwgQm9vdGxpbg0KPiBFbWJlZGRlZCBMaW51eCBhbmQgS2VybmVs
IGVuZ2luZWVyaW5nDQo+IGh0dHBzOi8vYm9vdGxpbi5jb20NCj4g
