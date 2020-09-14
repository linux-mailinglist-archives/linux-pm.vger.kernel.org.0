Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE8D2682E6
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 05:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgINDGg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Sep 2020 23:06:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11909 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726118AbgINDFQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2020 23:05:16 -0400
X-UUID: 7e98d87acc1a4595a9721a9653afc344-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FoVLuB7mUZzGbWA56kFB9mXbOhJutD39xGfD0bQTVbs=;
        b=laGVovez7xCcv1DSONeH4S6OrLuXLGXCag8cBXc5T59kl9CsMBeLOi3DSPElT6PNSQ498gvirDV8ShATmOKVDuPcmtt7EEsv6dW29HMmg/12xlKpQZsc9PaqPVIuUif6TOb36Pqc6muZZpqZoC67vDwo+G31+CZgwyvUGJ0FNP8=;
X-UUID: 7e98d87acc1a4595a9721a9653afc344-20200914
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1731189065; Mon, 14 Sep 2020 11:05:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Sep 2020 11:04:48 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Sep 2020 11:04:47 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        Mike Turquette <mturquette@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH V5 02/17] dt-bindings: soc: Add opp table on scpsys bindings
Date:   Mon, 14 Sep 2020 11:04:29 +0800
Message-ID: <1600052684-21198-3-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
References: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2FF2BAA8AC7D0745179B0DAD535F32421E236A189F525FC70B5002BB29ADC6572000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QWRkIG9wcCB0YWJsZSBvbiBzY3BzeXMgZHQtYmluZGluZ3MgZm9yIE1lZGlhdGVrIFNvQy4NCg0K
U2lnbmVkLW9mZi1ieTogSGVucnkgQ2hlbiA8aGVucnljLmNoZW5AbWVkaWF0ZWsuY29tPg0KUmV2
aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQotLS0NCiAuLi4vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLnR4dCAgICB8IDM4ICsrKysrKysrKysr
KysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9zY3Bz
eXMudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9z
Y3BzeXMudHh0DQppbmRleCA3ZjMyMmY5Li40Yjk2ZmRjIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9zY3BzeXMudHh0DQorKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL3NjcHN5cy50eHQN
CkBAIC05MCw2ICs5MCwyNyBAQCBFeGFtcGxlOg0KIAkJCSA8JnRvcGNrZ2VuIENMS19UT1BfVkVO
Q19TRUw+LA0KIAkJCSA8JnRvcGNrZ2VuIENMS19UT1BfVkVOQ19MVF9TRUw+Ow0KIAkJY2xvY2st
bmFtZXMgPSAibWZnIiwgIm1tIiwgInZlbmMiLCAidmVuY19sdCI7DQorCQlvcGVyYXRpbmctcG9p
bnRzLXYyID0gPCZkdmZzcmNfb3BwX3RhYmxlPjsNCisNCisJCWR2ZnNyY19vcHBfdGFibGU6IG9w
cC10YWJsZSB7DQorCQkJY29tcGF0aWJsZSA9ICJvcGVyYXRpbmctcG9pbnRzLXYyLWxldmVsIjsN
CisNCisJCQlkdmZzcmNfdm9sX21pbjogb3BwMSB7DQorCQkJCW9wcCxsZXZlbCA9IDxNVDgxODNf
RFZGU1JDX0xFVkVMXzE+Ow0KKwkJCX07DQorDQorCQkJZHZmc3JjX2ZyZXFfbWVkaXVtOiBvcHAy
IHsNCisJCQkJb3BwLGxldmVsID0gPE1UODE4M19EVkZTUkNfTEVWRUxfMj47DQorCQkJfTsNCisN
CisJCQlkdmZzcmNfZnJlcV9tYXg6IG9wcDMgew0KKwkJCQlvcHAsbGV2ZWwgPSA8TVQ4MTgzX0RW
RlNSQ19MRVZFTF8zPjsNCisJCQl9Ow0KKw0KKwkJCWR2ZnNyY192b2xfbWF4OiBvcHA0IHsNCisJ
CQkJb3BwLGxldmVsID0gPE1UODE4M19EVkZTUkNfTEVWRUxfND47DQorCQkJfTsNCisJCX07DQog
CX07DQogDQogRXhhbXBsZShwb3dlciBkb21haW4gc3ViIG5vZGUgd2l0aGluIHBvd2VyIGNvbnRy
b2xsZXIpOg0KQEAgLTE1MSw0ICsxNzIsMjEgQEAgRXhhbXBsZSBjb25zdW1lcjoNCiAJYWZlOiBt
dDgxNzMtYWZlLXBjbUAxMTIyMDAwMCB7DQogCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE3
My1hZmUtcGNtIjsNCiAJCXBvd2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgxNzNfUE9XRVJfRE9N
QUlOX0FVRElPPjsNCisJCW9wZXJhdGluZy1wb2ludHMtdjIgPSA8JmF1ZF9vcHBfdGFibGU+Ow0K
Kwl9Ow0KKw0KKwlhdWRfb3BwX3RhYmxlOiBhdWQtb3BwLXRhYmxlIHsNCisJCWNvbXBhdGlibGUg
PSAib3BlcmF0aW5nLXBvaW50cy12MiI7DQorCQlvcHAxIHsNCisJCQlvcHAtaHogPSAvYml0cy8g
NjQgPDc5MzAwMDAwMD47DQorCQkJcmVxdWlyZWQtb3BwcyA9IDwmZHZmc3JjX3ZvbF9taW4+Ow0K
KwkJfTsNCisJCW9wcDIgew0KKwkJCW9wcC1oeiA9IC9iaXRzLyA2NCA8OTEwMDAwMDAwPjsNCisJ
CQlyZXF1aXJlZC1vcHBzID0gPCZkdmZzcmNfdm9sX21heD47DQorCQl9Ow0KKwkJb3BwMyB7DQor
CQkJb3BwLWh6ID0gL2JpdHMvIDY0IDwxMDE0MDAwMDAwPjsNCisJCQlyZXF1aXJlZC1vcHBzID0g
PCZkdmZzcmNfdm9sX21heD47DQorCQl9Ow0KIAl9Ow0KLS0gDQoxLjkuMQ0K

