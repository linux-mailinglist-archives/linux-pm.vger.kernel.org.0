Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D4218B093
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 10:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCSJzq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 05:55:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:8194 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbgCSJzp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 05:55:45 -0400
X-UUID: 55f4458e03ba4043a76a6fc26a4fc857-20200319
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=EgjJ4/ozN7amIJ2TNqfWpzKzRvybv6gnG75eeEAlrTA=;
        b=pgSfGwgnj2B5MhSir/M5CIQLVSPdtjRhPM+ER3WXGz1nh0obqRjdZORZjJgg7I/hugBtLQUwfWve4kKWkoXJnmFBOqriXPfwyCrcfWSFD1kmLE0Sl4NXbrDg0gYe5D176mteRuV2G2JfL0+nUJ/XZr+NM+GaEieew2WHGAQbu48=;
X-UUID: 55f4458e03ba4043a76a6fc26a4fc857-20200319
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <henry.yen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1246530725; Thu, 19 Mar 2020 17:55:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 19 Mar 2020 17:52:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 19 Mar 2020 17:52:33 +0800
From:   Henry Yen <henry.yen@mediatek.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Steven Liu <steven.liu@mediatek.com>,
        Henry Yen <henry.yen@mediatek.com>,
        Michael Kao <michael.kao@mediatek.com>
