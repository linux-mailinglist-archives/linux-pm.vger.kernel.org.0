Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E6C357FF1
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 11:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhDHJvy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 05:51:54 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:2708 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229686AbhDHJvy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 05:51:54 -0400
X-UUID: 3d628607a0c742699c5e430d67f2cf3d-20210408
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=DhXrt3L4CKxUl57HEQInxirgPEfKt48YlqcSx9oo5a8=;
        b=TH4uvBxi42WGWVOPlxcK2pS/M8nrP96H81le+D77xFD24qDp31B04ONqs76H7nBxmhsi/un1VJfO5XsaRI0l9kUW6g33TfucN02FH+EaM595wAAMDncR0XDfZZEc5YKJzYGqhop1O6RsAtUgf1s51rsSRivpXL2aV1kLDQRz6fk=;
X-UUID: 3d628607a0c742699c5e430d67f2cf3d-20210408
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1541904808; Thu, 08 Apr 2021 17:51:39 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Apr
 2021 17:51:36 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Apr 2021 17:51:35 +0800
Message-ID: <1617875495.12105.10.camel@mhfsdcap03>
Subject: Re: [PATCH 4/6] usb: xhci-mtk: add support runtime PM
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        "Nicolas Boichat" <drinkcat@chromium.org>
Date:   Thu, 8 Apr 2021 17:51:35 +0800
In-Reply-To: <1617874514-12282-4-git-send-email-chunfeng.yun@mediatek.com>
References: <1617874514-12282-1-git-send-email-chunfeng.yun@mediatek.com>
         <1617874514-12282-4-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E15A2741E4BB7D8CC38E834F7543B5CB54B1540CBD14BBD60B90D85081593F412000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgSWtqb29uLA0KDQpPbiBUaHUsIDIwMjEtMDQtMDggYXQgMTc6MzUgKzA4MDAsIENodW5mZW5n
IFl1biB3cm90ZToNCj4gQSBkZWRpY2F0ZWQgd2FrZXVwIGlycSB3aWxsIGJlIHVzZWQgdG8gaGFu
ZGxlIHJ1bnRpbWUgc3VzcGVuZC9yZXN1bWUsDQo+IHdlIHVzZSBkZXZfcG1fc2V0X2RlZGljYXRl
ZF93YWtlX2lycSBBUEkgdG8gdGFrZSBjYXJlIG9mIHJlcXVlc3RpbmcNCj4gYW5kIGF0dGFjaGlu
ZyB3YWtldXAgaXJxLCB0aGVuIHRoZSBzdXNwZW5kL3Jlc3VtZSBmcmFtZXdvcmsgd2lsbCBoZWxw
DQo+IHRvIGVuYWJsZS9kaXNhYmxlIHdha2V1cCBpcnEuDQo+IA0KPiBUaGUgcnVudGltZSBQTSBp
cyBkZWZhdWx0IG9mZiBzaW5jZSBzb21lIHBsYXRmb3JtcyBtYXkgbm90IHN1cHBvcnQgaXQuDQo+
IHVzZXJzIGNhbiBlbmFibGUgaXQgdmlhIHBvd2VyL2NvbnRyb2wgKHNldCAiYXV0byIpIGluIHN5
c2ZzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVk
aWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYyB8IDE0MCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
MjQgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQoNClBsZWFzZSBoZWxwIHRvIHRlc3Qg
dGhlIHNlcmllcyBvbiBtdDgxOTIgY2hyb21lYm9vaywgdGhhbmtzIGEgbG90DQoNCg==

