Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C89938037C
	for <lists+linux-pm@lfdr.de>; Fri, 14 May 2021 07:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhENF7Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 May 2021 01:59:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55366 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230125AbhENF7X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 May 2021 01:59:23 -0400
X-UUID: 71e3dd490d024436a468134afbbef05c-20210514
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=uBkJYOBF3nBuM67e9q6aIA3FhUXGTxHk9W7aWmr1taQ=;
        b=CRURKEIoQyjN2BTuA3xHiF8nn9FvZRudLmqJgCz8VIgX4alhwy9yWgjJi9+3l66aYOpmPLvuwcL+mQ0PMEVrtvjSYVlWeMmKDyh6qR1w8H21O+AZoJhW4QX7FgR9bBVzju7LLTmql+UMw0XpVpeXVZspvmq4jUcMHYpNEROLrKs=;
X-UUID: 71e3dd490d024436a468134afbbef05c-20210514
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 945269689; Fri, 14 May 2021 13:58:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 14 May 2021 13:58:01 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 May 2021 13:58:01 +0800
Message-ID: <f64f2419217c0c8e0e269db0b480abb08040adb4.camel@mediatek.com>
Subject: Re: [PATCH v16 3/7] soc: mediatek: SVS: introduce MTK SVS engine
From:   Roger Lu <roger.lu@mediatek.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        "Charles Yang" <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        "Mark Rutland" <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 14 May 2021 13:58:01 +0800
In-Reply-To: <ec5f064f-41f1-f8f9-9a6d-fdf02c43cb8d@roeck-us.net>
References: <20210428065440.3704-1-roger.lu@mediatek.com>
         <20210428065440.3704-4-roger.lu@mediatek.com>
         <20210506045115.GA767398@roeck-us.net>
         <7a7a07adedf5d3f430fecf81aed35c6321e5b634.camel@mediatek.com>
         <ec5f064f-41f1-f8f9-9a6d-fdf02c43cb8d@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDIxLTA1LTEzIGF0IDIwOjMzIC0wNzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0K
