Return-Path: <linux-pm+bounces-33610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03783B3F6C0
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 09:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C530717E244
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C2C2E6CD4;
	Tue,  2 Sep 2025 07:33:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FEF2E7178;
	Tue,  2 Sep 2025 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798417; cv=none; b=bofz9vRZc/qXtZblimJSTm1SdA2rsxxdIvoL97ruJDarx097HmhLSXpZ5QpJb2PUzss4fGOA/XQshIci5VxzwNfijFg4HQMf+lEUw7Rs7P6zWOV/rWGt5oLa220JvWniPQ+U4NSqjX6CjvjIK4lrv/NAZwJ2GEu9emA3RlJ5y54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798417; c=relaxed/simple;
	bh=5580dP+quOgESO2dD3M3qtRCy6uIFcPddRHyHcVhHHE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dVChXqu37UY+HBRSNResXZN+Ael+vsgrwEWvO+0Z0TSgxUQd1RQKq36FGFCY4P9W1Ns99VF8h/HWKNsXF+E8QAgWATOi8y86pM15VNXajVWbnL4HZD9QtkzitG16gRbegMJ7lnysjFgXRjM5GaUBbND9NsmrvBL0QRBpS32blCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1dca683e87cf11f0b29709d653e92f7d-20250902
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e10b21fd-6a3b-469f-969d-da15227fa4b9,IP:0,U
	RL:0,TC:0,Content:29,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:29
X-CID-META: VersionHash:6493067,CLOUDID:35805640255346f83b014273619186e7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:4|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1dca683e87cf11f0b29709d653e92f7d-20250902
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1656665318; Tue, 02 Sep 2025 15:33:27 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 6CE80E008FA3;
	Tue,  2 Sep 2025 15:33:27 +0800 (CST)
X-ns-mid: postfix-68B69DC7-298239399
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id A1AC6E008FA2;
	Tue,  2 Sep 2025 15:33:26 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "Rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v2] cpufreq: Drop redundant freq_table parameter
Date: Tue,  2 Sep 2025 15:33:23 +0800
Message-Id: <20250902073323.48330-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since commit e0b3165ba521 ("cpufreq: add 'freq_table' in struct
cpufreq_policy"),
freq_table has been stored in struct cpufreq_policy instead of being
maintained separately.

However, several helpers in freq_table.c still take both policy and
freq_table as parameters, even though policy->freq_table can always be
used. This leads to redundant function arguments and increases the chance
of inconsistencies.

This patch removes the unnecessary freq_table argument from these functio=
ns
and updates their callers to only pass policy. This makes the code simple=
r,
more consistent, and avoids duplication.

V2:
 - Merge three patches into one to fix compile error
 - simple the check suggested by Viresh Kumar

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 drivers/cpufreq/cpufreq.c         |  2 +-
 drivers/cpufreq/freq_table.c      | 14 ++++++--------
 drivers/cpufreq/sh-cpufreq.c      |  6 ++----
 drivers/cpufreq/virtual-cpufreq.c |  2 +-
 include/linux/cpufreq.h           |  7 +++----
 5 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fc7eace8b65b..76ef82d75ba2 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2792,7 +2792,7 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *pol=
icy, int state)
 	if (!policy->freq_table)
 		return -ENXIO;
=20
-	ret =3D cpufreq_frequency_table_cpuinfo(policy, policy->freq_table);
+	ret =3D cpufreq_frequency_table_cpuinfo(policy);
 	if (ret) {
 		pr_err("%s: Policy frequency update failed\n", __func__);
 		return ret;
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 35de513af6c9..d5111ee56e38 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -28,10 +28,9 @@ static bool policy_has_boost_freq(struct cpufreq_polic=
y *policy)
 	return false;
 }
=20
-int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
-				    struct cpufreq_frequency_table *table)
+int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
 {
-	struct cpufreq_frequency_table *pos;
+	struct cpufreq_frequency_table *pos, *table =3D policy->freq_table;
 	unsigned int min_freq =3D ~0;
 	unsigned int max_freq =3D 0;
 	unsigned int freq;
@@ -65,10 +64,9 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_pol=
icy *policy,
 		return 0;
 }
=20
-int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy,
-				   struct cpufreq_frequency_table *table)
+int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy)
 {
-	struct cpufreq_frequency_table *pos;
+	struct cpufreq_frequency_table *pos, *table =3D policy->freq_table;
 	unsigned int freq, prev_smaller =3D 0;
 	bool found =3D false;
=20
@@ -110,7 +108,7 @@ int cpufreq_generic_frequency_table_verify(struct cpu=
freq_policy_data *policy)
 	if (!policy->freq_table)
 		return -ENODEV;
=20
-	return cpufreq_frequency_table_verify(policy, policy->freq_table);
+	return cpufreq_frequency_table_verify(policy);
 }
 EXPORT_SYMBOL_GPL(cpufreq_generic_frequency_table_verify);
=20
@@ -354,7 +352,7 @@ int cpufreq_table_validate_and_sort(struct cpufreq_po=
licy *policy)
 		return 0;
 	}
=20
-	ret =3D cpufreq_frequency_table_cpuinfo(policy, policy->freq_table);
+	ret =3D cpufreq_frequency_table_cpuinfo(policy);
 	if (ret)
 		return ret;
=20
diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
index 9c0b01e00508..642ddb9ea217 100644
--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -89,11 +89,9 @@ static int sh_cpufreq_target(struct cpufreq_policy *po=
licy,
 static int sh_cpufreq_verify(struct cpufreq_policy_data *policy)
 {
 	struct clk *cpuclk =3D &per_cpu(sh_cpuclk, policy->cpu);
-	struct cpufreq_frequency_table *freq_table;
=20
-	freq_table =3D cpuclk->nr_freqs ? cpuclk->freq_table : NULL;
-	if (freq_table)
-		return cpufreq_frequency_table_verify(policy, freq_table);
+	if (policy->freq_table)
+		return cpufreq_frequency_table_verify(policy);
=20
 	cpufreq_verify_within_cpu_limits(policy);
=20
diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-=
cpufreq.c
index 7dd1b0c263c7..6ffa16d239b2 100644
--- a/drivers/cpufreq/virtual-cpufreq.c
+++ b/drivers/cpufreq/virtual-cpufreq.c
@@ -250,7 +250,7 @@ static int virt_cpufreq_offline(struct cpufreq_policy=
 *policy)
 static int virt_cpufreq_verify_policy(struct cpufreq_policy_data *policy=
)
 {
 	if (policy->freq_table)
-		return cpufreq_frequency_table_verify(policy, policy->freq_table);
+		return cpufreq_frequency_table_verify(policy);
=20
 	cpufreq_verify_within_cpu_limits(policy);
 	return 0;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 95f3807c8c55..40966512ea18 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -780,11 +780,10 @@ struct cpufreq_frequency_table {
 		else
=20
=20
-int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
-				    struct cpufreq_frequency_table *table);
+int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy);
+
+int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy);
=20
-int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy,
-				   struct cpufreq_frequency_table *table);
 int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *p=
olicy);
=20
 int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
--=20
2.25.1


