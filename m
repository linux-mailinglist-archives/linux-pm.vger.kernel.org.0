Return-Path: <linux-pm+bounces-18722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9B99E7B77
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 23:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DA61885E5D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 22:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FFB206289;
	Fri,  6 Dec 2024 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yQOABU3x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F041FA172
	for <linux-pm@vger.kernel.org>; Fri,  6 Dec 2024 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523185; cv=none; b=A0agi5qhzzaGTZv56EUxOUAyWkdsbdA0SPZaxVI+3EZ5gazfA0ie7d6om9acmrKAnIwi2kXz8DHmvz+AVEg46h6yTR2+1233yL4nQcxDSewEZYKPNS7Yi6+oNHA8Vc4RQPx3XlMcJvbp6BrdJZqVSdYpTE8345fkKAKzOcmcHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523185; c=relaxed/simple;
	bh=j0AdB2Ec/r7btTrtPaxqZvIVKLQ2BqKv+VHDX0Y86Yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OYk4lNk+0gzN0e6UTQEoMKIoGZNZ676j40Kfb0OGnlrpXfPD9Zy28/XrgFNYAu64l/k56wKLxtAsccNZDCK/bWqxHZOIAwHGEn6OcR/q+iZTQa6brr3wp96CQN+QeeGORP03rbNixZF2s40feYNX7ihLo/4rl5yAU7zOJF1dbOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yQOABU3x; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7242f559a9fso2759429b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Dec 2024 14:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733523183; x=1734127983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7rXiwNlneTt0S3Im0z7iFr8r3P4BVASAMn47K57uCI=;
        b=yQOABU3x6mAJz5tjwuN3i3WO81RWULmTM6VYIdTxgrzmrmj1+Jdrjk67yrYRb+qvr0
         PaIb2w3vtZfwkuERbHr5Xx//lM4lMYB6VbX0KLBZr9TS/n4+CUZ90Yri0ZJtVtsTYjBr
         77aT6ILA4aKaCg6MnGVHH1gp4TWEqb0zOMIS7FMdB765Sr305LVLIl4AbK7f037/jYmH
         BpTTRKQURTYGGQktDbHmGxb+D/j0NlMWdkarLYBN8YzXBRidpI6IlKthzWDKJNL/qgOe
         Pk0VwJjJ+ItAVKi0gkevBwCXMilKNjBJFsb0Je9iCsB1a+fpMfJHus7cgIi8igN3ENDS
         CIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733523183; x=1734127983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7rXiwNlneTt0S3Im0z7iFr8r3P4BVASAMn47K57uCI=;
        b=v9Bsxy5i70Nc6ngPjoUAJOQlHT1bHWDvMZdOLBNt39hSAP5YSyB3KzEEOOQpr+URFO
         Keqlyq407tn9nwaZfkWyZqJd2DaUgAV9BJYSbh6+6tozdEn+eEkrcj94vyk+g9OYJxa8
         kKJsgOAypH7Rs7NZ+lUeKkHkLrX7M94QZ3SO/+8hJFIADlltvgdWDzO6OBXVLdFwMXpq
         c2InQMt5py/5JH3iyNO4ftqa1VeXFG9HmBxAqVubzGfifd1nY47GE3V+CCuG5cey0tFG
         jHsnYajSoGmWZjn/0K2IKUMor3z/iSrTruJlk2ClERKoOQ+XedQCWHHjdPWWPvKB1FiT
         n97w==
X-Forwarded-Encrypted: i=1; AJvYcCXSuZ2mjdrf8v9THK8Va813MkDJPNG/fEN52f51sbWzwvdxunrWiMXYx7kCFUw4ZnVl+fvL+zNddA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUVT/W6TRLjhSIW6Fxj1HxcOlUCo6+7XMdSgH+JOrrimnTENlN
	L9daJisuxfU0+X16RKktjYjGjnCOxmeJiR9aAe2wNFQfWi54xAS8/2B8LiKFbwc=
X-Gm-Gg: ASbGncsFAzX7DH60AHLA1XGcPBGT2ncxr9fH33cHTqb/+v+1AQmt2a98KOKO8MyGHXD
	E8+17fbSTr/ruZF6QdwZdcXRm8cQz4A14+jma7MMjKYksgAsVS4ZzeSSyzQqQ0FWQDOeIXsrEcq
	6/AvapgNgXyL7O9M45fDa2lcyZitdd5DBROBb+mC1HeaEjG1rdDjsj0DO0jYPP80oeiWYAIvllw
	XbkoYRmZIsMtDyf6S9V0umCnC4tipcJE9d/VRJI18aXd1I8