PiBPbiA1LzEzLzIxIDg6MTAgUE0sIFJvZ2VyIEx1IHdyb3RlOg0KPiA+IEhpIEd1ZW50ZXIsDQo+
ID4gDQo+ID4gU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5IGFuZCB0aGFua3MgZm9yIHRoZSBub3Rp
Y2UuDQo+ID4gDQo+ID4gT24gV2VkLCAyMDIxLTA1LTA1IGF0IDIxOjUxIC0wNzAwLCBHdWVudGVy
IFJvZWNrIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBBcHIgMjgsIDIwMjEgYXQgMDI6NTQ6MzZQTSAr
MDgwMCwgUm9nZXIgTHUgd3JvdGU6DQo+ID4gPiA+IFRoZSBTbWFydCBWb2x0YWdlIFNjYWxpbmco
U1ZTKSBlbmdpbmUgaXMgYSBwaWVjZSBvZiBoYXJkd2FyZQ0KPiA+ID4gPiB3aGljaCBjYWxjdWxh
dGVzIHN1aXRhYmxlIFNWUyBiYW5rIHZvbHRhZ2VzIHRvIE9QUCB2b2x0YWdlDQo+ID4gPiA+IHRh
YmxlLg0KPiA+ID4gPiBUaGVuLCBEVkZTIGRyaXZlciBjb3VsZCBhcHBseSB0aG9zZSBTVlMgYmFu
ayB2b2x0YWdlcyB0bw0KPiA+ID4gPiBQTUlDL0J1Y2sNCj4gPiA+ID4gd2hlbiByZWNlaXZpbmcg
T1BQX0VWRU5UX0FESlVTVF9WT0xUQUdFLg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogUm9nZXIgTHUgPHJvZ2VyLmx1QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+
ICAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvS2NvbmZpZyAgIHwgICAxMCArDQo+ID4gPiA+ICAgZHJp
dmVycy9zb2MvbWVkaWF0ZWsvTWFrZWZpbGUgIHwgICAgMSArDQo+ID4gPiA+ICAgZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLXN2cy5jIHwgMTcyMw0KPiA+ID4gPiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+ID4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTczNCBpbnNlcnRpb25z
KCspDQo+ID4gPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL210
ay1zdnMuYw0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gWyAuLi4gXQ0KPiA+ID4gDQo+ID4gPiA+
ICsNCj4gPiA+ID4gKwlzdnNwX2lycSA9IGlycV9vZl9wYXJzZV9hbmRfbWFwKHN2c3AtPmRldi0+
b2Zfbm9kZSwgMCk7DQo+ID4gPiA+ICsJcmV0ID0gZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2lycShz
dnNwLT5kZXYsIHN2c3BfaXJxLA0KPiA+ID4gPiBOVUxMLA0KPiA+ID4gPiBzdnNfaXNyLA0KPiA+
ID4gPiArCQkJCQlzdnNwLT5pcnFmbGFncywgc3ZzcC0NCj4gPiA+ID4gPm5hbWUsDQo+ID4gPiA+
IHN2c3ApOw0KPiA+ID4gDQo+ID4gPiAwLWRheSByZXBvcnRzOg0KPiA+ID4gDQo+ID4gPiBkcml2
ZXJzL3NvYy9tZWRpYXRlay9tdGstc3ZzLmM6MTY2Mzo3LTMyOiBFUlJPUjoNCj4gPiA+IAlUaHJl
YWRlZCBJUlEgd2l0aCBubyBwcmltYXJ5IGhhbmRsZXIgcmVxdWVzdGVkIHdpdGhvdXQNCj4gPiA+
IElSUUZfT05FU0hPVA0KPiA+ID4gDQo+ID4gPiBJIHdvdWxkIGJlIGEgYml0IGNvbmNlcm5lZCBh
Ym91dCB0aGlzLiBUaGVyZSBpcyBubyBwcmltYXJ5IChoYXJkKQ0KPiA+ID4gaW50ZXJydXB0IGhh
bmRsZXIsIG1lYW5pbmcgdGhlIGhhcmQgaW50ZXJydXB0IG1heSBiZSByZS1lbmFibGVkDQo+ID4g
PiBhZnRlcg0KPiA+ID4gdGhlIGRlZmF1bHQgaGFyZCBpbnRlcnJ1cHQgaGFuZGxlciBydW5zLiBU
aGlzIG1pZ2h0IHJlc3VsdCBpbg0KPiA+ID4gZW5kbGVzcw0KPiA+ID4gaW50ZXJydXB0cy4NCj4g
PiANCj4gPiBPaCwgd2UgYWRkIElSUUZfT05FU0hPVCBpbiAic3ZzX2dldF9zdnNfbXQ4MTgzX3Bs
YXRmb3JtX2RhdGEoKSIgZm9yDQo+ID4gdGhyZWFkZWQgaXJxLiBTbywgcGxlYXNlIGtpbmRseSBs
ZXQgdXMga25vdyBpZiB3ZSBuZWVkIHRvIHNldCBtb3JlDQo+ID4gZmxhZ3Mgb3IgYW55IG90aGVy
IHBvdGVudGlhbCByaXNrcyB3ZSBzaG91bGQgYmUgYXdhcmUuIFRoYW5rcyBpbg0KPiA+IGFkdmFu
Y2UuDQo+ID4gDQo+IA0KPiBBZnRlciByZXZpZXdpbmcgdGhlIGNvZGUsIEkgdGhpbmsgdGhpcyB3
YXMgYWN0dWFsbHkgYSBmYWxzZSBhbGFybSwNCj4gYXQgbGVhc3QgaWYgc3ZzcC0+aXJxZmxhZ3Mg
YWx3YXlzIGluY2x1ZGVzIElSUUZfT05FU0hPVC4NCj4gVGhlIGNvZGUgaXMga2luZCBvZiB1bnVz
dWFsLCB0aG91Z2guIFVubGVzcyBJIGFtIG1pc3Npbmcgc29tZXRoaW5nLA0KPiBzdnNwLT5pcnFm
bGFncyBpcyBvbmx5IHNldCBpbiBvbmUgcGxhY2UgYW5kIGl0IGlzIGFsd2F5cyBzZXQNCj4gdG8g
SVJRRl9UUklHR0VSX0xPVyB8IElSUUZfT05FU0hPVC4gSWYgdGhlcmUgaXMgYSByZW1vdGUgY2hh
bmNlDQo+IHRoYXQgdGhlIGZsYWcgaXMgZXZlciBkaWZmZXJlbnQsIGl0IHdvdWxkIGhhdmUgYmVl
biBiZXR0ZXIgKGFuZCBsZXNzDQo+IGNvbmZ1c2luZykgdG8gc3BlY2lmeSBJUlFGX09ORVNIT1Qg
ZGlyZWN0bHkgd2hlbiByZXF1ZXN0aW5nIHRoZQ0KPiBpbnRlcnJ1cHQgKGJlY2F1c2UgaXQgaXMg
YWx3YXlzIG5lZWRlZCwgbm8gbWF0dGVyIHdoaWNoIFNPQykuDQo+IElmIHRoZSBmbGFncyBhcmUg
YWx3YXlzIHRoZSBzYW1lLCB0aGVyZSBpcyBubyByZWFzb24gZm9yIGhhdmluZw0KPiB0aGUgc3Zz
cC0+aXJxZmxhZ3MgdmFyaWFibGUgaW4gdGhlIGZpcnN0IHBsYWNlLg0KDQpUaGFua3MgZm9yIHRo
ZSBhZHZpY2UuIFdlIHN0aWxsIG5lZWQgc3ZzcC0+aXJxZmxhZ3MgZm9yIGN1c3RvbWl6aW5nDQpk
aWZmZXJlbnQgU29DIHJlcXVpcmVtZW50IGFzIFsxXSBhbmQgSSdsbCBzcGVjaWZ5IElSUUZfT05F
U0hPVCBkaXJlY3RseQ0KYXMgWzJdIGluIHRoZSBuZXh0IHZlcnNpb24uDQoNClsxXQ0KbXQ4MTgz
IHNldHRpbmc6IHN2c3AtPmlycWZsYWdzID0gSVJRRl9UUklHR0VSX0xPVyB8IElSUUZfT05FU0hP
VDsNCm10ODE5MiBzZXR0aW5nOiBzdnNwLT5pcnFmbGFncyA9IElSUUZfVFJJR0dFUl9ISUdIIHwg
SVJRRl9PTkVTSE9UOw0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzE0
MTkzMDkvIChtdDgxOTIpDQoNClsyXQ0KcmV0ID0gZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2lycShz
dnNwLT5kZXYsIHN2c3BfaXJxLCBOVUxMLCBzdnNfaXNyLA0KCQkJCXN2c3AtPmlycWZsYWdzIHwg
SVJRRl9PTkVTSE9ULA0KCQkJCXN2c3AtPm5hbWUsIHN2c3ApOw0KPiANCj4gVGhhbmtzLA0KPiBH
dWVudGVyDQo=

