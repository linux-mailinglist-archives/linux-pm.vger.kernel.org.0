Return-Path: <linux-pm+bounces-24012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 820E8A60E15
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 11:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 252677ABEAF
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 10:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6081F3BAD;
	Fri, 14 Mar 2025 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/IaguaO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393291F1523
	for <linux-pm@vger.kernel.org>; Fri, 14 Mar 2025 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946483; cv=none; b=nqQLL1wS0itQWMaJHUrGvTEOYd6AaYutTv4WCa4eNYczdJxZ7oLwmfohCYCosp/cPbXblsLabxo6+dk6Vnpkq7gokM531qIJJqscvGo4z0kOkrKsc8yg6IBYnD5f/jg3lFPAEwY2KU2jrTPmyeoObA/FylXOTYwdOTxrqLiBPRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946483; c=relaxed/simple;
	bh=omP1dmdXBpgOE00x/2D72922lfplNPRUo8oQ0BL4bBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndhdhQkto0vc7WNtajuN9K+zHjo4akQgYVu8/pV6UhX/FkODPBo1VG0pxSZG9G4TU00GVY4VlAbS5N29vBQzcyFMMuhp2Exnfjys69PyuCSJ8kctQL0HyeSm+TrRd9mqf15sHKVJNQAwIDWEc+ZenYER+tDFVhGH7xCe+1Tw33M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u/IaguaO; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5497e7bf2e0so2298992e87.3
        for <linux-pm@vger.kernel.org>; Fri, 14 Mar 2025 03:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741946479; x=1742551279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxXrWuszmkPt9+jWh/jp7RjsQBBCWLjTzHixGfM6EZE=;
        b=u/IaguaOj5mqb7vZXxN0jrCnfvSI+A7xShqeT0Guz96NQdZkt+CtRs55Xe496T0IZh
         jF8qQfH59hEXdI2GRTGll5m1R5DRaSh2dLQxpNJTW/FBqTrvHWAtBCNS7Fprr1b8K4Ln
         PghjbZ4BWwHzxZPaJDPlW1hLcnNbvlPlBYNGQLQGQHdRFBJWHOLhXQaEemrOTFpL7cek
         HTJd93Wz9u2UY0bYpScrM8jEq7gzqi3cKjN2tsFcj2bwvU8MTe5Hdrsw5li8cV3obKZx
         FIDiVAUFpoMgiRv02ybOLXMo2NQi1o62JwR95EjFOhobGlpDVXU019pSq6OfQ8jMtI7d
         HPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946479; x=1742551279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxXrWuszmkPt9+jWh/jp7RjsQBBCWLjTzHixGfM6EZE=;
        b=p0r06g7UdHmahR96AslBjFmA1bWj6KIdkJ6lnJAR3YHyYUGJJ1w8DhbgEjdTQEFhC+
         tTP2IOJebvoXTRoGuBB0PvqDW/8uOQHyPgOFmfYdWpkXes294PGtGRxLUurBMS/UxG+J
         q87x1FKbN0ftgYBG22D43xl68n5ZfTPIcPD1qOMEd5LKsARC6IAwYc/AoeZ4cJaeMwCx
         qkCbGMnVmKUjhACxt6kYR1ACfWN25zWLErzvyfrHyYVYjMFggBpBd8+COvvbuf5UafWa
         TKqJB4JzBd0Kw4ic784PtvCZUmuJxQ7npHdffwxOBIUn2tOAGIniYg5HLnuzVoMRG6Ud
         hR7w==
X-Forwarded-Encrypted: i=1; AJvYcCWm+olnK/4sfkGkNz9nGpIj5p7apt3FlrmxUgBJeFdyR88zTZvHHEXcDz04JhlZJPcHFei9JMCWCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVsVJ7IL9dFL+q00jxvcSPyYl2rIzUwhQPeEXZFXvYREvesAHd
	2GSP5iZm/3fb8Nd6U/0S+ifSEpwYghuzcsjZgdJ0ppZ9OSOexBHM4VDB8YD44zc=
