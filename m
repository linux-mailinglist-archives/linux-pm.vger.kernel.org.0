Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25C3E114EC9
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 11:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfLFKLs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 05:11:48 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56007 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfLFKLr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2019 05:11:47 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191206101146euoutp0268b65f21cdc083f027ee250acd0bb5e3~dwIFPzkx_0501605016euoutp02T
        for <linux-pm@vger.kernel.org>; Fri,  6 Dec 2019 10:11:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191206101146euoutp0268b65f21cdc083f027ee250acd0bb5e3~dwIFPzkx_0501605016euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575627106;
        bh=pUJ+B8tPpXjSJhd2ezW888/S1hPq28299mikdXe5hNs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=pKowX9tOuAtIh14VyWYJcVAh+rc5S7OBAoLk4Sla2yJtdsOhg8gRxB36XyGgnLXQL
         e2VOY9NWDwPrLkycVkosoRI6KMJiyjoBVS8mnyX28+ag7pZ6Ab+LLiJtUFvubxesg8
         laJwGTUDabpuoyrL+pdOv82VmSHtYXgJfFU8UjDU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191206101145eucas1p17ea244f2318cff9a2f12701a6adc6e6f~dwIE_oWxJ2585325853eucas1p18;
        Fri,  6 Dec 2019 10:11:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 29.4C.60698.1692AED5; Fri,  6
        Dec 2019 10:11:45 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191206101145eucas1p26ed05a4d6d805c26c8ad92ad6b602f9d~dwIEalvKY0678206782eucas1p2d;
        Fri,  6 Dec 2019 10:11:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191206101145eusmtrp19b01c734a265fc9fede24f45cfa955fd~dwIEZ2dN_1595015950eusmtrp18;
        Fri,  6 Dec 2019 10:11:45 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-0f-5dea29614af9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6C.25.07950.1692AED5; Fri,  6
        Dec 2019 10:11:45 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191206101144eusmtip1634d1d2d38ea75b4c6a4908131de1e4c~dwID1KgfU0621706217eusmtip10;
        Fri,  6 Dec 2019 10:11:44 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH] devfreq: move declaration of DEVICE_ATTR_RW(min_freq)
Date:   Fri,  6 Dec 2019 11:11:29 +0100
Message-Id: <20191206101129.15232-1-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87qJmq9iDS41mllsnLGe1eL6l+es
        Fgs+zWC1OH9+A7vF2aY37BaXd81hs/jce4TRYu2Ru+wWtxtXsDlwemxa1cnm0bdlFaPH501y
        AcxRXDYpqTmZZalF+nYJXBldnT9YChZxVKz5bN7A+Imti5GTQ0LAROLb651MXYxcHEICKxgl
        ttxeD+V8YZS4cuQEG4TzmVFi8fN3jDAt37+eYIVILGeUODBxEjNcy64rDewgVWwC+hIHz55k
        AbFFBKQlOhdNBJvLLHCMSWLXob+sIAlhATeJ/sW7gLo5OFgEVCW672uBhHkFbCTa13xiBAlL
        CMhLzHmrAREWlDg58wnYSGagcPPW2WB7JQQ+s0kc//Ee6joXiZYZx9ghbGGJV8e3QNkyEqcn
        97BA2OUSTxf2sUM0tzBKPGj/CJWwljh8/CIryGJmAU2J9bv0IcKOEn8/34C6h0/ixltBiBv4
        JCZtm84MEeaV6GgTgqhWlXh+qocJwpaW6Pq/jhXC9pDo3dLFDGILCcRKbLvxlHUCo8IsJJ/N
        QvLZLIQbFjAyr2IUTy0tzk1PLTbOSy3XK07MLS7NS9dLzs/dxAhMNKf/Hf+6g3Hfn6RDjAIc
        jEo8vDM+v4gVYk0sK67MPcQowcGsJMKbzvcyVog3JbGyKrUoP76oNCe1+BCjNAeLkjiv8SKg
        lEB6YklqdmpqQWoRTJaJg1OqgVH07Yul8rGfmtN/Tko0OJx1+eqGwzE3zF5dXcl99uzFl7mc
        PXM+RlzK3bbaq3WGve/v8oD9zRYcnAaW8Qs25uwwak6IrdJ66i89+ezG1ddDdHlPHhPYnmTX
        91GvtXRv7Nx/39zFtlapXVi+sbpMztT+j4/uyxduxdzP2Bhbbc2j1jZ/bDac/1KJpTgj0VCL
        uag4EQCrQd7BMAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsVy+t/xu7qJmq9iDZp+ClhsnLGe1eL6l+es
        Fgs+zWC1OH9+A7vF2aY37BaXd81hs/jce4TRYu2Ru+wWtxtXsDlwemxa1cnm0bdlFaPH501y
        AcxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehld
        nT9YChZxVKz5bN7A+Imti5GTQ0LAROL71xOsILaQwFJGiTOLzCHi0hKNp1czQdjCEn+udQHV
        cwHVfGKUeLLjPzNIgk1AX+Lg2ZMsILYIUEPnoolgDcwCZ5gkfrVUgNjCAm4S/Yt3AdVzcLAI
        qEp039cCCfMK2Ei0r/nECBKWEJCXmPNWAyIsKHFy5hMWiCnyEs1bZzNPYOSbhSQ1C0lqASPT
        KkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMDg3nbs55YdjF3vgg8xCnAwKvHwzvj8IlaINbGs
        uDL3EKMEB7OSCG8638tYId6UxMqq1KL8+KLSnNTiQ4ymQKdOZJYSTc4HRl5eSbyhqaG5haWh
        ubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGi0u59gbYffuWbnz+RPHv1HdWIc4P
        quweCTOuCli6+FFQ4fLqzip30Y0y3Sz/N8zyVj0UoDvnbR2P/JqDscL5XJPDOhvf7p8jLvTm
        0M2JjitbgtNPR8j9i/xW78nwwbhHdC2HY/vUh1mczVOXp+vlhiypSJwza6r8i/I14kEla7Lv
        WUsK/NyoxFKckWioxVxUnAgAS6yZ7IQCAAA=
X-CMS-MailID: 20191206101145eucas1p26ed05a4d6d805c26c8ad92ad6b602f9d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191206101145eucas1p26ed05a4d6d805c26c8ad92ad6b602f9d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191206101145eucas1p26ed05a4d6d805c26c8ad92ad6b602f9d
References: <CGME20191206101145eucas1p26ed05a4d6d805c26c8ad92ad6b602f9d@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Declaration of DEVICE_ATTR_RW(min_freq) is placed after function
max_freq_store. Move it to the correct place after min_freq_show.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 1786a86b1779..46a7ff7c2994 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1368,6 +1368,7 @@ static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
 
 	return sprintf(buf, "%lu\n", min_freq);
 }
+static DEVICE_ATTR_RW(min_freq);
 
 static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
@@ -1391,7 +1392,6 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 
 	return count;
 }
-static DEVICE_ATTR_RW(min_freq);
 
 static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
-- 
2.24.0

