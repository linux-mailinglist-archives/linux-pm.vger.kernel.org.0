Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 578D113EFD6
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 19:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436515AbgAPSRb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 13:17:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404281AbgAPR3I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jan 2020 12:29:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C03EF246F4;
        Thu, 16 Jan 2020 17:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195748;
        bh=Gsd2aWs4bWJrcO2HurqTW8C6UED0ESDNK7HNRkyRefE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1tY0tTv+kV7FGVTP4NfVZOFw1lVNGPhEzu8PgKyikd62RU82lQ2IdyGLtzxv9bi+R
         44s3DJglWPR3CSlx3lbjagiAvkWos2d9iuub3WBVXm94toidTwdZLooh507IAh9IJi
         RIpsB6cJpGP+4XjKOMLxyU+abuIyNXBJDR0gR7qc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tri Vo <trong@android.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 281/371] power: supply: Init device wakeup after device_add()
Date:   Thu, 16 Jan 2020 12:22:33 -0500
Message-Id: <20200116172403.18149-224-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit 8288022284859acbcc3cf1a073a1e2692d6c2543 ]

We may want to use the device pointer in device_init_wakeup() with
functions that expect the device to already be added with device_add().
For example, if we were to link the device initializing wakeup to
something in sysfs such as a class for wakeups we'll run into an error.
It looks like this code was written with the assumption that the device
would be added before initializing wakeup due to the order of operations
in power_supply_unregister().

Let's change the order of operations so we don't run into problems here.

Fixes: 948dcf966228 ("power_supply: Prevent suspend until power supply events are processed")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tri Vo <trong@android.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/power_supply_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 3226faebe0a0..0f1a0efd5926 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -891,14 +891,14 @@ __power_supply_register(struct device *parent,
 	}
 
 	spin_lock_init(&psy->changed_lock);
-	rc = device_init_wakeup(dev, ws);
-	if (rc)
-		goto wakeup_init_failed;
-
 	rc = device_add(dev);
 	if (rc)
 		goto device_add_failed;
 
+	rc = device_init_wakeup(dev, ws);
+	if (rc)
+		goto wakeup_init_failed;
+
 	rc = psy_register_thermal(psy);
 	if (rc)
 		goto register_thermal_failed;
@@ -935,8 +935,8 @@ __power_supply_register(struct device *parent,
 	psy_unregister_thermal(psy);
 register_thermal_failed:
 	device_del(dev);
-device_add_failed:
 wakeup_init_failed:
+device_add_failed:
 check_supplies_failed:
 dev_set_name_failed:
 	put_device(dev);
-- 
2.20.1

