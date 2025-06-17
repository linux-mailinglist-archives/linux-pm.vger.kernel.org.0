Return-Path: <linux-pm+bounces-28920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6E0ADDC75
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 21:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0BCA4A1915
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 19:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2032E175B;
	Tue, 17 Jun 2025 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qz8sWiB+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B186628D8C2;
	Tue, 17 Jun 2025 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188966; cv=none; b=JE7OS/pPsIS0esqJ1cuH1tlY1/P2BIX5AEIM1CIoyCJCutpuFvSAjMlOjkMHRstQmY8PKYBUMTTJYsZJsDpMvZ/ZfSuOsYaJBn9q0/qoth3u2TFyCd21VPcO7vLf1e1OY0lR2VINmVeSjA7+gBnuBksgqtVNfEeWzeYD2U4GsPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188966; c=relaxed/simple;
	bh=OYtfVADC3YbaOkP37R0UIhy3l79PKRTWkTBXrHQnV+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=isYX5qoHDNE/adsrmPLjWXEU17cSm59nUh+Oavab5xXkEnmpK93/TQ4altEd57Zr51V1FAOrTW0eYZlftGrlHDKgfL5VAKfzM4/XpTgjmRC9In8uo4A202Q3G+Yl/IRCGZgauTMaa/CR/0FLahhSZj58yglppzJB8MTzB/07kxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qz8sWiB+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7487d2b524eso3197691b3a.0;
        Tue, 17 Jun 2025 12:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750188964; x=1750793764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+Jp9u/wRva4rrnrWzobzjZRnSw87IvFwB/n0IWH6u8=;
        b=Qz8sWiB+DD9HYnX+T22+hQ81OfQd3iCDqkhueh4j/JAmRSKQ5/Yb7T5F96I6asAFfu
         7d1+7XWLo487lMPXfSGRefKXXsKpvAInAoW1Ryjzmv1Xy1iebocHqKMfi+n13P+wheUI
         lKIeq1KlWjv8BbVDBALocA7+EjR9YU+abdk4XkNVn92dzLpJ20JjFJOWRLX2728bWzu1
         XYhXrdI3RsbMj+uxSKtQ93V5fWLvGmL9B9EJebQzJP3W1VGtvaQaWAS1LqlQ3UMy9Uuj
         VJulKE/gFd9ChOuJZ/bdswxhscyp1MXNWjLBWGlWLH5a1bNIqfMyx0eScpHt/i+pQo8R
         g9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188964; x=1750793764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+Jp9u/wRva4rrnrWzobzjZRnSw87IvFwB/n0IWH6u8=;
        b=dsum1LyMjbkdHOQD13JXBIDWqd+u1AGNBzTzHm2+vLNrYX31D347ew8X76mNEeTE7p
         cbXXgIudBQoGU3FQd97ywsEJ0s7IDuGAA05eLHr4WJQ1Uiq5ozeaM/21+gGeNzgH8Wzs
         vAAUfBoUReYlD6x+09GIZXHDpQitCs/bxzFfPJg5YYfjal7zSxERFkyQb0LqRfsNnZn7
         5b9LU31eVLlW2dzzT03OVU12tLNWApiZ8MU7v1wIr+c2CMIBm5W8pcjn+XpQQm8oEQwX
         b5Sp6lcnTTv2f+Q0BijaVDQitruP6cWroHWfbttXX8i4KD4q2s0hVhZ+pkX4HWWWq6w2
         fKug==
X-Forwarded-Encrypted: i=1; AJvYcCUwbFEB4b5n5Afgb0f8gtE1XBdopbMuv/MhMWPW/x3r7kG1vYBlQh4ojCH5YsblrhOi20ASIdQMCIn+dLIPs8mlBg==@vger.kernel.org, AJvYcCVJjNi/HEkQ8ARtkpdcmR8vpXfZcaZKm2uO3dH7WTvpFvy+Zu1dI0jGKYe/S3is0ws/9+bebHmiXK8=@vger.kernel.org, AJvYcCWmS9OXaqllhJIQEENI5BP+0Qka1DTArQ1ZlBIjdemTAZaMQ5cN0HeknK8hjPpu7UPHQQ8p7U7sD9U/jRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg5ZgI38d+8gbyFi8zdayOPe1tQiygDDxlj+SvTvv+HOTWfDgv
	5AS0iqjvGO6NMqkIt8jePlh63VXijAJG7oUSxdqvJAy7OL6IP4h25c8H
X-Gm-Gg: ASbGncvOjYhb1XMEz4UmhHtdBmWNahJWxVmCERZEy9ddDqEzY2lCr4g1ZQOCMP6ce5E
	ouL7hMHbt2QIRM7YssFyiQJpz+8UcTSgv6nQGzoCdJ2y/wIiREoWmp83U3Ezbk3lgaesfGPNdCs
	6suwRYXHQ6PgAq3HGfNV1rmdacTUF6Sg3KnhkeZLTIrE7988S9+6cOvPg0XMhrnxtufz5GICxt+
	FwPLLn6I34fVo45Mzc1u42z30MN2jwf493D1oEUyxA9apc2oY6gykSOR60UEfClHAy5FgtTNM0Z
	ci1C3JUrFg5gI80QMvel+vvU8LBfuZIzzZ4E4VIshACQ456x8VMKqniFFTGE7/faPvdC9tl9aTj
	kiBEoKsHbVNZxPVWJCHo=
X-Google-Smtp-Source: AGHT+IGcDSspfVbPpwb0f/ablI94JBqFeuuwuuxpXOVNcm2A90uM3TKWTA7DXqp9K6lERbNZaC1dhg==
X-Received: by 2002:a05:6a00:2d06:b0:736:5725:59b4 with SMTP id d2e1a72fcca58-7489cf62aa3mr20044531b3a.3.1750188963855;
        Tue, 17 Jun 2025 12:36:03 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d7340sm9648582b3a.179.2025.06.17.12.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:36:03 -0700 (PDT)
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
Subject: [PATCH v5 1/3] pmdomain: core: introduce dev_pm_genpd_is_on()
Date: Tue, 17 Jun 2025 16:34:48 -0300
Message-Id: <20250617193450.183889-2-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250617193450.183889-1-hiagofranco@gmail.com>
References: <20250617193450.183889-1-hiagofranco@gmail.com>
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


