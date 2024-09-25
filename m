Return-Path: <linux-pm+bounces-14671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FFC985A65
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 14:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775B91C237E7
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 12:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F791B580D;
	Wed, 25 Sep 2024 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBYSqrbR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA0418C931;
	Wed, 25 Sep 2024 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264539; cv=none; b=ozT2SVfbEdN7Os0DLd1LhZq0yGbFmFMYtIBDVGEWVCM5OeyNGhs9lFzRJnIIeES4d6m7UtArxa4wJWOmYjDCsrHHxyst3yg/jL+BOvw/GOaL9rTRyBglngDEo9kCTKNYlK21O8mM6I5TBi9cOuMNEf1MD9lVZ8u1UDYQN3TIZ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264539; c=relaxed/simple;
	bh=a5FKxM9TI86GXq66al+BZuV4NLTfkQo2ArkgmdetOpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fR8+SNpaIcJbdheLv30au2ecOH+AwCT5is4wJB6q+59G0QYYOQfFXM4X6clMEfyR5IL0qpsajlw/q5jE/g56GNLgZaAcfJzoKgTI2w2l/QFYBOB3lZAmFcw3gXi37EZjzh35y0Wj3WK8qniE1Y4lXfzQPmXI+Dw2enwRznjaZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBYSqrbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CC0C4CED3;
	Wed, 25 Sep 2024 11:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264539;
	bh=a5FKxM9TI86GXq66al+BZuV4NLTfkQo2ArkgmdetOpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DBYSqrbR8MYz2ea69vbbhgmqN6mU4bW/uYWJCbOhH9G30InOMOKn3fDvyZTb9g2NT
	 Iai1QuVrxyW04xf1ke8c031YumM7Jyn9rJ8+q8khd0tTYs9PFCIxE9Pfqm8F5HeId5
	 Tv9xlfm4zrbPG1SOlTtvSWeleMIama78UTCBTAgkPw3hKbb0dA4pijURXKrY+xL+ET
	 dq65HheF9c15Q0Sq24773MBWe+l/PSFa8xKW768UNylThfwtxAI2rqO1wHTVjGyzG9
	 2P5yJuyR2hiJNrBAP0sdt3lQ7MZJKrl84+OssUG1A1m7ZwGDaycjJynlu5XjPf9cC+
	 er7JdGopqfXhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Raghavendra Kakarla <quic_rkakarla@quicinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 116/244] pmdomain: core: Don't hold the genpd-lock when calling dev_pm_domain_set()
Date: Wed, 25 Sep 2024 07:25:37 -0400
Message-ID: <20240925113641.1297102-116-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit b87eee38605c396f0e1fa435939960e5c6cd41d6 ]

There is no need to hold the genpd-lock, while assigning the
dev->pm_domain. In fact, it becomes a problem on a PREEMPT_RT based
configuration as the genpd-lock may be a raw spinlock, while the lock
acquired through the call to dev_pm_domain_set() is a regular spinlock.

To fix the problem, let's simply move the calls to dev_pm_domain_set()
outside the genpd-lock.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Raghavendra Kakarla <quic_rkakarla@quicinc.com>  # qcm6490 with PREEMPT_RT set
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20240527142557.321610-3-ulf.hansson@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pmdomain/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 7a61aa88c0614..7b2f8b1417de8 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1758,7 +1758,6 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	genpd_lock(genpd);
 
 	genpd_set_cpumask(genpd, gpd_data->cpu);
-	dev_pm_domain_set(dev, &genpd->domain);
 
 	genpd->device_count++;
 	if (gd)
@@ -1767,6 +1766,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
 
 	genpd_unlock(genpd);
+	dev_pm_domain_set(dev, &genpd->domain);
  out:
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
@@ -1823,12 +1823,13 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 		genpd->gd->max_off_time_changed = true;
 
 	genpd_clear_cpumask(genpd, gpd_data->cpu);
-	dev_pm_domain_set(dev, NULL);
 
 	list_del_init(&pdd->list_node);
 
 	genpd_unlock(genpd);
 
+	dev_pm_domain_set(dev, NULL);
+
 	if (genpd->detach_dev)
 		genpd->detach_dev(genpd, dev);
 
-- 
2.43.0


