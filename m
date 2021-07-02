Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C98A3B9DFA
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 11:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhGBJVs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Jul 2021 05:21:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39831 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230112AbhGBJVo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jul 2021 05:21:44 -0400
X-UUID: aefc18c3c8344f5695a816aabdf4c0da-20210702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=IYyNmRrPNeyd0roXCcc3ug77Q20krYCuClxefjY+zjA=;
        b=OBxH2xcXEmkripda1zuduv7SxCUobWyN+AsPyEXi+WIztrYQ/9nHQP2br4XnAn+8YDTob/E2wPxlgUmTOjXrO6KGb7AlHHY84WnUXxBaWLPsNQdiGBgU9FIQ9CNztxkR/KxFLCyJVLDKUGNUWifjtEFb17eIk+c8nzAJCItw09A=;
X-UUID: aefc18c3c8344f5695a816aabdf4c0da-20210702
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 723412632; Fri, 02 Jul 2021 17:19:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 2 Jul 2021 17:19:06 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 2 Jul 2021 17:19:06 +0800
Message-ID: <0911434c39aa76a6312f19baa2a468c65589de3d.camel@mediatek.com>
Subject: Re: [PATCH v19 3/7] soc: mediatek: SVS: introduce MTK SVS engine
From:   Roger Lu <roger.lu@mediatek.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        "Kevin Hilman" <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Nicolas Boichat" <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Fri, 2 Jul 2021 17:19:06 +0800
In-Reply-To: <bf4f26cdca7174ba687e29a581a5276511112fe7.camel@pengutronix.de>
References: <20210702031214.21597-1-roger.lu@mediatek.com>
         <20210702031214.21597-4-roger.lu@mediatek.com>
         <bf4f26cdca7174ba687e29a581a5276511112fe7.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgUGhpbGlwcCwNCg0KVGhhbmtzIGZvciB0aGUgYWR2aWNlLg0KDQpPbiBGcmksIDIwMjEtMDct
