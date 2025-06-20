Return-Path: <linux-pm+bounces-29160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BC6AE19CD
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 13:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6914A3B543E
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 11:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB6828A419;
	Fri, 20 Jun 2025 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGab8+3s"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ACA28A409;
	Fri, 20 Jun 2025 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750418104; cv=none; b=qy6KCgL9JbKUxZkfmwLAJalt9oTF2iIpsToLLNIl6DdKGb/xvhtguu7toj/zlZnFP+sbFVelDHzp87grvqSVrbiy+KYHGDexM8G00jUqOVViqrRCfSBf1VurlgqMcT3ErE1mk7iVwTEqQbd55mGpmVFAF/8PGXcdSpVbCNwB6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750418104; c=relaxed/simple;
	bh=fHGPT6U5lkOL40pG3L6uGrMxMnoD5rKHLmnMjGJM4HY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hkX5sgu3geEGQGkKjKw+irTizaX02IMjz7Z7HsaQ2qq4aS567urX49KIORy9NfvZlVQuvbou6aVF16NmFyWqVTYHUksaGt2fn2sTGENLfoyLeAYWLYH37rGFewbVYG2eu0T148wuz2A5hKeJEQfChkjC4x9LP9qUKxtAZ3siaHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGab8+3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B40FC4CEE3;
	Fri, 20 Jun 2025 11:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750418103;
	bh=fHGPT6U5lkOL40pG3L6uGrMxMnoD5rKHLmnMjGJM4HY=;
	h=From:To:Cc:Subject:Date:From;
	b=uGab8+3sBVTk65V/vppELrITzxhLlKqt/PCYK2f5nMEGtMUyW+WIkJqwPgnLVFOyD
	 0fOKKPXlQl2KqwX26lksY/qNWuHp64d58okXUTeKO05KvGbmxfxtujqIg7djsQItzi
	 X/UCt4M8DmP71vRTg/TgUNm3J0KZ/Ha5+XWyfIdRrErxW4igRLUx073rB392UUO+Q7
	 BqLkXJWXWW8bkrS+QlHFwcj25XZECy2qpTtzvpB8exo60fWc736uctEizzutPd5tvj
	 DNmipNK8nm9LkGqS4yzR1xjYBgdOqe4pWSX9mdNFpOYuTbW/3q2qerphMxmEB3CxcZ
	 khkyzLPXi98Ew==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jacky Bai <ping.bai@nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: armada-8k: make both cpu masks static
Date: Fri, 20 Jun 2025 13:14:53 +0200
Message-Id: <20250620111459.3366195-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

An earlier patch marked one of the two CPU masks as 'static' to reduce stack
usage, but if CONFIG_NR_CPUS is large enough, the function still produces
a warning for compile testing:

drivers/cpufreq/armada-8k-cpufreq.c: In function 'armada_8k_cpufreq_init':
drivers/cpufreq/armada-8k-cpufreq.c:203:1: error: the frame size of 1416 bytes is larger than 1408 bytes [-Werror=frame-larger-than=]

Normally this should be done using alloc_cpumask_var(), but since the
driver already has a static mask and the probe function is not called
concurrently, use the same trick for both.

Fixes: 1ffec650d07f ("cpufreq: armada-8k: Avoid excessive stack usage")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/armada-8k-cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
index 5a3545bd0d8d..006f4c554dd7 100644
--- a/drivers/cpufreq/armada-8k-cpufreq.c
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -132,7 +132,7 @@ static int __init armada_8k_cpufreq_init(void)
 	int ret = 0, opps_index = 0, cpu, nb_cpus;
 	struct freq_table *freq_tables;
 	struct device_node *node;
-	static struct cpumask cpus;
+	static struct cpumask cpus, shared_cpus;
 
 	node = of_find_matching_node_and_match(NULL, armada_8k_cpufreq_of_match,
 					       NULL);
@@ -154,7 +154,6 @@ static int __init armada_8k_cpufreq_init(void)
 	 * divisions of it).
 	 */
 	for_each_cpu(cpu, &cpus) {
-		struct cpumask shared_cpus;
 		struct device *cpu_dev;
 		struct clk *clk;
 
-- 
2.39.5