X-Google-Smtp-Source: AGHT+IEfJ6mTFHdobaZb1oZ2zV41f+MLXhV0wfwqztWK6BVWpG2aRCtQVIyY2AfpGqUSf7Ysz3ATBA==
X-Received: by 2002:a05:6a00:994:b0:724:ed8f:4d35 with SMTP id d2e1a72fcca58-725b81a9cebmr6601983b3a.26.1733523182698;
        Fri, 06 Dec 2024 14:13:02 -0800 (PST)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a27e9193sm3435675b3a.0.2024.12.06.14.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 14:13:02 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
Date: Fri, 06 Dec 2024 14:12:50 -0800
Subject: [PATCH v6 1/3] pmdomain: ti_sci: add per-device latency constraint
 management
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-lpm-v6-10-constraints-pmdomain-v6-1-833980158c68@baylibre.com>
References: <20241206-lpm-v6-10-constraints-pmdomain-v6-0-833980158c68@baylibre.com>
In-Reply-To: <20241206-lpm-v6-10-constraints-pmdomain-v6-0-833980158c68@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4286; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=j0AdB2Ec/r7btTrtPaxqZvIVKLQ2BqKv+VHDX0Y86Yk=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBnU3bs+JJtfkcVGHUhIAcSaWpLkYXr8u3NXouG5
 4fGc5caxX6JAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZ1N27AAKCRBZNxia0/vG
 ZfnwD/0StIlo35PDhUGEwnfZ+Rydqy8cNKGKRhQb5KzUsyiuOL4ELlJa5D33A8NB2a75+95dlsg
 gzK1uGvwIdqpVGPEq6kzS+6+66g7gKkGprQ3Mt1pFHFMBhA2cb+8NMzPHxNUxBjcq2CqTL4lMaM
 1aeQ5YlLV3GTpJg7ec0WmleQRWkSY5XouNK3GFSSqCwFSYy9s7dri1gBDuzPy/ZP9HfEK7FoBA/
 3P5NITclzhBf0OuMF3qmDhQFC7TYX+CSXxKQFQl950y9xpy2zOuKRPWYO0XEqJfHvzWA9Wz/xGi
 ujsnul6qP8wqGyjbkWZNGHQK6lq2ryliZRnDPhB686kUFKNf6iFdTRISMa7TLHBkMoC6AGL4f+o
 3NB5yrgWOjEItFozVTrPtZSt37pQgCRkww7gFaE7EFPt1EfLXkclTZAjWjodA2U7ndDG3DgMUmq
 1jcKS7HMQH0iJfAcwDQKpPOZLaakslLctyRlsaBG+duSUZY4moA49Ork4iUCUJObMSpi3zBDDDv
 wWNjirwjI6iGIrTw/R+v9Xkc9mJzZZQSGm/J+Py5lPrJqiDHI4EgSkBuCJoG2nfoHQg9qJ8vsX4
 ijrbm+t0IDGLqpMgS+qFX0ViTMvxFy6qMkuCiNCji7qFNIVQhop1ioKJ68eU6Po1/wD3XpUlu0a
 SKtqsstaZbro8JQ==
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

Also note that the PM QoS framework uses usecs as the units for
latency whereas the TI SCI firmware uses msecs, so a conversion is
needed before passing to TI SCI.

Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 0e4bd749d067309654307484c5bb98711bf06daf..963fe1901c959197d5d8b5d34fd8420dfb180087 100644
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
 
@@ -51,6 +53,32 @@ struct ti_sci_pm_domain {
 
 #define genpd_to_ti_sci_pd(gpd) container_of(gpd, struct ti_sci_pm_domain, pd)
 
+static inline bool ti_sci_pd_is_valid_constraint(s32 val)
+{
+	return val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static void ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
+	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
+	u16 val_ms;
+	int ret;
+
+	/* PM QoS latency unit is usecs, TI SCI uses msecs */
+	val_ms = val / USEC_PER_MSEC;
+	ret = ti_sci->ops.pm_ops.set_latency_constraint(ti_sci, val_ms, TISCI_MSG_CONSTRAINT_SET);
+	if (ret)
+		dev_err(dev, "ti_sci_pd: set latency constraint failed: ret=%d\n",
+			ret);
+	else
+		dev_dbg(dev, "ti_sci_pd: ID:%d set latency constraint %d\n",
+			pd->idx, val);
+}
+#endif
+
 /*
  * ti_sci_pd_power_off(): genpd power down hook
  * @domain: pointer to the powerdomain to power off
@@ -79,6 +107,26 @@ static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
 		return ti_sci->ops.dev_ops.get_device(ti_sci, pd->idx);
 }
 
+#ifdef CONFIG_PM_SLEEP
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
+#else
+#define ti_sci_pd_suspend		NULL
+#endif
+
 /*
  * ti_sci_pd_xlate(): translation service for TI SCI genpds
  * @genpdspec: DT identification data for the genpd
@@ -182,6 +230,13 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				pd->pd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;
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
2.46.2


