Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10C6263C0B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 06:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgIJEb0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 00:31:26 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:12502 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725873AbgIJEbO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 00:31:14 -0400
X-UUID: 21f57d6eceda4df68242c057ff86e267-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gd8IHDDlRyngneuXbVMKDrh2dBx36h1OwZpzKd/37SU=;
        b=dJaIPuZaRpEKr/aqHAm29E7DNrG0TOUEcuijASavQ6ZTm9PoMb/ce4SG93mFGFBYVtokeS1rvyqPueSHkYSQP/RxWNZJAkzBoWwaprYZL2Nu3gOZE7qg4GmdkXFoFg3RKRvtQ+29y/wnYMLAuN71IlEE65/EcdXEbixHCBWppcw=;
X-UUID: 21f57d6eceda4df68242c057ff86e267-20200910
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1657231136; Thu, 10 Sep 2020 12:31:09 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 12:31:06 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 12:31:06 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v7 2/2] dt-bindings: cpufreq: add bindings for MediaTek cpufreq HW
Date:   Thu, 10 Sep 2020 12:31:02 +0800
Message-ID: <1599712262-8819-3-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1599712262-8819-1-git-send-email-hector.yuan@mediatek.com>
References: <1599712262-8819-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogIkhlY3Rvci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KDQpBZGQgZGV2
aWNldHJlZSBiaW5kaW5ncyBmb3IgTWVkaWFUZWsgSFcgZHJpdmVyLg0KDQpTaWduZWQtb2ZmLWJ5
OiBIZWN0b3IuWXVhbiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL2JpbmRp
bmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sICAgICAgfCAgMTQxICsrKysrKysr
KysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDE0MSBpbnNlcnRpb25zKCspDQogY3JlYXRl
IG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jcHVmcmVxL2Nw
dWZyZXEtbWVkaWF0ZWstaHcueWFtbA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55
YW1sDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uMTE4YTE2Mw0KLS0tIC9k
ZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NwdWZyZXEv
Y3B1ZnJlcS1tZWRpYXRlay1ody55YW1sDQpAQCAtMCwwICsxLDE0MSBAQA0KKyMgU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KKyVZQU1MIDEu
Mg0KKy0tLQ0KKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvY3B1ZnJlcS9jcHVm
cmVxLW1lZGlhdGVrLWh3LnlhbWwjDQorJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21l
dGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IE1lZGlhVGVrJ3MgQ1BVRlJFUSBCaW5k
aW5ncw0KKw0KK21haW50YWluZXJzOg0KKyAgLSBIZWN0b3IgWXVhbiA8aGVjdG9yLnl1YW5AbWVk
aWF0ZWsuY29tPg0KKw0KK2Rlc2NyaXB0aW9uOg0KKyAgQ1BVRlJFUSBIVyBpcyBhIGhhcmR3YXJl
IGVuZ2luZSB1c2VkIGJ5IE1lZGlhVGVrDQorICBTb0NzIHRvIG1hbmFnZSBmcmVxdWVuY3kgaW4g
aGFyZHdhcmUuIEl0IGlzIGNhcGFibGUgb2YgY29udHJvbGxpbmcgZnJlcXVlbmN5DQorICBmb3Ig
bXVsdGlwbGUgY2x1c3RlcnMuDQorDQorcHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6DQorICAg
IGNvbnN0OiAibWVkaWF0ZWssY3B1ZnJlcS1odyINCisNCisgIHJlZzoNCisgICAgbWluSXRlbXM6
IDENCisgICAgbWF4SXRlbXM6IDINCisgICAgZGVzY3JpcHRpb246IHwNCisgICAgICBBZGRyZXNz
ZXMgYW5kIHNpemVzIGZvciB0aGUgbWVtb3J5IG9mIHRoZSBIVyBiYXNlcyBpbiBlYWNoIGZyZXF1
ZW5jeSBkb21haW4uDQorDQorICByZWctbmFtZXM6DQorICAgIGl0ZW1zOg0KKyAgICAgIC0gY29u
c3Q6ICJmcmVxLWRvbWFpbjAiDQorICAgICAgLSBjb25zdDogImZyZXEtZG9tYWluMSINCisgICAg
ZGVzY3JpcHRpb246IHwNCisgICAgICBGcmVxdWVuY3kgZG9tYWluIG5hbWUuIGkuZS4NCisgICAg
ICAiZnJlcS1kb21haW4wIiwgImZyZXEtZG9tYWluMSIuDQorDQorICAiI2ZyZXEtZG9tYWluLWNl
bGxzIjoNCisgICAgY29uc3Q6IDENCisgICAgZGVzY3JpcHRpb246IHwNCisgICAgICBOdW1iZXIg
b2YgY2VsbHMgaW4gYSBmcmVxZW5jeSBkb21haW4gc3BlY2lmaWVyLg0KKw0KKyAgbXRrLWZyZXEt
ZG9tYWluOg0KKyAgICBtYXhJdGVtczogMQ0KKyAgICBkZXNjcmlwdGlvbjogfA0KKyAgICAgIERl
ZmluZSB0aGlzIGNwdSBiZWxvbmdzIHRvIHdoaWNoIGZyZXF1ZW5jeSBkb21haW4uIGkuZS4NCisg
ICAgICBjcHUwLTMgYmVsb25nIHRvIGZyZXF1ZW5jeSBkb21haW4wLA0KKyAgICAgIGNwdTQtNiBi
ZWxvbmcgdG8gZnJlcXVlbmN5IGRvbWFpbjEuDQorDQorcmVxdWlyZWQ6DQorICAtIGNvbXBhdGli
bGUNCisgIC0gcmVnDQorICAtIHJlZy1uYW1lcw0KKyAgLSAiI2ZyZXEtZG9tYWluLWNlbGxzIg0K
Kw0KK2V4YW1wbGVzOg0KKyAgLSB8DQorICAgIGNwdXMgew0KKyAgICAgICAgICAgICNhZGRyZXNz
LWNlbGxzID0gPDE+Ow0KKyAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KKw0KKyAgICAg
ICAgICAgIGNwdTA6IGNwdUAwIHsNCisgICAgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAiY3B1
IjsNCisgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4LWE1NSI7DQorICAg
ICAgICAgICAgICAgIGVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQorICAgICAgICAgICAgICAgIG10
ay1mcmVxLWRvbWFpbiA9IDwmY3B1ZnJlcV9odyAwPjsNCisgICAgICAgICAgICAgICAgcmVnID0g
PDB4MDAwPjsNCisgICAgICAgICAgICB9Ow0KKw0KKyAgICAgICAgICAgIGNwdTE6IGNwdUAxIHsN
CisgICAgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAiY3B1IjsNCisgICAgICAgICAgICAgICAg
Y29tcGF0aWJsZSA9ICJhcm0sY29ydGV4LWE1NSI7DQorICAgICAgICAgICAgICAgIGVuYWJsZS1t
ZXRob2QgPSAicHNjaSI7DQorICAgICAgICAgICAgICAgIG10ay1mcmVxLWRvbWFpbiA9IDwmY3B1
ZnJlcV9odyAwPjsNCisgICAgICAgICAgICAgICAgcmVnID0gPDB4MTAwPjsNCisgICAgICAgICAg
ICB9Ow0KKw0KKyAgICAgICAgICAgIGNwdTI6IGNwdUAyIHsNCisgICAgICAgICAgICAgICAgZGV2
aWNlX3R5cGUgPSAiY3B1IjsNCisgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhcm0sY29y
dGV4LWE1NSI7DQorICAgICAgICAgICAgICAgIGVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQorICAg
ICAgICAgICAgICAgIG10ay1mcmVxLWRvbWFpbiA9IDwmY3B1ZnJlcV9odyAwPjsNCisgICAgICAg
ICAgICAgICAgcmVnID0gPDB4MjAwPjsNCisgICAgICAgICAgICB9Ow0KKw0KKyAgICAgICAgICAg
IGNwdTM6IGNwdUAzIHsNCisgICAgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAiY3B1IjsNCisg
ICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4LWE1NSI7DQorICAgICAgICAg
ICAgICAgIGVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQorICAgICAgICAgICAgICAgIG10ay1mcmVx
LWRvbWFpbiA9IDwmY3B1ZnJlcV9odyAwPjsNCisgICAgICAgICAgICAgICAgcmVnID0gPDB4MzAw
PjsNCisgICAgICAgICAgICB9Ow0KKw0KKyAgICAgICAgICAgIGNwdTQ6IGNwdUA0IHsNCisgICAg
ICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAiY3B1IjsNCisgICAgICAgICAgICAgICAgY29tcGF0
aWJsZSA9ICJhcm0sY29ydGV4LWE1NSI7DQorICAgICAgICAgICAgICAgIGVuYWJsZS1tZXRob2Qg
PSAicHNjaSI7DQorICAgICAgICAgICAgICAgIG10ay1mcmVxLWRvbWFpbiA9IDwmY3B1ZnJlcV9o
dyAxPjsNCisgICAgICAgICAgICAgICAgcmVnID0gPDB4NDAwPjsNCisgICAgICAgICAgICB9Ow0K
Kw0KKyAgICAgICAgICAgIGNwdTU6IGNwdUA1IHsNCisgICAgICAgICAgICAgICAgZGV2aWNlX3R5
cGUgPSAiY3B1IjsNCisgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4LWE1
NSI7DQorICAgICAgICAgICAgICAgIGVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQorICAgICAgICAg
ICAgICAgIG10ay1mcmVxLWRvbWFpbiA9IDwmY3B1ZnJlcV9odyAxPjsNCisgICAgICAgICAgICAg
ICAgcmVnID0gPDB4NTAwPjsNCisgICAgICAgICAgICB9Ow0KKw0KKyAgICAgICAgICAgIGNwdTY6
IGNwdUA2IHsNCisgICAgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAiY3B1IjsNCisgICAgICAg
ICAgICAgICAgY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4LWE3NSI7DQorICAgICAgICAgICAgICAg
IGVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQorICAgICAgICAgICAgICAgIG10ay1mcmVxLWRvbWFp
biA9IDwmY3B1ZnJlcV9odyAxPjsNCisgICAgICAgICAgICAgICAgcmVnID0gPDB4NjAwPjsNCisg
ICAgICAgICAgICB9Ow0KKw0KKyAgICAgICAgICAgIGNwdTc6IGNwdUA3IHsNCisgICAgICAgICAg
ICAgICAgZGV2aWNlX3R5cGUgPSAiY3B1IjsNCisgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9
ICJhcm0sY29ydGV4LWE3NSI7DQorICAgICAgICAgICAgICAgIGVuYWJsZS1tZXRob2QgPSAicHNj
aSI7DQorICAgICAgICAgICAgICAgIG10ay1mcmVxLWRvbWFpbiA9IDwmY3B1ZnJlcV9odyAxPjsN
CisgICAgICAgICAgICAgICAgcmVnID0gPDB4NzAwPjsNCisgICAgICAgICAgICB9Ow0KKyAgICB9
Ow0KKw0KKyAgICAvKiAuLi4gKi8NCisNCisgICAgc29jIHsNCisgICAgICAgICNhZGRyZXNzLWNl
bGxzID0gPDI+Ow0KKyAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQorDQorICAgICAgICBjcHVm
cmVxX2h3OiBjcHVmcmVxQDExYmMwMCB7DQorICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxjcHVmcmVxLWh3IjsNCisgICAgICAgICAgICByZWcgPSA8MCAweDExYmMxMCAwIDB4OGM+
LA0KKyAgICAgICAgICAgICAgIDwwIDB4MTFiY2EwIDAgMHg4Yz47DQorICAgICAgICAgICAgcmVn
LW5hbWVzID0gImZyZXEtZG9tYWluMCIsICJmcmVxLWRvbWFpbjEiOw0KKyAgICAgICAgICAgICNm
cmVxLWRvbWFpbi1jZWxscyA9IDwxPjsNCisgICAgICAgIH07DQorICAgIH07DQorDQorDQorDQor
DQotLSANCjEuNy45LjUNCg==

