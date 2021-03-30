Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975BE34E15A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 08:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhC3GlT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 02:41:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15813 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhC3Gkv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Mar 2021 02:40:51 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F8fsv3H9Dz92s3;
        Tue, 30 Mar 2021 14:38:43 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 14:40:37 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <sre@kernel.org>, <haojian.zhuang@linaro.org>,
        <xuwei5@hisilicon.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: [PATCH] power: reset: hisi-reboot: use the correct HiSilicon copyright
Date:   Tue, 30 Mar 2021 14:38:05 +0800
Message-ID: <1617086285-36565-1-git-send-email-fanghao11@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

s/Hisilicon/HiSilicon/g.
It should use capital S, according to
https://www.hisilicon.com/en/terms-of-use.

Signed-off-by: Hao Fang <fanghao11@huawei.com>
---
 drivers/power/reset/hisi-reboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/hisi-reboot.c b/drivers/power/reset/hisi-reboot.c
index 0ba5fdc..5abc5f6 100644
--- a/drivers/power/reset/hisi-reboot.c
+++ b/drivers/power/reset/hisi-reboot.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Hisilicon SoC reset code
+ * HiSilicon SoC reset code
  *
- * Copyright (c) 2014 Hisilicon Ltd.
+ * Copyright (c) 2014 HiSilicon Ltd.
  * Copyright (c) 2014 Linaro Ltd.
  *
  * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
-- 
2.8.1

