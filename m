Return-Path: <linux-pm+bounces-41116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D393D3AC89
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 15:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A54430DD79F
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 14:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1687736CE11;
	Mon, 19 Jan 2026 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bs/DKRdb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542A9361DA7
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833094; cv=none; b=Z4aO1ymaVKcrLsEMy4RbPK2o9XmgFvC+qJNoIClYUDR9N+yqTPrEupqx/Knq2Sf4XDQMKrFpzn7v5BLS6Vb7trvX6CR0i0yKR7zlOT/FfFWilCJXsQgDYzjNlaqM9FAzorDZPYSVGxXDakyxECnpMK7XC9pj9zg/47xXnoOEWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833094; c=relaxed/simple;
	bh=9+QkNdO5VQ2yPX0vM4RE6f2/Gi4gkhAf8OoCEvuCYjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVD/T8ldd+ZoJFMOo8c0ZwumeykPrv/Wtn2RAkZCGibauUdngKrgDBSmmstuRW1pTHeAgQj9Qw9fYKYPT/z025UjmH7okeseIACA7MTm1r84c2zKYqD143TAsdKESzpAEt7c1vBIQ6GFuCjA5qzx/oGAYTvy+7X8e/fXrj6fTUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bs/DKRdb; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59b6c89d306so4933862e87.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 06:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768833090; x=1769437890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64A4cniu7Nu112V7CHRL//FijlPeEL9Dny3BjkKYjlY=;
        b=Bs/DKRdbQUuEmQcwfrCaVcs4LS3vObov/7EJR0XQhrgj2lNtOzCkkM3lip8ycaMvdT
         /eMnepArYxb7PrjSYO1iv6vdVW70wEOMcVyFmWPcxSQPF3n0e14eIh+IwqcDaA9Ihqkt
         QXIKlIjZbcZexAcgBFdfW2zZ9Tcr1nuF5FM3tJPp+Np9AC40X1gUOihnXZA914QyfA48
         WaJdQmKE74kKRhfWMH4ibOEj9aZ6yDQqyTz8SYUyRjLpnp6cr+qPtBa3R7MwleAx9YVP
         LqeSi+al0VssouWBDLDj8hoXS2X/UwTgOkBWz4RtKPO8F7VfFV/AKt5xnqPRE4eEU2Nu
         aUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768833090; x=1769437890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=64A4cniu7Nu112V7CHRL//FijlPeEL9Dny3BjkKYjlY=;
        b=UD+tPQfaA4IoKgR+RAlmZoRDJ/XO+2PS15Kk8hke2OQljVjpdeYdBP59HGnuefUb99
         O+wpbH4KD0uv1uo/mA1l613f+Vj9PzmJqZi8CIeRdF0sz/Mz7pb71V/RyrbGYthxtXeS
         aa7V69Gyb4L/vNhVh+mVc6TE2nl+V8zxJryMUAP/Q2HRa5oc5DVygyHHoNShgLNZ/mo+
         MQ/ethrpCPzHI67pifPBk4D8Z5aVvM3p1DU/fGOIA1bl1DYqHHXtEnP3sMiUW/fVLRsw
         xDD4BMZAbsmJU84U53izA4yew2kyVuucVqLSpf32te8WbVMuoiPzZxyknIZNZmI+NHf7
         6WaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRb8bETAgwcmhtHBAOTnijLlFoTj5RdS40BH/8Jd9m5WFL0DtV/LPm9ZbyYLpl/o7nxNcY7NTseQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeqQFL6B+NoLiTlsmh4q4ivvwjWeJa3OxeNO4KNVVPvX89lpC7
	Y0xFWNfVijlWvWGXrA+vJfJmcJtxSQrujplDtgmOZAI5XtT0kBgp7GVvpMgX/7d8oCw=
