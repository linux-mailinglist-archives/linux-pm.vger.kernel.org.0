Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F802DCE8E
	for <lists+linux-pm@lfdr.de>; Thu, 17 Dec 2020 10:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgLQJlT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Dec 2020 04:41:19 -0500
Received: from mail-eopbgr00080.outbound.protection.outlook.com ([40.107.0.80]:53988
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726012AbgLQJlS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Dec 2020 04:41:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMwxT6XaGYXaxbryU67PLAXZAsowoCzkXFtibRz7ZhVA6FuAE/Xun83iguaq8zXr6+k1x+Yutu4d/WusFm1oexRKmTWPoevX8E8Boe1rMkQCCdk9X6ugU1HMt+WK5mvmBogfzDdFUSIhtpyc7XDxym0r/vImMkcTeigZ0yyA9W7kuOus0dS/yiDtrwBAISrocPdAwPxSMo9L4PJSumxyXl0uoliL+0V4AqaHi6RJcevRFcA5hOEvq/AIhvLO20bn+HVjA/QSJBfh45m6Vrs9wi7Bhz34OhYQ1BQg98ghIFaD/vW6/k/m46uMmQvZy0eSkSl61hVYz1ixpkKN3fFO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zN/m5DJKde+TTv+6fgZdzEwtetTjlekCBKhalvM61Wk=;
 b=hZX6Mu77mVIw88O/0hNAVE845uTYGYr3QWUoTKKOAnPrOCax1OFoHnYyVmnctVfBv2vD0Jf+2bd2IY2T0yGFdTIZI1qEurxTsDBmBoe+tINA8yXb8AlmKFnu1pAY9cUim4EB5ph7hQCN1T+S3BeVkW3vqtY0XknkJGV4L7Hietk35qEHEHZruRNK6iwP4NnF3efdpGkRDTdQIIqzWfur6Xscz1pyMWr9f91ByiRTD3ubyxTWHjQJT9w0Mm2lsjKpAApYgO6lRM388CGOwcJhNcwobYiQQCDxnsZAMCbojV8HCotDntOy5PeU3b2KaYoj/sj2WGvDtkAii1wGh41uaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zN/m5DJKde+TTv+6fgZdzEwtetTjlekCBKhalvM61Wk=;
 b=mL+n1gYEV22yDRyVGzduMAxQMZ5jKhCR+b5slSiOqiBBIDX2h3Nq0zuP6fHOzYCTQ6C21s3gZMUv8oQKLnRQksl2j04DNxZI1OmKLQKI8fw20qstM8dBg7Br67Ntz3bwh1506uGbnUcQvioVEncCWMIYe9ZeIXcPWqVecOcwmcU=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB2890.eurprd03.prod.outlook.com (2603:10a6:7:5c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.19; Thu, 17 Dec 2020 09:40:27 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f1f1:eb1d:2bf5:eb87]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f1f1:eb1d:2bf5:eb87%7]) with mapi id 15.20.3676.025; Thu, 17 Dec 2020
 09:40:27 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "krzk@kernel.org" <krzk@kernel.org>,
        "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fan.chen@mediatek.com" <fan.chen@mediatek.com>,
        "rostokus@gmail.com" <rostokus@gmail.com>,
        "cpham2403@gmail.com" <cpham2403@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [RFC PATCH v2 4/6] mfd: add BD71827 header
Thread-Topic: [RFC PATCH v2 4/6] mfd: add BD71827 header
Thread-Index: AQHWyjvgjiWaj4uZzEWP6JQj+u4Dzqn5fX2AgAGfUgA=
Date:   Thu, 17 Dec 2020 09:40:27 +0000
Message-ID: <02fa1e88781ba118f49fa6b1d82f9e0c2c36de77.camel@fi.rohmeurope.com>
References: <cover.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
         <a9b5c999b67213141831bcb9d56d580e31419bec.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
         <20201216085353.GG4776@dell>
