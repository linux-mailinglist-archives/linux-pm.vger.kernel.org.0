Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4F21A1DD7
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 11:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgDHJGK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 05:06:10 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:17133 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727593AbgDHJGJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2020 05:06:09 -0400
X-UUID: 0df92e5b88774149b64a973690f36de6-20200408
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=i+cO+9EMM2JD6F6o50QfwlTXOe8ZQhfDqfgiLUw0a0Q=;
        b=NnUlJ7DcSgFb6eLlPCNXyuPELXW5j5RNIvRfE6fIkCGURicoldmRab/Vq5O+3xYLA52yoEtE5ZgLimUPr89miSZC/r+ANZd2V9r9IU5T6aq/HcPq+/HwRmm098JCF0U2nvwfv7VE7Zw0d1LlFxH4zxIwL1HPsljgLPzmKIA6DYk=;
X-UUID: 0df92e5b88774149b64a973690f36de6-20200408
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 130815472; Wed, 08 Apr 2020 17:06:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Apr 2020 17:05:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Apr 2020 17:05:57 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     <michael.kao@mediatek.com>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <linux-pm@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Louis Yu <louis.yu@mediatek.com>
Subject: [RESEND PATCH] thermal: mediatek: add suspend/resume callback
Date:   Wed, 8 Apr 2020 17:05:58 +0800
Message-ID: <20200408090558.12410-2-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200408090558.12410-1-michael.kao@mediatek.com>
References: <20200408090558.12410-1-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogTG91aXMgWXUgPGxvdWlzLnl1QG1lZGlhdGVrLmNvbT4NCg0KQWRkIHN1c3BlbmQvcmVz
dW1lIGNhbGxiYWNrIHRvIGRpc2FibGUvZW5hYmxlIE1lZGlhdGVrIHRoZXJtYWwgc2Vuc29yDQpy
ZXNwZWN0aXZlbHkuIFNpbmNlIHRoZXJtYWwgcG93ZXIgZG9tYWluIGlzIG9mZiBpbiBzdXNwZW5k
LCB0aGVybWFsIGRyaXZlcg0KbmVlZHMgcmUtaW5pdGlhbGl6YXRpb24gZHVyaW5nIHJlc3VtZS4N
Cg0KU2lnbmVkLW9mZi1ieTogTG91aXMgWXUgPGxvdWlzLnl1QG1lZGlhdGVrLmNvbT4NClNpZ25l
ZC1vZmYtYnk6IE1pY2hhZWwgS2FvIDxtaWNoYWVsLmthb0BtZWRpYXRlay5jb20+DQotLS0NCiBk
cml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYyB8IDE1MiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEzNCBpbnNlcnRpb25zKCspLCAxOCBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9tdGtfdGhlcm1hbC5jIGIv
ZHJpdmVycy90aGVybWFsL210a190aGVybWFsLmMNCmluZGV4IDc2ZTMwNjAzZDRkNS4uMzZmZDM1
ZmFjNzMzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy90aGVybWFsL210a190aGVybWFsLmMNCisrKyBi
L2RyaXZlcnMvdGhlcm1hbC9tdGtfdGhlcm1hbC5jDQpAQCAtMjIsNiArMjIsNyBAQA0KICNpbmNs
dWRlIDxsaW51eC90aGVybWFsLmg+DQogI2luY2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+DQogI2luY2x1
ZGUgPGxpbnV4L3R5cGVzLmg+DQorI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KIA0KIC8qIEFV
WEFEQyBSZWdpc3RlcnMgKi8NCiAjZGVmaW5lIEFVWEFEQ19DT04xX1NFVF9WCTB4MDA4DQpAQCAt
MzEsNiArMzIsOCBAQA0KIA0KICNkZWZpbmUgQVBNSVhFRF9TWVNfVFNfQ09OMQkweDYwNA0KIA0K
KyNkZWZpbmUgQVBNSVhFRF9TWVNfVFNfQ09OMV9CVUZGRVJfT0ZGCTB4MzANCisNCiAvKiBUaGVy
bWFsIENvbnRyb2xsZXIgUmVnaXN0ZXJzICovDQogI2RlZmluZSBURU1QX01PTkNUTDAJCTB4MDAw
DQogI2RlZmluZSBURU1QX01PTkNUTDEJCTB4MDA0DQpAQCAtMzgsNiArNDEsNyBAQA0KICNkZWZp
bmUgVEVNUF9NT05JREVUMAkJMHgwMTQNCiAjZGVmaW5lIFRFTVBfTU9OSURFVDEJCTB4MDE4DQog
I2RlZmluZSBURU1QX01TUkNUTDAJCTB4MDM4DQorI2RlZmluZSBURU1QX01TUkNUTDEJCTB4MDNj
DQogI2RlZmluZSBURU1QX0FIQlBPTEwJCTB4MDQwDQogI2RlZmluZSBURU1QX0FIQlRPCQkweDA0
NA0KICNkZWZpbmUgVEVNUF9BRENQTlAwCQkweDA0OA0KQEAgLTg3LDYgKzkxLDkgQEANCiAjZGVm
aW5lIFRFTVBfQURDVkFMSURNQVNLX1ZBTElEX0hJR0gJCUJJVCg1KQ0KICNkZWZpbmUgVEVNUF9B
RENWQUxJRE1BU0tfVkFMSURfUE9TKGJpdCkJKGJpdCkNCiANCisjZGVmaW5lIFRFTVBfTVNSQ1RM
MV9CVVNfU1RBCShCSVQoMCkgfCBCSVQoNykpDQorI2RlZmluZSBURU1QX01TUkNUTDFfU0VOU0lO
R19QT0lOVFNfUEFVU0UJMHgxMEUNCisNCiAvKiBNVDgxNzMgdGhlcm1hbCBzZW5zb3JzICovDQog
I2RlZmluZSBNVDgxNzNfVFMxCTANCiAjZGVmaW5lIE1UODE3M19UUzIJMQ0KQEAgLTI1MCw2ICsy
NTcsMTAgQEAgc3RydWN0IG10a190aGVybWFsX2RhdGEgew0KIHN0cnVjdCBtdGtfdGhlcm1hbCB7
DQogCXN0cnVjdCBkZXZpY2UgKmRldjsNCiAJdm9pZCBfX2lvbWVtICp0aGVybWFsX2Jhc2U7DQor
CXZvaWQgX19pb21lbSAqYXBtaXhlZF9iYXNlOw0KKwl2b2lkIF9faW9tZW0gKmF1eGFkY19iYXNl
Ow0KKwl1NjQgYXBtaXhlZF9waHlzX2Jhc2U7DQorCXU2NCBhdXhhZGNfcGh5c19iYXNlOw0KIA0K
IAlzdHJ1Y3QgY2xrICpjbGtfcGVyaV90aGVybTsNCiAJc3RydWN0IGNsayAqY2xrX2F1eGFkYzsN
CkBAIC01NDEsMTMgKzU1MiwxMyBAQCBzdGF0aWMgaW50IHJhd190b19tY2Vsc2l1cyhzdHJ1Y3Qg
bXRrX3RoZXJtYWwgKm10LCBpbnQgc2Vuc25vLCBzMzIgcmF3KQ0KIH0NCiANCiAvKioNCi0gKiBt
dGtfdGhlcm1hbF9nZXRfYmFuayAtIGdldCBiYW5rDQorICogbXRrX3RoZXJtYWxfbG9ja19iYW5r
IC0gZ2V0IGJhbmsNCiAgKiBAYmFuazoJVGhlIGJhbmsNCiAgKg0KICAqIFRoZSBiYW5rIHJlZ2lz
dGVycyBhcmUgYmFua2VkLCB3ZSBoYXZlIHRvIHNlbGVjdCBhIGJhbmsgaW4gdGhlDQogICogUFRQ
Q09SRVNFTCByZWdpc3RlciB0byBhY2Nlc3MgaXQuDQogICovDQotc3RhdGljIHZvaWQgbXRrX3Ro
ZXJtYWxfZ2V0X2Jhbmsoc3RydWN0IG10a190aGVybWFsX2JhbmsgKmJhbmspDQorc3RhdGljIHZv
aWQgbXRrX3RoZXJtYWxfbG9ja19iYW5rKHN0cnVjdCBtdGtfdGhlcm1hbF9iYW5rICpiYW5rKQ0K
IHsNCiAJc3RydWN0IG10a190aGVybWFsICptdCA9IGJhbmstPm10Ow0KIAl1MzIgdmFsOw0KQEAg
LTU2MywxMiArNTc0LDEyIEBAIHN0YXRpYyB2b2lkIG10a190aGVybWFsX2dldF9iYW5rKHN0cnVj
dCBtdGtfdGhlcm1hbF9iYW5rICpiYW5rKQ0KIH0NCiANCiAvKioNCi0gKiBtdGtfdGhlcm1hbF9w
dXRfYmFuayAtIHJlbGVhc2UgYmFuaw0KKyAqIG10a190aGVybWFsX3VubG9ja19iYW5rIC0gcmVs
ZWFzZSBiYW5rDQogICogQGJhbms6CVRoZSBiYW5rDQogICoNCi0gKiByZWxlYXNlIGEgYmFuayBw
cmV2aW91c2x5IHRha2VuIHdpdGggbXRrX3RoZXJtYWxfZ2V0X2JhbmssDQorICogcmVsZWFzZSBh
IGJhbmsgcHJldmlvdXNseSB0YWtlbiB3aXRoIG10a190aGVybWFsX2xvY2tfYmFuaywNCiAgKi8N
Ci1zdGF0aWMgdm9pZCBtdGtfdGhlcm1hbF9wdXRfYmFuayhzdHJ1Y3QgbXRrX3RoZXJtYWxfYmFu
ayAqYmFuaykNCitzdGF0aWMgdm9pZCBtdGtfdGhlcm1hbF91bmxvY2tfYmFuayhzdHJ1Y3QgbXRr
X3RoZXJtYWxfYmFuayAqYmFuaykNCiB7DQogCXN0cnVjdCBtdGtfdGhlcm1hbCAqbXQgPSBiYW5r
LT5tdDsNCiANCkBAIC02MjIsMTEgKzYzMywxMSBAQCBzdGF0aWMgaW50IG10a19yZWFkX3RlbXAo
dm9pZCAqZGF0YSwgaW50ICp0ZW1wZXJhdHVyZSkNCiAJZm9yIChpID0gMDsgaSA8IG10LT5jb25m
LT5udW1fYmFua3M7IGkrKykgew0KIAkJc3RydWN0IG10a190aGVybWFsX2JhbmsgKmJhbmsgPSAm
bXQtPmJhbmtzW2ldOw0KIA0KLQkJbXRrX3RoZXJtYWxfZ2V0X2JhbmsoYmFuayk7DQorCQltdGtf
dGhlcm1hbF9sb2NrX2JhbmsoYmFuayk7DQogDQogCQl0ZW1wbWF4ID0gbWF4KHRlbXBtYXgsIG10
a190aGVybWFsX2JhbmtfdGVtcGVyYXR1cmUoYmFuaykpOw0KIA0KLQkJbXRrX3RoZXJtYWxfcHV0
X2JhbmsoYmFuayk7DQorCQltdGtfdGhlcm1hbF91bmxvY2tfYmFuayhiYW5rKTsNCiAJfQ0KIA0K
IAkqdGVtcGVyYXR1cmUgPSB0ZW1wbWF4Ow0KQEAgLTY1Miw3ICs2NjMsNyBAQCBzdGF0aWMgdm9p
ZCBtdGtfdGhlcm1hbF9pbml0X2Jhbmsoc3RydWN0IG10a190aGVybWFsICptdCwgaW50IG51bSwN
CiAJYmFuay0+aWQgPSBudW07DQogCWJhbmstPm10ID0gbXQ7DQogDQotCW10a190aGVybWFsX2dl
dF9iYW5rKGJhbmspOw0KKwltdGtfdGhlcm1hbF9sb2NrX2JhbmsoYmFuayk7DQogDQogCS8qIGJ1
cyBjbG9jayA2Nk0gY291bnRpbmcgdW5pdCBpcyAxMiAqIDE1LjE1bnMgKiAyNTYgPSA0Ni41NDB1
cyAqLw0KIAl3cml0ZWwoVEVNUF9NT05DVEwxX1BFUklPRF9VTklUKDEyKSwgY29udHJvbGxlcl9i
YXNlICsgVEVNUF9NT05DVEwxKTsNCkBAIC03NDMsNyArNzU0LDQzIEBAIHN0YXRpYyB2b2lkIG10
a190aGVybWFsX2luaXRfYmFuayhzdHJ1Y3QgbXRrX3RoZXJtYWwgKm10LCBpbnQgbnVtLA0KIAkg
ICAgICAgVEVNUF9BRENXUklURUNUUkxfQURDX01VWF9XUklURSwNCiAJICAgICAgIGNvbnRyb2xs
ZXJfYmFzZSArIFRFTVBfQURDV1JJVEVDVFJMKTsNCiANCi0JbXRrX3RoZXJtYWxfcHV0X2Jhbmso
YmFuayk7DQorCW10a190aGVybWFsX3VubG9ja19iYW5rKGJhbmspOw0KK30NCisNCitzdGF0aWMg
aW50IG10a190aGVybWFsX2Rpc2FibGVfc2Vuc2luZyhzdHJ1Y3QgbXRrX3RoZXJtYWwgKm10LCBp
bnQgbnVtKQ0KK3sNCisJc3RydWN0IG10a190aGVybWFsX2JhbmsgKmJhbmsgPSAmbXQtPmJhbmtz
W251bV07DQorCXUzMiB2YWw7DQorCXVuc2lnbmVkIGxvbmcgdGltZW91dDsNCisJdm9pZCBfX2lv
bWVtICphZGRyOw0KKwlpbnQgcmV0ID0gMDsNCisNCisJYmFuay0+aWQgPSBudW07DQorCWJhbmst
Pm10ID0gbXQ7DQorDQorCW10a190aGVybWFsX2xvY2tfYmFuayhiYW5rKTsNCisNCisJdmFsID0g
cmVhZGwobXQtPnRoZXJtYWxfYmFzZSArIFRFTVBfTVNSQ1RMMSk7DQorCS8qIHBhdXNlIHBlcmlv
ZGljIHRlbXBlcmF0dXJlIG1lYXN1cmVtZW50IGZvciBzZW5zaW5nIHBvaW50cyAqLw0KKwl3cml0
ZWwodmFsIHwgVEVNUF9NU1JDVEwxX1NFTlNJTkdfUE9JTlRTX1BBVVNFLA0KKwkgICAgICAgbXQt
PnRoZXJtYWxfYmFzZSArIFRFTVBfTVNSQ1RMMSk7DQorDQorCS8qIHdhaXQgdW50aWwgdGVtcGVy
YXR1cmUgbWVhc3VyZW1lbnQgYnVzIGlkbGUgKi8NCisJdGltZW91dCA9IGppZmZpZXMgKyBIWjsN
CisJYWRkciA9IG10LT50aGVybWFsX2Jhc2UgKyBURU1QX01TUkNUTDE7DQorDQorCXJldCA9IHJl
YWRsX3BvbGxfdGltZW91dChhZGRyLCB2YWwsICh2YWwgJiBURU1QX01TUkNUTDFfQlVTX1NUQSkg
PT0gMHgwLA0KKwkJCQkgMCwgdGltZW91dCk7DQorCWlmIChyZXQgPCAwKQ0KKwkJZ290byBvdXQ7
DQorDQorCS8qIGRpc2FibGUgcGVyaW9kaWMgdGVtcGVyYXR1cmUgbWVhc3VyZW1lbnQgb24gc2Vu
c2luZyBwb2ludHMgKi8NCisJd3JpdGVsKDB4MCwgbXQtPnRoZXJtYWxfYmFzZSArIFRFTVBfTU9O
Q1RMMCk7DQorDQorb3V0Og0KKwltdGtfdGhlcm1hbF91bmxvY2tfYmFuayhiYW5rKTsNCisNCisJ
cmV0dXJuIHJldDsNCiB9DQogDQogc3RhdGljIHU2NCBvZl9nZXRfcGh5c19iYXNlKHN0cnVjdCBk
ZXZpY2Vfbm9kZSAqbnApDQpAQCAtODY4LDcgKzkxNSw2IEBAIHN0YXRpYyBpbnQgbXRrX3RoZXJt
YWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJc3RydWN0IGRldmljZV9u
b2RlICphdXhhZGMsICphcG1peGVkc3lzLCAqbnAgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCiAJc3Ry
dWN0IG10a190aGVybWFsICptdDsNCiAJc3RydWN0IHJlc291cmNlICpyZXM7DQotCXU2NCBhdXhh
ZGNfcGh5c19iYXNlLCBhcG1peGVkX3BoeXNfYmFzZTsNCiAJc3RydWN0IHRoZXJtYWxfem9uZV9k
ZXZpY2UgKnR6ZGV2Ow0KIA0KIAltdCA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2Yo
Km10KSwgR0ZQX0tFUk5FTCk7DQpAQCAtOTA0LDExICs5NTAsMTEgQEAgc3RhdGljIGludCBtdGtf
dGhlcm1hbF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJcmV0dXJuIC1F
Tk9ERVY7DQogCX0NCiANCi0JYXV4YWRjX3BoeXNfYmFzZSA9IG9mX2dldF9waHlzX2Jhc2UoYXV4
YWRjKTsNCisJbXQtPmF1eGFkY19waHlzX2Jhc2UgPSBvZl9nZXRfcGh5c19iYXNlKGF1eGFkYyk7
DQogDQogCW9mX25vZGVfcHV0KGF1eGFkYyk7DQogDQotCWlmIChhdXhhZGNfcGh5c19iYXNlID09
IE9GX0JBRF9BRERSKSB7DQorCWlmIChtdC0+YXV4YWRjX3BoeXNfYmFzZSA9PSBPRl9CQURfQURE
Uikgew0KIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiQ2FuJ3QgZ2V0IGF1eGFkYyBwaHlzIGFkZHJl
c3NcbiIpOw0KIAkJcmV0dXJuIC1FSU5WQUw7DQogCX0NCkBAIC05MTksMTEgKzk2NSwxMiBAQCBz
dGF0aWMgaW50IG10a190aGVybWFsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQogCQlyZXR1cm4gLUVOT0RFVjsNCiAJfQ0KIA0KLQlhcG1peGVkX3BoeXNfYmFzZSA9IG9mX2dl
dF9waHlzX2Jhc2UoYXBtaXhlZHN5cyk7DQorCW10LT5hcG1peGVkX3BoeXNfYmFzZSA9IG9mX2dl
dF9waHlzX2Jhc2UoYXBtaXhlZHN5cyk7DQorCW10LT5hcG1peGVkX2Jhc2UgPSBvZl9pb21hcChh
cG1peGVkc3lzLCAwKTsNCiANCiAJb2Zfbm9kZV9wdXQoYXBtaXhlZHN5cyk7DQogDQotCWlmIChh
cG1peGVkX3BoeXNfYmFzZSA9PSBPRl9CQURfQUREUikgew0KKwlpZiAobXQtPmFwbWl4ZWRfcGh5
c19iYXNlID09IE9GX0JBRF9BRERSKSB7DQogCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJDYW4ndCBn
ZXQgYXV4YWRjIHBoeXMgYWRkcmVzc1xuIik7DQogCQlyZXR1cm4gLUVJTlZBTDsNCiAJfQ0KQEAg
LTkzNSwxOSArOTgyLDE5IEBAIHN0YXRpYyBpbnQgbXRrX3RoZXJtYWxfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCiAJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKG10LT5jbGtf
YXV4YWRjKTsNCiAJaWYgKHJldCkgew0KIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiQ2FuJ3QgZW5h
YmxlIGF1eGFkYyBjbGs6ICVkXG4iLCByZXQpOw0KLQkJcmV0dXJuIHJldDsNCisJCWdvdG8gZXJy
X2Rpc2FibGVfY2xrX2F1eGFkYzsNCiAJfQ0KIA0KIAlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUo
bXQtPmNsa19wZXJpX3RoZXJtKTsNCiAJaWYgKHJldCkgew0KIAkJZGV2X2VycigmcGRldi0+ZGV2
LCAiQ2FuJ3QgZW5hYmxlIHBlcmkgY2xrOiAlZFxuIiwgcmV0KTsNCi0JCWdvdG8gZXJyX2Rpc2Fi
bGVfY2xrX2F1eGFkYzsNCisJCWdvdG8gZXJyX2Rpc2FibGVfY2xrX3BlcmlfdGhlcm07DQogCX0N
CiANCiAJZm9yIChjdHJsX2lkID0gMDsgY3RybF9pZCA8IG10LT5jb25mLT5udW1fY29udHJvbGxl
ciA7IGN0cmxfaWQrKykNCiAJCWZvciAoaSA9IDA7IGkgPCBtdC0+Y29uZi0+bnVtX2JhbmtzOyBp
KyspDQotCQkJbXRrX3RoZXJtYWxfaW5pdF9iYW5rKG10LCBpLCBhcG1peGVkX3BoeXNfYmFzZSwN
Ci0JCQkJCSAgICAgIGF1eGFkY19waHlzX2Jhc2UsIGN0cmxfaWQpOw0KKwkJCW10a190aGVybWFs
X2luaXRfYmFuayhtdCwgaSwgbXQtPmFwbWl4ZWRfcGh5c19iYXNlLA0KKwkJCQkJICAgICAgbXQt
PmF1eGFkY19waHlzX2Jhc2UsIGN0cmxfaWQpOw0KIA0KIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShw
ZGV2LCBtdCk7DQogDQpAQCAtOTc4LDExICsxMDI1LDgwIEBAIHN0YXRpYyBpbnQgbXRrX3RoZXJt
YWxfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCXJldHVybiAwOw0KIH0N
CiANCitzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIG10a190aGVybWFsX3N1c3BlbmQoc3RydWN0
IGRldmljZSAqZGV2KQ0KK3sNCisJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiA9IHRvX3Bs
YXRmb3JtX2RldmljZShkZXYpOw0KKwlzdHJ1Y3QgbXRrX3RoZXJtYWwgKm10ID0gcGxhdGZvcm1f
Z2V0X2RydmRhdGEocGRldik7DQorCWludCBpLCByZXQ7DQorDQorCWZvciAoaSA9IDA7IGkgPCBt
dC0+Y29uZi0+bnVtX2JhbmtzOyBpKyspIHsNCisJCXJldCA9IG10a190aGVybWFsX2Rpc2FibGVf
c2Vuc2luZyhtdCwgaSk7DQorCQlpZiAocmV0KQ0KKwkJCWdvdG8gb3V0Ow0KKwl9DQorDQorCS8q
IGRpc2FibGUgYnVmZmVyICovDQorCXdyaXRlbChyZWFkbChtdC0+YXBtaXhlZF9iYXNlICsgQVBN
SVhFRF9TWVNfVFNfQ09OMSkgfA0KKwkgICAgICAgQVBNSVhFRF9TWVNfVFNfQ09OMV9CVUZGRVJf
T0ZGLA0KKwkgICAgICAgbXQtPmFwbWl4ZWRfYmFzZSArIEFQTUlYRURfU1lTX1RTX0NPTjEpOw0K
Kw0KKwljbGtfZGlzYWJsZV91bnByZXBhcmUobXQtPmNsa19wZXJpX3RoZXJtKTsNCisJY2xrX2Rp
c2FibGVfdW5wcmVwYXJlKG10LT5jbGtfYXV4YWRjKTsNCisNCisJcmV0dXJuIDA7DQorDQorb3V0
Og0KKwlkZXZfZXJyKCZwZGV2LT5kZXYsICJGYWlsZWQgdG8gd2FpdCB1bnRpbCBidXMgaWRsZVxu
Iik7DQorDQorCXJldHVybiByZXQ7DQorfQ0KKw0KK3N0YXRpYyBpbnQgX19tYXliZV91bnVzZWQg
bXRrX3RoZXJtYWxfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCit7DQorCXN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYgPSB0b19wbGF0Zm9ybV9kZXZpY2UoZGV2KTsNCisJc3RydWN0IG10
a190aGVybWFsICptdCA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KKwlpbnQgaSwgcmV0
LCBjdHJsX2lkOw0KKw0KKwlyZXQgPSBkZXZpY2VfcmVzZXQoJnBkZXYtPmRldik7DQorCWlmIChy
ZXQpDQorCQlyZXR1cm4gcmV0Ow0KKw0KKwlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUobXQtPmNs
a19hdXhhZGMpOw0KKwlpZiAocmV0KSB7DQorCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJDYW4ndCBl
bmFibGUgYXV4YWRjIGNsazogJWRcbiIsIHJldCk7DQorCQlnb3RvIGVycl9kaXNhYmxlX2Nsa19h
dXhhZGM7DQorCX0NCisNCisJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKG10LT5jbGtfcGVyaV90
aGVybSk7DQorCWlmIChyZXQpIHsNCisJCWRldl9lcnIoJnBkZXYtPmRldiwgIkNhbid0IGVuYWJs
ZSBwZXJpIGNsazogJWRcbiIsIHJldCk7DQorCQlnb3RvIGVycl9kaXNhYmxlX2Nsa19wZXJpX3Ro
ZXJtOw0KKwl9DQorDQorCWZvciAoY3RybF9pZCA9IDA7IGN0cmxfaWQgPCBtdC0+Y29uZi0+bnVt
X2NvbnRyb2xsZXIgOyBjdHJsX2lkKyspDQorCQlmb3IgKGkgPSAwOyBpIDwgbXQtPmNvbmYtPm51
bV9iYW5rczsgaSsrKQ0KKwkJCW10a190aGVybWFsX2luaXRfYmFuayhtdCwgaSwgbXQtPmFwbWl4
ZWRfcGh5c19iYXNlLA0KKwkJCQkJICAgICAgbXQtPmF1eGFkY19waHlzX2Jhc2UsIGN0cmxfaWQp
Ow0KKw0KKwlyZXR1cm4gMDsNCisNCitlcnJfZGlzYWJsZV9jbGtfcGVyaV90aGVybToNCisJY2xr
X2Rpc2FibGVfdW5wcmVwYXJlKG10LT5jbGtfcGVyaV90aGVybSk7DQorZXJyX2Rpc2FibGVfY2xr
X2F1eGFkYzoNCisJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKG10LT5jbGtfYXV4YWRjKTsNCisNCisJ
cmV0dXJuIHJldDsNCit9DQorDQorc3RhdGljIFNJTVBMRV9ERVZfUE1fT1BTKG10a190aGVybWFs
X3BtX29wcywNCisJCQkgbXRrX3RoZXJtYWxfc3VzcGVuZCwgbXRrX3RoZXJtYWxfcmVzdW1lKTsN
CisNCiBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBtdGtfdGhlcm1hbF9kcml2ZXIgPSB7
DQogCS5wcm9iZSA9IG10a190aGVybWFsX3Byb2JlLA0KIAkucmVtb3ZlID0gbXRrX3RoZXJtYWxf
cmVtb3ZlLA0KIAkuZHJpdmVyID0gew0KIAkJLm5hbWUgPSAibXRrLXRoZXJtYWwiLA0KKwkJLnBt
ID0gJm10a190aGVybWFsX3BtX29wcywNCiAJCS5vZl9tYXRjaF90YWJsZSA9IG10a190aGVybWFs
X29mX21hdGNoLA0KIAl9LA0KIH07DQotLSANCjIuMTguMA0K

