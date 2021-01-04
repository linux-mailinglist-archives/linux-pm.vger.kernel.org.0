Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00F82E92E3
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 10:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbhADJwr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 04:52:47 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58564 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726178AbhADJwr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 04:52:47 -0500
X-UUID: 505866cf11114a4c901b7f44555e4c66-20210104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=sjTcMeyoXjN87Rhyg4qitaPKUaKrIT8FGe/kft/Q+nU=;
        b=toVXNAnF4COoB0mfQAEUT8Mv6cV/aV5I5jC6T26v0ChYRLXXHRwVymM00aiOV1OmNz+KYiOIqMrzZsmMU1s8yiAB8JFiMASFdjCNAGLMQ2EhKjsvaaNeye+ejA8SRUBtVQy81tlODxBum6FqfJ30Nx3KBMLB4uinRCJoFx3HghU=;
X-UUID: 505866cf11114a4c901b7f44555e4c66-20210104
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 744153943; Mon, 04 Jan 2021 17:52:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 4 Jan 2021 17:52:00 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 4 Jan 2021 17:52:01 +0800
Message-ID: <1609753920.7157.3.camel@mtksdaap41>
Subject: Re: [PATCH v10 3/7] [v10, 3/7]: soc: mediatek: SVS: introduce MTK
 SVS engine
From:   Roger Lu <roger.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, Angus Lin <Angus.Lin@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>, Fan Chen <fan.chen@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "HenryC Chen" <HenryC.Chen@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 4 Jan 2021 17:52:00 +0800
In-Reply-To: <CANMq1KDxVLo=JAAq-gjybke1WiX03COwNX7sHsZDMF9USzSECw@mail.gmail.com>
References: <20201227105449.11452-1-roger.lu@mediatek.com>
         <20201227105449.11452-4-roger.lu@mediatek.com>
         <CANMq1KBNKy708Vz67WOc+n7V7ne4L1EZVkUVGj6abd5voxKjxA@mail.gmail.com>
         <1609750266.20758.40.camel@mtksdaap41>
         <CANMq1KDxVLo=JAAq-gjybke1WiX03COwNX7sHsZDMF9USzSECw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgTmljb2xhcywNCg0KT24gTW9uLCAyMDIxLTAxLTA0IGF0IDE3OjI3ICswODAwLCBOaWNvbGFz
