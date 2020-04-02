Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81F8E19BA72
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 04:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733283AbgDBCsI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 22:48:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53033 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727135AbgDBCsI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2020 22:48:08 -0400
X-UUID: e7e50957bc6545f7b02442554dc2ea23-20200402
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=yvxzSL3ARjPlbxPt4EEaC22R2omEz1sQZS0v7fH05E4=;
        b=M9SWKqKDD/H/wozrDhmb1+sitaZRdUCkhyKiSyndekrXbC0p2pkY4+Pi7CqEeUSLZetl+YHZRtc7P6YCglJ9/OlXIGUJ5QfpFWaaRVRsldXDp52Xg6PLk/sY/EF3/Wy6vNhcMt/RlU+wJfPeIQx0cB2SUyBAYf6MO0A1cfO7cec=;
X-UUID: e7e50957bc6545f7b02442554dc2ea23-20200402
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1204681270; Thu, 02 Apr 2020 10:48:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Apr 2020 10:48:02 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Apr 2020 10:48:01 +0800
Message-ID: <1585795682.27527.12.camel@mtksdaap41>
Subject: Re: [PATCH V4 00/13] Add driver for dvfsrc, support for active
 state of scpsys
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Mike Turquette <mturquette@linaro.org>,
        <srv_heupstream@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Viresh Kumar <vireshk@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Stephen Boyd" <swboyd@chromium.org>,
        Fan Chen <fan.chen@mediatek.com>, <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Ryan Case <ryandcase@chromium.org>,
        Arvin Wang <arvin.wang@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 2 Apr 2020 10:48:02 +0800
In-Reply-To: <2737cc5c-3876-6861-c44f-fc9f552bbdb9@linaro.org>
References: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
         <2737cc5c-3876-6861-c44f-fc9f552bbdb9@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgR2VvcmdpLA0KDQpPbiBXZWQsIDIwMjAtMDQtMDEgYXQgMTg6MDkgKzAzMDAsIEdlb3JnaSBE
