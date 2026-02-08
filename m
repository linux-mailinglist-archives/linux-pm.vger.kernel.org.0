Return-Path: <linux-pm+bounces-42262-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N/ZC++2iGkrvAQAu9opvQ
	(envelope-from <linux-pm+bounces-42262-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 17:16:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E81F109633
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 17:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AA243003720
	for <lists+linux-pm@lfdr.de>; Sun,  8 Feb 2026 16:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4361D350A13;
	Sun,  8 Feb 2026 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXAh5YmR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDE5346E7E;
	Sun,  8 Feb 2026 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770567402; cv=none; b=TVYNGpR6fcwKH4+RNca/pC+cO1ta9PdCKvrRnhDnXOeMKdx3eqSMXQg6ixPqbZf14cdGdI+ZbvbMkyvritwR195wcLssXeYeKxcU7hLrDMQfqYwYhpABoeEfflDYsJiRXOPm+WrthkQguCL/mI78A4MoLgeN7niqmaxlIcbxB+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770567402; c=relaxed/simple;
	bh=1wyV+7Uu3S44OdrazAbRaKlSif4P05oTIsJAGvrLOWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q4oa4v7FTxg70rhQGoflFhqGoUiXF50kRxhWpm2hnOTIsPnkjNajGCUa7xvvMcbRMwp4pXNlkRaUGIVQlk0uChXs4X3b3HPYaFqMBHaEWbAQ8SWfReH3k11/0HI2i8QBQtYFC/wTx0b3OmE3msTYKctGN1SvR8iwgrJpQfMesGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXAh5YmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6CA0C4CEF7;
	Sun,  8 Feb 2026 16:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770567401;
	bh=1wyV+7Uu3S44OdrazAbRaKlSif4P05oTIsJAGvrLOWI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=QXAh5YmRB/k4kEKCr4GAtRcEsb+TmSAVvtlij9crnSzcyu+XBLEXX/4HeKVofoTcU
	 XBbgKH9yCxrHJ0qclRhYMThYzt4uoEEenqrnvvenqRBFBNHv5WUbwxgE0qI6bNmzDX
	 IQPXIFQXnut6e6+dNrr/5x+JVj+e74uuu3ZfWTqTmnae3QvEVr8YNZC9TVYqlt3hjN
	 1q3nxB9/EYtrVmwli/kX/zRkknq5Sb1wBFEK/HlY0kjoILLgsBgDvDHIBPEndvBKvW
	 BO2rBia0XwLUwoqM9wjk4CGw5JJ8ahWBiLsD+joXasPeRHKqjhpRGhaac7TBx1R12G
	 6D2rhU1lm9ovQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BA0EF06E1;
	Sun,  8 Feb 2026 16:16:41 +0000 (UTC)
From: Baoyuan Geng via B4 Relay <devnull+geng.baoyuan.gmail.com@kernel.org>
Date: Mon, 09 Feb 2026 00:16:05 +0800
Subject: [PATCH] thermal: qcom-spmi-temp-alarm: fix out-of-bounds when
 copying temp map
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-fix-qcom-spmi-temp-alarm-oob-v1-1-3f1c67090e77@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBA0avIrB2YziJWryIu0nRSB4xJE5FC8
 O6GLh98foUiWaXA1FXIcmrRuDc8+g7cavePoL6bgYkNMT3R6w+/LgYsKSgeEhLazeaAMb7QjDQ
 Y8o4tG2iLlKX1//28XNcNKYx98W4AAAA=
X-Change-ID: 20260208-fix-qcom-spmi-temp-alarm-oob-690760fc2a26
To: Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Baoyuan Geng <geng.baoyuan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770567397; l=3171;
 i=geng.baoyuan@gmail.com; s=20260208; h=from:subject:message-id;
 bh=IPx2aYZrJ7XVu7bN4arD9CKDHc8AbrpqAhkC0NxaMcs=;
 b=GL7ylGAiRQkvObp1NvpwrrYJTbgoT0im3QK/Sp1/y4+MwOxQeMz9RRBRxXcRNZZDulWPXdY15
 Dtk+3rCS2hyCOUAz70sEj9wfWF+B8cj6DA8mjjwyZzNA4MbSTFHPQcz
X-Developer-Key: i=geng.baoyuan@gmail.com; a=ed25519;
 pk=K8rZZQg2HZ88njeBrQUyqUdFffk6Lle8CFZzfh55wfU=
X-Endpoint-Received: by B4 Relay for geng.baoyuan@gmail.com/20260208 with
 auth_id=630
X-Original-From: Baoyuan Geng <geng.baoyuan@gmail.com>
Reply-To: geng.baoyuan@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42262-lists,linux-pm=lfdr.de,geng.baoyuan.gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,intel.com,arm.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[geng.baoyuan@gmail.com]
X-Rspamd-Queue-Id: 3E81F109633
X-Rspamd-Action: no action

From: Baoyuan Geng <geng.baoyuan@gmail.com>

The way to index the pointer of array missed a dereference, fix it.

The bug is reported by KASAN[0].

[0]:
==================================================================
BUG: KASAN: global-out-of-bounds in qpnp_tm_sync_thresholds+0x11c/0x1a4 [qcom_spmi_temp_alarm]
Read of size 24 at addr ffffbb86e7685280 by task (udev-worker)/928

CPU: 6 UID: 0 PID: 928 Comm: (udev-worker) \
    Not tainted 6.19.0-rc8-00185-g2687c848e578 #4 PREEMPT
Hardware name: Thundercomm RUBIK Pi 3 (DT)
Call trace:
 show_stack+0x18/0x30 (C)
 dump_stack_lvl+0x60/0x80
 print_report+0x18c/0x4e0
 kasan_report+0xac/0xf0
 kasan_check_range+0xfc/0x1ac
 __asan_memcpy+0x3c/0xa0
 qpnp_tm_sync_thresholds+0x11c/0x1a4 [qcom_spmi_temp_alarm]
 qpnp_tm_probe+0x390/0xb60 [qcom_spmi_temp_alarm]
 platform_probe+0xc0/0x1f0
 really_probe+0x190/0x604
 __driver_probe_device+0x160/0x2c0
 driver_probe_device+0x5c/0x2b8
 __driver_attach+0x134/0x534
 bus_for_each_dev+0xf4/0x180
 driver_attach+0x3c/0x60
 bus_add_driver+0x1f0/0x510
 driver_register+0x154/0x39c
 __platform_driver_register+0x58/0x84
 qpnp_tm_driver_init+0x2c/0x1000 [qcom_spmi_temp_alarm]
 do_one_initcall+0xd4/0x354
 do_init_module+0x30c/0x8bc
 load_module+0x3de0/0x5764
 init_module_from_file+0x144/0x254
 __arm64_sys_finit_module+0x338/0x710
 invoke_syscall.constprop.0+0x64/0x220
 do_el0_svc+0x144/0x200
 el0_svc+0x38/0xb8
 el0t_64_sync_handler+0xa0/0xe4
 el0t_64_sync+0x198/0x19c

The buggy address belongs to the variable:
 temp_map_gen2_v1+0x60/0xffffffffffff9de0 [qcom_spmi_temp_alarm]
==================================================================

Fixes: 703f13285a6c ("thermal/drivers/qcom-spmi-temp-alarm: Add temp alarm data struct based on HW subtype")
Fixes: 1f835c6a4c84 ("thermal/drivers/qcom-spmi-temp-alarm: Prepare to support additional Temp Alarm subtypes")

Signed-off-by: Baoyuan Geng <geng.baoyuan@gmail.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index f39ca0ddd17b..faaa56b399e8 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -345,7 +345,7 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 	}
 
 skip:
-	memcpy(chip->temp_thresh_map, chip->data->temp_map[threshold],
+	memcpy(chip->temp_thresh_map, (*chip->data->temp_map)[threshold],
 		sizeof(chip->temp_thresh_map));
 	reg |= threshold;
 	if (disable_stage2_shutdown && !chip->require_stage2_shutdown)
@@ -535,7 +535,7 @@ static int qpnp_tm_sync_thresholds(struct qpnp_tm_chip *chip)
 		return ret;
 
 	threshold = reg & SHUTDOWN_CTRL1_THRESHOLD_MASK;
-	memcpy(chip->temp_thresh_map, chip->data->temp_map[threshold],
+	memcpy(chip->temp_thresh_map, (*chip->data->temp_map)[threshold],
 		sizeof(chip->temp_thresh_map));
 
 	return ret;

---
base-commit: 2687c848e57820651b9f69d30c4710f4219f7dbf
change-id: 20260208-fix-qcom-spmi-temp-alarm-oob-690760fc2a26

Best regards,
-- 
Baoyuan Geng <geng.baoyuan@gmail.com>



