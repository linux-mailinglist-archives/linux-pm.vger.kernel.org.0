Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45436296B30
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 10:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371632AbgJWIZN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 04:25:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39533 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S460538AbgJWIZK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 04:25:10 -0400
X-UUID: a12a1011de3441b2b1a20a2a479ddcb0-20201023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4VM6NPl+ijVwqvktm+aSRB6nraYZBazPaRdaStpNXzc=;
        b=rm0RflTd5u9wFJxO2FMZtFgZFDjt24xhdnMr7Zn52u4kCihl+266WBEVM4veSjVhFVtTcr/iTGdFHIWJNZDh9/TaE5G6OBtArDoX6VN+epoy4tj77NHO2N8+lI5MooVXvlw/T2JSF6Qi33q0G7xUoK0tpO7HSdjksOSbQEiKkAA=;
X-UUID: a12a1011de3441b2b1a20a2a479ddcb0-20201023
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 380672809; Fri, 23 Oct 2020 16:25:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Oct 2020 16:24:55 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Oct 2020 16:24:55 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v1] cpufreq: mediatek-hw: Add support for Mediatek cpufreq HW driver
Date:   Fri, 23 Oct 2020 16:24:47 +0800
Message-ID: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7A55D9135E1B5F82F8A4AD06A6247FCBA5814595F3DF116BA47C602A718C7B152000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhpcyBwYXRjaHNldCBpbmNsdWRlcyA2IHBhdGNoZXMgYW5kIGRlcGVuZHMgb24gdGhlIE1UNjc3
OSBEVFMgcGF0Y2hbMV0gc3VibWl0dGVkIGJ5IEhhbmtzIENoZW4uDQpUaGUgZmlyc3QgMyBwYXRj
aGVzIGFyZSBmb3IgQ1BVRlJFUSBIVyBkcml2ZXIgYW5kIGRldmljZSB0cmVlIGJpbmRpbmcsIHdo
aWNoIGFyZSBhbHJlYWR5IHNlbnQgYmVmb3JlIHNlcGFyYXRlbHkgWzJdWzNdLiBGb3IgYmluZGlu
ZyBwYXJ0LCBJIGFkZCBhIG5ldyBwYXRjaCB0byBhZGQgcHJvcGVydHkgaW4gY3B1IHNjaGVtYS4N
CkJlc2lkZXMsIHdlIGFkZCB0aHJlZSBtb3JlIHBhdGNoZXMgaW5jbHVkaW5nIEVNIHBvd2VyIHRh
YmxlLCBTVlMgQ1BVIGluaXRpYWxpemUsIGFuZCBjb29saW5nIGRldmljZS4NCg0KWzFdIGh0dHBz
Oi8vbGttbC5vcmcvbGttbC8yMDIwLzgvNC8xMDk0DQpbMl0gaHR0cHM6Ly9sa21sLm9yZy9sa21s
LzIwMjAvOS8xMC8xMyAoYWxyZWFkeSByZXZpZXdlZCBieSBWaXJlc2gpIFszXSBodHRwczovL2xr
bWwub3JnL2xrbWwvMjAyMC85LzIzLzM4NA0KDQoNCkhlY3Rvci5ZdWFuICg2KToNCiAgY3B1ZnJl
cTogbWVkaWF0ZWstaHc6IEFkZCBzdXBwb3J0IGZvciBDUFVGUkVRIEhXDQogIGR0LWJpbmRpbmdz
OiBhcm06IGNwdXM6IERvY3VtZW50ICdtdGssZnJlcS1kb21haW4nIHByb3BlcnR5DQogIGR0LWJp
bmRpbmdzOiBjcHVmcmVxOiBhZGQgYmluZGluZ3MgZm9yIE1lZGlhVGVrIGNwdWZyZXEgSFcNCiAg
Y3B1ZnJlcTogbWVkaWF0ZWstaHc6IHJlZ2lzdGVyIEVNIHBvd2VyIHRhYmxlDQogIGNwdWZyZXE6
IG1lZGlhdGVrLWh3OiBBZGQgU1ZTIENQVSBpbml0aWFsaXphdGlvbg0KICBjcHVmcmVxOiBtZWRp
YXRlay1odzogQWRkIGNvb2xpbmcgZGV2IGZsYWcNCg0KIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9hcm0vY3B1cy55YW1sICAgIHwgICAgNiArDQogLi4uL2JpbmRpbmdzL2NwdWZy
ZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sICAgICAgfCAgIDQ2ICsrKw0KIGRyaXZlcnMvY3B1
ZnJlcS9LY29uZmlnLmFybSAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxMiArDQogZHJpdmVy
cy9jcHVmcmVxL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAxICsNCiBk
cml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS1ody5jICAgICAgICAgICAgICB8ICAzNDMg
KysrKysrKysrKysrKysrKysrKysNCiA1IGZpbGVzIGNoYW5nZWQsIDQwOCBpbnNlcnRpb25zKCsp
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9j
cHVmcmVxL2NwdWZyZXEtbWVkaWF0ZWstaHcueWFtbA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS1ody5j

