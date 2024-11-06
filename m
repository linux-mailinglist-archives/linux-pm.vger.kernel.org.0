Return-Path: <linux-pm+bounces-17087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BD69BF521
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 19:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A221C23B09
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 18:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83AA20898F;
	Wed,  6 Nov 2024 18:20:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C460207A2E;
	Wed,  6 Nov 2024 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730917211; cv=none; b=ibihtvHt+wi9waJ96XD/o6BuXWKOqixdtaZvlvIq00Sfgez57A9Z9iVahm9ko+dyWXh3FhBStOBlRE9r3GcsiY0Wp98gpJfnpharMB0vimrZYfs0O/b/Ncv3gUZUHvDL6k4yR6NY7aJP14o/ALbyV2EI2FrkeaRNYXXc8P91G14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730917211; c=relaxed/simple;
	bh=1V2pdvLpUnlpdAciZuSSm8AJQelPbd9SV3akI2CF4WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QowHzrcOMMD0Ir/g0CK80MqU4T65MQ3FK3w3qIFa/u1FyFKD4vYCU+bdiyQHZrcPgCZzsgw9z4sMB5TnTTupg6JB8I8P0dOIrL32ZbChpEnfdmQk8CQK/fxDd4J28AGUtdm9YHcXf1aEHXrAy0qBCkjaDiJsICq5H/GWEscRh7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id EA90224F77;
	Wed,  6 Nov 2024 21:20:05 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail04.astralinux.ru [10.177.185.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Wed,  6 Nov 2024 21:20:05 +0300 (MSK)
Received: from MBP-Anastasia.DL (unknown [10.198.46.47])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4XkD5J57xSzkWvP;
	Wed,  6 Nov 2024 21:20:04 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	lvc-project@linuxtesting.org,
	Huang Rui <ray.huang@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Yuan <perry.yuan@amd.com>
Subject: [PATCH 6.6 1/1] cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value
Date: Wed,  6 Nov 2024 21:19:58 +0300
Message-ID: <20241106182000.40167-2-abelova@astralinux.ru>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106182000.40167-1-abelova@astralinux.ru>
References: <20241106182000.40167-1-abelova@astralinux.ru>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: abelova@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 188998 [Nov 06 2024]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2024/11/06 15:41:00 #26827080
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Anastasia Belova <abelova@astralinux.ru>

commit 5493f9714e4cdaf0ee7cec15899a231400cb1a9f upstream.

cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
and return in case of error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/amd-pstate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8c16d67b98bf..0fc5495c935a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -579,9 +579,14 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	unsigned long max_perf, min_perf, des_perf,
 		      cap_perf, lowest_nonlinear_perf, max_freq;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	struct amd_cpudata *cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata;
 	unsigned int target_freq;
 
+	if (!policy)
+		return;
+
+	cpudata = policy->driver_data;
+
 	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
 		amd_pstate_update_min_max_limit(policy);
 
-- 
2.47.0


