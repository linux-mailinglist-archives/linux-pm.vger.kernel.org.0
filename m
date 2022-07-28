Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85931584349
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiG1Plp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiG1Plo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EE468DF0
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:43 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1iu+OuVbho1W4IxMvgWrMVnwcC3i/x6bAPA83FMlKw=;
        b=BqB+4qRXSh4XNp9BerZJRg9DS2C96p5VJlFgX0E8DNpVbpD40HN6ZCmKL3LQznPvUwyGE8
        IRcAgT9qWjhleRTRW7NLuH3O2SE3f6DhP36pL/ilA587KpxCDAYRhl5dbZgHOoCJ8iw09S
        E+wYek3UOrhk5ra9KoGNcY40md231hOev1BygotneTprqGI1rNRnlfadh86EizccxGD4XC
        sGNtpz+Hv73KSrC5rcTlf7c1rKU+T/U1LNUNkhH40Dy/x9TRYzKUDSF4y5niPj14qFt/ZD
        mAcVrNpx6mLes5R62kvuf4OpM1sMaFNtvOA0PMBZYuwFcGOH15wa3XsPC7+pyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1iu+OuVbho1W4IxMvgWrMVnwcC3i/x6bAPA83FMlKw=;
        b=pNQVyN3ETwAy48P3AbwgjRiJpYr/bJWgmQzbslBT/LG8OpjgfciEP5l7YXGbXyVEXlZFMk
        j8azYTKaShqI28Bg==
From:   "thermal-bot for Slark Xiao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/tools/tmon: Fix typo 'the the' in comment
Cc:     Slark Xiao <slark_xiao@163.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220722104047.83312-1-slark_xiao@163.com>
References: <20220722104047.83312-1-slark_xiao@163.com>
MIME-Version: 1.0
Message-ID: <165902290116.15455.1637973804937310281.tip-bot2@tip-bot2>
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

Commit-ID:     7a12f9188529d9529704b54ca51d3b6ef4a14094
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//7a12f9188529d9529704b54ca51d3b6ef4a14094
Author:        Slark Xiao <slark_xiao@163.com>
AuthorDate:    Fri, 22 Jul 2022 18:40:47 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:52 +02:00

thermal/tools/tmon: Fix typo 'the the' in comment

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
Link: https://lore.kernel.org/r/20220722104047.83312-1-slark_xiao@163.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 tools/thermal/tmon/pid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/pid.c b/tools/thermal/tmon/pid.c
index 296f69c..da20088 100644
--- a/tools/thermal/tmon/pid.c
+++ b/tools/thermal/tmon/pid.c
@@ -27,7 +27,7 @@
 
 /**************************************************************************
  * PID (Proportional-Integral-Derivative) controller is commonly used in
- * linear control system, consider the the process.
+ * linear control system, consider the process.
  * G(s) = U(s)/E(s)
  * kp = proportional gain
  * ki = integral gain
