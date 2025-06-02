Return-Path: <linux-pm+bounces-27964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21805ACAECF
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 15:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D1A3BD71A
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 13:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A8C221299;
	Mon,  2 Jun 2025 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCu1chwT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A585A220F51;
	Mon,  2 Jun 2025 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870395; cv=none; b=HpsX655ieljb5qsgH/0B7JhD05Y+5misbOcb4a54zrGetW7j8EH1ErqZG0yBUwnfRVAfC/yjz+ONie+xjUexXZsDUhgs+stB9n9TszZPR/fwiRcKKSth0SKYc8XZ0JAPbQjddNJ1HhzdiNfvz3+OWr1WLqHbg4yH7J+Pwjbkklw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870395; c=relaxed/simple;
	bh=GPsdVxlMIyFLjpYoGg3d0W6mL1zKPBYJinSVZjWHCvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k8+xeIOuvl3JiiN8OGfMJx+SvT8JRzCWO5AFBIJaKBVmCwDeWFTOuDm5vzcNYGxWHLAqqVMgMFOzVhIZGx2Nf0CMU9edlTCNak+KF0zfNTXTvi797VxaO3dw+tDS+ejRSS5JnYUSXJbZVSWxFTz8hn4W1RPbHd02VFPOtEkybC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCu1chwT; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so4112351a12.0;
        Mon, 02 Jun 2025 06:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748870392; x=1749475192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJ6sDs0ap5mby7PucN1jBOGKcXROdaugyvIe6KS1zRU=;
        b=JCu1chwTyxSek5uj9UFZMguD/pMKWhY//MvU0ksnKSJq1ajXJ0jIBDxRzup/HfX2qG
         aGFspvM+8EGcfPUZrznYfiwdH+bvPl1r6JrH6USSQyjboaFo3rFEYsMT5Cd31bHAz3Dp
         BTHKNtT73qt1TePQfFnuFVz2n2Y4nkdpihoiZOA2rHmvtGOlmAY8sW9ic2/WZ8LHC0uy
         F2uX6IE4nq5pjl5cP+/PQBPgVlXfacmTZIyNEHcpJ+VL+9pM/uYFUrsXQioSylajq1h2
         HqrOCl3DSft2XA8Sj9f0fZDMhTvqEps21kTa7soQOweZX4nL6oG1LMERPennohnC4G6p
         xn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748870392; x=1749475192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJ6sDs0ap5mby7PucN1jBOGKcXROdaugyvIe6KS1zRU=;
        b=GGF6Y38FQPTeO+NgPQyqpEH9S2H6iempQKzcFI6aMTbPpREi5OwgvOQP2DAGpLdGby
         nC0Xo2aa/6gxH/9/SxRIYgjhUwX4i81b2hxAsePaPe19+jO8mfnShLPWd4Zoh+9/meWD
         zU+J0i4KRTf7MMLiBVKpemUSywlBxbz1/pKyaK9dyqM/aDEmLLL5ErQOi8seok+ugR6t
         1WuCoXx4VvK28e0qhYDeXRT1Tw+ZUhA0Ocb1WRc5p9Dh1OiJQZ1amN0hh7jdpNvQZZ3y
         N6e8rmMIbEtPRStI2kCYe+3OhuCI/BqX7WGda1lhhve7DQ+j69EbcuuEgSzmyaBGdIy2
         xz+w==
X-Forwarded-Encrypted: i=1; AJvYcCVgug5PbBL+ZllldM/gAtT8HalGqO21W2z58ZpxQsvAqZHSYuyQqGkIRm7xyTGXRouCzWCtJC1qtzeTz6Vs07yHdQ==@vger.kernel.org, AJvYcCWiDNoqKMi/867nIx+MbYo11oTL5R1k+clgcDmNYwCMBJjpCPC7AHhRT/Aq44pJQXrczyp4nMAKM25axC0=@vger.kernel.org, AJvYcCXiezb6M/tw9JSKJZUlY2TMhEmcWo0AOCewsQ/xumVPxVoldjfW2KNfwOW0b6ifiL/fwL4OKkt7JAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmJwmGiX4Y9RIBioBGWgc88mT90gg6NVRmkwWMYbyGzXnhvwoG
	HMm5aMPEHl6F+tHu1G4veo7j2weEW+KlAzNYyndICcxgIuPQhEztq6uU
X-Gm-Gg: ASbGncuITOPc9Ru8Z4O8ObQHA631Ke9AhDsr76TPOuOLGP9wliqnPRW2SLAjLfMgV9k
	TkJn3FuzW+Hmizlr1n70OvA6ObAeGejNsaxTdqVGw3xsh9OAg2+0J8lAgUelesH8z4Qsjo47JG7
	h10ZBVSI1XO5greSO1EZ4Bio+6jqEezf7uybmBFXtTBQvjA5ZuQmxDGI7uG3RxZzWiZNk4DvXxr
	Ry+fzNdw/FB17MToygQr/LhVg6Ga7htNhSwgsPhRcpj6/YCI7STO2ua54DR/rFd3+oUy8E98zcZ
	THBJcYxYk1d/d5ODQgc60XLn2Ib+u8s0Er7vN/e7zMrZ2Mn3NZzbZ3UnhtvYe4Suv4PpkBewnq/
	N+lOzx+v0
X-Google-Smtp-Source: AGHT+IErgHS5snsVnZ//qcUNKvfllIsynXPhb7js8d1BuZtiwj0gMVWZpcbDBi6UEa1UGSsp0FKEfg==
X-Received: by 2002:a17:90b:268f:b0:311:a314:c2d9 with SMTP id 98e67ed59e1d1-31250357f1bmr19303166a91.9.1748870391611;
        Mon, 02 Jun 2025 06:19:51 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2b67bcsm6130983a91.8.2025.06.02.06.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 06:19:50 -0700 (PDT)
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
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH v4 1/3] pmdomain: core: introduce dev_pm_genpd_is_on
Date: Mon,  2 Jun 2025 10:19:03 -0300
Message-Id: <20250602131906.25751-2-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250602131906.25751-1-hiagofranco@gmail.com>
References: <20250602131906.25751-1-hiagofranco@gmail.com>
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
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
v4: New patch.
---
 drivers/pmdomain/core.c   | 27 +++++++++++++++++++++++++++
 include/linux/pm_domain.h |  6 ++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index ff5c7f2b69ce..bcb74d10960c 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -758,6 +758,33 @@ int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_rpm_always_on);
 
+/**
+ * dev_pm_genpd_is_on - Get device's power status
+ *
+ * @dev: Device to get the current power status
+ *
+ * This function checks whether the generic power domain is on or not by
+ * verifying if genpd_status_on equals GENPD_STATE_ON.
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


