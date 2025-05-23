Return-Path: <linux-pm+bounces-27571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1CAAC2444
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31328A20896
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E98C296153;
	Fri, 23 May 2025 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l5IYs9xH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D931293B68
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007661; cv=none; b=h4PA0/gBz0iHlQHVd4wufsxai5zLHLQUs1A5Q1k8SwnF5n0eEG5QWn4zB/kUA/2K+wSOIFC/4IOtf43twl/NUfWxTAd7G0KBEapt3euU1vwzIVg+Jnsk1JyU1JJL71F7xXRQZhZFRUlnY2KnAAnUzeEfLTviMT8mO6CA2rd42Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007661; c=relaxed/simple;
	bh=S60R5V/pPXQ74Qcu0WmrzCZGgGMF0WRf6YeAjT2i5xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnz6HfOvJ7dZWlON1gQF39qw+o1oo3A65VDuvOcb7AjSP4YRyajUMCb9a73SRPjbZrdBeUs2SWYVb4zxwCus9wQ5X7eGS4H9gHb0s+oFgf8gyiC1HvcFne6OcY3xX/YPTl0lE8VOOkzNVxN2zBu3Zy6swnk6zU88t7NihtpazvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l5IYs9xH; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54998f865b8so10032067e87.3
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007657; x=1748612457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaodTG452ygjUfeAqfzX0hcEID7mM0/biHJ7FoGpgVo=;
        b=l5IYs9xHkeDTDEX1Y8EiRhyWAbfS3gEwRpJ21TQV8IRGZoLRucYM7yk96NXVRCmI/X
         sAYXT+GGknL4RIUQcyjR9uOxkuEgf3RxkKquQqAdhGEB6DL7R2gfkZnYl1jtXLB0wxBw
         ogl0z6lnTz21MkboxUoKJnwy3S9DjSxYD3B1cjtsDr0eQMda0OzI0/MozsPjLJm2+w5W
         0MUKsSgYlTDpJhNDD44audMgsuLT1bug/B/kJr1iU+gsOKovdoOznKGwnSuzWd/pQOTP
         j2zuQxTDpDAk9dVprexdE6HfW/PCIPJq2CN4sJfWuWa2MUm0KBUgN7rM2YtL0fR4ld7T
         lyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007657; x=1748612457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaodTG452ygjUfeAqfzX0hcEID7mM0/biHJ7FoGpgVo=;
        b=oPhmBaV/lRu9AV45p3wNA/miHLfNfZ/VfSBby44en7GlxASsyP9/1kKi800rgAJwKW
         CNgS67Rbhr7lXGLvyUcxjVVGsyP+KWfcEabIOkojDU0d97E/A84GAsQHzudToLnpcq8Q
         YL3bO50Fo+dGOfcUuGxsPzbo8wWaa5rR8g7XzvnlVfhhfJW8ZaNb0Zi5FRkAYUAnfzxy
         A3zAd8Myvm4wkoTIV4hve8DJgDOKw4jxeEiSU4f9MVFI1nHXmKjJfi3gPWUStqONcR8j
         5rXWWRZWjiqi3pDzG2lHV9bP42rRCWKRdfHJ0mAOX1pOmXRt6OdaZNB16QGe+F0ek1Rm
         qtgA==
X-Forwarded-Encrypted: i=1; AJvYcCWMD6crISC/ewbzhO99lwtjjNCXsrXGhRF6EZenSCaXMwUiYR3toFIsz6LKSX7rNzJzLVtpPs1dxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcflwqP8wyP3uTXl1azJn0nN4mKxbjIXByL8S4JsPPD/raXWQ/
	S23BZ9R55DY+ni9tXTNU7hVfrUg0YkQknVyZk3Vlp4yk5HHcHIvu4vc7oT6i8I+owC0=
X-Gm-Gg: ASbGncuc+iVtWdbjGpvsD1/P0pXmQAIq7sExqoot2wvKKpl/JSN//5QVKNEFJeMNkGN
	XsbEcQPgByJY8SqTYLA+KxN+XgbxDCuGJVgnMjp0YBi0mQvSWBK3Sn8rFx2tXxp7jKzssfsD9uq
	9NuREVSltCyCizp9p2Y1kB9oLNDQzDuA8dUhEq9kXjCGREh2IdfjJwGCiW4o2aatzaQF7qxWvhI
	Fkj/oI79+MWXSo32ERBmVdFG5Bed3b+4zLTlEciEkMM0JXMnDSpT7/HC2uy7/I1qjaUpZGyd4MI
	8dM8igEWJwttZApbnqKEEmFrNBZX5K/CFe3/LZZ1T6fw+xzP8D9cpitiT9Nw3e3IsO/VoSA5fHN
	7VIt8os+W4jQaKr4IT3zofFpR8w==
