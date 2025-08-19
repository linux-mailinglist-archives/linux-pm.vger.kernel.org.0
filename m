Return-Path: <linux-pm+bounces-32620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B00B2BF22
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 12:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D72D4E30B1
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 10:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ED4322C91;
	Tue, 19 Aug 2025 10:40:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B86320CC1;
	Tue, 19 Aug 2025 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600005; cv=none; b=UQkZXTG3RkFXUMxfxNK9E75fpx3vZJE7OIYRETU2UAwVo6r9/AZl1+NJILYqlFlB1vBfglMzf9RQxekqv8Fx3D7PF4P6oBQ8DYRbh1AlyheJxXQPktuU9P2yK6bMEpsFEz7zkZ9ZTnbNEbEmbzvKpHM9SN+Ol5SP+yiYgrWcrbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600005; c=relaxed/simple;
	bh=PQ5VQxZxW8sWP8imtZF61Qy79U39gK3C8yjFaMQ5kxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Up6uaULlpw/3Ncr0prI5IrxEUsUr0Vz/kVxg8HDfOJPKgQxXdeSCvUgjAurb3o4V6OJlob4Q6EDwg8w5PemF5e+NU2ZHsWf2/5jNfbfJ4izZJzrzQN28Zg8YLA1q9C99/okGwo5DHT/PhMbkAo6KouWKGEZPgFfqRd8VaxeGpSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d485ddf27ce811f0b29709d653e92f7d-20250819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:45d05ed7-4863-4851-ade1-928862c37bda,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:dabda052eb454d3b774f56c30ae4700e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d485ddf27ce811f0b29709d653e92f7d-20250819
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1738701772; Tue, 19 Aug 2025 18:39:48 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 8AA49E008FA3;
	Tue, 19 Aug 2025 18:39:48 +0800 (CST)
X-ns-mid: postfix-68A45474-44094921
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 09948E008FA2;
	Tue, 19 Aug 2025 18:39:47 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH 2/2] cpufreq: simplify cpufreq_set_policy() interface
Date: Tue, 19 Aug 2025 18:39:40 +0800
Message-Id: <20250819103940.342774-3-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250819103940.342774-1-zhangzihuan@kylinos.cn>
References: <20250819103940.342774-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current cpufreq_set_policy() takes three arguments, including
new_pol. However, new_pol is only meaningful when a driver provides
the ->setpolicy callback. Most cpufreq drivers (e.g. ACPI) do not
implement this callback, so the extra parameter is unused.

Passing new_pol in such cases is unnecessary and may mislead readers
into thinking it has a functional effect, while in reality it is only
relevant for a very limited set of drivers.

Simplify the interface by removing the redundant argument and letting
drivers that implement ->setpolicy rely directly on
policy->policy. This reduces parameter passing overhead and makes the
API clearer.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 drivers/cpufreq/cpufreq.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a067b5447fe8..ea4a5d3f786c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -85,8 +85,7 @@ static int cpufreq_init_governor(struct cpufreq_policy =
*policy);
 static void cpufreq_exit_governor(struct cpufreq_policy *policy);
 static void cpufreq_governor_limits(struct cpufreq_policy *policy);
 static int cpufreq_set_policy(struct cpufreq_policy *policy,
-			      struct cpufreq_governor *new_gov,
-			      unsigned int new_pol);
+			      struct cpufreq_governor *new_gov);
 static bool cpufreq_boost_supported(void);
 static int cpufreq_boost_trigger_state(int state);
=20
@@ -822,7 +821,8 @@ static ssize_t store_scaling_governor(struct cpufreq_=
policy *policy,
 		if (!new_pol)
 			return -EINVAL;
=20
-		ret =3D cpufreq_set_policy(policy, NULL, new_pol);
+		policy->policy =3D new_pol;
+		ret =3D cpufreq_set_policy(policy, NULL);
 	} else {
 		struct cpufreq_governor *new_gov;
=20
@@ -830,8 +830,8 @@ static ssize_t store_scaling_governor(struct cpufreq_=
policy *policy,
 		if (!new_gov)
 			return -EINVAL;
=20
-		ret =3D cpufreq_set_policy(policy, new_gov,
-					 CPUFREQ_POLICY_UNKNOWN);
+		policy->policy =3D CPUFREQ_POLICY_UNKNOWN;
+		ret =3D cpufreq_set_policy(policy, new_gov);
=20
 		module_put(new_gov->owner);
 	}
@@ -1154,7 +1154,8 @@ static int cpufreq_init_policy(struct cpufreq_polic=
y *policy)
 			return -ENODATA;
 	}
=20
-	ret =3D cpufreq_set_policy(policy, gov, pol);
+	policy->policy =3D pol;
+	ret =3D cpufreq_set_policy(policy, gov);
 	if (gov)
 		module_put(gov->owner);
=20
@@ -1190,7 +1191,7 @@ void refresh_frequency_limits(struct cpufreq_policy=
 *policy)
 	if (!policy_is_inactive(policy)) {
 		pr_debug("updating policy for CPU %u\n", policy->cpu);
=20
-		cpufreq_set_policy(policy, policy->governor, policy->policy);
+		cpufreq_set_policy(policy, policy->governor);
 	}
 }
 EXPORT_SYMBOL(refresh_frequency_limits);
@@ -2610,7 +2611,6 @@ static void cpufreq_update_pressure(struct cpufreq_=
policy *policy)
  * cpufreq_set_policy - Modify cpufreq policy parameters.
  * @policy: Policy object to modify.
  * @new_gov: Policy governor pointer.
- * @new_pol: Policy value (for drivers with built-in governors).
  *
  * Invoke the cpufreq driver's ->verify() callback to sanity-check the f=
requency
  * limits to be set for the policy, update @policy with the verified lim=
its
@@ -2622,8 +2622,7 @@ static void cpufreq_update_pressure(struct cpufreq_=
policy *policy)
  * The cpuinfo part of @policy is not updated by this function.
  */
 static int cpufreq_set_policy(struct cpufreq_policy *policy,
-			      struct cpufreq_governor *new_gov,
-			      unsigned int new_pol)
+			      struct cpufreq_governor *new_gov)
 {
 	struct cpufreq_policy_data new_data;
 	struct cpufreq_governor *old_gov;
@@ -2676,7 +2675,6 @@ static int cpufreq_set_policy(struct cpufreq_policy=
 *policy,
 		 policy->min, policy->max);
=20
 	if (cpufreq_driver->setpolicy) {
-		policy->policy =3D new_pol;
 		pr_debug("setting range\n");
 		return cpufreq_driver->setpolicy(policy);
 	}
--=20
2.25.1


