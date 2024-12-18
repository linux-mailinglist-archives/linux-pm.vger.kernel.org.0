Return-Path: <linux-pm+bounces-19448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1656F9F6DDA
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 20:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670F516A210
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A201FC0E3;
	Wed, 18 Dec 2024 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yb9g6hyV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A021FAC40
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734549126; cv=none; b=uzEEjFNWAxtDPrA+d0OBHu+hMtVIU2uvrK1NFTT08tKfc1qTKcHTE9zxkpMDcE41b+7/xD8Gk0fxzgK6IWTF0DIR957uAz5pZoEq7lPrr5UGMM0LKPYA8pk/06XRFBKHe1HIuLqPo1EnZY9Axdc3nGDH7KnZ05n657XYQQoGMk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734549126; c=relaxed/simple;
	bh=+HpnK1/8zAyOotqNrpnCyj2V09vsKx8pA30RMzSTFdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9zg1Iw6cf62eu42BjdZ7W0hUWafnJrBqTM+yDC/NnnJfg3MltK1IB0qKcQLo5aIaRbeUzZKxBHZm3tOSLFOUzyO06HmdZbiiTe3Qd+Tfx/dendX+5BiXlSXSPfZOgbAu+ZIF4u6WDZCyGtxxywXIP2xcXitMOqO8FwZTnyO+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yb9g6hyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EF5C4CECD;
	Wed, 18 Dec 2024 19:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734549126;
	bh=+HpnK1/8zAyOotqNrpnCyj2V09vsKx8pA30RMzSTFdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yb9g6hyV8lT1J3oie20Tx7TTZn9xUVncCnGO0jw6WiNMFFFQCjRmwnb/18AEeZV8w
	 /LfaPXI5VWbILZgYIV+LbdSWaJDinLDhFwMwXvaWGxxUj4jIC03RCXDv24QvroG2r/
	 orGeEoKjBgpann40/UHoNvtCEkb5duwDsaCo7ER0wLNQRSXEFLFcwhqWnKgYhQePL+
	 XXVXAX2rWHG7yMEuPGJNpCT888aHUM76cx9Gxd95mM9rjsMWAqfFk7drZRr30p68x5
	 zmCGgDffQVyOeKyleJhoBsjtGO8BH4aa32P+qVlJx6MRjZL8O79kHh1r66KuRtMsrW
	 yG/RSaDH/I9MQ==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 2/7] cpupower: Add support for parsing 'enabled' or 'disabled' strings from table
Date: Wed, 18 Dec 2024 13:09:51 -0600
Message-ID: <20241218191144.3440854-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218191144.3440854-1-superm1@kernel.org>
References: <20241218191144.3440854-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When cpufreq_get_sysfs_value_from_table() is passed a table with
kernel strings that report 'enabled' or 'disabled' it always returns 0
because these can't cleanly convert to integers.

Explicitly look for enabled or disabled strings from the kernel to handle
this.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 tools/power/cpupower/lib/cpufreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index 1516d23c17c98..f27ee6d4b000c 100644
--- a/tools/power/cpupower/lib/cpufreq.c
+++ b/tools/power/cpupower/lib/cpufreq.c
@@ -102,6 +102,10 @@ unsigned long cpufreq_get_sysfs_value_from_table(unsigned int cpu,
 	if (len == 0)
 		return 0;
 
+	if (!strcmp(linebuf, "enabled\n"))
+		return 1;
+	if (!strcmp(linebuf, "disabled\n"))
+		return 0;
 	value = strtoul(linebuf, &endp, 0);
 
 	if (endp == linebuf || errno == ERANGE)
-- 
2.43.0


