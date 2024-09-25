Return-Path: <linux-pm+bounces-14672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3441E985A73
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 14:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1255B2625C
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 12:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224EC1B5EB0;
	Wed, 25 Sep 2024 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3S7GZEx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA08D1B5EA7;
	Wed, 25 Sep 2024 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264541; cv=none; b=hpvxaO1SjboA8dcvXn/Then03hdjzmA3iaq+TYNZZ2DcXcje4Vm8DFRUsU850A4u3y6a9NFdynRgjeMU87fZEqv9xxrlBl+61Srtf1x33jghTZGyVbRJyVlTjbw8CG7jUoGkdUT/4BLzR8F20+DTPVXUOecRSqFf3koLX+KDJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264541; c=relaxed/simple;
	bh=QxyhHlGqjynd10WnJVI7hQSbTdQXFAQM/iD8PYjcBb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fz6qkzHeFdiz5oJ9KCp/8qRSlOMcuPVx3U28iLdkOd1migh8MrL4/Xcoi4hTtVVpigHX1AWbB3686uUtR7zpcsb9Uk3OxEWxhVQcAOVYETz0QOlRWN99W38b5wZGMFCO1sOthfZNmyiqk+ssA6llve1Kd+pqysqkidg5d2CFiEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3S7GZEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875E4C4CEC7;
	Wed, 25 Sep 2024 11:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264540;
	bh=QxyhHlGqjynd10WnJVI7hQSbTdQXFAQM/iD8PYjcBb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g3S7GZExZxEcLIOQcFPSb3RCWzBM61gbIr8ls7XZ0C5rlzfpYyGcvQSTXkO51QbYJ
	 X+NVb3ZeZsPEq1Htdx2zghxagTf186fE3Wmpdqh0saoYvvmXmijTzjyJRI4CWbMCdI
	 20tpf/le02zCiu3XUauU2+qGURdwXdl6r+DBiul5aOxAYeHCGwAoVeTvwYaMBWqiyK
	 RIYJbzJoeGBAxtNWHTQ5to6S3RzItERg620dDkOBR+il7QNPkPpZ6fAX2WNUVW1F9+
	 +ykJz+wGLK6hE8QxkWr9n/Xydu0TurUNZ6rEMkoomvlOFEAZSnTuJfisTZsBdKHDbW
	 hUT2bulvnAHOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Raghavendra Kakarla <quic_rkakarla@quicinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 117/244] pmdomain: core: Use dev_name() instead of kobject_get_path() in debugfs
Date: Wed, 25 Sep 2024 07:25:38 -0400
Message-ID: <20240925113641.1297102-117-sashal@kernel.org>
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

[ Upstream commit 9094e53ff5c86ebe372ad3960c3216c9817a1a04 ]

Using kobject_get_path() means a dynamic memory allocation gets done, which
doesn't work on a PREEMPT_RT based configuration while holding genpd's raw
spinlock.

To fix the problem, let's convert into using the simpler dev_name(). This
means the information about the path doesn't get presented in debugfs, but
hopefully this shouldn't be an issue.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Raghavendra Kakarla <quic_rkakarla@quicinc.com>  # qcm6490 with PREEMPT_RT set
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20240527142557.321610-4-ulf.hansson@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pmdomain/core.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 7b2f8b1417de8..17b31a524697a 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3210,7 +3210,6 @@ static int genpd_summary_one(struct seq_file *s,
 		[GENPD_STATE_OFF] = "off"
 	};
 	struct pm_domain_data *pm_data;
-	const char *kobj_path;
 	struct gpd_link *link;
 	char state[16];
 	int ret;
@@ -3243,17 +3242,10 @@ static int genpd_summary_one(struct seq_file *s,
 	}
 
 	list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
-		kobj_path = kobject_get_path(&pm_data->dev->kobj,
-				genpd_is_irq_safe(genpd) ?
-				GFP_ATOMIC : GFP_KERNEL);
-		if (kobj_path == NULL)
-			continue;
-
-		seq_printf(s, "\n    %-50s  ", kobj_path);
+		seq_printf(s, "\n    %-50s  ", dev_name(pm_data->dev));
 		rtpm_status_str(s, pm_data->dev);
 		perf_status_str(s, pm_data->dev);
 		mode_status_str(s, pm_data->dev);
-		kfree(kobj_path);
 	}
 
 	seq_puts(s, "\n");
@@ -3422,23 +3414,14 @@ static int devices_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 	struct pm_domain_data *pm_data;
-	const char *kobj_path;
 	int ret = 0;
 
 	ret = genpd_lock_interruptible(genpd);
 	if (ret)
 		return -ERESTARTSYS;
 
-	list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
-		kobj_path = kobject_get_path(&pm_data->dev->kobj,
-				genpd_is_irq_safe(genpd) ?
-				GFP_ATOMIC : GFP_KERNEL);
-		if (kobj_path == NULL)
-			continue;
-
-		seq_printf(s, "%s\n", kobj_path);
-		kfree(kobj_path);
-	}
+	list_for_each_entry(pm_data, &genpd->dev_list, list_node)
+		seq_printf(s, "%s\n", dev_name(pm_data->dev));
 
 	genpd_unlock(genpd);
 	return ret;
-- 
2.43.0


