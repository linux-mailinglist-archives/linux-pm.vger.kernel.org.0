Return-Path: <linux-pm+bounces-2430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24402835D1F
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 09:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E64AB25718
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 08:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD2E38FB7;
	Mon, 22 Jan 2024 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIRNbueL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618239AF2
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913246; cv=none; b=EojtGY8a2EDzJwu9sG4uqvaRLpXdTtjTWvLENJmutEb+MxVRKL447zaYWEY6NKv4ThqjYPJIVpunZtVBRK4ABCjJskHVa4AyMNic4zgo+bR4OYU2zxWdxHPPR3LFtQZsHVzuQfcyXCohVPYnxZm36akGWPbxskzqsL8QbrBCl9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913246; c=relaxed/simple;
	bh=7tUdhB5Hjq9r5i/bI7pjQefXP4gx7LfsrRrId2oYhB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QIkNc/phik8U7w+I1FlNoq+SH07A77uT8FjPlFQiGnxQ3owRGroiXbsIQbXoAim3MFYrDTQipNZ7SnFgB5o6/nc/Q6Oi5ZJ9N5wbWSBDTLtk5pj8F63p9ea1addCfpEH1RBg1mFBvn8A7ceKROqykr2O6xQb11gjDMcYZ76sEUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UIRNbueL; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a30359b97a8so84189366b.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 00:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705913242; x=1706518042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGozEijrd2enh9tKEhmSTYLHZEfP085NRkmYnjnJTF4=;
        b=UIRNbueL1doiIfMd2q2A+2Lu2m4care/KTAklDtQZtKyYIey7A8Q1Mh6bMcwLcyttV
         F4rdqEki/C5jqMpdOGWx0zQ77UnsPzOYrf7Mj04l6UIst2hX6o9+RFR6KUTuaG3RB5PY
         WY3U8IA7UKyCGOzouMbE5zPw7LIptermJOJGQJxY6IxiUsp0+2YtB4f3NqvqQ+JrP1Iy
         2r7Afyq9OUb6t9bAs9O/nCzU/F6tcoKEUjHTV507/4MuE5tm+t6uwoBIXs/cgs1SuOd4
         YW3h/Rx6A/CzbkeHmHulc0SZVlBTQ+MgD2u4sgUvdtBiEu5N/5ojl/v2x/QH6P2G0i9p
         5kLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705913242; x=1706518042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGozEijrd2enh9tKEhmSTYLHZEfP085NRkmYnjnJTF4=;
        b=bTTqwfLSjMYxbXDyFJpBaTFTk8lBIfD84yA71R1ADvw8+U7vahTaZ7RcE8i1JtvF0T
         63K744GDttQnIl1BLQWy7Qrvs9GkWByoPSZAFd2+nnFiJzZJSJXsfRaKsSyyBSK3Ld+K
         sXm0lD2GHjF+Dqf/AdblQInhX/bnzb5lCeZsw3taTTjY49P/jzvFeBYTpnDY7ETNpP+l
         4iXMUtzRZgJ3dP3scTHfNJWEpCK0G0lk631J9NgLH60BPkak63LLPy/o5Vn1Bp6wxPPk
         ssEmS0owwbWxlKt33axYj2kHDQGD+tZM0PvVTzK/uLp/4m8dI8LZ2OV5viVbADm5lbkL
         wm+g==
X-Gm-Message-State: AOJu0YxL/2b+K1n5EC19yMiyTuqW4CD1IqiYPGJJew90av3sSrmkc6KV
	M39byFhu6YKtjc3GAXvnNPfs4bYPKB93q9rcnXzkxFgzGhWKqzqbsuZ0DEWRTlk=
X-Google-Smtp-Source: AGHT+IFVDm8CN995I0lrqyfm+4wxfcm+CrrDfUW7HOJYqkqQ993/J3bNWzJtsiDseke/grFBtkXYkA==
X-Received: by 2002:a17:907:c249:b0:a30:6016:89da with SMTP id tj9-20020a170907c24900b00a30601689damr409761ejc.45.1705913242247;
        Mon, 22 Jan 2024 00:47:22 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090630d500b00a2c4c23cd12sm13075462ejb.217.2024.01.22.00.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 00:47:21 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 22 Jan 2024 10:47:01 +0200
Subject: [PATCH v4 1/5] PM: domains: Allow devices attached to genpd to be
 managed by HW
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-gdsc-hwctrl-v4-1-9061e8a7aa07@linaro.org>
References: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org>
In-Reply-To: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-media@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5610; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=awkvV2DdUJnYuJXVb0EJKbDlz6Jjymy9CH2d16MF0H4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlriuPJ/oKq/9J/hlzle55QekASipW8hs2YpQ+H
 imOfR4YMd+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZa4rjwAKCRAbX0TJAJUV
 Vs9NEACe5dQjlAid71quApVBhRd9B4iOugaAxcj9GPY+LeWqTDt0KDK/qbbLV0GaNNzWYxv1u3/
 bOaSpBp9aHgEAjaPqfi1tSwY2VHXPrXmNqqgPDBxDR9N0Loze53ninXGRNY1JEvwjPoxjlu9JQS
 05HO1F76KHGcHQwqEtxzG74/v0CPhA1Lvt2N1/l/rNZ5N21RWXt0MyPQW7hfxQyTTc8HDLOtZ0r
 tCrqvFLxzkqe8P/OQNptL9GpZUf+qEkZPmiO2a4lFd8FNdt4aEz15+7YgOWCXqMWuNaI4o6I5d3
 lQDd9ujLjB9W1HioRxjEZNy2WABZFh6ElSeqi9B7ZRSi0PSGjYctQt+givczmEMTMR3czU1m3wG
 Sp8csl0XRrmeY6gUsHRlMw9H3SEeYJtihCtpZjSdNEA6R1Tw7vPusZooGYf98UqYJHQbSMgk2Of
 nyvdYY9BXNCOqjz9WcetU0thWuqD7LhUlPI81BxKrydih6qzeqrvGV9CVgnR8fUXydeGUALqzxs
 L3ymluVGtrjX+ve1nidD4ogvsB6xM2V+Se0mpFoTEX3X7fLe06CTmDIKC+B8Ru4ioO9GCPSRJMc
 jP/hgqI0RmidUOiKeIKjl9ymLlzOuw5wELoL+fiuen3ihLJQFwJ39L/BdhlK+K/dflCANH2t/YY
 G8ObFj6XBuOxUPQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

