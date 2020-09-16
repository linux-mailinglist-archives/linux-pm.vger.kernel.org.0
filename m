Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E137526C36F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 15:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgIPNzt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 09:55:49 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34567 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726580AbgIPNn4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 09:43:56 -0400
X-UUID: d375b2d7ef3b4924870ec3d7c51a879a-20200916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=W4f0Gv7pUKvtQ+PgBn2oCT/tUuwNvMVT9QsIDFwdjg0=;
        b=tREe3azI1u0MEgbt5H0hr3f29KZke4ZBJZj5JaGT+v3kP/QolKolAIg7L442D2z4O5/TEm5vMiIENcUohNUmNxaQtWj5mua/rr7vMjf074+uKEwuyYMsGmkICbqnosYdvebnaz/s6JiaLkh8ewzIM4osRYKpNY+XdBgfWqAAxHg=;
X-UUID: d375b2d7ef3b4924870ec3d7c51a879a-20200916
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1425565730; Wed, 16 Sep 2020 19:39:15 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Sep 2020 19:39:12 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Sep 2020 19:39:11 +0800
Message-ID: <1600256353.7042.13.camel@mtkswgap22>
Subject: Re: [PATCH v7] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rob Herring" <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Wed, 16 Sep 2020 19:39:13 +0800
In-Reply-To: <20200910053406.t37rgioykzvk3oem@vireshk-i7>
References: <1599712262-8819-1-git-send-email-hector.yuan@mediatek.com>
         <20200910050341.pgyieq3q7ijitosn@vireshk-i7>
         <1599715851.7042.9.camel@mtkswgap22>
         <20200910053406.t37rgioykzvk3oem@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D31B7E4528DDBB4A6FAA5C2B85C8B1EDF1AF3454225063A0AD4497AD9E8527D22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFJvYiBzaXI6DQoNClNvcnJ5IHRvIGJvdGhlciB5b3UsIG1heSBJIGhhdmUgeW91ciByZXZp
ZXcgY29tbWVudCBmb3IgdGhlIGJpbmRpbmcNCnBhcnQ/DQpBcHByZWNpYXRlZC4NCg0KT24gVGh1
LCAyMDIwLTA5LTEwIGF0IDExOjA0ICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+IE9uIDEw
LTA5LTIwLCAxMzozMCwgSGVjdG9yIFl1YW4gd3JvdGU6DQo+ID4gT24gVGh1LCAyMDIwLTA5LTEw
IGF0IDEwOjMzICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+ID4gPiBPbiAxMC0wOS0yMCwg
MTI6MzEsIEhlY3RvciBZdWFuIHdyb3RlOg0KPiA+ID4gPiBUaGUgQ1BVZnJlcSBIVyBwcmVzZW50
IGluIHNvbWUgTWVkaWF0ZWsgY2hpcHNldHMgb2ZmbG9hZHMgdGhlIHN0ZXBzIG5lY2Vzc2FyeSBm
b3IgY2hhbmdpbmcgdGhlIGZyZXF1ZW5jeSBvZiBDUFVzLiANCj4gPiA+ID4gVGhlIGRyaXZlciBp
bXBsZW1lbnRzIHRoZSBjcHVmcmVxIGRyaXZlciBpbnRlcmZhY2UgZm9yIHRoaXMgaGFyZHdhcmUg
ZW5naW5lLiANCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgcGF0Y2ggZGVwZW5kcyBvbiB0aGUgTVQ2
Nzc5IERUUyBwYXRjaCBzdWJtaXR0ZWQgYnkgSGFua3MgQ2hlbg0KPiA+ID4gPiAgaHR0cHM6Ly9s
a21sLm9yZy9sa21sLzIwMjAvOC80LzEwOTQNCj4gPiA+IA0KPiA+ID4gVGhhbmtzIGZvciBoYW5n
aW5nIHRoZXJlLiBMb29rcyBnb29kIHRvIG1lLiBJIHdpbGwgYXBwbHkgaXQgb25jZSBSb2INCj4g
PiA+IEFjaydzIHRoZSBiaW5kaW5nIHBhdGNoLg0KPiA+ID4gDQo+ID4gDQo+ID4gTWFueSB0aGFu
a3MgZm9yIHlvdXIgaGVscC4gTWF5IEkga25vdyBpZiB5b3UgY2FuIGFkZCBSZXZpZXdlZC1ieSB0
YWcgdG8NCj4gPiB0aGlzIHBhdGNoIHNldC4NCj4gDQo+IFNpbmNlIHRoaXMgcGF0Y2hzZXQgaXMg
Z29pbmcgdG8gZ2V0IG1lcmdlZCB2aWEgbXkgdHJlZSAoQVJNIGNwdWZyZXENCj4gdHJlZSksIGEg
cmV2aWV3ZWQtYnkgaXNuJ3QgcmVxdWlyZWQgaGVyZS4gSSB3aWxsIHF1ZXVlIGl0IHVwIGZvcg0K
PiA1LjEwLXJjMSBhZnRlciBJIHJlY2VpdmUgYW4gQWNrIGZyb20gUm9iLg0KPiANCj4gPiBJIHdv
dWxkIGxpa2UgdG8gcHJlcGFyZSBzb21lIHBhdGNoZXMgZm9yIG1vcmUgZmVhdHVyZXMNCj4gPiBi
YXNlZCBvbiB0aGlzLiBJcyB0aGF0IG9rYXkgdG8geW91PyBUaGFua3MgYWdhaW4uDQo+IA0KPiBU
aGF0IHNob3VsZCBiZSBmaW5lLg0KPiANCg0KDQo=

