Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D310C2682F1
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 05:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgINDHF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Sep 2020 23:07:05 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:31333 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726080AbgINDFG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2020 23:05:06 -0400
X-UUID: 461bc423578b4977ab4fc4d720041a1a-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nvQRJm4sVECHKjdCBLZvn1Ku1AJv7srF1NJ0jCgZY1Q=;
        b=LqEEKIFrYKCOi8n1VGrBv1vNbkpo1jt2UNT0rYLjDAXOJ7knktu2zHGGtv78Hg4L/G9e+r9hXQrz6d89gJqjKH8iTc/VceKEG+HxoldAxjmD7H/3sEk4dJK7+wsS/P0sqGNWPXipyodbm5jbZAWyP9NjXrZGAZlXvE04HPJWtNo=;
X-UUID: 461bc423578b4977ab4fc4d720041a1a-20200914
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 921105293; Mon, 14 Sep 2020 11:04:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Sep 2020 11:04:49 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Sep 2020 11:04:49 +0800
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
Subject: [PATCH V5 11/17] interconnect: mediatek: Add interconnect provider driver
Date:   Mon, 14 Sep 2020 11:04:38 +0800
Message-ID: <1600052684-21198-12-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
References: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SW50cm9kdWNlIE1lZGlhdGVrIE1UNjg3My9NVDgxODMvTVQ4MTkyIHNwZWNpZmljIHByb3ZpZGVy
IGRyaXZlcg0KdXNpbmcgdGhlIGludGVyY29ubmVjdCBmcmFtZXdvcmsuDQoNCiAgICAgICAgICAg
ICBJQ0MgcHJvdmlkZXIgICAgICAgICBJQ0MgTm9kZXMNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC0tLS0gICAgICAgICAgLS0tLQ0KICAgICAgICAgICAgIC0tLS0tLS0tLSAgICAgICB8
Q1BVIHwgICB8LS0tIHxWUFUgfA0KICAgIC0tLS0tICAgfCAgICAgICAgIHwtLS0tLSAgLS0tLSAg
ICB8ICAgICAtLS0tDQogICB8RFJBTSB8LS18RFJBTSAgICAgfCAgICAgICAtLS0tICAgIHwgICAg
IC0tLS0NCiAgIHwgICAgIHwtLXxzY2hlZHVsZXJ8LS0tLS0gfEdQVSB8ICAgfC0tLSB8RElTUHwN
CiAgIHwgICAgIHwtLXwoRU1JKSAgICB8ICAgICAgIC0tLS0gICAgfCAgICAgLS0tLQ0KICAgfCAg
ICAgfC0tfCAgICAgICAgIHwgICAgICAgLS0tLS0gICB8ICAgICAtLS0tDQogICAgLS0tLS0gICB8
ICAgICAgICAgfC0tLS0tIHxNTVNZU3wtLXwtLS0gfFZERUN8DQogICAgICAgICAgICAgLS0tLS0t
LS0tICAgICAgICAtLS0tLSAgIHwgICAgIC0tLS0NCiAgICAgICAgICAgICAgIC98XCAgICAgICAg
ICAgICAgICAgICAgfCAgICAgLS0tLQ0KICAgICAgICAgICAgICAgIHxjaGFuZ2UgRFJBTSBmcmVx
ICAgICB8LS0tIHxWRU5DfA0KICAgICAgICAgICAgIC0tLS0tLS0tLS0gICAgICAgICAgICAgICB8
ICAgICAtLS0tDQogICAgICAgICAgICB8ICBEVkZTUiAgIHwgICAgICAgICAgICAgIHwNCiAgICAg
ICAgICAgIHwgICAgICAgICAgfCAgICAgICAgICAgICAgfCAgICAgLS0tLQ0KICAgICAgICAgICAg
IC0tLS0tLS0tLS0gICAgICAgICAgICAgICB8LS0tIHxJTUcgfA0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgICAtLS0tDQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAgIC0tLS0NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfC0tLSB8Q0FNIHwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLS0tLQ0KDQpTaWduZWQtb2ZmLWJ5OiBIZW5yeSBDaGVuIDxoZW5yeWMuY2hlbkBtZWRp
YXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2ludGVyY29ubmVjdC9LY29uZmlnICAgICAgICAgICAg
fCAgIDEgKw0KIGRyaXZlcnMvaW50ZXJjb25uZWN0L01ha2VmaWxlICAgICAgICAgICB8ICAgMSAr
DQogZHJpdmVycy9pbnRlcmNvbm5lY3QvbWVkaWF0ZWsvS2NvbmZpZyAgIHwgIDEzICsrDQogZHJp
dmVycy9pbnRlcmNvbm5lY3QvbWVkaWF0ZWsvTWFrZWZpbGUgIHwgICAzICsNCiBkcml2ZXJzL2lu
dGVyY29ubmVjdC9tZWRpYXRlay9tdGstZW1pLmMgfCAzMzAgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCiA1IGZpbGVzIGNoYW5nZWQsIDM0OCBpbnNlcnRpb25zKCspDQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvaW50ZXJjb25uZWN0L21lZGlhdGVrL0tjb25maWcNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pbnRlcmNvbm5lY3QvbWVkaWF0ZWsvTWFrZWZpbGUNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pbnRlcmNvbm5lY3QvbWVkaWF0ZWsvbXRrLWVtaS5j
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2ludGVyY29ubmVjdC9LY29uZmlnIGIvZHJpdmVycy9p
bnRlcmNvbm5lY3QvS2NvbmZpZw0KaW5kZXggNWI3MjA0ZS4uZTkzOWY1YSAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvaW50ZXJjb25uZWN0L0tjb25maWcNCisrKyBiL2RyaXZlcnMvaW50ZXJjb25uZWN0
L0tjb25maWcNCkBAIC0xMyw1ICsxMyw2IEBAIGlmIElOVEVSQ09OTkVDVA0KIA0KIHNvdXJjZSAi
ZHJpdmVycy9pbnRlcmNvbm5lY3QvaW14L0tjb25maWciDQogc291cmNlICJkcml2ZXJzL2ludGVy
Y29ubmVjdC9xY29tL0tjb25maWciDQorc291cmNlICJkcml2ZXJzL2ludGVyY29ubmVjdC9tZWRp
YXRlay9LY29uZmlnIg0KIA0KIGVuZGlmDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnRlcmNvbm5l
Y3QvTWFrZWZpbGUgYi9kcml2ZXJzL2ludGVyY29ubmVjdC9NYWtlZmlsZQ0KaW5kZXggNDgyNWMy
OC4uNmY0Yjg4YSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW50ZXJjb25uZWN0L01ha2VmaWxlDQor
KysgYi9kcml2ZXJzL2ludGVyY29ubmVjdC9NYWtlZmlsZQ0KQEAgLTYsMyArNiw0IEBAIGljYy1j
b3JlLW9ianMJCQkJOj0gY29yZS5vDQogb2JqLSQoQ09ORklHX0lOVEVSQ09OTkVDVCkJCSs9IGlj
Yy1jb3JlLm8NCiBvYmotJChDT05GSUdfSU5URVJDT05ORUNUX0lNWCkJCSs9IGlteC8NCiBvYmot
JChDT05GSUdfSU5URVJDT05ORUNUX1FDT00pCQkrPSBxY29tLw0KK29iai0kKENPTkZJR19JTlRF
UkNPTk5FQ1RfTVRLKQkJKz0gbWVkaWF0ZWsvDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnRlcmNv
bm5lY3QvbWVkaWF0ZWsvS2NvbmZpZyBiL2RyaXZlcnMvaW50ZXJjb25uZWN0L21lZGlhdGVrL0tj
b25maWcNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi45NzJkM2JiDQotLS0g
L2Rldi9udWxsDQorKysgYi9kcml2ZXJzL2ludGVyY29ubmVjdC9tZWRpYXRlay9LY29uZmlnDQpA
QCAtMCwwICsxLDEzIEBADQorY29uZmlnIElOVEVSQ09OTkVDVF9NVEsNCisJYm9vbCAiTWVkaWF0
ZWsgTmV0d29yay1vbi1DaGlwIGludGVyY29ubmVjdCBkcml2ZXJzIg0KKwlkZXBlbmRzIG9uIEFS
Q0hfTUVESUFURUsNCisJaGVscA0KKwkgIFN1cHBvcnQgZm9yIE1lZGlhdGVrJ3MgTmV0d29yay1v
bi1DaGlwIGludGVyY29ubmVjdCBoYXJkd2FyZS4NCisNCitjb25maWcgSU5URVJDT05ORUNUX01U
S19FTUkNCisJdHJpc3RhdGUgIk1lZGlhdGVrIEVNSSBpbnRlcmNvbm5lY3QgZHJpdmVyIg0KKwlk
ZXBlbmRzIG9uIElOVEVSQ09OTkVDVF9NVEsNCisJZGVwZW5kcyBvbiAoTVRLX0RWRlNSQyAmJiBP
RikNCisJaGVscA0KKwkgIFRoaXMgaXMgYSBkcml2ZXIgZm9yIHRoZSBNZWRpYXRlayBOZXR3b3Jr
LW9uLUNoaXAgb24gRFZGU1JDLWJhc2VkDQorCSAgcGxhdGZvcm1zLg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW50ZXJjb25uZWN0L21lZGlhdGVrL01ha2VmaWxlIGIvZHJpdmVycy9pbnRlcmNvbm5l
Y3QvbWVkaWF0ZWsvTWFrZWZpbGUNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAw
Li4zNTM4NDJiDQotLS0gL2Rldi9udWxsDQorKysgYi9kcml2ZXJzL2ludGVyY29ubmVjdC9tZWRp
YXRlay9NYWtlZmlsZQ0KQEAgLTAsMCArMSwzIEBADQorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMA0KKw0KK29iai0kKENPTkZJR19JTlRFUkNPTk5FQ1RfTVRLX0VNSSkgKz0gbXRr
LWVtaS5vDQpcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2ludGVyY29ubmVjdC9tZWRpYXRlay9tdGstZW1pLmMgYi9kcml2ZXJzL2ludGVyY29ubmVjdC9t
ZWRpYXRlay9tdGstZW1pLmMNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi45
NjcwMDc3DQotLS0gL2Rldi9udWxsDQorKysgYi9kcml2ZXJzL2ludGVyY29ubmVjdC9tZWRpYXRl
ay9tdGstZW1pLmMNCkBAIC0wLDAgKzEsMzMwIEBADQorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjANCisvKg0KKyAqIENvcHlyaWdodCAoYykgMjAyMCwgVGhlIExpbnV4IEZvdW5k
YXRpb24uIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQorICoNCisgKi8NCisNCisjaW5jbHVkZSA8bGlu
dXgvZGV2aWNlLmg+DQorI2luY2x1ZGUgPGxpbnV4L2ludGVyY29ubmVjdC1wcm92aWRlci5oPg0K
KyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCisjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+
DQorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KKyNpbmNsdWRlIDxsaW51eC9z
b2MvbWVkaWF0ZWsvbXRrX2R2ZnNyYy5oPg0KKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcmNv
bm5lY3QvbXRrLG10ODE4My1lbWkuaD4NCisjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJjb25u
ZWN0L210ayxtdDY4NzMtZW1pLmg+DQorDQorZW51bSBtdGtfaWNjX25hbWUgew0KKwlTTEFWRV9E
RFJfRU1JLA0KKwlNQVNURVJfTUNVU1lTLA0KKwlNQVNURVJfR1BVU1lTLA0KKwlNQVNURVJfTU1T
WVMsDQorCU1BU1RFUl9NTV9WUFUsDQorCU1BU1RFUl9NTV9ESVNQLA0KKwlNQVNURVJfTU1fVkRF
QywNCisJTUFTVEVSX01NX1ZFTkMsDQorCU1BU1RFUl9NTV9DQU0sDQorCU1BU1RFUl9NTV9JTUcs
DQorCU1BU1RFUl9NTV9NRFAsDQorCU1BU1RFUl9WUFVTWVMsDQorCU1BU1RFUl9WUFVfUE9SVF8w
LA0KKwlNQVNURVJfVlBVX1BPUlRfMSwNCisJTUFTVEVSX01ETEFTWVMsDQorCU1BU1RFUl9NRExB
X1BPUlRfMCwNCisJTUFTVEVSX1VGUywNCisJTUFTVEVSX1BDSUUsDQorCU1BU1RFUl9VU0IsDQor
CU1BU1RFUl9XSUZJLA0KKwlNQVNURVJfQlQsDQorCU1BU1RFUl9ORVRTWVMsDQorCU1BU1RFUl9E
QkdJRiwNCisNCisJU0xBVkVfSFJUX0REUl9FTUksDQorCU1BU1RFUl9IUlRfTU1TWVMsDQorCU1B
U1RFUl9IUlRfTU1fRElTUCwNCisJTUFTVEVSX0hSVF9NTV9WREVDLA0KKwlNQVNURVJfSFJUX01N
X1ZFTkMsDQorCU1BU1RFUl9IUlRfTU1fQ0FNLA0KKwlNQVNURVJfSFJUX01NX0lNRywNCisJTUFT
VEVSX0hSVF9NTV9NRFAsDQorCU1BU1RFUl9IUlRfREJHSUYsDQorfTsNCisNCisjZGVmaW5lIE1U
ODE4M19NQVhfTElOS1MJMQ0KKw0KKy8qKg0KKyAqIHN0cnVjdCBtdGtfaWNjX25vZGUgLSBNZWRp
YXRlayBzcGVjaWZpYyBpbnRlcmNvbm5lY3Qgbm9kZXMNCisgKiBAbmFtZTogdGhlIG5vZGUgbmFt
ZSB1c2VkIGluIGRlYnVnZnMNCisgKiBAZXAgOiB0aGUgdHlwZSBvZiB0aGlzIGVuZHBvaW50DQor
ICogQGlkOiBhIHVuaXF1ZSBub2RlIGlkZW50aWZpZXINCisgKiBAbGlua3M6IGFuIGFycmF5IG9m
IG5vZGVzIHdoZXJlIHdlIGNhbiBnbyBuZXh0IHdoaWxlIHRyYXZlcnNpbmcNCisgKiBAbnVtX2xp
bmtzOiB0aGUgdG90YWwgbnVtYmVyIG9mIEBsaW5rcw0KKyAqIEBzdW1fYXZnOiBjdXJyZW50IHN1
bSBhZ2dyZWdhdGUgdmFsdWUgb2YgYWxsIGF2ZyBidyBrQnBzIHJlcXVlc3RzDQorICogQG1heF9w
ZWFrOiBjdXJyZW50IG1heCBhZ2dyZWdhdGUgdmFsdWUgb2YgYWxsIHBlYWsgYncga0JwcyByZXF1
ZXN0cw0KKyAqLw0KK3N0cnVjdCBtdGtfaWNjX25vZGUgew0KKwl1bnNpZ25lZCBjaGFyICpuYW1l
Ow0KKwlpbnQgZXA7DQorCXUxNiBpZDsNCisJdTE2IGxpbmtzW01UODE4M19NQVhfTElOS1NdOw0K
Kwl1MTYgbnVtX2xpbmtzOw0KKwl1NjQgc3VtX2F2ZzsNCisJdTY0IG1heF9wZWFrOw0KK307DQor
DQorc3RydWN0IG10a19pY2NfZGVzYyB7DQorCXN0cnVjdCBtdGtfaWNjX25vZGUgKipub2RlczsN
CisJc2l6ZV90IG51bV9ub2RlczsNCit9Ow0KKw0KKyNkZWZpbmUgREVGSU5FX01OT0RFKF9uYW1l
LCBfaWQsIF9lcCwgLi4uKQlcDQorCQlzdGF0aWMgc3RydWN0IG10a19pY2Nfbm9kZSBfbmFtZSA9
IHsJCQlcDQorCQkubmFtZSA9ICNfbmFtZSwJCQkJCQlcDQorCQkuaWQgPSBfaWQsCQkJCQkJXA0K
KwkJLmVwID0gX2VwLAkJCQkJCVwNCisJCS5udW1fbGlua3MgPSBBUlJBWV9TSVpFKCgoaW50W10p
eyBfX1ZBX0FSR1NfXyB9KSksCVwNCisJCS5saW5rcyA9IHsgX19WQV9BUkdTX18gfSwJCQkJXA0K
K30NCisNCitERUZJTkVfTU5PREUoZGRyX2VtaSwgU0xBVkVfRERSX0VNSSwgMSk7DQorREVGSU5F
X01OT0RFKG1jdXN5cywgTUFTVEVSX01DVVNZUywgMCwgU0xBVkVfRERSX0VNSSk7DQorREVGSU5F
X01OT0RFKGdwdSwgTUFTVEVSX0dQVVNZUywgMCwgU0xBVkVfRERSX0VNSSk7DQorREVGSU5FX01O
T0RFKG1tc3lzLCBNQVNURVJfTU1TWVMsIDAsIFNMQVZFX0REUl9FTUkpOw0KK0RFRklORV9NTk9E
RShtbV92cHUsIE1BU1RFUl9NTV9WUFUsIDAsIE1BU1RFUl9NTVNZUyk7DQorREVGSU5FX01OT0RF
KG1tX2Rpc3AsIE1BU1RFUl9NTV9ESVNQLCAwLCBNQVNURVJfTU1TWVMpOw0KK0RFRklORV9NTk9E
RShtbV92ZGVjLCBNQVNURVJfTU1fVkRFQywgMCwgTUFTVEVSX01NU1lTKTsNCitERUZJTkVfTU5P
REUobW1fdmVuYywgTUFTVEVSX01NX1ZFTkMsIDAsIE1BU1RFUl9NTVNZUyk7DQorREVGSU5FX01O
T0RFKG1tX2NhbSwgTUFTVEVSX01NX0NBTSwgMCwgTUFTVEVSX01NU1lTKTsNCitERUZJTkVfTU5P
REUobW1faW1nLCBNQVNURVJfTU1fSU1HLCAwLCBNQVNURVJfTU1TWVMpOw0KK0RFRklORV9NTk9E
RShtbV9tZHAsIE1BU1RFUl9NTV9NRFAsIDAsIE1BU1RFUl9NTVNZUyk7DQorREVGSU5FX01OT0RF
KHZwdXN5cywgTUFTVEVSX1ZQVVNZUywgMCwgU0xBVkVfRERSX0VNSSk7DQorREVGSU5FX01OT0RF
KHZwdV9wb3J0XzAsIE1BU1RFUl9WUFVfUE9SVF8wLCAwLCBNQVNURVJfVlBVU1lTKTsNCitERUZJ
TkVfTU5PREUodnB1X3BvcnRfMSwgTUFTVEVSX1ZQVV9QT1JUXzEsIDAsIE1BU1RFUl9WUFVTWVMp
Ow0KK0RFRklORV9NTk9ERShtZGxhc3lzLCBNQVNURVJfTURMQVNZUywgMCwgU0xBVkVfRERSX0VN
SSk7DQorREVGSU5FX01OT0RFKG1kbGFfcG9ydF8wLCBNQVNURVJfTURMQV9QT1JUXzAsIDAsIE1B
U1RFUl9NRExBU1lTKTsNCitERUZJTkVfTU5PREUodWZzLCBNQVNURVJfVUZTLCAwLCBTTEFWRV9E
RFJfRU1JKTsNCitERUZJTkVfTU5PREUocGNpZSwgTUFTVEVSX1BDSUUsIDAsIFNMQVZFX0REUl9F
TUkpOw0KK0RFRklORV9NTk9ERSh1c2IsIE1BU1RFUl9VU0IsIDAsIFNMQVZFX0REUl9FTUkpOw0K
K0RFRklORV9NTk9ERSh3aWZpLCBNQVNURVJfV0lGSSwgMCwgU0xBVkVfRERSX0VNSSk7DQorREVG
SU5FX01OT0RFKGJ0LCBNQVNURVJfQlQsIDAsIFNMQVZFX0REUl9FTUkpOw0KK0RFRklORV9NTk9E
RShuZXRzeXMsIE1BU1RFUl9ORVRTWVMsIDAsIFNMQVZFX0REUl9FTUkpOw0KK0RFRklORV9NTk9E
RShkYmdpZiwgTUFTVEVSX0RCR0lGLCAwLCBTTEFWRV9ERFJfRU1JKTsNCisNCitERUZJTkVfTU5P
REUoaHJ0X2Rkcl9lbWksIFNMQVZFX0hSVF9ERFJfRU1JLCAyKTsNCitERUZJTkVfTU5PREUoaHJ0
X21tc3lzLCBNQVNURVJfSFJUX01NU1lTLCAwLCBTTEFWRV9IUlRfRERSX0VNSSk7DQorREVGSU5F
X01OT0RFKGhydF9tbV9kaXNwLCBNQVNURVJfSFJUX01NX0RJU1AsIDAsIE1BU1RFUl9IUlRfTU1T
WVMpOw0KK0RFRklORV9NTk9ERShocnRfbW1fdmRlYywgTUFTVEVSX0hSVF9NTV9WREVDLCAwLCBN
QVNURVJfSFJUX01NU1lTKTsNCitERUZJTkVfTU5PREUoaHJ0X21tX3ZlbmMsIE1BU1RFUl9IUlRf
TU1fVkVOQywgMCwgTUFTVEVSX0hSVF9NTVNZUyk7DQorREVGSU5FX01OT0RFKGhydF9tbV9jYW0s
IE1BU1RFUl9IUlRfTU1fQ0FNLCAwLCBNQVNURVJfSFJUX01NU1lTKTsNCitERUZJTkVfTU5PREUo
aHJ0X21tX2ltZywgTUFTVEVSX0hSVF9NTV9JTUcsIDAsIE1BU1RFUl9IUlRfTU1TWVMpOw0KK0RF
RklORV9NTk9ERShocnRfbW1fbWRwLCBNQVNURVJfSFJUX01NX01EUCwgMCwgTUFTVEVSX0hSVF9N
TVNZUyk7DQorREVGSU5FX01OT0RFKGhydF9kYmdpZiwgTUFTVEVSX0hSVF9EQkdJRiwgMCwgU0xB
VkVfSFJUX0REUl9FTUkpOw0KKw0KK3N0YXRpYyBzdHJ1Y3QgbXRrX2ljY19ub2RlICptdDgxODNf
aWNjX25vZGVzW10gPSB7DQorCVtNVDgxODNfU0xBVkVfRERSX0VNSV0gPSAmZGRyX2VtaSwNCisJ
W01UODE4M19NQVNURVJfTUNVU1lTXSA9ICZtY3VzeXMsDQorCVtNVDgxODNfTUFTVEVSX0dQVV0g
PSAmZ3B1LA0KKwlbTVQ4MTgzX01BU1RFUl9NTVNZU10gPSAmbW1zeXMsDQorCVtNVDgxODNfTUFT
VEVSX01NX1ZQVV0gPSAmbW1fdnB1LA0KKwlbTVQ4MTgzX01BU1RFUl9NTV9ESVNQXSA9ICZtbV9k
aXNwLA0KKwlbTVQ4MTgzX01BU1RFUl9NTV9WREVDXSA9ICZtbV92ZGVjLA0KKwlbTVQ4MTgzX01B
U1RFUl9NTV9WRU5DXSA9ICZtbV92ZW5jLA0KKwlbTVQ4MTgzX01BU1RFUl9NTV9DQU1dID0gJm1t
X2NhbSwNCisJW01UODE4M19NQVNURVJfTU1fSU1HXSA9ICZtbV9pbWcsDQorCVtNVDgxODNfTUFT
VEVSX01NX01EUF0gPSAmbW1fbWRwLA0KK307DQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtf
aWNjX2Rlc2MgbXQ4MTgzX2ljYyA9IHsNCisJLm5vZGVzID0gbXQ4MTgzX2ljY19ub2RlcywNCisJ
Lm51bV9ub2RlcyA9IEFSUkFZX1NJWkUobXQ4MTgzX2ljY19ub2RlcyksDQorfTsNCisNCitzdGF0
aWMgc3RydWN0IG10a19pY2Nfbm9kZSAqbXQ2ODczX2ljY19ub2Rlc1tdID0gew0KKwlbTVQ2ODcz
X1NMQVZFX0REUl9FTUldID0gJmRkcl9lbWksDQorCVtNVDY4NzNfTUFTVEVSX01DVVNZU10gPSAm
bWN1c3lzLA0KKwlbTVQ2ODczX01BU1RFUl9HUFVTWVNdID0gJmdwdSwNCisJW01UNjg3M19NQVNU
RVJfTU1TWVNdID0gJm1tc3lzLA0KKwlbTVQ2ODczX01BU1RFUl9NTV9WUFVdID0gJm1tX3ZwdSwN
CisJW01UNjg3M19NQVNURVJfTU1fRElTUF0gPSAmbW1fZGlzcCwNCisJW01UNjg3M19NQVNURVJf
TU1fVkRFQ10gPSAmbW1fdmRlYywNCisJW01UNjg3M19NQVNURVJfTU1fVkVOQ10gPSAmbW1fdmVu
YywNCisJW01UNjg3M19NQVNURVJfTU1fQ0FNXSA9ICZtbV9jYW0sDQorCVtNVDY4NzNfTUFTVEVS
X01NX0lNR10gPSAmbW1faW1nLA0KKwlbTVQ2ODczX01BU1RFUl9NTV9NRFBdID0gJm1tX21kcCwN
CisJW01UNjg3M19NQVNURVJfVlBVU1lTXSA9ICZ2cHVzeXMsDQorCVtNVDY4NzNfTUFTVEVSX1ZQ
VV8wXSA9ICZ2cHVfcG9ydF8wLA0KKwlbTVQ2ODczX01BU1RFUl9WUFVfMV0gPSAmdnB1X3BvcnRf
MSwNCisJW01UNjg3M19NQVNURVJfTURMQVNZU10gPSAmbWRsYXN5cywNCisJW01UNjg3M19NQVNU
RVJfTURMQV8wXSA9ICZtZGxhX3BvcnRfMCwNCisJW01UNjg3M19NQVNURVJfVUZTXSA9ICZ1ZnMs
DQorCVtNVDY4NzNfTUFTVEVSX1BDSUVdID0gJnBjaWUsDQorCVtNVDY4NzNfTUFTVEVSX1VTQl0g
PSAmdXNiLA0KKwlbTVQ2ODczX01BU1RFUl9XSUZJXSA9ICZ3aWZpLA0KKwlbTVQ2ODczX01BU1RF
Ul9CVF0gPSAmYnQsDQorCVtNVDY4NzNfTUFTVEVSX05FVFNZU10gPSAmbmV0c3lzLA0KKwlbTVQ2
ODczX01BU1RFUl9EQkdJRl0gPSAmZGJnaWYsDQorDQorCVtNVDY4NzNfU0xBVkVfSFJUX0REUl9F
TUldID0gJmhydF9kZHJfZW1pLA0KKwlbTVQ2ODczX01BU1RFUl9IUlRfTU1TWVNdID0gJmhydF9t
bXN5cywNCisJW01UNjg3M19NQVNURVJfSFJUX01NX0RJU1BdID0gJmhydF9tbV9kaXNwLA0KKwlb
TVQ2ODczX01BU1RFUl9IUlRfTU1fVkRFQ10gPSAmaHJ0X21tX3ZkZWMsDQorCVtNVDY4NzNfTUFT
VEVSX0hSVF9NTV9WRU5DXSA9ICZocnRfbW1fdmVuYywNCisJW01UNjg3M19NQVNURVJfSFJUX01N
X0NBTV0gPSAmaHJ0X21tX2NhbSwNCisJW01UNjg3M19NQVNURVJfSFJUX01NX0lNR10gPSAmaHJ0
X21tX2ltZywNCisJW01UNjg3M19NQVNURVJfSFJUX01NX01EUF0gPSAmaHJ0X21tX21kcCwNCisJ
W01UNjg3M19NQVNURVJfSFJUX0RCR0lGXSA9ICZocnRfZGJnaWYsDQorfTsNCisNCitzdGF0aWMg
c3RydWN0IG10a19pY2NfZGVzYyBtdDY4NzNfaWNjID0gew0KKwkubm9kZXMgPSBtdDY4NzNfaWNj
X25vZGVzLA0KKwkubnVtX25vZGVzID0gQVJSQVlfU0laRShtdDY4NzNfaWNjX25vZGVzKSwNCit9
Ow0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGVtaV9pY2Nfb2ZfbWF0Y2hb
XSA9IHsNCisJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZHZmc3JjIiwgLmRhdGEg
PSAmbXQ4MTgzX2ljYyB9LA0KKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1kdmZz
cmMiLCAuZGF0YSA9ICZtdDY4NzNfaWNjIH0sDQorCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWss
bXQ2ODczLWR2ZnNyYyIsIC5kYXRhID0gJm10Njg3M19pY2MgfSwNCisJeyB9LA0KK307DQorTU9E
VUxFX0RFVklDRV9UQUJMRShvZiwgZW1pX2ljY19vZl9tYXRjaCk7DQorDQorc3RhdGljIGludCBl
bWlfaWNjX2FnZ3JlZ2F0ZShzdHJ1Y3QgaWNjX25vZGUgKm5vZGUsIHUzMiB0YWcsIHUzMiBhdmdf
YncsDQorCQkJICAgICB1MzIgcGVha19idywgdTMyICphZ2dfYXZnLCB1MzIgKmFnZ19wZWFrKQ0K
K3sNCisJc3RydWN0IG10a19pY2Nfbm9kZSAqaW47DQorDQorCWluID0gbm9kZS0+ZGF0YTsNCisN
CisJKmFnZ19hdmcgKz0gYXZnX2J3Ow0KKwkqYWdnX3BlYWsgPSBtYXhfdCh1MzIsICphZ2dfcGVh
aywgcGVha19idyk7DQorDQorCWluLT5zdW1fYXZnID0gKmFnZ19hdmc7DQorCWluLT5tYXhfcGVh
ayA9ICphZ2dfcGVhazsNCisNCisJcmV0dXJuIDA7DQorfQ0KKw0KK3N0YXRpYyBpbnQgZW1pX2lj
Y19zZXQoc3RydWN0IGljY19ub2RlICpzcmMsIHN0cnVjdCBpY2Nfbm9kZSAqZHN0KQ0KK3sNCisJ
aW50IHJldCA9IDA7DQorCXN0cnVjdCBtdGtfaWNjX25vZGUgKm5vZGU7DQorDQorCW5vZGUgPSBk
c3QtPmRhdGE7DQorDQorCWlmIChub2RlLT5lcCA9PSAxKSB7DQorCQltdGtfZHZmc3JjX3NlbmRf
cmVxdWVzdChzcmMtPnByb3ZpZGVyLT5kZXYsDQorCQkJCQlNVEtfRFZGU1JDX0NNRF9QRUFLX0JX
X1JFUVVFU1QsDQorCQkJCQlub2RlLT5tYXhfcGVhayk7DQorCQltdGtfZHZmc3JjX3NlbmRfcmVx
dWVzdChzcmMtPnByb3ZpZGVyLT5kZXYsDQorCQkJCQlNVEtfRFZGU1JDX0NNRF9CV19SRVFVRVNU
LA0KKwkJCQkJbm9kZS0+c3VtX2F2Zyk7DQorCX0gZWxzZSBpZiAobm9kZS0+ZXAgPT0gMikgew0K
KwkJbXRrX2R2ZnNyY19zZW5kX3JlcXVlc3Qoc3JjLT5wcm92aWRlci0+ZGV2LA0KKwkJCQkJTVRL
X0RWRlNSQ19DTURfSFJUQldfUkVRVUVTVCwNCisJCQkJCW5vZGUtPnN1bV9hdmcpOw0KKwl9DQor
DQorCXJldHVybiByZXQ7DQorfQ0KKw0KK3N0YXRpYyBpbnQgZW1pX2ljY19yZW1vdmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldik7DQorc3RhdGljIGludCBlbWlfaWNjX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQorew0KKwljb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lk
ICptYXRjaDsNCisJY29uc3Qgc3RydWN0IG10a19pY2NfZGVzYyAqZGVzYzsNCisJc3RydWN0IGRl
dmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCisJc3RydWN0IGljY19ub2RlICpub2RlOw0KKwlzdHJ1
Y3QgaWNjX29uZWNlbGxfZGF0YSAqZGF0YTsNCisJc3RydWN0IGljY19wcm92aWRlciAqcHJvdmlk
ZXI7DQorCXN0cnVjdCBtdGtfaWNjX25vZGUgKiptbm9kZXM7DQorCXNpemVfdCBudW1fbm9kZXMs
IGksIGo7DQorCWludCByZXQ7DQorDQorCW1hdGNoID0gb2ZfbWF0Y2hfbm9kZShlbWlfaWNjX29m
X21hdGNoLCBkZXYtPnBhcmVudC0+b2Zfbm9kZSk7DQorDQorCWlmICghbWF0Y2gpIHsNCisJCWRl
dl9lcnIoZGV2LCAiaW52YWxpZCBjb21wYXRpYmxlIHN0cmluZ1xuIik7DQorCQlyZXR1cm4gLUVO
T0RFVjsNCisJfQ0KKw0KKwlkZXNjID0gbWF0Y2gtPmRhdGE7DQorCW1ub2RlcyA9IGRlc2MtPm5v
ZGVzOw0KKwludW1fbm9kZXMgPSBkZXNjLT5udW1fbm9kZXM7DQorDQorCXByb3ZpZGVyID0gZGV2
bV9remFsbG9jKGRldiwgc2l6ZW9mKCpwcm92aWRlciksIEdGUF9LRVJORUwpOw0KKwlpZiAoIXBy
b3ZpZGVyKQ0KKwkJcmV0dXJuIC1FTk9NRU07DQorDQorCWRhdGEgPSBkZXZtX2t6YWxsb2MoZGV2
LCBzdHJ1Y3Rfc2l6ZShkYXRhLCBub2RlcywgbnVtX25vZGVzKSwNCisJCQkgICAgR0ZQX0tFUk5F
TCk7DQorCWlmICghZGF0YSkNCisJCXJldHVybiAtRU5PTUVNOw0KKw0KKwlwcm92aWRlci0+ZGV2
ID0gcGRldi0+ZGV2LnBhcmVudDsNCisJcHJvdmlkZXItPnNldCA9IGVtaV9pY2Nfc2V0Ow0KKwlw
cm92aWRlci0+YWdncmVnYXRlID0gZW1pX2ljY19hZ2dyZWdhdGU7DQorCXByb3ZpZGVyLT54bGF0
ZSA9IG9mX2ljY194bGF0ZV9vbmVjZWxsOw0KKwlJTklUX0xJU1RfSEVBRCgmcHJvdmlkZXItPm5v
ZGVzKTsNCisJcHJvdmlkZXItPmRhdGEgPSBkYXRhOw0KKw0KKwlyZXQgPSBpY2NfcHJvdmlkZXJf
YWRkKHByb3ZpZGVyKTsNCisJaWYgKHJldCkgew0KKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiZXJy
b3IgYWRkaW5nIGludGVyY29ubmVjdCBwcm92aWRlclxuIik7DQorCQlyZXR1cm4gcmV0Ow0KKwl9
DQorDQorCWZvciAoaSA9IDA7IGkgPCBudW1fbm9kZXM7IGkrKykgew0KKwkJbm9kZSA9IGljY19u
b2RlX2NyZWF0ZShtbm9kZXNbaV0tPmlkKTsNCisJCWlmIChJU19FUlIobm9kZSkpIHsNCisJCQly
ZXQgPSBQVFJfRVJSKG5vZGUpOw0KKwkJCWdvdG8gZXJyOw0KKwkJfQ0KKw0KKwkJbm9kZS0+bmFt
ZSA9IG1ub2Rlc1tpXS0+bmFtZTsNCisJCW5vZGUtPmRhdGEgPSBtbm9kZXNbaV07DQorCQlpY2Nf
bm9kZV9hZGQobm9kZSwgcHJvdmlkZXIpOw0KKw0KKwkJZm9yIChqID0gMDsgaiA8IG1ub2Rlc1tp
XS0+bnVtX2xpbmtzOyBqKyspDQorCQkJaWNjX2xpbmtfY3JlYXRlKG5vZGUsIG1ub2Rlc1tpXS0+
bGlua3Nbal0pOw0KKw0KKwkJZGF0YS0+bm9kZXNbaV0gPSBub2RlOw0KKwl9DQorCWRhdGEtPm51
bV9ub2RlcyA9IG51bV9ub2RlczsNCisNCisJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgcHJv
dmlkZXIpOw0KKw0KKwlyZXR1cm4gMDsNCitlcnI6DQorCWljY19ub2Rlc19yZW1vdmUocHJvdmlk
ZXIpOw0KKwlyZXR1cm4gcmV0Ow0KK30NCisNCitzdGF0aWMgaW50IGVtaV9pY2NfcmVtb3ZlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQorew0KKwlzdHJ1Y3QgaWNjX3Byb3ZpZGVyICpw
cm92aWRlciA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KKw0KKwlpY2Nfbm9kZXNfcmVt
b3ZlKHByb3ZpZGVyKTsNCisJcmV0dXJuIGljY19wcm92aWRlcl9kZWwocHJvdmlkZXIpOw0KK30N
CisNCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBlbWlfaWNjX2RyaXZlciA9IHsNCisJ
LnByb2JlID0gZW1pX2ljY19wcm9iZSwNCisJLnJlbW92ZSA9IGVtaV9pY2NfcmVtb3ZlLA0KKwku
ZHJpdmVyID0gew0KKwkJLm5hbWUgPSAibWVkaWF0ZWstZW1pLWljYyIsDQorCX0sDQorfTsNCisN
CitzdGF0aWMgaW50IF9faW5pdCBtdGtfZW1pX2ljY19pbml0KHZvaWQpDQorew0KKwlyZXR1cm4g
cGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZlbWlfaWNjX2RyaXZlcik7DQorfQ0KK3N1YnN5c19p
bml0Y2FsbChtdGtfZW1pX2ljY19pbml0KTsNCisNCitzdGF0aWMgdm9pZCBfX2V4aXQgbXRrX2Vt
aV9pY2NfZXhpdCh2b2lkKQ0KK3sNCisJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJmVtaV9p
Y2NfZHJpdmVyKTsNCit9DQorbW9kdWxlX2V4aXQobXRrX2VtaV9pY2NfZXhpdCk7DQorDQorTU9E
VUxFX0FVVEhPUigiSGVucnkgQ2hlbiA8aGVucnljLmNoZW5AbWVkaWF0ZWsuY29tPiIpOw0KK01P
RFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsNCi0tIA0KMS45LjENCg==

