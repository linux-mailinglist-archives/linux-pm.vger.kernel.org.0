Return-Path: <linux-pm+bounces-29623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3EEAEA929
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 23:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30D416BD40
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 21:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C19226157E;
	Thu, 26 Jun 2025 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWC8rccl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A055E2609C7;
	Thu, 26 Jun 2025 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750975180; cv=none; b=WKHCwckUo27TWJYxGxkQwaypM+2sf9dW0K4HDinYOv25+6loTDAU0yROBI+JUokt5fVjsL7DUmjQd0CgMRPUGV4GKovFkWY3eQJ3Wq+uChW4hv8bfpUj2jc6SQOE2+oWuKCtLYU50N3lxuyhgmaCbCA2J3hqtl0P7OuYBoBprQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750975180; c=relaxed/simple;
	bh=UufGGLlkb3UuTQ0EXDh1Zt5ACyC08b6N5Er0XaAmRE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oEEFdA+nrpueiDTR1DY2HSOey2qUdfn6NKzZETSKUCugmAqUsxm/OI8A9wnFcqD4S9HTw+6WwwWEfBtzacmMAnN8bJ2P44aJ+OZSZ74pdALKHcDW2/GWk2y7dB+/fjX26JCoQFdYnh8w5xAZl1czDbn/X2gfhHPKfi6SD1RmZbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWC8rccl; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b3182c6d03bso1810509a12.0;
        Thu, 26 Jun 2025 14:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750975177; x=1751579977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqUm180eQDox8Xlw05sxg5F58P/BrEE00f+0gmB6rO8=;
        b=NWC8rcclmk1NhEISpJL/1RUPd5RMQ2vTR4m89Oq4ubnTQ9+ofXbDSCD+3vUuoqfR6W
         sniw2W5kab3Z8IrantmaRcPszxV77obIP8ZInzfiUaf2ihPPF2l9nOy9c8jeh9W/yF2n
         zIdoWm+SmXrIwx3AFueayyAdYNhlmWFASLOprxwjGLfHIrIWJ4m6HWI+MiSL3Jj24i2K
         jtQRlGJJcBqS7oyUCBylQC/Q6HCezY5s2aQxo1smipUyEc0phpTNlUxMJgakitHQPDPX
         rokmVoN3x0aHS7OjJKGUCWW4+6w8x+KrLC77uZMXOY2YohTREpbRf/8dN0JU62ufZH6A
         0kcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750975177; x=1751579977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqUm180eQDox8Xlw05sxg5F58P/BrEE00f+0gmB6rO8=;
        b=ux81bZowlPaK+pKcQGh8FZcWPU3nPvLELZ9qUBVvPTVTEY2neWVfEUgbiChbUYeXWY
         YkFkPOwJL9SppiwuPN8j7G5hJHKTY8HHlSJjHSa59pePYw3kg+/kaJpv6dV+f4N2c6z6
         ENHNGBdlVGDgwKJ+lS0D1ac3Q9Sy74Ri9hagqsgUOFPdBcXFlPgn0BbGQH67dOe/uBZ/
         XF0Pux6umbjGFaK79z/9PUqjK58oiLc6ikj7j0BnrE9pddm4TzPooOxb01KSr68cWPKA
         4VZM2p9OGV5GetJ1HefZREO9ELM1ev9Bo1w3Lbv8ehlapmj2/AqQDfFkBN7/lc+G4EBn
         25Pg==
X-Forwarded-Encrypted: i=1; AJvYcCU5l5edGwcalb7CzpI+Ehh3HTUq1coMXoARxZ6EkoUjVbwvRV4HY/njARUxns/gykPflc8uUkta1KALqnQ=@vger.kernel.org, AJvYcCXR5SZ7woGtXQkz8OAMpU3BDlRRpMl1Tqm/nPeo+IMTIDw/EHvzhxpvRUS1MvvTOV5Dr+6aqpjfHG0=@vger.kernel.org, AJvYcCXjlSWUpbYnkpEyreCEEBD2tfclzTCB/SitPP8NzkqFE4ZHbFi4bm0E681bhk4p8knc2flulITYwdjC9KBSr/8TCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMObRshoJiNOlHBb7aypMAAJQoh+zLas5HbQQQTuyhRo0DZmEA
	R/RCSiuSa44kPULapEMudnvCE1hnxBnLwPn3MsKCM370bN7UaVW/jrxb
X-Gm-Gg: ASbGncspy/PLsZfeyIgpLlze6u4ovkKRxwzHI/18KdSQgnbr3DPx4cnmDU9oJwDtxjQ
	OHhn8AV6YAgJpzfJGksxYqwrGchC6DayVNtE2Elfxd+wsRrTKLOc91P0pJucTGpl36Gk6VNxZuI
	IjnOvx4YK8v2qNsOSRTrmtTuFkgJ0wBS2rY1d91GO/Z+8BN1ABh4T9VkGXlB3EJv4dRnYRUiuT8
	CB1gsArLxOfN21/qJazAzJR2MPcSdpt0jWbFJFYw5+aNpBrcLzCZiMzYf4CyzKog5XT/AencRoa
	ldR7Xa1ecGJE9W7dAUTTVzUskEBUZjOCgUb8aLPeUornL6FOJu/VphXLpu6YmdZfEDfZczkzFCn
	xnaI=
X-Google-Smtp-Source: AGHT+IEj6BGM+Mz3MmkFvPoHUKb7LLDLDubf4oTZNcLqHe+6ea1uskvJ137D58tQnmG8MNIGyCBZFg==
X-Received: by 2002:a17:90b:1643:b0:311:abba:53d2 with SMTP id 98e67ed59e1d1-318c92ec11amr909084a91.17.1750975176799;
        Thu, 26 Jun 2025 14:59:36 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a7c3:c88d:6da3:af6d:a237:3289])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39b8b9sm585275ad.118.2025.06.26.14.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 14:59:36 -0700 (PDT)
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
Subject: [PATCH v6 1/3] pmdomain: core: introduce dev_pm_genpd_is_on()
Date: Thu, 26 Jun 2025 18:59:09 -0300
Message-Id: <20250626215911.5992-2-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250626215911.5992-1-hiagofranco@gmail.com>
References: <20250626215911.5992-1-hiagofranco@gmail.com>
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
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
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


