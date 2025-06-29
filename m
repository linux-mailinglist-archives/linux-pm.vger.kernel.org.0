Return-Path: <linux-pm+bounces-29803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9676AECF25
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 19:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA47118963E2
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED4323817C;
	Sun, 29 Jun 2025 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NesDrHRm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4A423C4FF;
	Sun, 29 Jun 2025 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751217938; cv=none; b=JCLZF23Kmh3klf1XqjvIgjK32FfErGZF0EY8+OZwcSHpVMAbL1HaQGIaCRKbZXspJP7NsOlBHnfgtcvRQ2Bpw+fMNQALalUCAO7QIs31atW6XqdxZ6SskQySq7N4bCWxuDU6zzW6GEhe/iCwnnnl0BNiEnXa4l//IQvZai/jwQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751217938; c=relaxed/simple;
	bh=Pzuko6p5X7nNXZXr5mX6MGJAHdvlnWWK8W+rzZlOCQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aXdiuvl+e2w4uheNIaej5nS5FvAgBOjQX1VndNMVgG9mhLOk9dr9NxQBRoJENT/PZXm//tlfkhUBwJahxB1pCCCnDUF3r6jtN7K3pj+qNHknUe4caWRWtj4KBqu9cHG9K2xV2iGuXKAqNj74y90d/ArYTLzJdWztSpfR1kwUS9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NesDrHRm; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a440a72584so15895331cf.2;
        Sun, 29 Jun 2025 10:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751217936; x=1751822736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=do+WrCyUk54RUggZsmiUqY5/C6vOQx+Ug7MOVtvuvcQ=;
        b=NesDrHRmcDUkYK6C6iNqWw+FyploL2Wg4DhOg0LXsP5Q6RSNcjUUH7LF7YZ+PNkPMu
         gR4xfDHLeczyDChmVQlwNpAWKKpB4bREQUdSRik2FOXRzutfaMHg6OJ8sPKWPZwwjXGm
         GlbBZtE1sjmwbVRnERLFFERqJ/bv/0daohlz/xPfo5V3Bm8JsyYZMDfA3z7zrkMPJEPb
         U56PLQp/wzptcaQKsORZB+KLIOTzv6hm44GHoAsrus6djOWCS6WnKPaHjg5ecHUyrXd+
         lI9COdB2MHzE9LanlGnw7xhbhgSb90qQbXkTHQFfHc3ZZzoUwKteDjrFfj23o7rNasgu
         fWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751217936; x=1751822736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=do+WrCyUk54RUggZsmiUqY5/C6vOQx+Ug7MOVtvuvcQ=;
        b=LXfN4JVlkQ3nbmiYOQaptHrDgtd7UHyzaKmAwSk5sues1yBkCYGp2kRVucGLx9j4lb
         kgx1pRpwwQx1o09Bmx4y3e2fy2PtOSV1uqXzbqLQ4yAazq+RDJYaEDLTsxTrlD6bO3D3
         vy9J05hm9y94ShV0RC8g9hk/uKfULtAkeOx4YoW7aqeMJs8bcaKxsdzjcaKwf0O8cV1K
         k9CFsOoFNyqmiDjYP5duqtoGqNbO79f75MKOLnmE5VsxQBsU6WVRdn1ubcUkEpTk3Uep
         upNP1mrJ1SBYucJszolgqApt93K41wnA5ABF3qG2t3tPOT13NLmKmh1xSBurkpReD0pV
         bWRA==
X-Forwarded-Encrypted: i=1; AJvYcCUBvYxeUAwfHpIsEmoC5s9rLPm2qm41LpQ30Wjw7/q03sVUAEqNK6vVfu9nPcSsAGPk6PD+Kugjzf0=@vger.kernel.org, AJvYcCVFKfDbVj1VkGaRP1W7lpy1+YVsJjXmBJsIubd4fdkVErpkXp+wTuuqF0w0VAWOJjQq3ZPj5yQ+/ALqdNf90TdhTQ==@vger.kernel.org, AJvYcCWz6T1EooGGbN/7cOsd/YB/CD0TYhGWoeF++JlRYYfjG+xYUVW2D01rIT0qgojOgVXBNDh66ohiBAl2wgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtcjioPXXuNcg5/1RVXnEYYkm7A2bz48k2JzrESHGKNsbHS+9
	nw+ROlGneF/dYAVhvCYjYwmRr+ZJq/7PWIq4dFqWelqvpoRpbydXKoga