X-Gm-Gg: AY/fxX7DCWHw7kczftHP9z/eDX3RDoXR24U0Hy1tVzzuDzrgP8d5yptd/GsyEUPKmLe
	c10SpQzpK4nSr8ni/BxD2mMhg0a3pDTGo36IcebMpO86qHOjhWbzx1Jd4ajy9SmmvW1Ge3E27h9
	P4poUcQjRljnjwTKoapoIZk3iMd9PXescvwCzX2GaAez7FtMfNav6x9vDvId3VliTQtxSPSYUbG
	qrigVJv18knwYeyUPWcYlTHMzD6QUKvrt5h4ZkQZXlI739CjJQB2tYlybAfTLy4O4hBvO6BPRMx
	DcbVFZ3S3Szxyz+miZbS9tq+FBLVMNZGxpfMCNljt3Wnig2QMb6n4k3m+uJi/vW4xTXsztYNAup
	HC/xcp/ps/2lyPfDb2Ga7jJ7yFz7sfnDrIAQMc/3zr9hlUmYgV4FDM6xpQi8MyFIVA2W2Ozysi2
	t0kgh7ic0edN8qFzjBgKGMrd2f/ZCkWOMIbZedRnUQDK8Hfr/GIWnb5vZgfcvH
X-Received: by 2002:a05:6512:b1a:b0:59c:ba5a:c085 with SMTP id 2adb3069b0e04-59cba5ac2d3mr1685282e87.0.1768833090357;
        Mon, 19 Jan 2026 06:31:30 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf33e7fcsm3407211e87.20.2026.01.19.06.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 06:31:29 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Dhruva Gole <d-gole@ti.com>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] pmdomain: core: Extend statistics for domain idle states with s2idle data
Date: Mon, 19 Jan 2026 15:31:15 +0100
Message-ID: <20260119143121.161583-4-ulf.hansson@linaro.org>
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

To allow user space to monitor the selection of the domain idle state
during s2idle for a CPU PM domain, let's extend the debugfs support in
genpd with this information.

Suggested-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c   | 13 ++++++++++---
 include/linux/pm_domain.h |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index bf512ff0857d..bb04cb7ccdcd 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1438,6 +1438,13 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 		return;
 	} else {
 		genpd->states[genpd->state_idx].usage++;
+
+		/*
+		 * The ->system_power_down_ok() callback is currently used only
+		 * for s2idle. Use it to know when to update the usage counter.
+		 */
+		if (genpd->gov && genpd->gov->system_power_down_ok)
+			genpd->states[genpd->state_idx].usage_s2idle++;
 	}
 
 	genpd->status = GENPD_STATE_OFF;
@@ -3772,7 +3779,7 @@ static int idle_states_show(struct seq_file *s, void *data)
 	if (ret)
 		return -ERESTARTSYS;
 
-	seq_puts(s, "State  Time(ms)       Usage      Rejected   Above      Below\n");
+	seq_puts(s, "State  Time(ms)       Usage      Rejected   Above      Below      S2idle\n");
 
 	for (i = 0; i < genpd->state_count; i++) {
 		struct genpd_power_state *state = &genpd->states[i];
@@ -3790,9 +3797,9 @@ static int idle_states_show(struct seq_file *s, void *data)
 
 		snprintf(state_name, ARRAY_SIZE(state_name), "S%-5d", i);
 		do_div(idle_time, NSEC_PER_MSEC);
-		seq_printf(s, "%-6s %-14llu %-10llu %-10llu %-10llu %llu\n",
+		seq_printf(s, "%-6s %-14llu %-10llu %-10llu %-10llu %-10llu %llu\n",
 			   state_name, idle_time, state->usage, state->rejected,
-			   state->above, state->below);
+			   state->above, state->below, state->usage_s2idle);
 	}
 
 	genpd_unlock(genpd);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 93ba0143ca47..f6f6d494f728 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -183,6 +183,7 @@ struct genpd_power_state {
 	u64 rejected;
 	u64 above;
 	u64 below;
+	u64 usage_s2idle;
 	struct fwnode_handle *fwnode;
 	u64 idle_time;
 	void *data;
-- 
2.43.0


