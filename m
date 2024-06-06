Return-Path: <linux-pm+bounces-8688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AB08FE209
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 11:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 273DFB26391
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 09:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBB114F11A;
	Thu,  6 Jun 2024 09:01:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BBE13AA5E;
	Thu,  6 Jun 2024 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664482; cv=none; b=Qxo9GDjJZEpYlPfJ6m6QQNQkaZtllGpO4IASmOxoFrWpnCBeND7Mn7YRspBTirSFYsi6cS+ge2y0O4Kq21EQGf7WBozbPVaB/LrxmDOcAh3fUr//rRCmxxEX/kY6lHv863XI7b6Etdxovc+1La4d9kUsFm7W/e0YlmQgw83ZuNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664482; c=relaxed/simple;
	bh=qML0uzCbmFJloLReDcFy0oJJlPIuvZmfqSV9p2czb8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qJuRhzjFIRC7I4UuW0jsA9aYVPonoC42fU8BylagLFzl+NzBd5C5yGxm+ClZ+W0gtxItmSCtWbTBs3+cIxMRW55yCcuf1snQ/c8h61bAy3+Ci5gGoIjsCHrg5vm6j5LYZFBdfQPCXft68YN4WhIc67zGce2P/AOXNkmx4td0nY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBC38339;
	Thu,  6 Jun 2024 02:01:44 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.71.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E9E093F762;
	Thu,  6 Jun 2024 02:01:17 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: vincent.guittot@linaro.org,
	qyousef@layalina.io,
	peterz@infradead.org,
	daniel.lezcano@linaro.org,
	anna-maria@linutronix.de,
	kajetan.puchalski@arm.com,
	lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 2/6] cpuidle: teo: Don't stop tick on utilized
Date: Thu,  6 Jun 2024 10:00:46 +0100
Message-Id: <20240606090050.327614-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606090050.327614-1-christian.loehle@arm.com>
References: <20240606090050.327614-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As we expect to be woken up early, stopping the tick is likely to be
a waste.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpuidle/governors/teo.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 45f43e2ee02d..2c427dd4cac0 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -429,10 +429,13 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 			idx = 0;
 			goto out_tick;
 		}
-		/* Assume that state 1 is not a polling one and use it. */
+		/*
+		 * Assume that state 1 is not a polling one and use it, but
+		 * don't stop the tick as we expect to be woken up early.
+		 */
 		idx = 1;
 		duration_ns = drv->states[1].target_residency_ns;
-		goto end;
+		goto out_tick_state;
 	}
 
 	/* Compute the sums of metrics for early wakeup pattern detection. */
@@ -618,6 +621,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	    duration_ns >= TICK_NSEC) || tick_nohz_tick_stopped())
 		return idx;
 
+out_tick_state:
 	/*
 	 * The tick is not going to be stopped, so if the target residency of
 	 * the state to be returned is not within the time till the closest
-- 
2.34.1


