Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07283263C73
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 07:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgIJFaz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 01:30:55 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:3519 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725855AbgIJFay (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 01:30:54 -0400
X-UUID: 4cb539c9dd9b4a9b99e1e6913c7a040d-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=oKrpi4B/EZKt0VCDAKyjczOSEl+6iwJZEeFQwxXZIAU=;
        b=D9vP0eaV9obiIWcYbLltjWMKjXX22pHHPwwBJXgnUk9c4aYwMVe3aWEW61W4LG89qtCDt+a6pXCSOdmCSE+YvVWhBaRkctlXUp7gIe/BsFyR1VYqOv8lGFvQuk0pAzmtzEzz1Qjj/OKSCfNGex93bh9iNJMYbvCgLl+FuibD57s=;
X-UUID: 4cb539c9dd9b4a9b99e1e6913c7a040d-20200910
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2136567057; Thu, 10 Sep 2020 13:30:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 13:30:49 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 13:30:50 +0800
Message-ID: <1599715851.7042.9.camel@mtkswgap22>
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
Date:   Thu, 10 Sep 2020 13:30:51 +0800
In-Reply-To: <20200910050341.pgyieq3q7ijitosn@vireshk-i7>
References: <1599712262-8819-1-git-send-email-hector.yuan@mediatek.com>
         <20200910050341.pgyieq3q7ijitosn@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDIwLTA5LTEwIGF0IDEwOjMzICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+
IE9uIDEwLTA5LTIwLCAxMjozMSwgSGVjdG9yIFl1YW4gd3JvdGU6DQo+ID4gVGhlIENQVWZyZXEg
SFcgcHJlc2VudCBpbiBzb21lIE1lZGlhdGVrIGNoaXBzZXRzIG9mZmxvYWRzIHRoZSBzdGVwcyBu
ZWNlc3NhcnkgZm9yIGNoYW5naW5nIHRoZSBmcmVxdWVuY3kgb2YgQ1BVcy4gDQo+ID4gVGhlIGRy
aXZlciBpbXBsZW1lbnRzIHRoZSBjcHVmcmVxIGRyaXZlciBpbnRlcmZhY2UgZm9yIHRoaXMgaGFy
ZHdhcmUgZW5naW5lLiANCj4gPiANCj4gPiBUaGlzIHBhdGNoIGRlcGVuZHMgb24gdGhlIE1UNjc3
OSBEVFMgcGF0Y2ggc3VibWl0dGVkIGJ5IEhhbmtzIENoZW4NCj4gPiAgaHR0cHM6Ly9sa21sLm9y
Zy9sa21sLzIwMjAvOC80LzEwOTQNCj4gDQo+IFRoYW5rcyBmb3IgaGFuZ2luZyB0aGVyZS4gTG9v
a3MgZ29vZCB0byBtZS4gSSB3aWxsIGFwcGx5IGl0IG9uY2UgUm9iDQo+IEFjaydzIHRoZSBiaW5k
aW5nIHBhdGNoLg0KPiANCg0KTWFueSB0aGFua3MgZm9yIHlvdXIgaGVscC4gTWF5IEkga25vdyBp
ZiB5b3UgY2FuIGFkZCBSZXZpZXdlZC1ieSB0YWcgdG8NCnRoaXMgcGF0Y2ggc2V0LiBJIHdvdWxk
IGxpa2UgdG8gcHJlcGFyZSBzb21lIHBhdGNoZXMgZm9yIG1vcmUgZmVhdHVyZXMNCmJhc2VkIG9u
IHRoaXMuIElzIHRoYXQgb2theSB0byB5b3U/IFRoYW5rcyBhZ2Fpbi4NCg==

