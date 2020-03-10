Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 335AC17F48D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 11:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgCJKKw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 06:10:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33335 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726273AbgCJKKu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 06:10:50 -0400
X-UUID: 2e22c60e38e644dfb4547a0a9fc79688-20200310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sNkHpXF8izKZUF7qsuSvErydtyfam/Pb0hpHXYo69zY=;
        b=L18ESnSe2V9frc//cBdpfJLwMjd95acquRh/8O/Yc6t4TYWFlqg8QJ03SCDs9d+QcDN7tqifMr5gRa5+m17fojyCm524Mhlf/QXuOto2YqRO5/50d0SBebPZRkGgB9fjZlzSIfASsAH5rYACdeMdMZOjX6DjgR4WbkhsKAHYbPA=;
X-UUID: 2e22c60e38e644dfb4547a0a9fc79688-20200310
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1879422500; Tue, 10 Mar 2020 18:10:45 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Mar 2020 18:09:31 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Mar 2020 18:07:58 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Ran Bi <ran.bi@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>
Subject: [PATCH v9 2/5] dt-bindings: mfd: Add compatible for the MediaTek MT6358 PMIC
Date:   Tue, 10 Mar 2020 18:10:37 +0800
Message-ID: <1583835040-19157-3-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1583835040-19157-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1583835040-19157-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhpcyBhZGRzIGNvbXBhdGlibGUgZm9yIHRoZSBNZWRpYVRlayBNVDYzNTggUE1JQy4NCg0KQWNr
ZWQtZm9yLW1mZC1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4NClJldmlld2Vk
LWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KU2lnbmVkLW9mZi1ieTogSHNpbi1I
c2l1bmcgV2FuZyA8aHNpbi1oc2l1bmcud2FuZ0BtZWRpYXRlay5jb20+DQotLS0NCiBEb2N1bWVu
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

