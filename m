Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115C9374ECA
	for <lists+linux-pm@lfdr.de>; Thu,  6 May 2021 07:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhEFFMt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 May 2021 01:12:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33652 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231488AbhEFFMs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 May 2021 01:12:48 -0400
X-UUID: 4cd21c391cb3437aa423f9b883b4b40f-20210506
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=GCNKDKTbKe0DL6QViifjAcHqLVE5WHHmvfm15Wnjq68=;
        b=btlYBP/a1yUxC+VlWy6TA7S1BU1rjc+ip11uRRaw5iwHF03pwf1d90BOs1GgFTH+fxj/K0ieIgklg4sWg5hzIH6nRo/8l+q1v9gZI8AR3tg3WGfavXACY5d4IKSK/XYIa63+7YnEImrvCJOiOdkIBLLFT02cB4hidw5aC72yWcg=;
X-UUID: 4cd21c391cb3437aa423f9b883b4b40f-20210506
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 29911232; Thu, 06 May 2021 13:11:46 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 6 May 2021 13:11:44 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 May 2021 13:11:44 +0800
Message-ID: <7ae074f1f80d6c874e5db12d2650e301d8e4a080.camel@mediatek.com>
Subject: Re: [PATCH 1/1] arm64: dts: mt8183-kukui: Enable thermal Tboard
From:   Michael Kao <michael.kao@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <Ben.Tseng@mediatek.com>
CC:     <fan.chen@mediatek.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 6 May 2021 13:11:44 +0800
In-Reply-To: <CAJMQK-gXfR2Ca-Ay5fwcRgQ4F6h4xXVt1bbAL+3LFwgotwYREA@mail.gmail.com>
References: <20210409071158.2346-1-michael.kao@mediatek.com>
         <CAJMQK-gXfR2Ca-Ay5fwcRgQ4F6h4xXVt1bbAL+3LFwgotwYREA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 364551A4171664A9486A254729F726B04D8DD073D523B4A856147DA05543CF1C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgTWFpbnRhaW5lcnMsDQoNCkdlbnRsZSBwaW4gZm9yIHRoaXMgcGF0Y2guDQoNClRoYW5rcw0K