Subject: [PATCH 2/2] thermal: mediatek: add tsensor support for MT7622 SoC
Date:   Thu, 19 Mar 2020 17:54:53 +0800
Message-ID: <1584611693-3553-3-git-send-email-henry.yen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584611693-3553-1-git-send-email-henry.yen@mediatek.com>
References: <1584611693-3553-1-git-send-email-henry.yen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3BE1D2BE5077A5896A53555467BB7CAAAF41036944F071EE7B81B4AA7364ADF02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIHRoZSBzdXBwb3J0IGZvciB2ZXJzaW9uIDIgdGhlcm1hbCBzeXN0ZW0o
ZS5nLiwgTVQ3NjIyIFNvQykuDQpUaGUgY2hhbmdlcyBpbmNsdWRlIHRoZSB3YXkgb2YgcmVhZGlu
ZyBjYWxpYnJhdGlvbiBkYXRhLCB0aGUgd2F5IG9mDQpjb252ZXJ0aW5nIHRlbXBlcmF0dXJlIGFu
ZCBoYXJkd2FyZSBpbml0aWFsaXphdGlvbiBzcGVjaWZpYyBmb3IgdmVyc2lvbiAyDQp0aGVybWFs
IHN5c3RlbS4NCg0KU2lnbmVkLW9mZi1ieTogSGVucnkgWWVuIDxoZW5yeS55ZW5AbWVkaWF0ZWsu
Y29tPg0KLS0tDQogZHJpdmVycy90aGVybWFsL210a190aGVybWFsLmMgfCAxMDAgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA5OCBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL210a190
aGVybWFsLmMgYi9kcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYw0KaW5kZXggMTNlMTdjMzFi
YTNiLi45ZTY4MDdmNmFiZDQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJt
YWwuYw0KKysrIGIvZHJpdmVycy90aGVybWFsL210a190aGVybWFsLmMNCkBAIC0zOCw2ICszOCw3
IEBADQogI2RlZmluZSBURU1QX01PTklERVQwCQkweDAxNA0KICNkZWZpbmUgVEVNUF9NT05JREVU
MQkJMHgwMTgNCiAjZGVmaW5lIFRFTVBfTVNSQ1RMMAkJMHgwMzgNCisjZGVmaW5lIFRFTVBfTVNS
Q1RMMQkJMHgwM2MNCiAjZGVmaW5lIFRFTVBfQUhCUE9MTAkJMHgwNDANCiAjZGVmaW5lIFRFTVBf
QUhCVE8JCTB4MDQ0DQogI2RlZmluZSBURU1QX0FEQ1BOUDAJCTB4MDQ4DQpAQCAtMTMzLDYgKzEz
NCwyMCBAQA0KICNkZWZpbmUgQ0FMSUJfQlVGMF9PX1NMT1BFX1NJR05fVjEoeCkJKCgoeCkgPj4g
NykgJiAweDEpDQogI2RlZmluZSBDQUxJQl9CVUYxX0lEX1YxKHgpCQkoKCh4KSA+PiA5KSAmIDB4
MSkNCiANCisvKg0KKyAqIExheW91dCBvZiB0aGUgZnVzZXMgcHJvdmlkaW5nIHRoZSBjYWxpYnJh
dGlvbiBkYXRhDQorICogVGhlc2UgbWFjcm9zIGNvdWxkIGJlIHVzZWQgZm9yIE1UNzYyMi4NCisg
Ki8NCisjZGVmaW5lIENBTElCX0JVRjBfQURDX09FX1YyKHgpCQkoKCh4KSA+PiAyMikgJiAweDNm
ZikNCisjZGVmaW5lIENBTElCX0JVRjBfQURDX0dFX1YyKHgpCQkoKCh4KSA+PiAxMikgJiAweDNm
ZikNCisjZGVmaW5lIENBTElCX0JVRjBfREVHQ19DQUxJX1YyKHgpCSgoKHgpID4+IDYpICYgMHgz
ZikNCisjZGVmaW5lIENBTElCX0JVRjBfT19TTE9QRV9WMih4KQkoKCh4KSA+PiAwKSAmIDB4M2Yp
DQorI2RlZmluZSBDQUxJQl9CVUYxX1ZUU19UUzFfVjIoeCkJKCgoeCkgPj4gMjMpICYgMHgxZmYp
DQorI2RlZmluZSBDQUxJQl9CVUYxX1ZUU19UUzJfVjIoeCkJKCgoeCkgPj4gMTQpICYgMHgxZmYp
DQorI2RlZmluZSBDQUxJQl9CVUYxX1ZUU19UU0FCQl9WMih4KQkoKCh4KSA+PiA1KSAmIDB4MWZm
KQ0KKyNkZWZpbmUgQ0FMSUJfQlVGMV9WQUxJRF9WMih4KQkJKCgoeCkgPj4gNCkgJiAweDEpDQor
I2RlZmluZSBDQUxJQl9CVUYxX09fU0xPUEVfU0lHTl9WMih4KQkoKCh4KSA+PiAzKSAmIDB4MSkN
CisNCiBlbnVtIHsNCiAJVlRTMSwNCiAJVlRTMiwNCkBAIC0yNjYsOCArMjgxLDEwIEBAIHN0cnVj
dCBtdGtfdGhlcm1hbCB7DQogDQogCS8qIENhbGlicmF0aW9uIHZhbHVlcyAqLw0KIAlzMzIgYWRj
X2dlOw0KKwlzMzIgYWRjX29lOw0KIAlzMzIgZGVnY19jYWxpOw0KIAlzMzIgb19zbG9wZTsNCisJ
czMyIG9fc2xvcGVfc2lnbjsNCiAJczMyIHZ0c1tNQVhfTlVNX1ZUU107DQogDQogCWNvbnN0IHN0
cnVjdCBtdGtfdGhlcm1hbF9kYXRhICpjb25mOw0KQEAgLTM2Nyw3ICszODQsOSBAQCBzdGF0aWMg
Y29uc3QgaW50IG10NzYyMl92dHNfaW5kZXhbTVQ3NjIyX05VTV9TRU5TT1JTXSA9IHsgVlRTMSB9
Ow0KIHN0YXRpYyBjb25zdCBpbnQgbXQ3NjIyX3RjX29mZnNldFtNVDc2MjJfTlVNX0NPTlRST0xM
RVJdID0geyAweDAsIH07DQogDQogc3RhdGljIGludCBtdGtfdGhlcm1hbF9leHRyYWN0X2VmdXNl
X3YxKHN0cnVjdCBtdGtfdGhlcm1hbCAqbXQsIHUzMiAqYnVmKTsNCitzdGF0aWMgaW50IG10a190
aGVybWFsX2V4dHJhY3RfZWZ1c2VfdjIoc3RydWN0IG10a190aGVybWFsICptdCwgdTMyICpidWYp
Ow0KIHN0YXRpYyBpbnQgcmF3X3RvX21jZWxzaXVzX3YxKHN0cnVjdCBtdGtfdGhlcm1hbCAqbXQs
IGludCBzZW5zbm8sIHMzMiByYXcpOw0KK3N0YXRpYyBpbnQgcmF3X3RvX21jZWxzaXVzX3YyKHN0
cnVjdCBtdGtfdGhlcm1hbCAqbXQsIGludCBzZW5zbm8sIHMzMiByYXcpOw0KIA0KIC8qDQogICog
VGhlIE1UODE3MyB0aGVybWFsIGNvbnRyb2xsZXIgaGFzIGZvdXIgYmFua3MuIEVhY2ggYmFuayBj
YW4gcmVhZCB1cCB0bw0KQEAgLTUwMyw4ICs1MjIsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10
a190aGVybWFsX2RhdGEgbXQ3NjIyX3RoZXJtYWxfZGF0YSA9IHsNCiAJLmFkY3BucCA9IG10NzYy
Ml9hZGNwbnAsDQogCS5zZW5zb3JfbXV4X3ZhbHVlcyA9IG10NzYyMl9tdXhfdmFsdWVzLA0KIAku
dmVyc2lvbiA9IE1US19USEVSTUFMX1YyLA0KLQkuZXh0cmFjdCA9IG10a190aGVybWFsX2V4dHJh
Y3RfZWZ1c2VfdjEsDQotCS5jb252ZXJ0ID0gcmF3X3RvX21jZWxzaXVzX3YxLA0KKwkuZXh0cmFj
dCA9IG10a190aGVybWFsX2V4dHJhY3RfZWZ1c2VfdjIsDQorCS5jb252ZXJ0ID0gcmF3X3RvX21j
ZWxzaXVzX3YyLA0KIH07DQogDQogLyoNCkBAIC01NjYsNiArNTg1LDM2IEBAIHN0YXRpYyBpbnQg
cmF3X3RvX21jZWxzaXVzX3YxKHN0cnVjdCBtdGtfdGhlcm1hbCAqbXQsIGludCBzZW5zbm8sIHMz
MiByYXcpDQogCXJldHVybiBtdC0+ZGVnY19jYWxpICogNTAwIC0gdG1wOw0KIH0NCiANCitzdGF0
aWMgaW50IHJhd190b19tY2Vsc2l1c192MihzdHJ1Y3QgbXRrX3RoZXJtYWwgKm10LCBpbnQgc2Vu
c25vLCBzMzIgcmF3KQ0KK3sNCisJczMyIGZvcm1hdF8xID0gMDsNCisJczMyIGZvcm1hdF8yID0g
MDsNCisJczMyIGdfb2UgPSAxOw0KKwlzMzIgZ19nYWluID0gMTsNCisJczMyIGdfeF9yb29tdCA9
IDA7DQorCXMzMiB0bXAgPSAwOw0KKw0KKwlpZiAocmF3ID09IDApDQorCQlyZXR1cm4gMDsNCisN
CisJcmF3ICY9IDB4ZmZmOw0KKwlnX2dhaW4gPSAxMDAwMCArICgoKG10LT5hZGNfZ2UgLSA1MTIp
ICogMTAwMDApID4+IDEyKTsNCisJZ19vZSA9IG10LT5hZGNfb2UgLSA1MTI7DQorCWZvcm1hdF8x
ID0gbXQtPnZ0c1tWVFMyXSArIDMxMDUgLSBnX29lOw0KKwlmb3JtYXRfMiA9IChtdC0+ZGVnY19j
YWxpICogMTApID4+IDE7DQorCWdfeF9yb29tdCA9ICgoKGZvcm1hdF8xICogMTAwMDApID4+IDEy
KSAqIDEwMDAwKSAvIGdfZ2FpbjsNCisNCisJdG1wID0gKCgoKChyYXcgLSBnX29lKSAqIDEwMDAw
KSA+PiAxMikgKiAxMDAwMCkgLyBnX2dhaW4pIC0gZ194X3Jvb210Ow0KKwl0bXAgPSB0bXAgKiAx
MCAqIDEwMCAvIDExOw0KKw0KKwlpZiAobXQtPm9fc2xvcGVfc2lnbiA9PSAwKQ0KKwkJdG1wID0g
dG1wIC8gKDE2NSAtIG10LT5vX3Nsb3BlKTsNCisJZWxzZQ0KKwkJdG1wID0gdG1wIC8gKDE2NSAr
IG10LT5vX3Nsb3BlKTsNCisNCisJcmV0dXJuIChmb3JtYXRfMiAtIHRtcCkgKiAxMDA7DQorfQ0K
Kw0KIC8qKg0KICAqIG10a190aGVybWFsX2dldF9iYW5rIC0gZ2V0IGJhbmsNCiAgKiBAYmFuazoJ
VGhlIGJhbmsNCkBAIC04MzEsNiArODgwLDIzIEBAIHN0YXRpYyBpbnQgbXRrX3RoZXJtYWxfZXh0
cmFjdF9lZnVzZV92MShzdHJ1Y3QgbXRrX3RoZXJtYWwgKm10LCB1MzIgKmJ1ZikNCiAJcmV0dXJu
IDA7DQogfQ0KIA0KK3N0YXRpYyBpbnQgbXRrX3RoZXJtYWxfZXh0cmFjdF9lZnVzZV92MihzdHJ1
Y3QgbXRrX3RoZXJtYWwgKm10LCB1MzIgKmJ1ZikNCit7DQorCWlmICghQ0FMSUJfQlVGMV9WQUxJ
RF9WMihidWZbMV0pKQ0KKwkJcmV0dXJuIC1FSU5WQUw7DQorDQorCW10LT5hZGNfb2UgPSBDQUxJ
Ql9CVUYwX0FEQ19PRV9WMihidWZbMF0pOw0KKwltdC0+YWRjX2dlID0gQ0FMSUJfQlVGMF9BRENf
R0VfVjIoYnVmWzBdKTsNCisJbXQtPmRlZ2NfY2FsaSA9IENBTElCX0JVRjBfREVHQ19DQUxJX1Yy
KGJ1ZlswXSk7DQorCW10LT5vX3Nsb3BlID0gQ0FMSUJfQlVGMF9PX1NMT1BFX1YyKGJ1ZlswXSk7
DQorCW10LT52dHNbVlRTMV0gPSBDQUxJQl9CVUYxX1ZUU19UUzFfVjIoYnVmWzFdKTsNCisJbXQt
PnZ0c1tWVFMyXSA9IENBTElCX0JVRjFfVlRTX1RTMl9WMihidWZbMV0pOw0KKwltdC0+dnRzW1ZU
U0FCQl0gPSBDQUxJQl9CVUYxX1ZUU19UU0FCQl9WMihidWZbMV0pOw0KKwltdC0+b19zbG9wZV9z
aWduID0gQ0FMSUJfQlVGMV9PX1NMT1BFX1NJR05fVjIoYnVmWzFdKTsNCisNCisJcmV0dXJuIDA7
DQorfQ0KKw0KIHN0YXRpYyBpbnQgbXRrX3RoZXJtYWxfZ2V0X2NhbGlicmF0aW9uX2RhdGEoc3Ry
dWN0IGRldmljZSAqZGV2LA0KIAkJCQkJICAgIHN0cnVjdCBtdGtfdGhlcm1hbCAqbXQpDQogew0K
QEAgLTkwMCw2ICs5NjYsMjggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRr
X3RoZXJtYWxfb2ZfbWF0Y2hbXSA9IHsNCiB9Ow0KIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG10
a190aGVybWFsX29mX21hdGNoKTsNCiANCitzdGF0aWMgdm9pZCBtdGtfdGhlcm1hbF90dXJuX29u
X2J1ZmZlcih2b2lkIF9faW9tZW0gKmFwbWl4ZWRfYmFzZSkNCit7DQorCWludCB0bXA7DQorDQor
CXRtcCA9IHJlYWRsKGFwbWl4ZWRfYmFzZSArIEFQTUlYRURfU1lTX1RTX0NPTjEpOw0KKwl0bXAg
Jj0gfigweDM3KTsNCisJdG1wIHw9IDB4MTsNCisJd3JpdGVsKHRtcCwgYXBtaXhlZF9iYXNlICsg
QVBNSVhFRF9TWVNfVFNfQ09OMSk7DQorCXVkZWxheSgyMDApOw0KK30NCisNCitzdGF0aWMgdm9p
ZCBtdGtfdGhlcm1hbF9yZWxlYXNlX3BlcmlvZGljX3RzKHN0cnVjdCBtdGtfdGhlcm1hbCAqbXQs
DQorCQkJCQkgICAgdm9pZCBfX2lvbWVtICphdXhhZGNfYmFzZSkNCit7DQorCWludCB0bXA7DQor
DQorCXdyaXRlbCgweDgwMCwgYXV4YWRjX2Jhc2UgKyBBVVhBRENfQ09OMV9TRVRfVik7DQorCXdy
aXRlbCgweDEsIG10LT50aGVybWFsX2Jhc2UgKyBURU1QX01PTkNUTDApOw0KKwl0bXAgPSByZWFk
bChtdC0+dGhlcm1hbF9iYXNlICsgVEVNUF9NU1JDVEwxKTsNCisJd3JpdGVsKCh0bXAgJiAofjB4
MTBlKSksIG10LT50aGVybWFsX2Jhc2UgKyBURU1QX01TUkNUTDEpOw0KK30NCisNCiBzdGF0aWMg
aW50IG10a190aGVybWFsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogew0K
IAlpbnQgcmV0LCBpLCBjdHJsX2lkOw0KQEAgLTkwOCw2ICs5OTYsNyBAQCBzdGF0aWMgaW50IG10
a190aGVybWFsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCXN0cnVjdCBy
ZXNvdXJjZSAqcmVzOw0KIAl1NjQgYXV4YWRjX3BoeXNfYmFzZSwgYXBtaXhlZF9waHlzX2Jhc2U7
DQogCXN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp0emRldjsNCisJdm9pZCBfX2lvbWVtICph
cG1peGVkX2Jhc2UsICphdXhhZGNfYmFzZTsNCiANCiAJbXQgPSBkZXZtX2t6YWxsb2MoJnBkZXYt
PmRldiwgc2l6ZW9mKCptdCksIEdGUF9LRVJORUwpOw0KIAlpZiAoIW10KQ0KQEAgLTk0Miw2ICsx
MDMxLDcgQEAgc3RhdGljIGludCBtdGtfdGhlcm1hbF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KIAkJcmV0dXJuIC1FTk9ERVY7DQogCX0NCiANCisJYXV4YWRjX2Jhc2UgPSBv
Zl9pb21hcChhdXhhZGMsIDApOw0KIAlhdXhhZGNfcGh5c19iYXNlID0gb2ZfZ2V0X3BoeXNfYmFz
ZShhdXhhZGMpOw0KIA0KIAlvZl9ub2RlX3B1dChhdXhhZGMpOw0KQEAgLTk1Nyw2ICsxMDQ3LDcg
QEAgc3RhdGljIGludCBtdGtfdGhlcm1hbF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KIAkJcmV0dXJuIC1FTk9ERVY7DQogCX0NCiANCisJYXBtaXhlZF9iYXNlID0gb2ZfaW9t
YXAoYXBtaXhlZHN5cywgMCk7DQogCWFwbWl4ZWRfcGh5c19iYXNlID0gb2ZfZ2V0X3BoeXNfYmFz
ZShhcG1peGVkc3lzKTsNCiANCiAJb2Zfbm9kZV9wdXQoYXBtaXhlZHN5cyk7DQpAQCAtOTgyLDYg
KzEwNzMsMTEgQEAgc3RhdGljIGludCBtdGtfdGhlcm1hbF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KIAkJZ290byBlcnJfZGlzYWJsZV9jbGtfYXV4YWRjOw0KIAl9DQogDQor
CWlmIChtdC0+Y29uZi0+dmVyc2lvbiA9PSBNVEtfVEhFUk1BTF9WMikgew0KKwkJbXRrX3RoZXJt
YWxfdHVybl9vbl9idWZmZXIoYXBtaXhlZF9iYXNlKTsNCisJCW10a190aGVybWFsX3JlbGVhc2Vf
cGVyaW9kaWNfdHMobXQsIGF1eGFkY19iYXNlKTsNCisJfQ0KKw0KIAlmb3IgKGN0cmxfaWQgPSAw
OyBjdHJsX2lkIDwgbXQtPmNvbmYtPm51bV9jb250cm9sbGVyIDsgY3RybF9pZCsrKQ0KIAkJZm9y
IChpID0gMDsgaSA8IG10LT5jb25mLT5udW1fYmFua3M7IGkrKykNCiAJCQltdGtfdGhlcm1hbF9p
bml0X2JhbmsobXQsIGksIGFwbWl4ZWRfcGh5c19iYXNlLA0KLS0gDQoyLjE3LjENCg==

