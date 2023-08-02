Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EC976C2F6
	for <lists+linux-pm@lfdr.de>; Wed,  2 Aug 2023 04:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjHBCem (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Aug 2023 22:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHBCel (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2023 22:34:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7831B2
        for <linux-pm@vger.kernel.org>; Tue,  1 Aug 2023 19:34:40 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RFwvn0y4GztQT9;
        Wed,  2 Aug 2023 10:31:17 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 10:34:38 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <sebastian.reichel@collabora.com>
CC:     <liaoyu15@huawei.com>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-pm@vger.kernel.org>,
        <liwei391@huawei.com>
Subject: [PATCH -next] power: Fix uninitialized variable usage in smb2_status_change_work()
Date:   Wed, 2 Aug 2023 10:31:30 +0800
Message-ID: <20230802023130.2516232-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

smatch warnings:
  drivers/power/supply/qcom_pmi8998_charger.c:565 smb2_status_change_work() error: uninitialized symbol 'usb_online'.

usb_online is used uninitialized whenever smb2_get_prop_usb_online()
returns a negative value.

Thus, fix the issue by initializing usb_online to 0.

Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202307280638.556PrzIS-lkp@intel.com/
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/power/supply/qcom_pmi8998_charger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_pmi8998_charger.c b/drivers/power/supply/qcom_pmi8998_charger.c
index d16c5ee17249..cac89d233c38 100644
--- a/drivers/power/supply/qcom_pmi8998_charger.c
+++ b/drivers/power/supply/qcom_pmi8998_charger.c
@@ -556,7 +556,8 @@ static int smb2_set_current_limit(struct smb2_chip *chip, unsigned int val)
 static void smb2_status_change_work(struct work_struct *work)
 {
 	unsigned int charger_type, current_ua;
-	int usb_online, count, rc;
+	int usb_online = 0;
+	int count, rc;
 	struct smb2_chip *chip;
 
 	chip = container_of(work, struct smb2_chip, status_change_work.work);
-- 
2.25.1

