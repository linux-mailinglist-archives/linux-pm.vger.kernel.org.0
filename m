Return-Path: <linux-pm+bounces-24997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EEFA82173
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 11:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510D68A6B25
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 09:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1071125D52F;
	Wed,  9 Apr 2025 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="uQDWmYB2"
X-Original-To: linux-pm@vger.kernel.org
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38AE25D206;
	Wed,  9 Apr 2025 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744192611; cv=none; b=ahxXmXz/BiLt6e1ZsHNjpk8bzE+nw/Mn2G2esz/XIss18376S7b137tpQ+1QQ6eOIamr9BBsgzwTisnQetztpTQ+RCiHRTt742/rWuwYeIt3wFvsXUlXx6AQGVTqT0bGhhNp4gvBnXhlzuWgkldLbk3aJcSSf/GextZb3L5HMZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744192611; c=relaxed/simple;
	bh=wK1y6dHPy4sbGssX93eGO5NCjBNTcZms0HLXlXqdmeM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jtv11MKwsNwKkb1Sa+YJd6JoRktsBib6m3n5wpwSfWzjAQ/OnaKGvbZvj49SBD8LvsvGMzmgDWOVg1M+b/Oqeteqpl0JItVyMyRhzLJPv4qncfBstTlz+dwYsaAcqT6rmZG1L+21Iv9reO3JJkc7OO2WSGEPQbxANKNOCgVNLAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=uQDWmYB2; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744192304; bh=7Y4Q2wgqKIpLG/t08yDgQVZzMfyRABq6eyXLD9OhCis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uQDWmYB2tfWuwCCZsRlCVj4aTl+da6p3nlEofHUzzk2CrS7ds5gks04Q65pcDUDhy
	 WiELwRIPqxWSQKPxjSIxazBDaoe4Yunoz6qlArOBVaMyRTXkCvv/dMRr1VKhbIHvLM
	 ejc+Co1WifnhhvkJSDBvmB+KeJPJpjtLyq13WPkg=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id CEB04603; Wed, 09 Apr 2025 17:51:43 +0800
X-QQ-mid: xmsmtpt1744192303tvp8i7h6x
Message-ID: <tencent_C797B88F7509E18C70E48CD99275BAFD1E0A@qq.com>
X-QQ-XMAILINFO: Mg/13mbJq/Ru6Y7pf9rnxlFchTWPyEfj/S7AIffDwpj/H3SURotqVEM0ta4n4o
	 ZtdnahsYqyYJQJPtQtsf81LRHSRFKgO2Dj+sVSh+karuWL2kVQXDdRZimbIHkMVWraPzcPTx2Qil
	 bdVQrfGSrwza+eTwNvLP1jJDB4Tey/GJLKkspk6YU6lysjskwbb1ECNP8w2q0B/zDqgbfcPYFVOP
	 7trh+3dEOe+rgNoSllQOJJa5su2sWN8qCxUT649mCf/irsowHNNatTcMm6hLWJSrpO675SZ/2Lnd
	 uMlAY8/bcxY+u1lzb5pkgMbjDu15Dx+NLmejAxHB7fSuA+5xdX2ODVHdendZ1plUrQMgnl29808H
	 prWJUXBecvGmi+QuOjMnbD2l2bE/VP0nMAWsdW5hJVBYvwG72nAOCi38Zx8bz0bybIMPBkPsmpHZ
	 UNIMAz7UuojB80IptKuedAcJ6zfBoazA6qYuooGVsWGQNypi3lU4GJF0Hqn3TdUN0xxZsVrW4Cvg
	 PLodkWCUJcfWvY9SGZoNKXnzgU9C5xPX7JFZFOp5ee6bmEiCP4gFvBbkKQkzyAUrt1vNvbXQZKZK
	 RXJIVg48NkltijSl2RzHvDNPeu+SfPw3cpRpMC+SjDV4vXvAVEFK839Kn9arNEWXaFQqyL269wj8
	 0Nf9dqjRc4dF3REMRGWJ3Mf0LCLlX8IAJLWDKg6JyqMrVQpQQgcNTAH6z1QHcFdJw4HHFSapvlVb
	 XYBv4mLYfL5voJivFH1bf2lxe/OW+533BNTsUbmYm8Mdp+V7GV2k2blvRNcbPni9dMIGijuLf3+c
	 V46QHZ5SsduccyktGbi0FBjLKtbk9smm7fjdMKgetkfxCGMzh6VFejEbTm8wdZQsH+i1FLKKPAEW
	 PF5Q4jVOdImlujCKr6hicre872nrZZWU6oyfyJ4GTa0+SGSuo0vhDb32ZjOcf65WJpULIEipUEsi
	 KY7zC6agAZI08t5lH3oN06jxYC+TdVWCfdzqwdGttuMTx/Jf1xx+aoc9fiQJJS0dz358MXu/0OXP
	 tlNFIBXw==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Yaxiong Tian <iambestgod@qq.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	Pierre.Gondois@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 1/2] cpufreq: cppc: Update and opt comment for cost calculation method
Date: Wed,  9 Apr 2025 17:51:41 +0800
X-OQ-MSGID: <20250409095141.1691685-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_D6C4728C5C687C042BA7C156B0F3ECF7AE05@qq.com>
References: <tencent_D6C4728C5C687C042BA7C156B0F3ECF7AE05@qq.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

commit <1b600da510735a> ("PM: EM: Optimize em_cpu_energy() and remove division")
updated the energy calculation method, so the original comment needs to be updated
and opt.

Signed-off-by: Yaxiong Tian  <tianyaxiong@kylinos.cn>
---
 drivers/cpufreq/cppc_cpufreq.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index b3d74f9adcf0..756034b21682 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -379,9 +379,18 @@ static unsigned int get_perf_level_count(struct cpufreq_policy *policy)
 	return 1 + max_cap / CPPC_EM_CAP_STEP - min_cap / CPPC_EM_CAP_STEP;
 }
 
-/*
- * The cost is defined as:
- *   cost = power * max_frequency / frequency
+/**
+ * compute_cost - Calculate the cost for a given CPU and performance level step
+ * @cpu:  Target CPU
+ * @step: Performance level step
+ *
+ * CPPC uses a linear cost model since it only provides relative efficiency ratios:
+ *   Base cost (per CPU):    CPPC_EM_COST_GAP * efficiency_class
+ *   Step cost (per level):  step * CPPC_EM_COST_STEP
+ *
+ * Lower cost implies higher efficiency. The model ensures:
+ *   1. Higher efficiency CPUs (low efficiency_class) always have lower cost.
+ *   2. Higher performance levels (larger step) linearly increase cost.
  */
 static inline unsigned long compute_cost(int cpu, int step)
 {
-- 
2.25.1


