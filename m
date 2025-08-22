Return-Path: <linux-pm+bounces-32891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A09DB30FD6
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 09:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 298727BE7D3
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 07:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689B92E7BB3;
	Fri, 22 Aug 2025 07:04:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228BE22DA1F;
	Fri, 22 Aug 2025 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755846281; cv=none; b=SUWamQ5HyZxwDb8XFj5bZSnJlHrZoTaOFvxZuiHXyaDbO9DhsiL1lfhIf4vz5I4+Uevpj87W6b4hPClc5vrk/hBNDEsecewp5xidZF3Ys6xq+uppIzpmts8ssowbDqD6VUind262eaQC/lr4qEB/GPRlPUvIXD5YV4nXLN7GiCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755846281; c=relaxed/simple;
	bh=QccKFjC6p+v4nhzXdEjhMTUUbcRpkIbHN6EQp8KENSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IyQTPsyH8gz06vVFz6qTOBVX9U3GJAF0zxDMZ8RkzVbaAd3ksTfgX9WNINnnteTq08PZAGAeS7tHAp0S9Qg3FDZDd2bankQD7OX+TLRcWqf2imZ1/drL6/9l5P2bwKP8jQKQkTG50wQVxPw0SmvYB/InX8qquKHSr9SZ86NM+4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 404f29d27f2611f0b29709d653e92f7d-20250822
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:2e4a5d48-572d-4e21-bb50-8c64f101136d,IP:0,U
	RL:0,TC:0,Content:30,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:6493067,CLOUDID:87a5bc6b6d0ce16c213a0961aea888e8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:4|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 404f29d27f2611f0b29709d653e92f7d-20250822
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2023650233; Fri, 22 Aug 2025 15:04:31 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 20838E008FA4;
	Fri, 22 Aug 2025 15:04:31 +0800 (CST)
X-ns-mid: postfix-68A8167E-990336308
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 8A9A1E008FA2;
	Fri, 22 Aug 2025 15:04:30 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v3 2/2] cpufreq: simplify setpolicy/target check in driver verification
Date: Fri, 22 Aug 2025 15:04:24 +0800
Message-Id: <20250822070424.166795-3-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250822070424.166795-1-zhangzihuan@kylinos.cn>
References: <20250822070424.166795-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Cpufreq drivers are supposed to use either ->setpolicy or
->target/->target_index. This patch simplifies the existing check by
collapsing it into a single boolean expression:

    (!!driver->setpolicy =3D=3D (driver->target_index || driver->target))

This is a readability/maintainability cleanup and keeps the semantics
unchanged.

No functional change intended.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 drivers/cpufreq/cpufreq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a067b5447fe8..633be16297d6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2921,10 +2921,7 @@ int cpufreq_register_driver(struct cpufreq_driver =
*driver_data)
 		return -EPROBE_DEFER;
=20
 	if (!driver_data || !driver_data->verify || !driver_data->init ||
-	    !(driver_data->setpolicy || driver_data->target_index ||
-		    driver_data->target) ||
-	     (driver_data->setpolicy && (driver_data->target_index ||
-		    driver_data->target)) ||
+	     (!!driver_data->setpolicy =3D=3D (driver_data->target_index || dri=
ver_data->target)) ||
 	     (!driver_data->get_intermediate !=3D !driver_data->target_intermed=
iate) ||
 	     (!driver_data->online !=3D !driver_data->offline) ||
 		 (driver_data->adjust_perf && !driver_data->fast_switch))
--=20
2.25.1


