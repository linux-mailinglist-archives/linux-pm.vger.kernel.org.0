Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A36F44AE84
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 14:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhKINNh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 08:13:37 -0500
Received: from comms.puri.sm ([159.203.221.185]:47352 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234488AbhKINNg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Nov 2021 08:13:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 47ECAE0304;
        Tue,  9 Nov 2021 05:10:50 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LPH1gB_nCPrf; Tue,  9 Nov 2021 05:10:49 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     sakari.ailus@linux.intel.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@puri.sm,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 2/2] media: i2c: hi846: use pm_runtime_force_suspend/resume for system suspend
Date:   Tue,  9 Nov 2021 14:10:13 +0100
Message-Id: <20211109131013.2684058-3-martin.kepplinger@puri.sm>
In-Reply-To: <20211109131013.2684058-1-martin.kepplinger@puri.sm>
References: <20211109131013.2684058-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In cases like this when controlling regulators and clocks the suspend()
and resume() functions are meant to be called balanced toggling the behaviour.

It's wrong to use the same suspend function for runtime and system suspend
in this case and leads to errors like

[   77.718890] Failed to disable vddd: -EIO

Use pm_runtime_force_* helpers in order to support system suspend properly
when runtime pm is already implemented and fix this.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/media/i2c/hi846.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
index ed55c3894284..9bb96754a091 100644
--- a/drivers/media/i2c/hi846.c
+++ b/drivers/media/i2c/hi846.c
@@ -2418,7 +2418,11 @@ static int hi846_remove(struct i2c_client *client)
 	return 0;
 }
 
-static UNIVERSAL_DEV_PM_OPS(hi846_pm_ops, hi846_suspend, hi846_resume, NULL);
+static const struct dev_pm_ops hi846_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(hi846_suspend, hi846_resume, NULL)
+};
 
 static const struct of_device_id hi846_of_match[] = {
 	{ .compatible = "hynix,hi846", },
-- 
2.30.2

