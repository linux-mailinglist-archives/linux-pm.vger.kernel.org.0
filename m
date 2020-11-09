Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0E52AC222
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 18:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbgKIRZH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 12:25:07 -0500
Received: from foss.arm.com ([217.140.110.172]:43368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730588AbgKIRZH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Nov 2020 12:25:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12C3331B;
        Mon,  9 Nov 2020 09:25:07 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.22.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 47E223F719;
        Mon,  9 Nov 2020 09:25:05 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, rjw@rjwysocki.net, lukasz.luba@arm.com
Subject: [PATCH] powercap: Adjust printing the constraint name with new line
Date:   Mon,  9 Nov 2020 17:24:52 +0000
Message-Id: <20201109172452.6923-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The constraint name has limit of size 30, which sometimes might be hit.
When this happens the new line might be lost. Prevent this and set the
new line when the name string is too long."

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/powercap/powercap_sys.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index f808c5fa9838..575f9fdb810e 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -174,6 +174,10 @@ static ssize_t show_constraint_name(struct device *dev,
 								"%s\n", name);
 			buf[POWERCAP_CONSTRAINT_NAME_LEN] = '\0';
 			len = strlen(buf);
+
+			/* When the 'name' is too long, don't lose new line */
+			if (strlen(name) >= POWERCAP_CONSTRAINT_NAME_LEN)
+				buf[POWERCAP_CONSTRAINT_NAME_LEN - 1] = '\n';
 		}
 	}
 
-- 
2.17.1

