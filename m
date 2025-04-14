Return-Path: <linux-pm+bounces-25359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157D5A87B87
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 11:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203A4168C27
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 09:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1627825DCE3;
	Mon, 14 Apr 2025 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="MOe9ZzBN"
X-Original-To: linux-pm@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897F01ACEDF;
	Mon, 14 Apr 2025 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744621768; cv=none; b=WYMH0ptMEFjL5OHpKuB/wZyrA7HcFb0aGZtIUH/uoT0eNRt+jf0tq8UxDphe6IuZD1cFLVPDC8ruaHu2DqaPezZg8uaXzhIX596evhBYXNhXcRRXvJgK0WfzODzjhZctRRbP9uF2YMl2wAdPR0DXIqT63UVojjgNylh0VoyAejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744621768; c=relaxed/simple;
	bh=3wZPbKQ5oUdhFU6aeVJ9IfGzc2VNcc3Z7mBcz6+L1Rc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ChvS0VsL5cRO3uXzYB3bOfTFMR7l6QKnWo2713io9mqSAhFmD5enT275uNQQ5B/hEQKZX5mRKBW/Ol4YRpuDWwr0rLuwOy6A3X+soQkESjgaqfkBp25LpwVWzgzG69UGADbBX/rQ3cr8L0SsxtTe5w5tK3/+P+3g64k50gFUPxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=MOe9ZzBN; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744621450; bh=H/KIZKqdS3yDEUxbnXVXELq5+Ffxoz4WFW5qpPHDmjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MOe9ZzBN75JF8AghUBGNN2/PzJO174U4AsCctf43LSjnymdsxlzZAVNpPFpLNnEyA
	 sJfz+i6sWrKRbiTIwInckqnm5sHzBctuwsAIce3c9WoTM5qznOa9/W/60xPmGle3yp
	 Z0eVGWEIr7YFkeUJwgdPN4Abmo+9DJ6zjOk+JiOg=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 108A92C4; Mon, 14 Apr 2025 17:04:08 +0800
X-QQ-mid: xmsmtpt1744621448ts30wq64d
Message-ID: <tencent_6D2374392DB66C9D23BF6E2546638A42EC08@qq.com>
X-QQ-XMAILINFO: MFdGPHhuqhNoktDupUjrbNsITT8+WvnxQpRzYhCSwdqyiSYJjVyD+PBOqK1f6x
	 9kAeyWzE9twRU15fFXk+8JWv+MNo34hLp8dav0Z7AWX491Ga3tGHPBcU4wPsWASbAK+prlqHTUk2
	 AAwcZu2L/+kT9ZHqPjy2ljvBEMhqdzd8Qtmtf5iFPHvUeNi6Bbqyhz3wlDEyMo9/WpypzXyd+Fzs
	 XGZW0EeN+bVJXwRl6zayRyyNZY9Cz1KlsBFKkBnvAuQ1OnP/rSo+/VR7/C2MBRrmK/tryXxvqNCP
	 zgo+QA5QgimAxqvbX7UjiWoOWRLBFIoH4lAC5YrPOi2xhesQKnhAOChnEvO4hIS8DvR5D/h9mgPO
	 6Zc4RQzObto2KnhGj066USSjULGAowzqSwWEq8KOcVqrtBJizFiTrYUXqD+4SJmWjlhb1n68Fa0E
	 Rm3i13jbs8yyjnSTUc2528x1ooPQ8viq7RZQSHLXfwq5/ijIBHeqMR9zEfhI65XFxQwuINefjSSJ
	 10c5jBOttmwaTEOVsfP6mExiwcCqDYXEBsIqbb1rgoq36idX5cRcghbeN26hgUP9e+9A+na5EOAx
	 UCWsUhBcLFRgyHaBgF60RF/iRuLAg029XZHEJTt0AZGaANwBGXRB0j2Szz/oYBuIgzFHYlnl5Blu
	 PrtdOlgyXCKQJgZ4nf3S4/FFsSGab7r0T3JfKxoeuR5jX89VF1DznhAmG5EW2JnV2Oh1nZ38PyG3
	 /38MXIHCEUTklOmMAfvyGFQDJl8jzd4sT0Pydq//GnwM+0SsMTkZVfmPRs3QIaF6i9oloXtKw9hI
	 E1nTPu1cXs+CVrdfkFrUdCNpEgcNXftqyfs6cHBBPepBxYFJ+GgLeayUlpx3x3GJYZAydcms7abv
	 v4LhdsenrtxEfd6HXEImbTtjAcqJxTvsyc8nUu2bimY+4iC2GThgY+pUX7LnWBGyhp1SpVPNOx0W
	 wqMhuMocY=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Yaxiong Tian <iambestgod@qq.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v3] PM: EM: Fix potential division-by-zero error in em_compute_costs()
Date: Mon, 14 Apr 2025 17:04:06 +0800
X-OQ-MSGID: <20250414090406.1255935-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

When the device is of a non-CPU type, table[i].performance won't be
initialized in the previous em_init_performance(), resulting in division
by zero when calculating costs in em_compute_costs().

Since the 'cost' algorithm is only used for EAS energy efficiency
calculations and is currently not utilized by other device drivers, we
should add the _is_cpu_device(dev) check to prevent this division-by-zero
issue.

Fixes: <1b600da51073> ("PM: EM: Optimize em_cpu_energy() and remove division")
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 kernel/power/energy_model.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index d9b7e2b38c7a..fc972cc1fc12 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -235,7 +235,7 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 
 	/* Compute the cost of each performance state. */
 	for (i = nr_states - 1; i >= 0; i--) {
-		unsigned long power_res, cost;
+		unsigned long power_res, cost = 0;
 
 		if ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost) {
 			ret = cb->get_cost(dev, table[i].frequency, &cost);
@@ -244,7 +244,7 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 					cost, ret);
 				return -EINVAL;
 			}
-		} else {
+		} else if (_is_cpu_device(dev)) {
 			/* increase resolution of 'cost' precision */
 			power_res = table[i].power * 10;
 			cost = power_res / table[i].performance;
-- 
2.25.1



