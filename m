Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904481DAED4
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 11:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgETJb1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 05:31:27 -0400
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:62849
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726545AbgETJb0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 May 2020 05:31:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buwQdp6JVSC9E7A4IVzIEXxc5UBKFScuICzA4ZiuPLyfTJxB7druqfg//E/FZIDN8g4dpJ1CFwztGog4Nd9+ikaM4YimubL0U5PLum01AMyN6D4xsMw+DKxqabxtR2l42Q/MV5iHMai7EVadxHe16iy7WBc4Q4pQYdBdvLX7mZY+Onkdt3iJmY9VqtuCAN7q1G3bw6aFHOqwk2yHjiIhd5naIukyo7cLIy+tUt4yVvNlXBUGYAgAANmBJKBFx189BxJ7yuVzyNmp56pHHqrD53zReBq28pC2ir//96WkumoI9Gi9VnCCThyDjrEG4R815T2wvWz7kPwy0bnXNlxZEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6imZQd5QvjAsK/w75gZaIAn2ZBytQJWptr1GaODbNw4=;
 b=blMevY74mwOFQhn1T6i/JzZ8ROMlvpIKA60kQXoh5pURwOOvASV5JmP9D+2oqnxENySEVP4C32py+Rc1vw3A3/UVdmgD3nkQ0ba/Jd/PnpDndIgpI34nnj3ze/cw4ORsMoC+DD93T1mXgccb7KogflrUAh/sPX8+3WTR+m7wxPkCSjGY3Nq41OG8GTYxAJ1E2bujsoXkUFrzePPJn09kXhXjy9eLW0IA+VvclQbVVvsHLdYGFBBlogce+1lUj2SCyowNnC40oHZOuAjyhh6rmDY40V2sxIG2HUsH+bmz1ll/mkW8siPl9uQjKSYbXtFnhYaGO+PzRGetFGUtsvn+7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6imZQd5QvjAsK/w75gZaIAn2ZBytQJWptr1GaODbNw4=;
 b=H0fsjJc907yEUqmDryceLjduW1sHgky3FNfOi44xk4kx6+rZ9akJrdKng4hQ2LWzdfWVwHqisKVjoUfuz1ZJcp5lZVPut2QqmlmhrdphmcA86f2VL23sgzpUAkB+6HTRJspVLXn8MDFwM6Z6RSLV3ZFlPAka2LsICafikUCBosc=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5861.eurprd04.prod.outlook.com (2603:10a6:20b:a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 09:31:22 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 09:31:22 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
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
Subject: RE: [PATCH V3] dt-bindings: thermal: Convert i.MX to json-schema
Thread-Topic: [PATCH V3] dt-bindings: thermal: Convert i.MX to json-schema
Thread-Index: AQHWLoBrEdWAFmuPzEipjWXU6EAydqiws/Ng
Date:   Wed, 20 May 2020 09:31:22 +0000
Message-ID: <AM6PR04MB49663E19585FE55DE39DF46480B60@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589962619-28256-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589962619-28256-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d930f7bf-2eca-4646-c7e0-08d7fca08f25
x-ms-traffictypediagnostic: AM6PR04MB5861:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5861F15B37D835CFA5DC450E80B60@AM6PR04MB5861.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Igwjbn32o8dhos0HF0hKujL/1L0A914cOXWy0aWPHbYcFC5/cK1GR6iAAtZoEKZ0D9XLa6mekoMsldSx2EBV3S1v7RHhtSJx7cG1SpYOBFB4IFJuK4Tk7H5vDHyNc5ygB+GYkdltxmbBq0cO6JgT/HiHBmP9WIMMdgW/kQTGE/DUAQQE697xvKHYb6JCkSGncNM/rZDTp+aO2hIrfGpX4Q2EW9JsJV2Hsrl/jN0CmnsesRAiMidmwgtV3ddjHwQYk2ojW0aJR3rFocZgVrs37YG3GDCVz7NG0lZa09SCUJN0KcIlxF1urlln9tRbNGDkDYGx41u5RrD8LhRqK2VydgAyFOlIk03L/TU/MpasxH6o9YiGHM59iSP0392acq+oLjAoOdjT95qmkzqZ0c+EJaCrs9Y/2w09Iug5lL99hlDb+86RAJNTIO1y19vaar7RCjrN+CWl8jTUo7yMPEG+g1SDSJw6kLoqSqZINfROuA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(4326008)(26005)(71200400001)(478600001)(5660300002)(55016002)(186003)(44832011)(7696005)(33656002)(6506007)(7416002)(9686003)(66556008)(86362001)(8936002)(52536014)(2906002)(66476007)(8676002)(66446008)(66946007)(316002)(110136005)(76116006)(64756008)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: kPdP+wMFDZXeeTR0xlsdib/dQdKfXH2UAQwCOodndKS/YoyedxisWDJQu98w1o2oCz1eROd77w5Q/7PHOhv98/vDjdHbqMqlDSnQodryuMTvXdB9qr6AxN/vcks4vT6TORegQTZ83vh/iyWsGygPFX8K6DQOufAp/9BBPz0NObCL2o19+9kytXTHTb2DIc3nIVb0mxcymVHPUccLR1MIBe+FM2l5AoKWwYBTteeD0FpAV0XWB9GIFSYript7vTYRz6NnpjWK05TifClYPJ1LtLfSm6JqwdnKdgJb1vqdmPTxY4KqknsvHfd9z5VOGiTPIzMBTfPbt1b7XwJ04ZN/8eRfPONq2j1/3yPAxrRru8ZXVosfXGex2ouhpn/Jmezyo2l+9Nmmbw1pcl7F9gRmI+e9bfosCVwBGeeIzAp3JXu52PIx1x/BLZu4I/21taJeJFJLYfF49OlXjIgHA1SbABh94Dv6jxF2PlRolu+cdo3ew2iaIWYgmjrSvW9pgG3H
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d930f7bf-2eca-4646-c7e0-08d7fca08f25
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 09:31:22.1360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mw+lb+QwqA8fDLFsVMVB8NLKAyaJVeOTGYeX/xRakW3kGCyBtk0dg8JhrqvLCg4Yv9q1OEvV7j96lms2WBQShw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5861
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogV2VkbmVz
ZGF5LCBNYXkgMjAsIDIwMjAgNDoxNyBQTQ0KPiANCj4gQ29udmVydCB0aGUgaS5NWCB0aGVybWFs
IGJpbmRpbmcgdG8gRFQgc2NoZW1hIGZvcm1hdCB1c2luZyBqc29uLXNjaGVtYQ0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+IC0tLQ0KPiBD
aGFuZ2VzIHNpbmNlIFYyOg0KPiAJLSByZW1vdmUgdW5uZWNlc3NhcnkgcHJvcGVydHkgaW4gY29t
cGF0aWJsZTsNCj4gCS0gYWRkIGRldGFpbCBkZXNjcmlwdGlvbiBmb3IgaW50ZXJydXB0czsNCj4g
CS0gYWRkIGRlc2NyaXB0aW9uIGZvciBlYWNoIGl0ZW0gb2YgbnZtZW0tY2VsbHM7DQo+IAktIGFk
ZCBtb3JlIGRldGFpbCBmb3IgImZzbCx0ZW1wbW9uIiBkZXNjcmlwdGlvbi4NCg0KWy4uLl0NCg0K
PiArdGl0bGU6IE5YUCBpLk1YIFRoZXJtYWwgQmluZGluZw0KPiArDQo+ICttYWludGFpbmVyczoN
Cj4gKyAgLSBTaGF3biBHdW8gPHNoYXduLmd1b0BsaW5hcm8ub3JnPg0KPiArICAtIEFuc29uIEh1
YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiArDQo+ICtwcm9wZXJ0aWVzOg0KPiArICBjb21w
YXRpYmxlOg0KPiArICAgIGVudW06DQo+ICsgICAgICAtIGZzbCxpbXg2cS10ZW1wbW9uDQo+ICsg
ICAgICAtIGZzbCxpbXg2c3gtdGVtcG1vbg0KPiArICAgICAgLSBmc2wsaW14N2QtdGVtcG1vbg0K
PiArDQo+ICsgIGludGVycnVwdHM6DQo+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gKyAgICAgIFRo
ZSBpbnRlcnJ1cHQgb3V0cHV0IG9mIHRoZSBjb250cm9sbGVyLCBpLk1YNlEgaGFzIElSUV9ISUdI
IHdoaWNoDQo+ICsgICAgICB3aWxsIGJlIHRyaWdnZXJlZCB3aGVuIHRlbXBlcmF0dXJlIGlzIGhp
Z2hlciB0aGFuIGhpZ2ggdGhyZXNob2xkLA0KPiArICAgICAgaS5NWDZTWCBhbmQgaS5NWDdTL0Qg
aGF2ZSB0d28gbW9yZSBJUlFzIHRoYW4gaS5NWDZRLCBvbmUgaXMNCj4gSVJRX0xPVw0KPiArICAg
ICAgYW5kIHRoZSBvdGhlciBpcyBJUlFfUEFOSUMsIHdoZW4gdGVtcGVyYXR1cmUgaXMgbG93ZXIg
dGhhbiBsb3cNCj4gKyAgICAgIHRocmVzaG9sZCwgSVJRX0xPVyB3aWxsIGJlIHRyaWdnZXJlZCwg
d2hlbiB0ZW1wZXJhdHVyZSBpcyBoaWdoZXINCj4gKyAgICAgIHRoYW4gcGFuaWMgdGhyZXNob2xk
LCBJUlFfUEFOSUMgd2lsbCBiZSB0cmlnZ2VyZWQsIGFuZCBzeXN0ZW0gY2FuDQo+ICsgICAgICBi
ZSBjb25maWd1cmVkIHRvIGF1dG8gcmVib290IGJ5IFNSQyBtb2R1bGUgZm9yIElSUV9QQU5JQy4g
SVJRX0hJR0gsDQo+ICsgICAgICBJUlFfTE9XIGFuZCBJUlFfUEFOSUMgc2hhcmUgc2FtZSBpbnRl
cnJ1cHQgb3V0cHV0IG9mIGNvbnRyb2xsZXIuDQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiAr
ICBudm1lbS1jZWxsczoNCj4gKyAgICBpdGVtczoNCj4gKyAgICAgIC0gZGVzY3JpcHRpb246IFBo
YW5kbGUgdG8gdGhlIGNhbGlicmF0aW9uIGRhdGEgcHJvdmlkZWQgYnkgb2NvdHANCj4gKyAgICAg
IC0gZGVzY3JpcHRpb246IFBoYW5kbGUgdG8gdGhlIHRlbXBlcmF0dXJlIGdyYWRlIHByb3ZpZGVk
IGJ5IG9jb3RwDQo+ICsNCj4gKyAgbnZtZW0tY2VsbC1uYW1lczoNCj4gKyAgICBpdGVtczoNCj4g
KyAgICAgIC0gY29uc3Q6IGNhbGliDQo+ICsgICAgICAtIGNvbnN0OiB0ZW1wX2dyYWRlDQo+ICsN
Cj4gKyAgZnNsLHRlbXBtb246DQo+ICsgICAgJHJlZjogJy9zY2hlbWFzL3R5cGVzLnlhbWwjL2Rl
ZmluaXRpb25zL3BoYW5kbGUnDQo+ICsgICAgZGVzY3JpcHRpb246IFBoYW5kbGUgdG8gdGhlIHRl
bXBlcmF0dXJlIHNlbnNvciByZWdpc3RlciBtYXAgbm9kZS4NCg0KVGhpcyBzdGlsbCBsb29rcyB2
YXVnZS4NCkhvdyBhYm91dCAiIFBoYW5kbGUgdG8gYW5hdG9wIHN5c3RlbSBjb250cm9sbGVyIG5v
ZGUiPw0KDQpPdGhlcndpc2UsIHlvdSBjYW4gYWRkIG15IHRhZzoNClJldmlld2VkLWJ5OiBEb25n
IEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpBaXNoZW5nDQoNCj4g
Kw0KPiArICBmc2wsdGVtcG1vbi1kYXRhOg0KPiArICAgICRyZWY6ICcvc2NoZW1hcy90eXBlcy55
YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlJw0KPiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ICsgICAg
ICBEZXByZWNhdGVkIHByb3BlcnR5LCBwaGFuZGxlIHBvaW50ZXIgdG8gZnVzZSBjb250cm9sbGVy
IHRoYXQgY29udGFpbnMNCj4gKyAgICAgIFRFTVBNT04gY2FsaWJyYXRpb24gZGF0YSwgZS5nLiBP
Q09UUCBvbiBpbXg2cS4gVGhlIGRldGFpbHMgYWJvdXQNCj4gKyAgICAgIGNhbGlicmF0aW9uIGRh
dGEgY2FuIGJlIGZvdW5kIGluIFNvQyBSZWZlcmVuY2UgTWFudWFsLg0KPiArICAgIGRlcHJlY2F0
ZWQ6IHRydWUNCj4gKw0KPiArICBjbG9ja3M6DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiAr
cmVxdWlyZWQ6DQo+ICsgIC0gY29tcGF0aWJsZQ0KPiArICAtIGludGVycnVwdHMNCj4gKyAgLSBm
c2wsdGVtcG1vbg0KPiArICAtIG52bWVtLWNlbGxzDQo+ICsgIC0gbnZtZW0tY2VsbC1uYW1lcw0K
PiArDQo+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gKw0KPiArZXhhbXBsZXM6DQo+
ICsgIC0gfA0KPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9pbXg2c3gtY2xvY2su
aD4NCj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJt
LWdpYy5oPg0KPiArDQo+ICsgICAgZWZ1c2VAMjFiYzAwMCB7DQo+ICsgICAgICAgICAjYWRkcmVz
cy1jZWxscyA9IDwxPjsNCj4gKyAgICAgICAgICNzaXplLWNlbGxzID0gPDE+Ow0KPiArICAgICAg
ICAgY29tcGF0aWJsZSA9ICJmc2wsaW14NnN4LW9jb3RwIiwgInN5c2NvbiI7DQo+ICsgICAgICAg
ICByZWcgPSA8MHgwMjFiYzAwMCAweDQwMDA+Ow0KPiArICAgICAgICAgY2xvY2tzID0gPCZjbGtz
IElNWDZTWF9DTEtfT0NPVFA+Ow0KPiArDQo+ICsgICAgICAgICB0ZW1wbW9uX2NhbGliOiBjYWxp
YkAzOCB7DQo+ICsgICAgICAgICAgICAgcmVnID0gPDB4MzggND47DQo+ICsgICAgICAgICB9Ow0K
PiArDQo+ICsgICAgICAgICB0ZW1wbW9uX3RlbXBfZ3JhZGU6IHRlbXAtZ3JhZGVAMjAgew0KPiAr
ICAgICAgICAgICAgIHJlZyA9IDwweDIwIDQ+Ow0KPiArICAgICAgICAgfTsNCj4gKyAgICB9Ow0K
PiArDQo+ICsgICAgYW5hdG9wQDIwYzgwMDAgew0KPiArICAgICAgICBjb21wYXRpYmxlID0gImZz
bCxpbXg2cS1hbmF0b3AiLCAic3lzY29uIiwgInNpbXBsZS1tZmQiOw0KPiArICAgICAgICByZWcg
PSA8MHgwMjBjODAwMCAweDEwMDA+Ow0KPiArICAgICAgICBpbnRlcnJ1cHRzID0gPDAgNDkgSVJR
X1RZUEVfTEVWRUxfSElHSD4sDQo+ICsgICAgICAgICAgICAgICAgICAgICA8MCA1NCBJUlFfVFlQ
RV9MRVZFTF9ISUdIPiwNCj4gKyAgICAgICAgICAgICAgICAgICAgIDwwIDEyNyBJUlFfVFlQRV9M
RVZFTF9ISUdIPjsNCj4gKw0KPiArICAgICAgICB0ZW1wbW9uIHsNCj4gKyAgICAgICAgICAgICBj
b21wYXRpYmxlID0gImZzbCxpbXg2c3gtdGVtcG1vbiI7DQo+ICsgICAgICAgICAgICAgaW50ZXJy
dXB0cyA9IDxHSUNfU1BJIDQ5IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiArICAgICAgICAgICAg
IGZzbCx0ZW1wbW9uID0gPCZhbmF0b3A+Ow0KPiArICAgICAgICAgICAgIG52bWVtLWNlbGxzID0g
PCZ0ZW1wbW9uX2NhbGliPiwNCj4gPCZ0ZW1wbW9uX3RlbXBfZ3JhZGU+Ow0KPiArICAgICAgICAg
ICAgIG52bWVtLWNlbGwtbmFtZXMgPSAiY2FsaWIiLCAidGVtcF9ncmFkZSI7DQo+ICsgICAgICAg
ICAgICAgY2xvY2tzID0gPCZjbGtzIElNWDZTWF9DTEtfUExMM19VU0JfT1RHPjsNCj4gKyAgICAg
ICAgfTsNCj4gKyAgICB9Ow0KPiAtLQ0KPiAyLjcuNA0KDQo=
