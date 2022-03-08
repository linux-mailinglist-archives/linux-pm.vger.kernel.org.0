Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D391E4D22AB
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 21:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350246AbiCHUex (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 15:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350254AbiCHUew (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 15:34:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0609241607
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 12:33:54 -0800 (PST)
Date:   Tue, 08 Mar 2022 20:33:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646771632;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tA6c+A0ZugBN7VaMCbeT47P2jjejSxx1a9NkzxOesWE=;
        b=Z0YwdG2zVA+icIvxPPx3wjJ7jvAcwm+8o6T5rmgPdIVXzHgW+lJxgE+id1E6RZrlE6k5i+
        TUGPi6gn7FhqxB7jrjjBnQstZ+bPGT9t8qcHYYSnB71x5e0gSCupuqKnwIWw8VCoG2TD4u
        UgKqwl1utWyFlBMdUaWmn3TIdf/KY3j4Iv1WJ9UASMGfQRHy7VCG5PYJgM0EJodt0Bhm7p
        xOMr0qVcrfSaW5lVhjy1S/cF/YxPe11ic30X7k3/MI+yGsyDMw7WTs67uVQnsQ5rGGooGi
        Ox2PT0L2lLw0M9KIXCEPQcPQ1oNvKUomDTZxVeDoTfSs8aLiObwRF5II2k6MtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646771632;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tA6c+A0ZugBN7VaMCbeT47P2jjejSxx1a9NkzxOesWE=;
        b=GnhukadUovz66UeN8W19ywVcyQUekRIE6ecd3PFZZMfwrsZpOohadVvjn4hC4tbuD2PZUk
        bnwCtAOLd/mWtLBw==
From:   "thermal-bot for Dmitry Baryshkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tsens: register thermal zones
 as hwmon sensors
Cc:     Amit Kucheria <amitk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
In-Reply-To: <20220129180750.1882310-1-dmitry.baryshkov@linaro.org>
References: <20220129180750.1882310-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Message-ID: <164677163007.16921.12143354781302766435.tip-bot2@tip-bot2>
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

Commit-ID:     8556e19d4939fbdb15aee9391f035453c5b2255a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//8556e19d4939fbdb15aee9391f035453c5b2255a
Author:        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
AuthorDate:    Sat, 29 Jan 2022 21:07:50 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 08 Mar 2022 21:26:08 +01:00

thermal/drivers/tsens: register thermal zones as hwmon sensors

Register thermal zones as hwmon sensors to let userspace read
CPU temperatures using standard hwmon interface.

Acked-by: Amit Kucheria <amitk@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20220129180750.1882310-1-dmitry.baryshkov@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 99a8d9f..154d3cb 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -18,6 +18,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
+#include "../thermal_hwmon.h"
 #include "tsens.h"
 
 /**
@@ -1060,6 +1061,10 @@ static int tsens_register(struct tsens_priv *priv)
 		priv->sensor[i].tzd = tzd;
 		if (priv->ops->enable)
 			priv->ops->enable(priv, i);
+
+		if (devm_thermal_add_hwmon_sysfs(tzd))
+			dev_warn(priv->dev,
+				 "Failed to add hwmon sysfs attributes\n");
 	}
 
 	/* VER_0 require to set MIN and MAX THRESH
