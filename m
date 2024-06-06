Return-Path: <linux-pm+bounces-8690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7590E8FE20D
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 11:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10AE0B23B83
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 09:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0533215278F;
	Thu,  6 Jun 2024 09:01:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D01914EC71;
	Thu,  6 Jun 2024 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664490; cv=none; b=CNKAGfukCAH8Pc9ag0cpRgKuHhGisTzWhi10FUgEs5IZ0Fphgek0d8tWHMVaY4shryjYHFYOMAlcL9vKHzMR9y6wsspX6d62DFNu0ZxNO9rR3aDtADxs+rC3e9q6AGrJA0naFUf1cP2UdjS2OW5nCDGBe7GMhj+7gflgLWpm3UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664490; c=relaxed/simple;
	bh=BK15k8asB6S9tes/VSsFvDkpmsX7mPNMWzbLiswymSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EbZi35UqR9ylr3LTW+dp2h49oWZfu9XS/Imgk5uRkOkUgIWZlCAViNX8UgA9Dd44NWMpqqlf0X3IP1cF+CUe76PO6zK84frh65HWaCQZCQEecfi9jcFEKSwBRy0XheNPBsfLDQ0Th39971ycbaP0QSv6W1nsc8M0qSlPEzInbsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A8F9339;
	Thu,  6 Jun 2024 02:01:53 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.71.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ED7E63F762;
	Thu,  6 Jun 2024 02:01:26 -0700 (PDT)
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
Subject: [PATCH 4/6] cpuidle: teo: Increase minimum time to stop tick
Date: Thu,  6 Jun 2024 10:00:48 +0100
Message-Id: <20240606090050.327614-5-christian.loehle@arm.com>
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

Since stopping the tick isn't free, add at least some minor constant
(1ms) for the threshold to stop the tick.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpuidle/governors/teo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 216d34747e3b..ca9422bbd8db 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -622,10 +622,10 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	/*
 	 * Allow the tick to be stopped unless the selected state is a polling
 	 * one or the expected idle duration is shorter than the tick period
-	 * length.
+	 * length plus some constant (1ms) to account for stopping it.
 	 */
 	if ((!(drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
-	    duration_ns >= TICK_NSEC) || tick_nohz_tick_stopped())
+	    duration_ns > NSEC_PER_MSEC + TICK_NSEC) || tick_nohz_tick_stopped())
 		return idx;
 
 out_tick_state:
-- 
2.34.1


