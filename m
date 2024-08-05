Return-Path: <linux-pm+bounces-11925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E42948639
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 01:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F515B21957
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 23:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E449E16EB40;
	Mon,  5 Aug 2024 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="euGWp5yA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617FE14A088
	for <linux-pm@vger.kernel.org>; Mon,  5 Aug 2024 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722901157; cv=none; b=e6/JdBTO4vo+HmthtKDyy7cXe/xr64nOoAFyZ9lHG6VnzSRlCUyinTcNOs3X17RKy+NBAOPRmtoEdjhX1CIJNz+p19YM2BsNHX+ZhoR3K8CE2E679qiAVZSPEc82Lp0cvdd3JnOc84929FyPtwkwf7VprqI9/dPYczNysCjl8QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722901157; c=relaxed/simple;
	bh=og+oz6R3XYFQe2i2DejxnXQaA9AXpva6vUP3tRWt3gM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uwDR9dpJ601+6di88dZf9jhBB5724AzYsic7b8dUVTG6dIe43Ik4ZP3L3KIdDA9oRV+DYwHefMzNwkHm3OUi3RdVsBxZBjb0sBudtp944raAkoX7G2mtLkGrKAEqkbjBlwpbac3gViIJ4KfVwz1GN4EPnsCB7Hm0E6h2vZ1CeXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=euGWp5yA; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d1d6369acso4327468b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2024 16:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722901155; x=1723505955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7ZxYmXnQ2uNgyq0sl55f3TGVTSwdU9KJbJgLapC8Mw=;
        b=euGWp5yACqcGDobyS+cyr4zvwhDUl5illf9fZTt7PF/P4+f/NaiJROFihu2o/06xOy
         vXTTejMOPkAJPvWUVIu6E8UMOQG3C0950VKVNQXyERflc0hDOOIThFfzdy2G/Z/3fipe
         w1uV3xe4+p+3sDianE5wDk9Yytvto4eY4dC1FNYj0oD4MZqF4IReZWLNqW/k+eMwS1/P
         Q3ul2aNwpH1M2oSZnusfdm8L27pFyOrov5A5DgxWTH9qzXweyeAbkOnQ0//2+4ixTw4P
         +nrMYMnzivn4CTK0mm3BISuLJT16c54Q/4qg7SlZMueLqRY4kPNlj3BL4bIqZDPVgrSh
         IDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722901155; x=1723505955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7ZxYmXnQ2uNgyq0sl55f3TGVTSwdU9KJbJgLapC8Mw=;
        b=pRme2cW6eXwmqvLl4WAgKhUnBL1rjbmWJCzvwp6DqXAEGjXGUnuNAIcX3vMMAgQsK5
         y/9P+Anglk3mCoOqRVCIb7cjWSMOsp4+cadjKJtTNkd6GRqRMx4dtN5UR6mF4ZDVQCKC
         yj25jhEKaH4Q/dnW9T6x8H3fbh22HKAroelbdvQITaEQ2LiLXVXMCgvutiYA5yldE5GS
         hAHjDxIpIAL3h9Ui4ROpBs4oDHin47RCviDVwlGJVIiuxE1V8eGpXWvgyZMWSrulLJnN
         7vuBlBscgrDKL1oGZJd0QNp7975DadHMZTnzTw9iVSqf5NN1Z0fdIUy4nnO3wyk2AQ3c
         5tIw==
X-Forwarded-Encrypted: i=1; AJvYcCV7iasNf+sqvWD3hPgYn5aBROjSgPzzNxGQco4aDuRki0cQQ7MYnCNphkq79HDaIHi59UmShx+qiTHdJ9xfC5u7KSlz00+3gO0=
X-Gm-Message-State: AOJu0YzxHIa28NmLiw5qhON/tn4ywI3ECV/ieYrfodRZgyYcaTuPC1xJ
	8lGGWrFEKQ1HGxusFN1bwLiXmC+wdefdwp+XpEN9Z7qvxiLfCNh3i7VXx/Xgh2Q=
