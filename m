Return-Path: <linux-pm+bounces-14674-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05381985D56
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 15:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52111F274B5
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3251E0082;
	Wed, 25 Sep 2024 12:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpWs8iH3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516531DFE3B;
	Wed, 25 Sep 2024 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265798; cv=none; b=ZfTWbGhduhez0PpPe2smkzBuxwZoLx901+YwY3yB6nzflt+VyKyUyO0cGSlhvyKFoehPLQM1eXLWkNgfO6Y5aAYjh37EemLmpJDnd7AehJsAxn0r3Rc+OLmpEbKW4H+8M/zhFzBlS14x6Guli8+ow3lU/uXwNcnoNJifbIvOuMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265798; c=relaxed/simple;
	bh=Z5ySSR+BEZCRlW6ok+c9JHqTZnqbFibGazoAbKcH/UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsAdFwbw60dC+EGhq4iSHIk21KzBte1Z+ffTXHET9k22Ooy/xMkFzwym9kmTADkZm0+TzFpF8SA0FZknAaMk9Wg7WpIgIAOSsnJrjqiqq1ibrsI/5Qqf46XlsZNGVr6ElGIXh92jQzLB+rUvCcQcr7d90ADYVikJTSAE3JpPSls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpWs8iH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D42C4CECD;
	Wed, 25 Sep 2024 12:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265797;
	bh=Z5ySSR+BEZCRlW6ok+c9JHqTZnqbFibGazoAbKcH/UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TpWs8iH3iemTED3XlQf7244EL2P/Ugyn4hWvbopAWKcKBpugC6EABCsj9NJNncoBj
	 YQGRYUTCgU5ZASw2nFK2vBPiPwGSYEO0wJSjjsuzFlgskJj2FE4K87Voedpltp3EO7
	 MOX/C/97k3A3yFkzLLNdTAKKo4N/8etOdjSyrWfCJzWp+kOafbwIFTgSuVdIr5R4Jx
	 G3RsF9kv3AUMhaXRIr2y6HayQLFJtU0yzJaI3UAJ6reA9FegV0V70gdmsn2iC9WsTv
	 CQT/fW+4YqJiRq0gAAF36RxnHMLqKTbUB+Y39BB5TtXF52DJ1go5vj8F2OnZJNe9eZ
	 qGCMj9iyql4jQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Raghavendra Kakarla <quic_rkakarla@quicinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 100/197] pmdomain: core: Don't hold the genpd-lock when calling dev_pm_domain_set()
Date: Wed, 25 Sep 2024 07:51:59 -0400
Message-ID: <20240925115823.1303019-100-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index 623d15b68707e..c45819debde96 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1694,7 +1694,6 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	genpd_lock(genpd);
 
 	genpd_set_cpumask(genpd, gpd_data->cpu);
-	dev_pm_domain_set(dev, &genpd->domain);
 
 	genpd->device_count++;
 	if (gd)
@@ -1703,6 +1702,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
 
 	genpd_unlock(genpd);
+	dev_pm_domain_set(dev, &genpd->domain);
  out:
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
@@ -1759,12 +1759,13 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
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


