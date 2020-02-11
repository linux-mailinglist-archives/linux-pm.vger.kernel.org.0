Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38AB2159D78
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgBKXkL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:40:11 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51057 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgBKXit (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:38:49 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 9bb898a50f6407aa; Wed, 12 Feb 2020 00:38:46 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 17/28] drivers: hsi: Call cpu_latency_qos_*() instead of pm_qos_*()
Date:   Wed, 12 Feb 2020 00:13:17 +0100
Message-ID: <5212477.aCSzomBNgy@kreacher>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
References: <1654227.8mz0SueHsU@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Call cpu_latency_qos_add/remove_request() and
cpu_latency_qos_request_active() instead of
pm_qos_add/remove_request() and pm_qos_request_active(),
respectively, because the latter are going to be dropped.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/hsi/clients/cmt_speech.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/hsi/clients/cmt_speech.c b/drivers/hsi/clients/cmt_speech.c
index 9eec970cdfa5..89869c66fb9d 100644
--- a/drivers/hsi/clients/cmt_speech.c
+++ b/drivers/hsi/clients/cmt_speech.c
@@ -965,14 +965,13 @@ static int cs_hsi_buf_config(struct cs_hsi_iface *hi,
 
 	if (old_state != hi->iface_state) {
 		if (hi->iface_state == CS_STATE_CONFIGURED) {
-			pm_qos_add_request(&hi->pm_qos_req,
-				PM_QOS_CPU_DMA_LATENCY,
+			cpu_latency_qos_add_request(&hi->pm_qos_req,
 				CS_QOS_LATENCY_FOR_DATA_USEC);
 			local_bh_disable();
 			cs_hsi_read_on_data(hi);
 			local_bh_enable();
 		} else if (old_state == CS_STATE_CONFIGURED) {
-			pm_qos_remove_request(&hi->pm_qos_req);
+			cpu_latency_qos_remove_request(&hi->pm_qos_req);
 		}
 	}
 	return r;
@@ -1075,8 +1074,8 @@ static void cs_hsi_stop(struct cs_hsi_iface *hi)
 	WARN_ON(!cs_state_idle(hi->control_state));
 	WARN_ON(!cs_state_idle(hi->data_state));
 
-	if (pm_qos_request_active(&hi->pm_qos_req))
-		pm_qos_remove_request(&hi->pm_qos_req);
+	if (cpu_latency_qos_request_active(&hi->pm_qos_req))
+		cpu_latency_qos_remove_request(&hi->pm_qos_req);
 
 	spin_lock_bh(&hi->lock);
 	cs_hsi_free_data(hi);
-- 
2.16.4





