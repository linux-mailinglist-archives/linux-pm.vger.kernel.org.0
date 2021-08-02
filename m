Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D7F3DD0E8
	for <lists+linux-pm@lfdr.de>; Mon,  2 Aug 2021 09:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhHBHDZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Aug 2021 03:03:25 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:43934 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhHBHDY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Aug 2021 03:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1627887796; x=1659423796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d+sYesGeoRyh3B/0v0qbnsiM1FzOL/+CTv2hTLzpov4=;
  b=cuLFbysHRy2OiXydEhQfFJ4qS52lgf6Cno8/sCeES9NF8VuAAml8d2xd
   eBFZKp3xRZ4xlEIkfB808GC4bUnFBBaaSCas/K0T3xt7BMtsUSSt903JZ
   F/BXg7NcLiVOU7++UhO/jjxD9W3K5COhqL+HSQ3vNXMkDkfKYnHKM1t7m
   Pbw+KVS3NptGHMo8tmC/z6hbPtQ4hw9iBiEWj3i2b1NEaUkKkZAtJBUWi
   cR/jnHOFFik+2KbNmB/WZgySDwtaJNBNxmYyawL23IhGkcF0nzwUKKb+E
   8CkkxjdCRhmErNY1EBuSCOiABYiURAA//4ZT67LHk1naWR6cK353UxPnq
   w==;
X-IronPort-AV: E=Sophos;i="5.84,288,1620662400"; 
   d="scan'208";a="279898318"
Received: from mail-mw2nam08lp2176.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.176])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2021 15:03:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlY9F82ZJzFWGy5F9I2zZ5iThEtdwZneVHVcUSoOd9jrORvd8GNOQ/n/Dq2BTYDy/8AzOoP/Bgj/u4xn8EcFbQmSVlAWVRT7JPV9UyNOvB0heZHgh6JslBkp9As9jHbw7EE/b2zuH5TEsgOZS4gMUS11skbn6zeqdu3Cc1tzXwHLWP9PaZX7d/UR0o7HZGsMhLR9yLAXGhja9b9w4WwKzXQ+Npws0A4B+0KiUBl4a6ZObG+GQY7mlQB2vQUWjTx5syO1LC2ILQG8Wzq5vCiDCqpbvavKNvyg1Fn2rqXxBUK6TCJm/TNE3b/71/ZQdO6/Pbd5Gk+n40wrSzu2tI2BfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+sYesGeoRyh3B/0v0qbnsiM1FzOL/+CTv2hTLzpov4=;
 b=nyYAIcnRHCibfNtyHsBf/AQ6quDXYRKrmXJ55i+gvVt6GHqAa6XgSAvjjKRfifM+bMyD2QHBY4zht9JAAuiCLVl0+k+dZKSjN4jL/jQHf75PrXfYUI0FhV09BJmJpDd3XXyM5pfcbQ15Fg/ZNFaMFHq+krZXzu/2tSeACaGG9qs8Ijh7dz4sE0GCv0ISYIiKdj1jTEPLaGRD+J7UYWbzmFgN+AMcwehmU3gUwtGw6iSlQlZ4DOhnbvouyV+QmxdCa/GDDro/CpXDeUBReJnGMVqMUWNU4HFG3rkjwAn1NtCI+MLtDI5weB3q20328aoiU5AzznpZw/D+walhRaUf9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+sYesGeoRyh3B/0v0qbnsiM1FzOL/+CTv2hTLzpov4=;
 b=Rxahj9gfqpCIuPtdZsgeW9be6ovgD6X95ZCrOXpGV0j75HfGuPzQvWbd5j4/HqDWhPU7YaRLWN8hva5CMla1kIbbAVc87n0aJZvaKNIH8XnQSSmux1/DL2LTakOqe3pGqxJIE8Re5fahw+6rlX3c0nVQ5txhsZLE5zazazlVWgU=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6857.namprd04.prod.outlook.com (2603:10b6:5:249::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.19; Mon, 2 Aug 2021 07:03:12 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ccfd:eb59:ccfe:66e4]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ccfd:eb59:ccfe:66e4%7]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 07:03:12 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 2/2] scsi: ufshcd: Fix device links when BOOT WLUN
 fails to probe
Thread-Topic: [PATCH V4 2/2] scsi: ufshcd: Fix device links when BOOT WLUN
 fails to probe
Thread-Index: AQHXejfny8us3PDZC0W2/Kbb+ap76qtHdlmwgBhYSYCAABWLwA==
Date:   Mon, 2 Aug 2021 07:03:12 +0000
Message-ID: <DM6PR04MB657536B3CDF0487E07894A16FCEF9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210716114408.17320-1-adrian.hunter@intel.com>
 <20210716114408.17320-3-adrian.hunter@intel.com>
 <DM6PR04MB65758A834069CC7B56669905FC109@DM6PR04MB6575.namprd04.prod.outlook.com>
 <2a19830e-47cb-4c2a-ddbc-f2370af01452@intel.com>
