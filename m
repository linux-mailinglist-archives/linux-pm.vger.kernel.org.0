Return-Path: <linux-pm+bounces-27573-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AA0AC244C
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31349541598
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C75296735;
	Fri, 23 May 2025 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F8dFzDMW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F2529616B
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007666; cv=none; b=lg/MmMq4kT1+GM9oAoV63CIHfVNfwW3RhOKUH+0ZCmBFZPtWRuuxesH4deILxOg1xZhQ397XkZ0O2xUivVVKX1dx85pXoGCoRKe80PahL4WUyh8S8xXWRnfjUigetMU7rm3Z3oHZj9BCRAsTABPFLHfNl4cdJAoaoGeVQqmpj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007666; c=relaxed/simple;
	bh=ZG0wD/LR/YXT1TNvRGuMwWiwi7r8mDmA4GGyX/lU8x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGu6KT5B952cIqDFkk+INX7UDUvUdF329w115NlTO6Tr9/lTTK01TjS4EyN9eyD9/on3aLXmnlapmL5QW2hzkQlzyfDoZtxco+wqw6GTe96RbQfyMAJ/kdO0o9XyM3ELTlSNWoFjQtLVtgRSDy//P/EQRO1+ljSDpvjLIqpR5Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F8dFzDMW; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54ea69e9352so11683609e87.2
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007661; x=1748612461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/aJJumEOcgP/SHpHSm52hNIxPzlDOJRQ3oP2wL6guI=;
        b=F8dFzDMWueM3RzDG+pwIcr8kODFajW1nlz6emSjIaAx0uTESKlM1cXof1XJJkWxP5v
         dQoZEeCdI9+LalcRvw0JvWfP4cozeYlzZtGfi/tA7Yh4KUn4aYxMjA6FcYCsJ3qywuls
         R36piBDoWo/6shjTFbys3VqPIG/0eI9+x6ubO9ljqP7j2l01rI2WlD6PpbbJ+F6S78S4
         xp1MEZk2eVwP/0kVAdX68jdFbUXQeri/Lgr6fIJQs9CZQU6KMQCxl940BUHcr75JcDyU
         e8n4juD7RmJbtWq3dXsPtPztEGhoRRbqcptq1IQjc2yCrQpuHg9PbJk51ewcU+venwHx
         2Biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007661; x=1748612461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/aJJumEOcgP/SHpHSm52hNIxPzlDOJRQ3oP2wL6guI=;
        b=T5bd2oRoQ10GJMj1sX8MCLJi1kFI3NyjEnrR1l++xpwuwZOsrHtRzOcPtEDbFC4flu
         dU9CzulECI9VBJ1CnLN9apIQMqTA+5U+esi8dn1rq2/7bKk74sV927VO48Sbv5DXi4qA
         jhYAMQOk9wErDr9fqcJpDK4lsORiWpJJuqv6VK3yj23fJn6Ew0uZozonVOzFZDW7l3tA
         Ot2eOfAdLKD8Y1DBYuQORZ/z96AdiT7fB4GpCgb1bvkNV4EqB6jn32MsXeCnbWysMxx6
         9P1P3Fn2KMDtrE/eV1AYprgpClbxkKJKHZOJ1oDicTnDE/Ga9MwSupMivuxJ8Zs90NnR
         Ituw==
X-Forwarded-Encrypted: i=1; AJvYcCWR2hnb2ufHqRtWFaPwWhroZ6FPTsuPvQ8RbmhL78i+9Ua511zHwZMvfCXiACeo7aId2iA2/ZtA/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIeXrVjfjOoZhOImirBqGACyHp07ZV8+aV8dLJAtgAEFSMeFg0
	3xB1KzNHUNEz4B9Z9IE6SVj9slNMD+tIh5CHUHp9z7gIqDDMvHkrMEwKvQwRkPIrlmM=
X-Gm-Gg: ASbGncu/cHtUoj9ZbP+jBiAYdVOjOSG/MTnlHMOExJSQMMAH8p8f07X/Wn9QFpccpEU
	fzdfCe/8adDgx8+WDhgHTC8jQRcQsmZBtQbLpINtG5G3CcYK0jeo1U88wDDxKEHJ0rmz2kqDpkN
	Na/PP/m1Qs8b0k+RI/5JP+DvBh/lk/l/Aie7WQydfj8H+r1mTDT98+8CPfw/t5m48gshy+olXbG
	Hp6QI8JUUwKqqglWq6xCHcxq1EnFFp0mcw6W0aFfLQME1jY2f9ARhkrx1Xr4UXjw8nC++KNdT/n
	UrYHYza94yPnY8oBA8Qy8ymu5Ld6yUA0dk+jY/zxJ3iSvF/i1sYb0ENkfkKl2zfHKYx44FG+Hsn
	5wWqU0S4eBsROLnBW0Q/cM+jFCCgsCQCXNEuR
X-Google-Smtp-Source: AGHT+IFqaMutTsheTfKkW2cqf5rtDAzYDo1ADk4nh7EfRPJsLI0D9Etd71qYegkMcQyfr86dVQn3qQ==
X-Received: by 2002:a05:6512:2616:b0:54a:cbfd:5517 with SMTP id 2adb3069b0e04-550e99259b6mr6555792e87.53.1748007660645;
        Fri, 23 May 2025 06:41:00 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:40:59 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/21] firmware: xilinx: Use of_genpd_sync_state()
Date: Fri, 23 May 2025 15:40:10 +0200
Message-ID: <20250523134025.75130-14-ulf.hansson@linaro.org>
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

To make sure genpd tries to power off unused PM domains, let's call
of_genpd_sync_state() from our own ->sync_state() callback.

Cc: Michal Simek <michal.simek@amd.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/xilinx/zynqmp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 87ddbb7d11c2..02da3e48bc8f 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/hashtable.h>
@@ -2101,9 +2102,13 @@ static void zynqmp_firmware_remove(struct platform_device *pdev)
 
 static void zynqmp_firmware_sync_state(struct device *dev)
 {
-	if (!of_device_is_compatible(dev->of_node, "xlnx,zynqmp-firmware"))
+	struct device_node *np = dev->of_node;
+
+	if (!of_device_is_compatible(np, "xlnx,zynqmp-firmware"))
 		return;
 
+	of_genpd_sync_state(np);
+
 	if (zynqmp_pm_init_finalize())
 		dev_warn(dev, "failed to release power management to firmware\n");
 }
-- 
2.43.0


