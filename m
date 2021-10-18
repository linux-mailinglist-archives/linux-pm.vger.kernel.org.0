Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049304317B8
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 13:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhJRLsJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 07:48:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37996 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhJRLsI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 07:48:08 -0400
Date:   Mon, 18 Oct 2021 11:45:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634557556;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BRnTgr0+wEcPom5foA5Xa6QkFYTm6AOJtqFPWL4Z76M=;
        b=OQxwaBT0su6p8W0eATI08Is/NJQZcVQzxvOFwYAeSgakXgVHS5fcPG1hd7Xk1LNg5n0G9D
        iVkXnKnHItA2AhUkeYKMNpKlvsPzQJwWT7oDP1R8YDKR2zy/GyJTXJX0/HOSKK/g05GSPa
        7ZG7w/qjeAuBB65xIz7rtwLx4O+snLQWFNP/m20Xfz8ks0lBqUwDinM2YhnfPI7qKxTXIG
        O89yfU71WCIkPqymE9+V6Vzdrerqwg+TdgYnJrJi+elpCabDzrHVmB6E+daV7nQOv/0iE3
        jzAV8VzQBrUtCYOzaTrMTiLHR2KotcDJKmo1VTG7binB2PvdgbfBYDq0La0BTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634557556;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BRnTgr0+wEcPom5foA5Xa6QkFYTm6AOJtqFPWL4Z76M=;
        b=cXX2Vpw6nQnWVYdAJz9td+QbUIpb7fHPRatPEIA5FYaIeRImhp3BMVOzt3LF1hGQr3Tr+i
        vydTXXFioMCBZMDQ==
From:   "thermal-bot for Ansuel Smith" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tsens: Add timeout to
 get_temp_tsens_valid
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20211007172859.583-1-ansuelsmth@gmail.com>
References: <20211007172859.583-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Message-ID: <163455755542.25758.4594820260494925278.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     d012f9189fda0f3a1b303780ba0bbc7298d0d349
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//d012f9189fda0f3a1b303780ba0bbc7298d0d349
Author:        Ansuel Smith <ansuelsmth@gmail.com>
AuthorDate:    Thu, 07 Oct 2021 19:28:59 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 16 Oct 2021 20:24:43 +02:00

thermal/drivers/tsens: Add timeout to get_temp_tsens_valid

The function can loop and lock the system if for whatever reason the bit
for the target sensor is NEVER valid. This is the case if a sensor is
disabled by the factory and the valid bit is never reported as actually
valid. Add a timeout check and exit if a timeout occurs. As this is
a very rare condition, handle the timeout only if the first read fails.
While at it also rework the function to improve readability and convert
to poll_timeout generic macro.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20211007172859.583-1-ansuelsmth@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b1162e5..99a8d9f 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -603,22 +603,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 	int ret;
 
 	/* VER_0 doesn't have VALID bit */
-	if (tsens_version(priv) >= VER_0_1) {
-		ret = regmap_field_read(priv->rf[valid_idx], &valid);
-		if (ret)
-			return ret;
-		while (!valid) {
-			/* Valid bit is 0 for 6 AHB clock cycles.
-			 * At 19.2MHz, 1 AHB clock is ~60ns.
-			 * We should enter this loop very, very rarely.
-			 */
-			ndelay(400);
-			ret = regmap_field_read(priv->rf[valid_idx], &valid);
-			if (ret)
-				return ret;
-		}
-	}
+	if (tsens_version(priv) == VER_0)
+		goto get_temp;
+
+	/* Valid bit is 0 for 6 AHB clock cycles.
+	 * At 19.2MHz, 1 AHB clock is ~60ns.
+	 * We should enter this loop very, very rarely.
+	 * Wait 1 us since it's the min of poll_timeout macro.
+	 * Old value was 400 ns.
+	 */
+	ret = regmap_field_read_poll_timeout(priv->rf[valid_idx], valid,
+					     valid, 1, 20 * USEC_PER_MSEC);
+	if (ret)
+		return ret;
 
+get_temp:
 	/* Valid bit is set, OK to read the temperature */
 	*temp = tsens_hw_to_mC(s, temp_idx);
 
