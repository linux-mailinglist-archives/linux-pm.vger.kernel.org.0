Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D071877CF
	for <lists+linux-pm@lfdr.de>; Tue, 17 Mar 2020 03:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCQC3z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 22:29:55 -0400
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:32375
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbgCQC3y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Mar 2020 22:29:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JM87Bqi3mJ2JdfN4GyWdPOhkZLc3zjlIJ4gHsLdXq8ea01mdduXQ16rtGml+Onsg8JDWvVbiIayTDZYbYW8hQFGhJ81/p7Sia6VpeNHu0CBy85vtWikz8yNksYt9JDkMjTcUpMbwPVfIsKdi/1wn0W8VwKjK0x6A6+Qqh/BsT2T65UDd4As239uUSzaTlOranGtPV8kKC9noC78ivjXfcJabc6lP7hUAh11RzaGNfQMJVUPAQDvt5RKf+P3jAqTvkb/8LJFD4fBHpy2gTyGh/+8KSTDe8H1lo4DcTfYRzqBa+dWU/vaNdBURD9DUfuJHxE6kZ7wiWk2riCvg3JoDeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyhN624LKViFmgvwxDtnhVpVnlhzLcCjnOIpPCdGnik=;
 b=YsU4FwqkPf79qer1GETTtzok3ZoE22pRKB/NoWCm/QlY2niLEljrvLY5sVvNrX9ZbbN8UUFDTeLzL5YusIwmYs3eN4tBSkfUEP/k6fZf3k//UkN2VIemri4hB+B8/Slpf/VQNNmv3aDDD85xKVjE9weWW1IXTK6ZidnLcoZBzYdlg1ts97MScpQa15Y3c3UshCcQA6xirGfSwwx+sif89tmIJSeIyFHbSLFzZWhSvlWiqQl7QVEe2sZy8QtoiUdMkS/3PTqrxLTewEntaWLDMhWEPf9OCXHQ/iF1YHBz6Nn0uChM8I9XEHg5OaqlPo4k5xwLGc07bLrx8epS/9MqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyhN624LKViFmgvwxDtnhVpVnlhzLcCjnOIpPCdGnik=;
 b=mdgNCDZciCKNwbIPHnWqxO+uKjM+cUQGTm1VSInufsDbiYlYYURwNm47aaBrBn5Z56ato+QPmNDDBl1cVcMgWgls/ulobqYeUC6MOv56KVbkema/dq17d+vZci02RyMTtOWVwJhS9RT9lauXFovwysU88/udOH9cTC2rsAwP20Q=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3867.eurprd04.prod.outlook.com (52.134.65.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Tue, 17 Mar 2020 02:29:47 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 02:29:47 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Thread-Topic: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Thread-Index: AQHV9av62LAReQhoZkKZ9LnT5dFdbahARTIAgAopwQCAACFfgIAABHaAgAADEYCAAAR+AIAASuWQgAAKpACAAABIoIAABUuAgAABn+CAAAKDgIAABdZwgAEX1ICAAAL3IA==
Date:   Tue, 17 Mar 2020 02:29:47 +0000
Message-ID: <DB3PR0402MB39169D01DB4C505403ECD51DF5F60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20200316005219.GD17221@dragon>
 <AM0PR04MB44819E4A9E027F1555C33D0B88F90@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200316030744.GC17221@dragon>
 <AM0PR04MB44817A48746601EADA4E06BC88F90@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200316033447.GE17221@dragon>
 <DB3PR0402MB3916DA9F0F175B9D2E9E684FF5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316084056.GG4518@piout.net>
 <DB3PR0402MB391663DB37A8D241092AD708F5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316090053.GH4518@piout.net>
 <DB3PR0402MB391683A05820920158DFDA77F5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316091541.GI4518@piout.net>
 <DB3PR0402MB39169528B3FF39E23C7A90FCF5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM0PR04MB4481A54C639FD1D45098302088F60@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4481A54C639FD1D45098302088F60@AM0PR04MB4481.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e93b19d6-7b0e-4eac-93fe-08d7ca1b101a
x-ms-traffictypediagnostic: DB3PR0402MB3867:|DB3PR0402MB3867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB386728A60C8856F23104B5FCF5F60@DB3PR0402MB3867.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(199004)(66446008)(66556008)(9686003)(66946007)(64756008)(55016002)(66476007)(76116006)(81156014)(8676002)(186003)(81166006)(33656002)(44832011)(26005)(8936002)(71200400001)(54906003)(7696005)(316002)(110136005)(6506007)(53546011)(478600001)(5660300002)(52536014)(4326008)(86362001)(2906002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3867;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VYW0obuP1+POcpEsrPkT2SRhaC9lFkKWA4tiTiP7f3TdxcwRLyaS/GDJNqhTVquKJYyIceadjt/USKsyHUYCuu/WGY8M6s5NSK4a6LFi03DbWgZ6GodSVbY9vqe331LLPlyManDwVM6bbIZG7m9cDyxy+RxKG0wNnJ1GYYD0wrINCKWAIsNOjzGcSI77VNZwWIGGz5sdcP9eTxfJ+lv0AN5ErxYH9aR4qkcJVlMY8KHzRS00sAnzrqQSJV44Dzpuxa/DBDg26mJgURF9kmHzEebnoHJH4DC/3u/zkYdqsXKMMTNa6GzxDf1PD3VLdfVnqPibsTVbAy0QRRNiTwpUYx1mMgxp5WNgoh0WNIxKpQ1lfTqHganZJE4pMBNq2qNJvq1BLW1ER9DXHxEdnUhvlFWg1Qfmpef8dkQCIhZs0EQE+zu1/IRLAVhhcpybkVNF
x-ms-exchange-antispam-messagedata: 46a0/J6dg6QuUKol3OdZSu4xQCUW75MyhnHO/16uJygF1seK1OiPQLKJ3c4x21uxtR6mLJldA8BPaCXm24lCGXUlsSgwzPZQooGoTDSkps95O9ei13yYbiULTcxo+JJ/ykBMTERFNxwWUqxxtzdxMQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e93b19d6-7b0e-4eac-93fe-08d7ca1b101a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 02:29:47.8829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41X2+2FQkQBnz8DlbWw4F3A7OngClCoypXyj3ynntn+ZI/1eQl6YTUQkD5VVwIdREQYS/aMPHFcwoepCWpxQJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3867
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSCBWMyAxLzddIGZpcm13YXJlOiBpbXg6IEFkZCBzdHVi
cyBmb3IgIUNPTkZJR19JTVhfU0NVDQo+IGNhc2UNCj4gDQo+ID4gU3ViamVjdDogUkU6IFtQQVRD
SCBWMyAxLzddIGZpcm13YXJlOiBpbXg6IEFkZCBzdHVicyBmb3INCj4gPiAhQ09ORklHX0lNWF9T
Q1UgY2FzZQ0KPiA+DQo+ID4gSGksIEFsZXhhbmRyZQ0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5i
ZWxsb25pQGJvb3RsaW4uY29tPg0KPiA+ID4gU2VudDogTW9uZGF5LCBNYXJjaCAxNiwgMjAyMCA1
OjE2IFBNDQo+ID4gPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+ID4g
PiBDYzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgUGVuZyBGYW4gPHBlbmcuZmFu
QG54cC5jb20+Ow0KPiA+ID4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJv
bml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+ID4gPiBkbWl0cnkudG9yb2tob3ZAZ21haWwu
Y29tOyBhLnp1bW1vQHRvd2VydGVjaC5pdDsNCj4gPiBydWkuemhhbmdAaW50ZWwuY29tOw0KPiA+
ID4gZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsgYW1pdC5rdWNoZXJpYUB2ZXJkdXJlbnQuY29t
OyB3aW1AbGludXgtDQo+ID4gPiB3YXRjaGRvZy5vcmc7IGxpbnV4QHJvZWNrLXVzLm5ldDsgRGFu
aWVsIEJhbHV0YQ0KPiA+ID4gPGRhbmllbC5iYWx1dGFAbnhwLmNvbT47IGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnOw0KPiA+ID4gbGludXhAcmVtcGVsLXByaXZhdC5kZTsgdGdseEBsaW51dHJv
bml4LmRlOyBtLmZlbHNjaEBwZW5ndXRyb25peC5kZTsNCj4gPiA+IGFuZHJpeS5zaGV2Y2hlbmtv
QGxpbnV4LmludGVsLmNvbTsNCj4gPiA+IGFybmRAYXJuZGIuZGU7IHJvbmFsZEBpbm5vdmF0aW9u
LmNoOyBrcnprQGtlcm5lbC5vcmc7DQo+ID4gPiByb2JoQGtlcm5lbC5vcmc7IExlb25hcmQgQ3Jl
c3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+OyBBaXNoZW5nDQo+ID4gPiBEb25nIDxhaXNo
ZW5nLmRvbmdAbnhwLmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsN
Cj4gPiA+IGxpbnV4LSBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1pbnB1dEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiA+ID4gcnRjQHZnZXIua2VybmVsLm9yZzsgbGludXgtcG1Admdl
ci5rZXJuZWwub3JnOyBsaW51eC0NCj4gPiA+IHdhdGNoZG9nQHZnZXIua2VybmVsLm9yZzsgZGwt
bGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
VjMgMS83XSBmaXJtd2FyZTogaW14OiBBZGQgc3R1YnMgZm9yDQo+ID4gPiAhQ09ORklHX0lNWF9T
Q1UgY2FzZQ0KPiA+ID4NCj4gPiA+IE9uIDE2LzAzLzIwMjAgMDk6MDg6NTMrMDAwMCwgQW5zb24g
SHVhbmcgd3JvdGU6DQo+ID4gPiA+ID4gV2h5IGRvIHlvdSBhYnNvbHV0ZWx5IG5lZWQgdG8gY29t
cGlsZSB0aGVtIGluZGVwZW5kZW50bHk/IEZyb20gYQ0KPiA+ID4gPiA+IGNvZGUgY292ZXJhZ2Ug
cG9pbnQgb2YgdmlldywgaGF2aW5nOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQ09NUElMRV9URVNU
PXkNCj4gPiA+ID4gPiBDT05GSUdfSU1YX1NDVT15DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBpcyBl
bm91Z2ggdG8gc2VsZWN0IGFuZCBjb21waWxlIHRoZSByZW1haW5pbmcgZHJpdmVycy4NCj4gPiA+
ID4NCj4gPiA+ID4gV2hhdCBJIG1lYW50IGlzIGZvciBiZWxvdyBjYXNlLCBsaWtlIHVzaW5nIG90
aGVyIGFyY2ggY29uZmlnIHdoaWNoDQo+ID4gPiA+IGRvZXMgTk9UIGhhdmUgQ09ORklHX0lNWF9T
Q1Ugc2VsZWN0ZWQsIE9OTFkgd2l0aCBDT01QSUxFX1RFU1QNCj4gPiA+ID4gc2VsZWN0ZWQsIGFk
ZGluZyBzdHVicyBmb3IgSU1YX1NDVSBBUElzIGNhbiBmaXggc3VjaCBzY2VuYXJpby4NCj4gPiA+
ID4NCj4gPiA+ID4gQ09NUElMRV9URVNUPXkNCj4gPiA+ID4gQ09ORklHX0lNWF9TQ1U9bg0KPiA+
ID4gPg0KPiA+ID4NCj4gPiA+IFdoeSBpcyB0aGF0IGFuIGlzc3VlPyBJZiB0aGV5IGRvbid0IGhh
dmUgSU1YX1NDVSBzZWxlY3RlZCwgdGhlbiB0aGUNCj4gPiA+IG90aGVyIFNDVSBkcml2ZXIgYXJl
IG5vdCBzZWxlY3RlZCBlaXRoZXIsIGhhdmluZyBzdHVicyBkb2Vzbid0DQo+ID4gPiBjaGFuZ2Ug
dGhhdCB5b3Ugd2lsbCBoYXZlIHRvIHNlbGVjdCBhdCBsZWFzdCBvbmUgb3B0aW9uLiBQbGVhc2UN
Cj4gPiA+IGV4cGxhaW4gd2hhdCBpcyB0aGUgaXNzdWUgdGhhdCBpcyBub3Qgc29sdmVkIGhlcmUu
DQo+ID4NCj4gPiBPSywgd2hhdCBJIHRob3VnaHQgaXMgZXZlbiB3aXRob3V0IElNWF9TQ1Ugc2Vs
ZWN0ZWQsIG90aGVyIFNDVSBkcml2ZXJzDQo+ID4gc3RpbGwgY2FuIGJlIHNlbGVjdGVkIGZvciBi
dWlsZCB0ZXN0IGFmdGVyIGFkZGluZyAiQ09NUElMRV9URVNUIiB0bw0KPiA+IHRoZSBrY29uZmln
LCBsaWtlIGJlbG93LCBpZiB3aXRob3V0IElNWF9TQ1UgQVBJIHN0dWJzLCB0aGUNCj4gPiAiQ09N
UElMRV9URVNUIiBjYW4gTk9UIGJlIGFkZGVkIHRvIFNDVSBkcml2ZXJzIHRvIGVuYWJsZSBidWls
ZCB0ZXN0LA0KPiA+IHNvIEkgdGhpbmsgdGhlIElNWF9TQ1UgQVBJIHN0dWJzIHNob3VsZCBiZSBh
ZGRlZD8NCj4gDQo+IEZvcmdvdCB0byBtZW50aW9uLCB3aXRob3V0IHN0dWIgYXBpLCBmb3IgZHJp
dmVycyB3aXRoICIgI2luY2x1ZGUNCj4gPGxpbnV4L2Zpcm13YXJlL2lteC9zY2kuaD4gIiB3aWxs
IG1ldCBjb21waWxlIGVycm9yIHdpdGhvdXQNCj4gKyNpZmRlZiBDT05GSUdfSU1YX1NDVQ0KPiAr
I2VuZGlmDQo+IA0KPiBTbyB3ZSBoYXZlIHRvIHVzZSBpZmRlZiBDT05GSUdfSU1YX1NDVSB0byBn
dWFyZCB0aGUgaW5jbHVkZS4NCg0KVGhlIGlkZWEgaGVyZSBpcyB0aGF0IGFsbCBtb2R1bGVzIGRl
cGVuZGluZyBvbiBJTVhfU0NVIHNob3VsZCBOT1QgYmUgZW5hYmxlZA0Kd2l0aG91dCBJTVhfU0NV
IGVuYWJsZWQuIFNvIGl0IHNob3VsZCBiZSBmaW5lLg0KDQpBbnNvbg0K
