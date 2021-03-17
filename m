Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFDE33F099
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 13:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCQMjp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 08:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhCQMjP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 08:39:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294C9C06174A
        for <linux-pm@vger.kernel.org>; Wed, 17 Mar 2021 05:39:15 -0700 (PDT)
Date:   Wed, 17 Mar 2021 12:39:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ipyjCMZmobIx5wSecK4+NeqYil2kdcXxyZ/9qO05eXc=;
        b=aNcnV2yjkq/ZzGTgVGxhnyoGX+G06hegBMUDTlD7TL4rzMU7dhffnjuGflyxh3HWs7maDI
        UMH3pfkjJHNfzNDtDH+BwuUTygELUVyU5LNC6Ophla9xbpG9wg8dX/vK5nVq1xvlUoxONj
        EbYlTw9g7b2V611Lo+8sv7uFhKHmHdj86z5hY2XJR2mn3JoF/kW6QWpOryn3A9QxeoIP9p
        dJ6N4jVEyfdEfVBrRo/pxp7Mib8MTuLYTMX9RFXB4ClPC8of4e23+BO9IytJpdLCTNNjFl
        PfFgkO6RgtrNW7KtbdbAu26Xg0KnYWuHkAr84dW3coutR7eCtwYTJsPkqE3LXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ipyjCMZmobIx5wSecK4+NeqYil2kdcXxyZ/9qO05eXc=;
        b=Mrn3EE/m5J2cIbBSpNNEOmJA29l3THsv2btguhY+Jat/PrGA17f3GoOeZTFHAyxXOmr5zu
        7DjVi7E2RExdibDA==
From:   "thermal-bot for Jia-Ju Bai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: thermal_of: Fix error return code of
 thermal_of_populate_bind_params()
Cc:     TOTE Robot <oslab@tsinghua.edu.cn>,
        "Jia-Ju Bai" <baijiaju1990@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210310122423.3266-1-baijiaju1990@gmail.com>
References: <20210310122423.3266-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Message-ID: <161598475248.398.14296931225441425581.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     45c7eaeb29d67224db4ba935deb575586a1fda09
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//45c7eaeb29d67224db4ba935deb575586a1fda09
Author:        Jia-Ju Bai <baijiaju1990@gmail.com>
AuthorDate:    Wed, 10 Mar 2021 04:24:23 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 10 Mar 2021 13:41:33 +01:00

thermal: thermal_of: Fix error return code of thermal_of_populate_bind_params()

When kcalloc() returns NULL to __tcbp or of_count_phandle_with_args()
returns zero or -ENOENT to count, no error return code of
thermal_of_populate_bind_params() is assigned.
To fix these bugs, ret is assigned with -ENOMEM and -ENOENT in these
cases, respectively.

Fixes: a92bab8919e3 ("of: thermal: Allow multiple devices to share cooling map")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210310122423.3266-1-baijiaju1990@gmail.com
---
 drivers/thermal/thermal_of.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 69ef12f..5b76f9a 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -704,14 +704,17 @@ static int thermal_of_populate_bind_params(struct device_node *np,
 
 	count = of_count_phandle_with_args(np, "cooling-device",
 					   "#cooling-cells");
-	if (!count) {
+	if (count <= 0) {
 		pr_err("Add a cooling_device property with at least one device\n");
+		ret = -ENOENT;
 		goto end;
 	}
 
 	__tcbp = kcalloc(count, sizeof(*__tcbp), GFP_KERNEL);
-	if (!__tcbp)
+	if (!__tcbp) {
+		ret = -ENOMEM;
 		goto end;
+	}
 
 	for (i = 0; i < count; i++) {
 		ret = of_parse_phandle_with_args(np, "cooling-device",
