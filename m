Return-Path: <linux-pm+bounces-29906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FE4AEF732
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 13:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A43447C5A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 11:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D5D2777E5;
	Tue,  1 Jul 2025 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jDQIm7mo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2067B276046
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370490; cv=none; b=MJGtU1NV79jptqHfxidGAJNUW6DvQ5nEoosvDOS9/iza00yMK2XMLhyse8ZdGEyFEPY43sViZCj/yXxV/bnIdJ+qtH0cK3q+6vr/1QqLulr7X03ztGUoI1fThILQ+tPwi6VeFcxIby0DaZ0h9PixAB1CTphJ0+umKTC/lOxLkS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370490; c=relaxed/simple;
	bh=QuGttwI0OZFvkoIf9v7woAbjYjj7oBHxyYqMn/p2JR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMsIoS3LVMmHMpEv2Xuw85mttxfxeNMdtVrWktbamzSiwgXCpkqsNMQa9UycNQCua3zi5LVZvHRj40zqrP8fCOR1NgoQP/DVzrk57gHIeKFG4d78vTBxoFFje9h8UeuFT1bZGMXHVnuvFKWWOae0YDhPgAbfRcSScmsG2txoSck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jDQIm7mo; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-555024588a8so3328136e87.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 04:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751370486; x=1751975286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fe5xgad5AXlWIH4ix+NrVYG0DCMVBlY/Hz/zA/w4CmA=;
        b=jDQIm7mo30ERWh6u/ffmL5ZepdmzGin+NLRWWTXVTRc6GoelJ8s9spfAChFOh7qFGl
         pn2M6JejfB1ulFI7W4nzaEIh9NoqP4bpszUDDLgSw5Q6yi4Ay3N3c56lvjibELoRnxuo
         vYrZK9x6rhM0SBbbYjpspBJSXZPzrbRxBjbvrpVClU2cDFSrQxxnmhR12RFFia5RpFfa
         o9DCYUKe3/9q9jBv75owEAtSoV8uiP/V8UBnggUpTIa2iklHk7/5kd1mPLTYT0ph1CSv
         in9eoTzHeXzD7HfjUcHw3OY9LZ9nFy9LvJTqLZ/o4BdDpWYcJY1BXzG/LIcKSktr95UP
         oNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370486; x=1751975286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fe5xgad5AXlWIH4ix+NrVYG0DCMVBlY/Hz/zA/w4CmA=;
        b=WkGCppKlHJX+Osclh5eR0/bPnUnxymQfk4RJg69OYVYGig/v49WbE5Lkc0A6wH7C91
         lCnbSLhBaETcWZiT3uUbd3sqD/WN7xKSwoMn1HWiqDZwY8bxBvpdCeGa615X9F1XWhfI
         4CJWBRrrXMHGiKCyRSh0Z66dybjo8vLaWKUN8WW5QeSRkD1HLaQAPUUp2F/usXd/R8n3
         5yLMLe77moCI/zs1Ye8PkcW2IYrCgfqBn/P96V7x46Zve92hybPgjC0i7WCOzDPB+x30
         7N/LrkC+xHGGvBwL5gA6keMm1AivTy+VmxVHTB969tsKOJbNBxYvoeAPWW8Lw8ZUH5Gu
         QeHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmWjA7kCXkr89iTs4+fMDWEw1rflkI2LM2RQtAvyG7myMOsKaSCmooJ+5wEBtadu5gvLLZC2oWuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyxLvKHp8h1nYZ9/jXjBxtLMojTvxQyNrRsA9EWS5MNs0Vuj7x
	IuwiL7nMjdobeARNmRABv9mt8hBylHuntu2/QIyez4hnJNaO/YB5xYNAJ2Z2f15aQAc=
X-Gm-Gg: ASbGncsWsYPf+S9+0TWTagqiqZeBhTi8KTg6E9QmRst9HpLMBEsf5mKq0q7LSJo0hEE
	EEcAJMPYXhP2WYgMLEkuTqzOduBpG4R1WQB9qOnS7OUZxDnzbhcxgc9MVS+w6X/phzEfaEt/GH9
	vg11iyE4zgFMmrNUc5QXCI1pVPDIuqGrkMPSqO0cYeg6JodLcrmPK69KmevcC6PwWQCO5D5+3cK
	uiz03TQfIWqFxHZTl7anDa03eJz4ofouP/YemFJuDe5JcMdlRhXOiWtJRtcUl4FLZ6t/UJaH/I2
	CfYC/IL+xk5DeSb3AMywuWqUVkgV+Zzb96sO66QKzUScpr1l5Ha3na/mEbA6d6XtMpbIECb9rVe
	7dKibtc4KdkjTLOAeGs56x/J9Q0xbq1F/v2DR
X-Google-Smtp-Source: AGHT+IGPH5aM5Z4YbOMg/s4pZiEhmK3ttk/WWSZNeNphwAL/3oCJAKxe81UqHvcdpBdwTW8Yth1UsA==
X-Received: by 2002:a05:6512:3ba2:b0:553:3407:eee0 with SMTP id 2adb3069b0e04-5550b860e0dmr6025596e87.4.1751370486189;
        Tue, 01 Jul 2025 04:48:06 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2f162dsm1800592e87.248.2025.07.01.04.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:48:05 -0700 (PDT)
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
	Hiago De Franco <hiago.franco@toradex.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/24] firmware: xilinx: Use of_genpd_sync_state()
Date: Tue,  1 Jul 2025 13:47:18 +0200
Message-ID: <20250701114733.636510-17-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701114733.636510-1-ulf.hansson@linaro.org>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
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
Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
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