In-Reply-To: <2a19830e-47cb-4c2a-ddbc-f2370af01452@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b1b874c-9840-4035-4f55-08d9558397f5
x-ms-traffictypediagnostic: DM6PR04MB6857:
x-microsoft-antispam-prvs: <DM6PR04MB68578ACECC306284D4D66A38FCEF9@DM6PR04MB6857.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NUqF8EewU8Ip4pmI6dHQ15IRbQTFEtx1e3XViSEHvu+UtehdIXtTG1FvpRp+TYmlFnlZTjVThf3MwQzUz5WSYPlo5oZ8SBp+NTTVR8KueNF+WGmdaaEbpcHLMm7MISmpjb6LeBc7GIJGUju9ytnhcbTidcK9yI5ApR2nX0qYxdHWmYoOp0kEOd0k0IMM4ppAUD1MtL8alPS8ZestMTn1sD8BjbCisMFGK1fFn4j1xeWETOU+ngD+61o4jv3j5n4Rjwop+loa+7GBVt7oWsVROAQGSV53w6l9g8Jj5QfGBtas/VRpWkgDlVDyGWUI9WBleKoVtXTMxIvRrS778VX6P2dtg6r1s+ZZQgq1POSZCDW/OG2z5lKBvucJDuyCTmZMawT4bILIcsbkkbm35SFhRQZcIZEuk/rQr4rVy5QZ0z9dDCgWV3olc7kEBeOyloqCkb97tPz6i3zS1bC9d3cgxU+bheroqmW/P0CT/JGIotIcZd/9czn7Bb/Dk2xI5d1c66O7BYwIJvlvnk+R9CEJgwLegCIrnTOylrBnCYsaGeZh1OUKpjc7127zosDvPDz/xtME6tCPprFVsQPUBjRfHuIJijvwWcIVkPYMDiZDA410UTC2wr3H3sm+4ttZ0PrOIlmsw6FlJtchDlcshClO50/UqpVnYp/VdoOq3vBEM/g2D4qpFxkfTzFTXOJ4cRWd9EK/m17mrqtDDboCLQJTAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(316002)(54906003)(110136005)(83380400001)(2906002)(71200400001)(7696005)(186003)(6506007)(53546011)(26005)(4326008)(33656002)(66446008)(64756008)(66556008)(66476007)(5660300002)(86362001)(7416002)(76116006)(478600001)(122000001)(38070700005)(52536014)(38100700002)(66946007)(9686003)(8676002)(55016002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEx3RDJiTWRscG0vN3RYZHA5M1hCcVVISFhLZ29GRFQ5eUJXa2dCZVM5bXU2?=
 =?utf-8?B?c1h6c1VFQ2dTS21kTXNESUFMUlRUK3MzZE9VZGtIRVJhRUlnelVqM0tMOWRv?=
 =?utf-8?B?TWpMYVFIaEQ2V0MxOERIcENyMnh1QWwyOWRKOXZ2aHRUdTQrLzdZbjQzL0Zr?=
 =?utf-8?B?OUF0UDNYV1FFWnZYK1BHckVSR3FYbWVuQXY0QWJEVWhzNUVWTFFSYm51VmJm?=
 =?utf-8?B?Y2x2ekJQNWkxOWhMcFNwRjB1Q1hkQU00eHl0M0NsL3BoOEdxcElycGlPelVT?=
 =?utf-8?B?NjZTbjRISzMrVE9ScmhzZCtHc09NTUlxWmJBaXJGWUgvYVhZUlo3eTF0RC8w?=
 =?utf-8?B?WEV5TkVJWEMxNUR6dDhnOWpyYkkvckN2T1hkQ0E1OUVneFYrVU16RlNHZGhq?=
 =?utf-8?B?N1c5N0Q2LytFU2FnbFJLYmc3bFBvSGFlSDFzejQ5a3hMS3hpNXpJbG1yZ0Fn?=
 =?utf-8?B?b1MxSm5rUEJCNisrMnZFVGZPVEU5bG9ZcGllbE9zeHduUkVVT2s2SERKTTV4?=
 =?utf-8?B?UklFNHdkbVdSN0hRczZ4MDdBd3M3cTJwSk05NS9jVWZaZXZXNkxjVG8vYm9B?=
 =?utf-8?B?dVVEb05ITWUxellQL1ZwczZXM3gzRjJrUHFxaUxMVTdFVDB2STYrVUNUanFH?=
 =?utf-8?B?ekM2ZG93aVpFRFlCaUdTWklCWUZldk4xaEV2SVRpdnFoVC9vS2FQaTNqM1Mx?=
 =?utf-8?B?L1FhQmVzWE5teCsvdFhVZjVYT0MrL0hiRVhwczhLL1RqZlF5TE5vSDFROE5x?=
 =?utf-8?B?QmF0aXc0MmovcXJEVm1VSXQvOUp2VDl4amFOTWZRZ2hiSm5YL3pqSjVFWW9v?=
 =?utf-8?B?UUU2Yk9DRFZkbVJQUG1DNkd4d28vTGtPMEJWRnFWdFhDeURTMEFPZzY3TGRC?=
 =?utf-8?B?K1pUbnd4b0FVRnU4SkRWbUN0MkE1QlhNWkZoOE9lK3JNZ3M3T082aFRPS0gr?=
 =?utf-8?B?S1gyQ1h3L05IcUM1cXNBY1p3bGhLUjRLcS91R00xUzdjWVhoY1k4alA0QmVz?=
 =?utf-8?B?UVRoVy9YTEttdzdnNzlKWnJ3NGNlL0hldmU2ZC9SVU5qVlczc0FXc3dXUDgr?=
 =?utf-8?B?MXJUL3U5ZXRmaTdqcXBQZXk0ZUtGQnNyYVFHVDZhZ3Z1KytqaHNKWGRtcTNj?=
 =?utf-8?B?dXdoMFVNdEthTHRaR3YydWZ6Um9JNFd2ajE4ZXRCMmk0K3I5TVl6Y0ZYMXNp?=
 =?utf-8?B?MDkrdkR2UUc4MFNIb1BMeUVOeU5MK2ROWFV1Qnd1dTFOUVVXSzVxeThGYTQ5?=
 =?utf-8?B?Tnl0SUJoVzhaUlUrMklrV3lqNWJISWZoVFpUY3krbHZJZmtjeEFTaE1jS1ly?=
 =?utf-8?B?QXhDcE1zSy9kQytXalVIQUdneXcwYnZqYXJ5RTQ4S2tZQThJVEtRUnErb0ZR?=
 =?utf-8?B?aTJHbyt5SXRLZGhyNWw0KzJKVzA4eFNiTkpFaU5TTWlIVmxva2xVVlhWRi9V?=
 =?utf-8?B?QmJyd1FUQ3Y2L0I0bVRKb25FbFpDdE1xRC9rVjZYbjZSNWJVVnRKakEzQ3Qz?=
 =?utf-8?B?S0xrRGY3Y010c29CWjBuMEFhLzkxRGxicHdtcjBLZWFLMHBVb1kvK1dxMUxy?=
 =?utf-8?B?WHJXR3JGR20vVkFTWlNmRzRzU3ROaWt4R2huZENKNEh6N2FSTDVZbG5ZaUhT?=
 =?utf-8?B?WUFGNUhrTEFsTmFGMlBBN2ZRV29aZFN4R1YzVWw0cFdEMG4rMmdaWGtvb3Bw?=
 =?utf-8?B?MWJROGxZbWNTRGUzNjc2clhSaWFJdUpvWGQzQXlKRHQ4d3hldGpieCtIL21U?=
 =?utf-8?Q?DZjSnjQuA9Wscboucs=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1b874c-9840-4035-4f55-08d9558397f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2021 07:03:12.6993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xCr23NTbh7eVSXcxgmNUq3ezda3r1xCDRVy92hykpg+6PzKai7nzfWTGhepS5WsV9GZAvs0j0jnMUOOaRhxZxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6857
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

IA0KPiBPbiAxNy8wNy8yMSA5OjAyIHBtLCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hj
ZC5jDQo+ID4+IGluZGV4IDcwOGIzYjYyZmM0ZC4uOTg2NGE4ZWUwMjYzIDEwMDY0NA0KPiA+PiAt
LS0gYS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvc2NzaS91
ZnMvdWZzaGNkLmMNCj4gPj4gQEAgLTUwMjAsMTUgKzUwMjAsMzQgQEAgc3RhdGljIGludCB1ZnNo
Y2Rfc2xhdmVfY29uZmlndXJlKHN0cnVjdA0KPiA+PiBzY3NpX2RldmljZQ0KPiA+PiAqc2RldikN
Cj4gPj4gIHN0YXRpYyB2b2lkIHVmc2hjZF9zbGF2ZV9kZXN0cm95KHN0cnVjdCBzY3NpX2Rldmlj
ZSAqc2RldikgIHsNCj4gPj4gICAgICAgICBzdHJ1Y3QgdWZzX2hiYSAqaGJhOw0KPiA+PiArICAg
ICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4+DQo+ID4+ICAgICAgICAgaGJhID0gc2hvc3Rf
cHJpdihzZGV2LT5ob3N0KTsNCj4gPj4gICAgICAgICAvKiBEcm9wIHRoZSByZWZlcmVuY2UgYXMg
aXQgd29uJ3QgYmUgbmVlZGVkIGFueW1vcmUgKi8NCj4gPj4gICAgICAgICBpZiAodWZzaGNkX3Nj
c2lfdG9fdXBpdV9sdW4oc2Rldi0+bHVuKSA9PQ0KPiBVRlNfVVBJVV9VRlNfREVWSUNFX1dMVU4p
IHsNCj4gPj4gLSAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4+IC0NCj4g
Pj4gICAgICAgICAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKGhiYS0+aG9zdC0+aG9zdF9sb2Nr
LCBmbGFncyk7DQo+ID4+ICAgICAgICAgICAgICAgICBoYmEtPnNkZXZfdWZzX2RldmljZSA9IE5V
TEw7DQo+ID4+ICAgICAgICAgICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKGhiYS0+aG9z
dC0+aG9zdF9sb2NrLCBmbGFncyk7DQo+ID4+ICsgICAgICAgfSBlbHNlIGlmIChoYmEtPnNkZXZf
dWZzX2RldmljZSkgew0KPiA+PiArICAgICAgICAgICAgICAgc3RydWN0IGRldmljZSAqc3VwcGxp
ZXIgPSBOVUxMOw0KPiA+PiArDQo+ID4+ICsgICAgICAgICAgICAgICAvKiBFbnN1cmUgVUZTIERl
dmljZSBXTFVOIGV4aXN0cyBhbmQgZG9lcyBub3QgZGlzYXBwZWFyICovDQo+ID4+ICsgICAgICAg
ICAgICAgICBzcGluX2xvY2tfaXJxc2F2ZShoYmEtPmhvc3QtPmhvc3RfbG9jaywgZmxhZ3MpOw0K
PiA+PiArICAgICAgICAgICAgICAgaWYgKGhiYS0+c2Rldl91ZnNfZGV2aWNlKSB7DQo+ID4gV2Fz
IGp1c3QgY2hlY2tlZCBpbiB0aGUgb3V0ZXIgY2xhdXNlPw0KPiANCj4gWWVzLCBidXQgbmVlZCB0
byByZS1jaGVjayB3aXRoIHRoZSBzcGlubG9jayBsb2NrZWQuDQpPSy4NCkxvb2tzIGdvb2QgdG8g
bWUuDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gQXZyaQ0KPiA+
DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIHN1cHBsaWVyID0gJmhiYS0+c2Rldl91ZnNf
ZGV2aWNlLT5zZGV2X2dlbmRldjsNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgZ2V0X2Rl
dmljZShzdXBwbGllcik7DQo+ID4+ICsgICAgICAgICAgICAgICB9DQo+ID4+ICsgICAgICAgICAg
ICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKGhiYS0+aG9zdC0+aG9zdF9sb2NrLCBmbGFncyk7
DQo+ID4+ICsNCj4gPj4gKyAgICAgICAgICAgICAgIGlmIChzdXBwbGllcikgew0KPiA+PiArICAg
ICAgICAgICAgICAgICAgICAgICAvKg0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgKiBJ
ZiBhIExVTiBmYWlscyB0byBwcm9iZSAoZS5nLiBhYnNlbnQgQk9PVCBXTFVOKSwgdGhlDQo+ID4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAqIGRldmljZSB3aWxsIG5vdCBoYXZlIGJlZW4gcmVn
aXN0ZXJlZCBidXQgY2FuIHN0aWxsDQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAqIGhh
dmUgYSBkZXZpY2UgbGluayBob2xkaW5nIGEgcmVmZXJlbmNlIHRvIHRoZSBkZXZpY2UuDQo+ID4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAqLw0KPiA+PiArICAgICAgICAgICAgICAgICAgICAg
ICBkZXZpY2VfbGlua19yZW1vdmUoJnNkZXYtPnNkZXZfZ2VuZGV2LCBzdXBwbGllcik7DQo+ID4+
ICsgICAgICAgICAgICAgICAgICAgICAgIHB1dF9kZXZpY2Uoc3VwcGxpZXIpOw0KPiA+PiArICAg
ICAgICAgICAgICAgfQ0KPiA+PiAgICAgICAgIH0NCj4gPj4gIH0NCj4gPj4NCj4gPj4gLS0NCj4g
Pj4gMi4xNy4xDQo+ID4NCg0K
