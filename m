Return-Path: <linux-pm+bounces-35716-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F95BB9C90
	for <lists+linux-pm@lfdr.de>; Sun, 05 Oct 2025 21:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24541890ABC
	for <lists+linux-pm@lfdr.de>; Sun,  5 Oct 2025 19:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DA91D63C2;
	Sun,  5 Oct 2025 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b="gzwfupRk"
X-Original-To: linux-pm@vger.kernel.org
Received: from cse.ust.hk (cssvr7.cse.ust.hk [143.89.41.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB001A9FB7
	for <linux-pm@vger.kernel.org>; Sun,  5 Oct 2025 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=143.89.41.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759692761; cv=pass; b=PFDKH1DjgFKqZmbQ2dsBOKfcveO8J83rpF2wsFKKbKgVRLK7yNKO/IQ1WZg11nNL3mokzzEyJoRuAweYS26Zd6TR3M7MjkmXkBNVhkxCdOJFnL4dHO1KS7rOprHAThiInacV1/BCJHvlEGSKyz8SoBnJkydD28NC/QsmmsX1qug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759692761; c=relaxed/simple;
	bh=dWMlvcTUcdWIMPDMvLSL4ja1WzYg/f7xE+VuVo1u1uk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C3d+gJjmogDLtZPj7vSuR4Mu9mIQSNWkGUzk2slojbP3rOOpRtO3ish9VFegGAJU0vgghlV3TOzEWGVeUoGpuBOEP56nsoP0g+pIjGVwo+l2iFVUhqNsrtqvNPYWxc2VIjOOXGBhUa69+5FVQE0dXmZ0fYn7bAXXHfrfsG9CQXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk; spf=pass smtp.mailfrom=cse.ust.hk; dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b=gzwfupRk; arc=pass smtp.client-ip=143.89.41.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.ust.hk
Received: from homelab ([58.82.196.128])
	(authenticated bits=0)
	by cse.ust.hk (8.18.1/8.12.5) with ESMTPSA id 595JVMve1489727
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 6 Oct 2025 03:31:29 +0800
ARC-Seal: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse; t=1759692689; cv=none;
	b=iUDGMQsohSFIpgDPmULqJeoiFwYAIRjrUlnMgqvRxFiwm2XZL2P6UnLdblClHkN5rmC2i+fROVcjTVNjQrE2Qxnv3uGJVgWXJq1kAdO8aa6TyQfMsLKrgCp33ih1Aad1zDaP4KzTWXDik5WY0q/A8+SyE5AA3Z8LRlt1UbnibyA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse;
	t=1759692689; c=relaxed/relaxed;
	bh=0wcSvbdNGgWcP52EV7fjh4f9vXQFwnt3v62Btpojfco=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=jD5xUIsgsY6mfUvp/hMR0k58WMr/aFKFTsOkDHybq0FK14MjcHGdoSqyCRmRyMg58N+f5gkinM7pqw2mLEEr0wkXT/UzZaOOXYU1BYCwi5STsYwD8yr833jbZ7lhUJNXCtpzL2eBPoBtUkyCrsAN7ruf10epqFGnBat7Ow6sjZU=
ARC-Authentication-Results: i=1; cse.ust.hk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
	s=cseusthk; t=1759692689;
	bh=0wcSvbdNGgWcP52EV7fjh4f9vXQFwnt3v62Btpojfco=;
	h=Date:From:To:Cc:Subject:From;
	b=gzwfupRk+Bg9csLM/0jHEntriSYZ/mG0x7Eq85L3Et64H0W5DzwtDabkBzms+WoZa
	 nCEJMYk+dMirp8ZLVK0mFv5z5378Bb4RGUtWYbDeXiznTJyqSo/m266zFHhK7tSYK+
	 LiobuK/P/AF050cwYZxviEd7kHEalqTMb4YbXfmo=
Date: Mon, 6 Oct 2025 03:31:17 +0800
From: Shuhao Fu <sfual@cse.ust.hk>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: s5pv210: fix refcount leak
Message-ID: <aOLHhZNWnPY03Jqe@homelab>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Env-From: sfual

In function `s5pv210_cpu_init`, a possible refcount inconsistency has
been identified, causing a resource leak.

Why it is a bug:
1. For every clk_get, there should be a matching clk_put on every
successive error handling path.
2. After calling `clk_get(dmc1_clk)`, variable `dmc1_clk` will not be
freed even if any error happens.

How it is fixed: For every failed path, an extra goto label is added to
ensure `dmc1_clk` will be freed regardlessly.

Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 4215621de..ba8a1c964 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -518,7 +518,7 @@ static int s5pv210_cpu_init(struct cpufreq_policy *policy)
 
 	if (policy->cpu != 0) {
 		ret = -EINVAL;
-		goto out_dmc1;
+		goto out;
 	}
 
 	/*
@@ -530,7 +530,7 @@ static int s5pv210_cpu_init(struct cpufreq_policy *policy)
 	if ((mem_type != LPDDR) && (mem_type != LPDDR2)) {
 		pr_err("CPUFreq doesn't support this memory type\n");
 		ret = -EINVAL;
-		goto out_dmc1;
+		goto out;
 	}
 
 	/* Find current refresh counter and frequency each DMC */
@@ -544,6 +544,8 @@ static int s5pv210_cpu_init(struct cpufreq_policy *policy)
 	cpufreq_generic_init(policy, s5pv210_freq_table, 40000);
 	return 0;
 
+out:
+	clk_put(dmc1_clk);
 out_dmc1:
 	clk_put(dmc0_clk);
 out_dmc0:
-- 
2.39.5


