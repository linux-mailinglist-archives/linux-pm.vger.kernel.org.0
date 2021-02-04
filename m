Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54EC30ED99
	for <lists+linux-pm@lfdr.de>; Thu,  4 Feb 2021 08:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbhBDHln (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 02:41:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39212 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbhBDHl2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 02:41:28 -0500
Date:   Thu, 04 Feb 2021 07:40:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612424445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FmIa/dHwKQ4emIJO7qQeKMzpFiBkoOnsamXI3vGMq2Y=;
        b=rMNVNvoQqQrUqccNtJ1j+kXdOFffkJ8mSttHxX2B/WbW6VI+/uaDOswbDB4dg5ecQZOFAU
        M8lZt39OCHeKla5Gz/7Tc341qhUs7cVM63XlnAcZzDP43TrQMzbW4qS+civlDj0bAaLJsY
        De8ybgNtxRhdgKPrtu7vhHi6SUp2haVeq6Te+AZZKRRIvd2SteRyG1IDkYE9HjQef//3lh
        h11ziIhdWGX4FCal1SIlYTsYmpJY8awcRIISgFkB77shOx9Lm5++3Yn2nh2xO9P0vXEOXH
        e/GwJqDvzDVwvFh0odgSDkK9EZ7PzU/gh/GXcWulLPnpOV3IjFYfaSkghnEu+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612424445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FmIa/dHwKQ4emIJO7qQeKMzpFiBkoOnsamXI3vGMq2Y=;
        b=MsGOGrimuM3U6DtykHwCXqh8Qa8MQWVt4TmM2cHKWtp+Tmum9hCYjGTkHb3ILTHcnMqz/V
        B4r3MQqzh96j79Ag==
From:   "thermal-bot for Kai-Heng Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: intel: pch: Fix unexpected shutdown
 at critical temperature
Cc:     "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201221172345.36976-2-kai.heng.feng@canonical.com>
References: <20201221172345.36976-2-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Message-ID: <161242444533.23325.16982539612575849138.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     03671968d0bf2db598f7e3aa98f190b76c1bb4ff
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//03671968d0bf2db598f7e3aa98f190b76c1bb4ff
Author:        Kai-Heng Feng <kai.heng.feng@canonical.com>
AuthorDate:    Tue, 22 Dec 2020 01:23:44 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 19 Jan 2021 22:30:25 +01:00

thermal: intel: pch: Fix unexpected shutdown at critical temperature

Like previous patch, the intel_pch_thermal device is not in ACPI
ThermalZone namespace, so a critical trip doesn't mean shutdown.

Override the default .critical callback to prevent surprising thermal
shutdoown.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201221172345.36976-2-kai.heng.feng@canonical.com
---
 drivers/thermal/intel/intel_pch_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 41723c6..527c91f 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -326,10 +326,16 @@ static int pch_get_trip_temp(struct thermal_zone_device *tzd, int trip, int *tem
 	return 0;
 }
 
+static void pch_critical(struct thermal_zone_device *tzd)
+{
+	dev_dbg(&tzd->device, "%s: critical temperature reached\n", tzd->type);
+}
+
 static struct thermal_zone_device_ops tzd_ops = {
 	.get_temp = pch_thermal_get_temp,
 	.get_trip_type = pch_get_trip_type,
 	.get_trip_temp = pch_get_trip_temp,
+	.critical = pch_critical,
 };
 
 enum board_ids {
