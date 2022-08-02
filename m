Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54448587F35
	for <lists+linux-pm@lfdr.de>; Tue,  2 Aug 2022 17:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiHBPqE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Aug 2022 11:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHBPqE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Aug 2022 11:46:04 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6A1E03
        for <linux-pm@vger.kernel.org>; Tue,  2 Aug 2022 08:45:58 -0700 (PDT)
X-QQ-mid: bizesmtp90t1659455153tuyioh5o
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 02 Aug 2022 23:45:32 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: c88coFtlRu3V8JQWJLOWacg7wbDZcWwZl/3uE0SI+BoMiFXhSlXd9DMEuEzCZ
        E43LbE8cyYbRCIfiqPsQI5tNdBOfFBDEJSyy9dV+hG3N/I5TIO37u9ZI2F5Sf81EUFYk2D8
        akhsBhCxo79hU+vZs7UtVZjgqcFBffg85Ge14XhhF3eDudL8E2/Ddm3V0Kq1a4xEzqpWWSB
        6rnt9kw79VtufPoI64Fd5sBuiqJ5r8BSFlyVRVx7hQBhBhK6NkioXdRkWbwtGCvrVH2vUJd
        IMb7DIBNYcgmzq7u4absigg+PWiGN4/pJoG+cKHMqAFUX/Ci1O4jJGKrPDV63qb7RIpFKFn
        kNKbdZknHoxNiqbMd6DZw8PrrJ2Ksy7MQO+eKOSHo2lpJXvL+c=
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     trenn@suse.com, shuah@kernel.org
Cc:     linux-pm@vger.kernel.org, Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] cpupowerutils: Delete repeated word in comments
Date:   Tue,  2 Aug 2022 11:45:30 -0400
Message-Id: <20220802154530.18521-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Shaomin Deng <dengshaomin@cdjrlc.com>

Delete the repeated word "cpu" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 tools/power/cpupower/bench/system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/bench/system.c b/tools/power/cpupower/bench/system.c
index 40f3679e70b5..eb79dd9ac670 100644
--- a/tools/power/cpupower/bench/system.c
+++ b/tools/power/cpupower/bench/system.c
@@ -37,7 +37,7 @@ long long int get_time()
  * sets the cpufreq governor
  *
  * @param governor cpufreq governor name
- * @param cpu cpu for which the governor should be set
+ * @param cpu for which the governor should be set
  *
  * @retval 0 on success
  * @retval -1 when failed
-- 
2.25.1

