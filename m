Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC9D252EF0
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 14:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgHZMtQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 08:49:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47456 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729391AbgHZMtP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 08:49:15 -0400
X-UUID: 957785375bed4822880843a1e84212d0-20200826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=1gb8b+Ui/IVbAkliUc2c8Qp4qwqKoKYNM6ImDOzJa70=;
        b=TdzYSWAjtd3pyH4v7TAWSs0H0PokkUmb9Rngdy8QBQ9PENvv5VaHWbuHLdrniQ5VBsNoQKsdi5hFv7/QD/C3pjDABGwBfjC1zPy9xHzUQwRptFXj3XIMk1xrJOYpNqRSQErsvjLyNdc19+5YpJF9IVzK6tlCXf3TCRDDsqz83lY=;
X-UUID: 957785375bed4822880843a1e84212d0-20200826
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 336916498; Wed, 26 Aug 2020 20:49:09 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 20:49:04 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Aug 2020 20:49:04 +0800
Message-ID: <1598446146.24220.3.camel@mtkswgap22>
Subject: Re: [PATCH v2 2/2] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Olof Johansson" <olof@lixom.net>, <linux-kernel@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Wed, 26 Aug 2020 20:49:06 +0800
In-Reply-To: <20200825020423.GA3775564@bogus>
References: <1597302475-15484-1-git-send-email-hector.yuan@mediatek.com>
         <1597302475-15484-3-git-send-email-hector.yuan@mediatek.com>
         <20200825020423.GA3775564@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FC8CA34D7E1F830DBBC874996877A67BE735930B81B24B447A665FB1DD6E0FBA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gTW9uLCAyMDIwLTA4LTI0IGF0IDIwOjA0IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVGh1LCBBdWcgMTMsIDIwMjAgYXQgMDM6MDc6NTVQTSArMDgwMCwgSGVjdG9yIFl1YW4gd3Jv
