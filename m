Return-Path: <linux-pm+bounces-12497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A8A957A2F
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 02:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA061C23B38
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 00:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF768158208;
	Tue, 20 Aug 2024 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ga4R5Zgb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C038F9C
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724112031; cv=none; b=ZsFpjH8Uy15gO9E9cQewrRiStUG117XW2CGd/j8bsh0BMXyrudIpjLqNIKO3boJnReC2TePPvAKwBHYN3jgsUAWcyeWlfSH619dA0/cA5zRFgC3zxLJaM4diwWhrsvhABIx6zHuaZNWXjHvLj5Plw4pCVsBWvFTme3zaA25sIXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724112031; c=relaxed/simple;
	bh=EsyOvHfUW/kIQJ0oYk1mZTfySSyGRxhdYE3KKRCGBak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RUjwWe0y+9nfp58ClCHQThKYTuQMO1IpYJL2+a8Hmq4iug3fbS6PwmlveOrNkrxGaKYuaAjvo//FPLojk/eY105pJkfHdzoU93EsAI9gaKXe+yDvI4DzKuE+Adn5OQFfaKuMwM25JyR69S/Ls83/RS+vhiMLRqoNs7a5SXl6lQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ga4R5Zgb; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d3bd8784d3so3587673a91.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 17:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724112029; x=1724716829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLE5hAB62v7p1beN0KLDfInOowT8azj61EJTe8F9z3I=;
        b=ga4R5ZgbC5k/fm1bfryHvI/cKMGyd8/Jn2HT9i8mIa+WPIfcZXxF6U4SwY8QivOQku
         Ob5d+tIJRcLSRg/hui/c/mBC2yKJ2VcJEJrVpiJOETM8HYo/TOk91eufmUFml0LdB2ff
         znPD4DAoSeFwnIQ3bBvapzUNKFVnq5MTA1Nv7eb1rbKxbAkyAmlnbeusBWGdw5wi86Zh
         fSaqrtcuQPFI7wGU2M8zTwGvSrFajzjMQkWma39z9NoQRrVfrShxlu1E7PvnhF2d+aYQ
         JqrSg+/lrS469hgcCstEYgBJ5g9/NS2gbeubTl+D5OXtz4piOjDI1IDN1hih7DJeq+78
         l9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724112029; x=1724716829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLE5hAB62v7p1beN0KLDfInOowT8azj61EJTe8F9z3I=;
        b=rc3dpCThW9gmPUTAt2gtyLfr0GguFnaZn5bih/S46FD40YOnssQnF/xOBNVBWy/FQF
         bkoejQrBs0bsDAMWte5hxqErxj88FvIZE+B03kYEuvzoA8Wnhimj8cMlOtq+ay6t78VW
         j+ateCS32Y/hn8Oks5muBJvKoTBlsQAnHnpwbtn3ai08sl5KgLGY2a/OJk8G2f0slM9d
         1SKbm/lOHy5Vnel8T/HLl0GQdyLXqvOU1Fqk06LDLfNXGfYwJBWWlRR2sCdqMPvY2+xL
         mPtl4kW9CwR6xQGGy4n+bDuL/vibrrbnBL4uRJ9BVz09vYYoTtqAmgWHS2zCekG3da2+
         wQbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhtahvd476Xh0rg+2Z20uSXic0kwM+3pOFno3Ist8xhrMsmzpUGvHf8aSJpfHSgrr8aZtaz74RVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS67bikONICzNJn4e4gtyGxtK3eLJXnqw67t4Dq9WR1+Mjia1f
	wVjO34HEdQ1zxoUyCuVBjLB9Q5fVKz2kPOnXCRDI6pLy3wH7WnBfC/dzyWmaY0Y=
X-Google-Smtp-Source: AGHT+IF3qZLIeCayxsLpMAWoTFuVPjgH1YPTWPIw/WqvEfRwrWzcax1rN4IpM+MAAYfrKW8qcN1A4w==
X-Received: by 2002:a17:90b:33c2:b0:2d3:da6d:8330 with SMTP id 98e67ed59e1d1-2d5c0d79fe4mr726670a91.4.1724112028390;
        Mon, 19 Aug 2024 17:00:28 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3076130sm7955195a91.29.2024.08.19.17.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 17:00:28 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Mon, 19 Aug 2024 17:00:11 -0700
