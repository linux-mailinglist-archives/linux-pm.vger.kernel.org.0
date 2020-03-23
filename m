Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0263018F431
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 13:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgCWMPr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 08:15:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54031 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727401AbgCWMPr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2020 08:15:47 -0400
X-UUID: 226eb97b7fd3432e88f562d1b64e38d6-20200323
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=EmHqXxabAN0b2S2sXgJ4k8NzH+sbwvHDZlDKyy7WAIc=;
        b=rPdY3Nmz4WYS5bVakeNHhbsrK4+OCGZAVBDxcJN+obltT4mY20xl0C1U7kibm5SZljwNXDs9sE28jGgelsT/WaN5E6cYfL6L3DY2OtXcMJo21HHZqE68/O7BNB0CjdvsysHFyR2DUHYjPa0hdIB5M2GWX8qtPktK+9l3noCL8OE=;
X-UUID: 226eb97b7fd3432e88f562d1b64e38d6-20200323
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 740827534; Mon, 23 Mar 2020 20:15:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 23 Mar 2020 20:14:16 +0800
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
Subject: [v4,3/7] arm64: dts: mt8183: Add #cooling-cells to CPU nodes
Date:   Mon, 23 Mar 2020 20:15:33 +0800
Message-ID: <20200323121537.22697-4-michael.kao@mediatek.com>
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

RnJvbTogIm1pY2hhZWwua2FvIiA8bWljaGFlbC5rYW9AbWVkaWF0ZWsuY29tPg0KDQpUaGUgI2Nv
b2xpbmctY2VsbHMgcHJvcGVydHkgbmVlZHMgdG8gYmUgc3BlY2lmaWVkIHRvIGFsbG93IGEgQ1BV
DQp0byBiZSB1c2VkIGFzIGNvb2xpbmcgZGV2aWNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBNaWNoYWVs
IEthbyA8bWljaGFlbC5rYW9AbWVkaWF0ZWsuY29tPg0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDgxODMuZHRzaSB8IDkgKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDkg
aW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDgxODMuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kN
CmluZGV4IDJlMjUyN2MzMzY5YS4uMTgyZmE2MjY0ZTBkIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02
NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KQEAgLTExLDYgKzExLDcgQEANCiAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvcG93ZXIvbXQ4MTgzLXBvd2VyLmg+DQogI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3Jl
c2V0LWNvbnRyb2xsZXIvbXQ4MTgzLXJlc2V0cy5oPg0KICNpbmNsdWRlICJtdDgxODMtcGluZnVu
Yy5oIg0KKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy90aGVybWFsL3RoZXJtYWwuaD4NCiANCiAvIHsN
CiAJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMiOw0KQEAgLTc2LDYgKzc3LDcgQEANCiAJ
CQllbmFibGUtbWV0aG9kID0gInBzY2kiOw0KIAkJCWNhcGFjaXR5LWRtaXBzLW1oeiA9IDw3NDE+
Ow0KIAkJCWR5bmFtaWMtcG93ZXItY29lZmZpY2llbnQgPSA8ODQ+Ow0KKwkJCSNjb29saW5nLWNl
bGxzID0gPDI+Ow0KIAkJfTsNCiANCiAJCWNwdTE6IGNwdUAxIHsNCkBAIC04NSw2ICs4Nyw3IEBA
DQogCQkJZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsNCiAJCQljYXBhY2l0eS1kbWlwcy1taHogPSA8
NzQxPjsNCiAJCQlkeW5hbWljLXBvd2VyLWNvZWZmaWNpZW50ID0gPDg0PjsNCisJCQkjY29vbGlu
Zy1jZWxscyA9IDwyPjsNCiAJCX07DQogDQogCQljcHUyOiBjcHVAMiB7DQpAQCAtOTQsNiArOTcs
NyBAQA0KIAkJCWVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQogCQkJY2FwYWNpdHktZG1pcHMtbWh6
ID0gPDc0MT47DQogCQkJZHluYW1pYy1wb3dlci1jb2VmZmljaWVudCA9IDw4ND47DQorCQkJI2Nv
b2xpbmctY2VsbHMgPSA8Mj47DQogCQl9Ow0KIA0KIAkJY3B1MzogY3B1QDMgew0KQEAgLTEwMyw2
ICsxMDcsNyBAQA0KIAkJCWVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQogCQkJY2FwYWNpdHktZG1p
cHMtbWh6ID0gPDc0MT47DQogCQkJZHluYW1pYy1wb3dlci1jb2VmZmljaWVudCA9IDw4ND47DQor
CQkJI2Nvb2xpbmctY2VsbHMgPSA8Mj47DQogCQl9Ow0KIA0KIAkJY3B1NDogY3B1QDEwMCB7DQpA
QCAtMTEyLDYgKzExNyw3IEBADQogCQkJZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsNCiAJCQljYXBh
Y2l0eS1kbWlwcy1taHogPSA8MTAyND47DQogCQkJZHluYW1pYy1wb3dlci1jb2VmZmljaWVudCA9
IDwyMTE+Ow0KKwkJCSNjb29saW5nLWNlbGxzID0gPDI+Ow0KIAkJfTsNCiANCiAJCWNwdTU6IGNw
dUAxMDEgew0KQEAgLTEyMSw2ICsxMjcsNyBAQA0KIAkJCWVuYWJsZS1tZXRob2QgPSAicHNjaSI7
DQogCQkJY2FwYWNpdHktZG1pcHMtbWh6ID0gPDEwMjQ+Ow0KIAkJCWR5bmFtaWMtcG93ZXItY29l
ZmZpY2llbnQgPSA8MjExPjsNCisJCQkjY29vbGluZy1jZWxscyA9IDwyPjsNCiAJCX07DQogDQog
CQljcHU2OiBjcHVAMTAyIHsNCkBAIC0xMzAsNiArMTM3LDcgQEANCiAJCQllbmFibGUtbWV0aG9k
ID0gInBzY2kiOw0KIAkJCWNhcGFjaXR5LWRtaXBzLW1oeiA9IDwxMDI0PjsNCiAJCQlkeW5hbWlj
LXBvd2VyLWNvZWZmaWNpZW50ID0gPDIxMT47DQorCQkJI2Nvb2xpbmctY2VsbHMgPSA8Mj47DQog
CQl9Ow0KIA0KIAkJY3B1NzogY3B1QDEwMyB7DQpAQCAtMTM5LDYgKzE0Nyw3IEBADQogCQkJZW5h
YmxlLW1ldGhvZCA9ICJwc2NpIjsNCiAJCQljYXBhY2l0eS1kbWlwcy1taHogPSA8MTAyND47DQog
CQkJZHluYW1pYy1wb3dlci1jb2VmZmljaWVudCA9IDwyMTE+Ow0KKwkJCSNjb29saW5nLWNlbGxz
ID0gPDI+Ow0KIAkJfTsNCiAJfTsNCiANCi0tIA0KMi4xOC4wDQo=

