Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 315439FDF4
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 11:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfH1JKp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 05:10:45 -0400
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:3331
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726300AbfH1JKp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Aug 2019 05:10:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxyLJ+iWOPTUF4SsR1v+Gs+UTPGtu7hI11YhVDt8qXRU9/JV2hLsGaxxHhYN9osdA6b5gtMLh1GdcTJz6m62m2vwUCGVGSVEwEnMFPR5rGzss41qZpttdcMH/8UE2dTzHuGv3bwVoj9jjCGuvciCjERMQ76zMGQDMMP9kDtp0oMsX2cAJ6Pg37EbKGnMi3W/62LiiVMCtuFs86NoOHl7KD3KpCqeTxqRJLV3RfMpBVaUu8WbQHnBXTW17KKoMZbs6//c2evfv9paSsZozIuU2ys8ybIbnxp4VlGtSagZ4DIB1ozqEHbhu73Pgk0A03G/7pWuA8mLc6oxnDrufDb71Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zbnip9HI32GJAncxL0rErk88DO6m1WmtQAesIj3Olo8=;
 b=ckpPZaSfC7SCNHW2BI7KyRXk2Jq6/+xnbEXaSUi0BGAQAyeQsmUPGCbCY8pVjXIYx51JDa9CXyUWq2lr31AkUFxRN8sXuFCYuses2baY/xRJmDCIa0NlxeBq42L3n2XyDAGLalvK6H6LQH1gTO5qfMvAGtIEtwHnCLCEocq/r7k2ZIbMlPOEe9fOEf/jsXKXTj7yZLVXvenJpDqEApwzW921nYlNUdVm9VywVPNrxL75oXaUS/qKIMEOtBp05lVsDS5Jd63uzbiaHdl/IAQ+DIheCi02BvTkfmqpDK8b5clapS5rdYrnLu16nPONHnLSbmukjh60D7ltuLNNRW0ijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zbnip9HI32GJAncxL0rErk88DO6m1WmtQAesIj3Olo8=;
 b=NfcVtEno7b/OV0BcziSRVZxwM9XFGELkxf3nn3eNn4q+Ab3bTQQ4ABSzJfI2Yq0xWg2hoZ2J2CjdNGwHvJwrlQPdSNxW14hul+Oqa5KRriEtg0CN/s2t0DEG6XFUSgQosr16XaXnt9nqlR/kDy0yPlscQ5gvHTtMBUHz39sp93E=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3817.eurprd04.prod.outlook.com (52.134.73.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 09:10:42 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 09:10:42 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: RE: [PATCH V3 1/5] thermal: qoriq: Add clock operations
Thread-Topic: [PATCH V3 1/5] thermal: qoriq: Add clock operations
Thread-Index: AQHVRn7U0xGc5nAWcEuPNmwDSS0IiacQaSEAgAAE+eCAAAPjgIAAAXqA
Date:   Wed, 28 Aug 2019 09:10:41 +0000
Message-ID: <DB3PR0402MB39168DA42F69336EB2B231E8F5A30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190730022126.17883-1-Anson.Huang@nxp.com>
         <VI1PR04MB7023F219CA7B4187F86EAA42EEA10@VI1PR04MB7023.eurprd04.prod.outlook.com>
         <AM6PR0402MB3911D45B3B148588A582F6C4F5A00@AM6PR0402MB3911.eurprd04.prod.outlook.com>
         <VI1PR04MB7023773DD477FF89E2D2181CEEA00@VI1PR04MB7023.eurprd04.prod.outlook.com>
         <d9b428825654181fbdbfb4d613a6a3fd52330787.camel@intel.com>
         <DB3PR0402MB3916D1492F43D77E3679E3B1F5A30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <3f268ab0e05b795c04dbb3490f0c93da998e3b2c.camel@intel.com>
In-Reply-To: <3f268ab0e05b795c04dbb3490f0c93da998e3b2c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a13611a-7b3f-4d59-8552-08d72b979a05
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3817;
x-ms-traffictypediagnostic: DB3PR0402MB3817:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB381710CCB5256A9FD3EE3C0DF5A30@DB3PR0402MB3817.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(189003)(199004)(14444005)(7696005)(256004)(99286004)(53546011)(66946007)(66066001)(66446008)(71200400001)(66476007)(9686003)(64756008)(6246003)(71190400001)(7736002)(478600001)(55016002)(66556008)(102836004)(25786009)(186003)(4326008)(26005)(305945005)(6436002)(81166006)(5660300002)(3846002)(81156014)(44832011)(110136005)(316002)(8676002)(76176011)(8936002)(53936002)(2906002)(74316002)(33656002)(6506007)(7416002)(14454004)(76116006)(11346002)(52536014)(6116002)(446003)(86362001)(229853002)(476003)(486006)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3817;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dpNa4p1sdOW/H66MLCcZKGVZa99LmL7HEMRRHkULcQero9/qncWktOAqCG5bzKFTqAx80GJcZ39Efv5lQDMHjW3HWctGK+BuKWFVNBybdWufDSbsmxfgSaIKdFFinv7lzGYKYajbg2Cyy2jAc/RDcrimwPAfIuN7qvrjHzgC54faf58A74HkMbRFgW7+U5U4LbTqOdnGLOZOzOUEwdnE5Tffwv99801Es+vMyYKLa39q/dWmiRjqjAgieO2ORxgVsu2NMPF/wJz6r7W2GPeTh7cRwU4ZyX23KTGbCYovjn54LhJiIjT+DsTjYfzx2ZeEk2iRYh4sFBT61X7yAsgrdvjMDFF2WsD1umr7leNGQda/ujoBDvOdWDdzdl7ILar12n8ktw7p7mACQYJkFxtFDHZYl0zR4yO/Km+424EFu40=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a13611a-7b3f-4d59-8552-08d72b979a05
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 09:10:41.9344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qeHgr87VY6C7A9J5PJS342046uWTG/q6cnTnXsS0zHEgyKSHiE1bkW6UtOrZv7cMmWux8151kPOloL5qLCGHTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3817
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFJ1aQ0KDQo+IE9uIFdlZCwgMjAxOS0wOC0yOCBhdCAwODo1MSArMDAwMCwgQW5zb24gSHVh
bmcgd3JvdGU6DQo+ID4gSGksIFJ1aQ0KPiA+DQo+ID4gPiBPbiBUdWUsIDIwMTktMDgtMjcgYXQg
MTI6NDEgKzAwMDAsIExlb25hcmQgQ3Jlc3RleiB3cm90ZToNCj4gPiA+ID4gT24gMjcuMDguMjAx
OSAwNDo1MSwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gPiA+ID4gPiBJbiBhbiBlYXJsaWVyIHNl
cmllcyB0aGUgQ0xLX0lTX0NSSVRJQ0FMIGZsYWdzIHdhcyByZW1vdmVkDQo+ID4gPiA+ID4gPiBm
cm9tIHRoZSBUTVUgY2xvY2sgc28gaWYgdGhlIHRoZXJtYWwgZHJpdmVyIGRvZXNuJ3QgZXhwbGlj
aXRseQ0KPiA+ID4gPiA+ID4gZW5hYmxlIGl0IHRoZSBzeXN0ZW0gd2lsbCBoYW5nIG9uIHByb2Jl
LiBUaGlzIGlzIHdoYXQgaGFwcGVucw0KPiA+ID4gPiA+ID4gaW4gbGludXgtbmV4dCByaWdodCBu
b3chDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGUgdGhlcm1hbCBkcml2ZXIgc2hvdWxkIGJlIGJ1
aWx0IHdpdGggbW9kdWxlLCBzbyBkZWZhdWx0DQo+ID4gPiA+ID4ga2VybmVsIHNob3VsZCBjYW4g
Ym9vdCB1cCwgZG8geW91IG1vZGlmeSB0aGUgdGhlcm1hbCBkcml2ZXIgYXMNCj4gPiA+ID4gPiBi
dWlsdC0gaW4/DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFVubGVzcyB0aGlzIHBhdGNoZXMgaXMg
bWVyZ2VkIHNvb24gd2UnbGwgZW5kIHVwIHdpdGggYSA1LjQtDQo+ID4gPiA+ID4gPiByYzENCj4g
PiA+ID4gPiA+IHRoYXQgZG9lc24ndCBib290IG9uIGlteDhtcS4gQW4gZWFzeSBmaXggd291bGQg
YmUgdG8NCj4gPiA+ID4gPiA+IGRyb3AvcmV2ZXJ0IGNvbW1pdA0KPiA+ID4gPiA+ID4gOTUxYzFh
ZWY5NjkxICgiY2xrOiBpbXg4bXE6IFJlbW92ZSBDTEtfSVNfQ1JJVElDQUwgZmxhZyBmb3INCj4g
PiA+ID4gPiA+IElNWDhNUV9DTEtfVE1VX1JPT1QiKSB1bnRpbCB0aGUgdGhlcm1hbCBwYXRjaGVz
IGFyZSBhY2NlcHRlZC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IElmIHRoZSB0aGVybWFsIGRyaXZl
ciBpcyBidWlsdCBhcyBtb2R1bGUsIEkgdGhpbmsgbm8gbmVlZCB0bw0KPiA+ID4gPiA+IHJldmVy
dCB0aGUgY29tbWl0LCBidXQgaWYgYnkgZGVmYXVsdCB0aGVybWFsIGRyaXZlciBpcyBidWlsdC1p
bg0KPiA+ID4gPiA+IG9yIG1vZCBwcm9iZWQsIHRoZW4geWVzLCBpdCBzaG91bGQgTk9UIGJyZWFr
IGtlcm5lbCBib290IHVwLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgcW9yaXFfdGhlcm1hbCBkcml2
ZXIgaXMgYnVpbHQgYXMgYSBtb2R1bGUgaW4gZGVmY29uZmlnIGFuZA0KPiA+ID4gPiB3aGVuIG1v
ZHVsZXMgYXJlIHByb3Blcmx5IGluc3RhbGxlZCBpbiByb290ZnMgdGhleSB3aWxsIGJlDQo+ID4g
PiA+IGF1dG9tYXRpY2FsbHkgYmUgcHJvYmVkIG9uIGJvb3QgYW5kIGNhdXNlIGEgaGFuZy4NCj4g
PiA+ID4NCj4gPiA+ID4gSSB1c3VhbGx5IHJ1biBuZnNyb290IHdpdGggbW9kdWxlczoNCj4gPiA+
ID4NCj4gPiA+ID4gICAgICBtYWtlIG1vZHVsZXNfaW5zdGFsbCBJTlNUQUxMX01PRF9QQVRIPS9z
cnYvbmZzL2lteDgtcm9vdA0KPiA+ID4NCj4gPiA+IHNvIHdlIG5lZWQgdGhpcyBwYXRjaCBzaGlw
cGVkIGluIHRoZSBiZWdpbm5pbmcgb2YgdGhlIG1lcmdlIHdpbmRvdywNCj4gPiA+IHJpZ2h0Pw0K
PiA+ID4gaWYgdGhlcmUgaXMgaGFyZCBkZXBlbmRlbmN5IGJldHdlZW4gcGF0Y2hlcywgaXQncyBi
ZXR0ZXIgdG8gc2VuZA0KPiA+ID4gdGhlbSBpbiBvbmUgc2VyaWVzLCBhbmQgZ2V0IHNoaXBwZWQg
dmlhIGVpdGhlciB0cmVlLg0KPiA+DQo+ID4gVGhlcmUgaXMgbm8gaGFyZCBkZXBlbmRlbmN5IGlu
IHRoaXMgcGF0Y2ggc2VyaWVzLiBQcmV2aW91cyBmb3IgdGhlIFRNVQ0KPiA+IGNsb2NrIGRpc2Fi
bGVkIHBhdGNoLCBzaW5jZSB0aGVybWFsIGRyaXZlciBpcyBidWlsdCBhcyBtb2R1bGUgc28gSSBk
aWQNCj4gPiBOT1QgZm91bmQgdGhlIGlzc3VlLiBUaGUgcGF0Y2ggc2VyaWVzIGlzIHRoZSBjb3Jy
ZWN0IGZpeC4NCj4gPg0KPiBHb3QgaXQuDQo+IHRoZSBjbG9jayBwYXRjaCBpcyBhbHNvIHF1ZXVl
ZCBmb3IgNS40LXJjMSwgcmlnaHQ/DQo+IEkgd2lsbCBhcHBseSB0aGlzIHNlcmllcyBhbmQgdHJ5
IHRvIHB1c2ggaXQgYXMgZWFybHkgYXMgcG9zc2libGUgZHVyaW5nIHRoZSBtZXJnZQ0KPiB3aW5k
b3cuDQoNClRoZSBjbG9jayBwYXRjaCBpcyBhcyBiZWxvdyBpbiBMaW51eC1uZXh0IHRyZWUsIHdo
aWxlIEkgZGlkIE5PVCBzZWUgaXQgaW4gdjUuMy1yYzYsDQpzbyBpdCBzaG91bGQgYmUgcXVldWVk
IGZvciA1LjQtcmMxLCByaWdodD8NClRoYW5rcyBmb3IgdGFraW5nIHRoZSBwYXRjaCBzZXJpZXMh
DQoNCg0KY29tbWl0IDk1MWMxYWVmOTY5MTQ5MWRkZjRkZDVhYWI3NmYyNjY1ZDU2YmQ1ZDMNCkF1
dGhvcjogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQpEYXRlOiAgIEZyaSBKdWwg
NSAxMjo1NjoxMSAyMDE5ICswODAwDQoNCiAgICBjbGs6IGlteDhtcTogUmVtb3ZlIENMS19JU19D
UklUSUNBTCBmbGFnIGZvciBJTVg4TVFfQ0xLX1RNVV9ST09UDQoNCiAgICBJTVg4TVFfQ0xLX1RN
VV9ST09UIGlzIE9OTFkgdXNlZCBmb3IgdGhlcm1hbCBtb2R1bGUsIHRoZSBkcml2ZXINCiAgICBz
aG91bGQgbWFuYWdlIHRoaXMgY2xvY2ssIHNvIG5vIG5lZWQgdG8gaGF2ZSBDTEtfSVNfQ1JJVElD
QUwgZmxhZw0KICAgIHNldC4NCg0KICAgIFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNv
bi5IdWFuZ0BueHAuY29tPg0KICAgIFJldmlld2VkLWJ5OiBBYmVsIFZlc2EgPGFiZWwudmVzYUBu
eHAuY29tPg0KICAgIEFja2VkLWJ5OiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQog
ICAgU2lnbmVkLW9mZi1ieTogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KDQpkcml2
ZXJzL2Nsay9pbXgvY2xrLWlteDhtcS5jDQoNCg0KVGhhbmtzLA0KQW5zb24NCg==
