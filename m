Return-Path: <linux-pm+bounces-7977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB79B8C96A4
	for <lists+linux-pm@lfdr.de>; Sun, 19 May 2024 23:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998471F210F6
	for <lists+linux-pm@lfdr.de>; Sun, 19 May 2024 21:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0610448CC7;
	Sun, 19 May 2024 21:04:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4B026AEC;
	Sun, 19 May 2024 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716152652; cv=none; b=u9lp1lx8C5lwTVudZpg9Cdg7jFQV68SNQ+glPQOb/WJTdgm/fv+h9kc1nYvuToJ1ICk0yx05a7fwbcJ+sSl/4mQR6z1JFwFSVuzVrC71iyLjWbtaCBx4CUNKn1qzxHQ/7QTjjSATiT/FLTeIdVm9wxh/GJssCF9EFwpK4sSBT5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716152652; c=relaxed/simple;
	bh=d9zC13sd+PcOp2vUU2yC7M1ViEVGOliY1ayJq7D3KmI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=DGxaBhvH3r1XGjCdT+alrEB02Enyos6yEiqFepoINZwcrOyY4Sv7newVk5P/6vWJE6lsnRB1yK++w6v3a6ITCPljGGFQ1txSdBs/vxReWn3fQWiPY7x3EB+yQjmdn7kjIdYXd1DacNyZJtqFZSn9evFmAgfhLDNaSc4tjPX6oO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F261F1007;
	Sun, 19 May 2024 14:04:26 -0700 (PDT)
Received: from [10.57.85.2] (unknown [10.57.85.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 701D73F762;
	Sun, 19 May 2024 14:04:01 -0700 (PDT)
Message-ID: <0ce2d536-1125-4df8-9a5b-0d5e389cd8af@arm.com>
Date: Sun, 19 May 2024 22:03:59 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Qais Yousef <qyousef@layalina.io>, kajetan.puchalski@arm.com,
 Anna-Maria Behnsen <anna-maria@linutronix.de>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] cpuidle: teo: fix underflow of recent intercepts
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The recent counter of each cpuidle state bin reflects the number of
recent intercepts. It's decremented and incremented accordingly.
The decrement was never checked for 0, therefore underflowing into a
value teo cannot easily recover from.

The underflow lead to deeper idle states being skipped because teo
assumed interception was likely and it preferring shallower states.

Fixes: 77577558f25d ("cpuidle: teo: Rework most recent idle duration values treatment")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpuidle/governors/teo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 7244f71c59c5..42fb2771e35d 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -290,7 +290,8 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	if (cpu_data->next_recent_idx >= NR_RECENT)
 		cpu_data->next_recent_idx = 0;
 
-	if (cpu_data->recent_idx[i] >= 0)
+	if (cpu_data->recent_idx[i] >= 0 &&
+			cpu_data->state_bins[cpu_data->recent_idx[i]].recent)
 		cpu_data->state_bins[cpu_data->recent_idx[i]].recent--;
 
 	/*
-- 
2.34.1

