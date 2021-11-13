Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C80844F1B9
	for <lists+linux-pm@lfdr.de>; Sat, 13 Nov 2021 07:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhKMGKa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Nov 2021 01:10:30 -0500
Received: from smtpbg128.qq.com ([106.55.201.39]:59444 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229487AbhKMGK3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 13 Nov 2021 01:10:29 -0500
X-QQ-mid: bizesmtp49t1636783584t7l1s577
Received: from localhost.localdomain (unknown [125.69.41.88])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 13 Nov 2021 14:06:22 +0800 (CST)
X-QQ-SSF: 01000000000000C0F000B00A0000000
X-QQ-FEAT: ZHWZeLXy+8deiOhJyhemFt2XLUKQnkjQhPsS1KmTkVATSnjhBqZq2OsFqLNNW
        Jv90wTSzP/R9q/FEGDhOWsl1C4uqv0pcqrgm1pJ1CFSYawhXJOn8x2gKSojprt7Jo8m2Rvm
        kzUYUdOoNyPyKxEqbjFh3U3HlKBaECJDO8L2AE+wZFu9LGMa+I80MzShUaGtsz6q4OTP928
        DwB5ephWjn60d3KtKR3lRLW1JAUFiEq6EtvPAJ7THGYk4mWFNbdOJzlkuQ/wTfyktvEhlT6
        JsYl104vU5wdGfhwBSPwVWy+yIIbgTEp6Qv5PHbHXtqmyvHqaS5ml6qF+QitJ0duRf9ZmyB
        vmODddjhRpxHktVDzD5/YxNiEi1UFVTErPLvPK3
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, adobriyan@gmail.com, wangborong@cdjrlc.com,
        mingo@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle: menu: Fix typo in a comment
Date:   Sat, 13 Nov 2021 14:06:18 +0800
Message-Id: <20211113060618.220832-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The double word `these' in a comment is repeated, thus
one of them should be removed.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/cpuidle/governors/menu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 2e5670446991..c4922684f305 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -34,7 +34,7 @@
  * 1) Energy break even point
  * 2) Performance impact
  * 3) Latency tolerance (from pmqos infrastructure)
- * These these three factors are treated independently.
+ * These three factors are treated independently.
  *
  * Energy break even point
  * -----------------------
-- 
2.33.0

