Return-Path: <linux-pm+bounces-31412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FF5B11756
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 06:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45F41CC38E8
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 04:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933EE23C4F2;
	Fri, 25 Jul 2025 04:15:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBA72376FD;
	Fri, 25 Jul 2025 04:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753416906; cv=none; b=ETyY4Y5n7iOvEZBjoFEy06PmaQk5qSDVnihw4aJH7umqP8eIcXJ9WfYLN309i8Edw8yw5jirPZtg+vAGGjhHKsBGSsLzsOlR+ZiQtxjW8GdHt3U+8QTzpskRZ+dGtTdT3c71Z1U01bzjlL1ieYldjgKOifqI46I1VL3m9HWqrCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753416906; c=relaxed/simple;
	bh=G1ZRIhwsDY/i2THgnj9UW52wTj+jsb2hqWUHpwFEffI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=POjFBsN+PqLrLgHCIU4GZpTMev+cV4uIf1g9LGO7AlBnbxHDbsn29q+3lJUGMLsangdOITctnHGlVdw0IqPE1JRfStwH693O04iV/bsa5DABBUOYJfg1TLmEmYiMAIrt14aOD1BWOdxanQemL7nUUVnt2yYnYhWyQZHQ3dZwdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: eac4a9b6690d11f0b29709d653e92f7d-20250725
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:ee36c781-47fb-4fe5-9ee1-75c8a63a48d0,IP:0,U
	RL:0,TC:0,Content:17,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:17
X-CID-META: VersionHash:6493067,CLOUDID:adc5edde5a777f37626b98d417e1adbd,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eac4a9b6690d11f0b29709d653e92f7d-20250725
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1868079376; Fri, 25 Jul 2025 12:14:54 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 0DEF4E008FA3;
	Fri, 25 Jul 2025 12:14:54 +0800 (CST)
X-ns-mid: postfix-688304BD-8455324
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 0C9D7E008FA2;
	Fri, 25 Jul 2025 12:14:52 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v2] cpufreq: Avoid get_governor() for first policy
Date: Fri, 25 Jul 2025 12:14:50 +0800
Message-Id: <20250725041450.68754-1-zhangzihuan@kylinos.cn>
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
Changes in v2:
 - Fix the case where the governor is NULL.
---
---
 drivers/cpufreq/cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d7426e1d8bdd..1aa559f53479 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1122,7 +1122,8 @@ static int cpufreq_init_policy(struct cpufreq_polic=
y *policy)
=20
 	if (has_target()) {
 		/* Update policy governor to the one used before hotplug. */
-		gov =3D get_governor(policy->last_governor);
+		if (policy->last_governor[0] !=3D '\0')
+			gov =3D get_governor(policy->last_governor);
 		if (gov) {
 			pr_debug("Restoring governor %s for cpu %d\n",
 				 gov->name, policy->cpu);
--=20
2.25.1


