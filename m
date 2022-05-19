Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D39952D2C6
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbiESMoS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238003AbiESMoP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F162BA57A
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:15 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964253;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UT4db1IZhDvOQ210swy4MlPuECKJesUI7pS7NbtS0u8=;
        b=d0hWy85l3e5rd2eRdFg3vYgQf+A8rWkMNZzWUdA2cAtgL8rY2FznoxcrXLKL5OHj9u0nRP
        KAIAx/OC4wcq8Ki3h+t7eMX24F8PF395rC/bWsF1GuOuCycMgAaE0VoUjfzFMjSMLi5v2y
        MkNqHcet3/oE6v9FzpkbYz8aou4jh2NBwCL/ywc4JD75VyvR8gDSfrdfJQQ0a1bhcWQEtk
        zw3L19v4SYD7JtyhDxBH9ExeJzxmkgN7mDwQ/0akXWnaBZXRPZxNHY53SjlYA+p7xxDNVC
        aeqe4G8YN8rb4j09M2fHYk/rmJUv6dFpO7R68UjWNK921ImNCWlEZSbdyBlDSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964253;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UT4db1IZhDvOQ210swy4MlPuECKJesUI7pS7NbtS0u8=;
        b=PuCdldnQX6K+V7OHgzpeukEdO1l/zKR/tUKugla7Sf87LrMAhw/xTYOmlmQKV4CCh7Bmph
        6byPsmeRezDLVQBA==
From:   "thermal-bot for Jiapeng Chong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] tools/lib/thermal: remove unneeded semicolon
Cc:     Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220427030619.81556-1-jiapeng.chong@linux.alibaba.com>
References: <20220427030619.81556-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <165296425281.4207.1135914442258082055.tip-bot2@tip-bot2>
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

Commit-ID:     f21b57eb12bfe0d38794145f976ca8127d8846db
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//f21b57eb12bfe0d38794145f976ca8127d8846db
Author:        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
AuthorDate:    Wed, 27 Apr 2022 11:06:18 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:52 +02:00

tools/lib/thermal: remove unneeded semicolon

Fix the following coccicheck warnings:

./tools/lib/thermal/commands.c:215:2-3: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Link: https://lore.kernel.org/r/20220427030619.81556-1-jiapeng.chong@linux.alibaba.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 tools/lib/thermal/commands.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/thermal/commands.c b/tools/lib/thermal/commands.c
index 4e289ca..73d4d4e 100644
--- a/tools/lib/thermal/commands.c
+++ b/tools/lib/thermal/commands.c
@@ -212,7 +212,7 @@ static int handle_netlink(struct nl_cache_ops *unused,
 
 	default:
 		return THERMAL_ERROR;
-	};
+	}
 
 	return ret;
 }
