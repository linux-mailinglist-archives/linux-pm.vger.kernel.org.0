Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EF052D2C5
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbiESMoS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbiESMoO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE5FBA994
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:14 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964253;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lVIcKhh/bjiQXHciMJW9uKEqWsDt7/P56ar6YsmSEhM=;
        b=pHkvgO0hFFCesTSc7yRK7/7EnfaWfPfwwN1bGQp3DStDPAwTdAPS5okx8P2LolOJuAJkoP
        uweKJrT+zApjJv43ArJThXP8U0fyx1EaPBRB62vvRqWopwt77adANC0uS9m9ileVlbVSuT
        3P96X8a0ASRK0YWBtdrz3celLpErwydnd0PaYoFUmSMA0PncGvvmqw5umUZeVzhOBJvu1H
        js8syOX1JmYsYOD7qVwc+NjAHaNuCS12iS6VG3tEJFooT6OmaPNJwHs3/WEA38K6x4lS0r
        gSnoRoRpionPr7EHa9DbZZGtEy/CaQ227axNZ7i4i0Eaj/XbqSxfz/racgNVAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964253;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lVIcKhh/bjiQXHciMJW9uKEqWsDt7/P56ar6YsmSEhM=;
        b=xM2Pg63kReBIVyDcZDV9vIiFmqQolUMFYi8GVoTx7yb98bv7H/EI8BjwmqOCri8XcmfSSJ
        Av8q7GIURGQTy+CA==
From:   "thermal-bot for Jiapeng Chong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] tools/thermal: remove unneeded semicolon
Cc:     Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220427030619.81556-2-jiapeng.chong@linux.alibaba.com>
References: <20220427030619.81556-2-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <165296425196.4207.1628826264751962273.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     cb4487d2b4043bbe98f60f2628387b40fa4896f8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//cb4487d2b4043bbe98f60f2628387b40fa4896f8
Author:        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
AuthorDate:    Wed, 27 Apr 2022 11:06:19 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:52 +02:00

tools/thermal: remove unneeded semicolon

Fix the following coccicheck warnings:

./tools/thermal/thermometer/thermometer.c:147:3-4: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Link: https://lore.kernel.org/r/20220427030619.81556-2-jiapeng.chong@linux.alibaba.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 tools/thermal/thermometer/thermometer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/thermometer/thermometer.c b/tools/thermal/thermometer/thermometer.c
index 914986f..1a87a0a 100644
--- a/tools/thermal/thermometer/thermometer.c
+++ b/tools/thermal/thermometer/thermometer.c
@@ -144,7 +144,7 @@ static int configuration_init(const char *path, struct configuration *config)
 		if (!node) {
 			ERROR("Missing node name '%d'\n", i);
 			return -1;
-		};
+		}
 
 		if (!config_setting_lookup_string(node, "name", &name)) {
 			ERROR("Thermal zone name not found\n");
