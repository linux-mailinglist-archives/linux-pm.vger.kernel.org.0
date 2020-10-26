Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B2829882E
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 09:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771497AbgJZITh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 04:19:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47255 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1770925AbgJZITg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 04:19:36 -0400
X-UUID: f5b2368875bc4694b2ab26bf9e84aa32-20201026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ZvY3ebtojCqfX4voGnQGPEtZw2caPlgJvmfJsJzbufw=;
        b=lYmJ7AfIuj+qBf0saoPn8EXVMzy3ocbqyeAafQW1mcrXNb9i5wR61BTRJ4cFJd5rMmjvCAi+FiZ2s9Nj8/LTAq5GckXcMPpcWRiZEawQGLDlr3yyQav7mcJpPH04dXJqoWwB3GF8oo7y5UWhlRUtcb6K1mgrMkp3E2TCYa9v3so=;
X-UUID: f5b2368875bc4694b2ab26bf9e84aa32-20201026
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 648784899; Mon, 26 Oct 2020 16:19:32 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 26 Oct 2020 16:19:14 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Oct 2020 16:19:14 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v8 3/3] dt-bindings: cpufreq: add bindings for MediaTek cpufreq HW
Date:   Mon, 26 Oct 2020 16:19:09 +0800
Message-ID: <1603700349-5922-4-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1603700349-5922-1-git-send-email-hector.yuan@mediatek.com>
References: <1603700349-5922-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F7CCB49E09000072F62F73DDE781F4FACB0C6ADFAD64C3EB4D0B72B91C61209A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogIkhlY3Rvci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KDQpBZGQgZGV2
aWNldHJlZSBiaW5kaW5ncyBmb3IgTWVkaWFUZWsgSFcgZHJpdmVyLg0KDQpTaWduZWQtb2ZmLWJ5
OiBIZWN0b3IuWXVhbiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL2JpbmRp
bmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sICAgICAgfCAgMTEzICsrKysrKysr
KysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDExMyBpbnNlcnRpb25zKCspDQogY3JlYXRl
IG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jcHVmcmVxL2Nw
dWZyZXEtbWVkaWF0ZWstaHcueWFtbA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55
YW1sDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uMzJkMmFkNA0KLS0tIC9k
ZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NwdWZyZXEv
Y3B1ZnJlcS1tZWRpYXRlay1ody55YW1sDQpAQCAtMCwwICsxLDExMyBAQA0KKyMgU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KKyVZQU1MIDEu
Mg0KKy0tLQ0KKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvY3B1ZnJlcS9jcHVm
cmVxLW1lZGlhdGVrLWh3LnlhbWwjDQorJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21l
dGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IE1lZGlhVGVrJ3MgQ1BVRlJFUSBCaW5k
aW5ncw0KKw0KK21haW50YWluZXJzOg0KKyAgLSBIZWN0b3IgWXVhbiA8aGVjdG9yLnl1YW5AbWVk
aWF0ZWsuY29tPg0KKw0KK2Rlc2NyaXB0aW9uOg0KKyAgQ1BVRlJFUSBIVyBpcyBhIGhhcmR3YXJl
IGVuZ2luZSB1c2VkIGJ5IE1lZGlhVGVrDQorICBTb0NzIHRvIG1hbmFnZSBmcmVxdWVuY3kgaW4g
aGFyZHdhcmUuIEl0IGlzIGNhcGFibGUgb2YgY29udHJvbGxpbmcgZnJlcXVlbmN5DQorICBmb3Ig
bXVsdGlwbGUgY2x1c3RlcnMuDQorDQorcHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6DQorICAg
IGNvbnN0OiBtZWRpYXRlayxjcHVmcmVxLWh3DQorDQorICByZWc6DQorICAgIG1pbkl0ZW1zOiAx
DQorICAgIG1heEl0ZW1zOiAyDQorICAgIGRlc2NyaXB0aW9uOiB8DQorICAgICAgQWRkcmVzc2Vz
IGFuZCBzaXplcyBmb3IgdGhlIG1lbW9yeSBvZiB0aGUgSFcgYmFzZXMgaW4gZWFjaCBmcmVxdWVu
Y3kgZG9tYWluLg0KKw0KK3JlcXVpcmVkOg0KKyAgLSBjb21wYXRpYmxlDQorICAtIHJlZw0KKw0K
K2V4YW1wbGVzOg0KKyAgLSB8DQorICAgIGNwdXMgew0KKyAgICAgICAgICAgICNhZGRyZXNzLWNl
bGxzID0gPDE+Ow0KKyAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KKw0KKyAgICAgICAg
ICAgIGNwdTA6IGNwdUAwIHsNCisgICAgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAiY3B1IjsN
CisgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4LWE1NSI7DQorICAgICAg
ICAgICAgICAgIGVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQorICAgICAgICAgICAgICAgIG1lZGlh
dGVrLGZyZXEtZG9tYWluID0gPCZjcHVmcmVxX2h3IDA+Ow0KKyAgICAgICAgICAgICAgICByZWcg
PSA8MHgwMDA+Ow0KKyAgICAgICAgICAgIH07DQorDQorICAgICAgICAgICAgY3B1MTogY3B1QDEw
MCB7DQorICAgICAgICAgICAgICAgIGRldmljZV90eXBlID0gImNwdSI7DQorICAgICAgICAgICAg
ICAgIGNvbXBhdGlibGUgPSAiYXJtLGNvcnRleC1hNTUiOw0KKyAgICAgICAgICAgICAgICBlbmFi
bGUtbWV0aG9kID0gInBzY2kiOw0KKyAgICAgICAgICAgICAgICBtZWRpYXRlayxmcmVxLWRvbWFp
biA9IDwmY3B1ZnJlcV9odyAwPjsNCisgICAgICAgICAgICAgICAgcmVnID0gPDB4MTAwPjsNCisg
ICAgICAgICAgICB9Ow0KKw0KKyAgICAgICAgICAgIGNwdTI6IGNwdUAyMDAgew0KKyAgICAgICAg
ICAgICAgICBkZXZpY2VfdHlwZSA9ICJjcHUiOw0KKyAgICAgICAgICAgICAgICBjb21wYXRpYmxl
ID0gImFybSxjb3J0ZXgtYTU1IjsNCisgICAgICAgICAgICAgICAgZW5hYmxlLW1ldGhvZCA9ICJw
c2NpIjsNCisgICAgICAgICAgICAgICAgbWVkaWF0ZWssZnJlcS1kb21haW4gPSA8JmNwdWZyZXFf
aHcgMD47DQorICAgICAgICAgICAgICAgIHJlZyA9IDwweDIwMD47DQorICAgICAgICAgICAgfTsN
CisNCisgICAgICAgICAgICBjcHUzOiBjcHVAMzAwIHsNCisgICAgICAgICAgICAgICAgZGV2aWNl
X3R5cGUgPSAiY3B1IjsNCisgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4
LWE1NSI7DQorICAgICAgICAgICAgICAgIGVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQorICAgICAg
ICAgICAgICAgIG1lZGlhdGVrLGZyZXEtZG9tYWluID0gPCZjcHVmcmVxX2h3IDA+Ow0KKyAgICAg
ICAgICAgICAgICByZWcgPSA8MHgzMDA+Ow0KKyAgICAgICAgICAgIH07DQorDQorICAgICAgICAg
ICAgY3B1NDogY3B1QDQwMCB7DQorICAgICAgICAgICAgICAgIGRldmljZV90eXBlID0gImNwdSI7
DQorICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLGNvcnRleC1hNTUiOw0KKyAgICAg
ICAgICAgICAgICBlbmFibGUtbWV0aG9kID0gInBzY2kiOw0KKyAgICAgICAgICAgICAgICBtZWRp
YXRlayxmcmVxLWRvbWFpbiA9IDwmY3B1ZnJlcV9odyAxPjsNCisgICAgICAgICAgICAgICAgcmVn
ID0gPDB4NDAwPjsNCisgICAgICAgICAgICB9Ow0KKw0KKyAgICAgICAgICAgIGNwdTU6IGNwdUA1
MDAgew0KKyAgICAgICAgICAgICAgICBkZXZpY2VfdHlwZSA9ICJjcHUiOw0KKyAgICAgICAgICAg
ICAgICBjb21wYXRpYmxlID0gImFybSxjb3J0ZXgtYTU1IjsNCisgICAgICAgICAgICAgICAgZW5h
YmxlLW1ldGhvZCA9ICJwc2NpIjsNCisgICAgICAgICAgICAgICAgbWVkaWF0ZWssZnJlcS1kb21h
aW4gPSA8JmNwdWZyZXFfaHcgMT47DQorICAgICAgICAgICAgICAgIHJlZyA9IDwweDUwMD47DQor
ICAgICAgICAgICAgfTsNCisNCisgICAgICAgICAgICBjcHU2OiBjcHVANjAwIHsNCisgICAgICAg
ICAgICAgICAgZGV2aWNlX3R5cGUgPSAiY3B1IjsNCisgICAgICAgICAgICAgICAgY29tcGF0aWJs
ZSA9ICJhcm0sY29ydGV4LWE3NSI7DQorICAgICAgICAgICAgICAgIGVuYWJsZS1tZXRob2QgPSAi
cHNjaSI7DQorICAgICAgICAgICAgICAgIG1lZGlhdGVrLGZyZXEtZG9tYWluID0gPCZjcHVmcmVx
X2h3IDE+Ow0KKyAgICAgICAgICAgICAgICByZWcgPSA8MHg2MDA+Ow0KKyAgICAgICAgICAgIH07
DQorDQorICAgICAgICAgICAgY3B1NzogY3B1QDcwMCB7DQorICAgICAgICAgICAgICAgIGRldmlj
ZV90eXBlID0gImNwdSI7DQorICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLGNvcnRl
eC1hNzUiOw0KKyAgICAgICAgICAgICAgICBlbmFibGUtbWV0aG9kID0gInBzY2kiOw0KKyAgICAg
ICAgICAgICAgICBtZWRpYXRlayxmcmVxLWRvbWFpbiA9IDwmY3B1ZnJlcV9odyAxPjsNCisgICAg
ICAgICAgICAgICAgcmVnID0gPDB4NzAwPjsNCisgICAgICAgICAgICB9Ow0KKyAgICB9Ow0KKw0K
KyAgICAvKiAuLi4gKi8NCisNCisgICAgc29jIHsNCisgICAgICAgICNhZGRyZXNzLWNlbGxzID0g
PDI+Ow0KKyAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQorDQorICAgICAgICBjcHVmcmVxX2h3
OiBjcHVmcmVxQDExYmMwMCB7DQorICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxj
cHVmcmVxLWh3IjsNCisgICAgICAgICAgICByZWcgPSA8MCAweDExYmMxMCAwIDB4OGM+LA0KKyAg
ICAgICAgICAgICAgIDwwIDB4MTFiY2EwIDAgMHg4Yz47DQorICAgICAgICB9Ow0KKyAgICB9Ow0K
LS0gDQoxLjcuOS41DQo=

