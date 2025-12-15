Return-Path: <linux-pm+bounces-39552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 561C4CBDC4D
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 13:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6319230532A8
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 12:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899EC19A2A3;
	Mon, 15 Dec 2025 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UM72Uxo2"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E39710957
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765801029; cv=none; b=FIQDjVssCJ4nJO1Z/uYBZtaziIMUNPHDGWmhFbjEjhkvn4pV1WerU3u5S4gEAIVVll/G8xNbn7luknKajHJ8G4q8D221kjCJw+SQUmkyU4/Xhw3YdPcw5J3uCMZRMmJ2WpH+Q7A56Rft1AhfP7A6mzKPPD/M4nCz4nAHNPULA0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765801029; c=relaxed/simple;
	bh=xKd21L+BfgO9tYmMGuabt4dmULRVfJo5yaNtaQjm5Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5fxoeFlrL6hTZ+SfMxgavYHmzwFtIJBOzNM+j9/vxjMUFhB4tqWpoSLb+coSgrvey9mZWAQqxHzohuau+JkTY8hw8VyEYAj8dI3K2S5/OPXylW1U25vyK0dK02Pq0cV+6jmFdhsAPnBcYbMyTpXJqZUtgkOnKk7TpKXDhK+5BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UM72Uxo2; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765801012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sSkpNYskDg1ZQG+F+jcVFB1gclBvY7a46b7Rerkj6PQ=;
	b=UM72Uxo2PjeXPtv3jtoZnqtxL8nS9iCxMcpkzcQRFsnRI4GzDPMPjN/sfEu5O2dUEQPlK2
	hbfUsguSZPtdbJoNfECHI54EMsXWxITswFjN8Yx+orWD00OLuHiul3saFyUEx2li181C+l
	fio97nKfImBqHNdCCcYlmIS4nJK7l3E=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: core: Use strnlen in thermal_zone_device_register_with_trips
Date: Mon, 15 Dec 2025 13:16:33 +0100
Message-ID: <20251215121633.375193-1-thorsten.blum@linux.dev>
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
 drivers/thermal/thermal_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 17ca5c082643..63eb35b449c6 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1505,15 +1505,17 @@ thermal_zone_device_register_with_trips(const char *type,
 	const struct thermal_trip *trip = trips;
 	struct thermal_zone_device *tz;
 	struct thermal_trip_desc *td;
+	size_t type_len;
 	int id;
 	int result;
 
-	if (!type || strlen(type) == 0) {
+	type_len = type ? strnlen(type, THERMAL_NAME_LENGTH) : 0;
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


