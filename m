Return-Path: <linux-pm+bounces-41114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E63CBD3AC7E
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 15:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 528B630CCD05
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 14:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2816135E55A;
	Mon, 19 Jan 2026 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbTEF4dx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533C4231836
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833092; cv=none; b=Hrpo4HFx/EeY3g+DHRQo2UMCqkzK/uicPrMXvKbCyovtW4PPqoZSFi30tQzIF97RhghFMlyIAhnzZp+BVvtqXk2bayP0wDeKngNz19Uyrst90cYCv5qycZEVmPUqSlAVrYkex++1fWbctrmVVu0yTMog65CJRSy5b9JHdKxN500=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833092; c=relaxed/simple;
	bh=h63v7DdGLRtlIfqMHyUIhqVL2bPvgYNJszyikys8Ey8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rk0267ZD58spC3UlUH4ntCv2BZSXszZ4p5oqb6VEoQB3MoIkfVzKwxg6vW9tMsICgTvP8bEXhl8chKOjkFhPMzyXgtsId1SpTelSI7XQ2X2oKv2O3HTqnIWymv0QH3Rln75svhX5twpjUd1hTVgiVjSGpDFPV2YDTlGrh3W9E5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jbTEF4dx; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59b8364e4ccso4733368e87.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 06:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768833088; x=1769437888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jObY0CxQBZKbycpkPqiQaIebxzWVFrjrCXXvaXSeJs8=;
        b=jbTEF4dxHvxOfmchCA3x1GZ3X4YCD4jfAaVOaOwxCqoUAlMHfJc7BrFOhnZccHcLG7
         42yU+MW4Emd6/siFKSOOM5LrJ/vTRfIwGs/iWVzAwyj6jxOOaasqTBm5Le3XXF+TpDr4
         QpDPk+rQioXcP1jv2RsCX1DXp6C98yCMJfI6beDIbpRw9ok9WqV8Ygv5tJaRDhK7XVDm
         swz4lZXU9u/7oqr9AgyEa/lc9dAp6l9nMl6X2gf1JBQE7P/82tmzPH8Tk+bKQyBILbBZ
         R8LTjU7thHhvfZdGollf3SS4PNSNFPkxXkx+3yfbR1Z4AroTyNbEiiVIen381JEna0aX
         yqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768833088; x=1769437888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jObY0CxQBZKbycpkPqiQaIebxzWVFrjrCXXvaXSeJs8=;
        b=v6Z3lSBVkVESc/wAcqhPY+Ie1rLteX8b7uleLA9Ue/FH+9gl71IDUitreOYV2FBngf
         OI80nkNjo+WFTDMXyxsLwTz730r28tW06IsFNB7t3wgsEsAImnqIgZOY2q9BxuUQlnEB
         vJCTiGwqafRKE1Mq/isQkrk0T6Dq4NG/tNXdPvenAM9SrD5j/h9lWlD98khl2onaHr35
         KIhRbkavLew/DlBvfF5eY5UBKaQU6iKB86MREVNOkOZxUXpVMMIuet3C04AydHc4dnQZ
         Dnoyx4rQOQAPvWZYwGlVyQD5Dm4I6CrtD3YHDU1sNrSg4seYqodGYV6kEdG67yj4OmUM
         U4ig==
X-Forwarded-Encrypted: i=1; AJvYcCVhZ3GsHa2w3Faqd9tymSiVYOENpLADhzDW/TlLK4aQj4q/tQvDeA+0rGwG9mF/0eQicYIPzPqnaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Ody9GH8fWrQNKPtV6w2lw1RxB3UhixbF8cF3K+HUnjSp0Zwm
	eRdc1mh3+WP8LJobiakiZKRE9WDEK1xDvSyk3QozMZ0M2n2UuY3Pna73bfj7lrhyUKQ=
X-Gm-Gg: AY/fxX4rFhIBNamKVl4y709tNN67piSjsFtonrX4zmTX4MyTOGjLoDn211gDNGLKWlg
	xU6Ncxj6vqSNaBPPZDI4if0ldgaDULLZGMs4f/NbgFzeltj97GbT5i5+xkqgi3oxHBO0pAK7QOJ
	Oya4q28TKeOZQknp4ii7b3LQX6qwPBjBUwmxlFW/CVfbvPuH1+mqKo5oF0iIozomOH8Ez3X4OyI
	M3h1fhlMGpqlGTMVfmfXAPt0+u6tifS3ylQ7OLyeQ0eTXqIMx7QRdXKn9o4dYHuBblGgnwQqWTj
	xd4FIV4X8SPdLvp5m3lHsZkG0PlVaApx48ws/xW/n9HdsyGCZHsPZrugyFZbk9dImNJK82bw/yb
	RirLhpBptgDrPJFeqr4miDdB5laBpaeqfzSfUrn6Lld+jsF78IK+5tcMJjy1LCzYwU2nVXoX1mi
	4q8OCyYSABA5D9DepYXdhqB2ygu4VCPv3vtVqT9hIcr1xu4dkl2jsWhNHWvWJ8