From: Ulf Hansson <ulf.hansson@linaro.org>

Some power-domains may be capable of relying on the HW to control the power
for a device that's hooked up to it. Typically, for these kinds of
configurations the consumer driver should be able to change the behavior of
power domain at runtime, control the power domain in SW mode for certain
configurations and handover the control to HW mode for other usecases.

To allow a consumer driver to change the behaviour of the PM domain for its
device, let's provide a new function, dev_pm_genpd_set_hwmode(). Moreover,
let's add a corresponding optional genpd callback, ->set_hwmode_dev(),
which the genpd provider should implement if it can support switching
between HW controlled mode and SW controlled mode. Similarly, add the
dev_pm_genpd_get_hwmode() to allow consumers to read the current mode and
its corresponding optional genpd callback, ->get_hwmode_dev(), which the
genpd provider can also implement for reading back the mode from the
hardware.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pmdomain/core.c   | 69 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h | 17 ++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index a1f6cba3ae6c..41b6411d0ef5 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -548,6 +548,75 @@ void dev_pm_genpd_synced_poweroff(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_synced_poweroff);
 
+/**
+ * dev_pm_genpd_set_hwmode - Set the HW mode for the device and its PM domain.
+ *
+ * @dev: Device for which the HW-mode should be changed.
+ * @enable: Value to set or unset the HW-mode.
+ *
+ * Some PM domains can rely on HW signals to control the power for a device. To
+ * allow a consumer driver to switch the behaviour for its device in runtime,
+ * which may be beneficial from a latency or energy point of view, this function
+ * may be called.
+ *
+ * It is assumed that the users guarantee that the genpd wouldn't be detached
+ * while this routine is getting called.
+ *
+ * Returns 0 on success and negative error values on failures.
+ */
+int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
+{
+	struct generic_pm_domain *genpd;
+	int ret = 0;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
+		return -ENODEV;
+
+	if (!genpd->set_hwmode_dev)
+		return -EOPNOTSUPP;
+
+	genpd_lock(genpd);
+
+	if (dev_gpd_data(dev)->hw_mode == enable)
+		goto out;
+
+	ret = genpd->set_hwmode_dev(genpd, dev, enable);
+	if (!ret)
+		dev_gpd_data(dev)->hw_mode = enable;
+
+out:
+	genpd_unlock(genpd);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_set_hwmode);
+
+/**
+ * dev_pm_genpd_get_hwmode - Get the HW mode setting for the device.
+ *
+ * @dev: Device for which the current HW-mode setting should be fetched.
+ *
+ * This helper function allows consumer drivers to fetch the current HW mode
+ * setting of its the device.
+ *
+ * It is assumed that the users guarantee that the genpd wouldn't be detached
+ * while this routine is getting called.
+ */
+bool dev_pm_genpd_get_hwmode(struct device *dev)
+{
+	struct generic_pm_domain *genpd;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
+		return false;
+
+	if (genpd->get_hwmode_dev)
+		return genpd->get_hwmode_dev(genpd, dev);
+
+	return dev_gpd_data(dev)->hw_mode;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_get_hwmode);
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b97c5e9820f9..5a26423a7ee1 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -148,6 +148,10 @@ struct generic_pm_domain {
 	int (*set_performance_state)(struct generic_pm_domain *genpd,
 				     unsigned int state);
 	struct gpd_dev_ops dev_ops;
+	int (*set_hwmode_dev)(struct generic_pm_domain *domain,
+			      struct device *dev, bool enable);
+	bool (*get_hwmode_dev)(struct generic_pm_domain *domain,
+			      struct device *dev);
 	int (*attach_dev)(struct generic_pm_domain *domain,
 			  struct device *dev);
 	void (*detach_dev)(struct generic_pm_domain *domain,
@@ -210,6 +214,7 @@ struct generic_pm_domain_data {
 	unsigned int performance_state;
 	unsigned int default_pstate;
 	unsigned int rpm_pstate;
+	bool hw_mode;
 	void *data;
 };
 
@@ -239,6 +244,8 @@ int dev_pm_genpd_remove_notifier(struct device *dev);
 void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next);
 ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev);
 void dev_pm_genpd_synced_poweroff(struct device *dev);
+int dev_pm_genpd_set_hwmode(struct device *dev, bool enable);
+bool dev_pm_genpd_get_hwmode(struct device *dev);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -307,6 +314,16 @@ static inline ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev)
 static inline void dev_pm_genpd_synced_poweroff(struct device *dev)
 { }
 
+static inline int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool dev_pm_genpd_get_hwmode(struct device *dev)
+{
+	return false;
+}
+
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif

-- 
2.34.1