IEJvaWNoYXQgd3JvdGU6DQo+IE9uIE1vbiwgSmFuIDQsIDIwMjEgYXQgNDo1MSBQTSBSb2dlciBM
dSA8cm9nZXIubHVAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4gSGkgTmljb2xh
cywNCj4gPg0KPiA+IFRoYW5rcyBmb3IgYWxsIHRoZSBhZHZpY2VzLg0KPiA+DQo+ID4gT24gVGh1
LCAyMDIwLTEyLTMxIGF0IDEwOjEwICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6DQo+ID4g
PiBPbiBTdW4sIERlYyAyNywgMjAyMCBhdCA2OjU1IFBNIFJvZ2VyIEx1IDxyb2dlci5sdUBtZWRp
YXRlay5jb20+IHdyb3RlOg0KPiBbc25pcF0NCj4gPiA+ID4gK3N0YXRpYyBpbnQgc3ZzX2FkanVz
dF9wbV9vcHBfdm9sdHMoc3RydWN0IHN2c19iYW5rICpzdnNiLCBib29sIGZvcmNlX3VwZGF0ZSkN
Cj4gPiA+ID4gK3sNCj4gPiA+ID4gKyAgICAgICBpbnQgdHpvbmVfdGVtcCwgcmV0ID0gLUVQRVJN
Ow0KPiA+ID4NCj4gPiA+IE5vIG5lZWQgdG8gaW5pdGlhbGl6ZSByZXQuDQo+ID4NCj4gPiBPaCwg
ZXhjdXNlIG1lLCBzb21lIGNvZGluZyBjaGVjayB0b29sIHdhcm4gdGhhdCB0aGlzIGByZXRgIG1p
Z2h0IHJldHVybg0KPiA+IHdpdGhvdXQgYmVpbmcgdW5pbml0aWFsaXplZC4gVGhlcmVmb3JlLCBJ
J2xsIGtlZXAgdGhlIGluaXRpYWxpemF0aW9uLg0KPiANCj4gT2gsIHlvdSdyZSByaWdodCwgdGhl
cmUgaXMgYSBwb3NzaWJsZSBwYXRoIHdoZXJlIHJldCBpcyBub3Qgc2V0LiBzZ3RtIHRoZW4uDQo+
IA0KPiA+DQo+ID4gPg0KPiA+ID4gPiArICAgICAgIHUzMiBpLCBzdnNiX3ZvbHQsIG9wcF92b2x0
LCB0ZW1wX29mZnNldCA9IDA7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICBtdXRleF9sb2Nr
KCZzdnNiLT5sb2NrKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIC8qDQo+ID4gPiA+ICsg
ICAgICAgICogSWYgc3ZzIGJhbmsgaXMgc3VzcGVuZGVkLCBpdCBtZWFucyBzaWduZWQtb2ZmIHZv
bHRhZ2VzIGFyZSBhcHBsaWVkLg0KPiA+ID4gPiArICAgICAgICAqIERvbid0IG5lZWQgdG8gdXBk
YXRlIG9wcCB2b2x0YWdlIGFueW1vcmUuDQo+ID4gPiA+ICsgICAgICAgICovDQo+ID4gPiA+ICsg
ICAgICAgaWYgKHN2c2ItPnN1c3BlbmRlZCAmJiAhZm9yY2VfdXBkYXRlKSB7DQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICBkZXZfbm90aWNlKHN2c2ItPmRldiwgImJhbmsgaXMgc3VzcGVuZGVkXG4i
KTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldCA9IC1FUEVSTTsNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgIGdvdG8gdW5sb2NrX211dGV4Ow0KPiA+ID4gPiArICAgICAgIH0NCj4gPiA+ID4g
Kw0KPiA+ID4gPiArICAgICAgIC8qIEdldCB0aGVybWFsIGVmZmVjdCAqLw0KPiA+ID4gPiArICAg
ICAgIGlmIChzdnNiLT5waGFzZSA9PSBTVlNCX1BIQVNFX01PTikgew0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgaWYgKHN2c2ItPnRlbXAgPiBzdnNiLT50ZW1wX3VwcGVyX2JvdW5kICYmDQo+ID4g
PiA+ICsgICAgICAgICAgICAgICAgICAgc3ZzYi0+dGVtcCA8IHN2c2ItPnRlbXBfbG93ZXJfYm91
bmQpIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2X3dhcm4oc3ZzYi0+ZGV2
LCAic3ZzYiB0ZW1wID0gMHgleD9cbiIsIHN2c2ItPnRlbXApOw0KPiA+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICByZXQgPSAtRUlOVkFMOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBnb3RvIHVubG9ja19tdXRleDsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiA+
ID4gKw0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0ID0gc3ZzX2dldF9iYW5rX3pvbmVfdGVt
cGVyYXR1cmUoc3ZzYi0+dHpvbmVfbmFtZSwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ0em9uZV90ZW1wKTsNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgIGlmIChyZXQpIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ZGV2X2VycihzdnNiLT5kZXYsICJubyBcIiVzXCI/KCVkKT9cbiIsDQo+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3ZzYi0+dHpvbmVfbmFtZSwgcmV0KTsNCj4gPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgZGV2X2VycihzdnNiLT5kZXYsICJzZXQgc2lnbmVkLW9m
ZiB2b2x0YWdlXG4iKTsNCj4gPiA+DQo+ID4gPiBQbGVhc2UgbWVyZ2UgdGhlIGVycm9yIG1lc3Nh
Z2UgaW4gb25lIGxpbmUgKEknbSBub3Qgc3VyZSB3aGF0ICJzZXQNCj4gPiA+IHNpZ25lZC1vZmYg
dm9sdGFnZSIgbWVhbnMgaGVyZSkuDQo+ID4NCj4gPiAxLiBPaywgSSdsbCBtZXJnZSB0aGVtLiBU
aGFua3MuDQo+ID4gMi4gc2lnbmVkLW9mZiB2b2x0YWdlcyBtZWFucyBDUFUgRFZGUyBkZWZhdWx0
IHZvbHRhZ2VzDQo+IA0KPiBTbyBqdXN0IHdyaXRlICJkZWZhdWx0IHZvbHRhZ2VzIiB0aGVuPyAs
LSkNCg0KT2ssIHRoYW5rcy4gOikNCg0KPiANCj4gPg0KPiA+ID4NCj4gW3NuaXBdDQo+ID4gPiA+
ICtzdGF0aWMgaXJxcmV0dXJuX3Qgc3ZzX2lzcihpbnQgaXJxLCB2b2lkICpkYXRhKQ0KPiA+ID4g
PiArew0KPiA+ID4gPiArICAgICAgIHN0cnVjdCBzdnNfcGxhdGZvcm0gKnN2c3AgPSAoc3RydWN0
IHN2c19wbGF0Zm9ybSAqKWRhdGE7DQo+ID4gPg0KPiA+ID4gY2FzdCBub3QgbmVlZGVkLg0KPiA+
DQo+ID4gT2ssIEknbGwgcmVtb3ZlIGl0LiBUaGFua3MuDQo+ID4NCj4gPiA+DQo+ID4gPiA+ICsg
ICAgICAgc3RydWN0IHN2c19iYW5rICpzdnNiID0gTlVMTDsNCj4gPiA+ID4gKyAgICAgICB1bnNp
Z25lZCBsb25nIGZsYWdzOw0KPiA+ID4gPiArICAgICAgIHUzMiBpZHgsIGludF9zdHMsIHN2c19l
bjsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIGZvciAoaWR4ID0gMDsgaWR4IDwgc3ZzcC0+
YmFua19udW07IGlkeCsrKSB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBzdnNiID0gJnN2c3At
PmJhbmtzW2lkeF07DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHNwaW5fbG9j
a19pcnFzYXZlKCZtdGtfc3ZzX2xvY2ssIGZsYWdzKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAg
IHN2c3AtPnBiYW5rID0gc3ZzYjsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgICAgICAgICAg
LyogRmluZCBvdXQgd2hpY2ggc3ZzIGJhbmsgZmlyZXMgaW50ZXJydXB0ICovDQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICBpZiAoc3ZzYi0+aW50X3N0ICYgc3ZzX3JlYWRsKHN2c3AsIElOVFNUKSkg
ew0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3Jl
KCZtdGtfc3ZzX2xvY2ssIGZsYWdzKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
Y29udGludWU7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gPiA+ICsNCj4gPiA+ID4g
KyAgICAgICAgICAgICAgIGlmICghc3ZzYi0+c3VzcGVuZGVkKSB7DQo+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHN2c19zd2l0Y2hfYmFuayhzdnNwKTsNCj4gPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgaW50X3N0cyA9IHN2c19yZWFkbChzdnNwLCBJTlRTVFMpOw0KPiA+ID4g
PiArICAgICAgICAgICAgICAgICAgICAgICBzdnNfZW4gPSBzdnNfcmVhZGwoc3ZzcCwgU1ZTRU4p
Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChpbnRfc3Rz
ID09IFNWU0JfSU5UU1RTX0NPTVBMRVRFICYmDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAoKHN2c19lbiAmIFNWU0JfRU5fTUFTSykgPT0gU1ZTQl9FTl9JTklUMDEpKQ0KPiA+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN2c19pbml0MDFfaXNyX2hhbmRs
ZXIoc3ZzcCk7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGVsc2UgaWYgKChpbnRf
c3RzID09IFNWU0JfSU5UU1RTX0NPTVBMRVRFKSAmJg0KPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAoKHN2c19lbiAmIFNWU0JfRU5fTUFTSykgPT0gU1ZTQl9FTl9JTklU
MDIpKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN2c19pbml0MDJf
aXNyX2hhbmRsZXIoc3ZzcCk7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGVsc2Ug
aWYgKCEhKGludF9zdHMgJiBTVlNCX0lOVFNUU19NT05WT1ApKQ0KPiA+ID4NCj4gPiA+ICEhIGlz
IG5vdCByZXF1aXJlZC4NCj4gPg0KPiA+IE9rLCBJJ2xsIHJlbW92ZSBpdC4gVGhhbmtzLg0KPiA+
DQo+ID4gPg0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN2c19tb25f
bW9kZV9pc3JfaGFuZGxlcihzdnNwKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ZWxzZQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN2c19lcnJvcl9p
c3JfaGFuZGxlcihzdnNwKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiA+ID4gKw0K
PiA+ID4gPiArICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbXRrX3N2c19s
b2NrLCBmbGFncyk7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBicmVhazsNCj4gPiA+ID4gKyAg
ICAgICB9DQo+ID4gPg0KPiA+ID4gVGhpcyB3aWxsIHBhbmljIGlmIHN2c2IgaXMgTlVMTCwgaXMg
dGhhdCBvayBvciBkbyB5b3Ugd2FudCB0byBjYXRjaCB0aGF0Pw0KPiA+DQo+ID4gT2gsIGl0IGlz
IGZpbmUuIFRoYW5rcyBmb3IgdGhlIGhlYWRzLXVwLg0KPiANCj4gSSBzaG91bGQgaGF2ZSBiZWVu
IHN0cm9uZ2VyIGluIG15IHN0YXRlbWVudCwgSSB0aGluayB5b3Ugd2FudCB0byBhZGQgYQ0KPiBC
VUdfT04oIXN2c2IpIHRvIGNyYXNoIGluIGEgc2xpZ2h0bHkgbW9yZSBwcmVkaWN0YWJsZSBtYW5u
ZXIuDQoNCk9rLCBJJ2xsIGFkZCBCVUdfT04oIXN2c2IpIHRvIGdpdmUgYW4gZXZpZGVudCBoZWFk
cy11cC4gVGhhbmtzLg0KDQo+IA0KPiBbc25pcF0NCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAg
IHN2c3AtPnRlZnVzZSA9ICh1MzIgKiludm1lbV9jZWxsX3JlYWQoY2VsbCwgJnN2c3AtPnRlZnVz
ZV9udW0pOw0KPiA+ID4NCj4gPiA+IENhc3Qgbm90IG5lZWRlZC4NCj4gPg0KPiA+IE9rLCBJJ2xs
IHJlbW92ZSBpdCBpZiBidWlsZC90ZXN0IG9rLiBCZWNhdXNlIG52bWVtX2NlbGxfcmVhZCByZXR1
cm5zDQo+ID4gKHZvaWQgKikuDQo+ID4NCj4gPiA+DQo+ID4gPiBBbHNvLCB0aGlzIG5lZWQgdG8g
YmUgZnJlZWQgc29tZXdoZXJlIGluIHJlbW92ZSBjb2RlIChrZnJlZShzdnNwLT50ZWZ1c2UpKS4N
Cj4gPiA+DQo+ID4gPiBBbmQgaXQgc2VlbXMgbGlrZSBzdnNwLT50ZWZ1c2UgaXMgb25seSB1c2Vk
IGluIHRoaXMgZnVuY3Rpb24sIGNhbiB5b3UNCj4gPiA+IGp1c3QgYWxsb2NhdGUgaXQgaGVyZT8N
Cj4gPg0KPiA+IE9oLCBzdnNwLT50ZWZ1c2Ugd2lsbCBiZSB1c2VkIGluIFNWUyBkZWJ1ZyBwYXRj
aCBmb3IgZGVidWcgcHVycG9zZS4gU28sDQo+ID4gSSBuZWVkIHRvIHNhdmUgaXQgYXMgc3RydWN0
IG1lbWJlci4NCj4gDQo+IE9oIEkgbWlzc2VkIHRoYXQsIHNndG0gdGhlbi4gVGhhbmtzLg0KPiAN
Cj4gPg0KPiBbc25pcF0NCg0K

