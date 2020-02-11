Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 981AE158A7D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2020 08:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgBKHgN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 02:36:13 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:12453 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727467AbgBKHgN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 02:36:13 -0500
X-UUID: b6208217a42c4e998da28eb768635179-20200211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=WF9g4PEqWlupM4phER8lYwnueeO3pdMwX2AAwBSYAFg=;
        b=S7DEsO+fud6t7SGmRLazQtLkbpjWISULAdOGs8anuFOJ6bsB2qhicZ9+CHFX0BPk0P0sbB11BueuJFQ+Rel9UeFbyINcxYRxMKZ4m9gACpJqBj0CZmeoi7YF/vnZRVWQHZw/fKnPOpy6kIiblVk3Od23s0Ptu/jyusn51tog1BE=;
X-UUID: b6208217a42c4e998da28eb768635179-20200211
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1952218471; Tue, 11 Feb 2020 15:36:08 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 11 Feb 2020 15:35:03 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Feb 2020 15:36:19 +0800
Message-ID: <1581406566.14120.46.camel@mtksdaap41>
Subject: Re: [PATCH v6 1/3] dt-bindings: soc: add mtk svs dt-bindings
From:   Roger Lu <roger.lu@mediatek.com>
To:     Rob Herring <robh@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Fan Chen =?UTF-8?Q?=28=E9=99=B3=E5=87=A1=29?= 
        <fan.chen@mediatek.com>,
        HenryC Chen =?UTF-8?Q?=28=E9=99=B3=E5=BB=BA=E8=B1=AA=29?= 
        <HenryC.Chen@mediatek.com>,
        YT Lee =?UTF-8?Q?=28=E6=9D=8E=E4=BB=B0=E5=93=B2=29?= 
        <yt.lee@mediatek.com>,
        Xiaoqing Liu =?UTF-8?Q?=28=E5=88=98=E6=99=93=E5=BA=86=29?= 
        <Xiaoqing.Liu@mediatek.com>,
        Charles Yang =?UTF-8?Q?=28=E6=A5=8A=E4=BA=8E=E9=80=B2=29?= 
        <Charles.Yang@mediatek.com>,
        Angus Lin =?UTF-8?Q?=28=E6=9E=97=E7=91=9B=E8=B1=AA=29?= 
        <Angus.Lin@mediatek.com>, Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Nishanth Menon <nm@ti.com>,
        "Devicetree List" <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        <jamesjj.liao@mediatek.com>
Date:   Tue, 11 Feb 2020 15:36:06 +0800
In-Reply-To: <CAL_JsqLnVEhvAh_8DfGWRZa+MdPRpXc9sWEQ6-3HQAeUfvkOSg@mail.gmail.com>
References: <20200107070154.1574-1-roger.lu@mediatek.com>
         <20200107070154.1574-2-roger.lu@mediatek.com>
         <20200108203829.GA18987@bogus>
         <CANMq1KBu-gFy701BgFcjEwyhV9GgCCU2mkT9c8LviOJKBF30UA@mail.gmail.com>
         <CAL_JsqLnVEhvAh_8DfGWRZa+MdPRpXc9sWEQ6-3HQAeUfvkOSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgUm9iICYgTmljb2xhcywNCg0KU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5Lg0KDQpPbiBNb24s