X-Google-Smtp-Source: AGHT+IGset5hmzuq7qwgVG5jO7FGUImBhiqZ/zJ/EfQifRXafS7aAqsaS9KrWxySb9UyoA8woG2GCw==
X-Received: by 2002:a05:6a20:1581:b0:1c4:919f:3667 with SMTP id adf61e73a8af0-1c6943c8a6fmr23565497637.17.1722901154658;
        Mon, 05 Aug 2024 16:39:14 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9f83bsm6046136a12.7.2024.08.05.16.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 16:39:14 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Mon, 05 Aug 2024 16:38:39 -0700
Subject: [PATCH 1/3] pmdomain: ti_sci: add per-device latency constraint
 management
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-lpm-v6-10-constraints-pmdomain-v1-1-d186b68ded4c@baylibre.com>
References: <20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com>
In-Reply-To: <20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 20240801195422.2296347-1-msp@baylibre.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6319; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=og+oz6R3XYFQe2i2DejxnXQaA9AXpva6vUP3tRWt3gM=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBmsWKfpIl4kZWvuypKcaH/eqGQlC1R6P1bjGM74
 NFkYiMkch2JAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZrFinwAKCRBZNxia0/vG
 ZWHuEACoyTYvgkZj4fO9WVi1F+v4gbnUdFZ8AfidMqghcPI+M+ZW+xA8M2hD9OT/EQ3FDGCb+YF
 h0y2FTJ7xQF39jqC1+m8Cri3TXfb4lFfZnYIYWZSZ4gJh4LV3ZR3nP07CsXF7R9d+PhI7J2Awxf
 cXXji95+a8Qcg5NDOuo2JLrbaIuBdPCkgMJNCaR3NF5Os9ybWzasRloUeSf7voIn9M6Ne7T03h6
 7cnMGGcEVOiLRU2PPrJLPIeQISxuddDvONH36Z+81DTmiyfmZIEgSfFGdnIwoHXp37hBWZ1lFkO
 S0bhEvfYIlA+YKxJvHFK5qMje5IevKYQbaeGjAus4FsZsh5QwnCE32+CooazB9VUbNCrq7sKJT/
 E8wkwc/h1WKLrWLpwlLAN335iIyVn2qhczOflmvOTOJdCYgIdy8XpXNHoNJeD4IJblvDCMV3eBS
 G69dAERtX1IMhbDbvgywok89uo8MvoR7/kq+EIS2T1eSourc+7AZvWdMEZ4jFJPYNZ3SP043kL1
 SZSxXBofP5UrpVS3zceZ22O2wu5uhc26Ju3/11u6Tk96DJ4pmZHvyXRZSGcP3bvZlUjpIwQdVfp
 G/TF89TG/DW/g2kNs1srkuLms95COmDPqYIwySMwgHhZr9StvXCxMI34KNMCqdwOV45tpoQRh52
 rjBPTAeMast9MmQ==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

For each device in a TI SCI PM domain, check whether the device has
any resume latency constraints set via per-device PM QoS.  If
constraints are set, send them to DM via the new SCI constraints API.

Checking for constraints happen:

1) before SCI PM domain power off (->power_off() hook)
2) before system-wide suspend (via ->suspend() hook)

For TI SCI devices that are runtime PM enabled, check (1) will be the
primary method, and will happen when the TI SCI PM domain is powered
off (e.g. when the runtime PM usecount of the last device in that
domain goes to zero.)

For devices that are either not runtime PM enabled, or are not yet
runtime suspended (e.g. due to being used during the suspend path),
the constraints check will happen by check(2).

Since constraints can be sent by either (1) or (2), driver keeps track
of whether a valid constraint has been sent already.

An important detail here is that the PM domain driver inserts itself
into the path of both the ->suspend() and ->resume() hook path
of *all* devices in the PM domain.  This allows generic PM domain code
to handle the constraint management and communication with TI SCI.

Further, this allows device drivers to use existing PM QoS APIs to
add/update constraints.

