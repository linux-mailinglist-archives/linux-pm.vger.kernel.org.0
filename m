Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E0E23DBB7
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 18:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgHFQaW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 12:30:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46223 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727800AbgHFQ24 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2020 12:28:56 -0400
X-UUID: 63ebca70441545afb7dbb3ce575d5f3a-20200806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JZ86xIMebilEvlp79Twszym4JnEpu5xLVQiKKFL0Rbg=;
        b=SFkWefrhHraW8b1UN/wdeW8EiGOXwnWSnplaDkfSw8Fp4l9sukuFxE8Q8x/lbah8GKDN4staOXWsT+gEiYC/7uocVZwGA5xle6ihYNm053YvDRpkisM7Q2nG11A3ycRZZZB4ZLRhicqx1ubCLohmvZv++O7nEQ7BicLnfQe1y/U=;
X-UUID: 63ebca70441545afb7dbb3ce575d5f3a-20200806
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 180744894; Thu, 06 Aug 2020 20:18:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 6 Aug 2020 20:18:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Aug 2020 20:18:43 +0800
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
Subject: [PATCH v1 1/2] cpufreq: mediatek-hw: Add support for Mediatek cpufreq HW driver
Date:   Thu, 6 Aug 2020 20:18:39 +0800
Message-ID: <1596716320-19811-2-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1596716320-19811-1-git-send-email-hector.yuan@mediatek.com>
References: <1596716320-19811-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 42A5787A7FDE4CFE2E60EF9A02322FB287087D54C7179A4681EB51728BEF576C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogIkhlY3Rvci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KDQpBZGQgTVQ2
Nzc5IGNwdWZyZXEgSFcgc3VwcG9ydC4NCg0KU2lnbmVkLW9mZi1ieTogSGVjdG9yLll1YW4gPGhl
Y3Rvci55dWFuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGFyY2gvYXJtNjQvY29uZmlncy9kZWZjb25m
aWcgICAgICAgICAgfCAgICAxICsNCiBkcml2ZXJzL2NwdWZyZXEvS2NvbmZpZy5hcm0gICAgICAg
ICAgIHwgICAxMSArKw0KIGRyaXZlcnMvY3B1ZnJlcS9NYWtlZmlsZSAgICAgICAgICAgICAgfCAg
ICAxICsNCiBkcml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS1ody5jIHwgIDI1NSArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiA0IGZpbGVzIGNoYW5nZWQsIDI2OCBpbnNl
cnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY3B1ZnJlcS9tZWRpYXRlay1j
cHVmcmVxLWh3LmMNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcg
Yi9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQppbmRleCA4ODNlOGJhLi44NjZhMWJmIDEw
MDY0NA0KLS0tIGEvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZw0KKysrIGIvYXJjaC9hcm02
NC9jb25maWdzL2RlZmNvbmZpZw0KQEAgLTg2LDYgKzg2LDcgQEAgQ09ORklHX0NQVUZSRVFfRFQ9
eQ0KIENPTkZJR19BQ1BJX0NQUENfQ1BVRlJFUT1tDQogQ09ORklHX0FSTV9BTExXSU5ORVJfU1VO
NTBJX0NQVUZSRVFfTlZNRU09bQ0KIENPTkZJR19BUk1fQVJNQURBXzM3WFhfQ1BVRlJFUT15DQor
Q09ORklHX0FSTV9NRURJQVRFS19DUFVGUkVRX0hXPW0NCiBDT05GSUdfQVJNX1NDUElfQ1BVRlJF
UT15DQogQ09ORklHX0FSTV9JTVhfQ1BVRlJFUV9EVD1tDQogQ09ORklHX0FSTV9RQ09NX0NQVUZS
RVFfTlZNRU09eQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9LY29uZmlnLmFybSBiL2Ry
aXZlcnMvY3B1ZnJlcS9LY29uZmlnLmFybQ0KaW5kZXggYzZjYmZjOC4uODFmMWNjMSAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9LY29uZmlnLmFybQ0KKysrIGIvZHJpdmVycy9jcHVmcmVx
L0tjb25maWcuYXJtDQpAQCAtMTIxLDYgKzEyMSwxNyBAQCBjb25maWcgQVJNX01FRElBVEVLX0NQ
VUZSRVENCiAJaGVscA0KIAkgIFRoaXMgYWRkcyB0aGUgQ1BVRnJlcSBkcml2ZXIgc3VwcG9ydCBm
b3IgTWVkaWFUZWsgU29Dcy4NCiANCitjb25maWcgQVJNX01FRElBVEVLX0NQVUZSRVFfSFcNCisJ
dHJpc3RhdGUgIk1lZGlhVGVrIENQVUZyZXEgSFcgZHJpdmVyIg0KKwlkZXBlbmRzIG9uIEFSQ0hf
TUVESUFURUsgfHwgQ09NUElMRV9URVNUDQorCWhlbHANCisJICBTdXBwb3J0IGZvciB0aGUgQ1BV
RnJlcSBIVyBkcml2ZXIuDQorCSAgU29tZSBNZWRpYVRlayBjaGlwc2V0cyBoYXZlIGEgSFcgZW5n
aW5lIHRvIG9mZmxvYWQgdGhlIHN0ZXBzDQorCSAgbmVjZXNzYXJ5IGZvciBjaGFuZ2luZyB0aGUg
ZnJlcXVlbmN5IG9mIHRoZSBDUFVzLiBGaXJtd2FyZSBsb2FkZWQNCisJICBpbiB0aGlzIGVuZ2lu
ZSBleHBvc2VzIGEgcHJvZ3JhbW1pbmcgaW50ZXJmYWNlIHRvIHRoZSBPUy4NCisJICBUaGUgZHJp
dmVyIGltcGxlbWVudHMgdGhlIGNwdWZyZXEgaW50ZXJmYWNlIGZvciB0aGlzIEhXIGVuZ2luZS4N
CisJICBTYXkgWSBpZiB5b3Ugd2FudCB0byBzdXBwb3J0IENQVUZyZXEgSFcuDQorDQogY29uZmln
IEFSTV9PTUFQMlBMVVNfQ1BVRlJFUQ0KIAlib29sICJUSSBPTUFQMisiDQogCWRlcGVuZHMgb24g
QVJDSF9PTUFQMlBMVVMNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvTWFrZWZpbGUgYi9k
cml2ZXJzL2NwdWZyZXEvTWFrZWZpbGUNCmluZGV4IGY2NjcwYzQuLmRjMWYzNzEgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2NwdWZyZXEvTWFrZWZpbGUNCisrKyBiL2RyaXZlcnMvY3B1ZnJlcS9NYWtl
ZmlsZQ0KQEAgLTU3LDYgKzU3LDcgQEAgb2JqLSQoQ09ORklHX0FSTV9JTVg2UV9DUFVGUkVRKQkJ
Kz0gaW14NnEtY3B1ZnJlcS5vDQogb2JqLSQoQ09ORklHX0FSTV9JTVhfQ1BVRlJFUV9EVCkJKz0g
aW14LWNwdWZyZXEtZHQubw0KIG9iai0kKENPTkZJR19BUk1fS0lSS1dPT0RfQ1BVRlJFUSkJKz0g
a2lya3dvb2QtY3B1ZnJlcS5vDQogb2JqLSQoQ09ORklHX0FSTV9NRURJQVRFS19DUFVGUkVRKQkr
PSBtZWRpYXRlay1jcHVmcmVxLm8NCitvYmotJChDT05GSUdfQVJNX01FRElBVEVLX0NQVUZSRVFf
SFcpCSs9IG1lZGlhdGVrLWNwdWZyZXEtaHcubw0KIG9iai0kKENPTkZJR19NQUNIX01WRUJVX1Y3
KQkJKz0gbXZlYnUtY3B1ZnJlcS5vDQogb2JqLSQoQ09ORklHX0FSTV9PTUFQMlBMVVNfQ1BVRlJF
USkJKz0gb21hcC1jcHVmcmVxLm8NCiBvYmotJChDT05GSUdfQVJNX1BYQTJ4eF9DUFVGUkVRKQkr
PSBweGEyeHgtY3B1ZnJlcS5vDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL21lZGlhdGVr
LWNwdWZyZXEtaHcuYyBiL2RyaXZlcnMvY3B1ZnJlcS9tZWRpYXRlay1jcHVmcmVxLWh3LmMNCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi45MjBjYzg3DQotLS0gL2Rldi9udWxs
DQorKysgYi9kcml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS1ody5jDQpAQCAtMCwwICsx
LDI1NSBAQA0KKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQorLyoNCisgKiBD
b3B5cmlnaHQgKGMpIDIwMTgsIFRoZSBMaW51eCBGb3VuZGF0aW9uLiBBbGwgcmlnaHRzIHJlc2Vy
dmVkLg0KKyAqLw0KKw0KKyNpbmNsdWRlIDxsaW51eC9iaXRmaWVsZC5oPg0KKyNpbmNsdWRlIDxs
aW51eC9jcHVmcmVxLmg+DQorI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4NCisjaW5jbHVkZSA8bGlu
dXgva2VybmVsLmg+DQorI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KKyNpbmNsdWRlIDxsaW51
eC9vZl9hZGRyZXNzLmg+DQorI2luY2x1ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+DQorI2luY2x1
ZGUgPGxpbnV4L3BtX29wcC5oPg0KKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQorDQorI2RlZmlu
ZSBMVVRfTUFYX0VOVFJJRVMJCQkzMlUNCisjZGVmaW5lIExVVF9GUkVRCQkJR0VOTUFTSygxMSwg
MCkNCisjZGVmaW5lIExVVF9WT0xUCQkJR0VOTUFTSygyOCwgMTIpDQorI2RlZmluZSBMVVRfUk9X
X1NJWkUJCQkweDQNCisNCisvKiBSZWdpc3RlciBvZmZzZXRzICovDQorI2RlZmluZSBSRUdfRU5B
QkxFCQkJMHg4NA0KKyNkZWZpbmUgUkVHX1BFUkZfU1RBVEUJCTB4ODgNCisNCitzdGF0aWMgc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqZ2xvYmFsX3BkZXY7DQorc3RhdGljIGludCBtdGtfY3B1ZnJl
cV9od190YXJnZXRfaW5kZXgoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3ksDQorCQkJCSAg
ICAgICB1bnNpZ25lZCBpbnQgaW5kZXgpDQorew0KKwl2b2lkIF9faW9tZW0gKnBlcmZfc3RhdGVf
cmVnID0gcG9saWN5LT5kcml2ZXJfZGF0YTsNCisJdW5zaWduZWQgbG9uZyBmcmVxID0gcG9saWN5
LT5mcmVxX3RhYmxlW2luZGV4XS5mcmVxdWVuY3k7DQorDQorCXdyaXRlbF9yZWxheGVkKGluZGV4
LCBwZXJmX3N0YXRlX3JlZyk7DQorCWFyY2hfc2V0X2ZyZXFfc2NhbGUocG9saWN5LT5yZWxhdGVk
X2NwdXMsIGZyZXEsDQorCQkJICAgIHBvbGljeS0+Y3B1aW5mby5tYXhfZnJlcSk7DQorCXJldHVy
biAwOw0KK30NCisNCitzdGF0aWMgdW5zaWduZWQgaW50IG10a19jcHVmcmVxX2h3X2dldCh1bnNp
Z25lZCBpbnQgY3B1KQ0KK3sNCisJdm9pZCBfX2lvbWVtICpwZXJmX3N0YXRlX3JlZzsNCisJc3Ry
dWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3k7DQorCXVuc2lnbmVkIGludCBpbmRleDsNCisNCisJ
cG9saWN5ID0gY3B1ZnJlcV9jcHVfZ2V0X3JhdyhjcHUpOw0KKwlpZiAoIXBvbGljeSkNCisJCXJl
dHVybiAwOw0KKw0KKwlwZXJmX3N0YXRlX3JlZyA9IHBvbGljeS0+ZHJpdmVyX2RhdGE7DQorDQor
CWluZGV4ID0gcmVhZGxfcmVsYXhlZChwZXJmX3N0YXRlX3JlZyk7DQorCWluZGV4ID0gbWluKGlu
ZGV4LCBMVVRfTUFYX0VOVFJJRVMgLSAxKTsNCisNCisJcmV0dXJuIHBvbGljeS0+ZnJlcV90YWJs
ZVtpbmRleF0uZnJlcXVlbmN5Ow0KK30NCisNCitzdGF0aWMgaW50IG10a19jcHVmcmVxX2h3X3Jl
YWRfbHV0KHN0cnVjdCBkZXZpY2UgKmNwdV9kZXYsDQorCQkJCSAgIHN0cnVjdCBjcHVmcmVxX3Bv
bGljeSAqcG9saWN5LA0KKwkJCQkgICB2b2lkIF9faW9tZW0gKmJhc2UpDQorew0KKwl1MzIgZGF0
YTsNCisJdTMyIGZyZXEsIHZvbHQsIHByZXZfZnJlcSA9IDA7DQorCWludCBpID0gMDsNCisJc3Ry
dWN0IGNwdWZyZXFfZnJlcXVlbmN5X3RhYmxlCSp0YWJsZTsNCisNCisJdGFibGUgPSBrY2FsbG9j
KExVVF9NQVhfRU5UUklFUyArIDEsIHNpemVvZigqdGFibGUpLCBHRlBfS0VSTkVMKTsNCisJaWYg
KCF0YWJsZSkNCisJCXJldHVybiAtRU5PTUVNOw0KKw0KKwlmb3IgKGkgPSAwOyBpIDwgTFVUX01B
WF9FTlRSSUVTOyBpKyspIHsNCisJCWRhdGEgPSByZWFkbF9yZWxheGVkKGJhc2UgKyAoaSAqIExV
VF9ST1dfU0laRSkpOw0KKwkJZnJlcSA9IEZJRUxEX0dFVChMVVRfRlJFUSwgZGF0YSkgKiAxMDAw
Ow0KKwkJdm9sdCA9IEZJRUxEX0dFVChMVVRfVk9MVCwgZGF0YSk7DQorCQlpZiAoZnJlcSAhPSBw
cmV2X2ZyZXEpIHsNCisJCQl0YWJsZVtpXS5mcmVxdWVuY3kgPSBmcmVxOw0KKwkJCWRldl9wbV9v
cHBfYWRkKGNwdV9kZXYsIGZyZXEgKiAxMDAwLCB2b2x0KTsNCisJCQlkZXZfZGJnKGNwdV9kZXYs
ICJpbmRleD0lZCBmcmVxPSVkLCB2b2x0PSVkXG4iLCBpLA0KKwkJCQlmcmVxLCB2b2x0KTsNCisJ
CX0gZWxzZSB7DQorCQkJYnJlYWs7DQorCQl9DQorCQlwcmV2X2ZyZXEgPSBmcmVxOw0KKwl9DQor
CXRhYmxlW2ldLmZyZXF1ZW5jeSA9IENQVUZSRVFfVEFCTEVfRU5EOw0KKwlwb2xpY3ktPmZyZXFf
dGFibGUgPSB0YWJsZTsNCisJZGV2X3BtX29wcF9zZXRfc2hhcmluZ19jcHVzKGNwdV9kZXYsIHBv
bGljeS0+Y3B1cyk7DQorDQorCXJldHVybiAwOw0KK30NCisNCitzdGF0aWMgdm9pZCBtdGtfZ2V0
X3JlbGF0ZWRfY3B1cyhpbnQgaW5kZXgsIHN0cnVjdCBjcHVtYXNrICptKQ0KK3sNCisJc3RydWN0
IGRldmljZV9ub2RlICpjcHVfbnA7DQorCXN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgYXJnczsNCisJ
aW50IGNwdSwgcmV0Ow0KKw0KKwlmb3JfZWFjaF9wb3NzaWJsZV9jcHUoY3B1KSB7DQorCQljcHVf
bnAgPSBvZl9jcHVfZGV2aWNlX25vZGVfZ2V0KGNwdSk7DQorCQlpZiAoIWNwdV9ucCkNCisJCQlj
b250aW51ZTsNCisNCisJCXJldCA9IG9mX3BhcnNlX3BoYW5kbGVfd2l0aF9hcmdzKGNwdV9ucCwg
Im10ayxmcmVxLWRvbWFpbiIsDQorCQkJCQkJICIjZnJlcS1kb21haW4tY2VsbHMiLCAwLA0KKwkJ
CQkJCSAmYXJncyk7DQorCQlvZl9ub2RlX3B1dChjcHVfbnApOw0KKwkJaWYgKHJldCA8IDApDQor
CQkJY29udGludWU7DQorDQorCQlpZiAoaW5kZXggPT0gYXJncy5hcmdzWzBdKQ0KKwkJCWNwdW1h
c2tfc2V0X2NwdShjcHUsIG0pOw0KKwl9DQorfQ0KKw0KK3N0YXRpYyBpbnQgbXRrX2NwdWZyZXFf
aHdfY3B1X2luaXQoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpDQorew0KKwlzdHJ1Y3Qg
ZGV2aWNlICpkZXYgPSAmZ2xvYmFsX3BkZXYtPmRldjsNCisJc3RydWN0IG9mX3BoYW5kbGVfYXJn
cyBhcmdzOw0KKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKmNwdV9ucDsNCisJc3RydWN0IGRldmljZSAq
Y3B1X2RldjsNCisJc3RydWN0IHJlc291cmNlICpyZXM7DQorCXZvaWQgX19pb21lbSAqYmFzZTsN
CisJaW50IHJldCwgaW5kZXg7DQorDQorCWNwdV9kZXYgPSBnZXRfY3B1X2RldmljZShwb2xpY3kt
PmNwdSk7DQorCWlmICghY3B1X2Rldikgew0KKwkJcHJfZXJyKCIlczogZmFpbGVkIHRvIGdldCBj
cHUlZCBkZXZpY2VcbiIsIF9fZnVuY19fLA0KKwkJICAgICAgIHBvbGljeS0+Y3B1KTsNCisJCXJl
dHVybiAtRU5PREVWOw0KKwl9DQorDQorCWNwdV9ucCA9IG9mX2NwdV9kZXZpY2Vfbm9kZV9nZXQo
cG9saWN5LT5jcHUpOw0KKwlpZiAoIWNwdV9ucCkNCisJCXJldHVybiAtRUlOVkFMOw0KKw0KKwly
ZXQgPSBvZl9wYXJzZV9waGFuZGxlX3dpdGhfYXJncyhjcHVfbnAsICJtdGssZnJlcS1kb21haW4i
LA0KKwkJCQkJICIjZnJlcS1kb21haW4tY2VsbHMiLCAwLCAmYXJncyk7DQorCW9mX25vZGVfcHV0
KGNwdV9ucCk7DQorCWlmIChyZXQpDQorCQlyZXR1cm4gcmV0Ow0KKw0KKwlpbmRleCA9IGFyZ3Mu
YXJnc1swXTsNCisJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKGdsb2JhbF9wZGV2LCBJT1JF
U09VUkNFX01FTSwgaW5kZXgpOw0KKwlpZiAoIXJlcykNCisJCXJldHVybiAtRU5PREVWOw0KKwli
YXNlID0gZGV2bV9pb3JlbWFwKGRldiwgcmVzLT5zdGFydCwgcmVzb3VyY2Vfc2l6ZShyZXMpKTsN
CisJaWYgKCFiYXNlKQ0KKwkJcmV0dXJuIC1FTk9NRU07DQorDQorCW10a19nZXRfcmVsYXRlZF9j
cHVzKGluZGV4LCBwb2xpY3ktPmNwdXMpOw0KKwlpZiAoIWNwdW1hc2tfd2VpZ2h0KHBvbGljeS0+
Y3B1cykpIHsNCisJCWRldl9lcnIoZGV2LCAiRG9tYWluLSVkIGZhaWxlZCB0byBnZXQgcmVsYXRl
ZCBDUFVzXG4iLCBpbmRleCk7DQorCQlyZXQgPSAtRU5PRU5UOw0KKwkJZ290byBlcnJvcjsNCisJ
fQ0KKw0KKwlwb2xpY3ktPmRyaXZlcl9kYXRhID0gYmFzZSArIFJFR19QRVJGX1NUQVRFOw0KKwly
ZXQgPSBtdGtfY3B1ZnJlcV9od19yZWFkX2x1dChjcHVfZGV2LCBwb2xpY3ksIGJhc2UpOw0KKwlp
ZiAocmV0KSB7DQorCQlkZXZfZXJyKGRldiwgIkRvbWFpbi0lZCBmYWlsZWQgdG8gcmVhZCBMVVRc
biIsIGluZGV4KTsNCisJCWdvdG8gZXJyb3I7DQorCX0NCisNCisJcmV0ID0gZGV2X3BtX29wcF9n
ZXRfb3BwX2NvdW50KGNwdV9kZXYpOw0KKwlpZiAocmV0IDw9IDApIHsNCisJCWRldl9lcnIoY3B1
X2RldiwgIkZhaWxlZCB0byBhZGQgT1BQc1xuIik7DQorCQlyZXQgPSAtRU5PREVWOw0KKwkJZ290
byBlcnJvcjsNCisJfQ0KKw0KKwlkZXZfcG1fb3BwX29mX3JlZ2lzdGVyX2VtKHBvbGljeS0+Y3B1
cyk7DQorDQorCS8qIEhXIHNob3VsZCBiZSBpbiBlbmFibGVkIHN0YXRlIHRvIHByb2NlZWQgbm93
ICovDQorCXdyaXRlbF9yZWxheGVkKDB4MSwgKGJhc2UgKyBSRUdfRU5BQkxFKSk7DQorCXJldHVy
biAwOw0KK2Vycm9yOg0KKwlkZXZtX2lvdW5tYXAoZGV2LCBiYXNlKTsNCisJcmV0dXJuIHJldDsN
Cit9DQorDQorc3RhdGljIGludCBtdGtfY3B1ZnJlcV9od19jcHVfZXhpdChzdHJ1Y3QgY3B1ZnJl
cV9wb2xpY3kgKnBvbGljeSkNCit7DQorCXN0cnVjdCBkZXZpY2UgKmNwdV9kZXYgPSBnZXRfY3B1
X2RldmljZShwb2xpY3ktPmNwdSk7DQorCXZvaWQgX19pb21lbSAqYmFzZSA9IHBvbGljeS0+ZHJp
dmVyX2RhdGEgLSBSRUdfUEVSRl9TVEFURTsNCisNCisJZGV2X3BtX29wcF9yZW1vdmVfYWxsX2R5
bmFtaWMoY3B1X2Rldik7DQorCWtmcmVlKHBvbGljeS0+ZnJlcV90YWJsZSk7DQorCWRldm1faW91
bm1hcCgmZ2xvYmFsX3BkZXYtPmRldiwgYmFzZSk7DQorDQorCXJldHVybiAwOw0KK30NCisNCitz
dGF0aWMgc3RydWN0IGZyZXFfYXR0ciAqbXRrX2NwdWZyZXFfaHdfYXR0cltdID0gew0KKwkmY3B1
ZnJlcV9mcmVxX2F0dHJfc2NhbGluZ19hdmFpbGFibGVfZnJlcXMsDQorCU5VTEwNCit9Ow0KKw0K
K3N0YXRpYyBzdHJ1Y3QgY3B1ZnJlcV9kcml2ZXIgY3B1ZnJlcV9tdGtfaHdfZHJpdmVyID0gew0K
KwkuZmxhZ3MJCT0gQ1BVRlJFUV9TVElDS1kgfCBDUFVGUkVRX05FRURfSU5JVElBTF9GUkVRX0NI
RUNLIHwNCisJCQkgIENQVUZSRVFfSEFWRV9HT1ZFUk5PUl9QRVJfUE9MSUNZLA0KKwkudmVyaWZ5
CQk9IGNwdWZyZXFfZ2VuZXJpY19mcmVxdWVuY3lfdGFibGVfdmVyaWZ5LA0KKwkudGFyZ2V0X2lu
ZGV4CT0gbXRrX2NwdWZyZXFfaHdfdGFyZ2V0X2luZGV4LA0KKwkuZ2V0CQk9IG10a19jcHVmcmVx
X2h3X2dldCwNCisJLmluaXQJCT0gbXRrX2NwdWZyZXFfaHdfY3B1X2luaXQsDQorCS5leGl0CQk9
IG10a19jcHVmcmVxX2h3X2NwdV9leGl0LA0KKwkubmFtZQkJPSAibXRrLWNwdWZyZXEtaHciLA0K
KwkuYXR0cgkJPSBtdGtfY3B1ZnJlcV9od19hdHRyLA0KK307DQorDQorc3RhdGljIGludCBtdGtf
Y3B1ZnJlcV9od19kcml2ZXJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCit7
DQorCWludCByZXQ7DQorDQorCWdsb2JhbF9wZGV2ID0gcGRldjsNCisJcmV0ID0gY3B1ZnJlcV9y
ZWdpc3Rlcl9kcml2ZXIoJmNwdWZyZXFfbXRrX2h3X2RyaXZlcik7DQorCWlmIChyZXQpDQorCQlk
ZXZfZXJyKCZwZGV2LT5kZXYsICJDUFVGcmVxIEhXIGRyaXZlciBmYWlsZWQgdG8gcmVnaXN0ZXJc
biIpOw0KKwllbHNlDQorCQlkZXZfZGJnKCZwZGV2LT5kZXYsICJtdGsgQ1BVRnJlcSBIVyBkcml2
ZXIgaW5pdGlhbGl6ZWRcbiIpOw0KKw0KKwlyZXR1cm4gcmV0Ow0KK30NCisNCitzdGF0aWMgaW50
IG10a19jcHVmcmVxX2h3X2RyaXZlcl9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCit7DQorCXJldHVybiBjcHVmcmVxX3VucmVnaXN0ZXJfZHJpdmVyKCZjcHVmcmVxX210a19o
d19kcml2ZXIpOw0KK30NCisNCitzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtf
Y3B1ZnJlcV9od19tYXRjaFtdID0gew0KKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLGNwdWZy
ZXEtaHciIH0sDQorCXt9DQorfTsNCitNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBtdGtfY3B1ZnJl
cV9od19tYXRjaCk7DQorDQorc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgbXRrX2NwdWZy
ZXFfaHdfZHJpdmVyID0gew0KKwkucHJvYmUgPSBtdGtfY3B1ZnJlcV9od19kcml2ZXJfcHJvYmUs
DQorCS5yZW1vdmUgPSBtdGtfY3B1ZnJlcV9od19kcml2ZXJfcmVtb3ZlLA0KKwkuZHJpdmVyID0g
ew0KKwkJLm5hbWUgPSAibXRrLWNwdWZyZXEtaHciLA0KKwkJLm9mX21hdGNoX3RhYmxlID0gbXRr
X2NwdWZyZXFfaHdfbWF0Y2gsDQorCX0sDQorfTsNCisNCitzdGF0aWMgaW50IF9faW5pdCBtdGtf
Y3B1ZnJlcV9od19pbml0KHZvaWQpDQorew0KKwlyZXR1cm4gcGxhdGZvcm1fZHJpdmVyX3JlZ2lz
dGVyKCZtdGtfY3B1ZnJlcV9od19kcml2ZXIpOw0KK30NCitwb3N0Y29yZV9pbml0Y2FsbChtdGtf
Y3B1ZnJlcV9od19pbml0KTsNCisNCitzdGF0aWMgdm9pZCBfX2V4aXQgbXRrX2NwdWZyZXFfaHdf
ZXhpdCh2b2lkKQ0KK3sNCisJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJm10a19jcHVmcmVx
X2h3X2RyaXZlcik7DQorfQ0KK21vZHVsZV9leGl0KG10a19jcHVmcmVxX2h3X2V4aXQpOw0KKw0K
K01PRFVMRV9ERVNDUklQVElPTigibXRrIENQVUZSRVEgSFcgRHJpdmVyIik7DQorTU9EVUxFX0xJ
Q0VOU0UoIkdQTCB2MiIpOw0KLS0gDQoxLjcuOS41DQo=