X-Gm-Gg: ASbGncu+dCIExy1m0K9UaLNEnw+3y5T8zcOcOSMn9DQNdq/0CONMT2seGGffuGrgQjn
	5M+XTirgRmwiHWGFPMGZYW8avDHuUAQGdUMP8KDyNGTmnlkR/Nvx/NDGNG+fhxQ49+8UDoZBTnl
	1CoJe98EuazSF/IrxUnb0GXO97s17evik8mEY0UlpK1r8Om7duOEMmciKqQYxPvwKLxEzRVs/x0
	cGLYcHRKk+cqqDQeoM0tJrzOrFqvKr6Zgs4VHbdzKd3umWlYi5SpAIVshy9KnG/rc74PIRNFSru
	t0RNVrIpo1+MteizQVM+c8vK5bQqIFeocDr/Yaj4/2YdYAumVnf1slJtoLnfQes3tzdiHgckTJ+
	RLL8=
X-Google-Smtp-Source: AGHT+IEtbacLnJPOYdFPR4Qbf+3fCv4tbuGcOhmfcatWVey4R8ndXu0J2Fw9Zxydr+PjYKNsz5WN+A==
X-Received: by 2002:ac8:7c4c:0:b0:4a5:98ad:5640 with SMTP id d75a77b69052e-4a7fca4e44cmr189456211cf.23.1751217935798;
        Sun, 29 Jun 2025 10:25:35 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a7c3:c88d:6da3:af6d:a237:3289])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc57d7dcsm45549761cf.60.2025.06.29.10.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 10:25:35 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@oss.nxp.com>,
	daniel.baluta@nxp.com,
	iuliana.prodan@oss.nxp.com,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v7 1/3] pmdomain: core: introduce dev_pm_genpd_is_on()
Date: Sun, 29 Jun 2025 14:25:10 -0300
Message-Id: <20250629172512.14857-2-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250629172512.14857-1-hiagofranco@gmail.com>
References: <20250629172512.14857-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

This helper function returns the current power status of a given generic
power domain.

As example, remoteproc/imx_rproc.c can now use this function to check
the power status of the remote core to properly set "attached" or
"offline" modes.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
v6 -> v7:
- Added Peng reviewed-by.
v5 -> v6:
- Added Bjorn reviewed-by.
v4 -> v5:
- s/dev_pm_genpd_is_on/dev_pm_genpd_is_on()/ in function description.
- Updated function description to be explicit the function reflects the
  current power status and that this might change after the function
  returns, especially if the genpd is shared.

v3 -> v4:
- New patch.
---
 drivers/pmdomain/core.c   | 33 +++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h |  6 ++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index ff5c7f2b69ce..2f387e15cb75 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -758,6 +758,39 @@ int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_rpm_always_on);
 
+/**
+ * dev_pm_genpd_is_on() - Get device's current power domain status
+ *
+ * @dev: Device to get the current power status
+ *
+ * This function checks whether the generic power domain associated with the
+ * given device is on or not by verifying if genpd_status_on equals
+ * GENPD_STATE_ON.
+ *
+ * Note: this function returns the power status of the genpd at the time of the
+ * call. The power status may change after due to activity from other devices
+ * sharing the same genpd. Therefore, this information should not be relied for
+ * long-term decisions about the device power state.
+ *
+ * Return: 'true' if the device's power domain is on, 'false' otherwise.
+ */
+bool dev_pm_genpd_is_on(struct device *dev)
+{
+	struct generic_pm_domain *genpd;
+	bool is_on;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
+		return false;
+
+	genpd_lock(genpd);
+	is_on = genpd_status_on(genpd);
+	genpd_unlock(genpd);
+
+	return is_on;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_is_on);
+
 /**
  * pm_genpd_inc_rejected() - Adjust the rejected/usage counts for an idle-state.
  *
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 0b18160901a2..c12580b6579b 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -301,6 +301,7 @@ void dev_pm_genpd_synced_poweroff(struct device *dev);
 int dev_pm_genpd_set_hwmode(struct device *dev, bool enable);
 bool dev_pm_genpd_get_hwmode(struct device *dev);
 int dev_pm_genpd_rpm_always_on(struct device *dev, bool on);
+bool dev_pm_genpd_is_on(struct device *dev);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -393,6 +394,11 @@ static inline int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
 	return -EOPNOTSUPP;
 }
 
+static inline bool dev_pm_genpd_is_on(struct device *dev)
+{
+	return false;
+}
+
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
-- 
2.39.5


