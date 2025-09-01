Return-Path: <linux-pm+bounces-33555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 662C8B3E177
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 13:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60A71A8036D
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 11:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD37C31A053;
	Mon,  1 Sep 2025 11:26:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D3225F7A5;
	Mon,  1 Sep 2025 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756725965; cv=none; b=gm8ro5pWTEdFnCPdYUvHxNezyMPx6ZFZghlCzrXrpYsBTVHtYephyMUrMAyNku5+RoplMpyp1DG2E1sjje3sCZryX+C0IeaJA2j4/+ZeM664fovYWuTuoou1F3NJ7BtM5q/8tURph0ZVnAO8SXpEhjoBBzVs0JaQQgIBz1ARZlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756725965; c=relaxed/simple;
	bh=r37GOsjOSZIAi3ilm/DVvMw2aj8a5AQR+1Ltk6zD+pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TyxqhMYt/U2rJ9fYZBoBz+70QdHERID3UUc/3RVopihqKdcdEAgPrmeadQAE53bwIlVkUc2KaeybEy0ro+R3VHjIohjClIgKIeDS+tLS9b1TACdz4+UCx86DW4gY5UJ8SQbhvChiGV4oQ6zakNyfNcZdxmE+kXU2A/+9WroXCa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6d0a4170872611f0b29709d653e92f7d-20250901
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:f72e906c-0f97-4558-aa3b-b3f507437ee9,IP:0,U
	RL:0,TC:0,Content:28,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:28
X-CID-META: VersionHash:6493067,CLOUDID:599e9bb5ca3e0e7a2d8ab39f6015c321,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:4|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6d0a4170872611f0b29709d653e92f7d-20250901
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2052718097; Mon, 01 Sep 2025 19:25:55 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 7644CE008FA4;
	Mon,  1 Sep 2025 19:25:55 +0800 (CST)
X-ns-mid: postfix-68B582C3-3435373
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id E85DDE008FA6;
	Mon,  1 Sep 2025 19:25:54 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "Rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1 1/3] cpufreq: Drop redundant freq_table parameter
Date: Mon,  1 Sep 2025 19:25:49 +0800
Message-Id: <20250901112551.35534-2-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250901112551.35534-1-zhangzihuan@kylinos.cn>
References: <20250901112551.35534-1-zhangzihuan@kylinos.cn>
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

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 drivers/cpufreq/cpufreq.c    |  2 +-
 drivers/cpufreq/freq_table.c | 14 ++++++--------
 include/linux/cpufreq.h      |  7 +++----
 3 files changed, 10 insertions(+), 13 deletions(-)

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


