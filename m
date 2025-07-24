Return-Path: <linux-pm+bounces-31363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C64B10698
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 11:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EC177B60DE
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 09:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B108C2571C2;
	Thu, 24 Jul 2025 09:36:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0AF2571A9;
	Thu, 24 Jul 2025 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349796; cv=none; b=UnK9mt9yA0p82MwowS+TjXTwGZ5EvdzgtkwCjOl0rh5+35+XOD627L+Yhz0ltrX2vpd3fDXB04cBiokPBv22HeAO6YsqoTKadbFNXy8XUEhGbVqLGeS6uJ3vVjZ3l+6Qiid4Fd8G0ZRkEMUcXPjDVplcrCL7POIe9ZD/wgLsnyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349796; c=relaxed/simple;
	bh=IeDZzNY8Lkhxxaf4jgwee3J6do3OsmJ8iaVtWkR7R/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mZVaJ51WlycgyxeiIUvoigkb/PHbEJ71f6Fgd7uRCubpz2nQU4u1T+Y9CXS2HSSgZQpOLtKWR5qnu82DfOEptG+Kh1AAi4cFDp1vbVvutyxkoLWTt7lOd4O8whSvyi4WH/TzJX754ImyYsMsO+U61Go5IcixgsgtCSjX3jl+dNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ab6c180e687111f0b29709d653e92f7d-20250724
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:34417389-8d6c-4d35-b3d9-c23a2e177b40,IP:0,U
	RL:0,TC:0,Content:18,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:18
X-CID-META: VersionHash:6493067,CLOUDID:5a8f49b782a304558edab8f448bdce11,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ab6c180e687111f0b29709d653e92f7d-20250724
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1076584789; Thu, 24 Jul 2025 17:36:26 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 4AEBEE008FAA;
	Thu, 24 Jul 2025 17:36:26 +0800 (CST)
X-ns-mid: postfix-6881FE9A-95038790
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id EDAFCE008FA2;
	Thu, 24 Jul 2025 17:36:24 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1] cpufreq: Avoid get_governor() for first policy
Date: Thu, 24 Jul 2025 17:36:21 +0800
Message-Id: <20250724093621.61871-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a cpufreq driver registers the first policy, it may attempt to
initialize the policy governor from `last_governor`. However, this is
meaningless for the first policy instance, because `last_governor` is
only updated when policies are removed (e.g. during CPU offline).

The `last_governor` mechanism is intended to restore the previously
used governor across CPU hotplug events. For the very first policy,
there is no "previous governor" to restore, so calling
get_governor(last_governor) is unnecessary and potentially confusing.

This patch skips looking up `last_governor` when registering the first
policy. Instead, it directly uses the default governor after all
governors have been registered and are available.

This avoids meaningless lookups, reduces unnecessary module reference
handling, and simplifies the initial policy path.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 drivers/cpufreq/cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d7426e1d8bdd..b5ebd4519eab 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1121,9 +1121,9 @@ static int cpufreq_init_policy(struct cpufreq_polic=
y *policy)
 	int ret;
=20
 	if (has_target()) {
-		/* Update policy governor to the one used before hotplug. */
-		gov =3D get_governor(policy->last_governor);
-		if (gov) {
+		if (policy->last_governor[0] !=3D '\0') {
+			/* Update policy governor to the one used before hotplug. */
+			gov =3D get_governor(policy->last_governor);
 			pr_debug("Restoring governor %s for cpu %d\n",
 				 gov->name, policy->cpu);
 		} else {
--=20
2.25.1


