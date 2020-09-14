Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A632682DD
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 05:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgINDFl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Sep 2020 23:05:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11909 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgINDFY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2020 23:05:24 -0400
X-UUID: d5e13a062ea44bbaabc9f5e32a426af2-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gjbZ7EKE7bYC9s+TAJMXV+z2AM8mP9qQSnfSBopillU=;
        b=i1c9IFI+n1lw2kNLqrdH/9nRJkSgcyz34114SBZZwZDvmJIRLSQBRdFg3WeWC56ltO0lQOsWsV4YnxyDAJTA3ROZ/is1ED3BhqhUm+JXLrwOisY3a0g4anGJt9Jw+QBhb0nLpu2PdcP34A1CiJkqz8mZQGPRt+LPl+FjG8mpDmQ=;
X-UUID: d5e13a062ea44bbaabc9f5e32a426af2-20200914
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1235267071; Mon, 14 Sep 2020 11:05:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Sep 2020 11:04:48 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Sep 2020 11:04:48 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        Mike Turquette <mturquette@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH V5 06/17] soc: mediatek: add driver for dvfsrc support
Date:   Mon, 14 Sep 2020 11:04:33 +0800
Message-ID: <1600052684-21198-7-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
References: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5298DCA3361E2D22C6AA253035DFF938DC9B689EC198D5F934C9C7B4230BF4EC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QWRkIGR2ZnNyYyBkcml2ZXIgZm9yIE1UNjg3My9NVDgxODMvTVQ4MTkyDQoNClNpZ25lZC1vZmYt
Ynk6IEhlbnJ5IENoZW4gPGhlbnJ5Yy5jaGVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
c29jL21lZGlhdGVrL0tjb25maWcgICAgICAgICAgICB8ICAxMiArDQogZHJpdmVycy9zb2MvbWVk
aWF0ZWsvTWFrZWZpbGUgICAgICAgICAgIHwgICAxICsNCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9t
dGstZHZmc3JjLmMgICAgICAgfCA2MTggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
CiBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGtfZHZmc3JjLmggfCAgMzQgKysNCiA0IGZp
bGVzIGNoYW5nZWQsIDY2NSBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvc29jL21lZGlhdGVrL210ay1kdmZzcmMuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRl
L2xpbnV4L3NvYy9tZWRpYXRlay9tdGtfZHZmc3JjLmgNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
c29jL21lZGlhdGVrL0tjb25maWcgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9LY29uZmlnDQppbmRl
eCAzZjVlNWNiLi5hYzc4YzQ3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvS2Nv
bmZpZw0KKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvS2NvbmZpZw0KQEAgLTE2LDYgKzE2LDE4
IEBAIGNvbmZpZyBNVEtfQ01EUQ0KIAkgIHRpbWUgbGltaXRhdGlvbiwgc3VjaCBhcyB1cGRhdGlu
ZyBkaXNwbGF5IGNvbmZpZ3VyYXRpb24gZHVyaW5nIHRoZQ0KIAkgIHZibGFuay4NCiANCitjb25m
aWcgTVRLX0RWRlNSQw0KKwl0cmlzdGF0ZSAiTWVkaWFUZWsgRFZGU1JDIFN1cHBvcnQiDQorCWRl
cGVuZHMgb24gQVJDSF9NRURJQVRFSw0KKwlkZXBlbmRzIG9uIE1US19TQ1BTWVMNCisJaGVscA0K
KwkgIFNheSB5ZXMgaGVyZSB0byBhZGQgc3VwcG9ydCBmb3IgdGhlIE1lZGlhVGVrIERWRlNSQyAo
ZHluYW1pYyB2b2x0YWdlDQorCSAgYW5kIGZyZXF1ZW5jeSBzY2FsaW5nIHJlc291cmNlIGNvbGxl
Y3RvcikgZm91bmQNCisJICBvbiBkaWZmZXJlbnQgTWVkaWFUZWsgU29Dcy4gVGhlIERWRlNSQyBp
cyBhIHByb3ByaWV0YXJ5DQorCSAgaGFyZHdhcmUgd2hpY2ggaXMgdXNlZCB0byBjb2xsZWN0IGFs
bCB0aGUgcmVxdWVzdHMgZnJvbQ0KKwkgIHN5c3RlbSBhbmQgdHVybiBpbnRvIHRoZSBkZWNpc2lv
biBvZiBtaW5pbXVtIFZjb3JlIHZvbHRhZ2UNCisJICBhbmQgbWluaW11bSBEUkFNIGZyZXF1ZW5j
eSB0byBmdWxmaWxsIHRob3NlIHJlcXVlc3RzLg0KKw0KIGNvbmZpZyBNVEtfUE1JQ19XUkFQDQog
CXRyaXN0YXRlICJNZWRpYVRlayBQTUlDIFdyYXBwZXIgU3VwcG9ydCINCiAJZGVwZW5kcyBvbiBS
RVNFVF9DT05UUk9MTEVSDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvTWFrZWZp
bGUgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9NYWtlZmlsZQ0KaW5kZXggMmFmYTdiOS4uNjVlOTU5
NyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL01ha2VmaWxlDQorKysgYi9kcml2
ZXJzL3NvYy9tZWRpYXRlay9NYWtlZmlsZQ0KQEAgLTEsNSArMSw2IEBADQogIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQogb2JqLSQoQ09ORklHX01US19DTURRKSArPSBt
dGstY21kcS1oZWxwZXIubw0KK29iai0kKENPTkZJR19NVEtfRFZGU1JDKSArPSBtdGstZHZmc3Jj
Lm8NCiBvYmotJChDT05GSUdfTVRLX1BNSUNfV1JBUCkgKz0gbXRrLXBtaWMtd3JhcC5vDQogb2Jq
LSQoQ09ORklHX01US19TQ1BTWVMpICs9IG10ay1zY3BzeXMubw0KIG9iai0kKENPTkZJR19NVEtf
TU1TWVMpICs9IG10ay1tbXN5cy5vDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXRrLWR2ZnNyYy5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWR2ZnNyYy5jDQpuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uYzUzOTY3Nw0KLS0tIC9kZXYvbnVsbA0KKysr
IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWR2ZnNyYy5jDQpAQCAtMCwwICsxLDYxOCBAQA0K
Ky8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQorLyoNCisgKiBDb3B5cmlnaHQg
KEMpIDIwMTggTWVkaWFUZWsgSW5jLg0KKyAqLw0KKyNpbmNsdWRlIDxsaW51eC9hcm0tc21jY2Mu
aD4NCisjaW5jbHVkZSA8bGludXgvaW8uaD4NCisjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQor
I2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KKyNpbmNsdWRlIDxsaW51eC9ub3RpZmllci5oPg0K
KyNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCisjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1f
ZGV2aWNlLmg+DQorI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9tdGtfZHZmc3JjLmg+DQor
I2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9tdGtfc2lwX3N2Yy5oPg0KKyNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9wb3dlci9tdDgxODMtcG93ZXIuaD4NCisjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
c29jL210ayxkdmZzcmMuaD4NCisjaW5jbHVkZSAibXRrLXNjcHN5cy5oIg0KKw0KKyNkZWZpbmUg
RFZGU1JDX0lETEUgICAgIDB4MDANCisjZGVmaW5lIERWRlNSQ19HRVRfVEFSR0VUX0xFVkVMKHgp
ICAoKCh4KSA+PiAwKSAmIDB4MDAwMGZmZmYpDQorI2RlZmluZSBEVkZTUkNfR0VUX0NVUlJFTlRf
TEVWRUwoeCkgKCgoeCkgPj4gMTYpICYgMHgwMDAwZmZmZikNCisjZGVmaW5lIGticHNfdG9fbWJw
cyh4KSAoKHgpIC8gMTAwMCkNCisNCisjZGVmaW5lIE1UODE4M19EVkZTUkNfT1BQX0xQNCAgIDAN
CisjZGVmaW5lIE1UODE4M19EVkZTUkNfT1BQX0xQNFggIDENCisjZGVmaW5lIE1UODE4M19EVkZT
UkNfT1BQX0xQMyAgIDINCisNCisjZGVmaW5lIFBPTExfVElNRU9VVCAgICAgICAgMTAwMA0KKyNk
ZWZpbmUgU1RBUlRVUF9USU1FICAgICAgICAxDQorDQorI2RlZmluZSBNVEtfU0lQX0RWRlNSQ19J
TklUCQkweDAwDQorDQorI2RlZmluZSBEVkZTUkNfT1BQX0RFU0MoX29wcF90YWJsZSkJXA0KK3sJ
XA0KKwkub3BwcyA9IF9vcHBfdGFibGUsCVwNCisJLm51bV9vcHAgPSBBUlJBWV9TSVpFKF9vcHBf
dGFibGUpLAlcDQorfQ0KKw0KK3N0cnVjdCBkdmZzcmNfb3BwIHsNCisJdTMyIHZjb3JlX29wcDsN
CisJdTMyIGRyYW1fb3BwOw0KK307DQorDQorc3RydWN0IGR2ZnNyY19kb21haW4gew0KKwl1MzIg
aWQ7DQorCXUzMiBzdGF0ZTsNCit9Ow0KKw0KK3N0cnVjdCBkdmZzcmNfb3BwX2Rlc2Mgew0KKwlj
b25zdCBzdHJ1Y3QgZHZmc3JjX29wcCAqb3BwczsNCisJdTMyIG51bV9vcHA7DQorfTsNCisNCitz
dHJ1Y3QgbXRrX2R2ZnNyYzsNCitzdHJ1Y3QgZHZmc3JjX3NvY19kYXRhIHsNCisJY29uc3QgaW50
ICpyZWdzOw0KKwl1MzIgbnVtX2RvbWFpbnM7DQorCXN0cnVjdCBkdmZzcmNfZG9tYWluICpkb21h
aW5zOw0KKwljb25zdCBzdHJ1Y3QgZHZmc3JjX29wcF9kZXNjICpvcHBzX2Rlc2M7DQorCWludCAo
KmdldF90YXJnZXRfbGV2ZWwpKHN0cnVjdCBtdGtfZHZmc3JjICpkdmZzcmMpOw0KKwlpbnQgKCpn
ZXRfY3VycmVudF9sZXZlbCkoc3RydWN0IG10a19kdmZzcmMgKmR2ZnNyYyk7DQorCXUzMiAoKmdl
dF92Y29yZV9sZXZlbCkoc3RydWN0IG10a19kdmZzcmMgKmR2ZnNyYyk7DQorCXUzMiAoKmdldF92
Y3BfbGV2ZWwpKHN0cnVjdCBtdGtfZHZmc3JjICpkdmZzcmMpOw0KKwl2b2lkICgqc2V0X2RyYW1f
YncpKHN0cnVjdCBtdGtfZHZmc3JjICpkdmZzcmMsIHU2NCBidyk7DQorCXZvaWQgKCpzZXRfZHJh
bV9wZWFrX2J3KShzdHJ1Y3QgbXRrX2R2ZnNyYyAqZHZmc3JjLCB1NjQgYncpOw0KKwl2b2lkICgq
c2V0X2RyYW1faHJ0YncpKHN0cnVjdCBtdGtfZHZmc3JjICpkdmZzcmMsIHU2NCBidyk7DQorCXZv
aWQgKCpzZXRfb3BwX2xldmVsKShzdHJ1Y3QgbXRrX2R2ZnNyYyAqZHZmc3JjLCB1MzIgbGV2ZWwp
Ow0KKwl2b2lkICgqc2V0X3Zjb3JlX2xldmVsKShzdHJ1Y3QgbXRrX2R2ZnNyYyAqZHZmc3JjLCB1
MzIgbGV2ZWwpOw0KKwl2b2lkICgqc2V0X3ZzY3BfbGV2ZWwpKHN0cnVjdCBtdGtfZHZmc3JjICpk
dmZzcmMsIHUzMiBsZXZlbCk7DQorCWludCAoKndhaXRfZm9yX29wcF9sZXZlbCkoc3RydWN0IG10
a19kdmZzcmMgKmR2ZnNyYywgdTMyIGxldmVsKTsNCisJaW50ICgqd2FpdF9mb3JfdmNvcmVfbGV2
ZWwpKHN0cnVjdCBtdGtfZHZmc3JjICpkdmZzcmMsIHUzMiBsZXZlbCk7DQorfTsNCisNCitzdHJ1
Y3QgbXRrX2R2ZnNyYyB7DQorCXN0cnVjdCBkZXZpY2UgKmRldjsNCisJc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqaWNjOw0KKwlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpyZWd1bGF0b3I7DQorCWNv
bnN0IHN0cnVjdCBkdmZzcmNfc29jX2RhdGEgKmR2ZDsNCisJaW50IGRyYW1fdHlwZTsNCisJY29u
c3Qgc3RydWN0IGR2ZnNyY19vcHBfZGVzYyAqY3Vycl9vcHBzOw0KKwl2b2lkIF9faW9tZW0gKnJl
Z3M7DQorCXNwaW5sb2NrX3QgcmVxX2xvY2s7DQorCXN0cnVjdCBtdXRleCBwc3RhdGVfbG9jazsN
CisJc3RydWN0IG5vdGlmaWVyX2Jsb2NrIHNjcHN5c19ub3RpZmllcjsNCit9Ow0KKw0KK3N0YXRp
YyB1MzIgZHZmc3JjX3JlYWQoc3RydWN0IG10a19kdmZzcmMgKmR2ZnMsIHUzMiBvZmZzZXQpDQor
ew0KKwlyZXR1cm4gcmVhZGwoZHZmcy0+cmVncyArIGR2ZnMtPmR2ZC0+cmVnc1tvZmZzZXRdKTsN
Cit9DQorDQorc3RhdGljIHZvaWQgZHZmc3JjX3dyaXRlKHN0cnVjdCBtdGtfZHZmc3JjICpkdmZz
LCB1MzIgb2Zmc2V0LCB1MzIgdmFsKQ0KK3sNCisJd3JpdGVsKHZhbCwgZHZmcy0+cmVncyArIGR2
ZnMtPmR2ZC0+cmVnc1tvZmZzZXRdKTsNCit9DQorDQorI2RlZmluZSBkdmZzcmNfcm13KGR2ZnMs
IG9mZnNldCwgdmFsLCBtYXNrLCBzaGlmdCkgXA0KKwlkdmZzcmNfd3JpdGUoZHZmcywgb2Zmc2V0
LCBcDQorCQkoZHZmc3JjX3JlYWQoZHZmcywgb2Zmc2V0KSAmIH4obWFzayA8PCBzaGlmdCkpIHwg
KHZhbCA8PCBzaGlmdCkpDQorDQorZW51bSBkdmZzcmNfcmVncyB7DQorCURWRlNSQ19TV19SRVEs
DQorCURWRlNSQ19TV19SRVEyLA0KKwlEVkZTUkNfTEVWRUwsDQorCURWRlNSQ19UQVJHRVRfTEVW
RUwsDQorCURWRlNSQ19TV19CVywNCisJRFZGU1JDX1NXX1BFQUtfQlcsDQorCURWRlNSQ19TV19I
UlRfQlcsDQorCURWRlNSQ19WQ09SRV9SRVFVRVNULA0KK307DQorDQorc3RhdGljIGNvbnN0IGlu
dCBtdDgxODNfcmVnc1tdID0gew0KKwlbRFZGU1JDX1NXX1JFUV0gPQkweDQsDQorCVtEVkZTUkNf
U1dfUkVRMl0gPQkweDgsDQorCVtEVkZTUkNfTEVWRUxdID0JMHhEQywNCisJW0RWRlNSQ19TV19C
V10gPQkweDE2MCwNCit9Ow0KKw0KK3N0YXRpYyBjb25zdCBpbnQgbXQ2ODczX3JlZ3NbXSA9IHsN
CisJW0RWRlNSQ19TV19SRVFdID0JCTB4QywNCisJW0RWRlNSQ19MRVZFTF0gPQkJMHhENDQsDQor
CVtEVkZTUkNfU1dfUEVBS19CV10gPQkJMHgyNzgsDQorCVtEVkZTUkNfU1dfQlddID0JCTB4MjZD
LA0KKwlbRFZGU1JDX1NXX0hSVF9CV10gPQkJMHgyOTAsDQorCVtEVkZTUkNfVEFSR0VUX0xFVkVM
XSA9CQkweEQ0OCwNCisJW0RWRlNSQ19WQ09SRV9SRVFVRVNUXSA9CTB4NkMsDQorfTsNCisNCitz
dGF0aWMgY29uc3Qgc3RydWN0IGR2ZnNyY19vcHAgKmdldF9jdXJyZW50X29wcChzdHJ1Y3QgbXRr
X2R2ZnNyYyAqZHZmc3JjKQ0KK3sNCisJaW50IGxldmVsOw0KKw0KKwlsZXZlbCA9IGR2ZnNyYy0+
ZHZkLT5nZXRfY3VycmVudF9sZXZlbChkdmZzcmMpOw0KKwlyZXR1cm4gJmR2ZnNyYy0+Y3Vycl9v
cHBzLT5vcHBzW2xldmVsXTsNCit9DQorDQorc3RhdGljIGludCBkdmZzcmNfaXNfaWRsZShzdHJ1
Y3QgbXRrX2R2ZnNyYyAqZHZmc3JjKQ0KK3sNCisJaWYgKCFkdmZzcmMtPmR2ZC0+Z2V0X3Rhcmdl
dF9sZXZlbCkNCisJCXJldHVybiB0cnVlOw0KKw0KKwlyZXR1cm4gZHZmc3JjLT5kdmQtPmdldF90
YXJnZXRfbGV2ZWwoZHZmc3JjKTsNCit9DQorDQorc3RhdGljIGludCBkdmZzcmNfd2FpdF9mb3Jf
dmNvcmVfbGV2ZWwoc3RydWN0IG10a19kdmZzcmMgKmR2ZnNyYywgdTMyIGxldmVsKQ0KK3sNCisJ
Y29uc3Qgc3RydWN0IGR2ZnNyY19vcHAgKmN1cnI7DQorDQorCXJldHVybiByZWFkeF9wb2xsX3Rp
bWVvdXRfYXRvbWljKGdldF9jdXJyZW50X29wcCwgZHZmc3JjLCBjdXJyLA0KKwkJCQkJIGN1cnIt
PnZjb3JlX29wcCA+PSBsZXZlbCwgU1RBUlRVUF9USU1FLA0KKwkJCQkJIFBPTExfVElNRU9VVCk7
DQorfQ0KKw0KK3N0YXRpYyBpbnQgbXQ2ODczX2dldF90YXJnZXRfbGV2ZWwoc3RydWN0IG10a19k
dmZzcmMgKmR2ZnNyYykNCit7DQorCXJldHVybiBkdmZzcmNfcmVhZChkdmZzcmMsIERWRlNSQ19U
QVJHRVRfTEVWRUwpOw0KK30NCisNCitzdGF0aWMgaW50IG10Njg3M19nZXRfY3VycmVudF9sZXZl
bChzdHJ1Y3QgbXRrX2R2ZnNyYyAqZHZmc3JjKQ0KK3sNCisJdTMyIGN1cnJfbGV2ZWw7DQorDQor
CS8qIEhXIGxldmVsIDAgaXMgYmVnaW4gZnJvbSAweDEsIGFuZCBtYXggb3BwIGlzIDB4MSovDQor
CWN1cnJfbGV2ZWwgPSBmZnMoZHZmc3JjX3JlYWQoZHZmc3JjLCBEVkZTUkNfTEVWRUwpKTsNCisJ
aWYgKGN1cnJfbGV2ZWwgPiBkdmZzcmMtPmN1cnJfb3Bwcy0+bnVtX29wcCkNCisJCWN1cnJfbGV2
ZWwgPSAwOw0KKwllbHNlDQorCQljdXJyX2xldmVsID0gZHZmc3JjLT5jdXJyX29wcHMtPm51bV9v
cHAgLSBjdXJyX2xldmVsOw0KKw0KKwlyZXR1cm4gY3Vycl9sZXZlbDsNCit9DQorDQorc3RhdGlj
IGludCBtdDY4NzNfd2FpdF9mb3Jfb3BwX2xldmVsKHN0cnVjdCBtdGtfZHZmc3JjICpkdmZzcmMs
IHUzMiBsZXZlbCkNCit7DQorCWNvbnN0IHN0cnVjdCBkdmZzcmNfb3BwICp0YXJnZXQsICpjdXJy
Ow0KKw0KKwl0YXJnZXQgPSAmZHZmc3JjLT5jdXJyX29wcHMtPm9wcHNbbGV2ZWxdOw0KKwlyZXR1
cm4gcmVhZHhfcG9sbF90aW1lb3V0X2F0b21pYyhnZXRfY3VycmVudF9vcHAsIGR2ZnNyYywgY3Vy
ciwNCisJCWN1cnItPmRyYW1fb3BwID49IHRhcmdldC0+ZHJhbV9vcHAsDQorCQlTVEFSVFVQX1RJ
TUUsIFBPTExfVElNRU9VVCk7DQorfQ0KKw0KK3N0YXRpYyB1MzIgbXQ2ODczX2dldF92Y29yZV9s
ZXZlbChzdHJ1Y3QgbXRrX2R2ZnNyYyAqZHZmc3JjKQ0KK3sNCisJcmV0dXJuIChkdmZzcmNfcmVh
ZChkdmZzcmMsIERWRlNSQ19TV19SRVEpID4+IDQpICYgMHg3Ow0KK30NCisNCitzdGF0aWMgdTMy
IG10Njg3M19nZXRfdmNwX2xldmVsKHN0cnVjdCBtdGtfZHZmc3JjICpkdmZzcmMpDQorew0KKwly
ZXR1cm4gKGR2ZnNyY19yZWFkKGR2ZnNyYywgRFZGU1JDX1ZDT1JFX1JFUVVFU1QpID4+IDEyKSAm
IDB4NzsNCit9DQorDQorc3RhdGljIHZvaWQgbXQ2ODczX3NldF9kcmFtX2J3KHN0cnVjdCBtdGtf
ZHZmc3JjICpkdmZzcmMsIHU2NCBidykNCit7DQorCWJ3ID0gZGl2X3U2NChrYnBzX3RvX21icHMo
YncpLCAxMDApOw0KKwlidyA9IG1pbl90KHU2NCwgYncsIDB4RkYpOw0KKwlkdmZzcmNfd3JpdGUo
ZHZmc3JjLCBEVkZTUkNfU1dfQlcsIGJ3KTsNCit9DQorDQorc3RhdGljIHZvaWQgbXQ2ODczX3Nl
dF9kcmFtX3BlYWtfYncoc3RydWN0IG10a19kdmZzcmMgKmR2ZnNyYywgdTY0IGJ3KQ0KK3sNCisJ
YncgPSBkaXZfdTY0KGticHNfdG9fbWJwcyhidyksIDEwMCk7DQorCWJ3ID0gbWluX3QodTY0LCBi
dywgMHhGRik7DQorCWR2ZnNyY193cml0ZShkdmZzcmMsIERWRlNSQ19TV19QRUFLX0JXLCBidyk7
DQorfQ0KKw0KK3N0YXRpYyB2b2lkIG10Njg3M19zZXRfZHJhbV9ocnRidyhzdHJ1Y3QgbXRrX2R2
ZnNyYyAqZHZmc3JjLCB1NjQgYncpDQorew0KKwlidyA9IGRpdl91NjQoKGticHNfdG9fbWJwcyhi
dykgKyAyOSksIDMwKTsNCisJYncgPSBtaW5fdCh1NjQsIGJ3LCAweDNGRik7DQorCWR2ZnNyY193
cml0ZShkdmZzcmMsIERWRlNSQ19TV19IUlRfQlcsIGJ3KTsNCit9DQorDQorc3RhdGljIHZvaWQg
bXQ2ODczX3NldF92Y29yZV9sZXZlbChzdHJ1Y3QgbXRrX2R2ZnNyYyAqZHZmc3JjLCB1MzIgbGV2
ZWwpDQorew0KKwlzcGluX2xvY2soJmR2ZnNyYy0+cmVxX2xvY2spOw0KKwlkdmZzcmNfcm13KGR2
ZnNyYywgRFZGU1JDX1NXX1JFUSwgbGV2ZWwsIDB4NywgNCk7DQorCXNwaW5fdW5sb2NrKCZkdmZz
cmMtPnJlcV9sb2NrKTsNCit9DQorDQorc3RhdGljIHZvaWQgbXQ2ODczX3NldF92c2NwX2xldmVs
KHN0cnVjdCBtdGtfZHZmc3JjICpkdmZzcmMsIHUzMiBsZXZlbCkNCit7DQorCWR2ZnNyY19ybXco
ZHZmc3JjLCBEVkZTUkNfVkNPUkVfUkVRVUVTVCwgbGV2ZWwsIDB4NywgMTIpOw0KK30NCisNCitz
dGF0aWMgaW50IG10ODE4M193YWl0X2Zvcl9vcHBfbGV2ZWwoc3RydWN0IG10a19kdmZzcmMgKmR2
ZnNyYywgdTMyIGxldmVsKQ0KK3sNCisJY29uc3Qgc3RydWN0IGR2ZnNyY19vcHAgKnRhcmdldCwg
KmN1cnI7DQorCWludCByZXQ7DQorDQorCXRhcmdldCA9ICZkdmZzcmMtPmN1cnJfb3Bwcy0+b3Bw
c1tsZXZlbF07DQorCXJldCA9IHJlYWR4X3BvbGxfdGltZW91dChnZXRfY3VycmVudF9vcHAsIGR2
ZnNyYywgY3VyciwNCisJCQkJIGN1cnItPmRyYW1fb3BwID49IHRhcmdldC0+ZHJhbV9vcHAgJiYN
CisJCQkJIGN1cnItPnZjb3JlX29wcCA+PSB0YXJnZXQtPnZjb3JlX29wcCwNCisJCQkJIFNUQVJU
VVBfVElNRSwgUE9MTF9USU1FT1VUKTsNCisJaWYgKHJldCA8IDApIHsNCisJCWRldl93YXJuKGR2
ZnNyYy0+ZGV2LA0KKwkJCSAidGltZW91dCwgdGFyZ2V0OiAldSwgZHJhbTogJWQsIHZjb3JlOiAl
ZFxuIiwgbGV2ZWwsDQorCQkJIGN1cnItPmRyYW1fb3BwLCBjdXJyLT52Y29yZV9vcHApOw0KKwkJ
cmV0dXJuIHJldDsNCisJfQ0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQorc3RhdGljIGludCBtdDgx
ODNfZ2V0X3RhcmdldF9sZXZlbChzdHJ1Y3QgbXRrX2R2ZnNyYyAqZHZmc3JjKQ0KK3sNCisJcmV0
dXJuIERWRlNSQ19HRVRfVEFSR0VUX0xFVkVMKGR2ZnNyY19yZWFkKGR2ZnNyYywgRFZGU1JDX0xF
VkVMKSk7DQorfQ0KKw0KK3N0YXRpYyBpbnQgbXQ4MTgzX2dldF9jdXJyZW50X2xldmVsKHN0cnVj
dCBtdGtfZHZmc3JjICpkdmZzcmMpDQorew0KKwlpbnQgbGV2ZWw7DQorDQorCS8qIEhXIGxldmVs
IDAgaXMgYmVnaW4gZnJvbSAweDEwMDAwICovDQorCWxldmVsID0gRFZGU1JDX0dFVF9DVVJSRU5U
X0xFVkVMKGR2ZnNyY19yZWFkKGR2ZnNyYywgRFZGU1JDX0xFVkVMKSk7DQorCS8qIEFycmF5IGlu
ZGV4IHN0YXJ0IGZyb20gMCAqLw0KKwlyZXR1cm4gZmZzKGxldmVsKSAtIDE7DQorfQ0KKw0KK3N0
YXRpYyB1MzIgbXQ4MTgzX2dldF92Y29yZV9sZXZlbChzdHJ1Y3QgbXRrX2R2ZnNyYyAqZHZmc3Jj
KQ0KK3sNCisJcmV0dXJuIChkdmZzcmNfcmVhZChkdmZzcmMsIERWRlNSQ19TV19SRVEyKSA+PiAy
KSAmIDB4MzsNCit9DQorDQorc3RhdGljIHZvaWQgbXQ4MTgzX3NldF9kcmFtX2J3KHN0cnVjdCBt
dGtfZHZmc3JjICpkdmZzcmMsIHU2NCBidykNCit7DQorCWR2ZnNyY193cml0ZShkdmZzcmMsIERW
RlNSQ19TV19CVywgZGl2X3U2NChrYnBzX3RvX21icHMoYncpLCAxMDApKTsNCit9DQorDQorc3Rh
dGljIHZvaWQgbXQ4MTgzX3NldF9vcHBfbGV2ZWwoc3RydWN0IG10a19kdmZzcmMgKmR2ZnNyYywg
dTMyIGxldmVsKQ0KK3sNCisJaW50IHZjb3JlX29wcCwgZHJhbV9vcHA7DQorCWNvbnN0IHN0cnVj
dCBkdmZzcmNfb3BwICpvcHA7DQorDQorCS8qIHRyYW5zbGF0ZSBwc3RhdGUgdG8gZHZmc3JjIGxl
dmVsLCBhbmQgc2V0IGl0IHRvIERWRlNSQyBIVyAqLw0KKwlvcHAgPSAmZHZmc3JjLT5jdXJyX29w
cHMtPm9wcHNbbGV2ZWxdOw0KKwl2Y29yZV9vcHAgPSBvcHAtPnZjb3JlX29wcDsNCisJZHJhbV9v
cHAgPSBvcHAtPmRyYW1fb3BwOw0KKw0KKwlkZXZfZGJnKGR2ZnNyYy0+ZGV2LCAidmNvcmVfb3Bw
OiAlZCwgZHJhbV9vcHA6ICVkXG4iLA0KKwkJdmNvcmVfb3BwLCBkcmFtX29wcCk7DQorCWR2ZnNy
Y193cml0ZShkdmZzcmMsIERWRlNSQ19TV19SRVEsIGRyYW1fb3BwIHwgdmNvcmVfb3BwIDw8IDIp
Ow0KK30NCisNCitzdGF0aWMgdm9pZCBtdDgxODNfc2V0X3Zjb3JlX2xldmVsKHN0cnVjdCBtdGtf
ZHZmc3JjICpkdmZzcmMsIHUzMiBsZXZlbCkNCit7DQorCWR2ZnNyY193cml0ZShkdmZzcmMsIERW
RlNSQ19TV19SRVEyLCBsZXZlbCA8PCAyKTsNCit9DQorDQordm9pZCBtdGtfZHZmc3JjX3NlbmRf
cmVxdWVzdChjb25zdCBzdHJ1Y3QgZGV2aWNlICpkZXYsIHUzMiBjbWQsIHU2NCBkYXRhKQ0KK3sN
CisJaW50IHJldCwgc3RhdGU7DQorCXN0cnVjdCBtdGtfZHZmc3JjICpkdmZzcmMgPSBkZXZfZ2V0
X2RydmRhdGEoZGV2KTsNCisNCisJZGV2X2RiZyhkdmZzcmMtPmRldiwgImNtZDogJWQsIGRhdGE6
ICVsbHVcbiIsIGNtZCwgZGF0YSk7DQorDQorCXN3aXRjaCAoY21kKSB7DQorCWNhc2UgTVRLX0RW
RlNSQ19DTURfQldfUkVRVUVTVDoNCisJCWR2ZnNyYy0+ZHZkLT5zZXRfZHJhbV9idyhkdmZzcmMs
IGRhdGEpOw0KKwkJcmV0dXJuOw0KKwljYXNlIE1US19EVkZTUkNfQ01EX1BFQUtfQldfUkVRVUVT
VDoNCisJCWlmIChkdmZzcmMtPmR2ZC0+c2V0X2RyYW1fcGVha19idykNCisJCQlkdmZzcmMtPmR2
ZC0+c2V0X2RyYW1fcGVha19idyhkdmZzcmMsIGRhdGEpOw0KKwkJcmV0dXJuOw0KKwljYXNlIE1U
S19EVkZTUkNfQ01EX09QUF9SRVFVRVNUOg0KKwkJaWYgKGR2ZnNyYy0+ZHZkLT5zZXRfb3BwX2xl
dmVsKQ0KKwkJCWR2ZnNyYy0+ZHZkLT5zZXRfb3BwX2xldmVsKGR2ZnNyYywgZGF0YSk7DQorCQli
cmVhazsNCisJY2FzZSBNVEtfRFZGU1JDX0NNRF9WQ09SRV9SRVFVRVNUOg0KKwkJZHZmc3JjLT5k
dmQtPnNldF92Y29yZV9sZXZlbChkdmZzcmMsIGRhdGEpOw0KKwkJYnJlYWs7DQorCWNhc2UgTVRL
X0RWRlNSQ19DTURfSFJUQldfUkVRVUVTVDoNCisJCWlmIChkdmZzcmMtPmR2ZC0+c2V0X2RyYW1f
aHJ0YncpDQorCQkJZHZmc3JjLT5kdmQtPnNldF9kcmFtX2hydGJ3KGR2ZnNyYywgZGF0YSk7DQor
CQllbHNlDQorCQkJcmV0dXJuOw0KKwkJYnJlYWs7DQorCWNhc2UgTVRLX0RWRlNSQ19DTURfVlND
UF9SRVFVRVNUOg0KKwkJZHZmc3JjLT5kdmQtPnNldF92c2NwX2xldmVsKGR2ZnNyYywgZGF0YSk7
DQorCQlicmVhazsNCisJZGVmYXVsdDoNCisJCWRldl9lcnIoZHZmc3JjLT5kZXYsICJ1bmtub3du
IGNvbW1hbmQ6ICVkXG4iLCBjbWQpOw0KKwkJcmV0dXJuOw0KKwl9DQorDQorCS8qIERWRlNSQyBu
ZWVkIHRvIHdhaXQgYXQgbGVhc3QgMlQofjE5Nm5zKSB0byBoYW5kbGUgcmVxdWVzdA0KKwkgKiBh
ZnRlciByZWNpZXZpbmcgY29tbWFuZA0KKwkgKi8NCisJdWRlbGF5KFNUQVJUVVBfVElNRSk7DQor
DQorCXJldCA9IHJlYWR4X3BvbGxfdGltZW91dChkdmZzcmNfaXNfaWRsZSwgZHZmc3JjLA0KKwkJ
CQkgc3RhdGUsIHN0YXRlID09IERWRlNSQ19JRExFLA0KKwkJCQkgU1RBUlRVUF9USU1FLCBQT0xM
X1RJTUVPVVQpOw0KKw0KKwlpZiAocmV0IDwgMCkgew0KKwkJZGV2X3dhcm4oZHZmc3JjLT5kZXYs
DQorCQkJICIlZDogaWRsZSB0aW1lb3V0LCBkYXRhOiAlbGx1LCBsYXN0OiAlZCAtPiAlZFxuIiwN
CisJCQkgY21kLCBkYXRhLA0KKwkJCSBkdmZzcmMtPmR2ZC0+Z2V0X2N1cnJlbnRfbGV2ZWwoZHZm
c3JjKSwNCisJCQkgZHZmc3JjLT5kdmQtPmdldF90YXJnZXRfbGV2ZWwoZHZmc3JjKSk7DQorCQly
ZXR1cm47DQorCX0NCisNCisJLyogVGhlIHByZXZpb3VzIGNoYW5nZSBtYXkgYmUgcmVxdWVzdGVk
IGJ5IHByZXZpb3VzIHJlcXVlc3QuDQorCSAqIFNvIHdlIGRlbGF5IDF1cywgdGhlbiBzdGFydCBj
aGVja2luZyBvcHAgaXMgcmVhY2hlZCBlbm91Z2guDQorCSAqLw0KKwl1ZGVsYXkoU1RBUlRVUF9U
SU1FKTsNCisNCisJaWYgKGNtZCA9PSBNVEtfRFZGU1JDX0NNRF9PUFBfUkVRVUVTVCkNCisJCXJl
dCA9IGR2ZnNyYy0+ZHZkLT53YWl0X2Zvcl9vcHBfbGV2ZWwoZHZmc3JjLCBkYXRhKTsNCisJZWxz
ZQ0KKwkJcmV0ID0gZHZmc3JjLT5kdmQtPndhaXRfZm9yX3Zjb3JlX2xldmVsKGR2ZnNyYywgZGF0
YSk7DQorDQorCWlmIChyZXQgPCAwKSB7DQorCQlkZXZfd2FybihkdmZzcmMtPmRldiwNCisJCQkg
IiVkOiB3YWl0IHRpbWVvdXQsIGRhdGE6ICVsbHUsIGxhc3Q6ICVkIC0+ICVkXG4iLA0KKwkJCSBj
bWQsIGRhdGEsDQorCQkJIGR2ZnNyYy0+ZHZkLT5nZXRfY3VycmVudF9sZXZlbChkdmZzcmMpLA0K
KwkJCSBkdmZzcmMtPmR2ZC0+Z2V0X3RhcmdldF9sZXZlbChkdmZzcmMpKTsNCisJfQ0KKw0KK30N
CitFWFBPUlRfU1lNQk9MKG10a19kdmZzcmNfc2VuZF9yZXF1ZXN0KTsNCisNCitpbnQgbXRrX2R2
ZnNyY19xdWVyeV9pbmZvKGNvbnN0IHN0cnVjdCBkZXZpY2UgKmRldiwgdTMyIGNtZCwgaW50ICpk
YXRhKQ0KK3sNCisJc3RydWN0IG10a19kdmZzcmMgKmR2ZnNyYyA9IGRldl9nZXRfZHJ2ZGF0YShk
ZXYpOw0KKw0KKwlzd2l0Y2ggKGNtZCkgew0KKwljYXNlIE1US19EVkZTUkNfQ01EX1ZDT1JFX0xF
VkVMX1FVRVJZOg0KKwkJKmRhdGEgPSBkdmZzcmMtPmR2ZC0+Z2V0X3Zjb3JlX2xldmVsKGR2ZnNy
Yyk7DQorCQlicmVhazsNCisJY2FzZSBNVEtfRFZGU1JDX0NNRF9WU0NQX0xFVkVMX1FVRVJZOg0K
KwkJKmRhdGEgPSBkdmZzcmMtPmR2ZC0+Z2V0X3ZjcF9sZXZlbChkdmZzcmMpOw0KKwkJYnJlYWs7
DQorCWRlZmF1bHQ6DQorCQlyZXR1cm4gLUVJTlZBTDsNCisJfQ0KKw0KKwlyZXR1cm4gMDsNCit9
DQorRVhQT1JUX1NZTUJPTChtdGtfZHZmc3JjX3F1ZXJ5X2luZm8pOw0KKw0KK3N0YXRpYyBpbnQg
ZHZmc3JjX3NldF9wZXJmb3JtYW5jZShzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKmIsDQorCQkJCSAg
dW5zaWduZWQgbG9uZyBwc3RhdGUsIHZvaWQgKnYpDQorew0KKwlib29sIG1hdGNoID0gZmFsc2U7
DQorCWludCBpOw0KKwlzdHJ1Y3QgbXRrX2R2ZnNyYyAqZHZmc3JjOw0KKwlzdHJ1Y3Qgc2NwX2V2
ZW50X2RhdGEgKnNjID0gdjsNCisJc3RydWN0IGR2ZnNyY19kb21haW4gKmQ7DQorCXUzMiBoaWdo
ZXN0Ow0KKw0KKwlpZiAoc2MtPmV2ZW50X3R5cGUgIT0gTVRLX1NDUFNZU19QU1RBVEUpDQorCQly
ZXR1cm4gMDsNCisNCisJZHZmc3JjID0gY29udGFpbmVyX29mKGIsIHN0cnVjdCBtdGtfZHZmc3Jj
LCBzY3BzeXNfbm90aWZpZXIpOw0KKw0KKwlpZiAoIWR2ZnNyYy0+ZHZkLT5udW1fZG9tYWlucykN
CisJCXJldHVybiAwOw0KKw0KKwlkID0gZHZmc3JjLT5kdmQtPmRvbWFpbnM7DQorDQorCWlmIChw
c3RhdGUgPiBkdmZzcmMtPmN1cnJfb3Bwcy0+bnVtX29wcCkgew0KKwkJZGV2X2VycihkdmZzcmMt
PmRldiwgInBzdGF0ZSBvdXQgb2YgcmFuZ2UgPSAlbGRcbiIsIHBzdGF0ZSk7DQorCQlyZXR1cm4g
MDsNCisJfQ0KKw0KKwltdXRleF9sb2NrKCZkdmZzcmMtPnBzdGF0ZV9sb2NrKTsNCisNCisJZm9y
IChpID0gMCwgaGlnaGVzdCA9IDA7IGkgPCBkdmZzcmMtPmR2ZC0+bnVtX2RvbWFpbnM7IGkrKywg
ZCsrKSB7DQorCQlpZiAoc2MtPmRvbWFpbl9pZCA9PSBkLT5pZCkgew0KKwkJCWQtPnN0YXRlID0g
cHN0YXRlOw0KKwkJCW1hdGNoID0gdHJ1ZTsNCisJCX0NCisJCWhpZ2hlc3QgPSBtYXgoaGlnaGVz
dCwgZC0+c3RhdGUpOw0KKwl9DQorDQorCWlmICghbWF0Y2gpDQorCQlnb3RvIG91dDsNCisNCisJ
LyogcHN0YXQgc3RhcnQgZnJvbSBsZXZlbCAxLCBhcnJheSBpbmRleCBzdGFydCBmcm9tIDAgKi8N
CisJbXRrX2R2ZnNyY19zZW5kX3JlcXVlc3QoZHZmc3JjLT5kZXYsIE1US19EVkZTUkNfQ01EX09Q
UF9SRVFVRVNULA0KKwkJCQloaWdoZXN0IC0gMSk7DQorDQorb3V0Og0KKwltdXRleF91bmxvY2so
JmR2ZnNyYy0+cHN0YXRlX2xvY2spOw0KKwlyZXR1cm4gMDsNCit9DQorDQorc3RhdGljIHZvaWQg
cHN0YXRlX25vdGlmaWVyX3JlZ2lzdGVyKHN0cnVjdCBtdGtfZHZmc3JjICpkdmZzcmMpDQorew0K
KwlkdmZzcmMtPnNjcHN5c19ub3RpZmllci5ub3RpZmllcl9jYWxsID0gZHZmc3JjX3NldF9wZXJm
b3JtYW5jZTsNCisJcmVnaXN0ZXJfc2Nwc3lzX25vdGlmaWVyKCZkdmZzcmMtPnNjcHN5c19ub3Rp
Zmllcik7DQorfQ0KKw0KK3N0YXRpYyBpbnQgbXRrX2R2ZnNyY19wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KK3sNCisJc3RydWN0IGFybV9zbWNjY19yZXMgYXJlczsNCisJc3Ry
dWN0IHJlc291cmNlICpyZXM7DQorCXN0cnVjdCBtdGtfZHZmc3JjICpkdmZzcmM7DQorCWludCBy
ZXQ7DQorDQorCWR2ZnNyYyA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2YoKmR2ZnNy
YyksIEdGUF9LRVJORUwpOw0KKwlpZiAoIWR2ZnNyYykNCisJCXJldHVybiAtRU5PTUVNOw0KKw0K
KwlkdmZzcmMtPmR2ZCA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSgmcGRldi0+ZGV2KTsNCisJ
ZHZmc3JjLT5kZXYgPSAmcGRldi0+ZGV2Ow0KKw0KKwlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3Vy
Y2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KKwlkdmZzcmMtPnJlZ3MgPSBkZXZtX2lvcmVt
YXBfcmVzb3VyY2UoJnBkZXYtPmRldiwgcmVzKTsNCisJaWYgKElTX0VSUihkdmZzcmMtPnJlZ3Mp
KQ0KKwkJcmV0dXJuIFBUUl9FUlIoZHZmc3JjLT5yZWdzKTsNCisNCisJc3Bpbl9sb2NrX2luaXQo
JmR2ZnNyYy0+cmVxX2xvY2spOw0KKwltdXRleF9pbml0KCZkdmZzcmMtPnBzdGF0ZV9sb2NrKTsN
CisNCisJYXJtX3NtY2NjX3NtYyhNVEtfU0lQX1ZDT1JFRlNfQ09OVFJPTCwgTVRLX1NJUF9EVkZT
UkNfSU5JVCwgMCwgMCwgMCwNCisJCTAsIDAsIDAsICZhcmVzKTsNCisNCisJaWYgKCFhcmVzLmEw
KSB7DQorCQlkdmZzcmMtPmRyYW1fdHlwZSA9IGFyZXMuYTE7DQorCQlkZXZfaW5mbyhkdmZzcmMt
PmRldiwgImRyYW1fdHlwZTogJWRcbiIsIGR2ZnNyYy0+ZHJhbV90eXBlKTsNCisJfSBlbHNlIHsN
CisJCWRldl9lcnIoZHZmc3JjLT5kZXYsICJpbml0IGZhaWxzOiAlbHVcbiIsIGFyZXMuYTApOw0K
KwkJcmV0dXJuIGFyZXMuYTA7DQorCX0NCisNCisJZHZmc3JjLT5jdXJyX29wcHMgPSAmZHZmc3Jj
LT5kdmQtPm9wcHNfZGVzY1tkdmZzcmMtPmRyYW1fdHlwZV07DQorCXBsYXRmb3JtX3NldF9kcnZk
YXRhKHBkZXYsIGR2ZnNyYyk7DQorCWlmIChkdmZzcmMtPmR2ZC0+bnVtX2RvbWFpbnMpDQorCQlw
c3RhdGVfbm90aWZpZXJfcmVnaXN0ZXIoZHZmc3JjKTsNCisNCisJZHZmc3JjLT5yZWd1bGF0b3Ig
PSBwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXJfZGF0YShkdmZzcmMtPmRldiwNCisJCQkibXRrLWR2
ZnNyYy1yZWd1bGF0b3IiLCAtMSwgTlVMTCwgMCk7DQorCWlmIChJU19FUlIoZHZmc3JjLT5yZWd1
bGF0b3IpKSB7DQorCQlkZXZfZXJyKGR2ZnNyYy0+ZGV2LCAiRmFpbGVkIGNyZWF0ZSByZWd1bGF0
b3IgZGV2aWNlXG4iKTsNCisJCXJldCA9IFBUUl9FUlIoZHZmc3JjLT5yZWd1bGF0b3IpOw0KKwkJ
Z290byBlcnI7DQorCX0NCisNCisJZHZmc3JjLT5pY2MgPSBwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0
ZXJfZGF0YShkdmZzcmMtPmRldiwNCisJCQkibWVkaWF0ZWstZW1pLWljYyIsIC0xLCBOVUxMLCAw
KTsNCisJaWYgKElTX0VSUihkdmZzcmMtPmljYykpIHsNCisJCWRldl9lcnIoZHZmc3JjLT5kZXYs
ICJGYWlsZWQgY3JlYXRlIGljYyBkZXZpY2VcbiIpOw0KKwkJcmV0ID0gUFRSX0VSUihkdmZzcmMt
PmljYyk7DQorCQlnb3RvIHVucmVnaXN0ZXJfcmVndWxhdG9yOw0KKwl9DQorDQorCXJldCA9IGRl
dm1fb2ZfcGxhdGZvcm1fcG9wdWxhdGUoJnBkZXYtPmRldik7DQorCWlmIChyZXQpDQorCQlwbGF0
Zm9ybV9kZXZpY2VfdW5yZWdpc3RlcihkdmZzcmMtPmljYyk7DQorDQorCXJldHVybiAwOw0KKw0K
K3VucmVnaXN0ZXJfcmVndWxhdG9yOg0KKwlwbGF0Zm9ybV9kZXZpY2VfdW5yZWdpc3RlcihkdmZz
cmMtPnJlZ3VsYXRvcik7DQorZXJyOg0KKwlyZXR1cm4gcmV0Ow0KK30NCisNCitzdGF0aWMgY29u
c3Qgc3RydWN0IGR2ZnNyY19vcHAgZHZmc3JjX29wcF9tdDgxODNfbHA0W10gPSB7DQorCXswLCAw
fSwgezAsIDF9LCB7MCwgMn0sIHsxLCAyfSwNCit9Ow0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
ZHZmc3JjX29wcCBkdmZzcmNfb3BwX210ODE4M19scDNbXSA9IHsNCisJezAsIDB9LCB7MCwgMX0s
IHsxLCAxfSwgezEsIDJ9LA0KK307DQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBkdmZzcmNfb3Bw
X2Rlc2MgZHZmc3JjX29wcF9tdDgxODNfZGVzY1tdID0gew0KKwlEVkZTUkNfT1BQX0RFU0MoZHZm
c3JjX29wcF9tdDgxODNfbHA0KSwNCisJRFZGU1JDX09QUF9ERVNDKGR2ZnNyY19vcHBfbXQ4MTgz
X2xwMyksDQorCURWRlNSQ19PUFBfREVTQyhkdmZzcmNfb3BwX210ODE4M19scDMpLA0KK307DQor
DQorc3RhdGljIHN0cnVjdCBkdmZzcmNfZG9tYWluIGR2ZnNyY19kb21haW5zX210ODE4M1tdID0g
ew0KKwl7IE1UODE4M19QT1dFUl9ET01BSU5fTUZHX0FTWU5DLCAwIH0sDQorCXsgTVQ4MTgzX1BP
V0VSX0RPTUFJTl9NRkcsIDAgfSwNCisJeyBNVDgxODNfUE9XRVJfRE9NQUlOX0NBTSwgMCB9LA0K
Kwl7IE1UODE4M19QT1dFUl9ET01BSU5fRElTUCwgMCB9LA0KKwl7IE1UODE4M19QT1dFUl9ET01B
SU5fSVNQLCAwIH0sDQorCXsgTVQ4MTgzX1BPV0VSX0RPTUFJTl9WREVDLCAwIH0sDQorCXsgTVQ4
MTgzX1BPV0VSX0RPTUFJTl9WRU5DLCAwIH0sDQorfTsNCisNCitzdGF0aWMgY29uc3Qgc3RydWN0
IGR2ZnNyY19zb2NfZGF0YSBtdDgxODNfZGF0YSA9IHsNCisJLm9wcHNfZGVzYyA9IGR2ZnNyY19v
cHBfbXQ4MTgzX2Rlc2MsDQorCS5yZWdzID0gbXQ4MTgzX3JlZ3MsDQorCS5kb21haW5zID0gZHZm
c3JjX2RvbWFpbnNfbXQ4MTgzLA0KKwkubnVtX2RvbWFpbnMgPSBBUlJBWV9TSVpFKGR2ZnNyY19k
b21haW5zX210ODE4MyksDQorCS5nZXRfdGFyZ2V0X2xldmVsID0gbXQ4MTgzX2dldF90YXJnZXRf
bGV2ZWwsDQorCS5nZXRfY3VycmVudF9sZXZlbCA9IG10ODE4M19nZXRfY3VycmVudF9sZXZlbCwN
CisJLmdldF92Y29yZV9sZXZlbCA9IG10ODE4M19nZXRfdmNvcmVfbGV2ZWwsDQorCS5zZXRfZHJh
bV9idyA9IG10ODE4M19zZXRfZHJhbV9idywNCisJLnNldF9vcHBfbGV2ZWwgPSBtdDgxODNfc2V0
X29wcF9sZXZlbCwNCisJLnNldF92Y29yZV9sZXZlbCA9IG10ODE4M19zZXRfdmNvcmVfbGV2ZWws
DQorCS53YWl0X2Zvcl9vcHBfbGV2ZWwgPSBtdDgxODNfd2FpdF9mb3Jfb3BwX2xldmVsLA0KKwku
d2FpdF9mb3JfdmNvcmVfbGV2ZWwgPSBkdmZzcmNfd2FpdF9mb3JfdmNvcmVfbGV2ZWwsDQorfTsN
CisNCitzdGF0aWMgY29uc3Qgc3RydWN0IGR2ZnNyY19vcHAgZHZmc3JjX29wcF9tdDY4NzNfbHA0
W10gPSB7DQorCXswLCAwfSwgezEsIDB9LCB7MiwgMH0sIHszLCAwfSwNCisJezAsIDF9LCB7MSwg
MX0sIHsyLCAxfSwgezMsIDF9LA0KKwl7MCwgMn0sIHsxLCAyfSwgezIsIDJ9LCB7MywgMn0sDQor
CXsxLCAzfSwgezIsIDN9LCB7MywgM30sIHsxLCA0fSwNCisJezIsIDR9LCB7MywgNH0sIHsyLCA1
fSwgezMsIDV9LA0KKwl7MywgNn0sDQorfTsNCisNCitzdGF0aWMgY29uc3Qgc3RydWN0IGR2ZnNy
Y19vcHBfZGVzYyBkdmZzcmNfb3BwX210Njg3M19kZXNjW10gPSB7DQorCURWRlNSQ19PUFBfREVT
QyhkdmZzcmNfb3BwX210Njg3M19scDQpLA0KK307DQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBk
dmZzcmNfc29jX2RhdGEgbXQ2ODczX2RhdGEgPSB7DQorCS5vcHBzX2Rlc2MgPSBkdmZzcmNfb3Bw
X210Njg3M19kZXNjLA0KKwkucmVncyA9IG10Njg3M19yZWdzLA0KKwkuZ2V0X3RhcmdldF9sZXZl
bCA9IG10Njg3M19nZXRfdGFyZ2V0X2xldmVsLA0KKwkuZ2V0X2N1cnJlbnRfbGV2ZWwgPSBtdDY4
NzNfZ2V0X2N1cnJlbnRfbGV2ZWwsDQorCS5nZXRfdmNvcmVfbGV2ZWwgPSBtdDY4NzNfZ2V0X3Zj
b3JlX2xldmVsLA0KKwkuZ2V0X3ZjcF9sZXZlbCA9IG10Njg3M19nZXRfdmNwX2xldmVsLA0KKwku
c2V0X2RyYW1fYncgPSBtdDY4NzNfc2V0X2RyYW1fYncsDQorCS5zZXRfZHJhbV9wZWFrX2J3ID0g
bXQ2ODczX3NldF9kcmFtX3BlYWtfYncsDQorCS5zZXRfZHJhbV9ocnRidyA9IG10Njg3M19zZXRf
ZHJhbV9ocnRidywNCisJLnNldF92Y29yZV9sZXZlbCA9IG10Njg3M19zZXRfdmNvcmVfbGV2ZWws
DQorCS5zZXRfdnNjcF9sZXZlbCA9IG10Njg3M19zZXRfdnNjcF9sZXZlbCwNCisJLndhaXRfZm9y
X29wcF9sZXZlbCA9IG10Njg3M193YWl0X2Zvcl9vcHBfbGV2ZWwsDQorCS53YWl0X2Zvcl92Y29y
ZV9sZXZlbCA9IGR2ZnNyY193YWl0X2Zvcl92Y29yZV9sZXZlbCwNCit9Ow0KKw0KK3N0YXRpYyBp
bnQgbXRrX2R2ZnNyY19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCit7DQor
CXN0cnVjdCBtdGtfZHZmc3JjICpkdmZzcmMgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsN
CisNCisJcGxhdGZvcm1fZGV2aWNlX3VucmVnaXN0ZXIoZHZmc3JjLT5yZWd1bGF0b3IpOw0KKwlw
bGF0Zm9ybV9kZXZpY2VfdW5yZWdpc3RlcihkdmZzcmMtPmljYyk7DQorDQorCXJldHVybiAwOw0K
K30NCisNCitzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfZHZmc3JjX29mX21h
dGNoW10gPSB7DQorCXsNCisJCS5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1kdmZzcmMi
LA0KKwkJLmRhdGEgPSAmbXQ4MTgzX2RhdGEsDQorCX0sIHsNCisJCS5jb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE5Mi1kdmZzcmMiLA0KKwkJLmRhdGEgPSAmbXQ2ODczX2RhdGEsDQorCX0sIHsN
CisJCS5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njg3My1kdmZzcmMiLA0KKwkJLmRhdGEgPSAm
bXQ2ODczX2RhdGEsDQorCX0sIHsNCisJCS8qIHNlbnRpbmVsICovDQorCX0sDQorfTsNCisNCitz
dGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBtdGtfZHZmc3JjX2RyaXZlciA9IHsNCisJLnBy
b2JlCT0gbXRrX2R2ZnNyY19wcm9iZSwNCisJLnJlbW92ZQk9IG10a19kdmZzcmNfcmVtb3ZlLA0K
KwkuZHJpdmVyID0gew0KKwkJLm5hbWUgPSAibXRrLWR2ZnNyYyIsDQorCQkub2ZfbWF0Y2hfdGFi
bGUgPSBvZl9tYXRjaF9wdHIobXRrX2R2ZnNyY19vZl9tYXRjaCksDQorCX0sDQorfTsNCisNCitz
dGF0aWMgaW50IF9faW5pdCBtdGtfZHZmc3JjX2luaXQodm9pZCkNCit7DQorCXJldHVybiBwbGF0
Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJm10a19kdmZzcmNfZHJpdmVyKTsNCit9DQorc3Vic3lzX2lu
aXRjYWxsKG10a19kdmZzcmNfaW5pdCk7DQorDQorc3RhdGljIHZvaWQgX19leGl0IG10a19kdmZz
cmNfZXhpdCh2b2lkKQ0KK3sNCisJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJm10a19kdmZz
cmNfZHJpdmVyKTsNCit9DQorbW9kdWxlX2V4aXQobXRrX2R2ZnNyY19leGl0KTsNCisNCitNT0RV
TEVfTElDRU5TRSgiR1BMIHYyIik7DQorTU9EVUxFX0RFU0NSSVBUSU9OKCJNVEsgRFZGU1JDIGRy
aXZlciIpOw0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210a19kdmZz
cmMuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210a19kdmZzcmMuaA0KbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLmYyMTc2YjUNCi0tLSAvZGV2L251bGwNCisrKyBi
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210a19kdmZzcmMuaA0KQEAgLTAsMCArMSwzNCBA
QA0KKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQorICoNCisgKiBDb3B5cmln
aHQgKGMpIDIwMTggTWVkaWFUZWsgSW5jLg0KKyAqLw0KKyNpZm5kZWYgX19TT0NfTVRLX0RWRlNS
Q19IDQorI2RlZmluZSBfX1NPQ19NVEtfRFZGU1JDX0gNCisNCisjZGVmaW5lIE1US19EVkZTUkNf
Q01EX0JXX1JFUVVFU1QJCTANCisjZGVmaW5lIE1US19EVkZTUkNfQ01EX09QUF9SRVFVRVNUCQkx
DQorI2RlZmluZSBNVEtfRFZGU1JDX0NNRF9WQ09SRV9SRVFVRVNUCQkyDQorI2RlZmluZSBNVEtf
RFZGU1JDX0NNRF9IUlRCV19SRVFVRVNUCQkzDQorI2RlZmluZSBNVEtfRFZGU1JDX0NNRF9WU0NQ
X1JFUVVFU1QJCTQNCisjZGVmaW5lIE1US19EVkZTUkNfQ01EX1BFQUtfQldfUkVRVUVTVAkJNQ0K
Kw0KKyNkZWZpbmUgTVRLX0RWRlNSQ19DTURfVkNPUkVfTEVWRUxfUVVFUlkJMA0KKyNkZWZpbmUg
TVRLX0RWRlNSQ19DTURfVlNDUF9MRVZFTF9RVUVSWQkJMQ0KKw0KKyNpZiBJU19FTkFCTEVEKENP
TkZJR19NVEtfRFZGU1JDKQ0KK3ZvaWQgbXRrX2R2ZnNyY19zZW5kX3JlcXVlc3QoY29uc3Qgc3Ry
dWN0IGRldmljZSAqZGV2LCB1MzIgY21kLCB1NjQgZGF0YSk7DQoraW50IG10a19kdmZzcmNfcXVl
cnlfaW5mbyhjb25zdCBzdHJ1Y3QgZGV2aWNlICpkZXYsIHUzMiBjbWQsIGludCAqZGF0YSk7DQor
DQorI2Vsc2UNCisNCitzdGF0aWMgaW5saW5lIHZvaWQgbXRrX2R2ZnNyY19zZW5kX3JlcXVlc3Qo
Y29uc3Qgc3RydWN0IGRldmljZSAqZGV2LCB1MzIgY21kLA0KKwkJCQkJICAgdTY0IGRhdGEpDQor
eyByZXR1cm4gLUVOT0RFVjsgfQ0KKw0KK3N0YXRpYyBpbmxpbmUgaW50IG10a19kdmZzcmNfcXVl
cnlfaW5mbyhjb25zdCBzdHJ1Y3QgZGV2aWNlICpkZXYsIHUzMiBjbWQsDQorCQkJCQlpbnQgKmRh
dGEpOw0KK3sgcmV0dXJuIC1FTk9ERVY7IH0NCisNCisjZW5kaWYgLyogQ09ORklHX01US19EVkZT
UkMgKi8NCisNCisjZW5kaWYNCi0tIA0KMS45LjENCg==

