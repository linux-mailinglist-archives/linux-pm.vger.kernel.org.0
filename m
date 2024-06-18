Return-Path: <linux-pm+bounces-9482-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A5B90D7CE
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 17:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769711C20DF0
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590316F307;
	Tue, 18 Jun 2024 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zmsr+E2K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF2E43AC3
	for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725833; cv=none; b=YoC0EXM+5tYcyxwa7aOnU8uYe0LXUTnLi8lSmKb2nc8m1utFVLG+Iyk2914kTDzZA9cTPsXv+kv/vIs5XJZFJFd7D0s2AW4MFV8cE7oUe7iQ2JHZtOuHvI0+MnAPikKbsFSCMLlET2/mwEAzzwj9obikpBniHkRb/SYsx8/iYME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725833; c=relaxed/simple;
	bh=O83FNAdgJkgnscldJT04vDrZcANIzWxDsUu1SHrFuVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A98ErXQ5Yf6CBkzEbH8WLDOEZdq5hUKPWIxllDpIQphJ3ssM9eivpYT8uEpTM/5PesrGltwzeZ8DRyqxSSgs/qmkrKGK34r7/evfQtwHQhoSZaNe9MMA0/G7FyP1iKaBhnaOqp8lAQFO46QGHi7pKth97Cj7nQo/4EOXPbBsfzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zmsr+E2K; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso94055471fa.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718725828; x=1719330628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j0o2btwvxJuAvs23zoxm88cS8MnRzldpGlzftLOxRCk=;
        b=zmsr+E2KfIvSDLv1hwZZ1RJlEQJ0yo37Ra82b0MjeNoEGbFl9XyM45wMHlrhO0UuVG
         ZVPH+Kge0JYTpOUKMPAjoXXpwkzYK0Uratz4DCS8+DI6pc/wZ4N8oiGDEL/PqS48kDlW
         iMdelv+bm05dQV4RhFmHzh47kJSXHZe8e0Y5kNcZgAj0e8wfJHkS+1pQB4Wgmci5JTK/
         K71/pHY9BDbAzCmHInWLxRhFQjYds2u2tib0/GjwwLr/EYAqV6XYA+Dz9i3vDjrTOauC
         u3Fm72G87Po1d9+r8hEJsveaoYD7DDPAHW0CGiYIAZXu9/7VHHLXane6n9LE2+HG8+eY
         hn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718725828; x=1719330628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0o2btwvxJuAvs23zoxm88cS8MnRzldpGlzftLOxRCk=;
        b=Hx+u6KuoWWBlPGPhwmOv1mZzsWcp3V9s/QzLZ+qHT4IC2cLmZh4Lvy3SUWYbskWlpw
         WPePtRRfAiiA0Caph6ICvtfPaUf7yqeYYacXIbX8toAQDgb0+e8jddOWBD+aZZ03rtGB
         ns+NgykcWSB1wyanP+yfWTccqYAsaSMffCvyqpPqUDbXIno3bDKE2QZkbcsDA9eErlTT
         FjbYia7//a0790xlsE3jJmsvA1z1nQ6BCZZ/y2moT732tKnM1C0eG3/peIDzLQjZrSZT
         XhsDKe+FJYy24zx++C4bMcVTpLuWav+T36yo4VCFlR2HMtH0eeKGUJNohCAuZ1pGw7yQ
         YOJw==
X-Forwarded-Encrypted: i=1; AJvYcCVWkJM4cwmUlHfS7M747+CIk5rMnxKWB0XlFBrVXYStf9CW3rLyo0Rq53rRVErY16C82pux2cNEkW/n6UpcsuZNzOvcb9XhTkA=
X-Gm-Message-State: AOJu0YzREBlrfi2XPp03HJFIaG0/NeHCkgGjGoX5ZlLmW3vPCmuOqZXj
	w6FXzqWrbLMNe/pcBhqZ8HU+posQ6EW5eoBDu3LwjvXSdubfN6rw/aNQyeqfTls=
X-Google-Smtp-Source: AGHT+IHHHBPht25n9Gly0ArxuEAcjB2htzP4JMhnxdb/RauObkjrKLdR6j/+3D8xHpgeQ7/4CkMWXg==
X-Received: by 2002:a19:750c:0:b0:52c:76ac:329b with SMTP id 2adb3069b0e04-52ccaa369d8mr30796e87.35.1718725828111;
        Tue, 18 Jun 2024 08:50:28 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287241csm1544550e87.172.2024.06.18.08.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:50:26 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] OPP: Fix support for required OPPs for multiple PM domains
Date: Tue, 18 Jun 2024 17:50:13 +0200
Message-Id: <20240618155013.323322-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In _set_opp() we are normally bailing out when trying to set an OPP that is
the current one. This make perfect sense, but becomes a problem when
_set_required_opps() calls it recursively.

More precisely, when a required OPP is being shared by multiple PM domains,
we end up skipping to request the corresponding performance-state for all
of the PM domains, but the first one. Let's fix the problem, by calling
_set_opp_level() from _set_required_opps() instead.

Fixes: e37440e7e2c2 ("OPP: Call dev_pm_opp_set_opp() for required OPPs")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/opp/core.c | 47 +++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index cb4611fe1b5b..45eca65f27f9 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1061,6 +1061,28 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 	return 0;
 }
 
+static int _set_opp_level(struct device *dev, struct opp_table *opp_table,
+			  struct dev_pm_opp *opp)
+{
+	unsigned int level = 0;
+	int ret = 0;
+
+	if (opp) {
+		if (opp->level == OPP_LEVEL_UNSET)
+			return 0;
+
+		level = opp->level;
+	}
+
+	/* Request a new performance state through the device's PM domain. */
+	ret = dev_pm_domain_set_performance_state(dev, level);
+	if (ret)
+		dev_err(dev, "Failed to set performance state %u (%d)\n", level,
+			ret);
+
+	return ret;
+}
+
 /* This is only called for PM domain for now */
 static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 			      struct dev_pm_opp *opp, bool up)
@@ -1091,7 +1113,8 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 		if (devs[index]) {
 			required_opp = opp ? opp->required_opps[index] : NULL;
 
-			ret = dev_pm_opp_set_opp(devs[index], required_opp);
+			ret = _set_opp_level(devs[index], opp_table,
+					     required_opp);
 			if (ret)
 				return ret;
 		}
@@ -1102,28 +1125,6 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 	return 0;
 }
 
-static int _set_opp_level(struct device *dev, struct opp_table *opp_table,
-			  struct dev_pm_opp *opp)
-{
-	unsigned int level = 0;
-	int ret = 0;
-
-	if (opp) {
-		if (opp->level == OPP_LEVEL_UNSET)
-			return 0;
-
-		level = opp->level;
-	}
-
-	/* Request a new performance state through the device's PM domain. */
-	ret = dev_pm_domain_set_performance_state(dev, level);
-	if (ret)
-		dev_err(dev, "Failed to set performance state %u (%d)\n", level,
-			ret);
-
-	return ret;
-}
-
 static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
-- 
2.34.1


