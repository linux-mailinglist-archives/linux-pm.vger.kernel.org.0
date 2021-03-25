Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9278D349B10
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 21:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhCYUhV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 16:37:21 -0400
Received: from mail-eopbgr670086.outbound.protection.outlook.com ([40.107.67.86]:35123
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230009AbhCYUhC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Mar 2021 16:37:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzQElSnal3L56UxsG6zRxEPHIgczy6nofU+epsRL7wWmIMtXKzplqkJqui7AAIA1sdH99IoDiJPuK2F/130MhxicQOS2+7vf7DoSvG/yaepIdk/CwCijj05eTDT9cw8uHPzpn+TJmbvUjqibMHiNINDGYZ6Ov1pZhjTN3Zgt7UzLBtP5xRAZcQPVwtrDS/ZliR3je10U8N7FLXR6WZaNhVuz9ueq1o063sjPTAkSujHOj+MSpr6+5cbB4F2YXqt0v9DzKD/Bz9VqNpYGRojGOxnQjPn+D6Pmsd+BMjsn41tvLUB4s2+TkaaAKdBy+FX9JupKkGz1EMAqmPABXoUowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLxT9PCJQCBAWSynyoYemUnbFE9PAcpSoxluDnbfYg4=;
 b=Y6+kXiSmmqA1WTV8ugHjGZ4trCHlfTU6VyG6ocRmTB+jBFJVzJA+5IF9msKnZ5YKWREQ0ymritMwtya4em6rTpYIR4KuKwWHLOkp17kYAcSPHqzrzFoWhf/yycHbs2+M+qc1ZsEqGeLl5WFfV0EmVaJq6iythPzlHHPQ4zVBE0OlCLY6KpMGfnlK+JcFnY4WezK8DZMpsHJ0wOKM7gz1G7PBRvHRrtdUyc9XDruNUETq0vN9WFhLAPJugJDM44xFzAIM2VII0GVLfXTLkKVi54oxn3PXFESrpovVZQ3JcuOqU8KRybuVVBYdQ1y/Ej8RM7IC+XRfal0GTrkhu+CK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stfx.ca; dmarc=pass action=none header.from=stfx.ca; dkim=pass
 header.d=stfx.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stfxca.onmicrosoft.com; s=selector2-stfxca-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLxT9PCJQCBAWSynyoYemUnbFE9PAcpSoxluDnbfYg4=;
 b=Nbub/Hf3F9GGN0T4C1aZegNZdOtJRchXYCYtYTwP8kx0JeiKgw3/vI4R9EqtwFG8Wi99Mr7BMsFBlQg4F0DOsX1dQf79289Bh8TaOcvvTdufI3BaQ6zV0cQuDr2o3SH//43KJJEe08vYAlt6J8awtFcwjbylsJB/uCY7j4pMGpQ=
Received: from YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:17::19)
 by YT2PR01MB4207.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:35::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Thu, 25 Mar
 2021 20:37:01 +0000
Received: from YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c087:282b:4ebb:81b3]) by YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c087:282b:4ebb:81b3%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 20:37:01 +0000
From:   "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: =?big5?B?UmU6IKZezmA6IFtQQVRDSCAwMS8xMF0gdGljay9ub2h6OiBQcmV2ZW50IHRpY2tf?=
 =?big5?B?bm9oel9nZXRfc2xlZXBfbGVuZ3RoKCkgZnJvbSByZXR1cm5pbmcgbmVnYXRpdmUg?=
 =?big5?Q?value?=
Thread-Topic: =?big5?B?pl7OYDogW1BBVENIIDAxLzEwXSB0aWNrL25vaHo6IFByZXZlbnQgdGlja19ub2h6?=
 =?big5?B?X2dldF9zbGVlcF9sZW5ndGgoKSBmcm9tIHJldHVybmluZyBuZWdhdGl2ZSB2YWx1?=
 =?big5?Q?e?=
