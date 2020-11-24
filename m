Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47502C2196
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 10:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbgKXJgp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 04:36:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42012 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731374AbgKXJgk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 04:36:40 -0500
Date:   Tue, 24 Nov 2020 09:36:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606210598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BB9NNXwp6WyAPDk8ApDaiyGL3fi0BQibQ0N1oLy5FB8=;
        b=ixIGaC3/kVesZydE3/bC6Xy2XUIroiMLm/+yIpx77tR1AoesN7+u/Dm7dLtVVP+J9iFCb2
        VuEBOsESIOLxjdGixhcsQEF3jtxKbnTMl7PVYtwndW8WwE6QQkNNb8c5KdV8yMrbLx/Ymu
        fhc8+hkyLI/YNFzqiDz+AUnGjJfOR5bt6alnvB0ahzbmcJWQNQNYeNoZItIS2qiMMSb39w
        4IA2R6K6LqZTCNRKZgdIzD1pjPGUGtdv7IEmO08QmItBpi80ZfHbXzyg9HQ7loJI5Bnugo
        RS2eeWKkrCaut6hwIZprzIZkysuVFrTz7HKlaHbk0Uhl5v49sHoqLlB84OiwnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606210598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BB9NNXwp6WyAPDk8ApDaiyGL3fi0BQibQ0N1oLy5FB8=;
        b=XQ6N3tafZrztXXrC9cgOObwwpKSdMPr767s2egm96QnVuZwe46kCx/1L2QWDTuzAl/KYXC
        V/JWc2ACbN7xMxDA==
From:   "thermal-bot for Bernard Zhao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/hwmon: Cleanup coding style a bit
Cc:     Bernard Zhao <bernard@vivo.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201102023121.3312-1-bernard@vivo.com>
References: <20201102023121.3312-1-bernard@vivo.com>
MIME-Version: 1.0
Message-ID: <160621059771.11115.1021341423442981344.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     030a48b0f6ce393d78b8d33debb1e2043b8cc156
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//030a48b0f6ce393d78b8d33debb1e2043b8cc156
Author:        Bernard Zhao <bernard@vivo.com>
AuthorDate:    Sun, 01 Nov 2020 18:31:21 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 12 Nov 2020 11:24:01 +01:00

thermal/drivers/hwmon: Cleanup coding style a bit

Function thermal_add_hwmon_sysfs, hwmon will be NULL when
new_hwmon_device = 0, so there is no need to check, kfree will
handle NULL point.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201102023121.3312-1-bernard@vivo.com
---
 drivers/thermal/thermal_hwmon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 8b92e00..ad03262 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -206,8 +206,7 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	if (new_hwmon_device)
 		hwmon_device_unregister(hwmon->device);
  free_mem:
-	if (new_hwmon_device)
-		kfree(hwmon);
+	kfree(hwmon);
 
 	return result;
 }
