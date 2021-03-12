Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B58F3396DE
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 19:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhCLSqO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 13:46:14 -0500
Received: from foss.arm.com ([217.140.110.172]:59488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233973AbhCLSpu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Mar 2021 13:45:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E333AED1;
        Fri, 12 Mar 2021 10:45:49 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.17.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 40E8C3F7D7;
        Fri, 12 Mar 2021 10:45:48 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cw00.choi@samsung.com
Cc:     lukasz.luba@arm.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
Subject: [PATCH] PM / devfreq: unlock mutex and free devfreq struct in error path
Date:   Fri, 12 Mar 2021 18:45:34 +0000
Message-Id: <20210312184534.6423-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devfreq->lock is held for time of setup. Release the lock in the
error path, before jumping to the end of the function.

Change the goto destination which frees the allocated memory.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/devfreq/devfreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index b6d3e7db0b09..99b2eeedc238 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -822,7 +822,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	if (devfreq->profile->timer < 0
 		|| devfreq->profile->timer >= DEVFREQ_TIMER_NUM) {
-		goto err_out;
+		mutex_unlock(&devfreq->lock);
+		goto err_dev;
 	}
 
 	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
-- 
2.17.1