In-Reply-To: <20201216085353.GG4776@dell>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [62.78.225.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78b6c7c9-469f-4835-038c-08d8a26fc987
x-ms-traffictypediagnostic: HE1PR03MB2890:
x-microsoft-antispam-prvs: <HE1PR03MB28909F1CC9D111D04023FAB4ADC40@HE1PR03MB2890.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xmMHFj17icN0IgJR+zA0UG90dWsC0bw506/WwykbMFDdmHOFgetM1pf4G/sc106/iLhU8Ym/UyGU34V8bDLrxd5rIx7sZpFYng5umjQYVkweouLWs66C0hH23OXBbwgjXR629S01VxWTPrzjxyNyihT1HMxftyKHdix1CKLKj9+lIjf9o2TRa+rExmi/XyPKXxW+/dpwMR4D6TD5N75gCI4+BfLKwsJIm7kJC4fnfBbxfKM6nJshZ0teW6R+39cStsXoEc61rNKZ6h0X8+g/nUWTaX+Dv/MCtNVBt4VoWjr6yRCiJVfUynBe4qwahZWyEd2gDUXH2Qebjn/qmhYcvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(366004)(376002)(396003)(136003)(71200400001)(76116006)(66556008)(54906003)(186003)(66446008)(66946007)(316002)(66476007)(64756008)(6916009)(478600001)(83380400001)(2616005)(8936002)(3450700001)(86362001)(7416002)(2906002)(5660300002)(4001150100001)(26005)(8676002)(6512007)(6506007)(4326008)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VVdhMzZPbmRpVWVXNnNNTWRzVGpXeFUzZC9ERmZOVUdKSC95UnZXMnVtTUd3?=
 =?utf-8?B?ckU0ZEw3Qkg2VDRiSm1CSms1MVVhZ3dDL3NTRzJzRDlMOHBTQzgzU1I4SVB6?=
 =?utf-8?B?VHdudFVMOFVPWVFkTUVsd2tESmd0a1JBZnNqVlJ0aWVEMjdxNll4d0J5di9o?=
 =?utf-8?B?YnlWOFpCVzBmVkxrcExGRUtDYlVyZ2tNRUUrenAzRGY2ZVZtVDNPbjhlYWtO?=
 =?utf-8?B?ZnlKbEhsYzh5dkV1YmwycTBZVXl3TnZ4YWwrUmRvdzRtTUVxR25qZTJ4bkN1?=
 =?utf-8?B?ZmxOUHYxZXJFdFpxL2MxcTZZVXdFVE8xU05kSkxXRlg0QzZtWXdLVUlldGw5?=
 =?utf-8?B?MVZkTHNuUnlMOVBYaXVmVmRZQ05GbjhtSE1xb3dsTzg1TU9uVE5NR09ienFY?=
 =?utf-8?B?Mkt0bDhEd0ZEZjArZVErTVJSWEphSS9BUFNTSmRYU21mK09mR1V1bjRTc05D?=
 =?utf-8?B?NmdFWVdRc0Ixc29LRWFJaWNYMUdQSTE3YS83Tkg3WjgvS0ZpK3UrcEtaalpY?=
 =?utf-8?B?R1hCQ3N5SnN4SC95aVFrV29mcldqUUk1K3B2cjJIRmZQYy9VU0tUNjd1U1Z0?=
 =?utf-8?B?Z1B3YVFXaXFZQmFpZHMrbTFOZmNpUzU4dmhYVVVTTkQ2WjNRcTljcWRrZ3dk?=
 =?utf-8?B?S0RaY3dKZE9ZNnJKQjlvVU5hMWo4YWJSeUNqM3YyWm1iVHJqMkF1VEZSM2pn?=
 =?utf-8?B?S0V2bDVzUFdkbXNFWExZU0dKS1ZGbERjMTladjZsQ1hMK0pUNU5QTWFHdmVS?=
 =?utf-8?B?Z2pDajRUSW9IWVRid3JZbW1oZElxdm8zVnY4TFJLSDhpanB2UnlkUmlPeUJh?=
 =?utf-8?B?bXV3bXd5MFZxcWl6UllqakZiQW02RHdUS3FuV2Z5SkdHTXRucWRZbTEvMWJE?=
 =?utf-8?B?eW44K1VwallNZm44VUdBL1ZMTmQ5ZnBiNUthNCtxVGpHSmFvZ3lMOFFiL3VX?=
 =?utf-8?B?S0U1TzVDa2JHdEovMGhTWmNILzF2TUZBUHVoczNvODRWRUh0dWtEcnlHQlRp?=
 =?utf-8?B?T1ZjdDdOR1NJdlZ2dHBMT0R0YllHSlZ4UGEwOVdpa05QNkUwU1BXY1Z3MGky?=
 =?utf-8?B?cVRhTVRaSlJlS1M5N1h6UmRLVjRNUDVMVXBGQkZ6Z09SdjNZMm15aU9PRmhk?=
 =?utf-8?B?ZDFhUk16Q3NzUFA3dUtaRnFZcDYxWEdrVDJLQ3ZLd1R4U2E1bi90OVM5T2Iy?=
 =?utf-8?B?U21aaGhoUkZzNk43dHRnaXlRMDNkVVZ6Zm5LM2FOZDY2UU9JNlpYYVJ2bGJE?=
 =?utf-8?B?UXFLbENCaGpDTE8xblRQdUtzMGFyY08rUWJmQzBYdHFTV29WVEdlaEdRYzl2?=
 =?utf-8?Q?cMmxsXiEJwHejt/mdlrXFb7loY6U/d3tN5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <97EA778C6A277649888DBAECED5894CD@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b6c7c9-469f-4835-038c-08d8a26fc987
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 09:40:27.8513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mg+XPkZNk1Xgh7r3z9eP+dfrNhgBhPvMy2MS18haCX36uTx+nj3CeDkWuEfkghHXBz1Xw12jsnj1HkQsvzi1UnF4EUWUdxM1LoEC/fsPqZQNOXPveFwoZEIV9M7GLpQt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB2890
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiBXZWQsIDIwMjAtMTItMTYgYXQgMDg6NTMgKzAwMDAsIExlZSBKb25lcyB3cm90ZToNCj4g
T24gRnJpLCAwNCBEZWMgMjAyMCwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPiANCj4gPiBBZGQg
QkQ3MTgyNyBkcml2ZXIgaGVhZGVyLiBGb3IgYSByZWNvcmQgLSBIZWFkZXIgaXMgb3JpZ2luYWxs
eQ0KPiA+IGJhc2VkIG9uIHdvcmsgYXV0aG9yZWQgYnkgQ29uZyBQaGFtIGFsdGhvdWdoIG5vdCBt
dWNoIG9mIG9yaWdpbmFsDQo+ID4gd29yayBpcyBsZWZ0IG5vdy4NCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBNYXR0aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNv
bT4NCj4gPiAtLS0NCj4gPiBUaGlzIHBhdGNoIHdhcyBub3QgaW4gdjEuIFRoaXMgYnJpbmdzIGlu
IHNvbWUgY2hhcmdlciByZWdpc3RlcnMNCj4gPiBmb3IgdGhlIEJENzE4MjcgY2hhcmdlciB3aGlj
aCBpcyBpbiBmb2xsb3dpbmcgcGF0Y2hlcy4NCj4gPiANCj4gPiAgaW5jbHVkZS9saW51eC9tZmQv
cm9obS1iZDcxODI3LmggfCAyOTUNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyOTUgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgaW5jbHVkZS9saW51eC9tZmQvcm9obS1iZDcxODI3LmgNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tZmQvcm9obS1iZDcxODI3LmgNCj4gPiBiL2luY2x1ZGUv
bGludXgvbWZkL3JvaG0tYmQ3MTgyNy5oDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBp
bmRleCAwMDAwMDAwMDAwMDAuLjBmNWEzNDNiMTBhZQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiAr
KysgYi9pbmNsdWRlL2xpbnV4L21mZC9yb2htLWJkNzE4MjcuaA0KPiA+IEBAIC0wLDAgKzEsMjk1
IEBADQo+ID4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICov
DQo+ID4gKy8qDQo+ID4gKyAqIENvcHlyaWdodCAyMDE2DQo+IA0KPiBPdXQgb2YgZGF0ZS4NCg0K
Li4uDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyBMZWUhIEl0IHdhcyB1bmV4cGVjdGVkIGFzIEkg
ZGlkbid0IGFkZCB5b3UgdG8gQ0MuDQpSZWFzb24gZm9yIHNraXBwaW5nIHlvdSBpcyB0aGF0IHRo
aXMgd2FzIHZlcnkgaW5pdGlhbCBSRkMgcGF0Y2ggc2V0IC0NCmludGVuZGVkIHRvIGNvbGxlY3Qg
b3BpbmlvbnMgb2YgYWRkaW5nIHNvbWUgZnVlbC1nYXVnZSBsb2dpYyBpbiBwb3dlci0NCnN1cHBs
eS4gSSB3aWxsIGZvciBzdXJlIGNsZWFuIHVwIHRoZSBmaW5kaW5ncyAoYW5kIHBvc3NpYmx5IHNv
bWUgb3RoZXINCmlzc3Vlcykgd2hlbiBJIHByb2NlZWQgd2l0aCB0aGVzZSBjaGFyZ2VyIGRyaXZl
cnMgLSBhbmQgYXQgdGhhdCBwb2ludCBJDQp3aWxsIGFzayBmb3IgYSByZS1yZXZpZXcgJiBhZGQg
eW91IGluIENDLiBCdXQgSSBqdXN0IHdhbnRlZCB0byBwb2ludA0Kb3V0IHRoYXQgYXMgdGhlIGZh
dGUvZm9ybWF0IG9mIHRoaXMgZHJpdmVyIGRlcGVuZHMgb24gaG93IHRoZSBSRkMgaXMNCnNlZW4g
YnkgU2ViYXN0aWFuICYgb3RoZXJzIHNvIGdldHRpbmcgYmFjayB0byB0aGlzIG1heSB0YWtlIHNv
bWUNCnRpbWUuLi4NCg0KQlRXIC0geW91IGhhdmUgbmljZSBtYWlsLWZpbHRlcnMgYXMgeW91IGNh
dWdodCB0aGVzZSBwYXRoY2VzLCB5b3UgcGljaw0KZXZlcnkgbWFpbCB3aXRoIE1GRCBpbiBzdWJq
ZWN0KD8pIA0KDQoNCkJlc3QgUmVnYXJkcw0KCU1hdHRpDQoNCi0tDQpNYXR0aSBWYWl0dGluZW4s
IExpbnV4IGRldmljZSBkcml2ZXJzDQpST0hNIFNlbWljb25kdWN0b3JzLCBGaW5sYW5kDQpTV0RD
DQpLaXZpaGFyanVubGVua2tpIDFFDQo5MDIyMCBPVUxVDQpGSU5MQU5EDQoNCn5+fiAiSSBkb24n
dCB0aGluayBzbywiIHNhaWQgUmVuZSBEZXNjYXJ0ZXMuIEp1c3QgdGhlbiBoZSB2YW5pc2hlZCB+
fn4NCg0KU2ltb24gc2F5cyAtIGluIExhdGluIHBsZWFzZS4NCiJub24gY29naXRvIG1lIiBkaXhp
dCBSZW5lIERlc2NhcnRlLCBkZWluZGUgZXZhbmVzY2F2aXQNCg0KKFRoYW5rcyBmb3IgdGhlIHRy
YW5zbGF0aW9uIFNpbW9uKQ0KDQo=