Thread-Index: AQHXFnNGiA2JtEhS2EiDRBkCbpwkF6qGkOKAgAAVHICAABBdgIAABRoAgAAI/QCAAAjRv4AAAXDTgA311gCAAF+bgIAABILrgAAKyACAAAPIZQ==
Date:   Thu, 25 Mar 2021 20:37:01 +0000
Message-ID: <YTBPR01MB3262C64BEB4DBA0ED48F3168C4629@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
References: <20210311123708.23501-1-frederic@kernel.org>
 <YTBPR01MB3262D78448BD2FB3AD5EB4F9C46B9@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
 <20210325131400.GA938586@lothringen> <5712356.lOV4Wx5bFT@kreacher>
 <YTBPR01MB326253A7B094A2F603488EA8C4629@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>,<CAJZ5v0h2BZdj4ds1NUKUcdJ_WCZe-0EogE1k5qbJkoEGFkjJyw@mail.gmail.com>
In-Reply-To: <CAJZ5v0h2BZdj4ds1NUKUcdJ_WCZe-0EogE1k5qbJkoEGFkjJyw@mail.gmail.com>
Accept-Language: en-CA, zh-CN, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=stfx.ca;
x-originating-ip: [141.109.104.116]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f946f898-02c5-4054-97bb-08d8efcdbe45
x-ms-traffictypediagnostic: YT2PR01MB4207:
x-microsoft-antispam-prvs: <YT2PR01MB420785EEE1A39F15DCB03BF7C4629@YT2PR01MB4207.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: byjOtZp97hcSBvsICAk8RbtCn4PNeSQTKnii+eh257MvO+4Gxii6dlyQD2b1VGVblDE5sviDIflMzfzUCj4hzlE/VXHPNx0mnS+glFk5UN4CW03Ye60AUSCwQkYC/0xlWcT4wjpwWixV47ucsgraffo2aLV8FO3gaYGUIeOmAdPB5jbSN1be86ShJqC+mCkTjKPcoSEXG2OvnTU/C+hln1JC6WONY/3X7WHAgA1PoQ4UpVBKW8q2BoOFrU7VTExKL6SURVMdXFjLo7x+dmRX1CkDtXGP5XzO7GQ69hh+aWJD6lzMAbO4DTHpShkdxQAR6LRmbzc+dIShtaNClURESqZ4kMzKrQ3QCLznKwmwAFqYqpHnPDQkO8D8NXzA15WabuMhHVpx4sWKkfmqPwIR+NXyTaVJj+bbFlGLukLmzAYeBMPdyp4sac0fUH0IoKdn06C28RXSqKGeLkuQdYfk5nuM6rzyD8PrSA+rjQvSneeWj8yLG5lNrB3httVGQkxVdz9cgIOTtpgoWoVmMnH4jUyUuHFHuVIAqamdYhtvc4sqzbUdSyeU2eSq9kofx38yqyUVdE18G46pKPeHTTLRRXwB5vFnUtDluyavfFU2/uzuOA7OfFVf1ilPQYO2+RetrGKLTni0vIlYCFG20OyWDfPTSo8OvpSRRJ/F7QfKsOA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39850400004)(346002)(376002)(396003)(52536014)(8936002)(66446008)(4326008)(186003)(224303003)(786003)(6916009)(26005)(66946007)(38100700001)(66556008)(76116006)(6506007)(71200400001)(5660300002)(7416002)(53546011)(33656002)(86362001)(9686003)(7696005)(316002)(478600001)(66476007)(55016002)(64756008)(2906002)(54906003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?big5?B?WlJiQ1k3RkhzTUM3ekMvclJDd3d0MHUrbElaQmx0U0xDMjlUYXFmMWRIOGJSdzlk?=
 =?big5?B?dlJsYUw3MUdnMmlTZksxdVBxU2thTFIrcVF3L3FFM1hqeWJWbXJCVTNqQ3NQZmNl?=
 =?big5?B?VldIMy8yQmNDUTl1eHc3VTlLOGdqQU9FRXBqbXN1NEU0b0grYUd1enFnM2VsVDB0?=
 =?big5?B?ZVg0SG5ZaURUOVdmWGRPekJwM0pHTk13VjJ3Q1orU3JEN3ErMzNQV2Z4ZEJDc3BR?=
 =?big5?B?OFpxZ1poMXpRZVBJd3JsSDExRHlEdko1b2VmaG5GSnpiS1Z3VUY0cUFTQXZrQnpM?=
 =?big5?B?U0laMS81M2FwbVgwVkh3Wjk2MGtiaTJuaGtzVXc0NDZkNnp0cFZQT01XNWhPc1hN?=
 =?big5?B?R2dURUxKZzg5eEplZWFOeGgrVWJET3NDY0R4czl4TXZHNjdaaVBqbmxDTXNDZnBz?=
 =?big5?B?ZGpiM0pabmhLeWhQYS9uWVZlcDh3aEk4R1d1NzVtWUdIeFpRR3RwdGFta2pCMTJN?=
 =?big5?B?dEVpbXFURGdhN01ROWo2QmtwQXUzdlZGTGI4cXBZMUpoZ3RWSnNYazExUjFlWGJL?=
 =?big5?B?eE0zN0piOGVDZFlmaHpaNmRxQXlEZnAyaldnNU44VG8valdCdEFYWFZHMUNyVjFq?=
 =?big5?B?SCtWRW10ZUtYckY3UWlBYVcrWmovTkV6TERFdU13QWhtUWp2bFRPeERGcTZKYzcr?=
 =?big5?B?UkZNZkZaMVhVc0lSVC93N1BXRlViWFZOZHRIL0dFSElZc2hYb3QySXhWbjRGL3I5?=
 =?big5?B?MHpkUWcvcEZqS0NLbjFCSExhU0Y3M3pOYnBVamZ2UlI1WGZ5V1Q4Snh6Z2FDdWhu?=
 =?big5?B?bWdIZ25TM2dhNWNkYllIV0J5akRFTHMvMjdOcjdnTmF5emZHemNQS3hDL0FiMWVr?=
 =?big5?B?RHZwQWRLdVEwdTdjR052TUpwOFhFNzNoVEdtWEt6VTRVOFRMdUl4L0E2Uktnb1dM?=
 =?big5?B?SFcxWjNvV0N2cjZoNjlNbGJzUTltdy9ZSzhHQ2pFNDVMeXc4OHRzeTYrY3g4L2pl?=
 =?big5?B?WEZCdWovRWN6OVJJMFE0VWhqcVYwejRUUWpRWnJLbGlKWFpiZjh2SkZtZFRtbmdZ?=
 =?big5?B?R1FvNGxIWTdHVDFFeWs5V0pwU2d2djRJNFltMG1nWWZpbyswYzJyQVlKUjVIajcr?=
 =?big5?B?VTl6bjlSb1NEVXN3Y0NGWWJsS0NQWWpVZkFNMklPKzBUL0dLOGpSUUFQenlqaTJl?=
 =?big5?B?eWwway9NWm5vMTBsazltR0tTc0xTRTV3cmxZdzRkOVhFRVo1ZEZ4WGNCTWVRQUE1?=
 =?big5?B?VHoxRzhwb0JaT2I2UnV3SkVCM2ppZzJTQUtnTEJucmcvV3VhdEphRlIranBpdVoz?=
 =?big5?B?TFpZTmRZTzFoOXk3M0xqajRQdFBmWGNSU0w4djB0S3RyTEtsVHVhbFExU2tSYzJC?=
 =?big5?B?ZTlkeUJ1RmZ2K09CNUpyMlkrb2RNSkppVXo3MFoxenZkaWQ3TWRZRWM5R3FUSXNk?=
 =?big5?B?M0JzTHNCRTJCOElDbWo1cUo5eWh2NUlJSmhFL0gxamV3OUlBdS9RblJ0ZmJYSTFE?=
 =?big5?B?N0psMklPbldKdVBiWXNnZHdZYXhBQVpyeE1BMWZqQ2laRXFOcGRwRU93a1U3L1h5?=
 =?big5?B?cDBGQzcrVVlRTEdVMWhhek81czlnZ3VrMzg1dGlIOGkzeXN0dWYyWkFWcWtZRXlp?=
 =?big5?B?RU5DMXJ1MGgyZXIvZEFORFp3SWo1ckJFbTh6V0dJdXExempOUlRWMGxCbG1DcVd3?=
 =?big5?Q?6ON1CZJFF3UItSYkAYvC+aWjNc/qkncA9ljwpg4U3iU5Y/T+?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: stfx.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f946f898-02c5-4054-97bb-08d8efcdbe45
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 20:37:01.1002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c46abc7-960b-4124-8950-1628b2b192f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eIEx1lJ1nJyp4KE/U2eUSwA/ZpqpM34t64T2v7w+WA5aGr2v8LEnqpqUYd7/8NH4f6v1JsFssR+iTzn5+ufhlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB4207
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gTWFyY2ggMjUsIDIwMjEgMTU6NTAsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOgo+IE9uIFRo
dSwgTWFyIDI1LCAyMDIxIGF0IDg6MTggUE0gWmhvdSBUaSAoeDIwMTljd20pIDx4MjAxOWN3bUBz
dGZ4LmNhPiB3cm90ZToKPiA+Cj4gPiBPbiBNYXJjaCAyNSwgMjAyMSAxNDo1NiwgUmFmYWVsIEou
IFd5c29ja2kgd3JvdGU6Cj4gPiA+IE9uIFRodXJzZGF5LCBNYXJjaCAyNSwgMjAyMSAyOjE0OjAw
IFBNIENFVCBGcmVkZXJpYyBXZWlzYmVja2VyIHdyb3RlOgo+ID4gPiA+IE9uIFR1ZSwgTWFyIDE2
LCAyMDIxIGF0IDA0OjA4OjA4UE0gKzAwMDAsIFpob3UgVGkgKHgyMDE5Y3dtKSB3cm90ZToKPiA+
ID4gPiA+IEJ1dCBJIGRvbid0IHRoaW5rIGl0J3MgYSBnb29kIGlkZWEgdG8gaGFuZGxlIHRoaXMg
aW4gY2FsbGVycywgYmVjYXVzZSBsb2dpY2FsbHkgdGhlIGZ1bmN0aW9uIHNob3VsZG4ndCByZXR1
cm4gbmVnYXRpdmUgdmFsdWVzLiBSZXR1cm5pbmcgMCBkaXJlY3RseSB3b3VsZCBhbGxvdyBpZGxl
IGdvdmVybm9ycyB0byBnZXQgYW5vdGhlciBjaGFuY2UgdG8gc2VsZWN0IGFnYWluLgo+ID4gPiA+
Cj4gPiA+ID4gSG1tLCBJJ20gZ29pbmcgdG8gbGVhdmUgdGhlIGxhc3Qgd29yZCB0byBSYWZhZWwg
c2luY2UgY3B1aWRsZSBhcmUgdGhlIG9ubHkKPiA+ID4gPiBjYWxsZXJzIG9mIHRoaXMuIEluIGFu
eSBjYXNlIHdlIG5lZWQgdG8gZml4IGl0Lgo+ID4gPgo+ID4gPiBZZXMsIHdlIGRvLgo+ID4gPgo+
ID4gPiBTbyBJIHNhaWQgdGhhdCBJIHByZWZlcnJlZCB0byBhZGRyZXNzIHRoaXMgaW4gdGhlIGNh
bGxlcnMgYW5kIHRoZSByZWFzb24gd2h5Cj4gPiA+IGlzIGJlY2F1c2UsIGZvciBleGFtcGxlLCBm
b3IgdGhlIHRlbyBnb3Zlcm5vciBpdCB3b3VsZCBiZSBhIG1hdHRlciBvZiB1c2luZwo+ID4gPiBh
IGRpZmZlcmVudCBkYXRhIHR5cGUgdG8gc3RvcmUgdGhlIHRpY2tfbm9oel9nZXRfc2xlZXBfbGVu
Z3RoKCkgcmV0dXJuIHZhbHVlLAo+ID4gPiBsaWtlIGluIHRoZSAodW50ZXN0ZWQpIHBhdGNoIGJl
bG93Lgo+ID4gPgo+ID4gPiBTbyBhdCBsZWFzdCBpbiB0aGlzIGNhc2UgdGhlcmUgaXMgbm8gbmVl
ZCB0byBhZGQgYW55IG5ldyBicmFuY2hlcyBhbnl3aGVyZS4KPiA+ID4KPiA+ID4gSSdtIHN0aWxs
IG5vdCBzdXJlIGFib3V0IG1lbnUsIGJlY2F1c2UgaXQgaXMgbW9yZSBjb21wbGljYXRlZCwgYnV0
IGV2ZW4gaWYKPiA+ID4gdGhhdCBvbmUgbmVlZHMgYW4gZXh0cmEgYnJhbmNoLCB0aGF0IGlzIGEg
d2luIGFscmVhZHkuCj4gPgo+ID4gSSB3b3VsZCBsaWtlIHRvIHBvaW50IG91dCB0aGUgcG90ZW50
aWFsIHRyb3VibGUgdGhhdCBmaXhpbmcgdGhpcyBpc3N1ZSBpbiB0aGUKPiA+IGNhbGxlcnMgY291
bGQgY2F1c2UuCj4gPgo+ID4gMS4gVGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgbXVsdGlwbGUgdGlt
ZXMgaW4gbWVudSBnb3Zlcm5vciBhbmQgVEVPCj4gPiBnb3Zlcm5vci4KPiAKPiBXaGF0IGRvIHlv
dSBtZWFuIGJ5ICJtdWx0aXBsZSB0aW1lcyI/Cj4gCj4gRWFjaCBvZiB0aGUgZ292ZXJub3JzIGNh
bGxzIGl0IG9uY2UgcGVyIGN5Y2xlIGFuZCBpdHMgcHJldmlvdXMgcmV0dXJuCj4gdmFsdWUgaXMg
bm90IHVzZWQgaW4gdGhlIG5leHQgY3ljbGUgYXQgbGVhc3QgaW4gdGVvLgoKSSByZW1lbWJlciBh
IGdvdmVybm9yIGNhbGxlZCB0aGlzIGZ1bmN0aW9uIHR3aWNlIGluIGEgY3ljbGUsIEkgZ3Vlc3Mg
SSByZW1lbWJlciAKd3JvbmcuCgo+IAo+ID4gSSdtIG5vdCBzdXJlIHRoYXQgcmVjZWl2aW5nIHJl
c3VsdHMgdXNpbmcgc2lnbmVkIGludGVnZXJzIGlzIGVub3VnaAo+ID4gdG8gc29sdmUgYWxsIHRo
ZSBwcm9ibGVtcywgaW4gdGhlIHdvcnN0IGNhc2UgaXQgbWF5IHJlcXVpcmUgaW5jcmVhc2luZwo+
ID4gdGhlIGxvZ2ljYWwgY29tcGxleGl0eSBvZiB0aGUgY29kZS4KPiAKPiBUaGF0IGlzIGEgdmFs
aWQgY29uY2Vybiwgc28gaXQgaXMgYSB0cmFkZW9mZiBiZXR3ZWVuIGluY3JlYXNpbmcgdGhlCj4g
bG9naWNhbCBjb21wbGV4aXR5IG9mIHRoZSBjb2RlIGFuZCBhZGRpbmcgYnJhbmNoZXMgdG8gaXQu
Cj4gCj4gPiAyLiBUaGlzIGZ1bmN0aW9uIGlzIGltcG9ydGFudCBmb3IgZGV2ZWxvcGluZyBpZGxl
IGdvdmVybm9yLgo+ID4gSWYgdGhlIHByb2JsZW0gaXMgbm90IGZpeGVkIGluIHRoZSBmdW5jdGlv
biBpdHNlbGYsIHRoZW4gdGhpcyBwb3RlbnRpYWwKPiA+IHBpdGZhbGwgc2hvdWxkIGJlIGV4cGxp
Y2l0bHkgc3RhdGVkIGluIHRoZSBkb2N1bWVudGF0aW9uLgo+IAo+IFRoYXQgSSBjYW4gYWdyZWUg
d2l0aC4KPiAKPiA+IFRoaXMgaXMgYmVjYXVzZQo+ID4gaXQgaXMgZGlmZmljdWx0IHRvIHByZWRp
Y3QgZnJvbSB0aGUgZGVmaW5pdGlvbiBhbmQgbmFtaW5nIG9mIHRoZSBmdW5jdGlvbgo+ID4gdGhh
dCBpdCBtaWdodCByZXR1cm4gYSBuZWdhdGl2ZSBudW1iZXIuIEkgYWN0dWFsbHkgZGlzY292ZXJl
ZCB0aGlzIGFub21hbHkKPiA+IHdoZW4gSSB3YXMgZG9pbmcgZGF0YSBhbmFseXNpcyBvbiBteSBv
d24gaWRsZSBnb3Zlcm5vci4gRm9yIHNvbWUgaWRsZSBjb250cm9sCj4gPiBhbGdvcml0aG1zLCB0
aGlzIGV4Y2VwdGlvbiByZXR1cm4gY291bGQgbGVhZCB0byBzZXJpb3VzIGNvbnNlcXVlbmNlcywK
PiA+IGJlY2F1c2UgbmVnYXRpdmUgcmV0dXJuIGxvZ2ljYWxseSB3b24ndCBoYXBwZW4uCj4gCj4g
V2VsbCwgaXQncyBhIG1hdHRlciBvZiBob3cgdG8gdGFrZSB0aGUgcG9zc2libGUgbmVnYXRpdmUg
cmV0dXJuIHZhbHVlCj4gaW50byBhY2NvdW50IHNvIGl0IGRvZXMgbm90IGFmZmVjdCB0aGUgcmVz
dWx0IG9mIHRoZSBjb21wdXRhdGlvbnMuCgpJIHRoaW5rIGl0IGlzIGNoYWxsZW5naW5nIGZvciBz
b21lIGFsZ29yaXRobXMgdG8gdGFrZSBuZWdhdGl2ZSByZXR1cm4gdmFsdWVzIAppbnRvIGFjY291
bnQgcHJvcGVybHkuIEZvciBURU8gKGFuZCBldmVuIG1lbnUpLCBpdCBpcyBwb3NzaWJsZSB0byAK
c29sdmUgdGhlIHByb2JsZW0gYnkganVzdCBjaGFuZ2luZyB0aGUgd2F5IHRoZSBkYXRhIGlzIHJl
Y2VpdmVkIGlzIGJlY2F1c2UgdGhlIApsZWFybmluZyBtZWNoYW5pc20gZm9yIGJvdGggYWxnb3Jp
dGhtcyBpcyBzaW1wbGUuIAoKT25lIG9mIHRoZSBpbnRlcmVzdGluZyB0aGluZ3MgYWJvdXQgdGhl
IENQVUlkbGUgc3Vic3lzdGVtIGlzIHRoYXQgaXQgaXMgd2VsbCAKc3VpdGVkIHRvIGludHJvZHVj
ZSBtYWNoaW5lIGxlYXJuaW5nIGFuZCBwcm9iYWJpbGlzdGljIHN0YXRpc3RpY2FsIG1ldGhvZHMu
ClRoaXMgbWVhbnMgdGhhdCBtYW55IG9mIHRoZSBtb3JlIGNvbXBsZXggYW5kIGRhdGEtc2Vuc2l0
aXZlIGFsZ29yaXRobXMgY2FuIApwb3RlbnRpYWxseSBiZSBleHBsb3JlZC4gSW4gdGhlIGJlc3Qg
Y2FzZSB3ZSB3aWxsIHN0aWxsIG5lZWQgdG8gYWRkIGFkZGl0aW9uYWwgCmNvZGUgY29tcGxleGl0
eSB0byBhIG5ldyBhbGdvcml0aG0uCgpJdCB3b3VsZCByZWR1Y2UgYSBsb3Qgb2YgdW5uZWNlc3Nh
cnkgY29uc2lkZXJhdGlvbnMgKGZvciBleGFtcGxlLCBoaWdobGlnaHQgCnRoaXMgc2hvcnRjb21p
bmcgaW4gdGhlIGRvY3VtZW50YXRpb24pIGlmIHdlIGNvdWxkIGVuc3VyZSB0aGF0IHRoaXMgZnVu
Y3Rpb24gCndvdWxkIHdvcmsgYXMgaXQgaXMgbG9naWNhbGx5IGRlZmluZWQuIEJ1dCBJIGRvbid0
IHJlYWxseSB1bmRlcnN0YW5kIApob3cgbXVjaCBvZiBhIGJ1cmRlbiBhZGRpbmcgYW4gZXh0cmEg
YnJhbmNoIHdvdWxkIGltcG9zZSwgc28gSSBkb24ndCBrbm93IGlmIAp0aGlzIHRyYWRlb2ZmIGlz
IHdvcnRoIGl0Lgo=
