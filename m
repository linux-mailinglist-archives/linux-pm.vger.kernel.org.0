Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329005F8E10
	for <lists+linux-pm@lfdr.de>; Sun,  9 Oct 2022 22:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJIUxL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Oct 2022 16:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiJIUwY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Oct 2022 16:52:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A4E2FFC0;
        Sun,  9 Oct 2022 13:52:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99B6560C4F;
        Sun,  9 Oct 2022 20:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1D1C433C1;
        Sun,  9 Oct 2022 20:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665348728;
        bh=sO3qeFRmk2abLCeiuvM40rE2MlBvScvIuhhFNrA1ZVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jv+ZvW4mpqN6GfuNrNUHojDuqIPBKyUKK+A3wjUxdckLDmDQhu+ZzZrSKl5Gv32Z+
         SenGZeLRavstYdjkqw6PAeWWDXrgIpWAASWTgwnEpbjBHIaj0tdAGZAjdI3R5Ll+gp
         fyY6K03N/kJJ6xpAOjgpYrPRmnw5Ywuk+dYpGZvLsmfEGeu/t5mosGmSObiZjJm2YZ
         kDOAyZdmwJEL/jBJgxMpdpTMi7oiELJg7SFxKGVIbW6AqMs56aRYlCHU+oizCoft7j
         rv6eTeaoYs2k/HX1ut5AyNxpoxSZVeBjYmy/xYp4nhD8csZth7f5CyvwuaU5fTh5m8
         voDSuBUBi5wDA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        daniel.lezcano@linaro.org, rikard.falkeborn@gmail.com,
        yury.norov@gmail.com, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.0 13/18] thermal: intel_powerclamp: Use get_cpu() instead of smp_processor_id() to avoid crash
Date:   Sun,  9 Oct 2022 16:51:30 -0400
Message-Id: <20221009205136.1201774-13-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221009205136.1201774-1-sashal@kernel.org>
References: <20221009205136.1201774-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 68b99e94a4a2db6ba9b31fe0485e057b9354a640 ]

When CPU 0 is offline and intel_powerclamp is used to inject
idle, it generates kernel BUG:

BUG: using smp_processor_id() in preemptible [00000000] code: bash/15687
caller is debug_smp_processor_id+0x17/0x20
CPU: 4 PID: 15687 Comm: bash Not tainted 5.19.0-rc7+ #57
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x63
dump_stack+0x10/0x16
check_preemption_disabled+0xdd/0xe0
debug_smp_processor_id+0x17/0x20
powerclamp_set_cur_state+0x7f/0xf9 [intel_powerclamp]
...
...

Here CPU 0 is the control CPU by default and changed to the current CPU,
if CPU 0 offlined. This check has to be performed under cpus_read_lock(),
hence the above warning.

Use get_cpu() instead of smp_processor_id() to avoid this BUG.

Suggested-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
[ rjw: Subject edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/intel/intel_powerclamp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index c841ab37e7c6..46cd799af148 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -532,8 +532,10 @@ static int start_power_clamp(void)
 
 	/* prefer BSP */
 	control_cpu = 0;
-	if (!cpu_online(control_cpu))
-		control_cpu = smp_processor_id();
+	if (!cpu_online(control_cpu)) {
+		control_cpu = get_cpu();
+		put_cpu();
+	}
 
 	clamping = true;
 	schedule_delayed_work(&poll_pkg_cstate_work, 0);
-- 
2.35.1

