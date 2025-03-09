Return-Path: <linux-pm+bounces-23703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B36AA583F4
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 13:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43AA169E5C
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 12:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641EC1D47A2;
	Sun,  9 Mar 2025 12:13:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE231CEAC2;
	Sun,  9 Mar 2025 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741522434; cv=none; b=b48Av4WDwxBVkw9J8rsNuoWtEcjRdXcENliUiDRH1cpUv9W9K7OQrlV9KNfbK/aM1jXps54iDcgYFP7r5DoJK0UX9ZbFS+2Im2pqP3yUuRsBDnuZU5m77siHUuAuWKtNVwBSByd0fpnXOvMvZzu6E+WwJ2/XcTE9xCqvLWBIFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741522434; c=relaxed/simple;
	bh=S9f+QpqRDIUggGy4CQtFQ5kyO+tQhL50aELuYlny68s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgKZffhZKOnxaplkcY1jCgyxUDPXXGhVV+wjV24QR5LDllDtYmXCm0DcpoKwVH768I3GCmTgolkQQUZyAWCyFzcDB22D9IyPN/o6bmsrevHyQCny8d6PzIhDPVHiIvnlmYfw4lbspTcqmbUBgpB1rBGNbWrkwWobQUL5Rh9Xcv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: nWZFClKuS5qx3Vs/XWlD9g==
X-CSE-MsgGUID: HzfBxGZLQDmEEGsI66aaZA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 09 Mar 2025 21:13:44 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.42])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C24D7422041D;
	Sun,  9 Mar 2025 21:13:39 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: geert+renesas@glider.be,
	niklas.soderlund+renesas@ragnatech.se,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: magnus.damm@gmail.com,
	claudiu.beznea.uj@bp.renesas.com,
	devicetree@vger.kernel.org,
	john.madieu@gmail.com,
	rui.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	linux-pm@vger.kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [RFC PATCH 2/3] tmon: Add support for THERMAL_TRIP_PLUG type
Date: Sun,  9 Mar 2025 13:13:22 +0100
Message-ID: <20250309121324.29633-3-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250309121324.29633-1-john.madieu.xa@bp.renesas.com>
References: <20250309121324.29633-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend tmon to handle the new THERMAL_TRIP_PLUG trip type:

- Update UI legend to show 'G=Plug' in status display
- Map trip type to 'G' character in trip_type_to_char()

Align tmon with kernel thermal framework extensions that support
CPU hotplug-based cooling through dedicated trip points.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 tools/thermal/tmon/tmon.h | 1 +
 tools/thermal/tmon/tui.c  | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/tmon.h b/tools/thermal/tmon/tmon.h
index 44d16d778f04..b9b413be5eac 100644
--- a/tools/thermal/tmon/tmon.h
+++ b/tools/thermal/tmon/tmon.h
@@ -57,6 +57,7 @@ struct cdev_info {
 
 enum trip_type {
 	THERMAL_TRIP_CRITICAL,
+	THERMAL_TRIP_PLUG,
 	THERMAL_TRIP_HOT,
 	THERMAL_TRIP_PASSIVE,
 	THERMAL_TRIP_ACTIVE,
diff --git a/tools/thermal/tmon/tui.c b/tools/thermal/tmon/tui.c
index 7f5dd2b87f15..8579b9a0d00d 100644
--- a/tools/thermal/tmon/tui.c
+++ b/tools/thermal/tmon/tui.c
@@ -307,7 +307,7 @@ void show_dialogue(void)
 	wattroff(w, A_BOLD);
 	/* print legend at the bottom line */
 	mvwprintw(w, rows - 2, 1,
-		"Legend: A=Active, P=Passive, C=Critical");
+		"Legend: A=Active, P=Passive, G=Plug, C=Critical");
 
 	wrefresh(dialogue_window);
 }
@@ -535,6 +535,7 @@ static char trip_type_to_char(int type)
 	switch (type) {
 	case THERMAL_TRIP_CRITICAL: return 'C';
 	case THERMAL_TRIP_HOT: return 'H';
+	case THERMAL_TRIP_PLUG: return 'G';
 	case THERMAL_TRIP_PASSIVE: return 'P';
 	case THERMAL_TRIP_ACTIVE: return 'A';
 	default:
-- 
2.25.1


