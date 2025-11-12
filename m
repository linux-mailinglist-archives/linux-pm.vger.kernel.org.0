Return-Path: <linux-pm+bounces-37860-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5143BC53CFA
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 18:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D2F64FC0D8
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 17:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EEE33F8BE;
	Wed, 12 Nov 2025 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UBRFJnus"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1D32F5463
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968113; cv=none; b=V6W8833Z3R3AxuFrPzmoTuaq6C+GOlbhI2CKvyG51EcCvFXmHFEE7+++LWdiAQg2CpZWAczWnMVR4iz0y2A+4zJ67YNPS/QvFcluRNauuXXRJd7utWpSv0WxlWFcJO7G0dLKpTfDnO0aBJanqe37fWZQMbPMFf4LiB65BZ+26Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968113; c=relaxed/simple;
	bh=N5adIYAtdFqjBajODZDFHwOrJ7rnYtok6HIzFkiZyo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8uYJwU/uX6HRC0ihoPD8opzaHcZYDWJjsL/TwFnPrh+iMH7ljXE6zzV8yH2ud0JDiOYnxJLS0+chyd8FxM9V8gYFstd8MHHK3NCyn53ELVps6pJ41N1H339KEEJuariOUXcfkMBpWKLhEIwzuPg+88ZigxO2gmhcteyv0BwhqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UBRFJnus; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762968099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jGs7Hv9KNWjSfl9ACuS3BD9nItk1f1HqEtWBU6SNvgo=;
	b=UBRFJnusMotR6GK+7LDYXvFe2NVdRm1AtZotjH2GkbguPKudCQW7xTV8MCmt5CCnYw/flw
	1/HzqeBJyMByGy0LTToYCim0PfnWjfXQGQ4x9fuwgCQ/T+G2+xVUAi4cSZs2Trijh0A6e4
	GxpLD8HxReL25xprxm6GzOAafIcFSTQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Dmitry Osipenko <digetx@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] PM / devfreq: tegra30: use min to simplify actmon_cpu_to_emc_rate
Date: Wed, 12 Nov 2025 18:21:21 +0100
Message-ID: <20251112172121.3741-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use min() to improve the readability of actmon_cpu_to_emc_rate() and
remove any unnecessary curly braces.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/devfreq/tegra30-devfreq.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 4a4f0106ab9d..2c9813bd697e 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -326,14 +327,9 @@ static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
 	unsigned int i;
 	const struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
 
-	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++) {
-		if (cpu_freq >= ratio->cpu_freq) {
-			if (ratio->emc_freq >= tegra->max_freq)
-				return tegra->max_freq;
-			else
-				return ratio->emc_freq;
-		}
-	}
+	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++)
+		if (cpu_freq >= ratio->cpu_freq)
+			return min(ratio->emc_freq, tegra->max_freq);
 
 	return 0;
 }
-- 
2.51.1


