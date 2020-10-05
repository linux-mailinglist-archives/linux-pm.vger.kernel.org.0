Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9080F282ED0
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 04:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgJEC3x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Oct 2020 22:29:53 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50201 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725841AbgJEC3x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Oct 2020 22:29:53 -0400
X-UUID: 43e6c307201740c2a5fc0d87cca4fa5e-20201005
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=zfIoFOO7M2zzmk/gLUFI1nPpZvnU+1hf0KYlAmBzynM=;
        b=nvyOw5xuwQfMsLWDm49sXKIRbVZ7Zxle5+RQR9b3rO5QczMUY0RjujUheDKTkqKHyBN9qWo603dG8ilJ2Ud7GQif6V3wt/DBAVIwXv/uZm/zVAYY+pvGGjW/Do48x1cZHCwezqlsAwEzawun3kIEO90Rpn5SxWPOYsP14tSrHjM=;
X-UUID: 43e6c307201740c2a5fc0d87cca4fa5e-20201005
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1506511504; Mon, 05 Oct 2020 10:29:47 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 5 Oct 2020 10:29:36 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 5 Oct 2020 10:29:36 +0800
Message-ID: <1601864976.21446.46.camel@mtkswgap22>
Subject: Re: [PATCH v7 2/2] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Date:   Mon, 5 Oct 2020 10:29:36 +0800
In-Reply-To: <1601018748.21446.43.camel@mtkswgap22>
References: <1599712262-8819-1-git-send-email-hector.yuan@mediatek.com>
         <1599712262-8819-3-git-send-email-hector.yuan@mediatek.com>
         <20200922202852.GA3134161@bogus> <1600866614.21446.18.camel@mtkswgap22>
         <1601000847.21446.34.camel@mtkswgap22>
         <20200925061543.5hxs3ija2y53gzea@vireshk-i7>
         <1601018748.21446.43.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: ABEF21196E9B582F58E3DE8582B85091A8ED4ECED688690E8E2408ECBC9D27172000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIwLTA5LTI1IGF0IDE1OjI1ICswODAwLCBIZWN0b3IgWXVhbiB3cm90ZToNCj4g
SGksIFJvYiBzaXI6DQo+IA0KPiBZZXMsIG15IHBhdGNoIGZvbGxvd3MNCj4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1xY29tLWh3LnR4dCB3YXkgdG8N
Cj4gZGVmaW5lIGZyZXF1ZW5jeSBkb21haW4uDQo+IElzIGl0IE9LIHRvIHlvdSBpZiBJIHVzZSB0
aGUgc2FtZSB3YXkgdG8gZG8/DQo+IEFuZCBpZiB0aGVyZSBleGlzdCBhbnkgc2NoZW1hIHByb2Js
ZW0sIHBsZWFzZSBraW5kbHkgbGV0IG1lIGtub3cgaG93IHRvDQo+IGZpeCBpdC4NCj4gDQo+IE15
IHBhdGNoIHJlZmVyZW5jZQ0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGhl
cm1hbC90aGVybWFsLWNvb2xpbmctZGV2aWNlcy55YW1sDQo+IHRvIHVzZSB0aGUgY3B1IG5vZGUu
DQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjktcmM2L3NvdXJjZS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGhlcm1hbC90aGVybWFsLWNvb2xpbmctZGV2
aWNlcy55YW1sDQo+IA0KPiBUaGFua3MgYSBsb3QuDQo+IA0KSGksIFJvYiBzaXI6DQoNClNvcnJ5
IHRvIGJvdGhlciB5b3UsIG1heSB3ZSBrbm93IHlvdXIgY29tbWVudCBmb3IgdGhpcy4NClRoYW5r
cyBzbyBtdWNoLiANCg0KPiBPbiBGcmksIDIwMjAtMDktMjUgYXQgMTE6NDUgKzA1MzAsIFZpcmVz
aCBLdW1hciB3cm90ZToNCj4gPiBPbiAyNS0wOS0yMCwgMTA6MjcsIEhlY3RvciBZdWFuIHdyb3Rl
Og0KPiA+ID4gSGksIFZpcmVzaCAmIFJvYiBTaXI6DQo+ID4gPiANCj4gPiA+IEkgd2lsbCBjaGFu
Z2UgZnJlcXVlbmN5IGRvbWFpbiB0byBiZWxvdyBhbmQgZGVmaW5lIGl0IGluIGNwdWZyZXFfaHcN
Cj4gPiA+IHNjaGVtYSByYXRoZXIgdGhhbiBjcHUgbm9kZS4NCj4gPiA+IA0KPiA+ID4gbWVkaWF0
ZWssZnJlcS1kb21haW4tMCA9IDwmY3B1MD4sIDwmY3B1MT47DQo+ID4gDQo+ID4gSSB0aGluayBp
dCB3b3VsZCBiZSBiZXR0ZXIgdG8gZG8gaXQgdGhlIHN0YW5kYXJkIHdheSB3ZSBoYXZlIGRvbmUg
aXQgZWxzZXdoZXJlLg0KPiA+IGkuZS4gZm9sbG93IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9jcHVmcmVxL2NwdWZyZXEtcWNvbS1ody50eHQsIHRoYXQNCj4gPiBpcyBzaW1pbGFy
IHRvIHdoYXQgeW91IGRpZCBlYXJsaWVyLg0KPiA+IA0KPiANCg0K

