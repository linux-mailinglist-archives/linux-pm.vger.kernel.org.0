Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F11944AE2E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 13:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhKIM66 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 07:58:58 -0500
Received: from comms.puri.sm ([159.203.221.185]:46434 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233652AbhKIM65 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Nov 2021 07:58:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 90DB7DFE04;
        Tue,  9 Nov 2021 04:55:41 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WNnYO0huJ9K0; Tue,  9 Nov 2021 04:55:41 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     sakari.ailus@linux.intel.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, linux-pm@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] media: i2c: dw9714: use pm_runtime_force_suspend/resume for system suspend
Date:   Tue,  9 Nov 2021 13:55:05 +0100
Message-Id: <20211109125505.2682553-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Using the same suspend function for runtime and system suspend doesn't
work in this case (when controlling regulators and clocks). suspend() and
resume() are clearly meant to stay balanced.

Use the pm_runtime_force_* helpers for system suspend and fix error like the
following when transitioning to system suspend:

[  559.685921] dw9714 3-000c: I2C write fail
[  559.685941] dw9714 3-000c: dw9714_vcm_suspend I2C failure: -5

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/media/i2c/dw9714.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/dw9714.c b/drivers/media/i2c/dw9714.c
index fcbebb3558b5..f6ddd7c4a1ff 100644
--- a/drivers/media/i2c/dw9714.c
+++ b/drivers/media/i2c/dw9714.c
@@ -267,7 +267,8 @@ static const struct of_device_id dw9714_of_table[] = {
 MODULE_DEVICE_TABLE(of, dw9714_of_table);
 
 static const struct dev_pm_ops dw9714_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(dw9714_vcm_suspend, dw9714_vcm_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(dw9714_vcm_suspend, dw9714_vcm_resume, NULL)
 };
 
-- 
2.30.2

