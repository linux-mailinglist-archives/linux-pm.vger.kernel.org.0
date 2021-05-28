Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88058393DE1
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 09:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbhE1H33 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 May 2021 03:29:29 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41276 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234447AbhE1H32 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 May 2021 03:29:28 -0400
X-UUID: a094207799114c37b48487d48039c306-20210528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=hJ6JezNIvj6ABl5W9WM2O4yJyn7QGyEyRh0VxX9iS/8=;
        b=g1IcgBnmu1v01thJMJw3AyaDS0owuq7AH8HdyhNMA8/r0sgSTdDWPMidFpqfU7AzJJ3LQNB+inw9UX0A9m/JwinVn+h1VptvMTUXi7HxYaCd3RDk6p5ahbuvY24zzNn7fSSKmqEx+9GekVspTVUd4PdP7wBvIHz8FZJi0ooMBI8=;
X-UUID: a094207799114c37b48487d48039c306-20210528
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 364549102; Fri, 28 May 2021 15:27:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 28 May 2021 15:27:49 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 May 2021 15:27:49 +0800
Message-ID: <1622186869.1958.0.camel@mtkswgap22>
Subject: Re: [PATCH v10] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Fri, 28 May 2021 15:27:49 +0800
In-Reply-To: <20210524091845.wlikxun3x2qou7zs@vireshk-i7>
References: <1609222629-2979-1-git-send-email-hector.yuan@mediatek.com>
         <20210524091845.wlikxun3x2qou7zs@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gTW9uLCAyMDIxLTA1LTI0IGF0IDE0OjQ4ICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+
IE9uIDI5LTEyLTIwLCAxNDoxNywgSGVjdG9yIFl1YW4gd3JvdGU6DQo+ID4gVGhlIENQVWZyZXEg
SFcgcHJlc2VudCBpbiBzb21lIE1lZGlhdGVrIGNoaXBzZXRzIG9mZmxvYWRzIHRoZSBzdGVwcyBu
ZWNlc3NhcnkgZm9yIGNoYW5naW5nIHRoZSBmcmVxdWVuY3kgb2YgQ1BVcy4gDQo+ID4gVGhlIGRy
aXZlciBpbXBsZW1lbnRzIHRoZSBjcHVmcmVxIGRyaXZlciBpbnRlcmZhY2UgZm9yIHRoaXMgaGFy
ZHdhcmUgZW5naW5lLiANCj4gPiBUaGlzIHBhdGNoIGRlcGVuZHMgb24gTVQ2Nzc5IERUUyBwYXRj
aHNldFsxXSBzdWJtaXR0ZWQgYnkgSGFua3MgQ2hlbi4NCj4gPiANCj4gPiA+RnJvbSB2OCB0byB2
OSwgdGhlcmUgYXJlIHRocmVlIG1vcmUgbW9kaWZpY2F0aW9ucy4NCj4gPiAxLiBCYXNlZCBvbiBw
YXRjaHNldFsyXSwgYWxpZ24gYmluZGluZyB3aXRoIHNjbWkgZm9yIHBlcmZvcm1hbmNlIGRvbWFp
bi4NCj4gPiAyLiBBZGQgdGhlIENQVUZSRVEgZmFzdCBzd2l0Y2ggZnVuY3Rpb24gc3VwcG9ydCBh
bmQgZGVmaW5lIERWRlMgbGF0ZW5jeS4NCj4gPiAzLiBCYXNlZCBvbiBwYXRjaHNlclszXSwgYWRk
IGVuZXJneSBtb2RlbCBBUEkgcGFyYW1ldGVyIGZvciBtVy4NCj4gDQo+IEhpIEhlY3RvciwNCj4g
DQo+IFlvdSBjYW4gcmVmcmVzaCB0aGlzIHNlcmllcyBiYXNlZCBvbiB0aGUgcGF0Y2ggZnJvbSBT
dWRlZXA6DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1kZXZpY2V0cmVlLzIw
MjEwNTE3MTU1NDU4LjEwMTY3MDctMS1zdWRlZXAuaG9sbGFAYXJtLmNvbS8NCj4gDQpPSywgd2ls
bCBiYXNlZCBvbiBsYXRlc3Qga2VybmVsIGFuZCByZXNlbmQgcGF0Y2hlcyBpbiB0aGVzZSBkYXlz
Lg0KVGhhbmtzIQ0K