X-Google-Smtp-Source: AGHT+IHrYinBpOd90/7cqZZUAtcZLCgKCB9acewmFqtCkeLzwOOJRxqmBPoVSqry9v+2LJB1zYOmGA==
X-Received: by 2002:a05:6512:6081:b0:550:d534:2b23 with SMTP id 2adb3069b0e04-550e71d2719mr8188649e87.27.1748007657233;
        Fri, 23 May 2025 06:40:57 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:40:56 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH v2 11/21] firmware/pmdomain: xilinx: Move ->sync_state() support to firmware driver
Date: Fri, 23 May 2025 15:40:08 +0200
Message-ID: <20250523134025.75130-12-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523134025.75130-1-ulf.hansson@linaro.org>
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than having the genpd provider to add device_links for each device
that gets attached, to implement the ->sync_state() support, let's rely on
fw_devlink to do this for us.

In this way, we can simplify the code by moving the ->sync_state() callback
into the firmware driver, so let's do that.

Cc: Michael Tretter <m.tretter@pengutronix.de>
Cc: Michal Simek <michal.simek@amd.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/xilinx/zynqmp.c            | 10 ++++++++++
 drivers/pmdomain/xilinx/zynqmp-pm-domains.c | 16 ----------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7356e860e65c..a91a0191c689 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -2100,6 +2100,15 @@ static void zynqmp_firmware_remove(struct platform_device *pdev)
 	platform_device_unregister(em_dev);
 }
 
+static void zynqmp_firmware_sync_state(struct device *dev)
+{
+	if (!of_device_is_compatible(dev->of_node, "xlnx,zynqmp-firmware"))
+		return;
+
+	if (zynqmp_pm_init_finalize())
+		dev_warn(dev, "failed to release power management to firmware\n");
+}
+
 static const struct of_device_id zynqmp_firmware_of_match[] = {
 	{.compatible = "xlnx,zynqmp-firmware"},
 	{.compatible = "xlnx,versal-firmware"},
@@ -2112,6 +2121,7 @@ static struct platform_driver zynqmp_firmware_driver = {
 		.name = "zynqmp_firmware",
 		.of_match_table = zynqmp_firmware_of_match,
 		.dev_groups = zynqmp_firmware_groups,
+		.sync_state = zynqmp_firmware_sync_state,
 	},
 	.probe = zynqmp_firmware_probe,
 	.remove = zynqmp_firmware_remove,
diff --git a/drivers/pmdomain/xilinx/zynqmp-pm-domains.c b/drivers/pmdomain/xilinx/zynqmp-pm-domains.c
index d579220a4500..b5aedd6e33ad 100644
--- a/drivers/pmdomain/xilinx/zynqmp-pm-domains.c
+++ b/drivers/pmdomain/xilinx/zynqmp-pm-domains.c
@@ -153,14 +153,8 @@ static int zynqmp_gpd_attach_dev(struct generic_pm_domain *domain,
 				 struct device *dev)
 {
 	struct zynqmp_pm_domain *pd = to_zynqmp_pm_domain(domain);
-	struct device_link *link;
 	int ret;
 
-	link = device_link_add(dev, &domain->dev, DL_FLAG_SYNC_STATE_ONLY);
-	if (!link)
-		dev_dbg(&domain->dev, "failed to create device link for %s\n",
-			dev_name(dev));
-
 	/* If this is not the first device to attach there is nothing to do */
 	if (domain->device_count)
 		return 0;
@@ -298,19 +292,9 @@ static void zynqmp_gpd_remove(struct platform_device *pdev)
 	of_genpd_del_provider(pdev->dev.parent->of_node);
 }
 
-static void zynqmp_gpd_sync_state(struct device *dev)
-{
-	int ret;
-
-	ret = zynqmp_pm_init_finalize();
-	if (ret)
-		dev_warn(dev, "failed to release power management to firmware\n");
-}
-
 static struct platform_driver zynqmp_power_domain_driver = {
 	.driver	= {
 		.name = "zynqmp_power_controller",
-		.sync_state = zynqmp_gpd_sync_state,
 	},
 	.probe = zynqmp_gpd_probe,
 	.remove = zynqmp_gpd_remove,
-- 
2.43.0


