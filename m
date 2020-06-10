Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A081F4ED5
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jun 2020 09:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgFJH0g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jun 2020 03:26:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:1584 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726081AbgFJH0g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2020 03:26:36 -0400
X-UUID: b72ab5fc772b40e68d62d1f9d3e165fa-20200610
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=oVjcbyJtHSMVDm6RhFxQD8NCsbEcu2YvovIvKyEf9WA=;
        b=IUTBTpaBBmuA2LUlB2T48toWx3CdAIxf4jwMN/vX+EWykLSG+cW3QoD+NTz4iRPhdqNM6a6v2iqe40C8qev9NQ3RkkD0D7pWCTNMzoZM9DaFxdOHyylza95xCUc8rZyztB63F/bl4/TLPY8pahpKqjhvwQyWLQydopZGE1GTH6c=;
X-UUID: b72ab5fc772b40e68d62d1f9d3e165fa-20200610
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1727039160; Wed, 10 Jun 2020 15:26:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 10 Jun 2020 15:26:22 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Jun 2020 15:26:24 +0800
Message-ID: <1591773984.14659.14.camel@mtksdaap41>
Subject: Re: [PATCH v9 1/4] dt-bindings: power: avs: add mtk svs dt-bindings
From:   Roger Lu <roger.lu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Angus Lin <Angus.Lin@mediatek.com>, <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>, Fan Chen <fan.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nishanth Menon <nm@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 10 Jun 2020 15:26:24 +0800
In-Reply-To: <20200609173636.GA1125574@bogus>
References: <20200609104534.29314-1-roger.lu@mediatek.com>
         <20200609104534.29314-2-roger.lu@mediatek.com>
         <20200609173636.GA1125574@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RGVhciBSb2IsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQpPbiBUdWUsIDIwMjAtMDYt
MDkgYXQgMTE6MzYgLTA2MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBUdWUsIDA5IEp1biAy
MDIwIDE4OjQ1OjMxICswODAwLCBSb2dlciBMdSB3cm90ZToNCj4gPiBEb2N1bWVudCB0aGUgYmlu
ZGluZyBmb3IgZW5hYmxpbmcgbXRrIHN2cyBvbiBNZWRpYVRlayBTb0MuDQo+ID4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogUm9nZXIgTHUgPHJvZ2VyLmx1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4g
PiAgLi4uL2JpbmRpbmdzL3Bvd2VyL2F2cy9tdGtfc3ZzLnlhbWwgICAgICAgICAgIHwgMTQxICsr
KysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQxIGluc2VydGlvbnMoKykN
Cj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9wb3dlci9hdnMvbXRrX3N2cy55YW1sDQo+ID4gDQo+IA0KPiANCj4gTXkgYm90IGZvdW5kIGVy
cm9ycyBydW5uaW5nICdtYWtlIGR0X2JpbmRpbmdfY2hlY2snIG9uIHlvdXIgcGF0Y2g6DQo+IA0K
PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvYXZzL210a19zdnMuZXhh
bXBsZS5kdHM6MjI6MTg6IGZhdGFsIGVycm9yOiBkdC1iaW5kaW5ncy9wb3dlci9tdDgxODMtcG93
ZXIuaDogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0KPiAgICAgICAgICAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvcG93ZXIvbXQ4MTgzLXBvd2VyLmg+DQo+ICAgICAgICAgICAgICAgICAgIF5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gY29tcGlsYXRpb24gdGVybWluYXRlZC4N
Cj4gc2NyaXB0cy9NYWtlZmlsZS5saWI6MzEyOiByZWNpcGUgZm9yIHRhcmdldCAnRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL2F2cy9tdGtfc3ZzLmV4YW1wbGUuZHQueWFt
bCcgZmFpbGVkDQo+IG1ha2VbMV06ICoqKiBbRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3Bvd2VyL2F2cy9tdGtfc3ZzLmV4YW1wbGUuZHQueWFtbF0gRXJyb3IgMQ0KPiBtYWtlWzFd
OiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLg0KPiBNYWtlZmlsZToxMzAwOiBy
ZWNpcGUgZm9yIHRhcmdldCAnZHRfYmluZGluZ19jaGVjaycgZmFpbGVkDQo+IG1ha2U6ICoqKiBb
ZHRfYmluZGluZ19jaGVja10gRXJyb3IgMg0KPiANCj4gU2VlIGh0dHBzOi8vcGF0Y2h3b3JrLm96
bGFicy5vcmcvcGF0Y2gvMTMwNTgwMA0KPiANCj4gSWYgeW91IGFscmVhZHkgcmFuICdtYWtlIGR0
X2JpbmRpbmdfY2hlY2snIGFuZCBkaWRuJ3Qgc2VlIHRoZSBhYm92ZQ0KPiBlcnJvcihzKSwgdGhl
biBtYWtlIHN1cmUgZHQtc2NoZW1hIGlzIHVwIHRvIGRhdGU6DQo+IA0KPiBwaXAzIGluc3RhbGwg
Z2l0K2h0dHBzOi8vZ2l0aHViLmNvbS9kZXZpY2V0cmVlLW9yZy9kdC1zY2hlbWEuZ2l0QG1hc3Rl
ciAtLXVwZ3JhZGUNCj4gDQo+IFBsZWFzZSBjaGVjayBhbmQgcmUtc3VibWl0Lg0KDQpPb3BzLCBt
dDgxODMtcG93ZXIuaCBpcyBhZGRlZCBpbiBiZWxvdyBwYXRjaCB3aGljaCBpcyBzdGlsbCB1bmRl
ciByZXZpZXcNCmluIHBhdGNod29yay4gSW4gb3JkZXIgdG8gaGF2ZSBjb21wbGV0ZSBTVlMgZGVz
Y3JpcHRpb24sIG10ODE4My1wb3dlci5oDQppcyBhZGRlZCBpbiBtdGtfc3ZzLnlhbWwuDQoNClRo
ZXJlZm9yZSwgdGhpcyBpc3N1ZSB3aWxsIGJlIGZpeGVkIGFmdGVyIHBhdGNoIGluY2x1ZGluZyBt
dDgxODMtcG93ZXIuaA0KaXMgbWVyZ2VkLg0KDQojZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTgzLXBv
d2VyLmgNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE1NjI1MjEvDQoNCj4g
DQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
PiBMaW51eC1tZWRpYXRlayBtYWlsaW5nIGxpc3QNCj4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5m
cmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW1lZGlhdGVrDQoNCg==