MDIgYXQgMTA6MzMgKzAyMDAsIFBoaWxpcHAgWmFiZWwgd3JvdGU6DQo+IEhpIFJvZ2VyLA0KPiAN
Cj4gT24gRnJpLCAyMDIxLTA3LTAyIGF0IDExOjEyICswODAwLCBSb2dlciBMdSB3cm90ZToNCj4g
Wy4uLl0NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXN2cy5jIGIv
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXN2cy5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmMyZmNiYzIwNGIxZA0KPiA+IC0tLSAvZGV2L251bGwN
Cj4gPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc3ZzLmMNCj4gPiBAQCAtMCwwICsx
LDE3MjQgQEANCj4gDQo+IFsuLi5dDQo+ID4gK3N0YXRpYyBpbnQgc3ZzX3N1c3BlbmQoc3RydWN0
IGRldmljZSAqZGV2KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3Qgc3ZzX3BsYXRmb3JtICpzdnNwID0g
ZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gKwlzdHJ1Y3Qgc3ZzX2JhbmsgKnN2c2I7DQo+ID4g
Kwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+ICsJaW50IHJldDsNCj4gPiArCXUzMiBpZHg7DQo+
ID4gKw0KPiA+ICsJZm9yIChpZHggPSAwOyBpZHggPCBzdnNwLT5iYW5rX251bTsgaWR4KyspIHsN
Cj4gPiArCQlzdnNiID0gJnN2c3AtPmJhbmtzW2lkeF07DQo+ID4gKw0KPiA+ICsJCS8qIFdhaXQg
aWYgc3ZzX2lzcigpIGlzIHN0aWxsIGluIHByb2Nlc3MuICovDQo+ID4gKwkJc3Bpbl9sb2NrX2ly
cXNhdmUoJm10a19zdnNfbG9jaywgZmxhZ3MpOw0KPiA+ICsJCXN2c3AtPnBiYW5rID0gc3ZzYjsN
Cj4gPiArCQlzdnNfc3dpdGNoX2Jhbmsoc3ZzcCk7DQo+ID4gKwkJc3ZzX3dyaXRlbChzdnNwLCBT
VlNCX0VOX09GRiwgU1ZTRU4pOw0KPiA+ICsJCXN2c193cml0ZWwoc3ZzcCwgU1ZTQl9JTlRTVFNf
Q0xFQU4sIElOVFNUUyk7DQo+ID4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbXRrX3N2c19s
b2NrLCBmbGFncyk7DQo+ID4gKw0KPiA+ICsJCXN2c2ItPnN1c3BlbmRlZCA9IHRydWU7DQo+ID4g
KwkJaWYgKHN2c2ItPnBoYXNlICE9IFNWU0JfUEhBU0VfSU5JVDAxKSB7DQo+ID4gKwkJCXN2c2It
PnBoYXNlID0gU1ZTQl9QSEFTRV9FUlJPUjsNCj4gPiArCQkJc3ZzX2FkanVzdF9wbV9vcHBfdm9s
dHMoc3ZzYiwgdHJ1ZSk7DQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWlmIChzdnNw
LT5yc3QpIHsNCj4gDQo+IFRoaXMgaXMgbm90IG5lY2Vzc2FyeSwgcmVzZXRfY29udHJvbF9hc3Nl
cnQoKSBjaGVja3MgZm9yIChyc3RjID09IE5VTEwpDQo+IGl0c2VsZi4NCk9rYXkuIFdlJ2xsIHJl
bW92ZSAiaWYgKHN2c3AtPnJzdCkgeyIgaW4gdGhlIG5leHQgcGF0Y2guIFRoYW5rcy4NCg0KPiAN
Cj4gPiArCQlyZXQgPSByZXNldF9jb250cm9sX2Fzc2VydChzdnNwLT5yc3QpOw0KPiA+ICsJCWlm
IChyZXQpIHsNCj4gPiArCQkJZGV2X2VycihzdnNwLT5kZXYsICJjYW5ub3QgYXNzZXJ0IHJlc2V0
ICVkXG4iLCByZXQpOw0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICsJCX0NCj4gPiArCX0NCj4g
PiArDQo+ID4gKwljbGtfZGlzYWJsZV91bnByZXBhcmUoc3ZzcC0+bWFpbl9jbGspOw0KPiA+ICsN
Cj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHN2c19yZXN1
bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3Qgc3ZzX3BsYXRmb3Jt
ICpzdnNwID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gKwlzdHJ1Y3Qgc3ZzX2JhbmsgKnN2
c2I7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsJdTMyIGlkeDsNCj4gPiArDQo+ID4gKwlyZXQgPSBj
bGtfcHJlcGFyZV9lbmFibGUoc3ZzcC0+bWFpbl9jbGspOw0KPiA+ICsJaWYgKHJldCkgew0KPiA+
ICsJCWRldl9lcnIoc3ZzcC0+ZGV2LCAiY2Fubm90IGVuYWJsZSBtYWluX2NsaywgZGlzYWJsZSBz
dnNcbiIpOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKHN2
c3AtPnJzdCkgew0KPiANCj4gU2FtZSBhcyBhYm92ZSwgcmVzZXRfY29udHJvbF9kZWFzc2VydChO
VUxMKSB3aWxsIGp1c3QgcmV0dXJuIDAuDQpPa2F5LiBXZSdsbCByZW1vdmUgImlmIChzdnNwLT5y
c3QpIHsiIGluIHRoZSBuZXh0IHBhdGNoLiBUaGFua3MuDQo+IA0KPiA+ICsJCXJldCA9IHJlc2V0
X2NvbnRyb2xfZGVhc3NlcnQoc3ZzcC0+cnN0KTsNCj4gPiArCQlpZiAocmV0KSB7DQo+ID4gKwkJ
CWRldl9lcnIoc3ZzcC0+ZGV2LCAiY2Fubm90IGRlYXNzZXJ0IHJlc2V0ICVkXG4iLCByZXQpOw0K
PiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPiArDQo+ID4gKwlmb3Ig
KGlkeCA9IDA7IGlkeCA8IHN2c3AtPmJhbmtfbnVtOyBpZHgrKykgew0KPiA+ICsJCXN2c2IgPSAm
c3ZzcC0+YmFua3NbaWR4XTsNCj4gPiArCQlzdnNiLT5zdXNwZW5kZWQgPSBmYWxzZTsNCj4gPiAr
CX0NCj4gPiArDQo+ID4gKwlyZXQgPSBzdnNfaW5pdDAyKHN2c3ApOw0KPiA+ICsJaWYgKHJldCkN
Cj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCXN2c19tb25fbW9kZShzdnNwKTsNCj4g
PiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiANCj4gcmVnYXJkcw0KPiBQaGlsaXBwDQo=

