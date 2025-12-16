Return-Path: <linux-pm+bounces-39636-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 67600CC328B
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 14:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6FEA930301A4
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 13:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0E4221F17;
	Tue, 16 Dec 2025 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RbIF7Feb"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F6833067B;
	Tue, 16 Dec 2025 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765890643; cv=none; b=WKw1mE68rrqwSPsZNzAFkhmopqOdcjiD5/727uzjbM9EHQ8kkrdmIyI5tkAyMLzPxdeWq8MQkKfKMTTIPyS2+7CcZOrUypYVGDJ+R2XZPfdkzHLOVcOEzTUNQfdZGhdMO3ZgSQpsz0F+rjGutkybw+t7zYq6hnETT9a7SCx2tW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765890643; c=relaxed/simple;
	bh=2ePsCsl+uTeQ63NpxBU2OYmg3L7+LXoDuu9Tv1F+qoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mXnW+VlqCwoj/lmxFur5vHyWDfqbCKOC1I9o2SvUGnIUPtGdORHwWFnQKaWS8x/B/ev2R6D8gP7kHnTX8sLIuaog2W0VBAX6bxisE+tfc8DiG4Fx5PwVFfn5ANxaYnA7AxKH0tIPgBa/aequK8vLEarOWUlxz+6HqpQTusd8IMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RbIF7Feb; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765890634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tvc2xx3qRbTtdh8Es7si6GKKG8vbrEeAl+HIW3DfEt4=;
	b=RbIF7FebcsU1in2/qn7QoHXUngfLgNcqrxa8/riDW2wcEvtHnc/gxReizW/fhZnDS2R4Bq
	cmo/r4oxGnNUOkjHUwSV8D8MQnXvGGxoN30UcvbAkd68OgOpyBooYy1gJlaq4c39fccFdv
	OnJnmTTVJqJNko0Q6F2gUGcyQZHLZj8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] thermal: core: Use strnlen in thermal_zone_device_register_with_trips
Date: Tue, 16 Dec 2025 14:09:44 +0100
Message-ID: <20251216130943.40180-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace strlen() with the safer strnlen() and calculate the length of
the thermal zone name 'type' only once.  No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Format the code differently (Rafael)
- Link to v1: https://lore.kernel.org/lkml/20251215121633.375193-1-thorsten.blum@linux.dev/
---
 drivers/thermal/thermal_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 17ca5c082643..90e7edf16a52 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1505,15 +1505,19 @@ thermal_zone_device_register_with_trips(const char *type,
 	const struct thermal_trip *trip = trips;
 	struct thermal_zone_device *tz;
 	struct thermal_trip_desc *td;
+	size_t type_len = 0;
 	int id;
 	int result;
 
-	if (!type || strlen(type) == 0) {
+	if (type)
+		type_len = strnlen(type, THERMAL_NAME_LENGTH);
+
+	if (type_len == 0) {
 		pr_err("No thermal zone type defined\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (strlen(type) >= THERMAL_NAME_LENGTH) {
+	if (type_len == THERMAL_NAME_LENGTH) {
 		pr_err("Thermal zone name (%s) too long, should be under %d chars\n",
 		       type, THERMAL_NAME_LENGTH);
 		return ERR_PTR(-EINVAL);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


