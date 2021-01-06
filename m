Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF7B2EBB34
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jan 2021 09:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbhAFImn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jan 2021 03:42:43 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:45377 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725836AbhAFImm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jan 2021 03:42:42 -0500
X-UUID: 344a96c5f6c448c197ebc83a23976be8-20210106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=HjDudKT6CirLj9XUT1/FsMduOj9/1XKYdNqPso3wAXI=;
        b=ZUvHxZ9U/OW4QIu8hz2QCXzAwn1b7a4Ftz3MbmO+w5wLR4nFCGB0431y8ldOlmmF3xuEVcL53zrVf93Li2A0Nna2jNgHl5uZwlpCciXlx8O0iAlrDdqPN6TgsOYUT/cH6z3iNGhTIT8ypEM2sQkcy+sEeYRYOos7kxAoEhfDUMI=;
X-UUID: 344a96c5f6c448c197ebc83a23976be8-20210106
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 189377158; Wed, 06 Jan 2021 16:41:56 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 Jan 2021 16:41:54 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 Jan 2021 16:41:55 +0800
Message-ID: <1609922515.18506.17.camel@mtksdaap41>
Subject: Re: [PATCH v10 3/7] [v10, 3/7]: soc: mediatek: SVS: introduce MTK
 SVS engine
From:   Roger Lu <roger.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Devicetree List" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Charles Yang" <Charles.Yang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        YT Lee <yt.lee@mediatek.com>, Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 6 Jan 2021 16:41:55 +0800
In-Reply-To: <1609750266.20758.40.camel@mtksdaap41>
References: <20201227105449.11452-1-roger.lu@mediatek.com>
         <20201227105449.11452-4-roger.lu@mediatek.com>
         <CANMq1KBNKy708Vz67WOc+n7V7ne4L1EZVkUVGj6abd5voxKjxA@mail.gmail.com>
         <1609750266.20758.40.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgTmljb2xhcywNCg0KW3NuaXBdDQo+ID4gDQo+ID4gPiArDQo+ID4gPiArICAgICAgIC8qIFN2
cyBlZnVzZSBwYXJzaW5nICovDQo+ID4gPiArICAgICAgIGZ0X3BnbSA9IChzdnNwLT5lZnVzZVsw
XSA+PiA0KSAmIEdFTk1BU0soMywgMCk7DQo+ID4gPiArDQo+ID4gPiArICAgICAgIGZvciAoaWR4
ID0gMDsgaWR4IDwgc3ZzcC0+YmFua19udW07IGlkeCsrKSB7DQo+ID4gPiArICAgICAgICAgICAg
ICAgc3ZzYiA9ICZzdnNwLT5iYW5rc1tpZHhdOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAgICAg
ICAgIGlmIChmdF9wZ20gPD0gMSkNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHN2c2It
PmluaXQwMV92b2x0X2ZsYWcgPSBTVlNCX0lOSVQwMV9WT0xUX0lHTk9SRTsNCj4gPiA+ICsNCj4g
PiA+ICsgICAgICAgICAgICAgICBzd2l0Y2ggKHN2c2ItPnN3X2lkKSB7DQo+ID4gPiArICAgICAg
ICAgICAgICAgY2FzZSBTVlNCX0NQVV9MSVRUTEU6DQo+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBzdnNiLT5iZGVzID0gc3ZzcC0+ZWZ1c2VbMTZdICYgR0VOTUFTSyg3LCAwKTsNCj4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHN2c2ItPm1kZXMgPSAoc3ZzcC0+ZWZ1c2VbMTZdID4+
IDgpICYgR0VOTUFTSyg3LCAwKTsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHN2c2It
PmRjYmRldCA9IChzdnNwLT5lZnVzZVsxNl0gPj4gMTYpICYgR0VOTUFTSyg3LCAwKTsNCj4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHN2c2ItPmRjbWRldCA9IChzdnNwLT5lZnVzZVsxNl0g
Pj4gMjQpICYgR0VOTUFTSyg3LCAwKTsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHN2
c2ItPm10ZGVzICA9IChzdnNwLT5lZnVzZVsxN10gPj4gMTYpICYgR0VOTUFTSyg3LCAwKTsNCj4g
PiANCj4gPiBBZ2FpbiwgaWYgYWxsIG9mIHRob3NlIHZhbHVlcyB3ZXJlIHU4LCB0aGVyZSdkIGJl
IG5vIG5lZWQgZm9yIHRoZXNlIEdFTk1BU0sNCj4gDQo+IE9rLCBJJ2xsIHVzZSB1OCBpbnN0ZWFk
IG9mIEdFTk1BU0suIFRoYW5rcy4NCg0KQWZ0ZXIgcmVmaW5pbmcgdGhlIGNvZGVzLCBJIHRoaW5r
IGl0J3MgbXVjaCBleHBsaWNpdCB0byBhc3NpZ24gdGhlIGJpdHMNCkkgd2FudCBieSBHRU5NQVNL
KCkgYW5kIHdpbGwgcmVtb3ZlIG90aGVyIEdFTk1BU0soKSB0aGF0IGFyZSByZXBldGl0aXZlDQps
aWtlIGluIHN2c19zZXRfYmFua19waGFzZSgpIG9yIHN2c19zZXRfZnJlcXNfcGN0X3YyKCkuDQoN
CltzbmlwXQ0KDQo=

