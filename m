Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B902F0B29
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 03:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbhAKCxW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 21:53:22 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:50832 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726472AbhAKCxW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jan 2021 21:53:22 -0500
X-UUID: 7ea9de077b6f4014b6316b66de40cde8-20210111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=RU7+xCTgbwjA5/NtcwBJENhgnq5+fPnUIsbPT3lI/JM=;
        b=u3b95U32sPUFB6giWzfm6HoTt305o5A02NSaF3ruxcMHyzCYwsL8IsMURf7hJ+KNQe2sDv1Rs2ZaexXJcBySZoo8IGk9UWWP3Hr6KW7CsjHhC306ITGgTJEnCXFgrHAUKZb50hrCrED2l7nyYsR9OMkEPa9dUzRculju3cGRln4=;
X-UUID: 7ea9de077b6f4014b6316b66de40cde8-20210111
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 705182530; Mon, 11 Jan 2021 10:52:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 10:52:33 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 10:52:33 +0800
Message-ID: <1610333553.2992.7.camel@mtksdaap41>
Subject: Re: [PATCH V7 01/13] dt-bindings: soc: Add dvfsrc driver bindings
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>, <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        <linux-kernel@vger.kernel.org>, Ryan Case <ryandcase@chromium.org>,
        "Arvin Wang" <arvin.wang@mediatek.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>, <devicetree@vger.kernel.org>
Date:   Mon, 11 Jan 2021 10:52:33 +0800
In-Reply-To: <1610163019.789930.3762037.nullmailer@robh.at.kernel.org>
References: <1610092095-5113-1-git-send-email-henryc.chen@mediatek.com>
         <1610092095-5113-2-git-send-email-henryc.chen@mediatek.com>
         <1610163019.789930.3762037.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 95F7C6906A6D4DC8F92E1987659365ED2D84E2337FE6B238817FF73313E3F32C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgUm9iLA0KDQpPbiBGcmksIDIwMjEtMDEtMDggYXQgMjA6MzAgLTA3MDAsIFJvYiBIZXJyaW5n
IHdyb3RlOg0KPiBPbiBGcmksIDA4IEphbiAyMDIxIDE1OjQ4OjAzICswODAwLCBIZW5yeSBDaGVu
IHdyb3RlOg0KPiA+IERvY3VtZW50IHRoZSBiaW5kaW5nIGZvciBlbmFibGluZyBkdmZzcmMgb24g
TWVkaWFUZWsgU29DLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEhlbnJ5IENoZW4gPGhlbnJ5
Yy5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc29jL21lZGlhdGVrL2R2ZnNyYy55YW1sICAgfCA2NyArKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2NyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2R2
ZnNyYy55YW1sDQo+ID4gDQo+IA0KPiBNeSBib3QgZm91bmQgZXJyb3JzIHJ1bm5pbmcgJ21ha2Ug
ZHRfYmluZGluZ19jaGVjaycgb24geW91ciBwYXRjaDoNCj4gDQo+IHlhbWxsaW50IHdhcm5pbmdz
L2Vycm9yczoNCj4gDQo+IGR0c2NoZW1hL2R0YyB3YXJuaW5ncy9lcnJvcnM6DQo+IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvZHZmc3JjLmV4YW1wbGUuZHRz
OjE5OjE4OiBmYXRhbCBlcnJvcjogZHQtYmluZGluZ3MvaW50ZXJjb25uZWN0L210ayxtdDgxODMt
ZW1pLmg6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCj4gICAgMTkgfCAgICAgICAgICNpbmNs
dWRlIDxkdC1iaW5kaW5ncy9pbnRlcmNvbm5lY3QvbXRrLG10ODE4My1lbWkuaD4NCj4gICAgICAg
fCAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn4NClNvcnJ5LCBiZWNhdXNlIHRoaXMgaGVhZGVyIGZpbGUgaXMgYWRkZWQgb24gIltWNyww
Ny8xM10gZHQtYmluZGluZ3M6DQppbnRlcmNvbm5lY3Q6IGFkZCBNVDgxODMgaW50ZXJjb25uZWN0
IGR0LWJpbmRpbmdzIi4NClNob3VsZCBJIGNoYW5nZSB0aGUgb3JkZXIgb2YgdGhlIHBhdGNoc2V0
IChsZXQgdGhlIHlhbWwgcGF0aGMgYmVoaW5kIHRoZQ0KaGVhZGVyKSB0byBmaXhlZCB0aGF0ID8N
Cg0KVGhhbmtzLA0KSGVucnkNCj4gY29tcGlsYXRpb24gdGVybWluYXRlZC4NCj4gbWFrZVsxXTog
KioqIFtzY3JpcHRzL01ha2VmaWxlLmxpYjozNDQ6IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb2MvbWVkaWF0ZWsvZHZmc3JjLmV4YW1wbGUuZHQueWFtbF0gRXJyb3IgMQ0KPiBt
YWtlOiAqKiogW01ha2VmaWxlOjEzNzA6IGR0X2JpbmRpbmdfY2hlY2tdIEVycm9yIDINCj4gDQo+
IFNlZSBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzE0MjM2NzkNCj4gDQo+IFRo
aXMgY2hlY2sgY2FuIGZhaWwgaWYgdGhlcmUgYXJlIGFueSBkZXBlbmRlbmNpZXMuIFRoZSBiYXNl
IGZvciBhIHBhdGNoDQo+IHNlcmllcyBpcyBnZW5lcmFsbHkgdGhlIG1vc3QgcmVjZW50IHJjMS4N
Cj4gDQo+IElmIHlvdSBhbHJlYWR5IHJhbiAnbWFrZSBkdF9iaW5kaW5nX2NoZWNrJyBhbmQgZGlk
bid0IHNlZSB0aGUgYWJvdmUNCj4gZXJyb3IocyksIHRoZW4gbWFrZSBzdXJlICd5YW1sbGludCcg
aXMgaW5zdGFsbGVkIGFuZCBkdC1zY2hlbWEgaXMgdXAgdG8NCj4gZGF0ZToNCj4gDQo+IHBpcDMg
aW5zdGFsbCBkdHNjaGVtYSAtLXVwZ3JhZGUNCj4gDQo+IFBsZWFzZSBjaGVjayBhbmQgcmUtc3Vi
bWl0Lg0KPiANCg0K

