Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C503252F3A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 15:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbgHZNCS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 09:02:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:8470 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730099AbgHZNCI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 09:02:08 -0400
X-UUID: f8140fc064ba44e9b42d3d5d93a22512-20200826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CxyzFCyyAUAD9dzrQYeXJkejylJ8fCzMCpGiZ2fc9dM=;
        b=rD/I6SIHcSYN6197sgB1VsqSANMyY0y/y8dYpJzbXw7kLFL9rjbezDlLxCwacem6eNILCkF8fs9RK+n4ny36CH2VZ7p9jGw9ZZTZ3zX493U4jYv4WuX2xreFZ0hEQWWk5UVaEiWwyy2lto31jQu66sw3I4Ea3u+PG63coxxevZg=;
X-UUID: f8140fc064ba44e9b42d3d5d93a22512-20200826
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 273996754; Wed, 26 Aug 2020 21:02:03 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 21:01:59 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Aug 2020 21:01:59 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>
CC:     <wsd_upstream@mediatek.com>, <hector.yuan@mediatek.com>
Subject: [PATCH v3 2/2] dt-bindings: cpufreq: add bindings for MediaTek cpufreq HW
Date:   Wed, 26 Aug 2020 21:01:53 +0800
Message-ID: <1598446913-24325-3-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1598446913-24325-1-git-send-email-hector.yuan@mediatek.com>
References: <1598446913-24325-1-git-send-email-hector.yuan@mediatek.com>
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
YW1sDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uNWJlNTg2Nw0KLS0tIC9k
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
IGNvbnN0OiBtZWRpYXRlayxjcHVmcmVxLWh3DQorDQorICByZWc6DQorICAgIG1pbkl0ZW1zOiAx
DQorICAgIG1heEl0ZW1zOiAyDQorICAgIGRlc2NyaXB0aW9uOiB8DQorICAgICAgQWRkcmVzc2Vz
IGFuZCBzaXplcyBmb3IgdGhlIG1lbW9yeSBvZiB0aGUgSFcgYmFzZXMgaW4gZWFjaCBmcmVxdWVu
Y3kgZG9tYWluLg0KKw0KKyAgcmVnLW5hbWVzOg0KKyAgICBpdGVtczoNCisgICAgICAtIGNvbnN0
OiAiZnJlcS1kb21haW4wIg0KKyAgICAgIC0gY29uc3Q6ICJmcmVxLWRvbWFpbjEiDQorICAgIGRl
c2NyaXB0aW9uOiB8DQorICAgICAgRnJlcXVlbmN5IGRvbWFpbiBuYW1lLiBpLmUuDQorICAgICAg
ImZyZXEtZG9tYWluMCIsICJmcmVxLWRvbWFpbjEiLg0KKw0KKyAgIiNmcmVxLWRvbWFpbi1jZWxs
cyI6DQorICAgIGNvbnN0OiAxDQorICAgIGRlc2NyaXB0aW9uOiB8DQorICAgICAgTnVtYmVyIG9m
IGNlbGxzIGluIGEgZnJlcWVuY3kgZG9tYWluIHNwZWNpZmllci4NCisNCisgIG10ay1mcmVxLWRv
bWFpbjoNCisgICAgbWF4SXRlbXM6IDENCisgICAgZGVzY3JpcHRpb246IHwNCisgICAgICBEZWZp
bmUgdGhpcyBjcHUgYmVsb25ncyB0byB3aGljaCBmcmVxdWVuY3kgZG9tYWluLiBpLmUuDQorICAg
ICAgY3B1MC0zIGJlbG9uZyB0byBmcmVxdWVuY3kgZG9tYWluMCwNCisgICAgICBjcHU0LTYgYmVs
b25nIHRvIGZyZXF1ZW5jeSBkb21haW4xLg0KKw0KK3JlcXVpcmVkOg0KKyAgLSBjb21wYXRpYmxl
DQorICAtIHJlZw0KKyAgLSByZWctbmFtZXMNCisgIC0gIiNmcmVxLWRvbWFpbi1jZWxscyINCisN
CitleGFtcGxlczoNCisgIC0gfA0KKyAgICBjcHVzIHsNCisgICAgICAgICAgICAjYWRkcmVzcy1j
ZWxscyA9IDwxPjsNCisgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCisNCisgICAgICAg
ICAgICBjcHUwOiBjcHVAMCB7DQorICAgICAgICAgICAgICAgIGRldmljZV90eXBlID0gImNwdSI7
DQorICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLGNvcnRleC1hNTUiOw0KKyAgICAg
ICAgICAgICAgICBlbmFibGUtbWV0aG9kID0gInBzY2kiOw0KKyAgICAgICAgICAgICAgICBtdGst
ZnJlcS1kb21haW4gPSA8JmNwdWZyZXFfaHcgMD47DQorICAgICAgICAgICAgICAgIHJlZyA9IDww
eDAwMD47DQorICAgICAgICAgICAgfTsNCisNCisgICAgICAgICAgICBjcHUxOiBjcHVAMSB7DQor
ICAgICAgICAgICAgICAgIGRldmljZV90eXBlID0gImNwdSI7DQorICAgICAgICAgICAgICAgIGNv
bXBhdGlibGUgPSAiYXJtLGNvcnRleC1hNTUiOw0KKyAgICAgICAgICAgICAgICBlbmFibGUtbWV0
aG9kID0gInBzY2kiOw0KKyAgICAgICAgICAgICAgICBtdGstZnJlcS1kb21haW4gPSA8JmNwdWZy
ZXFfaHcgMD47DQorICAgICAgICAgICAgICAgIHJlZyA9IDwweDEwMD47DQorICAgICAgICAgICAg
fTsNCisNCisgICAgICAgICAgICBjcHUyOiBjcHVAMiB7DQorICAgICAgICAgICAgICAgIGRldmlj
ZV90eXBlID0gImNwdSI7DQorICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLGNvcnRl
eC1hNTUiOw0KKyAgICAgICAgICAgICAgICBlbmFibGUtbWV0aG9kID0gInBzY2kiOw0KKyAgICAg
ICAgICAgICAgICBtdGstZnJlcS1kb21haW4gPSA8JmNwdWZyZXFfaHcgMD47DQorICAgICAgICAg
ICAgICAgIHJlZyA9IDwweDIwMD47DQorICAgICAgICAgICAgfTsNCisNCisgICAgICAgICAgICBj
cHUzOiBjcHVAMyB7DQorICAgICAgICAgICAgICAgIGRldmljZV90eXBlID0gImNwdSI7DQorICAg
ICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLGNvcnRleC1hNTUiOw0KKyAgICAgICAgICAg
ICAgICBlbmFibGUtbWV0aG9kID0gInBzY2kiOw0KKyAgICAgICAgICAgICAgICBtdGstZnJlcS1k
b21haW4gPSA8JmNwdWZyZXFfaHcgMD47DQorICAgICAgICAgICAgICAgIHJlZyA9IDwweDMwMD47
DQorICAgICAgICAgICAgfTsNCisNCisgICAgICAgICAgICBjcHU0OiBjcHVANCB7DQorICAgICAg
ICAgICAgICAgIGRldmljZV90eXBlID0gImNwdSI7DQorICAgICAgICAgICAgICAgIGNvbXBhdGli
bGUgPSAiYXJtLGNvcnRleC1hNTUiOw0KKyAgICAgICAgICAgICAgICBlbmFibGUtbWV0aG9kID0g
InBzY2kiOw0KKyAgICAgICAgICAgICAgICBtdGstZnJlcS1kb21haW4gPSA8JmNwdWZyZXFfaHcg
MT47DQorICAgICAgICAgICAgICAgIHJlZyA9IDwweDQwMD47DQorICAgICAgICAgICAgfTsNCisN
CisgICAgICAgICAgICBjcHU1OiBjcHVANSB7DQorICAgICAgICAgICAgICAgIGRldmljZV90eXBl
ID0gImNwdSI7DQorICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLGNvcnRleC1hNTUi
Ow0KKyAgICAgICAgICAgICAgICBlbmFibGUtbWV0aG9kID0gInBzY2kiOw0KKyAgICAgICAgICAg
ICAgICBtdGstZnJlcS1kb21haW4gPSA8JmNwdWZyZXFfaHcgMT47DQorICAgICAgICAgICAgICAg
IHJlZyA9IDwweDUwMD47DQorICAgICAgICAgICAgfTsNCisNCisgICAgICAgICAgICBjcHU2OiBj
cHVANiB7DQorICAgICAgICAgICAgICAgIGRldmljZV90eXBlID0gImNwdSI7DQorICAgICAgICAg
ICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLGNvcnRleC1hNzUiOw0KKyAgICAgICAgICAgICAgICBl
bmFibGUtbWV0aG9kID0gInBzY2kiOw0KKyAgICAgICAgICAgICAgICBtdGstZnJlcS1kb21haW4g
PSA8JmNwdWZyZXFfaHcgMT47DQorICAgICAgICAgICAgICAgIHJlZyA9IDwweDYwMD47DQorICAg
ICAgICAgICAgfTsNCisNCisgICAgICAgICAgICBjcHU3OiBjcHVANyB7DQorICAgICAgICAgICAg
ICAgIGRldmljZV90eXBlID0gImNwdSI7DQorICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAi
YXJtLGNvcnRleC1hNzUiOw0KKyAgICAgICAgICAgICAgICBlbmFibGUtbWV0aG9kID0gInBzY2ki
Ow0KKyAgICAgICAgICAgICAgICBtdGstZnJlcS1kb21haW4gPSA8JmNwdWZyZXFfaHcgMT47DQor
ICAgICAgICAgICAgICAgIHJlZyA9IDwweDcwMD47DQorICAgICAgICAgICAgfTsNCisgICAgfTsN
CisNCisgICAgLyogLi4uICovDQorDQorICAgIHNvYyB7DQorICAgICAgICAjYWRkcmVzcy1jZWxs
cyA9IDwyPjsNCisgICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KKw0KKyAgICAgICAgY3B1ZnJl
cV9odzogY3B1ZnJlcUAxMWJjMDAgew0KKyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0
ZWssY3B1ZnJlcS1odyI7DQorICAgICAgICAgICAgcmVnID0gPDAgMHgxMWJjMTAgMCAweDhjPiwN
CisgICAgICAgICAgICAgICA8MCAweDExYmNhMCAwIDB4OGM+Ow0KKyAgICAgICAgICAgIHJlZy1u
YW1lcyA9ICJmcmVxLWRvbWFpbjAiLCAiZnJlcS1kb21haW4xIjsNCisgICAgICAgICAgICAjZnJl
cS1kb21haW4tY2VsbHMgPSA8MT47DQorICAgICAgICB9Ow0KKyAgICB9Ow0KKw0KKw0KKw0KKw0K
LS0gDQoxLjcuOS41DQo=