IDIwMjAtMDEtMTMgYXQgMjM6NTAgKzA4MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBNb24s
IEphbiAxMywgMjAyMCBhdCAxMjo0NCBBTSBOaWNvbGFzIEJvaWNoYXQgPGRyaW5rY2F0QGNocm9t
aXVtLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUaHUsIEphbiA5LCAyMDIwIGF0IDQ6MzggQU0g
Um9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gT24gVHVl
LCBKYW4gMDcsIDIwMjAgYXQgMDM6MDE6NTJQTSArMDgwMCwgUm9nZXIgTHUgd3JvdGU6DQo+ID4g
PiA+IERvY3VtZW50IHRoZSBiaW5kaW5nIGZvciBlbmFibGluZyBtdGsgc3ZzIG9uIE1lZGlhVGVr
IFNvQy4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUm9nZXIgTHUgPHJvZ2VyLmx1
QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5k
aW5ncy9wb3dlci9tdGstc3ZzLnR4dCAgICAgfCA3NiArKysrKysrKysrKysrKysrKysrDQo+ID4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNzYgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9tdGstc3Zz
LnR4dA0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3Bvd2VyL210ay1zdnMudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3Bvd2VyL210ay1zdnMudHh0DQo+ID4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+ID4gPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uOWEzZTgxYjllMWQyDQo+ID4gPiA+IC0tLSAv
ZGV2L251bGwNCj4gPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3Bvd2VyL210ay1zdnMudHh0DQo+ID4gPiA+IEBAIC0wLDAgKzEsNzYgQEANCj4gPiA+ID4gKyog
TWVkaWF0ZWsgU21hcnQgVm9sdGFnZSBTY2FsaW5nIChNVEsgU1ZTKQ0KPiA+ID4gPiArDQo+ID4g
PiA+ICtUaGlzIGRlc2NyaWJlcyB0aGUgZGV2aWNlIHRyZWUgYmluZGluZyBmb3IgdGhlIE1USyBT
VlMgY29udHJvbGxlciAoYmFuaykNCj4gPiA+ID4gK3doaWNoIGhlbHBzIHByb3ZpZGUgdGhlIG9w
dGltaXplZCBDUFUvR1BVL0NDSSB2b2x0YWdlcy4gVGhpcyBkZXZpY2UgYWxzbw0KPiA+ID4gPiAr
bmVlZHMgdGhlcm1hbCBkYXRhIHRvIGNhbGN1bGF0ZSB0aGVybWFsIHNsb3BlIGZvciBhY2N1cmF0
ZWx5IGNvbXBlbnNhdGUNCj4gPiA+ID4gK3RoZSB2b2x0YWdlcyB3aGVuIHRlbXBlcmF0dXJlIGNo
YW5nZS4NCj4gPiA+ID4gKw0KPiA+ID4gPiArUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiA+ID4g
Ky0gY29tcGF0aWJsZToNCj4gPiA+ID4gKyAgLSAibWVkaWF0ZWssbXQ4MTgzLXN2cyIgOiBGb3Ig
TVQ4MTgzIGZhbWlseSBvZiBTb0NzDQo+ID4gPiA+ICstIHJlZzogQWRkcmVzcyByYW5nZSBvZiB0
aGUgTVRLIFNWUyBjb250cm9sbGVyLg0KPiA+ID4gPiArLSBpbnRlcnJ1cHRzOiBJUlEgZm9yIHRo
ZSBNVEsgU1ZTIGNvbnRyb2xsZXIuDQo+ID4gPiA+ICstIGNsb2NrcywgY2xvY2stbmFtZXM6IENs
b2NrcyBuZWVkZWQgZm9yIHRoZSBzdnMgaGFyZHdhcmUuIHJlcXVpcmVkDQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGNsb2NrcyBhcmU6DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICJtYWluIjogTWFpbiBjbG9jayBmb3Igc3ZzIGNvbnRyb2xsZXIgdG8gd29yay4NCj4gPiA+
ID4gKy0gbnZtZW0tY2VsbHM6IFBoYW5kbGUgdG8gdGhlIGNhbGlicmF0aW9uIGRhdGEgcHJvdmlk
ZWQgYnkgYSBudm1lbSBkZXZpY2UuDQo+ID4gPiA+ICstIG52bWVtLWNlbGwtbmFtZXM6IFNob3Vs
ZCBiZSAic3ZzLWNhbGlicmF0aW9uLWRhdGEiIGFuZCAiY2FsaWJyYXRpb24tZGF0YSINCj4gPiA+
ID4gKw0KPiA+ID4gPiArU3Vibm9kZXM6DQo+ID4gPiA+ICstIHN2cy1jcHUtbGl0dGxlOiBTVlMg
YmFuayBkZXZpY2Ugbm9kZSBvZiBsaXR0bGUgQ1BVDQo+ID4gPiA+ICsgIGNvbXBhdGlibGU6ICJt
ZWRpYXRlayxtdDgxODMtc3ZzLWNwdS1saXR0bGUiDQo+ID4gPiA+ICsgIG9wZXJhdGluZy1wb2lu
dHMtdjI6IE9QUCB0YWJsZSBob29rZWQgYnkgU1ZTIGxpdHRsZSBDUFUgYmFuay4NCj4gPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgU1ZTIHdpbGwgb3B0aW16ZSB0aGlzIE9QUCB0YWJsZSB2b2x0
YWdlIHBhcnQuDQo+ID4gPiA+ICsgIHZjcHUtbGl0dGxlLXN1cHBseTogUE1JQyBidWNrIG9mIGxp
dHRsZSBDUFUNCj4gPiA+ID4gKy0gc3ZzLWNwdS1iaWc6IFNWUyBiYW5rIGRldmljZSBub2RlIG9m
IGJpZyBDUFUNCj4gPiA+ID4gKyAgY29tcGF0aWJsZTogIm1lZGlhdGVrLG10ODE4My1zdnMtY3B1
LWJpZyINCj4gPiA+ID4gKyAgb3BlcmF0aW5nLXBvaW50cy12MjogT1BQIHRhYmxlIGhvb2tlZCBi
eSBTVlMgYmlnIENQVSBiYW5rLg0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICBTVlMgd2ls
bCBvcHRpbXplIHRoaXMgT1BQIHRhYmxlIHZvbHRhZ2UgcGFydC4NCj4gPiA+ID4gKyAgdmNwdS1i
aWctc3VwcGx5OiBQTUlDIGJ1Y2sgb2YgYmlnIENQVQ0KPiA+ID4gPiArLSBzdnMtY2NpOiBTVlMg
YmFuayBkZXZpY2Ugbm9kZSBvZiBDQ0kNCj4gPiA+ID4gKyAgY29tcGF0aWJsZTogIm1lZGlhdGVr
LG10ODE4My1zdnMtY2NpIg0KPiA+ID4gPiArICBvcGVyYXRpbmctcG9pbnRzLXYyOiBPUFAgdGFi
bGUgaG9va2VkIGJ5IFNWUyBDQ0kgYmFuay4NCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
U1ZTIHdpbGwgb3B0aW16ZSB0aGlzIE9QUCB0YWJsZSB2b2x0YWdlIHBhcnQuDQo+ID4gPiA+ICsg
IHZjY2ktc3VwcGx5OiBQTUlDIGJ1Y2sgb2YgQ0NJDQo+ID4gPiA+ICstIHN2cy1ncHU6IFNWUyBi
YW5rIGRldmljZSBub2RlIG9mIEdQVQ0KPiA+ID4gPiArICBjb21wYXRpYmxlOiAibWVkaWF0ZWss
bXQ4MTgzLXN2cy1ncHUiDQo+ID4gPiA+ICsgIG9wZXJhdGluZy1wb2ludHMtdjI6IE9QUCB0YWJs
ZSBob29rZWQgYnkgU1ZTIEdQVSBiYW5rLg0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICBT
VlMgd2lsbCBvcHRpbXplIHRoaXMgT1BQIHRhYmxlIHZvbHRhZ2UgcGFydC4NCj4gPiA+ID4gKyAg
dmdwdS1zdXBwbHk6IFBNSUMgYnVjayBvZiBHUFUNCj4gPiA+ID4gKw0KPiA+ID4gPiArRXhhbXBs
ZToNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICBzdnM6IHN2c0AxMTAwYjAwMCB7DQo+ID4gPiA+
ICsgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtc3ZzIjsNCj4gPiA+
ID4gKyAgICAgICAgICAgICByZWcgPSA8MCAweDExMDBiMDAwIDAgMHgxMDAwPjsNCj4gPiA+ID4g
KyAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTI3IElSUV9UWVBFX0xFVkVMX0xP
Vz47DQo+ID4gPiA+ICsgICAgICAgICAgICAgY2xvY2tzID0gPCZpbmZyYWNmZyBDTEtfSU5GUkFf
VEhFUk0+Ow0KPiA+ID4gPiArICAgICAgICAgICAgIGNsb2NrLW5hbWVzID0gIm1haW5fY2xrIjsN
Cj4gPiA+ID4gKyAgICAgICAgICAgICBudm1lbS1jZWxscyA9IDwmc3ZzX2NhbGlicmF0aW9uPiwg
PCZ0aGVybWFsX2NhbGlicmF0aW9uPjsNCj4gPiA+ID4gKyAgICAgICAgICAgICBudm1lbS1jZWxs
LW5hbWVzID0gInN2cy1jYWxpYnJhdGlvbi1kYXRhIiwgImNhbGlicmF0aW9uLWRhdGEiOw0KPiA+
ID4gPiArDQo+ID4gPiA+ICsgICAgICAgICAgICAgc3ZzX2NwdV9saXR0bGU6IHN2cy1jcHUtbGl0
dGxlIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTgzLXN2cy1jcHUtbGl0dGxlIjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
IG9wZXJhdGluZy1wb2ludHMtdjIgPSA8JmNsdXN0ZXIwX29wcD47DQo+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICB2Y3B1LWxpdHRsZS1zdXBwbHkgPSA8Jm10NjM1OF92cHJvYzEyX3JlZz47
DQo+ID4gPiA+ICsgICAgICAgICAgICAgfTsNCj4gPiA+DQo+ID4gPiBJIGRvbid0IHRoaW5rIHRo
aXMgaXMgYSBnb29kIGJpbmRpbmcuIFRoaXMgaW5mb3JtYXRpb24gYWxyZWFkeSBleGlzdHMNCj4g
PiA+IGVsc2V3aGVyZSBpbiB0aGUgRFQsIHNvIHlvdXIgZHJpdmVyIHNob3VsZCBqdXN0IGxvb2sg
aW4gdGhvc2Ugbm9kZXMuDQo+ID4gPiBGb3IgZXhhbXBsZSB0aGUgcmVndWxhdG9yIGNhbiBiZSBp
biB0aGUgY3B1IG5vZGVzIG9yIHRoZSBPUFAgdGFibGUNCj4gPiA+IGl0c2VsZi4NCj4gPg0KPiA+
IFJvZ2VyLCBpZiB0aGF0IGhlbHBzLCB3aXRob3V0IGNoYW5naW5nIGFueSBvdGhlciBiaW5kaW5n
LCBvbiA4MTgzLA0KPiA+IGJhc2ljYWxseSB5b3UgY291bGQgaGF2ZToNCj4gPiAgLSBzdnMtY3B1
LWxpdHRsZTogQWRkIGEgaGFuZGxlIHRvICZjcHUwIGFuZCBnZXQgdGhlIHJlZ3VsYXRvci9vcHAN
Cj4gPiB0YWJsZSBmcm9tIGl0Lg0KPiA+ICAtIHN2cy1jcHUtYmlnOiBIYW5kbGUgdG8gJmNwdTQN
Cj4gDQo+IFdoeSBkbyB5b3UgbmVlZCB0aG9zZT8gVXNlIHRoZSBjb21wYXRpYmxlIG9mIHRoZSBj
cHVzIHRvIGRldGVybWluZSBiaWcNCj4gYW5kIGxpdHRsZSBjb3Jlcy4gT3IgdGhlcmUncyB0aGUg
Y3B1IGNhcGFjaXR5IHByb3BlcnR5IHRoYXQgY291bGQgYmUNCj4gdXNlZCBpbnN0ZWFkLg0KPiAN
Cj4gPiAgLSBzdnMtY2NpOiBIYW5kbGUgdG8gJmNjaQ0KPiANCj4gSXMgdGhlcmUgbW9yZSB0aGFu
IDEgQ0NJPyBKdXN0IHJldHJpZXZlIHRoZSBub2RlIGJ5IHRoZSBjb21wYXRpYmxlLg0KPiBUaGVy
ZSdzIG5vIG5lZWQgdG8gaGF2ZSBub2RlcyB0aGF0IHNpbXBseSBzZXJ2ZSBhcyBhIGNvbGxlY3Rp
b24gb2YNCj4gZGF0YSBmb3Igc29tZSBkcml2ZXIuDQo+IA0KPiA+ICAtIHN2cy1ncHU6IEhhbmRs
ZSB0byAmZ3B1IChCVFcsIGl0IGlzIGV4cGVjdGVkIHRoYXQgU1ZTIHdvdWxkIG9ubHkNCj4gPiBh
cHBseSB0byB2Z3B1L21hbGkgcmVndWxhdG9yLCBhbmQgbm90IHZzcmFtIHJlZ3VsYXRvcj8pDQoN
CnN2cy1ncHUgZGVwZW5kcyBvbiB2Z3B1IHBvd2VyIG9uIGZvciBpbml0IChkb24ndCBjYXJlIHZn
cHVfc3JhbSkuIEFmdGVyDQpzdnMtZ3B1IGluaXQgaXMgZG9uZSwgaXQgZG9lc24ndCBuZWVkIHZn
cHUgcG93ZXIgb24gYW55bW9yZS4gKHZncHUgY2FuDQpiZSB0dXJuZWQgb2ZmKQ0KDQpQbGVhc2Ug
YWxsb3dzIG1lIHRvIGludHJvZHVjZSBtb3JlIGFib3V0IHdoYXQgc3ZzLWdwdSBkZXZpY2UgbmVl
ZHMuDQoxLiBJdCBuZWVkcyBncHUgb3BwIHRhYmxlIGZyb20gImdwdSBub2RlIiBhbmQgZ3B1X2Nv
cmUyIHBvd2VyLWRvbWFpbnMNCmZyb20gImdwdV9jb3JlMiBub2RlIi4gV2hlbiBzdnMtZ3B1IGhh
cyB0aG9zZSByZXNvdXJjZXMsIGl0IHR1cm5zIG9uDQpncHVfY29yZTIgcG93ZXItZG9tYWluIGZv
ciBzdnMtZ3B1LWh3IHRvIGhhdmUgcG93ZXIgKGZvciBjYWxjdWxhdGluZykNCmFuZCBzdnMtZ3B1
LXN3IHdpbGwgdXBkYXRlIGdwdSBvcHAgdGFibGUgdm9sdGFnZXMnIHBhcnQuDQoyLiBUaGVyZWZv
cmUsIGlmIEkgcmV0cmlldmUgZ3B1LXJlbGF0ZWQgbm9kZSBmcm9tIHBoYW5kbGUgb3IgY29tcGF0
aWJsZSwNCml0IG1lYW5zIHN2cy1ncHUgZGV2aWNlIGluIGRyaXZlciBuZWVkcyB0byBhdHRhY2gg
dHdvIGRpZmZlcmVudCBncHUNCm5vZGVzIGZvciBhdHRhaW5pbmcgZ3B1IG9wcCB0YWJsZSBhbmQg
Z3B1X2NvcmUyIHBvd2VyLWRvbWFpbnMuIEkgdGhpbmsNCnRoaXMgYXJjaGl0ZWN0dXJlIG9mIHN2
cy1ncHUgY29uZnVzZXMgbWFpbnRhaW5lciB3aHkgaXQgYXR0YWNoZXMgdHdvDQpkaWZmZXJlbnQg
bm9kZXMgaW5zdGVhZCBvZiBoYXZpbmcgYSBkZXZpY2UgdG8gZGVzY3JpYmUgd2hhdCBpdCBuZWVk
cy4NCjMuIElzIGl0IGFjY2VwdGFibGUgdG8gaGF2ZSBhIExpbnV4IGRldmljZSBhdHRhY2hpbmcg
dHdvIGRpZmZlcmVudA0Kbm9kZXM/IElmIHllcywgY291bGQgeW91IGd1aWRlIHVzIHNvbWUgQVBJ
cyBmb3Igb25lIGRldmljZSB0byBhdHRhY2ggdHdvDQpub2Rlcz8gSSBkb24ndCBrbm93IGhvdyB0
byBpbXBsZW1lbnQgaXQuIFRoYW5rcy4NCg0KPiA+DQo+ID4gSSdtIG5vdCB0b28gc3VyZSBob3cg
d2UnZCBmZXRjaCB0aGUgcmlnaHQgcmVndWxhdG9yIG5hbWUsIGhvd2V2ZXIgKGZvcg0KPiA+IHRo
ZSBmaXJzdCAzIHRoZSBuYW1lIGlzICJwcm9jIiwgZm9yIHRoZSBsYXN0IG9uZSBpdCdzICJtYWxp
IiksIG1heWJlDQo+ID4gYWRkIGEgcmVndWxhdG9yLW5hbWUgbGlzdCBpbiB0aGUgRFQ/DQo+IA0K
PiBUbyBwdXQgdGhpcyBhbm90aGVyIHdheSwgd3JpdGUgYW4gU29DIHNwZWNpZmljIGRyaXZlciB0
aGF0IHVuZGVyc3RhbmRzDQo+IHRvIHNvbWUgZXh0ZW50IHdoYXQgZXhpc3RzIGluIHRoZSBTb0Mg
KGFuZCBEVCkuIEkgZG91YnQgc29tZXRoaW5nIGxpa2UNCj4gdGhpcyBpcyBnb2luZyB0byBiZSBn
ZW5lcmljIGFjcm9zcyBtb3JlIHRoYW4gYSBmZXcgU29DcyBhdCBtb3N0Lg0KDQo+IA0KPiBSb2IN
Cg0K

