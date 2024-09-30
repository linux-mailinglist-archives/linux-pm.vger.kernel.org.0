Return-Path: <linux-pm+bounces-14933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD4E989E6F
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 11:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6158B2887BA
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 09:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ED3189534;
	Mon, 30 Sep 2024 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o68bGup5"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9367189F39;
	Mon, 30 Sep 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688783; cv=none; b=aC/XwmaT9jX1KeE45qgQO7YMRryMNjv9MtGyUGUHI/f9A/relCzY1e5zXJ7uK+MXRKZOHJyuKPlqOTrSlh9CcB9q9w5qXn4jCZmFbxZ8NUkBhapXo6vL5nO+Oqsl75d88qsN1b2vin/+JWfI/HT0dA4Z3eh4Z6R+K+tN2kGTCQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688783; c=relaxed/simple;
	bh=ETCZJl2hvenovoiVHwckcLTtShZZABdCaDoHGGgnfU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PF1Dzf3LuqVWjAKoXQYIJqNZjXJwFMmKEqt8A8BDnSxJsouCpFr4bu8II1hgK4ZQhuu+p6y+frOZwlKkECtJMcP8sxh5f3QkX4cUsHg+0h+pn3a77t/W2ozio53qyUfEOvvvMNElcQMkV06ss1aDar3ZM+7pF7nBfSaT3j7I6os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=o68bGup5; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48U9WlJw113835;
	Mon, 30 Sep 2024 04:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727688767;
	bh=9pKcgzqovl6h5rOv45dmznA3UOESkuOmvAsaDkjkxa0=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=o68bGup5Z4DtvTNRLzUNDnkOn6JLAuPiJiO4zG32AFTr31w2isdV5RybbkZDpvyKF
	 94XnuIuA1JrbhrdIMCnFVqA/2bJ1EUU2gbdLZt823GuTVrQ5Jgj+zNnAskiLHYLLY8
	 N4fkIhto9oAHTwBSDQ6VJW+voNvt78Q0hj0T8T+Q=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48U9WlUw081907
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Sep 2024 04:32:47 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 30
 Sep 2024 04:32:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 30 Sep 2024 04:32:46 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48U9WcvB021643;
	Mon, 30 Sep 2024 04:32:44 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Mon, 30 Sep 2024 15:02:10 +0530
Subject: [PATCH 2/2] cpufreq: ti-cpufreq: Remove revision offsets in AM62
 family
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240930-b4-ti-cpufreq-am62-quirk-v1-2-b5e04f0f899b@ti.com>
References: <20240930-b4-ti-cpufreq-am62-quirk-v1-0-b5e04f0f899b@ti.com>
In-Reply-To: <20240930-b4-ti-cpufreq-am62-quirk-v1-0-b5e04f0f899b@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bryan Brattlof
	<bb@ti.com>, Nishanth Menon <nm@ti.com>,
        Andrew Davis <afd@ti.com>, Dhruva
 Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727688758; l=1272;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=ETCZJl2hvenovoiVHwckcLTtShZZABdCaDoHGGgnfU0=;
 b=gNoa9y0wY4hjf4Qz/y9YYN5fKAuVKILEDwsuyB7OmhwfCr+naWO1Xq8q9O5d6cmQH0eFEV5U5
 Dy64/5FDbsyCAoHauyl0a0pUQy9kyUqpojOeoV/J30eudDDAWL0CC7J
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

With the Silicon revision being taken directly from socinfo, there's no
longer any need for reading any SOC register for revision from this driver.
Hence, we do not require any rev_offset for AM62 family of devices.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 7014cebb41e3490cadd14834e0c3e057419f2abb..5a5147277cd0ab03031926cd62f6ba61aea78512 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -318,7 +318,6 @@ static struct ti_cpufreq_soc_data am625_soc_data = {
 	.efuse_offset = 0x0018,
 	.efuse_mask = 0x07c0,
 	.efuse_shift = 0x6,
-	.rev_offset = 0x0014,
 	.multi_regulator = false,
 	.quirks = TI_QUIRK_SYSCON_IS_SINGLE_REG,
 };
@@ -328,7 +327,6 @@ static struct ti_cpufreq_soc_data am62a7_soc_data = {
 	.efuse_offset = 0x0,
 	.efuse_mask = 0x07c0,
 	.efuse_shift = 0x6,
-	.rev_offset = 0x0014,
 	.multi_regulator = false,
 };
 
@@ -337,7 +335,6 @@ static struct ti_cpufreq_soc_data am62p5_soc_data = {
 	.efuse_offset = 0x0,
 	.efuse_mask = 0x07c0,
 	.efuse_shift = 0x6,
-	.rev_offset = 0x0014,
 	.multi_regulator = false,
 };
 

-- 
2.34.1