dGU6DQo+ID4gRnJvbTogIkhlY3Rvci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0K
PiA+IA0KPiA+IEFkZCBkZXZpY2V0cmVlIGJpbmRpbmdzIGZvciBNZWRpYVRlayBIVyBkcml2ZXIu
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSGVjdG9yLll1YW4gPGhlY3Rvci55dWFuQG1lZGlh
dGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRp
YXRlay1ody55YW1sICAgICAgfCAgIDYxICsrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3B1ZnJlcS9jcHVmcmVxLW1lZGlhdGVrLWh3
LnlhbWwNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sDQo+ID4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwLi41OWJiMjRlDQo+ID4gLS0t
IC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9j
cHVmcmVxL2NwdWZyZXEtbWVkaWF0ZWstaHcueWFtbA0KPiA+IEBAIC0wLDAgKzEsNjEgQEANCj4g
PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1
c2UpDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8vZGV2aWNldHJl
ZS5vcmcvc2NoZW1hcy9jcHVmcmVxL2NwdWZyZXEtbWVkaWF0ZWstaHcueWFtbCMNCj4gPiArJHNj
aGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4g
Kw0KPiA+ICt0aXRsZTogTWVkaWFUZWsncyBDUFVGUkVRIEJpbmRpbmdzDQo+ID4gKw0KPiA+ICtt
YWludGFpbmVyczoNCj4gPiArICAtIEhlY3RvciBZdWFuIDxoZWN0b3IueXVhbkBtZWRpYXRlay5j
b20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjoNCj4gPiArICBDUFVGUkVRIEhXIGlzIGEgaGFy
ZHdhcmUgZW5naW5lIHVzZWQgYnkgTWVkaWFUZWsNCj4gPiArICBTb0NzIHRvIG1hbmFnZSBmcmVx
dWVuY3kgaW4gaGFyZHdhcmUuIEl0IGlzIGNhcGFibGUgb2YgY29udHJvbGxpbmcgZnJlcXVlbmN5
DQo+ID4gKyAgZm9yIG11bHRpcGxlIGNsdXN0ZXJzLg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoN
Cj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgY29uc3Q6IG1lZGlhdGVrLGNwdWZyZXEtaHcN
Cj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsgICAgbWluSXRlbXM6IDENCj4gPiArICAgIG1heEl0
ZW1zOiAyDQo+ID4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICBBZGRyZXNzZXMgYW5k
IHNpemVzIGZvciB0aGUgbWVtb3J5IG9mIHRoZSBIVyBiYXNlcyBpbiBlYWNoIGZyZXF1ZW5jeSBk
b21haW4uDQo+ID4gKw0KPiA+ICsgIHJlZy1uYW1lczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsg
ICAgICAtIGNvbnN0OiAiZnJlcS1kb21haW4wIg0KPiA+ICsgICAgICAtIGNvbnN0OiAiZnJlcS1k
b21haW4xIg0KPiANCj4gTm90IGFsbCB0aGF0IHVzZWZ1bCBvZiBhIG5hbWUgZ2l2ZW4gaXQncyBi
YXNlZCBvbiB0aGUgaW5kZXguDQpMZXQgbWUgZXhwbGFpbiB0aGlzIGluZGV4IGlzIGFib3V0IHRv
IG1hcCBjcHVzIHRvIGVhY2ggZnJlcXVlbmN5IGNvbnRyb2wNCmRvbWFpbi4gV2lsbCB1cGRhdGUg
ZGV0YWlscyB1c2FnZSBpbiBWMy4gVGhhbmsgeW91Lg0KPiA+ICsgICAgZGVzY3JpcHRpb246IHwN
Cj4gPiArICAgICAgRnJlcXVlbmN5IGRvbWFpbiBuYW1lLg0KPiA+ICsNCj4gPiArICAiI2ZyZXEt
ZG9tYWluLWNlbGxzIjoNCj4gPiArICAgIGNvbnN0OiAxDQo+ID4gKyAgICBkZXNjcmlwdGlvbjog
fA0KPiA+ICsgICAgICBOdW1iZXIgb2YgY2VsbHMgaW4gYSBmcmVxZW5jeSBkb21haW4gc3BlY2lm
aWVyLg0KPiANCj4gV2hhdCdzIHRoaXMgZm9yPw0KPiBMaWtlIHRoZSBwcmV2aW91cyBtZW50aW9u
ZWQsIHRoaXMgaXMgZm9yIGluZGV4IG1hcHBpbmcuIHdpbGwgdXBkYXRlIGluIFYzLiBUaGFuayB5
b3UuDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAt
IHJlZw0KPiA+ICsgIC0gcmVnLW5hbWVzDQo+ID4gKyAgLSAiI2ZyZXEtZG9tYWluLWNlbGxzIg0K
PiA+ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtleGFt
cGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgIHNvYyB7DQo+ID4gKyAgICAgICAgI2FkZHJlc3Mt
Y2VsbHMgPSA8Mj47DQo+ID4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKw0KPiA+
ICsgICAgICAgIGNwdWZyZXFfaHc6IGNwdWZyZXFAMTFiYzAwIHsNCj4gPiArICAgICAgICAgICAg
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxjcHVmcmVxLWh3IjsNCj4gPiArICAgICAgICAgICAgcmVn
ID0gPDAgMHgxMWJjMTAgMCAweDhjPiwNCj4gPiArICAgICAgICAgICAgICAgPDAgMHgxMWJjYTAg
MCAweDhjPjsNCj4gPiArICAgICAgICAgICAgcmVnLW5hbWVzID0gImZyZXEtZG9tYWluMCIsICJm
cmVxLWRvbWFpbjEiOw0KPiA+ICsgICAgICAgICAgICAjZnJlcS1kb21haW4tY2VsbHMgPSA8MT47
DQo+ID4gKyAgICAgICAgfTsNCj4gPiArICAgIH07DQo+ID4gKw0KPiA+IC0tIA0KPiA+IDEuNy45
LjUNCg0K

