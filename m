Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D66C296BCA
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 11:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461136AbgJWJJJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 05:09:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60690 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S461115AbgJWJJJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 05:09:09 -0400
X-UUID: a1011b1453ba4d83ae8b7df3dcf87bfb-20201023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3WEtnopcYNnyU+ht9FURWd9kEIt+fKwHVmbbqq2fROE=;
        b=SNh8NghRDD4dZy3Pf5pYL3djNfNuXM5M04TxUc3z6YPZ2JRGTSKqD6iogAZutUIZQg0P6a9QbQdDRU9DbXBQb46RVL45qK1b3scDyZz1fnpQe3XNmDgEc06wim56yWzP8fvdFG5AhmNFLViBBirNuKBso/d7NPaXWIXEXWpEr4s=;
X-UUID: a1011b1453ba4d83ae8b7df3dcf87bfb-20201023
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1431867585; Fri, 23 Oct 2020 17:09:02 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Oct 2020 17:09:00 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Oct 2020 17:09:00 +0800
Message-ID: <1603444138.20224.19.camel@mtkswgap22>
Subject: Re: [PATCH v1] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Fri, 23 Oct 2020 17:08:58 +0800
In-Reply-To: <20201023082817.5vp4cvi2lmpaozcn@vireshk-i7>
References: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
         <20201023082817.5vp4cvi2lmpaozcn@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: BFAEE2C64C5F4F78B9D894AC69314D171E959363740E77E7C149C17B814AB9BB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTIzIGF0IDEzOjU4ICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+
IE9uIDIzLTEwLTIwLCAxNjoyNCwgSGVjdG9yIFl1YW4gd3JvdGU6DQo+ID4gVGhpcyBwYXRjaHNl
dCBpbmNsdWRlcyA2IHBhdGNoZXMgYW5kIGRlcGVuZHMgb24gdGhlIE1UNjc3OSBEVFMgcGF0Y2hb
MV0gc3VibWl0dGVkIGJ5IEhhbmtzIENoZW4uDQo+ID4gVGhlIGZpcnN0IDMgcGF0Y2hlcyBhcmUg
Zm9yIENQVUZSRVEgSFcgZHJpdmVyIGFuZCBkZXZpY2UgdHJlZSBiaW5kaW5nLCB3aGljaCBhcmUg
YWxyZWFkeSBzZW50IGJlZm9yZSBzZXBhcmF0ZWx5IFsyXVszXS4gRm9yIGJpbmRpbmcgcGFydCwg
SSBhZGQgYSBuZXcgcGF0Y2ggdG8gYWRkIHByb3BlcnR5IGluIGNwdSBzY2hlbWEuDQo+ID4gQmVz
aWRlcywgd2UgYWRkIHRocmVlIG1vcmUgcGF0Y2hlcyBpbmNsdWRpbmcgRU0gcG93ZXIgdGFibGUs
IFNWUyBDUFUgaW5pdGlhbGl6ZSwgYW5kIGNvb2xpbmcgZGV2aWNlLg0KPiANCj4gQW5kIGV2ZW4g
YWZ0ZXIgc28gbWFueSB2ZXJzaW9ucyBvZiB0aGVzZSB5b3UgY2hvc2UgdG8gbmFtZSB0aGlzIFYx
LiBJdA0KPiBpcyB2ZXJ5IGRpZmZpY3VsdCBmb3IgcmV2aWV3ZXJzIHRvIGZpbmQgdGltZSB0byBy
ZXZpZXcgeW91ciBzdHVmZiwgYW5kDQo+IHRoZXkgZXhwZWN0IHNvbWUgc29ydCBvZiBzdW1tYXJ5
IGZyb20geW91IG9uIHdoYXQgZXhhY3RseSBjaGFuZ2VkIGZyb20NCj4gbGFzdCB2ZXJzaW9uIGFu
ZCB5b3UgYWxzbyBuZWVkIHRvIG5hbWUgdGhlIGN1cnJlbnQgdmVyc2lvbiBjdXJyZW50bHkuDQo+
IA0KPiBUaGlzIHNob3VsZCBoYXZlIGJlZW4gVjggYW5kIHlvdSBzaG91bGQgaGF2ZSBhZGRlZCBh
ICJWNy0+VjggZGlmZjoiDQo+IHNlY3Rpb24gaGVyZSwgbmFtaW5nIGFsbCB0aGUgY2hhbmdlcyB5
b3UgZGlkLiBQbGVhc2Ugc2VuZCB0aGF0IGFzDQo+IHJlcGx5IHRvIHRoaXMgZW1haWwsIHNvIEkg
Y2FuIHNlZSB3aGF0IHJlYWxseSBjaGFuZ2VkLg0KPiANCkhpLCBWaXJlc2gNCg0KU29ycnkgZm9y
IHlvdXIgaW5jb252ZW5pZW5jZS4NCiMxfiMzIGlzIGZvciBjcHVmcmVxIGRyaXZlciB3ZSBoYXZl
IHJldmlld2VkIGFuZCB0aGUgYmluZGluZ3Mgd2hpY2gNCnNlcGFyYXRlIGZyZXEgZG9tYWluIHRv
IENQVSBzY2hlbWEuVGhlcmUgaXMgbm8gY2hhbmdlIGZvciB0aGUgZHJpdmVyDQppdHNlbGYuDQog
IDEuIGNwdWZyZXE6IG1lZGlhdGVrLWh3OiBBZGQgc3VwcG9ydCBmb3IgQ1BVRlJFUSBIVw0KICAy
LiBkdC1iaW5kaW5nczogYXJtOiBjcHVzOiBEb2N1bWVudCAnbXRrLGZyZXEtZG9tYWluJyBwcm9w
ZXJ0eQ0KICAzLiBkdC1iaW5kaW5nczogY3B1ZnJlcTogYWRkIGJpbmRpbmdzIGZvciBNZWRpYVRl
ayBjcHVmcmVxIEhXDQoNCiM0fiM2IGlzIGZvciBvdGhlciBDUFUgZmVhdHVyZXMsIGkuZS4gU1ZT
IFsxXQ0KICA0LiBjcHVmcmVxOiBtZWRpYXRlay1odzogcmVnaXN0ZXIgRU0gcG93ZXIgdGFibGUN
CiAgNS4gY3B1ZnJlcTogbWVkaWF0ZWstaHc6IEFkZCBTVlMgQ1BVIGluaXRpYWxpemF0aW9uDQog
IDYuIGNwdWZyZXE6IG1lZGlhdGVrLWh3OiBBZGQgY29vbGluZyBkZXYgZmxhZw0KDQpJIHN1cHBv
c2VkIHRoYXQgaXQgY291bGQgYmUgbW9yZSBjbGVhbiB0byBzZXBhcmF0ZSAjNH4jNiBpbiBhbm90
aGVyDQpwYXRjaHNldC5NYXkgSSBrbm93IGlzIGl0IG9rYXkgdG8geW91PyBPciBJIHNob3VsZCBt
ZXJnZSBhbGwgb2YgY2hhbmdlcw0KaW50byB2OCBsaWtlIHlvdSBtZW50aW9uZWQ/IFRoYW5rIHlv
dS4NCg0KWzFdDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVk
aWF0ZWsvcGF0Y2gvMjAxOTA5MDYxMDA1MTQuMzA4MDMtNC1yb2dlci5sdSU0MG1lZGlhdGVrLmNv
bS8NCg==