X-Gm-Gg: ASbGncsyS8cvCL2uszjmJUVBAiTSD68ijA1Ia9iv4SgVL27B2T7j9OXMMt5uhxnw07G
	kl05v5fQ/PytF7c+oqUeGTxhVJwJfnzvc0gukNFtyO6lJnqPB79h4pKWn+IuyuL/+TJ49QZwvcD
	K5x8/Ervcbse7Kv1y/9bt92CuyELZPB9jqkOtvxjBU3dnZ/sZJOwYwByC7Qx/tsKPjwBySyBQxg
	2IPHBk9uxGmSDqg8x47bmnQWQSBfwvR2aBj8YcrkodMGJlGdXjFycrX9Te1saiRVduIuZERCBXa
	LUuX6+r41HVsGaPH1snwqJI46tZr+phx/G4yzdMKVUJ0GNYi46dH1FgW6vdp7VDXZr6TvxvKWYz
	0Y+WcP0/htitUFEXxCghdabSpeOnFMg==
X-Google-Smtp-Source: AGHT+IGI4U+6gFVGvMxY7c2ZChVVcSTAYz3qWc9D46+/1FYmNXR+U/zCzRxHxW++97VulyB6QhEBRA==
X-Received: by 2002:a05:6512:238d:b0:549:8d8d:2c62 with SMTP id 2adb3069b0e04-549c396e3d9mr653362e87.36.1741946479167;
        Fri, 14 Mar 2025 03:01:19 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0ea468sm5168221fa.41.2025.03.14.03.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:01:18 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] pmdomain: core: Add genpd helper to correct the usage/rejected counters
Date: Fri, 14 Mar 2025 11:00:55 +0100
Message-ID: <20250314100103.1294715-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314100103.1294715-1-ulf.hansson@linaro.org>
References: <20250314100103.1294715-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the cpuidle-psci-domain case the ->power_off() callback is usually
returning zero to indicate success. This is because the actual call to the
PSCI FW to enter the selected domain-idlestate, needs to be done after the
->power_off() callback has returned.

When the call to the PSCI FW fails, this leads to receiving an incorrect
tracking of the usage/rejected counts for the selected domain-idlestate.
In other words, the presented debug-statistics for genpd may look better
than what the actually are.

To allow a better correctness of the data, let's add a new genpd helper
function, which enables the caller adjust the usage/rejected counters for a
domain-idlestate, in cases of errors during power-off.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c   | 25 +++++++++++++++++++++++++
 include/linux/pm_domain.h |  6 ++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 9b2f28b34bb5..c79ef6e3ab85 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -728,6 +728,31 @@ int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_rpm_always_on);
 
+/**
+ * pm_genpd_inc_rejected() - Adjust the rejected/usage counts for an idle-state.
+ *
+ * @genpd: The PM domain the idle-state belongs to.
+ * @state_idx: The index of the idle-state that failed.
+ *
+ * In some special cases the ->power_off() callback is asynchronously powering
+ * off the PM domain, leading to that it may return zero to indicate success,
+ * even though the actual power-off could fail. To account for this correctly in
+ * the rejected/usage counts for the idle-state statistics, users can call this
+ * function to adjust the values.
+ *
+ * It is assumed that the users guarantee that the genpd doesn't get removed
+ * while this routine is getting called.
+ */
+void pm_genpd_inc_rejected(struct generic_pm_domain *genpd,
+			   unsigned int state_idx)
+{
+	genpd_lock(genpd);
+	genpd->states[genpd->state_idx].rejected++;
+	genpd->states[genpd->state_idx].usage--;
+	genpd_unlock(genpd);
+}
+EXPORT_SYMBOL_GPL(pm_genpd_inc_rejected);
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index d56a78af4af1..6e808aeecbcb 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -285,6 +285,8 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 int pm_genpd_init(struct generic_pm_domain *genpd,
 		  struct dev_power_governor *gov, bool is_off);
 int pm_genpd_remove(struct generic_pm_domain *genpd);
+void pm_genpd_inc_rejected(struct generic_pm_domain *genpd,
+			   unsigned int state_idx);
 struct device *dev_to_genpd_dev(struct device *dev);
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
@@ -336,6 +338,10 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
 	return -EOPNOTSUPP;
 }
 
+static inline void pm_genpd_inc_rejected(struct generic_pm_domain *genpd,
+					 unsigned int state_idx)
+{ }
+
 static inline struct device *dev_to_genpd_dev(struct device *dev)
 {
 	return ERR_PTR(-EOPNOTSUPP);
-- 
2.43.0