amFrb3Ygd3JvdGU6DQo+IEhpIEhlbnJ5LA0KPiANCj4gT24gMy8xMy8yMCAxMTozNCwgSGVucnkg
Q2hlbiB3cm90ZToNCj4gPiBUaGUgcGF0Y2hzZXRzIGFkZCBzdXBwb3J0IGZvciBNZWRpYVRlayBo
YXJkd2FyZSBtb2R1bGUgbmFtZWQgRFZGU1JDDQo+ID4gKGR5bmFtaWMgdm9sdGFnZSBhbmQgZnJl
cXVlbmN5IHNjYWxpbmcgcmVzb3VyY2UgY29sbGVjdG9yKS4gVGhlIERWRlNSQyBpcw0KPiA+IGEg
SFcgbW9kdWxlIHdoaWNoIGlzIHVzZWQgdG8gY29sbGVjdCBhbGwgdGhlIHJlcXVlc3RzIGZyb20g
Ym90aCBzb2Z0d2FyZQ0KPiA+IGFuZCBoYXJkd2FyZSBhbmQgdHVybiBpbnRvIHRoZSBkZWNpc2lv
biBvZiBtaW5pbXVtIG9wZXJhdGluZyB2b2x0YWdlIGFuZA0KPiA+IG1pbmltdW0gRFJBTSBmcmVx
dWVuY3kgdG8gZnVsZmlsbCB0aG9zZSByZXF1ZXN0cy4NCj4gPiANCj4gPiBTbywgVGhpcyBzZXJp
ZXMgaXMgdG8gaW1wbGVtZW50IHRoZSBkdmZzcmMgZHJpdmVyIHRvIGNvbGxlY3QgYWxsIHRoZQ0K
PiA+IHJlcXVlc3RzIG9mIG9wZXJhdGluZyB2b2x0YWdlIG9yIERSQU0gYmFuZHdpZHRoIGZyb20g
b3RoZXIgZGV2aWNlIGRyaXZlcnMNCj4gPiBsaWtlcyBHUFUvQ2FtZXJhIHRocm91Z2ggMyBmcmFt
ZXdvcmtzIGJhc2ljYWxseToNCj4gPiANCj4gPiAxLiBpbnRlcmNvbm5lY3QgZnJhbWV3b3JrOiB0
byBhZ2dyZWdhdGUgdGhlIGJhbmR3aWR0aA0KPiA+ICAgIHJlcXVpcmVtZW50cyBmcm9tIGRpZmZl
cmVudCBjbGllbnRzDQo+ID4gDQo+ID4gWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcv
Y292ZXIvMTA3NjYzMjkvDQo+ID4gDQo+ID4gQmVsb3cgaXMgdGhlIGVtaSBiYW5kd2lkdGggbWFw
IG9mIG10ODE4My4gVGhlcmUgaGFzIGEgaHcgbW9kdWxlICJEUkFNIHNjaGVkdWxlciINCj4gPiB3
aGljaCB1c2VkIHRvIGNvbnRyb2wgdGhlIHRocm91Z2hwdXQuIFRoZSBEVkZTUkMgd2lsbCBjb2xs
ZWN0IGZvcmVjYXN0IGRhdGENCj4gPiBvZiBkcmFtIGJhbmR3aWR0aCBmcm9tIFNXIGNvbnN1bWVy
cyhjYW1lcmEvZ3B1Li4uKSwgYW5kIGFjY29yZGluZyB0aGUgZm9yZWNhc3QNCj4gPiB0byBjaGFu
Z2UgdGhlIERSQU0gZnJlcXVlbmN5DQo+ID4gDQo+ID4gICAgICAgICAgICBJQ0MgcHJvdmlkZXIg
ICAgICAgICBJQ0MgTm9kZXMNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0tLSAg
ICAgICAgICAtLS0tDQo+ID4gICAgICAgICAgICAtLS0tLS0tLS0gICAgICAgfENQVSB8ICAgfC0t
LT58VlBVIHwNCj4gPiAgIC0tLS0tICAgfCAgICAgICAgIHwtLS0tLT4gLS0tLSAgICB8ICAgICAt
LS0tDQo+ID4gIHxEUkFNIHwtLXxEUkFNICAgICB8ICAgICAgIC0tLS0gICAgfCAgICAgLS0tLQ0K
PiA+ICB8ICAgICB8LS18c2NoZWR1bGVyfC0tLS0tPnxHUFUgfCAgIHwtLS0+fERJU1B8DQo+ID4g
IHwgICAgIHwtLXwoRU1JKSAgICB8ICAgICAgIC0tLS0gICAgfCAgICAgLS0tLQ0KPiA+ICB8ICAg
ICB8LS18ICAgICAgICAgfCAgICAgICAtLS0tLSAgIHwgICAgIC0tLS0NCj4gPiAgIC0tLS0tICAg
fCAgICAgICAgIHwtLS0tLT58TU1TWVN8LS18LS0tPnxWREVDfA0KPiA+ICAgICAgICAgICAgLS0t
LS0tLS0tICAgICAgICAtLS0tLSAgIHwgICAgIC0tLS0NCj4gPiAgICAgICAgICAgICAgL3xcICAg
ICAgICAgICAgICAgICAgICB8ICAgICAtLS0tDQo+ID4gICAgICAgICAgICAgICB8Y2hhbmdlIERS
QU0gZnJlcSAgICAgfC0tLT58VkVOQ3wNCj4gPiAgICAgICAgICAgIC0tLS0tLS0tLS0gICAgICAg
ICAgICAgICB8ICAgICAtLS0tDQo+ID4gICAgICAgICAgIHwgIERWRlNSICAgfCAgICAgICAgICAg
ICAgfA0KPiA+ICAgICAgICAgICB8ICAgICAgICAgIHwgICAgICAgICAgICAgIHwgICAgIC0tLS0N
Cj4gPiAgICAgICAgICAgIC0tLS0tLS0tLS0gICAgICAgICAgICAgICB8LS0tPnxJTUcgfA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgIC0tLS0NCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAtLS0tDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfC0tLT58Q0FNIHwNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLS0tDQo+IA0KPiBJdCB3b3VsZCBiZSB1c2Vm
dWwgdG8gYWxzbyBhZGQgdGhlIGFib3ZlIGRpYWdyYW0gaW50byB0aGUgY29tbWl0IHRleHQgb2YN
Cj4gcGF0Y2ggMDkvMTMuIEJ5IGRvaW5nIHNvLCBpdCB3aWxsIGJlIHNhdmVkIGludG8gdGhlIGhp
c3RvcnksIGFzIGNvdmVyIGxldHRlcnMNCj4gYXJlIGRpc2NhcmRlZC4NCk9LLCB0aGFua3MuDQo+
IA0KPiBUaGFua3MsDQo+IEdlb3JnaQ0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCj4gTGludXgtbWVkaWF0ZWsgbWFpbGluZyBsaXN0DQo+IExp
bnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tZWRpYXRlaw0KDQo=

