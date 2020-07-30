Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA1232CF1
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 10:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgG3IF0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 04:05:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:16832 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729137AbgG3IFX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 04:05:23 -0400
X-UUID: 644fe121202244c4b38649415137a0f5-20200730
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=gtc/7yIbUp5/Z/sZoviqQWwUV/DSInVUWpg1vFZLruY=;
        b=TgqjfKTg2cR+y6eIfMj0fJSi1VFMiJkTpcLHe3zywndNhGyEWwGZEL77j/+3uUaqOws3JR2Kx7zGusNsmHiBX/3PmLHWOUfK0BkyXQ6/05MWFjmjJ4hz/hYZVaLXOgnWeXpN4P56usounCI43xOa9iMwCb4JvCcQ3UugEyhSFbw=;
X-UUID: 644fe121202244c4b38649415137a0f5-20200730
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <henry.yen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1605561292; Thu, 30 Jul 2020 16:05:18 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Jul 2020 16:05:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 30 Jul 2020 16:05:15 +0800
From:   Henry Yen <henry.yen@mediatek.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Steven Liu <steven.liu@mediatek.com>,
        Henry Yen <henry.yen@mediatek.com>,
        Michael Kao <michael.kao@mediatek.com>
Subject: [PATCH] thermal: mediatek: Fix missing selection
Date:   Thu, 30 Jul 2020 16:05:04 +0800
Message-ID: <1596096304-16422-1-git-send-email-henry.yen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TWVkaWF0ZWsgdGhlcm1hbCBkcml2ZXIgaXMgY29tcGF0aWJsZSB3aXRoIG11bHRpcGxlIHBsYXRm
b3Jtcy4NClNvbWUgb2YgdGhlIHBsYXRmb3JtcyAoZS5nLiwgTVQyNzAxKSByZXF1aXJlcyB0byBl
bmFibGUNCk1FRElBVEVLX01UNjU3N19BVVhBREMgb3B0aW9uLiBJZiBsYWNrcyB0aGUgY29uZmln
LCB0aGUgZHJpdmVyDQp3aWxsIG5vdCBiZSBhYmxlIHRvIHJlYWQgY29ycmVjdCB0ZW1wZXJhdHVy
ZS4NCg0KVG8gZml4IGl0LCBzZWxlY3QgbWlzc2luZyBNRURJQVRFS19NVDY1NzdfQVVYQURDIGNv
bmZpZy4NCg0KU2lnbmVkLW9mZi1ieTogSGVucnkgWWVuIDxoZW5yeS55ZW5AbWVkaWF0ZWsuY29t
Pg0KLS0tDQogZHJpdmVycy90aGVybWFsL0tjb25maWcgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9LY29uZmlnIGIv
ZHJpdmVycy90aGVybWFsL0tjb25maWcNCmluZGV4IDNlYjIzNDhlNTI0Mi4uM2EzN2Y2NzRmN2Yz
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy90aGVybWFsL0tjb25maWcNCisrKyBiL2RyaXZlcnMvdGhl
cm1hbC9LY29uZmlnDQpAQCAtNDA5LDYgKzQwOSw3IEBAIGNvbmZpZyBNVEtfVEhFUk1BTA0KIAlk
ZXBlbmRzIG9uIE5WTUVNIHx8IE5WTUVNPW4NCiAJZGVwZW5kcyBvbiBSRVNFVF9DT05UUk9MTEVS
DQogCWRlZmF1bHQgeQ0KKwlzZWxlY3QgTUVESUFURUtfTVQ2NTc3X0FVWEFEQw0KIAloZWxwDQog
CSAgRW5hYmxlIHRoaXMgb3B0aW9uIGlmIHlvdSB3YW50IHRvIGhhdmUgc3VwcG9ydCBmb3IgdGhl
cm1hbCBtYW5hZ2VtZW50DQogCSAgY29udHJvbGxlciBwcmVzZW50IGluIE1lZGlhdGVrIFNvQ3MN
Ci0tIA0KMi4xNy4xDQo=

