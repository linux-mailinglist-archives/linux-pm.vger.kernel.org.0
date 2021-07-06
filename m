Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536FC3BC8AF
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 11:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhGFJze (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 05:55:34 -0400
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:45058
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231159AbhGFJzd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Jul 2021 05:55:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQTbntJk+2N5U5qx9tfUR0as4kDHYRE98azs6Qm1Nple2IEIy7I810FhIWqmmtB61Y7H156NTGSgcwfbGRqdaN9bpQaH7KzmesqU5z2xz3Dg72D2OEao0Ym95ksKwfPjH0R//HrDv+Tep+6RmZ8Qv2Ywp1/4HygZGg0e5JJxbVcSFEAGYf5PqOkLnaDg1NfixV0+LqwaybMU6GwyIQTcBLTARQNuRKNW0zhaLPcQctIJgfsbgugGk1bD0Gxh0n2FovZZEfSeNc44Q3iGYRUue8Aj6awGF0WiBGQaIFc5YFlxznqobK5MdCsOpnjcskx9h7wHei5aM9hbvSLEmZkbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/7SZkqHjnYKcx9ZiJlug8t4FXZTdtiC81dCsPV0BI8=;
 b=fy3wr6uIraOWvRw1mJIQF3m3iqGK3/JqPA/eVL9IrEVuSh0GtkywJjXesWB7plPlZbSairRjPpSSVoQzwmiIxEzI9NX4Qz1Fih8YAl29CLYnmli+pltGKfOdzJip9EY583gOsdzA7xrSj6j623kMjjhaGNFRXHoYXA1PkTFCwZqea+pj9VPyRuTk4ta0GGd8VWyVEXeYTnX/fxkIBMLfqx/dbp5OF0a+Qq1m5I8RkmbAYnmFjV5j5sAYUfppQiiSM5oeSzs81mAjIodbYModAt9ylJDezwRTXTrh4o4nC3onQSj0yIwaxVWx26uChYu59+o0C2pMFSuJKq+kzgNkRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/7SZkqHjnYKcx9ZiJlug8t4FXZTdtiC81dCsPV0BI8=;
 b=BwjxulcpCU6kcXCRZTvmx+x/5oFFQDxY9u6ztaIXcNCRu9JTU0GEa2t2Wb5yaG34U4/cy7o8WdJEMgW7qlIvxygxlvavwKkj+hpJ/vVJg7FWd/rsZKFNVLjWb3T8UwXka/BjGxkizhAB3NndjuOdh4xXKJDPZTT2Bd+vUlbOAXM=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB5804.eurprd04.prod.outlook.com (2603:10a6:10:a6::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Tue, 6 Jul
 2021 09:52:51 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 09:52:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PM: domains: not update genpd status when power on fail
Thread-Topic: [PATCH] PM: domains: not update genpd status when power on fail
Thread-Index: AQHXckmzmQAhEjXvb0Cm5ZNUmczSP6s1sncAgAABPOA=
Date:   Tue, 6 Jul 2021 09:52:51 +0000
Message-ID: <DB6PR0402MB2760C8EBCF384C19789BBBC5881B9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210706100519.13851-1-peng.fan@oss.nxp.com>
 <CAPDyKFo-r0b1+wwoAyi8VRQpeAbXaxnDeFXGrjZV-zaqWZ7ojQ@mail.gmail.com>
In-Reply-To: <CAPDyKFo-r0b1+wwoAyi8VRQpeAbXaxnDeFXGrjZV-zaqWZ7ojQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2af06cc-1fe0-4bbc-0fdf-08d94063d1dd
x-ms-traffictypediagnostic: DB8PR04MB5804:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB58046286E22E124C09225F87C91B9@DB8PR04MB5804.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y5HkXeH9Ne0rh5mTuctz/gtdBjRWTN0/xWX1bHu9QESSCJ7VIB4IONxXpoLLkGEfTrk5/l3y+xYx/PwqycCs0452I0AiTa3S3KSX5jIHuzsAkusfet79v/5RzYcbEPJC71BgmbMGvEkcUG09+n3zgMvQ2zRY0Md+UUdxEAKIOXDJV5ohkX7JywTY0MyXatOQSw49qX8U/OL+KMlPeTsODHObGGbERLkrz4F6/WlIwwSuRqaZo7rPGxQPU3k+DAJnyZVB03Lix6LvBRnBmTPgA9Lmhl+rJkIdJ/3p9tLFa6f/pEU0QU9rXUg9UddcaP7IxxNGLEp7/wPju0DaJSDEvOXGA1fz3CaGo783s12ttaJk/Zp+SwKtyGiuMvIMVamjdu8Aw5w4LCgyiGRCU6ALOy4gNJVh3AHES6Oh3AgkSM9vXWvQzMqYgko6/zovmwj0mNscbqkdOobWfiWsz6eITo8IZckpON2Jmsx8DGUezaQTGmH9sAuL4MBQvP7PurlVvSKNT+h/FJg9LXz7268JBMg1LFXohT8AxF4VxDEUkCVnN5w0DKvitlB2NHo7jPp1ZZAAuDdAOEt5pvqLN2qGTbVYUO+77J/g2kdRrBf309a0h1xtgBKunONd5/GIn9bYCqju7nBGEZ+sycNpCqT7LZHvBl8uPQy1B4zo4Ob3oO+ThooRwXC/VnduR/ALMFVAwG8gIj2C4vOlP8wkmEDC5aMbWdO3JH7KLAmGtqAeWBWq4oHz8nn/0JFr5xha31YPcRmDuKkkg8JIMAZ17wKWfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(110136005)(8936002)(6506007)(33656002)(54906003)(71200400001)(15650500001)(478600001)(4326008)(2906002)(83380400001)(86362001)(26005)(316002)(66476007)(55016002)(38100700002)(66946007)(8676002)(52536014)(7696005)(64756008)(966005)(76116006)(186003)(66556008)(122000001)(5660300002)(66446008)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGxYbjQxaTRpUlpPY2tiUkpnU3JSUzJxWjRFRklFcGhETTl0Ukc5WmdRdW9D?=
 =?utf-8?B?SXJqZlFJTllaRnl4VUhQNmlVSTZEYUZoc29RcHlnWmdZMXc0OGJEbCtWbXJU?=
 =?utf-8?B?VXRMQWs0Q3gxd2U0bUhhT3JEaDBhd0t2QXJTRWtGanNLSGN2Lzh4SHJwNmlP?=
 =?utf-8?B?dGhEb2dDVTBEN1FLUDNabHgxSE84Q3J4aHc1dVBRcVFITS9VeWJJNW1TMnVk?=
 =?utf-8?B?TWFNNWpiTzZIR1RSYXl5cEVKMGNydjBia3pJZHVoblhmN0w5OE5haXFESkxR?=
 =?utf-8?B?UVcxTHN1V3dCaXl5c1p0c3NmK2R6WjBVOWFlVG5QeWNKeWhrZm82aHRHZkxY?=
 =?utf-8?B?RVkyR2dLcEsyemVBK2E3VEhRdmlCTkRoZHpXc2lMdG42Y0xBRUtCTDRmNjhZ?=
 =?utf-8?B?VmNObitMTkRrV0w2ckR3M1BDc3JleUJNbFRNUGYyNzZxQldIdHdOYXp6MSt4?=
 =?utf-8?B?VitSQUNORkZyTUpDQnRSdnlWSXp6VFlzakpSYzVOMW1WVkp2RmxnQ0c4OG81?=
 =?utf-8?B?NWRJc01sZWNQRnM2NFkyNmpqWUJLZE4wRE4zVmgrdFllVzkwNFh1bi9sQk00?=
 =?utf-8?B?K2s5aEFjUTNhZ0ZKL1d5Wk9FeHp3NXB4dXFyaFZoR3BzVlM4cXVvSUlsOVpz?=
 =?utf-8?B?NXFwaG4yeGp5OE1Fek5SZTRvS3ByNEFjMzM1Wm45eCtDUVRBUkU2K0Q4dEhN?=
 =?utf-8?B?YWh6Rk5yN05YSHBxSExaVmxQT1hVZk5vNWtwMkNOVFZMSm9UNUtqN3FMeHh2?=
 =?utf-8?B?eThSdG1hdzJ0MW9McEp4RkllZjVORU5QOU41UmRLWVlxT2VXbTY5eHhacWdK?=
 =?utf-8?B?Y29IS0lwSlhTM2cxRHBwbzkremZaUzBSVTlVTytDbEFhVTZSMHZmbndaTDJ5?=
 =?utf-8?B?L1BsSHZpT3pweHd3ZXhkWnpZQjdjNTl0cmY4TTRqY05hcy9NTTZGUkFoalBq?=
 =?utf-8?B?WjNVT285bnJOb1cwUnNBK2gwa0dxc2MvZStRVE0xTU9Pa3FnU3F0cElkcXg4?=
 =?utf-8?B?bm1PeWk0UXJyZlBOUjZRdGYvODRDbTJPcDUvYUZaNTJKakJMVmdCV1Mzem5a?=
 =?utf-8?B?cDRKRTJpMlg5OFo4UTdrMUFPR0FVVHp0Y3pHSHhhSjR4MTRJeEM3Z1JLZnpr?=
 =?utf-8?B?K1JvcUEwUW1nSkNwWWVEMllVQyttanEwSjVGdElTSjJ4VUVKMjE0SFF6aDZa?=
 =?utf-8?B?UlZPTEIyenVva0VXamRaeXBDajhma3gvWUc3a3YwTXYrZXZLQXR2Sk8rYXpR?=
 =?utf-8?B?c25ROFNNdVNCZ3AwckN5VHNJZ1M2MVZGcEwyWCtWMFl5ZE95N1pFcEZGTjF2?=
 =?utf-8?B?d0RKVFpjVlZBN3huYUxrVWFualc1dXZrUEwvYzZsL0NGWnFiUUp3d202dllX?=
 =?utf-8?B?cWJLbDYyU0d5NDl3MWdqYmtKV3ZtU1MyRnJqZ2NFUjdvMkcxUG03dzBzTkRI?=
 =?utf-8?B?RFdwRk5GSUdVcHdzK2hDUkppKzhCVDZnamw1RTUyNmI3YkxPem04elB4TW9m?=
 =?utf-8?B?QmUwZ3J1M1BFd3JSaUVlSmpqZXU1RklDTnA2L3J3WENsK2RJa3dTYmdiVXVR?=
 =?utf-8?B?Ti9PNXZWcUxEN05UZmJYem9UcXJVR1VRZFNuWWl5Z3Q1S3VkQ2twbk5SNEE3?=
 =?utf-8?B?TXEwR3RDODV1Y2Vkcko4YjUrVzhMSVVIZ1k2STJiNGFLNGFZNkgxb0VpODdI?=
 =?utf-8?B?L3BnUjBaOWxzU1Bqa3F2bTZMbklOVTZZeTcwaStrMFBiRjJGclBPTCtmcnJB?=
 =?utf-8?Q?RVUpSl0DO4xb2TKFh3f+wZagyn4xefaRU8Xuuqt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2af06cc-1fe0-4bbc-0fdf-08d94063d1dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 09:52:51.5471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQAVBVk3eLqdMD+H9wPYbAj3RO7ZCr7lSgqYaf6BT0opQCRdgi3SGnjn6lhbUmA2O0Q70slJLb/oTZXETZjAFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5804
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgVWxmLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFBNOiBkb21haW5zOiBub3QgdXBkYXRl
IGdlbnBkIHN0YXR1cyB3aGVuIHBvd2VyIG9uDQo+IGZhaWwNCj4gDQo+IE9uIFR1ZSwgNiBKdWwg
MjAyMSBhdCAxMTozMSwgPHBlbmcuZmFuQG9zcy5ueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZy
b206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gV2hlbiBfZ2VucGRfcG93
ZXJfb24gZmFpbCwgdGhlIGdlbmVyaWMgcG93ZXIgZG9tYWluIHN0YXR1cyBzaG91bGQgbm90DQo+
ID4gYmUgY2hhbmdlZCB0byBHRU5QRF9TVEFURV9PTi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Jhc2Uv
cG93ZXIvZG9tYWluLmMgfCA2ICsrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFz
ZS9wb3dlci9kb21haW4uYyBiL2RyaXZlcnMvYmFzZS9wb3dlci9kb21haW4uYw0KPiA+IGluZGV4
IGFiMGI3NDBjYzBmMS4uNzU0YTVkMzg0NDc5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmFz
ZS9wb3dlci9kb21haW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMvYmFzZS9wb3dlci9kb21haW4uYw0K
PiA+IEBAIC0xMTAxLDYgKzExMDEsNyBAQCBzdGF0aWMgdm9pZCBnZW5wZF9zeW5jX3Bvd2VyX29u
KHN0cnVjdA0KPiBnZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQsIGJvb2wgdXNlX2xvY2ssDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgZGVwdGgpICB7DQo+
ID4gICAgICAgICBzdHJ1Y3QgZ3BkX2xpbmsgKmxpbms7DQo+ID4gKyAgICAgICBpbnQgcmV0Ow0K
PiA+DQo+ID4gICAgICAgICBpZiAoZ2VucGRfc3RhdHVzX29uKGdlbnBkKSkNCj4gPiAgICAgICAg
ICAgICAgICAgcmV0dXJuOw0KPiA+IEBAIC0xMTE3LDggKzExMTgsOSBAQCBzdGF0aWMgdm9pZCBn
ZW5wZF9zeW5jX3Bvd2VyX29uKHN0cnVjdA0KPiBnZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQsIGJv
b2wgdXNlX2xvY2ssDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgZ2VucGRfdW5sb2NrKGxp
bmstPnBhcmVudCk7DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAtICAgICAgIF9nZW5wZF9wb3dl
cl9vbihnZW5wZCwgZmFsc2UpOw0KPiA+IC0gICAgICAgZ2VucGQtPnN0YXR1cyA9IEdFTlBEX1NU
QVRFX09OOw0KPiA+ICsgICAgICAgcmV0ID0gX2dlbnBkX3Bvd2VyX29uKGdlbnBkLCBmYWxzZSk7
DQo+ID4gKyAgICAgICBpZiAoIXJldCkNCj4gDQo+IFRvIHN1cHBvcnQgdGhpcyBlcnJvciBwYXRo
LCBhIGxvdCBtb3JlIGNvZGUgbmVlZHMgdG8gYmUgYWRkZWQuIEp1c3QNCj4gaGF2ZSBhIGxvb2sg
YXQgdGhlIGNhbGxlcnMgb2YgZ2VucGRfc3luY19wb3dlcl9vbigpIGFuZCBjb21wYXJlIGl0DQo+
IHdpdGggZ2VucGRfcG93ZXJfb24oKS4NCj4gDQo+IEluIG15IG9waW5pb24sIHN1cHBvcnRpbmcg
dGhpcyBlcnJvciBwYXRoIGlzbid0IHJlYWxseSB3b3J0aCBpdCwgYXQNCj4gbGVhc3QgdW50aWwg
c29tZW9uZSBjb21lcyB3aXRoIGEgdmFsaWQgdXNlIGNhc2UuIERvIHlvdSBoYXZlIG9uZSAtIG9y
DQo+IGRpZCB5b3Ugc2VuZCB0aGUgJHN1YmplY3QgcGF0Y2ggYmFzZWQgc29sZWx5IG9uIGNvZGUg
aW5zcGVjdGlvbj8NCg0KVGhpcyBpcyB0d28gcGF0Y2hzZXQ6DQpodHRwczovL3BhdGNod29yay5r
ZXJuZWwub3JnL3Byb2plY3QvbGludXgtYXJtLWtlcm5lbC9wYXRjaC8yMDIxMDYwNDExMTAwNS42
ODA0LTEtcGVuZy5mYW5Ab3NzLm54cC5jb20vDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3Jn
L3Byb2plY3QvbGludXgtYXJtLWtlcm5lbC9jb3Zlci8yMDIxMDYyOTA3Mjk0MS43OTgwLTEtcGVu
Zy5mYW5Ab3NzLm54cC5jb20vDQoNCkkgY29sbGVjdGVkIGluIGdpdGh1YiB3aXRoIGEgZmV3IGZp
eGVzOg0KaHR0cHM6Ly9naXRodWIuY29tL01yVmFuL2xpbnV4L3RyZWUvbGludXgtbmV4dC1tYXN0
ZXItNjI4LWJsay1jdGwtdGVzdA0KDQoNCkluIG15IHRlc3QsIHdoZW4gc3VzcGVuZC9yZXN1bWUs
IEkgc2VlDQpwZ2NfdnB1X2gxL2cxL2cyIGhhcyBzdGF0dXMgb24sIGJ1dCBhY3R1YWxseSB0aGV5
IGFyZSBub3Qgb24gaW4gaGFyZHdhcmUuDQpCZWNhdXNlIHZwdW1peF9ibGtfY3RsIGJ1cyBkb21h
aW4gaXMgbm90IG9uLCBwZ2NfdnB1X2gxL2cxL2cyIHJ1bnRpbWUNCnBvd2VyIG9mZiB3aWxsIGZh
aWwuDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+ID4gKyAgICAgICAgICAgICAgIGdlbnBkLT5z
dGF0dXMgPSBHRU5QRF9TVEFURV9PTjsNCj4gPiAgfQ0KPiA+DQo+ID4gIC8qKg0KPiA+IC0tDQo+
ID4gMi4zMC4wDQo+ID4NCj4gDQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo=
