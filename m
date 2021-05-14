Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1151038024B
	for <lists+linux-pm@lfdr.de>; Fri, 14 May 2021 05:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhENDLa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 23:11:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57267 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229980AbhENDLa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 May 2021 23:11:30 -0400
X-UUID: 204295a1734d4112a3a504ac72d00fe2-20210514
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=TJGSji2ZQJC1gEeWYsGmPT+9twgITBZ7l92YrBaGz8M=;
        b=SoWdPOz3pfiJwRPOvFp279daIN5ITE7Md38PT5PdvvFpwJZ/tKpE+R0dacuO4nkF85HglmlKaavPWtaJN856mPmni/wErlYQNcGQynL6wfpmAcRq5AgQdIkeXA1d/MBDmjG7J1tTMQE1baYOT3mxVWsET4N05vhF+7omMYoF3H8=;
X-UUID: 204295a1734d4112a3a504ac72d00fe2-20210514
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 555409809; Fri, 14 May 2021 11:10:15 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 14 May 2021 11:10:13 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 May 2021 11:10:13 +0800
Message-ID: <7a7a07adedf5d3f430fecf81aed35c6321e5b634.camel@mediatek.com>
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
Date:   Fri, 14 May 2021 11:10:13 +0800
In-Reply-To: <20210506045115.GA767398@roeck-us.net>
References: <20210428065440.3704-1-roger.lu@mediatek.com>
         <20210428065440.3704-4-roger.lu@mediatek.com>
         <20210506045115.GA767398@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgR3VlbnRlciwNCg0KU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5IGFuZCB0aGFua3MgZm9yIHRo
ZSBub3RpY2UuDQoNCk9uIFdlZCwgMjAyMS0wNS0wNSBhdCAyMTo1MSAtMDcwMCwgR3VlbnRlciBS
b2VjayB3cm90ZToNCj4gT24gV2VkLCBBcHIgMjgsIDIwMjEgYXQgMDI6NTQ6MzZQTSArMDgwMCwg
Um9nZXIgTHUgd3JvdGU6DQo+ID4gVGhlIFNtYXJ0IFZvbHRhZ2UgU2NhbGluZyhTVlMpIGVuZ2lu
ZSBpcyBhIHBpZWNlIG9mIGhhcmR3YXJlDQo+ID4gd2hpY2ggY2FsY3VsYXRlcyBzdWl0YWJsZSBT
VlMgYmFuayB2b2x0YWdlcyB0byBPUFAgdm9sdGFnZSB0YWJsZS4NCj4gPiBUaGVuLCBEVkZTIGRy
aXZlciBjb3VsZCBhcHBseSB0aG9zZSBTVlMgYmFuayB2b2x0YWdlcyB0byBQTUlDL0J1Y2sNCj4g
PiB3aGVuIHJlY2VpdmluZyBPUFBfRVZFTlRfQURKVVNUX1ZPTFRBR0UuDQo+ID4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogUm9nZXIgTHUgPHJvZ2VyLmx1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvS2NvbmZpZyAgIHwgICAxMCArDQo+ID4gIGRyaXZlcnMv
c29jL21lZGlhdGVrL01ha2VmaWxlICB8ICAgIDEgKw0KPiA+ICBkcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstc3ZzLmMgfCAxNzIzDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNzM0IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1zdnMuYw0KPiA+IA0KPiANCj4gWyAu
Li4gXQ0KPiANCj4gPiArDQo+ID4gKwlzdnNwX2lycSA9IGlycV9vZl9wYXJzZV9hbmRfbWFwKHN2
c3AtPmRldi0+b2Zfbm9kZSwgMCk7DQo+ID4gKwlyZXQgPSBkZXZtX3JlcXVlc3RfdGhyZWFkZWRf
aXJxKHN2c3AtPmRldiwgc3ZzcF9pcnEsIE5VTEwsDQo+ID4gc3ZzX2lzciwNCj4gPiArCQkJCQlz
dnNwLT5pcnFmbGFncywgc3ZzcC0+bmFtZSwNCj4gPiBzdnNwKTsNCj4gDQo+IDAtZGF5IHJlcG9y
dHM6DQo+IA0KPiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc3ZzLmM6MTY2Mzo3LTMyOiBFUlJP
UjoNCj4gCVRocmVhZGVkIElSUSB3aXRoIG5vIHByaW1hcnkgaGFuZGxlciByZXF1ZXN0ZWQgd2l0
aG91dA0KPiBJUlFGX09ORVNIT1QNCj4gDQo+IEkgd291bGQgYmUgYSBiaXQgY29uY2VybmVkIGFi
b3V0IHRoaXMuIFRoZXJlIGlzIG5vIHByaW1hcnkgKGhhcmQpDQo+IGludGVycnVwdCBoYW5kbGVy
LCBtZWFuaW5nIHRoZSBoYXJkIGludGVycnVwdCBtYXkgYmUgcmUtZW5hYmxlZCBhZnRlcg0KPiB0
aGUgZGVmYXVsdCBoYXJkIGludGVycnVwdCBoYW5kbGVyIHJ1bnMuIFRoaXMgbWlnaHQgcmVzdWx0
IGluIGVuZGxlc3MNCj4gaW50ZXJydXB0cy4NCg0KT2gsIHdlIGFkZCBJUlFGX09ORVNIT1QgaW4g
InN2c19nZXRfc3ZzX210ODE4M19wbGF0Zm9ybV9kYXRhKCkiIGZvcg0KdGhyZWFkZWQgaXJxLiBT
bywgcGxlYXNlIGtpbmRseSBsZXQgdXMga25vdyBpZiB3ZSBuZWVkIHRvIHNldCBtb3JlDQpmbGFn
cyBvciBhbnkgb3RoZXIgcG90ZW50aWFsIHJpc2tzIHdlIHNob3VsZCBiZSBhd2FyZS4gVGhhbmtz
IGluDQphZHZhbmNlLg0KDQo+IA0KPiBHdWVudGVyDQo=

