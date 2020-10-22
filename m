Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDE6295844
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 08:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503436AbgJVGST (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 02:18:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58213 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2503430AbgJVGST (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 02:18:19 -0400
X-UUID: bfd49dbfb3b542c7a8c3c8b3582b9154-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zCW5jEV9lFVr+2pw4W/WWhiqBQ7hV3YbIjRN0M12464=;
        b=tz8mgTT2xaOef2TCkdlgslRJjgXXak8bhAvN+0PcdkTf6oQNxRmcoomxzi5aUhU6yPfpus9r4PeyG3DTvuOMk0V1tHQ7cjf1ZmBgQajtuq9d7UW0ByhzwNqLl5Ax6o7gdiGm/VZVuoGsX7a1itc3txOz0ZkKmomnpcXu4OEgDk8=;
X-UUID: bfd49dbfb3b542c7a8c3c8b3582b9154-20201022
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <claude.yen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1436168799; Thu, 22 Oct 2020 14:18:14 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 14:18:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 14:18:10 +0800
From:   Claude Yen <claude.yen@mediatek.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        <claude.yen@mediatek.com>
Subject: [PATCH] PM / s2idle: Export s2idle_set_ops  
Date:   Thu, 22 Oct 2020 14:17:47 +0800
Message-ID: <20201022061748.13730-1-claude.yen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2E94CE7364EFCCBE6657F048F02BCCFE98C5E747ADF33706E7CBF3B1A53E304E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhpcyBzZXJpZXMgYmFzZWQgb24gNS45LXJjMQ0KDQpBcyBzdXNwZW5kX3NldF9vcHMgaXMgZXhw
b3J0ZWQgaW4gY29tbWl0IGE1ZTRmZDg3ODNhMg0KKCJQTSAvIFN1c3BlbmQ6IEV4cG9ydCBzdXNw
ZW5kX3NldF9vcHMsIHN1c3BlbmRfdmFsaWRfb25seV9tZW0iKSwNCmV4cG9ydGluZyBzMmlkbGVf
c2V0X29wcyB0byBtYWtlIGtlcm5lbCBtb2R1bGUgc2V0dXAgczJpZGxlIG9wcyB0b28uDQoNCklu
IHRoaXMgd2F5LCBrZXJuZWwgbW9kdWxlIGNhbiBob29rIHBsYXRmb3JtIHN1c3BlbmQgZnVuY3Rp
b25zDQpyZWdhcmRsZXNzIG9mIFN1c3BlbmQtdG8tUmFtKFMyUikgb3IgU3VzcGVuZC10by1JZGxl
KFMySSkNCg0KKioqIEJMVVJCIEhFUkUgKioqDQoNCkNsYXVkZSBZZW4gKDEpOg0KICBQTSAvIHMy
aWRsZTogRXhwb3J0IHMyaWRsZV9zZXRfb3BzDQoNCiBrZXJuZWwvcG93ZXIvc3VzcGVuZC5jIHwg
MSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCg==

