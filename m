Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 068F3182BA7
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 09:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCLI6S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 04:58:18 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:31735 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725978AbgCLI6R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 04:58:17 -0400
X-UUID: 7cbfa43d3c244faf9edc17ff0fa57006-20200312
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3TDN1j10xZCmKTt4/HmcFKsBFN2EXb3TUfii04A/U8I=;
        b=iOzxdYppsJNm+1ewnLgQ2d8sdb7jq3GrPSchuyFSJNsLrWOi5Upv12r4SzLG8jfEhjBTop/YwNCPRaCIK1F9VSqcD9QwIoh3iYVKhpbu8rcDUEDdcmPfzRlDPc9bfqaxtUDK6u4aghGTdSU/SuM+gXV0ya1uyndzEJ/rWsR7Ric=;
X-UUID: 7cbfa43d3c244faf9edc17ff0fa57006-20200312
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ran.bi@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1079829579; Thu, 12 Mar 2020 16:58:11 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs01n2.mediatek.inc
 (172.21.101.79) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 Mar
 2020 16:56:37 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Mar 2020 16:58:06 +0800
Message-ID: <1584003477.6269.8.camel@mhfsdcap03>
Subject: Re: [PATCH v10 4/5] rtc: mt6397: Add support for the MediaTek
 MT6358 RTC
From:   Ran Bi <ran.bi@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "Sebastian Reichel" <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Frank Wunderlich <frank-w@public-files.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Richard Fontana" <rfontana@redhat.com>,
        Josef Friedl <josef.friedl@speed.at>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>
Date:   Thu, 12 Mar 2020 16:57:57 +0800
In-Reply-To: <20200312074407.GA3142@dell>
References: <1583918223-22506-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1583918223-22506-5-git-send-email-hsin-hsiung.wang@mediatek.com>
         <20200312074407.GA3142@dell>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 41489C93ED8253A92B734623EA5AC68DE0AA3C817D3EF1171405B84CD846F7CC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTEyIGF0IDA3OjQ0ICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6DQo+IE9u
IFdlZCwgMTEgTWFyIDIwMjAsIEhzaW4tSHNpdW5nIFdhbmcgd3JvdGU6DQo+IA0KPiA+IEZyb206
IFJhbiBCaSA8cmFuLmJpQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBUaGlzIGFkZCBzdXBwb3J0
IGZvciB0aGUgTWVkaWFUZWsgTVQ2MzU4IFJUQy4gRHJpdmVyIHVzaW5nDQo+ID4gY29tcGF0aWJs
ZSBkYXRhIHRvIHN0b3JlIGRpZmZlcmVudCBSVENfV1JUR1IgYWRkcmVzcyBvZmZzZXQuDQo+ID4g
VGhpcyByZXBsYWNlIFJUQ19XUlRHUiB0byBSVENfV1JUR1JfTVQ2MzIzIGluIG10NjMyMy1wb3dl
cm9mZg0KPiA+IGRyaXZlciB3aGljaCBvbmx5IG5lZWRlZCBieSBhcm12NyBDUFUgd2l0aG91dCBB
VEYuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUmFuIEJpIDxyYW4uYmlAbWVkaWF0ZWsuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhzaW4tSHNpdW5nIFdhbmcgPGhzaW4taHNpdW5nLndhbmdA
bWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Bvd2VyL3Jlc2V0L210NjMyMy1w
b3dlcm9mZi5jIHwgIDIgKy0NCj4gPiAgZHJpdmVycy9ydGMvcnRjLW10NjM5Ny5jICAgICAgICAg
ICAgICB8IDMyICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ID4gIGluY2x1ZGUv
bGludXgvbWZkL210NjM5Ny9ydGMuaCAgICAgICAgfCAgOSArKysrKysrKy0NCj4gPiAgMyBmaWxl
cyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gPiANCg0KPC4u
Lj4NCg0KPiA+ICANCj4gPiAgI2RlZmluZSBSVENfSVJRX1NUQSAgICAgICAgICAgIDB4MDAwMg0K
PiA+ICAjZGVmaW5lIFJUQ19JUlFfU1RBX0FMICAgICAgICAgQklUKDApDQo+ID4gQEAgLTY1LDYg
KzY3LDEwIEBADQo+ID4gICNkZWZpbmUgTVRLX1JUQ19QT0xMX0RFTEFZX1VTICAxMA0KPiA+ICAj
ZGVmaW5lIE1US19SVENfUE9MTF9USU1FT1VUICAgKGppZmZpZXNfdG9fdXNlY3MoSFopKQ0KPiA+
ICANCj4gPiArc3RydWN0IG10a19ydGNfZGF0YSB7DQo+ID4gKwl1MzIJCQl3cnRncjsNCj4gPiAr
fTsNCj4gDQo+IERvIHlvdSBleHBlY3QgdG8gYWRkIG1vcmUgcHJvcGVydGllcyB0byB0aGlzIHN0
cnVjdD8NCj4gDQo+IElmIG5vdCwgaXQgc2VlbXMgYSBiaXQgb3ZlcmtpbGwuDQo+IA0KDQpZZXMs
IHdlIHdvdWxkIGFkZCBtb3JlIHByb3BlcnRpZXMgaGVyZSBpbiBmdXR1cmUgcGF0Y2hlcy4NCg0K
PiA+ICBzdHJ1Y3QgbXQ2Mzk3X3J0YyB7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlICAgICAgICAgICAq
ZGV2Ow0KPiA+ICAJc3RydWN0IHJ0Y19kZXZpY2UgICAgICAgKnJ0Y19kZXY7DQo+ID4gQEAgLTc0
LDYgKzgwLDcgQEAgc3RydWN0IG10NjM5N19ydGMgew0KPiA+ICAJc3RydWN0IHJlZ21hcCAgICAg
ICAgICAgKnJlZ21hcDsNCj4gPiAgCWludCAgICAgICAgICAgICAgICAgICAgIGlycTsNCj4gPiAg
CXUzMiAgICAgICAgICAgICAgICAgICAgIGFkZHJfYmFzZTsNCj4gPiArCWNvbnN0IHN0cnVjdCBt
dGtfcnRjX2RhdGEgKmRhdGE7DQo+IA0KPiAnZGF0YScgaXMgYSB0ZXJyaWJsZSB2YXJpYWJsZSBu
YW1lLg0KPiANCj4gV2h5IGRvIHlvdSBuZWVkIHRvIHN0b3JlIHRoaXM/DQo+IA0KPiBJdCdzIG9u
ZSB2YXJpYWJsZSB3aGljaCBpcyB1c2VkIG9uY2UgQUZBSUNULg0KPiANCg0KSSB3b3VsZCByZW5h
bWUgJ2RhdGEnIHRvICdjb25maWcnLg0KDQpUaGlzIHN0cnVjdCB3aWxsIGJlIGV4dGVuZGVkIGlu
IGZ1dHVyZSBwYXRjaGVzIHRvIGFjaGlldmUgbW9yZSBQTUlDIGNoaXANCmNvbXBhdGliaWxpdHku
DQoNCj4gPiAgfTsNCj4gPiAgDQo+ID4gICNlbmRpZiAvKiBfTElOVVhfTUZEX01UNjM5N19SVENf
SF8gKi8NCj4gDQoNCg==

