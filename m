Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6821C180E72
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 04:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgCKDY7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 23:24:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47152 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727648AbgCKDY7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 23:24:59 -0400
X-UUID: 1e0ac38db6e4476eaea91aa593267a54-20200311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Hs7qXhY4scbN9V12HC8l5mpj1ZLtWI/x/58EtakrmHg=;
        b=h5J3He0IDt7KmfFWkOHEjGDcyD/zqs9HUtmqCQUV55d28qxfIB+LNNenXupAOOAfbiHXyFHEw2VZHtP2eoGPb12SJzhjOmAsCgaFD6JH+xnxCPJkyOWkDPkLGukj/KZD8Gvj9PX3n9E3SW4ENArCgkD1LElcDfHe/iIJM1STNxU=;
X-UUID: 1e0ac38db6e4476eaea91aa593267a54-20200311
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2050323538; Wed, 11 Mar 2020 11:24:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Mar 2020 11:23:38 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Mar 2020 11:24:38 +0800
Message-ID: <1583897091.14612.1.camel@mtksdaap41>
Subject: Re: [PATCH v9 4/5] rtc: mt6397: Add support for the MediaTek MT6358
 RTC
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        Josef Friedl <josef.friedl@speed.at>,
        "Nicolas Boichat" <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>,
        "Frank Wunderlich" <frank-w@public-files.de>,
        Ran Bi <ran.bi@mediatek.com>,
        "Sean Wang" <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Fontana <rfontana@redhat.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Eddie Huang <eddie.huang@mediatek.com>,
        <linux-rtc@vger.kernel.org>
Date:   Wed, 11 Mar 2020 11:24:51 +0800
In-Reply-To: <1583835040-19157-5-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1583835040-19157-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1583835040-19157-5-git-send-email-hsin-hsiung.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTEwIGF0IDE4OjEwICswODAwLCBIc2luLUhzaXVuZyBXYW5nIHdyb3Rl
Og0KPiBGcm9tOiBSYW4gQmkgPHJhbi5iaUBtZWRpYXRlay5jb20+DQo+IA0KPiBUaGlzIGFkZCBz
dXBwb3J0IGZvciB0aGUgTWVkaWFUZWsgTVQ2MzU4IFJUQy4gRHJpdmVyIHVzaW5nDQo+IGNvbXBh
dGlibGUgZGF0YSB0byBzdG9yZSBkaWZmZXJlbnQgUlRDX1dSVEdSIGFkZHJlc3Mgb2Zmc2V0Lg0K
PiBUaGlzIHJlcGxhY2UgUlRDX1dSVEdSIHRvIFJUQ19XUlRHUl9NVDYzMjMgaW4gbXQ2MzIzLXBv
d2Vyb2ZmDQo+IGRyaXZlciB3aGljaCBvbmx5IG5lZWRlZCBieSBhcm12NyBDUFUgd2l0aG91dCBB
VEYuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYW4gQmkgPHJhbi5iaUBtZWRpYXRlay5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IEhzaW4tSHNpdW5nIFdhbmcgPGhzaW4taHNpdW5nLndhbmdAbWVkaWF0
ZWsuY29tPg0KPiAtLS0NCg0KPC4uLj4NCg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9t
ZmQvbXQ2Mzk3L3J0Yy5oIGIvaW5jbHVkZS9saW51eC9tZmQvbXQ2Mzk3L3J0Yy5oDQo+IGluZGV4
IDdkZmI2M2IuLjNkYzQ4ZTggMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvbWZkL210NjM5
Ny9ydGMuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L21mZC9tdDYzOTcvcnRjLmgNCg0KPC4uLj4N
Cg0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a19ydGNfZGF0YSBtdDYzNThfcnRjX2Rh
dGEgPSB7DQo+ICsJLndydGdyID0gUlRDX1dSVEdSX01UNjM1OCwNCj4gK307DQo+ICsNCj4gK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3J0Y19kYXRhIG10NjM5N19ydGNfZGF0YSA9IHsNCj4gKwku
d3J0Z3IgPSBSVENfV1JUR1JfTVQ2Mzk3LA0KPiAgfTsNCg0KSGksDQoNCm10NjMyMy1wb3dlcm9m
Zi5jIGRvZXNuJ3QgbmVlZCB0aGVzZSBfcnRjX2RhdGEuIFBsZWFzZSBwdXQgdGhlbSBpbg0KcnRj
LW10NjM5Ny5jDQoNCkpvZS5DDQoNCg==

