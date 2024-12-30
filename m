Return-Path: <linux-pm+bounces-19844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3A49FE4DB
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 10:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF7D3A1D53
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 09:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C4C1A3BC0;
	Mon, 30 Dec 2024 09:32:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F421A23A9;
	Mon, 30 Dec 2024 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735551131; cv=none; b=d/DJwy+2El2Cwj6yCzD/J1F85ZMyVPTAW/d+ziPpWbZjroWlZJVzmwsfTRmPThBunEmn8jzmTZrNq4SyBNVwgwUesmO3S/GyhVF1iCpJy2D/RHGdADAJxWrdPpTlkCeX79EmzPG4EBZzX50yaj+lPZ0tz6jADzgYL+AAK/CAo4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735551131; c=relaxed/simple;
	bh=6z0eFfOZs7BdJIGqDGcwfBjGyNn+VEE09uPh+kDNBHY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RA7ApbVIzkNWPrtJLrf23RWDz2IJrHenjrEufNhVnZmN7bDhmGxdZrOOhhyahoP34N3sUsi/kTCL1r0uxKfxt1MIRjtOs0NieMgm3BPeG69L+ID7zYqQf/k+Iskx24LoU6IfPQN7EjzBH/lZBsA4hPevtyfpdpxLRIGrowFWf2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id BNL00002;
        Mon, 30 Dec 2024 17:32:02 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Dec 2024 17:32:02 +0800
Received: from localhost.localdomain (10.94.16.130) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Dec 2024 17:32:01 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>
CC: <arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] cpufreq: scpi: Prevent null pointer dereference in scpi_cpufreq_get_rate()
Date: Mon, 30 Dec 2024 17:31:59 +0800
Message-ID: <20241230093159.258813-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201615.home.langchao.com (10.100.2.15) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 20241230173202c6988a2345bca3e4352598e577134bd2
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

cpufreq_cpu_get_raw() may return NULL if the cpu is not in
policy->cpus cpu mask and it will cause null pointer dereference.
Prevent null pointer dereference in scpi_cpufreq_get_rate().

Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/cpufreq/scpi-cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index cd89c1b9832c..c888ed3a0de9 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -30,6 +30,9 @@ static struct scpi_ops *scpi_ops;
 static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
+	if (unlikely(!policy))
+		return 0;
+
 	struct scpi_data *priv = policy->driver_data;
 	unsigned long rate = clk_get_rate(priv->clk);
 
-- 
2.31.1