DQpPbiBGcmksIDIwMjEtMDQtMDkgYXQgMTU6MTYgKzA4MDAsIEhzaW4tWWkgV2FuZyB3cm90ZToN
Cj4gT24gRnJpLCBBcHIgOSwgMjAyMSBhdCAzOjEyIFBNIE1pY2hhZWwgS2FvIDxtaWNoYWVsLmth
b0BtZWRpYXRlay5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IEFkZCBUYm9hcmQgdGhlcm1hbCBz
ZW5zb3Igc2V0dGluZ3MuDQo+ID4gDQo+ID4gcHVsbC11cCB2b2x0YWdlOiAxODAwIG12DQo+ID4g
cHVsbC11cCByZXNpc3RvcjogNzVLDQo+ID4gDQo+ID4gVnNlbnNlID0gcHVsbC11cCB2b2x0YWdl
ICogUm50YyAvICggcHVsbC11cCByZXNpc3RvciArIFJudGMgKQ0KPiA+IEF1eEluID0gVnNlbnNl
ICogNDA5NiAvIDE1MDANCj4gPiANCj4gPiBURVNUPWJvb3Qga3VrdWkNCj4gPiAgICAgIGNoZWNr
IC9zeXMvY2xhc3MvdGhlcm1hbC90aGVybWFsX3pvbmUqL3R5cGUNCj4gPiAgICAgIGNoZWNrIC9z
eXMvY2xhc3MvdGhlcm1hbC90aGVybWFsX3pvbmUqL3RlbXANCj4gDQo+IHRoZSBURVNUIGxpbmVz
IGNhbiBiZSByZW1vdmVkLg0KPiANCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEth
byA8bWljaGFlbC5rYW9AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5pY29sYXMg
Qm9pY2hhdCA8ZHJpbmtjYXRAY2hyb21pdW0ub3JnPg0KPiA+IC0tLQ0KPiANCj4gVGVzdGVkLWJ5
OiBIc2luLVlpIFdhbmcgPGhzaW55aUBjaHJvbWl1bS5vcmc+DQo+IA0KPiBUaGlzIHJlbW92ZXMg
Zm9sbG93aW5nIGVycm9yOg0KPiBbICAgMTAuODgyMzI1XSBnZW5lcmljLWFkYy10aGVybWFsIHRo
ZXJtYWwtc2Vuc29yMTogVGhlcm1hbCB6b25lDQo+IHNlbnNvciByZWdpc3RlciBmYWlsZWQ6IC0x
OQ0KPiBbICAgMTAuOTExOTEyXSBnZW5lcmljLWFkYy10aGVybWFsIHRoZXJtYWwtc2Vuc29yMjog
VGhlcm1hbCB6b25lDQo+IHNlbnNvciByZWdpc3RlciBmYWlsZWQ6IC0xOQ0KPiANCj4gPiAgYXJj
aC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMta3VrdWkuZHRzaSB8IDE0ICsrKysrKysr
KysrKysrDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgICAg
ICAgfCAgMiArLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRp
YXRlay9tdDgxODMta3VrdWkuZHRzaQ0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDgxODMta3VrdWkuZHRzaQ0KPiA+IGluZGV4IGJmMmFkMTI5NGRkMy4uMjAyYWNiNTQyYjEy
IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLWt1
a3VpLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My1r
dWt1aS5kdHNpDQo+ID4gQEAgLTgwMSw2ICs4MDEsMjAgQEANCj4gPiAgICAgICAgIHN0YXR1cyA9
ICJva2F5IjsNCj4gPiAgfTsNCj4gPiANCj4gPiArJnRoZXJtYWxfem9uZXMgew0KPiA+ICsgICAg
ICAgVGJvYXJkMSB7DQo+ID4gKyAgICAgICAgICAgICAgIHBvbGxpbmctZGVsYXkgPSA8MTAwMD47
IC8qIG1pbGxpc2Vjb25kcyAqLw0KPiA+ICsgICAgICAgICAgICAgICBwb2xsaW5nLWRlbGF5LXBh
c3NpdmUgPSA8MD47IC8qIG1pbGxpc2Vjb25kcyAqLw0KPiA+ICsgICAgICAgICAgICAgICB0aGVy
bWFsLXNlbnNvcnMgPSA8JnRib2FyZF90aGVybWlzdG9yMT47DQo+ID4gKyAgICAgICB9Ow0KPiA+
ICsNCj4gPiArICAgICAgIFRib2FyZDIgew0KPiA+ICsgICAgICAgICAgICAgICBwb2xsaW5nLWRl
bGF5ID0gPDEwMDA+OyAvKiBtaWxsaXNlY29uZHMgKi8NCj4gPiArICAgICAgICAgICAgICAgcG9s
bGluZy1kZWxheS1wYXNzaXZlID0gPDA+OyAvKiBtaWxsaXNlY29uZHMgKi8NCj4gPiArICAgICAg
ICAgICAgICAgdGhlcm1hbC1zZW5zb3JzID0gPCZ0Ym9hcmRfdGhlcm1pc3RvcjI+Ow0KPiA+ICsg
ICAgICAgfTsNCj4gPiArfTsNCj4gPiArDQo+ID4gICZ1M3BoeSB7DQo+ID4gICAgICAgICBzdGF0
dXMgPSAib2theSI7DQo+ID4gIH07DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0
ZWsvbXQ4MTgzLmR0c2kNCj4gPiBpbmRleCAxYWQwYTFkNTVkNTMuLmYwNzE5ZGJlZjI0OSAxMDA2
NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpDQo+
ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KPiA+IEBA
IC02NzMsNyArNjczLDcgQEANCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBudm1lbS1jZWxs
LW5hbWVzID0gImNhbGlicmF0aW9uLWRhdGEiOw0KPiA+ICAgICAgICAgICAgICAgICB9Ow0KPiA+
IA0KPiA+IC0gICAgICAgICAgICAgICB0aGVybWFsLXpvbmVzIHsNCj4gPiArICAgICAgICAgICAg
ICAgdGhlcm1hbF96b25lczogdGhlcm1hbC16b25lcyB7DQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgY3B1X3RoZXJtYWw6IGNwdV90aGVybWFsIHsNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHBvbGxpbmctZGVsYXktcGFzc2l2ZSA9IDwxMDA+Ow0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcG9sbGluZy1kZWxheSA9IDw1MDA+Ow0KPiA+IC0tDQo+
ID4gMi4xOC4wDQo+ID4gDQo=

