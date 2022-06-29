Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B8755F445
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 05:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiF2Dpk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jun 2022 23:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiF2Dpj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2022 23:45:39 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B452218343;
        Tue, 28 Jun 2022 20:45:38 -0700 (PDT)
X-UUID: 9d20ce9404824614b58d2fa31a7004c1-20220629
X-Spam-Fingerprint: 0
X-GW-Reason: 13103
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HNeS6uumcgOimgeWuoeaguA==
X-Content-Feature: ica/max.line-size 74
        audit/email.address 1
        dict/notice 1
        dict/time 1
        meta/cnt.alert 1
X-CPASD-INFO: f988679151534d35a96f4c0a9043a517@r4lyWGNpZ2FhUXd_g6d-b4FqZpZkj1C
        we2pUZY9lXVeVgnxsTWBnX1OEgnBQYl5dZFZ3dG9RYmBgYlB_i4Jyj1RiXmCCVHSTgKhzWGpkZw==
X-CLOUD-ID: f988679151534d35a96f4c0a9043a517
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:2.0,URL:-5,TVAL:182.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:143.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:2.0,CFOB:2.0,SPC:0,SIG:-
        5,AUF:8,DUF:135,ACD:2,DCD:2,SL:0,EISP:0,AG:0,CFC:0.576,CFSR:0.037,UAT:0,RAF:0
        ,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0,EAF:
        0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 9d20ce9404824614b58d2fa31a7004c1-20220629
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 9d20ce9404824614b58d2fa31a7004c1-20220629
X-User: xiongxin@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <xiongxin@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1270190514; Wed, 29 Jun 2022 09:12:15 +0800
From:   xiongxin <xiongxin@kylinos.cn>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        xiongxin@kylinos.cn, luriwen@kylinos.cn
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next 1/2] PM: suspend: expand the assignment scope of the pm_suspend_target_state
Date:   Wed, 29 Jun 2022 09:11:45 +0800
Message-Id: <20220629011146.299521-2-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629011146.299521-1-xiongxin@kylinos.cn>
References: <20220629011146.299521-1-xiongxin@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RCVD_IN_PBL,RDNS_DYNAMIC,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pm_suspend_target_state variable can be used as a suspend state
identifier and given to the specific device driver as a code judgment;

Because the suspend_prepare() function is time-consuming for the
operation of freezing processes, and this stage is actually in the suspend
stage, it is necessary to expand the scope of the pm_suspend_target_state
variable to be assigned to the suspend state at enter_state() function;

Another reason is that the specific device driver can locate whether it is
in the suspend state based on this variable, so as to determine the
validity of its wake-up source.

Signed-off-by: xiongxin <xiongxin@kylinos.cn>
---
 kernel/power/suspend.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 827075944d28..c754b084ec03 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -564,6 +564,12 @@ static int enter_state(suspend_state_t state)
 	if (state == PM_SUSPEND_TO_IDLE)
 		s2idle_begin();
 
+	/*
+	 * Expand the scope of suspend state for suspend operations
+	 * performed from the /sys/power/state entry.
+	 */
+	pm_suspend_target_state = state;
+
 	if (sync_on_suspend_enabled) {
 		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
 		ksys_sync_helper();
@@ -590,6 +596,7 @@ static int enter_state(suspend_state_t state)
 	pm_pr_dbg("Finishing wakeup.\n");
 	suspend_finish();
  Unlock:
+	pm_suspend_target_state = PM_SUSPEND_ON;
 	mutex_unlock(&system_transition_mutex);
 	return error;
 }
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
