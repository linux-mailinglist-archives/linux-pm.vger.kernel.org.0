Return-Path: <linux-pm+bounces-34670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEED3B57995
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 13:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD21E3B7056
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 11:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842702F90EA;
	Mon, 15 Sep 2025 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m7lzQF6b"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5612C376B
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937426; cv=none; b=Ho7geGcIoJhNvG4JIBY2VQDqURbuH4aTIcR4r4LObX7T4sQIiynuw5Qcu5vQQd596YUPLPkhL2dswJH/RRClSJrOHpXHDekCNJkyADwtQKjSnvcDKn5h7dLkeeG76619SlRrksww6Nu/EBWl7TP+0nD44/uvWZNDkklmAzNtJes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937426; c=relaxed/simple;
	bh=fA4MlAIn7P1pBX/89vOZIi4pnvENU8A6OalvZ9lhyUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ivFHpzhE5jAAbaFlo7fvMWeJZklRwnGx9EaJZk2NhOzwPjTPcXVKj24/2zvER4FIRHD/kqGqpkMsCW/e6SG1CEzokkjE1nDDYD3/eIfLzS2UJMM0BOILyL0AWTbXYRFrMxXcgNu1ljQldzFiZs+q5n8tU738G9ssoiuqMoKUgx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m7lzQF6b; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757937410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JVVGhrqsmL4odmIDg4NNn1VRpJaq1RD433dc/e6m7/I=;
	b=m7lzQF6bpIU0zWTJt4VYQVIVA5KoWH3Oha1hmVSrZEtMQYWjg3kW7Hm+dYfGTh8JudNVrJ
	fSL4UxEAOoeJsp2jwXemfRNXbxPh4LGp9Jdd44m4/7CLvDvRzdeGP8Nc/kJm+va1WRSJG8
	68Ts/yJrq7PM2lIdeI/peOOK5+IueG0=
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
Subject: [PATCH] PM / devfreq: tegra30: use designated initializers for tegra_actmon_emc_ratio
Date: Mon, 15 Sep 2025 13:55:55 +0200
Message-ID: <20250915115554.2150603-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Switch actmon_emc_ratios[] to the more modern and flexible designated
initializers. This improves readability and allows struct fields to be
reordered.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/devfreq/tegra30-devfreq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 4a4f0106ab9d..890990e03335 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -206,13 +206,13 @@ struct tegra_actmon_emc_ratio {
 };
 
 static const struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
-	{ 1400000,    KHZ_MAX },
-	{ 1200000,    750000 },
-	{ 1100000,    600000 },
-	{ 1000000,    500000 },
-	{  800000,    375000 },
-	{  500000,    200000 },
-	{  250000,    100000 },
+	{ .cpu_freq = 1400000, .emc_freq = KHZ_MAX },
+	{ .cpu_freq = 1200000, .emc_freq = 750000 },
+	{ .cpu_freq = 1100000, .emc_freq = 600000 },
+	{ .cpu_freq = 1000000, .emc_freq = 500000 },
+	{ .cpu_freq =  800000, .emc_freq = 375000 },
+	{ .cpu_freq =  500000, .emc_freq = 200000 },
+	{ .cpu_freq =  250000, .emc_freq = 100000 },
 };
 
 static u32 actmon_readl(struct tegra_devfreq *tegra, u32 offset)
-- 
2.51.0


