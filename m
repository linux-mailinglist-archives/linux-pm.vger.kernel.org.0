Return-Path: <linux-pm+bounces-33556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1A0B3E17C
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 13:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 387B87A0356
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 11:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A8431AF0A;
	Mon,  1 Sep 2025 11:26:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352053148B8;
	Mon,  1 Sep 2025 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756725966; cv=none; b=n0TJWqWVLXRKCxv5pHWWdQt6bhOGuAUTG+IunJT4iMXtP8U493WYGwc4ikQYXeH/wXAC86ymEqbrYwu4FRqrP26UDrh/uCTb1lP9F9FPwoB0czOUWN+FdDadddyBPy2MUR2u6NLq9LuB9Z8GyniybmiTgYAhV8FR5HhJD8s1IBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756725966; c=relaxed/simple;
	bh=BXFrM7sEC9cmcb2ejUW+WWFUfN19B5lAYhKHK8zPRGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G5G0LceAj5SAuSxnvbGdKG+NcvctvhqYP9N1axoA1jgajKsy1yeZ1w4dlgcIlODnvJYxAr2tz7MBL6J6iCPppnAxlevCzuCjojFn+FCqjEeIF+eQi8VD0ThDG0c/fO8HT07nhZcFTSy/iZAMGJ+eFKsZh4HrgAbyuTJwoUARKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6dcba658872611f0b29709d653e92f7d-20250901
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:080ebc23-0147-47d8-836c-3ca0df44aa07,IP:0,U
	RL:0,TC:0,Content:30,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:6493067,CLOUDID:6b3849a3a587fda4276d687cb5af7504,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:4|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6dcba658872611f0b29709d653e92f7d-20250901
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 917678618; Mon, 01 Sep 2025 19:25:56 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id B647AE008FA4;
	Mon,  1 Sep 2025 19:25:56 +0800 (CST)
X-ns-mid: postfix-68B582C4-6041265
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 3245AE008FA6;
	Mon,  1 Sep 2025 19:25:56 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "Rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1 3/3] cpufreq: virtual: drop redundant freq_table argument
Date: Mon,  1 Sep 2025 19:25:51 +0800
Message-Id: <20250901112551.35534-4-zhangzihuan@kylinos.cn>
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

Previously, some cpufreq core helper functions accepted a separate
'freq_table' argument even though the frequency table is now stored
inside struct cpufreq_policy.

This patch updates all cpufreq core calls to remove the redundant
argument and use policy directly.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 drivers/cpufreq/virtual-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
--=20
2.25.1


