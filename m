Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C68A2986C4
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 07:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770274AbgJZGNV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 02:13:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49327 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390548AbgJZGNU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 02:13:20 -0400
X-UUID: f78dc9bb1454497c8257f2d5bc1abf04-20201026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=tHaycWbdhS5D1KkhI22Nx0pfaOvhy8Oc/aWec7gTuqE=;
        b=ojaSWGuDK2+dpfjnIhfzKi7VIxYCbxGs8l38Om0erjhPA2cFMHAaBLq1fh2cvsbld/eINTUUxg5psAEMrucbrIRoQJm995Zu4yeGPOeLIyzbSPlRL4trzXt7SUOvuOuefuRMBCwNAWnVoVbxGbXqoqZUmtfRjsn98Rua2Ni4lwo=;
X-UUID: f78dc9bb1454497c8257f2d5bc1abf04-20201026
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 238537299; Mon, 26 Oct 2020 14:13:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 26 Oct 2020 14:12:56 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Oct 2020 14:12:56 +0800
Message-ID: <1603692776.20535.3.camel@mtkswgap22>
Subject: Re: [PATCH v1 2/6] dt-bindings: arm: cpus: Document
 'mtk,freq-domain' property
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Sudeep Holla <sudeep.holla@arm.com>
Date:   Mon, 26 Oct 2020 14:12:56 +0800
In-Reply-To: <20201023162003.GB2800310@bogus>
References: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
         <1603441493-18554-3-git-send-email-hector.yuan@mediatek.com>
         <20201023162003.GB2800310@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTIzIGF0IDExOjIwIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
K1N1ZGVlcA0KPiANCj4gT24gRnJpLCBPY3QgMjMsIDIwMjAgYXQgMDQ6MjQ6NDlQTSArMDgwMCwg
SGVjdG9yIFl1YW4gd3JvdGU6DQo+ID4gRnJvbTogIkhlY3Rvci5ZdWFuIiA8aGVjdG9yLnl1YW5A
bWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IEFkZCBkZXZpY2V0cmVlIGRvY3VtZW50YXRpb24gZm9y
ICdtdGssZnJlcS1kb21haW4nIHByb3BlcnR5IHNwZWNpZmljDQo+ID4gdG8gTWVkaWF0ZWsgQ1BV
cy4gVGhpcyBwcm9wZXJ0eSBpcyB1c2VkIHRvIHJlZmVyZW5jZSB0aGUgQ1BVRlJFUSBub2RlDQo+
ID4gYWxvbmcgd2l0aCB0aGUgZG9tYWluIGlkLg0KPiANCj4gT2theSwgbm93IHdlJ3ZlIGdvdCB0
aGUgc2FtZSB0aGluZyBiZWluZyBkb25lIGZvciBNZWRpYXRlaywgUUNvbSwgYW5kIA0KPiBTQ01J
LiBUaGlzIG5lZWRzIHRvIGJlIGEgY29tbW9uIGJpbmRpbmcuDQo+IA0KT0ssIHRoYW5rIHlvdS4g
SSB3aWxsIHBheSBhdHRlbnRpb24gZm9yIHRoaXMuIEJ1dCBzdGlsbA0KIm1lZGlhdGVrLGZyZXEt
ZG9tYWluIiBpbiB2OC4NCg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhlY3Rvci5ZdWFuIDxoZWN0b3Iu
eXVhbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9hcm0vY3B1cy55YW1sIHwgICAgNiArKysrKysNCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2NwdXMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9hcm0vY3B1cy55YW1sDQo+ID4gaW5kZXggMTIyMmJmMS4uMDZhNmY1YiAx
MDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2Nw
dXMueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
Y3B1cy55YW1sDQo+ID4gQEAgLTI1NSw2ICsyNTUsMTIgQEAgcHJvcGVydGllczoNCj4gPiAgDQo+
ID4gICAgICAgIHdoZXJlIHZvbHRhZ2UgaXMgaW4gViwgZnJlcXVlbmN5IGlzIGluIE1Iei4NCj4g
PiAgDQo+ID4gKyAgbXRrLWZyZXEtZG9tYWluOg0KPiANCj4gSSBleHBlY3QgdGhpcyB0byBjaGFu
Z2UsIGJ1dCBzdGlsbCBub3QgcmlnaHQgZm9ybTogPHZlbmRvcj4sPHByb3AgbmFtZT4NCj4gDQo+
IG10ayBpcyBub3QgdGhlIHJlZ2lzdGVyZWQgdmVuZG9yLg0KPiANCk9LLCB3aWxsIG1vZGlmeSB0
aGlzIGluIHY4Lih1c2UgdGhlIHByZXZpb3VzIHBhY3Roc2V0IGFuZCBtZXJnZSBhbGwNCmNoYW5n
ZXMpDQoNCj4gPiArICAgICRyZWY6ICcvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9w
aGFuZGxlLWFycmF5Jw0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIENQVXMgc3Vw
cG9ydGluZyBmcmVxLWRvbWFpbiBtdXN0IHNldCB0aGVpciAibXRrLWZyZXEtZG9tYWluIiBwcm9w
ZXJ0eQ0KPiA+ICsgICAgICB3aXRoIHBoYW5kbGUgdG8gYSBjcHVmcmVxX2h3IG5vZGUgZm9sbG93
ZWQgYnkgdGhlIGRvbWFpbiBpZC4NCj4gPiArDQo+ID4gICAgcG93ZXItZG9tYWluczoNCj4gPiAg
ICAgICRyZWY6ICcvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlLWFycmF5
Jw0KPiA+ICAgICAgZGVzY3JpcHRpb246DQo+ID4gLS0gDQo+ID4gMS43LjkuNQ0KDQo=

