Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9371B405990
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbhIIOsF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240885AbhIIOru (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:47:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD92C0698D8
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 07:38:39 -0700 (PDT)
Date:   Thu, 09 Sep 2021 14:38:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631198318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mQFngEwDuIFr6KWI7VI7YA54UpPS26ihjtUbW+sy1tw=;
        b=apSZ7TOtHZrd+jpgtBI54oWXvvo7g95zGA5bLLZMTTAjRzYyma5scMuUSIWLoy5pvR2DDC
        5LVrkyyZ8vjwIwT4lV+MkwlmdWufGV3ftsO59//9MmKaCoqftqsG6SeMegcWl0lmJqVyMi
        2bMTXrYDJB63xvBThg3XJXSD5QT+EiFkNQvjRmKgehzYO21tt0uSJxLxcZnN7pmZg/MBlI
        gAMTOhQYeTTB8p2Pvs6xK9ZBNAPX47YQA1sgIm/n2Mby4ip9fKThygZYnuk23mDAB+Q80k
        V04kKkaJ587MxsiYaibLVYyQPT+6ksWVfCaTQyOiuUkl3kkzI/LspfaS3DMHcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631198318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mQFngEwDuIFr6KWI7VI7YA54UpPS26ihjtUbW+sy1tw=;
        b=T8CJIRT/rX1GH21QWulTC9F9pCQJxSDaXlLo/WsG6v9SmhOaN3NjOk2GYm4S8gxXemptHY
        BGw/Gr+O3hhCclAQ==
From:   "thermal-bot for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: Spelling s/scallbacks/callbacks/
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: =?utf-8?q?=3Cae38372996a23bb67769e2d62ca170ae9457c4df=2E16262?=
 =?utf-8?q?61946=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3Cae38372996a23bb67769e2d62ca170ae9457c4df=2E162626?=
 =?utf-8?q?1946=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
MIME-Version: 1.0
Message-ID: <163119831731.25758.4631237606171951869.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     454f2ed4b34f9ef5726d080b1eb5dc47a7f36d6f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//454f2ed4b34f9ef5726d080b1eb5dc47a7f36d6f
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 14 Jul 2021 13:27:01 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 14 Aug 2021 15:43:28 +02:00

thermal: Spelling s/scallbacks/callbacks/

Fix a misspelling of the word "callbacks".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/ae38372996a23bb67769e2d62ca170ae9457c4df.1626261946.git.geert+renesas@glider.be
---
 include/linux/thermal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 8050d92..c314893 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -285,7 +285,7 @@ struct thermal_zone_params {
 };
 
 /**
- * struct thermal_zone_of_device_ops - scallbacks for handling DT based zones
+ * struct thermal_zone_of_device_ops - callbacks for handling DT based zones
  *
  * Mandatory:
  * @get_temp: a pointer to a function that reads the sensor temperature.
