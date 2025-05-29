Return-Path: <linux-pm+bounces-27774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D96DCAC74DE
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 02:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25004A20395
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 00:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A108E14F9FB;
	Thu, 29 May 2025 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="P3gq4JA/"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A138B67A;
	Thu, 29 May 2025 00:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748477636; cv=none; b=moWxWPJPVP1VjSZ3oVY+fqpS8i03nes7+TwdwGfa90vIDQ1HcK/6vJHWsAfWjZ9WRaM+h2GqecZC2IWJdrE4+ghSlTliuX8T8YmVE2/BQh0kkRIIpOmuGxHHWxshyqEDq/rgeF8czpVd5e0ZbzOYIjBrub9lmDZoVzHxTtfume0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748477636; c=relaxed/simple;
	bh=1y2ZVOmO3FcC6g3Y3xnbSPeJjAN/V4jgxqazxePXTGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUeLoYS+2oIAJrInZkPXOaxW3pi7B6IjyZCydVnmKybzyemkN6vwOBg0XV79E9kwShVZc811SO62aFKd+/YV89fDZpbeuwkcCWveRmODBfrTlzxye9s3VPsGfsHItO0b6+9XLsSi2zvsbpShj603ljFR1SNnc/GdZ4GTO1OAtRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=P3gq4JA/; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FuEWsFWgmso91gJ4yulhACnmewxC84ZRX7NRO2lsVAE=; b=P3gq4JA/bkRiQYJqt+sEsHNylO
	G62MYHbAbgA1dXRd0m0LYr9OEOtI4WmHONr+kb7rcs1VuHu+qZbIc8lm9icfohVpteaMqS7YTcdpq
	EyIIcG94gLThHM9cMV8qcGyOfol37hIeJP+ewBZep9O9fOxQuGaCW7btWFi47R6ucn9YYZGIstGav
	qjmDoW0lccTLNjADvyoL3hPWgXnjJTryC+FZSrjpEFJSDinTVo11TGg9cyMEiNkIn4880JgV8XdxG
	YRVYZJebFgNsKaiWON3hpM3uQqcz5sNB+l5t6UWXb+PIsj2PPiuOaOAwpab2NNh95zfeNI2INxeOA
	s4fhkegg==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uKQu2-00EZvx-5f; Thu, 29 May 2025 02:13:47 +0200
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: christian.loehle@arm.com,
	tj@kernel.org,
	kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH 03/11] PM: EM: Initialize the netlink notification during booting.
Date: Thu, 29 May 2025 09:13:07 +0900
Message-ID: <20250529001315.233492-4-changwoo@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529001315.233492-1-changwoo@igalia.com>
References: <20250529001315.233492-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize and register the netlink during booting. The initialization is
called at the postcore level, which is late enough after the generic
netlink is initialized.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/power/energy_model.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index ea7995a25780..b15b685c22bd 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -17,6 +17,8 @@
 #include <linux/sched/topology.h>
 #include <linux/slab.h>
 
+#include "em_netlink.h"
+
 /*
  * Mutex serializing the registrations of performance domains and letting
  * callbacks defined by drivers sleep.
@@ -936,3 +938,18 @@ void em_rebuild_sched_domains(void)
 	 */
 	schedule_work(&rebuild_sd_work);
 }
+
+static int __init em_init(void)
+{
+	int result;
+
+	result = em_netlink_init();
+	if (result)
+		goto error;
+
+	return 0;
+
+error:
+	return result;
+}
+postcore_initcall(em_init);
-- 
2.49.0


