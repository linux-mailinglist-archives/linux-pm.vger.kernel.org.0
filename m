Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8371B1C40
	for <lists+linux-pm@lfdr.de>; Tue, 21 Apr 2020 05:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgDUDA0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 23:00:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:23240 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726644AbgDUDAZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 23:00:25 -0400
X-UUID: e9d530c4e1fc43f08600376a74cb89e9-20200421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5mB7sfvd0i91yBHg/4/utOO4PjHFM3FM1/PPiCYZSqc=;
        b=sb9NPmJR/AokUUMc4ix9IIJqKGtPo8ZjTilQ/+zjcNhm13wN75sKSx5zRHn9Y4uMrwHD8es5cdzdb3KXSYKa5VrKLdWHrgiQbCD5mfoWyIzXy6U/A2m64ggPxepzB5LkuOszzakJRnEmdRAL7eucmmKsuu1oIg96ca0SQY/eXbI=;
X-UUID: e9d530c4e1fc43f08600376a74cb89e9-20200421
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2017802698; Tue, 21 Apr 2020 11:00:15 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 21 Apr 2020 11:00:14 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Apr 2020 11:00:12 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <drinkcat@chromium.org>, Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Frank Wunderlich <frank-w@public-files.de>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ran Bi <ran.bi@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v13 3/6] dt-bindings: mfd: Add compatible for the MediaTek MT6358 PMIC
Date:   Tue, 21 Apr 2020 11:00:09 +0800
Message-ID: <1587438012-24832-4-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1587438012-24832-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1587438012-24832-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6ED35DFF6DA4653F428FB76853F03DBBB915F01E631990D5E4E3462BE51360CD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhpcyBhZGRzIGNvbXBhdGlibGUgZm9yIHRoZSBNZWRpYVRlayBNVDYzNTggUE1JQy4NCg0KU2ln
bmVkLW9mZi1ieTogSHNpbi1Ic2l1bmcgV2FuZyA8aHNpbi1oc2l1bmcud2FuZ0BtZWRpYXRlay5j
b20+DQpBY2tlZC1mb3ItbWZkLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPg0K
UmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQotLS0NCiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL210NjM5Ny50eHQgfCAxNCArKysrKysrKysr
LS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9tdDYz
OTcudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9tdDYzOTcudHh0
DQppbmRleCBhOWIxMDVhLi4wZGY0MzgyIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL21mZC9tdDYzOTcudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWZkL210NjM5Ny50eHQNCkBAIC0xOCwyNCArMTgsMzAgQEAgU2VlIHRo
ZSBmb2xsb3dpbmcgZm9yIHB3YXJwIG5vZGUgZGVmaW5pdGlvbnM6DQogVGhpcyBkb2N1bWVudCBk
ZXNjcmliZXMgdGhlIGJpbmRpbmcgZm9yIE1GRCBkZXZpY2UgYW5kIGl0cyBzdWIgbW9kdWxlLg0K
IA0KIFJlcXVpcmVkIHByb3BlcnRpZXM6DQotY29tcGF0aWJsZTogIm1lZGlhdGVrLG10NjM5NyIg
b3IgIm1lZGlhdGVrLG10NjMyMyINCitjb21wYXRpYmxlOg0KKwkibWVkaWF0ZWssbXQ2MzIzIiBm
b3IgUE1JQyBNVDYzMjMNCisJIm1lZGlhdGVrLG10NjM1OCIgZm9yIFBNSUMgTVQ2MzU4DQorCSJt
ZWRpYXRlayxtdDYzOTciIGZvciBQTUlDIE1UNjM5Nw0KIA0KIE9wdGlvbmFsIHN1Ym5vZGVzOg0K
IA0KIC0gcnRjDQogCVJlcXVpcmVkIHByb3BlcnRpZXM6IFNob3VsZCBiZSBvbmUgb2YgZm9sbG93
cw0KIAkJLSBjb21wYXRpYmxlOiAibWVkaWF0ZWssbXQ2MzIzLXJ0YyINCisJCS0gY29tcGF0aWJs
ZTogIm1lZGlhdGVrLG10NjM1OC1ydGMiDQogCQktIGNvbXBhdGlibGU6ICJtZWRpYXRlayxtdDYz
OTctcnRjIg0KIAlGb3IgZGV0YWlscywgc2VlIC4uL3J0Yy9ydGMtbXQ2Mzk3LnR4dA0KIC0gcmVn
dWxhdG9ycw0KIAlSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KLQkJLSBjb21wYXRpYmxlOiAibWVkaWF0
ZWssbXQ2Mzk3LXJlZ3VsYXRvciINCi0Jc2VlIC4uL3JlZ3VsYXRvci9tdDYzOTctcmVndWxhdG9y
LnR4dA0KIAkJLSBjb21wYXRpYmxlOiAibWVkaWF0ZWssbXQ2MzIzLXJlZ3VsYXRvciINCiAJc2Vl
IC4uL3JlZ3VsYXRvci9tdDYzMjMtcmVndWxhdG9yLnR4dA0KKwkJLSBjb21wYXRpYmxlOiAibWVk
aWF0ZWssbXQ2MzU4LXJlZ3VsYXRvciINCisJc2VlIC4uL3JlZ3VsYXRvci9tdDYzNTgtcmVndWxh
dG9yLnR4dA0KKwkJLSBjb21wYXRpYmxlOiAibWVkaWF0ZWssbXQ2Mzk3LXJlZ3VsYXRvciINCisJ
c2VlIC4uL3JlZ3VsYXRvci9tdDYzOTctcmVndWxhdG9yLnR4dA0KIC0gY29kZWMNCiAJUmVxdWly
ZWQgcHJvcGVydGllczoNCi0JCS0gY29tcGF0aWJsZTogIm1lZGlhdGVrLG10NjM5Ny1jb2RlYyIN
CisJCS0gY29tcGF0aWJsZTogIm1lZGlhdGVrLG10NjM5Ny1jb2RlYyIgb3IgIm1lZGlhdGVrLG10
NjM1OC1zb3VuZCINCiAtIGNsaw0KIAlSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KIAkJLSBjb21wYXRp
YmxlOiAibWVkaWF0ZWssbXQ2Mzk3LWNsayINCi0tIA0KMi42LjQNCg==

