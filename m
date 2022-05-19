Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A1952D2C4
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbiESMoR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbiESMoO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F37BA99D
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:13 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vosng7/NSlMGpz0vi9weuk9xk/nt2/vRFG4VyAn211k=;
        b=EUdxXsNi78QbjCEuB+hIVK9auFDQdAhvF6Dk2YtqhGbM4tJ4XMqZ6u4IKp+J1ffX5jQyhq
        zFw8B09zh0oKEHRLEdhkIhGzvsMuxAwRoKNi7/JnJPxkEkLtHJmSfxbTA802HHQtluy5YY
        KQH+Db1c/25IXOATDBXcLy4reg4rH4ICT1eHX9PeFK7sDz6w0On+f8qDdLRbRceqO3MFTI
        rtfYzAzVevCp6PmmvI9a4kywgrN+ysrGXdjSOYTFof/QLEqbGPD4YU5xNiQ3viSfSNlS0K
        6/x8yaslxfl55RihcWvR/ucJpHhvxdlAslCIv1DCJmdFnFLNlwyg7ZJOSoF1lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vosng7/NSlMGpz0vi9weuk9xk/nt2/vRFG4VyAn211k=;
        b=B9zZKrhTktfvwSFtI9pWax7xTS2FERF9ULYJXpSi+NTu37OLy4ZEu9Jd1QtYY3TvZeY8dq
        P6i3fSxjBidiGvCw==
From:   "thermal-bot for Corentin Labbe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: thermal_of: fix typo on
 __thermal_bind_params
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220426064113.3787826-1-clabbe@baylibre.com>
References: <20220426064113.3787826-1-clabbe@baylibre.com>
MIME-Version: 1.0
Message-ID: <165296425108.4207.3172189754708769819.tip-bot2@tip-bot2>
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

Commit-ID:     44b965d8c44e8e86a43e11fc46adfc60da540c77
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//44b965d8c44e8e86a43e11fc46adfc60da540c77
Author:        Corentin Labbe <clabbe@baylibre.com>
AuthorDate:    Tue, 26 Apr 2022 06:41:13 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:52 +02:00

thermal: thermal_of: fix typo on __thermal_bind_params

Add a missing s to __thermal_bind_param kernel doc comment.
This fixes the following sparse warnings:
drivers/thermal/thermal_of.c:50: warning: expecting prototype for struct __thermal_bind_param. Prototype was for struct __thermal_bind_params instead

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Link: https://lore.kernel.org/r/20220426064113.3787826-1-clabbe@baylibre.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index da48480..b65d435 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -35,7 +35,7 @@ struct __thermal_cooling_bind_param {
 };
 
 /**
- * struct __thermal_bind_param - a match between trip and cooling device
+ * struct __thermal_bind_params - a match between trip and cooling device
  * @tcbp: a pointer to an array of cooling devices
  * @count: number of elements in array
  * @trip_id: the trip point index
