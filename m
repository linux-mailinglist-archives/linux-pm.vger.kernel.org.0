Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53FB6114E38
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 10:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfLFJfe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 04:35:34 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:5461 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726070AbfLFJfe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2019 04:35:34 -0500
X-UUID: 2dfcf66ed612406c98283f1ad3fb97d1-20191206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=vR5+TmnGL8k18O3RfwhBu/Xl8JNbLQTJoi3SA28TkwA=;
        b=FEJKPtO6DGFE/HBnaQa1tq7mNOXQMTKic6YvCv9ETOPxmUS4driR3Uwkhc3saEfbP6jV+LUGqLK98mmgBsfHG8G5J/qQ+AnGR5EX05ECxxOk1xoLnFLLj4RbxynbYAr7y3GPA7JKhp/LMS1ZWZ+/A7o4jTD3G16AHGDC4ZXspBM=;
X-UUID: 2dfcf66ed612406c98283f1ad3fb97d1-20191206
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 583983391; Fri, 06 Dec 2019 17:35:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 6 Dec 2019 17:35:27 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 6 Dec 2019 17:34:50 +0800
Message-ID: <1575624927.1631.7.camel@mtksdccf07>
Subject: Re: [PATCH v2 7/8] thermal: mediatek: add another get_temp ops for
 thermal sensors
From:   Michael Kao <michael.kao@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-pm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 6 Dec 2019 17:35:27 +0800
In-Reply-To: <CAJMQK-ivho3T1hnD9axV2EMKT3Srs_5zAXLqwts8nojY15fBGg@mail.gmail.com>
References: <1557494826-6044-1-git-send-email-michael.kao@mediatek.com>
         <1557494826-6044-8-git-send-email-michael.kao@mediatek.com>
         <CAJMQK-ivho3T1hnD9axV2EMKT3Srs_5zAXLqwts8nojY15fBGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B074D70E04D46F7F6E1F3B63CE826B399628CA35CC3E3E458B7FA485D552647E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDE5LTExLTIxIGF0IDE1OjAwICswODAwLCBIc2luLVlpIFdhbmcgd3JvdGU6DQo+
IE9uIEZyaSwgTWF5IDEwLCAyMDE5IGF0IDk6MjcgUE0gbWljaGFlbC5rYW8gPG1pY2hhZWwua2Fv
QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+IA0KPiA+IC0gICAgICAgdHpkZXYgPSBkZXZtX3RoZXJt
YWxfem9uZV9vZl9zZW5zb3JfcmVnaXN0ZXIoJnBkZXYtPmRldiwgMCwgbXQsDQo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmbXRrX3RoZXJt
YWxfb3BzKTsNCj4gPiAtICAgICAgIGlmIChJU19FUlIodHpkZXYpKSB7DQo+ID4gLSAgICAgICAg
ICAgICAgIHJldCA9IFBUUl9FUlIodHpkZXYpOw0KPiA+IC0gICAgICAgICAgICAgICBnb3RvIGVy
cl9kaXNhYmxlX2Nsa19wZXJpX3RoZXJtOw0KPiA+ICsgICAgICAgZm9yIChpID0gMDsgaSA8IG10
LT5jb25mLT5udW1fc2Vuc29ycyArIDE7IGkrKykgew0KPiA+ICsgICAgICAgICAgICAgICB0eiA9
IGttYWxsb2Moc2l6ZW9mKCp0eiksIEdGUF9LRVJORUwpOw0KPiA+ICsgICAgICAgICAgICAgICBp
ZiAoIXR6KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+
ICsNCj4gPiArICAgICAgICAgICAgICAgdHotPm10ID0gbXQ7DQo+ID4gKyAgICAgICAgICAgICAg
IHR6LT5pZCA9IGk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICB0emRldiA9IGRldm1fdGhl
cm1hbF96b25lX29mX3NlbnNvcl9yZWdpc3RlcigmcGRldi0+ZGV2LCBpLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdHosIChpID09IDApID8NCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICZtdGtfdGhlcm1hbF9vcHMgOiAmbXRrX3RoZXJtYWxfc2Vuc29y
X29wcyk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICBpZiAoSVNfRVJSKHR6ZGV2KSkgew0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChJU19FUlIodHpkZXYpICE9IC1FQUNDRVMp
IHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQVFJfRVJSKHR6ZGV2KQ0KPiAN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIodHpkZXYp
Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJfZGlzYWJsZV9j
bGtfcGVyaV90aGVybTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gKyAgICAg
ICAgICAgICAgIH0NCj4gDQo+IFRoaXMgZm9yIGxvb3AgYWRkaW5nIHRoZXJtYWwgem9uZSBzZW5z
b3JzIHdpbGwgbm90IHdvcmsgZm9yIG10ODE3My4gSXQNCj4gYXNzdW1lcyB0aGF0IHRoZXJtYWwt
em9uZXMgaW4gZHRzIGhhdmUgc3Vibm9kZXMgKGVnLiBjcHVfdGhlcm1hbCwNCj4gdHp0cy4uKSBh
bW91bnQgZXF1YWwgdG8gbnVtX3NlbnNvcnMrMS4gT3RoZXJ3aXNlIHR6ZGV2IHdvdWxkIGJlDQo+
IC1FTk9ERVYgYW5kIHRoZXJtYWwgZmFpbGVkIHRvIGJlIHByb2JlZC4NCj4gSW4gbXQ4MTgzIHRo
aXMgaXMgZmluZSwgc2luY2UgZWFjaCB0aGVybWFsIHpvbmUgb25seSBoYXMgb25lIHNlbnNvciwN
Cj4gYnV0IGluIG10ODE3Mywgc29tZSBzZW5zb3IgYXBwZWFycyBpbiBtdWx0aXBsZSB0aGVybWFs
IHpvbmVzLg0KPiANCj4gSW4gb3JkZXIgdG8gbGV0IHRoZSBjaGFuZ2UgYWxzbyB3b3JrcyBmb3Ig
ODE3MywgSSB0aGluayBpZiB0aGUgZXJyb3INCj4gaXMgLUVOT0RFViwgYW5kIHRoZSBpZCBpcyBu
b3QgMCAoMCBpcyBjcHVfdGhlcm1hbCksIHByb21wdCBhIHdhcm5pbmcNCj4gaW5zdGVhZCBvZiBm
YWlsaW5nLiBFZy4NCj4gDQo+ICAgICAgICAgICAgICAgICBpZiAoSVNfRVJSKHR6ZGV2KSkgew0K
PiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoaSA+IDAgJiYgUFRSX0VSUih0emRldikgPT0g
LUVOT0RFVikgew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl93YXJuKCZw
ZGV2LT5kZXYsICJjYW4ndCBmaW5kDQo+IHRoZXJtYWwgc2Vuc29yICVkXG4iLCBpKTsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgfQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoUFRSX0VSUih0emRldikg
IT0gLUVBQ0NFUykgew0KDQpPSywgSSB3aWxsIHVwZGF0ZSB0aGlzIHBhdGNoLg0K

