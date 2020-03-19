Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77BAD18B08D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 10:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgCSJzj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 05:55:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60081 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbgCSJzj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 05:55:39 -0400
X-UUID: 9c69e65bf7eb479ba168f56035bcefd6-20200319
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=eAP4t7CT+ZTox+ouHvAMB5H/l5cIuHdf3USlLwvMS5Y=;
        b=QMda1ivHKhmHnwkgcaNtNeO1yh1njvp+wW35NXTUjPpcjjN23eUHikVShDmWKAtWEWLyTEhIy6WkJNdrF7NZ0F6Uj9IejrC7X0bjp8PtqMfkgukftYR7hQTZ5Ml9nGiYLWpdaYOIz7Tly2a/rEreeAtgOiDjB5dcY1GAOmmG5Uc=;
X-UUID: 9c69e65bf7eb479ba168f56035bcefd6-20200319
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <henry.yen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 688613099; Thu, 19 Mar 2020 17:55:30 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 19 Mar 2020 17:52:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 19 Mar 2020 17:52:16 +0800
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
Subject: [PATCH 0/2] Add Mediatek thermal driver for MT7622
Date:   Thu, 19 Mar 2020 17:54:51 +0800
Message-ID: <1584611693-3553-1-git-send-email-henry.yen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CE5A3A715436CF45EA217465AFB9DE324815F7979766A429500461C9CCCC66552000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TWVkaWF0ZWsgb3ducyB0d28gdGhlcm1hbCBzeXN0ZW1zLCB3aGljaCBhcmUgYWxtb3N0IHRoZSBz
YW1lIGV4Y2VwdCBmb3INCnRoZSB3YXkgb2YgcmVhZGluZyBjYWxpYnJhdGlvbiBkYXRhIGFuZCBj
b252ZXJ0aW5nIHRlbXBlcmF0dXJlLg0KTVQ4MTczLCBNVDI3MDEsIE1UMjcxMiBhbmQgTVQ4MTgz
IGJlbG9uZ3MgdG8gdmVyc2lvbiAxIHRoZXJtYWwgc3lzdGVtLA0KYW5kIE1UNzYyMiBiZWxvbmdz
IHRvIHZlcnNpb24gMi4gVGhlIGN1cnJlbnQgY29kZSBoYXMgYWxyZWFkeSBzdXBwb3J0ZWQNCnZl
cnNpb24gMSBzeXN0ZW0uIFRoZW4gdGhpcyBwYXRjaHNldCBhZGRzIHRoZSBzdXBwb3J0IGZvciBh
bm90aGVyDQpwbGF0Zm9ybSAoZS5nLiwgTVQ3NjIyIFNvQykuDQoNCg0KSGVucnkgWWVuICgyKToN
CiAgdGhlcm1hbDogbWVkaWF0ZWs6IHByZXBhcmUgdG8gYWRkIHN1cHBvcnQgZm9yIG90aGVyIHBs
YXRmb3Jtcw0KICB0aGVybWFsOiBtZWRpYXRlazogYWRkIHRzZW5zb3Igc3VwcG9ydCBmb3IgTVQ3
NjIyIFNvQw0KDQogZHJpdmVycy90aGVybWFsL210a190aGVybWFsLmMgfCAyNDQgKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxODkgaW5zZXJ0aW9u
cygrKSwgNTUgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4xNy4xDQo=

