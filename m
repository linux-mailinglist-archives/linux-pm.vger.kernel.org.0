Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487122E9685
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 15:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbhADOAY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 09:00:24 -0500
Received: from foss.arm.com ([217.140.110.172]:36094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbhADOAX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Jan 2021 09:00:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C9EC1FB;
        Mon,  4 Jan 2021 05:59:38 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.3.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 608733F719;
        Mon,  4 Jan 2021 05:59:36 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, cw00.choi@samsung.com
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com
Subject: [PATCH] PM / devfreq: spelling correction in a comment
Date:   Mon,  4 Jan 2021 13:59:12 +0000
Message-Id: <20210104135912.8185-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The device attribute exposed in sysfs is called 'polling_interval'. Align
the comment.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
Hi Chanwoo,

While grepping the devfreq polling_interval sources I've found
this trivial mistake in the comment.

Regards,
Lukasz

 drivers/devfreq/governor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index 2a52f97b542d..70f44b3ca42e 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -40,7 +40,7 @@
 /*
  * Definition of governor attribute flags except for common sysfs attributes
  * - DEVFREQ_GOV_ATTR_POLLING_INTERVAL
- *   : Indicate polling_interal sysfs attribute
+ *   : Indicate polling_interval sysfs attribute
  * - DEVFREQ_GOV_ATTR_TIMER
  *   : Indicate timer sysfs attribute
  */
-- 
2.17.1

