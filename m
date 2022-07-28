Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBFE584350
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiG1Plw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiG1Plv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888CF69F2E
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:50 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whO/bydgWwNS6IRQrcq+YXw4GnlKQ9np5ljGKOZJWQ4=;
        b=NcqnwCLAH6Gkae+l4KpSJSxUZveJGMaJlCvtwrhUB/wpF2yQal4Gd+YC30eTvxxLO+oArD
        sOwMu3bn7PqXcD9SjyD1sVVaCa8W+Af3QZtKKheZ1AAOrdg1sbGXg857SK/bwPLwErCBBu
        62o6qKyOMs/Qz+8di0+zWUj8vcsAlBZk/pHPGKgO4FzadnunAfEuMxX9hb9J/LZGWBRvfv
        E9wE6N5tejHwYZMyFNojil1whUkdEjTLZ1EbkZ7i/mzXmLN5a8Z6LGAsSAoU4hGq5zn7g3
        gAt0A/jr0+uhOyQluu+UHsEg7J/kDBxhPmSVKdd/DxmUkpOCt9PXAm/GR4fvng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whO/bydgWwNS6IRQrcq+YXw4GnlKQ9np5ljGKOZJWQ4=;
        b=6IT4Gdg6KiQs2LQA9zdxW7lJXb5zZ9SW0PwBeKZ+xDcQcKqEPZMex/CPnpQMYy/m5DGsXz
        IIoQRlRxkXXZnTCg==
From:   "thermal-bot for Julia Lawall" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/sun8i: Fix typo in comment
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220521111145.81697-36-Julia.Lawall@inria.fr>
References: <20220521111145.81697-36-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Message-ID: <165902290780.15455.801425426946519060.tip-bot2@tip-bot2>
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

Commit-ID:     11188b439974b8ef8fe8c4c6df6ab8b6486c8c45
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//11188b439974b8ef8fe8c4c6df6ab8b6486c8c45
Author:        Julia Lawall <Julia.Lawall@inria.fr>
AuthorDate:    Sat, 21 May 2022 13:10:46 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:49 +02:00

thermal/drivers/sun8i: Fix typo in comment

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Acked-by: Vasily Khoruzhick <anarsoul@gmail.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Link: https://lore.kernel.org/r/20220521111145.81697-36-Julia.Lawall@inria.fr
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/sun8i_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index d9cd23c..212c87e 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -237,7 +237,7 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 	 * The calibration data on the H6 is the ambient temperature and
 	 * sensor values that are filled during the factory test stage.
 	 *
-	 * The unit of stored FT temperature is 0.1 degreee celusis.
+	 * The unit of stored FT temperature is 0.1 degree celsius.
 	 *
 	 * We need to calculate a delta between measured and caluclated
 	 * register values and this will become a calibration offset.
