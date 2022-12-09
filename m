Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC42648538
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiLIP1F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiLIP0l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448D8900EA
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:35 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Q7BZmplsLxw1fz9rvvVU+ux7aFJaWkqq1UuYlShEQM=;
        b=NkTOC1s4bdpy/JuS4ohKzMKxWWrX5VZva7KGKlmOa42Hq9W4DUgc4yH7Csr+THbkpxWClO
        78JE8YJh6QOwi1FDFCTDIW/tVgnP/kKQ/2QF1htFapXNE6ZkqXhnL91sD1+2svzSMfrlVT
        f7bx/jaY8WXbz1ddf+csgtDmJuO2tOgVqfU8XvOGyOYzM0IwVcj5g11++wTNJ8T+GXlxrW
        YVTKR7jnDo/bbaeTlSfR0FxPnpCXKjWKiFgSlggwyu6I6QBTqm7Li6CJYmdkdMvN/v4udv
        tgcr16zkUPlVcjDX7gV6grFdCSE7JFVN8h98a5VXq37cJmdmMxqb/zLt6NXpuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Q7BZmplsLxw1fz9rvvVU+ux7aFJaWkqq1UuYlShEQM=;
        b=+7EinEdj5SFnDv7PeO3XjkijccM0aBiYXfbdMVT4pIyQrjt8X96otdc0jH7UTcCsxpuz0O
        ZBv6aF+URP6KRcCg==
From:   "thermal-bot for Marcus Folkesson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/imx8mm_thermal: Use GENMASK()
 when appropriate
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20221014081620.1599511-1-marcus.folkesson@gmail.com>
References: <20221014081620.1599511-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Message-ID: <167059959160.4906.676834455950682920.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     1043376c94ebc57ddb4c2ce5be2bb41dcb8459b2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//1043376c94ebc57ddb4c2ce5be2bb41dcb8459b2
Author:        Marcus Folkesson <marcus.folkesson@gmail.com>
AuthorDate:    Fri, 14 Oct 2022 10:16:20 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:43 +01:00

thermal/drivers/imx8mm_thermal: Use GENMASK() when appropriate

GENMASK() is preferred to use for bitmasks.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Link: https://lore.kernel.org/r/20221014081620.1599511-1-marcus.folkesson@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/imx8mm_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index e2c2673..68608d8 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -23,8 +23,8 @@
 
 #define TER_ADC_PD		BIT(30)
 #define TER_EN			BIT(31)
-#define TRITSR_TEMP0_VAL_MASK	0xff
-#define TRITSR_TEMP1_VAL_MASK	0xff0000
+#define TRITSR_TEMP0_VAL_MASK	GENMASK(7, 0)
+#define TRITSR_TEMP1_VAL_MASK	GENMASK(23, 16)
 
 #define PROBE_SEL_ALL		GENMASK(31, 30)
 
