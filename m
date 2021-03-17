Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AB133F097
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 13:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhCQMjq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 08:39:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49820 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhCQMjO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 08:39:14 -0400
Date:   Wed, 17 Mar 2021 12:39:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984754;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2KVDagARgEqJCXRFinYryzqaLRMen55//SALzdx+C9c=;
        b=m3tamVcX4zYE2xC0nBN/6jkFxYdnJsZLNqeeAcAYLXOOpm3diZCdTF56GtrH8T2BY0a0mF
        aH0SjpvVLPHEd0Q6FSqpJJok655g9p1z6bniWYGXvKqHf72Omz6SnGIllbCKeVMYPYoePj
        PqywbWmF6yTXKcoJrV1jQXObhidVTGzHRQBbYl4gPte/IdMfAOnRj/cjbLsXJAOGk41ehJ
        H2f7uZ5sw6829SnWmV5Gw6JHAgJGFoo2WRdHzA1cmO0gInGpszbVWOwXsKPiBTSCil31g1
        AzBOmvLftbrJ7sdeCJ0pf3wvHuQE7v4ozf3xZ7lS3d/XQVj6hQZ9B0y92bnMYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984754;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2KVDagARgEqJCXRFinYryzqaLRMen55//SALzdx+C9c=;
        b=5FdtEFK4zDDz0yQtaK8bc2BLByE0wjNWBhQh7VDZoU6CWV2xY3vFme4Tu0Ue0ysj+8vfTk
        9V3nKI1mFJJPkXAw==
From:   "thermal-bot for Bhaskar Chowdhury" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: Fix couple of spellos in the file
 sun8i_thermal.c
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210305014348.17412-1-unixbhaskar@gmail.com>
References: <20210305014348.17412-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Message-ID: <161598475356.398.6972397347901219162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     76d6329534ae3b2f344aa72cc978ef4cfd69c0c8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//76d6329534ae3b2f344aa72cc978ef4cfd69c0c8
Author:        Bhaskar Chowdhury <unixbhaskar@gmail.com>
AuthorDate:    Fri, 05 Mar 2021 07:13:48 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 10 Mar 2021 12:54:58 +01:00

thermal: Fix couple of spellos in the file sun8i_thermal.c

s/calibartion/calibration/
s/undocummented/undocumented/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210305014348.17412-1-unixbhaskar@gmail.com
---
 drivers/thermal/sun8i_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 8c80bd0..d9cd23c 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -300,7 +300,7 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
 		 * or 0x8xx, so they won't be away from the default value
 		 * for a lot.
 		 *
-		 * So here we do not return error if the calibartion data is
+		 * So here we do not return error if the calibration data is
 		 * not available, except the probe needs deferring.
 		 */
 		goto out;
@@ -418,7 +418,7 @@ static int sun8i_h3_thermal_init(struct ths_device *tmdev)
 }
 
 /*
- * Without this undocummented value, the returned temperatures would
+ * Without this undocumented value, the returned temperatures would
  * be higher than real ones by about 20C.
  */
 #define SUN50I_H6_CTRL0_UNK 0x0000002f
