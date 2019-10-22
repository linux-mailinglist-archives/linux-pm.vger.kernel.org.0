Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF0F8E0658
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 16:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfJVO1W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 10:27:22 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34229 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfJVO1W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 10:27:22 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mzhax-1i9dMY3aYT-00vdGx; Tue, 22 Oct 2019 16:27:07 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM / devfreq: events: fix excessive stack usage
Date:   Tue, 22 Oct 2019 16:26:48 +0200
Message-Id: <20191022142703.1789898-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qh/RvLmjzDt8CUVV7ACatn1skvYcyfu5E28VkIq7AS6tttHZlMz
 TIjAjlq//c4oE0S7pk2+qn3TwWn+zIIDE+irKrPdUQkLSm9C+UMARBbwSYsXjmQ3A4Vj4+m
 WaYPiiDoSMGCRXT0S2+joZKLny6x7/4mgNiuXorMgIEGEcbqw0dHAFpnjrAPOburAvNGWF+
 9WZ22K4YeTldC144O2aUQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sL01PcIlAAs=:AntrFvxzg3D8JTrZICKrqN
 1ZPcU53wnTXZaTpk0RQYe0TbS0a4kx0bLi2NKVF//lAiil22BuvuewyWdDVifb017uCRjc23M
 a8bn7moO7kXmW24pWlqE+VddKGpvytQMyzEzzGqKZPCHhUe7IErLHu6/FsS0GZj+qI3WiMuSj
 sdZrCdC+hXXvm+yDqnzpqzQ2PNTiGqUeYncWNojpuimzpwSVNBkd6ZUhaGp/ffsVMRA3ndliV
 P8ePYjyBGCeEOiCGk+WSL4mIsAJhFgopmppPVrLN4Y/L40+8DVKFXHJu4njXeEZxz7S4flg/H
 syJEdRIGPIpMeBIqzfhtr/YfVMRuiey+q6s4j9ibCcz3HZlDAxgHjM1USfC1qKlLiD2F/qTKL
 2aB6GnHIJ/n8MqcKJBN6LcVOklxnFb62hwn0IF7mB9i4ZbUgwuQMoZJn7iq2S+uC86BA77rSZ
 77t2x1ygZ+fNSEP2Qdee08lDS4Q9N7qkcUKrm7JPIK9meUfMzOgsnSwAPbc9pFIxAsJgD73El
 HN8hbnxKcaHLSKXN4RFXBMka2+4KtDTCQPqISfbeWJyEkUZY8Q1lNdsTIxtR80lVCL0XxtP33
 gx9qE9CPg0iYSV8AbwAggbQ3Aag0BfGSnPClLTRIhOY3NcISc7LnCzvryq8hmcpPpqLDOQDLW
 DBb4COdvFcGH+wED2mv5Rp4f/jkAz7Rj8f2re+ij6KoQuU34ryYMH6VA9pTnVqAQx2W/Bek+H
 iJqeYhoXUFR47tPo3Xo1uxkr+oYSmEzHbP/4WCDejGwmlioTth7WUFtwvbv/pYbZ3nCbst2bv
 zwbdwYn6oSVjStsGxfOWHEX4D4miVBlCvShwv//yhKuL0HP/BCDhx3o5UrU8O2YXXRBPlIu61
 ZV8Swi1xkpPum25vukVg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Putting a 'struct devfreq_event_dev' object on the stack is generally
a bad idea and here it leads to a warnig about potential stack overflow:

drivers/devfreq/event/exynos-ppmu.c:643:12: error: stack frame size of 1040 bytes in function 'exynos_ppmu_probe' [-Werror,-Wframe-larger-than=]

There is no real need for the device structure, only the string inside
it, so add an internal helper function that simply takes the string
as its argument and remove the device structure.

Fixes: 1dd62c66d345 ("PM / devfreq: events: extend events by type of counted data")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/devfreq/event/exynos-ppmu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index 87b42055e6bc..302e466549d3 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -101,17 +101,22 @@ static struct __exynos_ppmu_events {
 	PPMU_EVENT(dmc1_1),
 };
 
-static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
+static int __exynos_ppmu_find_ppmu_id(const char *edev_name)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(ppmu_events); i++)
-		if (!strcmp(edev->desc->name, ppmu_events[i].name))
+		if (!strcmp(edev_name, ppmu_events[i].name))
 			return ppmu_events[i].id;
 
 	return -EINVAL;
 }
 
+static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
+{
+	return __exynos_ppmu_find_ppmu_id(edev->desc->name);
+}
+
 /*
  * The devfreq-event ops structure for PPMU v1.1
  */
@@ -556,13 +561,11 @@ static int of_get_devfreq_events(struct device_node *np,
 			 * use default if not.
 			 */
 			if (info->ppmu_type == EXYNOS_TYPE_PPMU_V2) {
-				struct devfreq_event_dev edev;
 				int id;
 				/* Not all registers take the same value for
 				 * read+write data count.
 				 */
-				edev.desc = &desc[j];
-				id = exynos_ppmu_find_ppmu_id(&edev);
+				id = __exynos_ppmu_find_ppmu_id(desc->name);
 
 				switch (id) {
 				case PPMU_PMNCNT0:
-- 
2.20.0

