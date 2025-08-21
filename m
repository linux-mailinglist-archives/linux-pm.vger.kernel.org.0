Return-Path: <linux-pm+bounces-32788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C50B2F334
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 11:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA383BABEF
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 09:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC942D2488;
	Thu, 21 Aug 2025 09:00:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B63233155;
	Thu, 21 Aug 2025 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766841; cv=none; b=hDpNjFH0PBgh4W04Qa5UcktQcH8k1tlfBZ/aumKvQ1Nc0KnrAgRqFnIN33CJlIF/TvCF2t+sCFWhh1s0SHeIGV/EtbPGIoQ5cncQMB7M9LcdxDhp3WPGVH6sn1XE2dy8QmyZFOCWxHwKjt9KEW+KxrXoPVa7NnpvZK00vRNEBzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766841; c=relaxed/simple;
	bh=8czEM3NXl7qw9yW8BzzlmK5NEpZLBDu2CEv4Z12+AoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=onPIaSbJ1AK1lPuh2LC0N2d7LIHliOeJ8Pa2uN0o4gOdiM2ilU2OAJ+kJioX92BnrF/pbZ0oYzILX7GOg6IFVFQMMM0MBV2sUb9IuVw3WZcMdAGrSBHCBV7dh7uDR563EGO85ZIvNK4DsGlcJU/XVX7QOfLdn9xuyL37r+yBD9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4afe0fec7e6d11f0b29709d653e92f7d-20250821
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:ced252fc-e28b-4ca5-8405-02ddb7896bef,IP:0,U
	RL:0,TC:0,Content:28,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:28
X-CID-META: VersionHash:6493067,CLOUDID:8a26086101aa5bdfd495a078b0a5bf4d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:4|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4afe0fec7e6d11f0b29709d653e92f7d-20250821
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 517812491; Thu, 21 Aug 2025 17:00:32 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 29488E008FA3;
	Thu, 21 Aug 2025 17:00:32 +0800 (CST)
X-ns-mid: postfix-68A6E030-28880776
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 95E09E008FA2;
	Thu, 21 Aug 2025 17:00:31 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v2 2/2] cpufreq: simplify setpolicy/target check in driver verification
Date: Thu, 21 Aug 2025 17:00:20 +0800
Message-Id: <20250821090020.167786-3-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250821090020.167786-1-zhangzihuan@kylinos.cn>
References: <20250821090020.167786-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently the driver verification code uses two separate conditions to
ensure that exactly one of setpolicy or target functions is provided:

    if (!has_setpolicy && !has_target)
        return -EINVAL;
    if (has_setpolicy && has_target)
        return -EINVAL;

This can be simplified into a single condition:

    if (has_setpolicy =3D=3D has_target)
        return -EINVAL;

which makes the intent clearer and avoids duplicated logic.
No functional changes intended.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 drivers/cpufreq/cpufreq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a067b5447fe8..92633ff2c4f3 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2908,6 +2908,8 @@ static int cpuhp_cpufreq_offline(unsigned int cpu)
 int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 {
 	unsigned long flags;
+	bool has_setpolicy =3D driver_data->setpolicy;
+	bool has_target =3D driver_data->target_index || driver_data->target;
 	int ret;
=20
 	if (cpufreq_disabled())
@@ -2921,10 +2923,7 @@ int cpufreq_register_driver(struct cpufreq_driver =
*driver_data)
 		return -EPROBE_DEFER;
=20
 	if (!driver_data || !driver_data->verify || !driver_data->init ||
-	    !(driver_data->setpolicy || driver_data->target_index ||
-		    driver_data->target) ||
-	     (driver_data->setpolicy && (driver_data->target_index ||
-		    driver_data->target)) ||
+	     (has_setpolicy =3D=3D has_target) ||
 	     (!driver_data->get_intermediate !=3D !driver_data->target_intermed=
iate) ||
 	     (!driver_data->online !=3D !driver_data->offline) ||
 		 (driver_data->adjust_perf && !driver_data->fast_switch))
--=20
2.25.1


