Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A532028CB86
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 12:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbgJMKYF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 06:24:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50282 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729123AbgJMKYE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 06:24:04 -0400
X-UUID: d848fabbf87a4677b5bbd929647894c6-20201013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qiedL0JxT+BhogXj0HkQMKXH7NoJA144Q5PDLAu55v0=;
        b=V5HvdVYDIVnMjV1ReyIE25A/9J9z/mxi+7NkB1OuCxOlYph/vMTd8BA2APOe5kX0Ih0y8gWT+YmZQ+1d3evIhFSokidgtfHC5dyaileTKtng/JNX3DUZUcWDjZ0tVNsDhFnuoxrEudYfx9CmJA8i2K2PKavoGNb5uOg1XQJBIcE=;
X-UUID: d848fabbf87a4677b5bbd929647894c6-20201013
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1401521386; Tue, 13 Oct 2020 18:24:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 13 Oct 2020 18:24:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Oct 2020 18:24:00 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>
CC:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Kao <michael.kao@mediatek.com>
Subject: [v5 2/3] arm64: dts: mt8183: Configure CPU cooling
Date:   Tue, 13 Oct 2020 18:23:57 +0800
Message-ID: <20201013102358.22588-3-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201013102358.22588-1-michael.kao@mediatek.com>
References: <20201013102358.22588-1-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogTWF0dGhpYXMgS2FlaGxja2UgPG1rYUBjaHJvbWl1bS5vcmc+DQoNCkFkZCB0d28gcGFz
c2l2ZSB0cmlwIHBvaW50cyBhdCA2OMKwQyBhbmQgODDCsEMgZm9yIHRoZSBDUFUgdGVtcGVyYXR1
cmUuDQoNClNpZ25lZC1vZmYtYnk6IE1hdHRoaWFzIEthZWhsY2tlIDxta2FAY2hyb21pdW0ub3Jn
Pg0KU2lnbmVkLW9mZi1ieTogTWljaGFlbCBLYW8gPG1pY2hhZWwua2FvQG1lZGlhdGVrLmNvbT4N
Ci0tLQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgfCA1NiArKysr
KysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKQ0K
DQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCmluZGV4IDFjZDA5M2Nm
MzNmMy4uMDYxNGYxOGExZWEyIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRp
YXRlay9tdDgxODMuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgx
ODMuZHRzaQ0KQEAgLTEwLDYgKzEwLDcgQEANCiAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJy
dXB0LWNvbnRyb2xsZXIvaXJxLmg+DQogI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3Jlc2V0LWNvbnRy
b2xsZXIvbXQ4MTgzLXJlc2V0cy5oPg0KICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9waHkvcGh5Lmg+
DQorI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3RoZXJtYWwvdGhlcm1hbC5oPg0KICNpbmNsdWRlICJt
dDgxODMtcGluZnVuYy5oIg0KIA0KIC8gew0KQEAgLTQ1MCw2ICs0NTEsNjEgQEANCiAJCQkJcG9s
bGluZy1kZWxheSA9IDw1MDA+Ow0KIAkJCQl0aGVybWFsLXNlbnNvcnMgPSA8JnRoZXJtYWwgMD47
DQogCQkJCXN1c3RhaW5hYmxlLXBvd2VyID0gPDUwMDA+Ow0KKw0KKwkJCQl0cmlwcyB7DQorCQkJ
CQl0aHJlc2hvbGQ6IHRyaXAtcG9pbnRAMCB7DQorCQkJCQkJdGVtcGVyYXR1cmUgPSA8NjgwMDA+
Ow0KKwkJCQkJCWh5c3RlcmVzaXMgPSA8MjAwMD47DQorCQkJCQkJdHlwZSA9ICJwYXNzaXZlIjsN
CisJCQkJCX07DQorDQorCQkJCQl0YXJnZXQ6IHRyaXAtcG9pbnRAMSB7DQorCQkJCQkJdGVtcGVy
YXR1cmUgPSA8ODAwMDA+Ow0KKwkJCQkJCWh5c3RlcmVzaXMgPSA8MjAwMD47DQorCQkJCQkJdHlw
ZSA9ICJwYXNzaXZlIjsNCisJCQkJCX07DQorDQorCQkJCQljcHVfY3JpdDogY3B1LWNyaXQgew0K
KwkJCQkJCXRlbXBlcmF0dXJlID0gPDExNTAwMD47DQorCQkJCQkJaHlzdGVyZXNpcyA9IDwyMDAw
PjsNCisJCQkJCQl0eXBlID0gImNyaXRpY2FsIjsNCisJCQkJCX07DQorCQkJCX07DQorDQorCQkJ
CWNvb2xpbmctbWFwcyB7DQorCQkJCQltYXAwIHsNCisJCQkJCQl0cmlwID0gPCZ0YXJnZXQ+Ow0K
KwkJCQkJCWNvb2xpbmctZGV2aWNlID0gPCZjcHUwDQorCQkJCQkJCVRIRVJNQUxfTk9fTElNSVQN
CisJCQkJCQkJVEhFUk1BTF9OT19MSU1JVD4sDQorCQkJCQkJCQkgPCZjcHUxDQorCQkJCQkJCVRI
RVJNQUxfTk9fTElNSVQNCisJCQkJCQkJVEhFUk1BTF9OT19MSU1JVD4sDQorCQkJCQkJCQkgPCZj
cHUyDQorCQkJCQkJCVRIRVJNQUxfTk9fTElNSVQNCisJCQkJCQkJVEhFUk1BTF9OT19MSU1JVD4s
DQorCQkJCQkJCQkgPCZjcHUzDQorCQkJCQkJCVRIRVJNQUxfTk9fTElNSVQNCisJCQkJCQkJVEhF
Uk1BTF9OT19MSU1JVD47DQorCQkJCQkJY29udHJpYnV0aW9uID0gPDMwNzI+Ow0KKwkJCQkJfTsN
CisJCQkJCW1hcDEgew0KKwkJCQkJCXRyaXAgPSA8JnRhcmdldD47DQorCQkJCQkJY29vbGluZy1k
ZXZpY2UgPSA8JmNwdTQNCisJCQkJCQkJVEhFUk1BTF9OT19MSU1JVA0KKwkJCQkJCQlUSEVSTUFM
X05PX0xJTUlUPiwNCisJCQkJCQkJCSA8JmNwdTUNCisJCQkJCQkJVEhFUk1BTF9OT19MSU1JVA0K
KwkJCQkJCQlUSEVSTUFMX05PX0xJTUlUPiwNCisJCQkJCQkJCSA8JmNwdTYNCisJCQkJCQkJVEhF
Uk1BTF9OT19MSU1JVA0KKwkJCQkJCQlUSEVSTUFMX05PX0xJTUlUPiwNCisJCQkJCQkJCSA8JmNw
dTcNCisJCQkJCQkJVEhFUk1BTF9OT19MSU1JVA0KKwkJCQkJCQlUSEVSTUFMX05PX0xJTUlUPjsN
CisJCQkJCQljb250cmlidXRpb24gPSA8MTAyND47DQorCQkJCQl9Ow0KKwkJCQl9Ow0KIAkJCX07
DQogDQogCQkJLyogVGhlIHR6dHMxIH4gdHp0czYgZG9uJ3QgbmVlZCB0byBwb2xsaW5nICovDQot
LSANCjIuMTguMA0K

