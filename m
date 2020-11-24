Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDED92C219D
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 10:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbgKXJgt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 04:36:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41996 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731412AbgKXJgp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 04:36:45 -0500
Date:   Tue, 24 Nov 2020 09:36:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606210603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XBTnKv9xGZXqUan4gxnt8PICOA0KJEV8MjfsJPWBaIM=;
        b=Y2VbOtcuZV/mMrkpXAb3h01OEq4Q4mDlCeZUHMtLVGJDOr/6gLd3C2NXSpM3DYyxGKZ7Aj
        xFYZl05HI93H7U4e8g2/v0afq46eiJR2JWRg8oT35WbdHuocMq8x9swCvLEupXzTNER4rT
        WUqIe4JjxW3tnSEu9KSHfJWYYFBq0SH0XOo4DUzxESjjFTBXVgJe1rrhfDVM+KOvuBY5Nz
        RY4glskz6t4DKRoasy+YUfep3rYn6W+ULM5LlCuY1HiwhuNVy/lhtGrDF6TDss6jcG7w5y
        1GAElGrmvWUvEWuN+BwnxLZfWoaC7ifkc53vyVtlEjwA7G7yaNk0/LJB769xsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606210603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XBTnKv9xGZXqUan4gxnt8PICOA0KJEV8MjfsJPWBaIM=;
        b=jQJQqodQiKIRlHT68dJJuvogZtfY/gif1wZqI47lwy+FFxcNkn+MoAF12yz7rhXHiifdA2
        FSvhF3BtHrKxbKDA==
From:   "thermal-bot for Bernard Zhao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] drivers/thermal/core: Optimize trip points check
Cc:     Bernard Zhao <bernard@vivo.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201027013743.62392-1-bernard@vivo.com>
References: <20201027013743.62392-1-bernard@vivo.com>
MIME-Version: 1.0
Message-ID: <160621060274.11115.1871630758046158914.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     37b2539e63d6570c9ee51b1d48bdecb334df367d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//37b2539e63d6570c9ee51b1d48bdecb334df367d
Author:        Bernard Zhao <bernard@vivo.com>
AuthorDate:    Mon, 26 Oct 2020 18:37:42 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 27 Oct 2020 09:53:19 +01:00

drivers/thermal/core: Optimize trip points check

The trip points are checked one by one with multiple condition
branches where one condition is enough to disable the trip point.

Merge all these conditions in a single 'OR' statement.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201027013743.62392-1-bernard@vivo.com

[dlezcano] Changed patch description
---
 drivers/thermal/thermal_core.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 96349ba..90e38cc 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1358,12 +1358,9 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 		goto release_device;
 
 	for (count = 0; count < trips; count++) {
-		if (tz->ops->get_trip_type(tz, count, &trip_type))
-			set_bit(count, &tz->trips_disabled);
-		if (tz->ops->get_trip_temp(tz, count, &trip_temp))
-			set_bit(count, &tz->trips_disabled);
-		/* Check for bogus trip points */
-		if (trip_temp == 0)
+		if (tz->ops->get_trip_type(tz, count, &trip_type) ||
+		    tz->ops->get_trip_temp(tz, count, &trip_temp) ||
+		    !trip_temp)
 			set_bit(count, &tz->trips_disabled);
 	}
 
