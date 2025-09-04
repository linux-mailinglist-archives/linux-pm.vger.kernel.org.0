Return-Path: <linux-pm+bounces-33781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FE4B43070
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 05:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683025E7C09
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 03:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BCA28C01E;
	Thu,  4 Sep 2025 03:22:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035BF3209;
	Thu,  4 Sep 2025 03:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756956155; cv=none; b=I4gIbA/UoE9LNronrVbrpH7nP+E+VorM3KuYo/p6t3/jOHp9tgDHp6SnbkwQVjWcddGve9sl2Ij26B7F+31kBUisL//9ZyATfdEAnr4ab1/zLDUtiUJaiQrPVxuvJxP46X+ZKeyVe+kFoUiwajJsaMppD3oT6WYCA5xoIJVWvR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756956155; c=relaxed/simple;
	bh=k0LN+wL4HRHl6TaEJ88+JUFRCRFLfXvr2BjuIXLReHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YoJjcJpV9l4vY2dohEyUmFhVcl85CTFV1nd0FHmCv6S/iBCiG67yM+B0ZOQkNkfludoUrmdljummoZamHaKRLpQ/1dzc/Ib7jXVKyjPWKq4PWAxZ+sIOwg0g/1veS2JNWSQCUJ61+Uaz7Q9YV3H0MLcuVyLbscsLGW+rsEJqPmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 609be398893e11f0b29709d653e92f7d-20250904
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:713e5fd1-bb7d-4cfc-b179-ac01170625ac,IP:0,U
	RL:0,TC:0,Content:28,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:28
X-CID-META: VersionHash:6493067,CLOUDID:1c3f862ab780cee6f3c4f534703e0f60,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:4|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 609be398893e11f0b29709d653e92f7d-20250904
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1138274889; Thu, 04 Sep 2025 11:22:25 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id B375CE008FA5;
	Thu,  4 Sep 2025 11:22:24 +0800 (CST)
X-ns-mid: postfix-68B905F0-562822608
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 148D7E008FA3;
	Thu,  4 Sep 2025 11:22:24 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "Rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Saravana Kannan <saravanak@google.com>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1 3/3] cpufreq: Make cpufreq_frequency_table_verify() internal
Date: Thu,  4 Sep 2025 11:22:10 +0800
Message-Id: <20250904032210.92978-4-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The helper cpufreq_frequency_table_verify() was previously exported and u=
sed
directly by a few cpufreq drivers. With the previous change ensuring that
cpufreq_generic_frequency_table_verify() always calls
cpufreq_verify_within_cpu_limits(), drivers no longer need to call
cpufreq_frequency_table_verify() explicitly.

Update the affected drivers (sh-cpufreq and virtual-cpufreq) to use
cpufreq_generic_frequency_table_verify() instead, and convert
cpufreq_frequency_table_verify() to a private static function inside
freq_table.c.

This reduces the exported cpufreq API surface and enforces a single, cons=
istent
entry point (cpufreq_generic_frequency_table_verify()) for drivers.

No functional changes intended.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 drivers/cpufreq/freq_table.c      | 5 +----
 drivers/cpufreq/sh-cpufreq.c      | 6 ++----
 drivers/cpufreq/virtual-cpufreq.c | 5 +----
 include/linux/cpufreq.h           | 2 --
 4 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index f4b05dcc479b..79fa65aa3859 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -64,7 +64,7 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_poli=
cy *policy)
 		return 0;
 }
=20
-int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy)
+static int cpufreq_frequency_table_verify(struct cpufreq_policy_data *po=
licy)
 {
 	struct cpufreq_frequency_table *pos, *table =3D policy->freq_table;
 	unsigned int freq, prev_smaller =3D 0;
@@ -73,8 +73,6 @@ int cpufreq_frequency_table_verify(struct cpufreq_polic=
y_data *policy)
 	pr_debug("request for verification of policy (%u - %u kHz) for cpu %u\n=
",
 					policy->min, policy->max, policy->cpu);
=20
-	cpufreq_verify_within_cpu_limits(policy);
-
 	cpufreq_for_each_valid_entry(pos, table) {
 		freq =3D pos->frequency;
=20
@@ -97,7 +95,6 @@ int cpufreq_frequency_table_verify(struct cpufreq_polic=
y_data *policy)
=20
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpufreq_frequency_table_verify);
=20
 /*
  * Generic routine to verify policy & frequency table, requires driver t=
o set
diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
index 642ddb9ea217..ee3fd1e71b90 100644
--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -90,10 +90,8 @@ static int sh_cpufreq_verify(struct cpufreq_policy_dat=
a *policy)
 {
 	struct clk *cpuclk =3D &per_cpu(sh_cpuclk, policy->cpu);
=20
-	if (policy->freq_table)
-		return cpufreq_frequency_table_verify(policy);
-
-	cpufreq_verify_within_cpu_limits(policy);
+	if (!cpufreq_generic_frequency_table_verify(policy))
+		return 0;
=20
 	policy->min =3D (clk_round_rate(cpuclk, 1) + 500) / 1000;
 	policy->max =3D (clk_round_rate(cpuclk, ~0UL) + 500) / 1000;
diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-=
cpufreq.c
index 6ffa16d239b2..2498f40cd57e 100644
--- a/drivers/cpufreq/virtual-cpufreq.c
+++ b/drivers/cpufreq/virtual-cpufreq.c
@@ -249,10 +249,7 @@ static int virt_cpufreq_offline(struct cpufreq_polic=
y *policy)
=20
 static int virt_cpufreq_verify_policy(struct cpufreq_policy_data *policy=
)
 {
-	if (policy->freq_table)
-		return cpufreq_frequency_table_verify(policy);
-
-	cpufreq_verify_within_cpu_limits(policy);
+	cpufreq_generic_frequency_table_verify(policy);
 	return 0;
 }
=20
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 40966512ea18..577f1cd723a0 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -782,8 +782,6 @@ struct cpufreq_frequency_table {
=20
 int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy);
=20
-int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy);
-
 int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *p=
olicy);
=20
 int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
--=20
2.25.1


