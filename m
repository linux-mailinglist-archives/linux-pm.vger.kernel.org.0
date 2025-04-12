Return-Path: <linux-pm+bounces-25310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D18A86C8C
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 12:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74191B65F48
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 10:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846CF18B46C;
	Sat, 12 Apr 2025 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="U+Ssw3q6"
X-Original-To: linux-pm@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E22192D97;
	Sat, 12 Apr 2025 10:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744454126; cv=none; b=Ab4SJGVEMNy5pem5gXkXeIp5hiiJaZt7KmdS9M1y9lBUzHKS8Jiq2FvLbs0332A/BXCs5CaWgjU8LG08t9MwSpBwPWw7jCiRKz34HKZyKcdXD21qjC0R6b3+N3aJ/WzXaIJf1uFf/W2r8QilQG+9+VD7/DC2MwGSvVCCFJGkzhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744454126; c=relaxed/simple;
	bh=4sW5JMTRSsvTEk9VaH8EMr1GBuNX2t5YMXRxgO9abPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+5S7lyfT+6c4+5T5+r15TgI1bVJjC8jOPu0S3K994t5On+3B60IUlH28UazoQxzO3PLPdiA7FUoCGq6H9E/hRuF0yZRtNvOgE5qWaRWTNiKD7/qg01RFRzTxtrsgvM+28BeEwPafp1Wwg1+Wc0e7prqmSZTM4yDyvpLCMEkD3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=U+Ssw3q6; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1744454118;
	bh=npFXiCkNqEjUskLtqtkmIK6sPrbA/QX7VYsHwEruji4=;
	h=From:To:Cc:Subject:Date:From;
	b=U+Ssw3q69qTi+x+JuV6tJIRrl3E43naIYieCYP9BEGyxgxHCSg0G7etHFzSlvlW8Y
	 4UczdfemEg3LL5wvjuF4QRXDpvK27IBCOzXW3LnrD/Gi5GbC1gboSiYbk8wagxd+Dd
	 MqGXAWeFa7M8daRaM0QLhQbc0Rp7lm9mz7YvRKQ4=
Received: from stargazer.. (unknown [IPv6:240e:43d:108:7db5:ca6e:8ff:fed5:b0dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 9FEC665F59;
	Sat, 12 Apr 2025 06:35:10 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH] cpufreq: intel_pstate: Use raw_smp_processor_id() in hwp_get_cpu_scaling()
Date: Sat, 12 Apr 2025 18:34:34 +0800
Message-ID: <20250412103434.5321-1-xry111@xry111.site>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use raw_smp_processor_id() instead of plain smp_processor_id() in
hwp_get_cpu_scaling(), otherwise we get some errors on a Lenovo Thinkpad
T14P Gen 2:

    BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
    caller is hwp_get_cpu_scaling+0x7f/0xc0

Fixes: b52aaeeadfac ("cpufreq: intel_pstate: Avoid SMP calls to get cpu-type")
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 4aad79d26c64..bfc20b978240 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2209,7 +2209,7 @@ static int knl_get_turbo_pstate(int cpu)
 static int hwp_get_cpu_scaling(int cpu)
 {
 	if (hybrid_scaling_factor) {
-		struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
+		struct cpuinfo_x86 *c = &cpu_data(raw_smp_processor_id());
 		u8 cpu_type = c->topo.intel_type;
 
 		/*
-- 
2.49.0