X-Received: by 2002:a05:6512:b95:b0:59b:7e2b:33db with SMTP id 2adb3069b0e04-59baeef6d5bmr3309809e87.28.1768833088255;
        Mon, 19 Jan 2026 06:31:28 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf33e7fcsm3407211e87.20.2026.01.19.06.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 06:31:27 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Dhruva Gole <d-gole@ti.com>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] pmdomain: core: Restructure domain idle states data for genpd in debugfs
Date: Mon, 19 Jan 2026 15:31:13 +0100
Message-ID: <20260119143121.161583-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119143121.161583-1-ulf.hansson@linaro.org>
References: <20260119143121.161583-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for additional information to be added for the domain idle
states in genpd's debugfs, let's make the existing information denser. To
allow that, let's move the static information of the domain idle states
into a separate debugfs file.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 43 ++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index bf82775f6a67..919dff2081d6 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3772,11 +3772,11 @@ static int idle_states_show(struct seq_file *s, void *data)
 	if (ret)
 		return -ERESTARTSYS;
 
-	seq_puts(s, "State          Time Spent(ms) Usage      Rejected   Above      Below\n");
+	seq_puts(s, "State  Time(ms)       Usage      Rejected   Above      Below\n");
 
 	for (i = 0; i < genpd->state_count; i++) {
 		struct genpd_power_state *state = &genpd->states[i];
-		char state_name[15];
+		char state_name[7];
 
 		idle_time += state->idle_time;
 
@@ -3788,14 +3788,36 @@ static int idle_states_show(struct seq_file *s, void *data)
 			}
 		}
 
-		if (!state->name)
-			snprintf(state_name, ARRAY_SIZE(state_name), "S%-13d", i);
-
+		snprintf(state_name, ARRAY_SIZE(state_name), "S%-5d", i);
 		do_div(idle_time, NSEC_PER_MSEC);
-		seq_printf(s, "%-14s %-14llu %-10llu %-10llu %-10llu %llu\n",
-			   state->name ?: state_name, idle_time,
-			   state->usage, state->rejected, state->above,
-			   state->below);
+		seq_printf(s, "%-6s %-14llu %-10llu %-10llu %-10llu %llu\n",
+			   state_name, idle_time, state->usage, state->rejected,
+			   state->above, state->below);
+	}
+
+	genpd_unlock(genpd);
+	return ret;
+}
+
+static int idle_states_desc_show(struct seq_file *s, void *data)
+{
+	struct generic_pm_domain *genpd = s->private;
+	unsigned int i;
+	int ret = 0;
+
+	ret = genpd_lock_interruptible(genpd);
+	if (ret)
+		return -ERESTARTSYS;
+
+	seq_puts(s, "State  Name\n");
+
+	for (i = 0; i < genpd->state_count; i++) {
+		struct genpd_power_state *state = &genpd->states[i];
+		char state_name[7];
+
+		snprintf(state_name, ARRAY_SIZE(state_name), "S%-5d", i);
+		seq_printf(s, "%-6s %s\n",
+			   state_name, state->name ?: "N/A");
 	}
 
 	genpd_unlock(genpd);
@@ -3891,6 +3913,7 @@ DEFINE_SHOW_ATTRIBUTE(summary);
 DEFINE_SHOW_ATTRIBUTE(status);
 DEFINE_SHOW_ATTRIBUTE(sub_domains);
 DEFINE_SHOW_ATTRIBUTE(idle_states);
+DEFINE_SHOW_ATTRIBUTE(idle_states_desc);
 DEFINE_SHOW_ATTRIBUTE(active_time);
 DEFINE_SHOW_ATTRIBUTE(total_idle_time);
 DEFINE_SHOW_ATTRIBUTE(devices);
@@ -3911,6 +3934,8 @@ static void genpd_debug_add(struct generic_pm_domain *genpd)
 			    d, genpd, &sub_domains_fops);
 	debugfs_create_file("idle_states", 0444,
 			    d, genpd, &idle_states_fops);
+	debugfs_create_file("idle_states_desc", 0444,
+			    d, genpd, &idle_states_desc_fops);
 	debugfs_create_file("active_time", 0444,
 			    d, genpd, &active_time_fops);
 	debugfs_create_file("total_idle_time", 0444,
-- 
2.43.0