Subject: [PATCH v2 1/3] pmdomain: ti_sci: add per-device latency constraint
 management
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-lpm-v6-10-constraints-pmdomain-v2-1-461325a6008f@baylibre.com>
References: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
In-Reply-To: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3743; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=EsyOvHfUW/kIQJ0oYk1mZTfySSyGRxhdYE3KKRCGBak=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBmw9yavh3GVW7GdVcsaxRa3+zt6YHIUgUUkm+PB
 xaznFP/seGJAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZsPcmgAKCRBZNxia0/vG
 ZXaqD/9kEDcKjRDUuwAvfCW4lDul+xVVGKxjHy87Bc/XdpCDVJpMhCgaPnmwPaNZahraaii+WDc
 A/ikrbMk9jpbcRYi7RxIge80STHu3Re5Pk3OqI9flWtuQ4gCt8gAnXkPG8PYLvbsOIvG5XcuVs9
 S30gGsGoQAUpJodgGrAIKNr/9TFhTFO6jGnFvWmXZ/BuGoRg73H2rXhTkrBHq2iYcfYQwcJH69d
 bPOMIGkk5eWMBspqH9pkvoqmR31aHUol5vro5ANeCMTvt7etKD/ug2qa6H9xkxMLxAQDP/vADXZ
 qevQIIw64jReIj8qbmjACgu2gyBLHqvsfjGDo3zEEKMzjFQz7iEV4D8njkqtdCy7FNgwsu9lDXG
 GkYgV0/ecBT+HMg9rn0TSkeQ3RjSmryLWbk2vmTQUwYrkM4plp67a3Az3xugrFsUW1VIc/LKO3X
 z3WXnnBuU7/BGZYNFWgrh6luqGgFhiiwxOTfmdtYgkIp8XF6lY0a3TeVTv6bL8PxjHlGcrdWct6
 qrQFvxRyjh+6lalWWO72eHaBduZr6plINvEPjfwH34RhjO3ysRojgOwA+oop9KO54SsmfgkAyFa
 y2S3L5R6zC4pahzXCS/qTYy95trffxQg7Nq0Vg3XYvxh5ZZuyKPJIvecc9vCXR0arF6in5lDCYN
 cBBvQIb14J/+Iig==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

For each device in a TI SCI PM domain, check whether the device has
any resume latency constraints set via per-device PM QoS.  If
constraints are set, send them to DM via the new SCI constraints API.

Checking for constraints happen for each device before system-wide
suspend (via ->suspend() hook.)

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
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 1510d5ddae3d..963272fa387b 100644
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
 
@@ -51,6 +53,29 @@ struct ti_sci_pm_domain {
 
 #define genpd_to_ti_sci_pd(gpd) container_of(gpd, struct ti_sci_pm_domain, pd)
 
+static inline bool ti_sci_pd_is_valid_constraint(s32 val)
+{
+	return val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+}
+
+static int ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
+	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
+	int ret;
+
+	ret = ti_sci->ops.pm_ops.set_latency_constraint(ti_sci, val, TISCI_MSG_CONSTRAINT_SET);
+	if (ret)
+		dev_err(dev, "ti_sci_pd: set latency constraint failed: ret=%d\n",
+			ret);
+	else
+		dev_dbg(dev, "ti_sci_pd: ID:%d set latency constraint %d\n",
+			pd->idx, val);
+
+	return ret;
+}
+
 /*
  * ti_sci_pd_power_off(): genpd power down hook
  * @domain: pointer to the powerdomain to power off
@@ -79,6 +104,22 @@ static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
 		return ti_sci->ops.dev_ops.get_device(ti_sci, pd->idx);
 }
 
+static int ti_sci_pd_suspend(struct device *dev)
+{
+	int ret;
+	s32 val;
+
+	ret = pm_generic_suspend(dev);
+	if (ret)
+		return ret;
+
+	val = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
+	if (ti_sci_pd_is_valid_constraint(val))
+		ti_sci_pd_set_lat_constraint(dev, val);
+
+	return 0;
+}
+
 /*
  * ti_sci_pd_xlate(): translation service for TI SCI genpds
  * @genpdspec: DT identification data for the genpd
@@ -188,6 +229,13 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				pd->pd.power_on = ti_sci_pd_power_on;
 				pd->idx = args.args[0];
 				pd->parent = pd_provider;
+				/*
+				 * If SCI constraint functions are present, then firmware
+				 * supports the constraints API.
+				 */
+				if (pd_provider->ti_sci->ops.pm_ops.set_device_constraint &&
+				    pd_provider->ti_sci->ops.pm_ops.set_latency_constraint)
+					pd->pd.domain.ops.suspend = ti_sci_pd_suspend;
 
 				pm_genpd_init(&pd->pd, NULL, true);
 

-- 
2.46.0


