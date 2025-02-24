Return-Path: <linux-pm+bounces-22833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD9FA42A03
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 18:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C4B17F642
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 17:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6025265CAC;
	Mon, 24 Feb 2025 17:34:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1CA265630;
	Mon, 24 Feb 2025 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418491; cv=none; b=YWndDKk7WdGJIWczSdoB7lUaFmvpgrXHnuFkB63XQYJDLkyCo3SedmPIb3LlstprCIJuNUfc6LGZtL4Xzz1gpJo+axSREvRcVnzLWCKmfVkKPI+LHS6XusDxJ/VEtkt+ssgGL2V38SQthvOa3d2Mf880VuA8CuEoNUh5Af+fXt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418491; c=relaxed/simple;
	bh=b+5bekHFm+sDW6aHnNsKja9uTB5ioANecssh2KfE3IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rx1Nqbv8HYDwyEZ9IjFcNuk0/4nfx/5ZoXjjA/jiRTBuAIvX2F55zwJ6HlEJlG61SCer4Zn0UsBs2cHPkfKDd8WBS1L/TAp19Hcho2sJRo6Udg+vy4bxcvfayP0jFAeZhaGewRr1BZpZKaIkYWS1u1ROSf0SSo1LWRr2pjAXsc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58003152B;
	Mon, 24 Feb 2025 09:35:06 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.65.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 001BA3F5A1;
	Mon, 24 Feb 2025 09:34:47 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: lukasz.luba@arm.com,
	rui.zhang@intel.com,
	srinivas.pandruvada@linux.intel.com
Subject: [PATCH 2/4] thermal: k3_j72xx_bandgap: Use kcalloc() instead of kzalloc()
Date: Mon, 24 Feb 2025 17:33:04 +0000
Message-ID: <20250224173432.1946070-3-lukasz.luba@arm.com>
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
 drivers/thermal/k3_j72xx_bandgap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 70de6dbf99c5a..a36289e61315a 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -460,13 +460,13 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
-	ref_table = kzalloc(sizeof(*ref_table) * TABLE_SIZE, GFP_KERNEL);
+	ref_table = kcalloc(TABLE_SIZE, sizeof(*ref_table), GFP_KERNEL);
 	if (!ref_table) {
 		ret = -ENOMEM;
 		goto err_alloc;
 	}
 
-	derived_table = devm_kzalloc(bgp->dev, sizeof(*derived_table) * TABLE_SIZE,
+	derived_table = devm_kcalloc(bgp->dev, TABLE_SIZE, sizeof(*derived_table),
 				     GFP_KERNEL);
 	if (!derived_table) {
 		ret = -ENOMEM;
-- 
2.48.1


