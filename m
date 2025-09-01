Return-Path: <linux-pm+bounces-33557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B782B3E17E
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 13:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5E816B32D
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 11:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BD231AF31;
	Mon,  1 Sep 2025 11:26:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3C5317700;
	Mon,  1 Sep 2025 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756725966; cv=none; b=Y90S2en5Ct1RpOLGw3P3VpZ4S7K08MOUDId4HBJ33fgHR1HmQFyFbS1ja9pJ5ixTU9uFgb8SrgEDQ4ecSqE3M+OH0bRNUpXz1554pcmfovB3HbaIIfTGvBCWHgnuAJUbqT1k0Y1Pt8NnOPA7iWX9NiB8KxhinmnU6Gq9QhSsrMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756725966; c=relaxed/simple;
	bh=yFrHGY4gl+WKtjVwZg7z/fy9wHFND+nRTEy0fProNDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fuGYrMFWyAHXOnkT9KA456/oHvs+HkXxltUp9L68VMUHS3YV+wSaxMalSl5nm0qmex2fpXdSjyQ3ey3i5UyFeqlQKtclLQOcOEAb1vjTPEW/a3fJN7lQEJQ5Gj5hiEZupOmYCZCJQRLzOgjC1G9h2ho6q/QNyTuiiumhb1e0I90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6d6d9216872611f0b29709d653e92f7d-20250901
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:144c35c4-4d56-44ab-b343-6fedf74b5f09,IP:0,U
	RL:0,TC:0,Content:30,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:6493067,CLOUDID:a0527624422494d963e0bfeaab0b4276,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:4|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6d6d9216872611f0b29709d653e92f7d-20250901
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1851374865; Mon, 01 Sep 2025 19:25:56 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 1A2FBE008FA4;
	Mon,  1 Sep 2025 19:25:56 +0800 (CST)
X-ns-mid: postfix-68B582C3-9680524
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 8C4A5E008FA5;
	Mon,  1 Sep 2025 19:25:55 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "Rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1 2/3] cpufreq: sh: drop redundant freq_table argument
Date: Mon,  1 Sep 2025 19:25:50 +0800
Message-Id: <20250901112551.35534-3-zhangzihuan@kylinos.cn>
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
 drivers/cpufreq/sh-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
index 9c0b01e00508..75d224ba56ba 100644
--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -93,7 +93,7 @@ static int sh_cpufreq_verify(struct cpufreq_policy_data=
 *policy)
=20
 	freq_table =3D cpuclk->nr_freqs ? cpuclk->freq_table : NULL;
 	if (freq_table)
-		return cpufreq_frequency_table_verify(policy, freq_table);
+		return cpufreq_frequency_table_verify(policy);
=20
 	cpufreq_verify_within_cpu_limits(policy);
=20
--=20
2.25.1


