Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55820278176
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 09:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgIYHZ6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 03:25:58 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40580 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727183AbgIYHZ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 03:25:58 -0400
X-UUID: 44f2c2cc6fd442408e74c46367601df7-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=qR+6jO15KAuDt/EGf8Txytwkys5qSReDtq36TcjNmZg=;
        b=pbldmRyfG3USG3/0C/3coFn01dHuKTjB8Ja8GfkwKf9yhxw4ZXQDZA5izOtR1YAWRdOd9cAElWYwFYqY5nwbyPMi8j9lkzeptIaZLAOEKPXa+uTiVrLwg7AyJJgbqMecMiEE3sQnxyc8xscBZVAXb7hffPE3O++Fh5adHXv6+No=;
X-UUID: 44f2c2cc6fd442408e74c46367601df7-20200925
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1516025203; Fri, 25 Sep 2020 15:25:51 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 15:25:47 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 15:25:48 +0800
Message-ID: <1601018748.21446.43.camel@mtkswgap22>
Subject: Re: [PATCH v7 2/2] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>
CC:     Rob Herring <robh@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Fri, 25 Sep 2020 15:25:48 +0800
In-Reply-To: <20200925061543.5hxs3ija2y53gzea@vireshk-i7>
References: <1599712262-8819-1-git-send-email-hector.yuan@mediatek.com>
         <1599712262-8819-3-git-send-email-hector.yuan@mediatek.com>
         <20200922202852.GA3134161@bogus> <1600866614.21446.18.camel@mtkswgap22>
         <1601000847.21446.34.camel@mtkswgap22>
         <20200925061543.5hxs3ija2y53gzea@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1A08A85A014F2A3DFCD670D1D164310B29665174DC1C1C9978AFB07F1C124E7D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFJvYiBzaXI6DQoNClllcywgbXkgcGF0Y2ggZm9sbG93cw0KRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1xY29tLWh3LnR4dCB3YXkgdG8NCmRlZmlu
ZSBmcmVxdWVuY3kgZG9tYWluLg0KSXMgaXQgT0sgdG8geW91IGlmIEkgdXNlIHRoZSBzYW1lIHdh
eSB0byBkbz8NCkFuZCBpZiB0aGVyZSBleGlzdCBhbnkgc2NoZW1hIHByb2JsZW0sIHBsZWFzZSBr
aW5kbHkgbGV0IG1lIGtub3cgaG93IHRvDQpmaXggaXQuDQoNCk15IHBhdGNoIHJlZmVyZW5jZQ0K
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvdGhlcm1hbC1jb29saW5n
LWRldmljZXMueWFtbA0KdG8gdXNlIHRoZSBjcHUgbm9kZS4NCmh0dHBzOi8vZWxpeGlyLmJvb3Rs
aW4uY29tL2xpbnV4L3Y1LjktcmM2L3NvdXJjZS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvdGhlcm1hbC90aGVybWFsLWNvb2xpbmctZGV2aWNlcy55YW1sDQoNClRoYW5rcyBhIGxv
dC4NCg0KT24gRnJpLCAyMDIwLTA5LTI1IGF0IDExOjQ1ICswNTMwLCBWaXJlc2ggS3VtYXIgd3Jv
dGU6DQo+IE9uIDI1LTA5LTIwLCAxMDoyNywgSGVjdG9yIFl1YW4gd3JvdGU6DQo+ID4gSGksIFZp
cmVzaCAmIFJvYiBTaXI6DQo+ID4gDQo+ID4gSSB3aWxsIGNoYW5nZSBmcmVxdWVuY3kgZG9tYWlu
IHRvIGJlbG93IGFuZCBkZWZpbmUgaXQgaW4gY3B1ZnJlcV9odw0KPiA+IHNjaGVtYSByYXRoZXIg
dGhhbiBjcHUgbm9kZS4NCj4gPiANCj4gPiBtZWRpYXRlayxmcmVxLWRvbWFpbi0wID0gPCZjcHUw
PiwgPCZjcHUxPjsNCj4gDQo+IEkgdGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIHRvIGRvIGl0IHRo
ZSBzdGFuZGFyZCB3YXkgd2UgaGF2ZSBkb25lIGl0IGVsc2V3aGVyZS4NCj4gaS5lLiBmb2xsb3cg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1xY29tLWh3
LnR4dCwgdGhhdA0KPiBpcyBzaW1pbGFyIHRvIHdoYXQgeW91IGRpZCBlYXJsaWVyLg0KPiANCg0K

