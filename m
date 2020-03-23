Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D432318F43E
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 13:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgCWMPp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 08:15:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54031 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727377AbgCWMPo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2020 08:15:44 -0400
X-UUID: df17da0d8b6345b7aeef52b08729b011-20200323
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=t4KDU3gSGbmIBW1rfyL1Ets87sk3PSbQi3QOVB4Qbp0=;
        b=m4wa/aWu/KVS6/eZ2BS+RbH2oPKQiHlKWukwP93/jOan0aFMkJFqWdRHEE05Z+qilQgu/Jn2hSP/q7rf1DM0r220s4TOsF+Kx35YugPkp0hdDU1Rf7j3vpvvO4Ds3q7geOnJeLNxkHQhOxP831NbO8vdtnvjfcyAGvXk/QQhLyo=;
X-UUID: df17da0d8b6345b7aeef52b08729b011-20200323
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1546018266; Mon, 23 Mar 2020 20:15:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 23 Mar 2020 20:14:29 +0800
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
        <linux-mediatek@lists.infradead.org>
Subject: [v4,2/7] arm64: dts: mt8183: add dynamic power coefficients
Date:   Mon, 23 Mar 2020 20:15:32 +0800
Message-ID: <20200323121537.22697-3-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200323121537.22697-1-michael.kao@mediatek.com>
References: <20200323121537.22697-1-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogIm1pY2hhZWwua2FvIiA8bWljaGFlbC5rYW9AbWVkaWF0ZWsuY29tPg0KDQpBZGQgZHlu
YW1pYyBwb3dlciBjb2VmZmljaWVudHMgZm9yIGFsbCBjb3JlcyBhbmQgdXBkYXRlIHRob3NlIG9m
DQpDUFUwIGFuZCBDUFU0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEthbyA8bWljaGFlbC5r
YW9AbWVkaWF0ZWsuY29tPg0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgx
ODMuZHRzaSB8IDggKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQoN
CmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpIGIv
YXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KaW5kZXggNTlmOTcyMTdh
YWE4Li4yZTI1MjdjMzM2OWEgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlh
dGVrL210ODE4My5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4
My5kdHNpDQpAQCAtNzUsNiArNzUsNyBAQA0KIAkJCXJlZyA9IDwweDAwMD47DQogCQkJZW5hYmxl
LW1ldGhvZCA9ICJwc2NpIjsNCiAJCQljYXBhY2l0eS1kbWlwcy1taHogPSA8NzQxPjsNCisJCQlk
eW5hbWljLXBvd2VyLWNvZWZmaWNpZW50ID0gPDg0PjsNCiAJCX07DQogDQogCQljcHUxOiBjcHVA
MSB7DQpAQCAtODMsNiArODQsNyBAQA0KIAkJCXJlZyA9IDwweDAwMT47DQogCQkJZW5hYmxlLW1l
dGhvZCA9ICJwc2NpIjsNCiAJCQljYXBhY2l0eS1kbWlwcy1taHogPSA8NzQxPjsNCisJCQlkeW5h
bWljLXBvd2VyLWNvZWZmaWNpZW50ID0gPDg0PjsNCiAJCX07DQogDQogCQljcHUyOiBjcHVAMiB7
DQpAQCAtOTEsNiArOTMsNyBAQA0KIAkJCXJlZyA9IDwweDAwMj47DQogCQkJZW5hYmxlLW1ldGhv
ZCA9ICJwc2NpIjsNCiAJCQljYXBhY2l0eS1kbWlwcy1taHogPSA8NzQxPjsNCisJCQlkeW5hbWlj
LXBvd2VyLWNvZWZmaWNpZW50ID0gPDg0PjsNCiAJCX07DQogDQogCQljcHUzOiBjcHVAMyB7DQpA
QCAtOTksNiArMTAyLDcgQEANCiAJCQlyZWcgPSA8MHgwMDM+Ow0KIAkJCWVuYWJsZS1tZXRob2Qg
PSAicHNjaSI7DQogCQkJY2FwYWNpdHktZG1pcHMtbWh6ID0gPDc0MT47DQorCQkJZHluYW1pYy1w
b3dlci1jb2VmZmljaWVudCA9IDw4ND47DQogCQl9Ow0KIA0KIAkJY3B1NDogY3B1QDEwMCB7DQpA
QCAtMTA3LDYgKzExMSw3IEBADQogCQkJcmVnID0gPDB4MTAwPjsNCiAJCQllbmFibGUtbWV0aG9k
ID0gInBzY2kiOw0KIAkJCWNhcGFjaXR5LWRtaXBzLW1oeiA9IDwxMDI0PjsNCisJCQlkeW5hbWlj
LXBvd2VyLWNvZWZmaWNpZW50ID0gPDIxMT47DQogCQl9Ow0KIA0KIAkJY3B1NTogY3B1QDEwMSB7
DQpAQCAtMTE1LDYgKzEyMCw3IEBADQogCQkJcmVnID0gPDB4MTAxPjsNCiAJCQllbmFibGUtbWV0
aG9kID0gInBzY2kiOw0KIAkJCWNhcGFjaXR5LWRtaXBzLW1oeiA9IDwxMDI0PjsNCisJCQlkeW5h
bWljLXBvd2VyLWNvZWZmaWNpZW50ID0gPDIxMT47DQogCQl9Ow0KIA0KIAkJY3B1NjogY3B1QDEw
MiB7DQpAQCAtMTIzLDYgKzEyOSw3IEBADQogCQkJcmVnID0gPDB4MTAyPjsNCiAJCQllbmFibGUt
bWV0aG9kID0gInBzY2kiOw0KIAkJCWNhcGFjaXR5LWRtaXBzLW1oeiA9IDwxMDI0PjsNCisJCQlk
eW5hbWljLXBvd2VyLWNvZWZmaWNpZW50ID0gPDIxMT47DQogCQl9Ow0KIA0KIAkJY3B1NzogY3B1
QDEwMyB7DQpAQCAtMTMxLDYgKzEzOCw3IEBADQogCQkJcmVnID0gPDB4MTAzPjsNCiAJCQllbmFi
bGUtbWV0aG9kID0gInBzY2kiOw0KIAkJCWNhcGFjaXR5LWRtaXBzLW1oeiA9IDwxMDI0PjsNCisJ
CQlkeW5hbWljLXBvd2VyLWNvZWZmaWNpZW50ID0gPDIxMT47DQogCQl9Ow0KIAl9Ow0KIA0KLS0g
DQoyLjE4LjANCg==

