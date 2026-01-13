Return-Path: <linux-pm+bounces-40763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D0DD1B1BD
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 20:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A641305372C
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 19:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35B430DEDD;
	Tue, 13 Jan 2026 19:48:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E3B2FD689;
	Tue, 13 Jan 2026 19:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768333730; cv=none; b=febZR9I/SFkkhhWA4R8wSTV2Wr8Lf8VmD0pSgCi80bAx+errxx9mFBAgBEXRjfslErGzU/6ohpIoV7sgl6wViNMXBAL/n7+/D56MOngmtf1o71byecnoZrLUnElMi+g8XcWcRIaDjUKAwcWwSEWrgEYQBb9OeRXcloeqf9lc9c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768333730; c=relaxed/simple;
	bh=TBSdy3Rr/LOCqjf4wut0AiYPYytXGCwDLIEfWM9wiBI=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=R8i1ZYlFN9RlSujDRvvRvVlaMMFHekx+a/zZDhQ06lm45YfhKJZesImwaVopyJ3wQKjYRS0aZn+7zePGvy0IOLOOAIArDb3M7w1smeJXd8DDz/po3+ByDcJ33Og28sxKVRYUlcqvzERKC78WtJ3c0soHhfO2xF3sE+58PtyfM2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (213.87.161.90) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 13 Jan
 2026 22:33:29 +0300
Message-ID: <e6c2e7af-ad87-4d38-9dbb-f9d6ae81fe83@auroraos.dev>
Date: Tue, 13 Jan 2026 22:33:30 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, <arm-scmi@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, Sergey Shtylyov
	<s.shtylyov@auroraos.dev>
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Subject: [PATCH] cpufreq: scmi: correct SCMI explanation
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

SCMI stands for System Control and Management Interface, not System Control
and Power Interface -- apparently, Sudeep Holla copied this line from his
SCPI driver and then just forgot to update the acronym explanation... :-)

Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI message protocol")
Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
---
The patch is against the cpufreq/arm/linux-next branch of Viresh Kumar's pm.git
repo...

 drivers/cpufreq/scmi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index d2a110079f5f..e0e1756180b0 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * System Control and Power Interface (SCMI) based CPUFreq Interface driver
+ * System Control and Management Interface (SCMI) based CPUFreq Interface driver
  *
  * Copyright (C) 2018-2021 ARM Ltd.
  * Sudeep Holla <sudeep.holla@arm.com>
-- 
2.52.0

