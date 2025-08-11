Return-Path: <linux-pm+bounces-32126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FE1B1FFC6
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 09:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0CB3A2780
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 07:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349031FAC34;
	Mon, 11 Aug 2025 07:01:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1D226ACB;
	Mon, 11 Aug 2025 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895718; cv=none; b=r/kf8YzJigQOCKMoDjYcquaPsaao1sJ+M2+cMZXYfCEQOtpDGcOVymKd27dP5cpntiFmo1G9a9UwJUvlFcP7tfBHcS3k+m+RLObW4qSL6VqPZMtk3FgrUDbM/KgKlf/OsaikHSwlW2I1Vy7kEPqdHA4fa+ejFVNfZibRLFc3cps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895718; c=relaxed/simple;
	bh=6AEPZBLXJ840Eubt8TAIQVCHSydkHWeRdZovamsUYpU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZPBY7VZW0MDbOX6nw9OoGPOIpNZFArFgQ8sf+1Mgsw8PGZ4U+2pE3v1avCqbnIYIJgU4SgBu/IA/IVBPEN+wwG+G1R9liLIS5njZ8uIbpOhiSO6aB/WYVxkhodeuNjqXKvvZbRKyOAb8YMBwWxF3iE5BLFCo1J1X5Dgm0c3AfHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>, Fushuai Wang
	<wangfushuai@baidu.com>
Subject: [PATCH] cpuidle: tegra: Use for_each_{possible|online}_cpu() instead of for_each_cpu()
Date: Mon, 11 Aug 2025 15:00:59 +0800
Message-ID: <20250811070059.4094-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc5.internal.baidu.com (172.31.3.15) To
 bjhj-exc17.internal.baidu.com (172.31.4.15)
X-FEAS-Client-IP: 172.31.4.15
X-FE-Policy-ID: 52:10:53:SYSTEM

Replace the opencoded for_each_cpu(cpu, cpu_{possilble|online}_mask) loop
with the more readable and equivalent for_each_{possilbe|online}_cpu(cpu)
macro.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 drivers/cpuidle/cpuidle-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index b203a93deac5..350b1fcceb8a 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -52,7 +52,7 @@ static void tegra_cpuidle_report_cpus_state(void)
 {
 	unsigned long cpu, lcpu, csr;
 
-	for_each_cpu(lcpu, cpu_possible_mask) {
+	for_each_possible_cpu(lcpu) {
 		cpu = cpu_logical_map(lcpu);
 		csr = flowctrl_read_cpu_csr(cpu);
 
@@ -98,7 +98,7 @@ static void tegra_cpuidle_unpark_secondary_cpus(void)
 {
 	unsigned int cpu, lcpu;
 
-	for_each_cpu(lcpu, cpu_online_mask) {
+	for_each_online_cpu(lcpu) {
 		cpu = cpu_logical_map(lcpu);
 
 		if (cpu > 0) {
-- 
2.36.1


