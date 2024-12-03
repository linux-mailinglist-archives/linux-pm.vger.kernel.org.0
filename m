Return-Path: <linux-pm+bounces-18475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 181569E1F92
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 15:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1916282704
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325CC1F707D;
	Tue,  3 Dec 2024 14:38:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808691EE029;
	Tue,  3 Dec 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236701; cv=none; b=QX70989i6K//o0e/cmjBbeUhdiQo68yYnxvoyKQgjgjVTUpVmFw8XhuKXX2o8581CXo19kXPflSOLdLnD2E8xtH6NNfCn3S7esDvooLlh3GTx9/ajZcIwTEhg6GyPMrAF0DTBVzHEOs+rARwkrBI8gXRmMW9f1JAwgawmUtWdWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236701; c=relaxed/simple;
	bh=/RpnszIWaIm8v6385F1dHLoY+XsDEZcoE7rgkurFXuI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AK9ZoImh9b9LCYjJOntuF7fCttRbleJbAt/LtIaOEYQFilx429u3E3xcYC3KQfB0B/W82awhCFZoUilm5buVxA4lTb25MzVUt1kZooTGVvrpt9jjA+yNXlnf3Mij1v6pGued+EnCvzDQC/Bs3/S9uM3iy1PGpKfeo1KZIscpirI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: Pr32bEfMS52Pu1jHWYLoMw==
X-CSE-MsgGUID: l74GEaegRCG/w1+c7qTMAQ==
X-IronPort-AV: E=Sophos;i="6.12,205,1728918000"; 
   d="scan'208";a="230765977"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Dec 2024 23:38:15 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.8])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E8BEC4080A97;
	Tue,  3 Dec 2024 23:38:03 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: PM: Clarify pm_runtime_resume_and_get return value
Date: Tue,  3 Dec 2024 14:37:29 +0000
Message-Id: <20241203143729.478-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the documentation to match the behaviour of the code.

The function pm_runtime_resume_and_get() always returns 0 on success,
even if __pm_runtime_resume() returns 1.

Fixes: 2c412337cfe6 ("PM: runtime: Add documentation for pm_runtime_resume_and_get()")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 Documentation/power/runtime_pm.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 53d1996460ab..a86f1173980a 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -347,7 +347,9 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
 
   `int pm_runtime_resume_and_get(struct device *dev);`
     - run pm_runtime_resume(dev) and if successful, increment the device's
-      usage counter; return the result of pm_runtime_resume
+      usage counter; returns 0 on success (whether or not the device's runtime
+      PM status was already 'active') or the error code from pm_runtime_resume
+      on failure.
 
   `int pm_request_idle(struct device *dev);`
     - submit a request to execute the subsystem-level idle callback for the
-- 
2.43.0


