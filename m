Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B467718F42D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 13:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgCWMPo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 08:15:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:61955 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727303AbgCWMPo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2020 08:15:44 -0400
X-UUID: 9c596e1c356f48b498aefbbde324757d-20200323
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Syxtl64f/oiHmFDozNPlTQ/y9hPgVybUbznOPaoIJLs=;
        b=WVq7BLBFAVRGwysc2XISyaUEeWklgVbg4nAC5J1+72gq0s9hqfPeGmaRE22VMMS1//scEXCwM/w2NiRmYfM1w/gCV5GHYrM61lrM1uMi3Gk54jHUdmXeeOw+ppDb1tFtb4mqWae3A6+n1zBecWPV5UL3zXJfOayjRB7PA1wGfMU=;
X-UUID: 9c596e1c356f48b498aefbbde324757d-20200323
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1151621450; Mon, 23 Mar 2020 20:15:41 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 23 Mar 2020 20:15:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 23 Mar 2020 20:15:38 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <hsinyi@chromium.org>,
        <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <michael.kao@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [v4,4/7] arm64: dts: mt8183: Configure CPU cooling
Date:   Mon, 23 Mar 2020 20:15:34 +0800
Message-ID: <20200323121537.22697-5-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200323121537.22697-1-michael.kao@mediatek.com>
References: <20200323121537.22697-1-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogTWF0dGhpYXMgS2FlaGxja2UgPG1rYUBjaHJvbWl1bS5vcmc+DQoNCkFkZCB0d28gcGFz
c2l2ZSB0cmlwIHBvaW50cyBhdCA2OMKwQyBhbmQgODDCsEMgZm9yIHRoZSBDUFUgdGVtcGVyYXR1
cmUuDQoNClNpZ25lZC1vZmYtYnk6IE1hdHRoaWFzIEthZWhsY2tlIDxta2FAY2hyb21pdW0ub3Jn
Pg0KU2lnbmVkLW9mZi1ieTogTWljaGFlbCBLYW8gPG1pY2hhZWwua2FvQG1lZGlhdGVrLmNvbT4N
Ci0tLQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgfCA1NSArKysr
KysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKQ0K
DQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCmluZGV4IDE4MmZhNjI2
NGUwZC4uNTlhYjI5NTdkODVkIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRp
YXRlay9tdDgxODMuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgx
ODMuZHRzaQ0KQEAgLTY3NSw2ICs2NzUsNjEgQEANCiAJCQkJcG9sbGluZy1kZWxheSA9IDw1MDA+
Ow0KIAkJCQl0aGVybWFsLXNlbnNvcnMgPSA8JnRoZXJtYWwgMD47DQogCQkJCXN1c3RhaW5hYmxl
LXBvd2VyID0gPDUwMDA+Ow0KKw0KKwkJCQl0cmlwcyB7DQorCQkJCQl0aHJlc2hvbGQ6IHRyaXAt
cG9pbnRAMCB7DQorCQkJCQkJdGVtcGVyYXR1cmUgPSA8NjgwMDA+Ow0KKwkJCQkJCWh5c3RlcmVz
aXMgPSA8MjAwMD47DQorCQkJCQkJdHlwZSA9ICJwYXNzaXZlIjsNCisJCQkJCX07DQorDQorCQkJ
CQl0YXJnZXQ6IHRyaXAtcG9pbnRAMSB7DQorCQkJCQkJdGVtcGVyYXR1cmUgPSA8ODAwMDA+Ow0K
KwkJCQkJCWh5c3RlcmVzaXMgPSA8MjAwMD47DQorCQkJCQkJdHlwZSA9ICJwYXNzaXZlIjsNCisJ
CQkJCX07DQorDQorCQkJCQljcHVfY3JpdDogY3B1LWNyaXQgew0KKwkJCQkJCXRlbXBlcmF0dXJl
ID0gPDExNTAwMD47DQorCQkJCQkJaHlzdGVyZXNpcyA9IDwyMDAwPjsNCisJCQkJCQl0eXBlID0g
ImNyaXRpY2FsIjsNCisJCQkJCX07DQorCQkJCX07DQorDQorCQkJCWNvb2xpbmctbWFwcyB7DQor
CQkJCQltYXAwIHsNCisJCQkJCQl0cmlwID0gPCZ0YXJnZXQ+Ow0KKwkJCQkJCWNvb2xpbmctZGV2
aWNlID0gPCZjcHUwDQorCQkJCQkJCVRIRVJNQUxfTk9fTElNSVQNCisJCQkJCQkJVEhFUk1BTF9O
T19MSU1JVD4sDQorCQkJCQkJCQkgPCZjcHUxDQorCQkJCQkJCVRIRVJNQUxfTk9fTElNSVQNCisJ
CQkJCQkJVEhFUk1BTF9OT19MSU1JVD4sDQorCQkJCQkJCQkgPCZjcHUyDQorCQkJCQkJCVRIRVJN
QUxfTk9fTElNSVQNCisJCQkJCQkJVEhFUk1BTF9OT19MSU1JVD4sDQorCQkJCQkJCQkgPCZjcHUz
DQorCQkJCQkJCVRIRVJNQUxfTk9fTElNSVQNCisJCQkJCQkJVEhFUk1BTF9OT19MSU1JVD47DQor
CQkJCQkJY29udHJpYnV0aW9uID0gPDMwNzI+Ow0KKwkJCQkJfTsNCisJCQkJCW1hcDEgew0KKwkJ
CQkJCXRyaXAgPSA8JnRhcmdldD47DQorCQkJCQkJY29vbGluZy1kZXZpY2UgPSA8JmNwdTQNCisJ
CQkJCQkJVEhFUk1BTF9OT19MSU1JVA0KKwkJCQkJCQlUSEVSTUFMX05PX0xJTUlUPiwNCisJCQkJ
CQkJCSA8JmNwdTUNCisJCQkJCQkJVEhFUk1BTF9OT19MSU1JVA0KKwkJCQkJCQlUSEVSTUFMX05P
X0xJTUlUPiwNCisJCQkJCQkJCSA8JmNwdTYNCisJCQkJCQkJVEhFUk1BTF9OT19MSU1JVA0KKwkJ
CQkJCQlUSEVSTUFMX05PX0xJTUlUPiwNCisJCQkJCQkJCSA8JmNwdTcNCisJCQkJCQkJVEhFUk1B
TF9OT19MSU1JVA0KKwkJCQkJCQlUSEVSTUFMX05PX0xJTUlUPjsNCisJCQkJCQljb250cmlidXRp
b24gPSA8MTAyND47DQorCQkJCQl9Ow0KKwkJCQl9Ow0KIAkJCX07DQogDQogCQkJLyogVGhlIHR6
dHMxIH4gdHp0czYgZG9uJ3QgbmVlZCB0byBwb2xsaW5nICovDQotLSANCjIuMTguMA0K