DM firmware clears constraints during its resume, so Linux has
to check/update/send constraints each time system suspends.

Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 1510d5ddae3d..4dc48a97f9b8 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -13,6 +13,8 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
+#include <linux/pm_qos.h>
+#include <linux/pm_runtime.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
@@ -47,10 +49,46 @@ struct ti_sci_pm_domain {
 	struct generic_pm_domain pd;
 	struct list_head node;
 	struct ti_sci_genpd_provider *parent;
+	s32 lat_constraint;
+	bool constraint_sent;
 };
 
 #define genpd_to_ti_sci_pd(gpd) container_of(gpd, struct ti_sci_pm_domain, pd)
 
+static inline bool ti_sci_pd_is_valid_constraint(s32 val)
+{
+	return val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+}
+
+static int ti_sci_pd_send_constraint(struct device *dev, s32 val)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
+	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
+	int ret;
+
+	ret = ti_sci->ops.pm_ops.set_latency_constraint(ti_sci, val, TISCI_MSG_CONSTRAINT_SET);
+	if (!ret) {
+		pd->constraint_sent = true;
+		dev_dbg(dev, "ti_sci_pd: ID:%d set latency constraint %d\n",
+			pd->idx, val);
+	} else {
+		dev_err(dev, "ti_sci_pd: set latency constraint failed: ret=%d\n",
+			ret);
+	}
+
+	return ret;
+}
+
+static inline void ti_sci_pd_clear_constraints(struct device *dev)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
+
+	pd->lat_constraint = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+	pd->constraint_sent = false;
+}
+
 /*
  * ti_sci_pd_power_off(): genpd power down hook
  * @domain: pointer to the powerdomain to power off
@@ -59,6 +97,18 @@ static int ti_sci_pd_power_off(struct generic_pm_domain *domain)
 {
 	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(domain);
 	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
+	struct pm_domain_data *pdd;
+
+	list_for_each_entry(pdd, &domain->dev_list, list_node) {
+		struct device *dev = pdd->dev;
+		s32 val;
+
+		/* If device has any resume latency constraints, send 'em */
+		val = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
+		if (ti_sci_pd_is_valid_constraint(val) && !pd->constraint_sent)
+			ti_sci_pd_send_constraint(dev, val);
+		pd->lat_constraint = val;
+	}
 
 	return ti_sci->ops.dev_ops.put_device(ti_sci, pd->idx);
 }
@@ -79,6 +129,38 @@ static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
 		return ti_sci->ops.dev_ops.get_device(ti_sci, pd->idx);
 }
 
+static int ti_sci_pd_resume(struct device *dev)
+{
+	ti_sci_pd_clear_constraints(dev);
+	return pm_generic_resume(dev);
+}
+
+static int ti_sci_pd_suspend(struct device *dev)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
+	s32 val;
+	int ret;
+
+	ret = pm_generic_suspend(dev);
+	if (ret)
+		return ret;
+
+	/* Check if device has any resume latency constraints */
+	val = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
+	if (ti_sci_pd_is_valid_constraint(val) && !pd->constraint_sent) {
+		if (genpd && genpd->status == GENPD_STATE_OFF)
+			dev_warn(dev, "%s: %s: already off.\n", genpd->name, __func__);
+		else if (pm_runtime_suspended(dev))
+			dev_warn(dev, "%s: %s: already RPM suspended.\n", genpd->name, __func__);
+		else
+			ti_sci_pd_send_constraint(dev, val);
+	}
+	pd->lat_constraint = val;
+
+	return 0;
+}
+
 /*
  * ti_sci_pd_xlate(): translation service for TI SCI genpds
  * @genpdspec: DT identification data for the genpd
@@ -188,7 +270,15 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				pd->pd.power_on = ti_sci_pd_power_on;
 				pd->idx = args.args[0];
 				pd->parent = pd_provider;
-
+				pd->lat_constraint = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+				/*
+				 * If SCI constraint functions are present, then firmware
+				 * supports the constraints API.
+				 */
+				if (pd_provider->ti_sci->ops.pm_ops.set_device_constraint) {
+					pd->pd.domain.ops.resume = ti_sci_pd_resume;
+					pd->pd.domain.ops.suspend = ti_sci_pd_suspend;
+				}
 				pm_genpd_init(&pd->pd, NULL, true);
 
 				list_add(&pd->node, &pd_provider->pd_list);

-- 
2.46.0


