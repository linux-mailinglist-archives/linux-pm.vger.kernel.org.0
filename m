Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05B4260A5C
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 07:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgIHFwc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 01:52:32 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41239 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728531AbgIHFwa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 01:52:30 -0400
X-UUID: ce9e17ac8b57459482247ad4bb65b26e-20200908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=zrrwNcnMPIRlU5Qw4X9J4deUAZZqqjlSu2mS7e67eO4=;
        b=RtY0yWVrwUzjJg10Cb21GFHewHWBECdQfDstxSFLlq8NR9QxZvOKr+x1uDDpSk3LuWj135bWOMLnRQhPFGlpf/TNFhUbzKVtDh7ilOomp2C8TaFbxfr01xQrD17l/Iozv+7V886ShVZAErx+ylY2mA7mQ5xXIGhG/Dmt7/jz5VY=;
X-UUID: ce9e17ac8b57459482247ad4bb65b26e-20200908
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 73886558; Tue, 08 Sep 2020 13:52:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Sep 2020 13:52:23 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Sep 2020 13:52:24 +0800
Message-ID: <1599544344.17800.2.camel@mtkswgap22>
Subject: Re: [PATCH v3] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rob Herring" <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Olof Johansson" <olof@lixom.net>, <wsd_upstream@mediatek.com>
Date:   Tue, 8 Sep 2020 13:52:24 +0800
In-Reply-To: <20200908051416.na567g3mr7zbyr6h@vireshk-i7>
References: <1598446913-24325-1-git-send-email-hector.yuan@mediatek.com>
         <1599532510.17707.4.camel@mtkswgap22>
         <20200908051416.na567g3mr7zbyr6h@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 267856DCEFB91F9263896297BDB66F042192EFBF9467B861CC1DC02360CBEFF02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVHVlLCAyMDIwLTA5LTA4IGF0IDEwOjQ0ICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+
IE9uIDA4LTA5LTIwLCAxMDozNSwgSGVjdG9yIFl1YW4gd3JvdGU6DQo+ID4gSGksIFNpcnM6DQo+
ID4gDQo+ID4gUGxlYXNlIGtpbmRseSBsZXQgbWUga25vdyB5b3VyIHJldmlldyB0aG91Z2h0cyBv
ZiB0aGlzIHBhdGNoLg0KPiA+IEFwcHJlY2lhdGVkLg0KPiANCj4gUGxlYXNlIGRvbid0IHNlbmQg
bmV3IHBhdGNoc2V0cyBpbiBodXJyeSwgaXQgaXNuJ3QgZ29pbmcgdG8gaGVscCBhbnkNCj4gb2Yg
dXMuIFYzIGRvZXNuJ3QgYWRkcmVzcyBhbGwgdGhlIHJldmlldyBjb21tZW50cyB5b3UgcmVjZWl2
ZWQgaW4gVjINCj4gYW5kIHNvIHRoZXJlIGlzIG5vIHBvaW50IHJldmlld2luZyBpdC4NCj4gDQo+
IFBsZWFzZSBzZW5kIGEgbmV3IHZlcnNpb24gd2hpY2ggYWRkcmVzc2VzIGFsbCB0aGUgY29tbWVu
dHMgeW91IGdvdC4NCj4gDQpPSywgSSB3aWxsIHNlbmQgVjQgd2hpY2ggYWRkcmVzc2VzIGFsbCB0
aGUgY29tbWVudHMuDQoNCg==

