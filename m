Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17A026109B
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 13:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgIHLVp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 07:21:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32150 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729372AbgIHLV2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 07:21:28 -0400
X-UUID: cd19ca6877cb4c87a84d88385cff48e4-20200908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=J6PetP5hY2T+2YPn7CjXIDc6ZgTmKvWDCgSOANgtWDU=;
        b=RV4MIZfopVZVu1atLbAv7iS3QiYc90+A8iHdZINNf2k+aBQ9lKJqNDPAST3Q/YwhEQgwoFHMCYBdgX6o5fLfcDt8xSrNC+8Yy2Z64FYrkavqh+iQZ7mmmQVz8v7Hu8NCfBQtWtkQo+2Wqr6jCN1Ja3YrzdJOO5aRov2KH4KyydE=;
X-UUID: cd19ca6877cb4c87a84d88385cff48e4-20200908
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 687616419; Tue, 08 Sep 2020 19:21:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Sep 2020 19:21:19 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Sep 2020 19:21:20 +0800
Message-ID: <1599564080.2621.9.camel@mtkswgap22>
Subject: Re: [PATCH v4 1/2] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rob Herring" <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Tue, 8 Sep 2020 19:21:20 +0800
In-Reply-To: <20200908111331.rdvtrvttoapqxaib@vireshk-i7>
References: <1599550547-27767-1-git-send-email-hector.yuan@mediatek.com>
         <1599550547-27767-2-git-send-email-hector.yuan@mediatek.com>
         <20200908102752.r2n6xvghl4fcdrcv@vireshk-i7>
         <1599563425.2621.5.camel@mtkswgap22>
         <20200908111331.rdvtrvttoapqxaib@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVHVlLCAyMDIwLTA5LTA4IGF0IDE2OjQzICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+
IE9uIDA4LTA5LTIwLCAxOToxMCwgSGVjdG9yIFl1YW4gd3JvdGU6DQo+ID4gT0ssIEkgd2lsbCBk
ZWZpbmUgdGhlIGNvcnJlc3BvbmRpbmcgZXhpdCBmdW5jdGlvbi4gDQo+IA0KPiBBbHNvIHBsZWFz
ZSBhZGQgcmVtb3ZlKCkgY29ycmVzcG9uZGluZyB0byBwcm9iZSgpLg0KPiANCk9LLCB0aGFua3Mg
Zm9yIHlvdXIga2luZCByZW1pbmRlci4NCg0K

