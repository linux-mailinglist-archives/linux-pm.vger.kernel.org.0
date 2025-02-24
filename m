Return-Path: <linux-pm+bounces-22832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAFCA42A02
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 18:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148DD3B974F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 17:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0DD265604;
	Mon, 24 Feb 2025 17:34:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438D3264A8B;
	Mon, 24 Feb 2025 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418489; cv=none; b=PNQJKqIO6VBqJnzxLu9USi7qBHv4Z2NyroFZifgaaO2SSdG1O0TdLx1tfUROXZtORHHwXdFs4uFNrIRMul52Quisp8ZcXDGmf20LJngiZRV0VoXbXr47NVUxXp6DvIBMadmxUCpRNVT9hiQiqZRWZ3Oi0ZiWPWlNMVpiMRvuIQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418489; c=relaxed/simple;
	bh=I++dDYsKJnAzZs7TT3zrtUksPHsTx63cS2lKz5ZMiDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qax8lIDgvhvKzpmXAt+ZsP7uADP9TGiOTB/6J/EJY3cY7TQB56UZJm/tH/khriiizGW6uALhBrCqAg5wW7mjItqV+6QD/FL/1M3qJY6W7sm+h1Y/lFVBCGwcaveTCD95kGFQ6v9MZN2b/Pxlz8wCOAW0PvIKY9aAbUEb/cAaOTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 342CE1756;
	Mon, 24 Feb 2025 09:35:04 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.65.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF1B63F5A1;
	Mon, 24 Feb 2025 09:34:45 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: lukasz.luba@arm.com,
	rui.zhang@intel.com,
	srinivas.pandruvada@linux.intel.com
Subject: [PATCH 1/4] thermal: OF: Use kcalloc() instead of kzalloc() with multiplication
Date: Mon, 24 Feb 2025 17:33:03 +0000
Message-ID: <20250224173432.1946070-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224173432.1946070-1-lukasz.luba@arm.com>
References: <20250224173432.1946070-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the latest recommendations, kcalloc() should be used instead
of kzalloc() with multiplication (which might overflow).
Switch to this new scheme and use more safe kcalloc().

No functional impact changes.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 5ab4ce4daaebd..fb376bd4d9579 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -107,7 +107,7 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 	if (!count)
 		return NULL;
 
-	struct thermal_trip *tt __free(kfree) = kzalloc(sizeof(*tt) * count, GFP_KERNEL);
+	struct thermal_trip *tt __free(kfree) = kcalloc(count, sizeof(*tt), GFP_KERNEL);
 	if (!tt)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.48.1


