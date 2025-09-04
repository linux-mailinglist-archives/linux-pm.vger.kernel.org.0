Return-Path: <linux-pm+bounces-33779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8843FB4306C
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 05:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B7E169FD8
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 03:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196E4286D50;
	Thu,  4 Sep 2025 03:22:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4105023875D;
	Thu,  4 Sep 2025 03:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756956153; cv=none; b=gFAM5W+mcDwR+7htcUYwDi/LPUjZMETb0Il3R0MGHjvtgfEt5NJ0zbayxVBij1Qznb6uSwY9V2xI31btLxjhSMXmO9+QaOGYGjLnXUc05kKZiPxcrGxJajHHGGjCsyxOktxjVfgWDWM7JcuP7jSSCJAgcQIcY8XJ6QCv7MWKwVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756956153; c=relaxed/simple;
	bh=y1F4YNY5ia6byEs1gI8SFG6uVecpwsvCj2rNHgXxPJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQbhJIspckJRV/bADvjVwW1HEzOhmL+kC9I5E3mr0GNY30ZtxPABQRq7EpTzoHIW4uD1CDz1ucN0H1AefkgWWyWuZVWCBS82nZqo9mof2J+t5AoH1pLoXqBdvfZ6pJac2FGXGBNdn0na+rV4VK8HDobtgddSxE22HcxDfT3vQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 606e5a90893e11f0b29709d653e92f7d-20250904
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0c47e6c4-b252-4ea7-a1ea-e5084b30ac91,IP:0,U
	RL:0,TC:0,Content:15,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-META: VersionHash:6493067,CLOUDID:b4e81299e9a4bbf89f9b3aa19e02cd36,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:4|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 606e5a90893e11f0b29709d653e92f7d-20250904
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1139586264; Thu, 04 Sep 2025 11:22:24 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id F0DD9E008FA2;
	Thu,  4 Sep 2025 11:22:23 +0800 (CST)
X-ns-mid: postfix-68B905EF-844106607
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 594EFE008FA4;
	Thu,  4 Sep 2025 11:22:23 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "Rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Saravana Kannan <saravanak@google.com>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1 2/3] cpufreq: Always enforce policy limits even without frequency table
Date: Thu,  4 Sep 2025 11:22:09 +0800
Message-Id: <20250904032210.92978-3-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: quoted-printable

Currently, cpufreq_frequency_table_verify() simply returns when the drive=
r=E2=80=99s
frequency table is missing (policy->freq_table =3D=3D NULL).
This means that cpufreq_verify_within_cpu_limits() is not invoked in such
cases, leaving policy->min and policy->max unchecked.

Some cpufreq drivers handle this manually by calling
cpufreq_verify_within_cpu_limits() even when no frequency table is presen=
t,
in order to ensure the policy stays within CPU limits.

To avoid this inconsistency and potential misuse, make
cpufreq_generic_frequency_table_verify() always call
cpufreq_verify_within_cpu_limits(), regardless of whether policy->freq_ta=
ble
is available. This unifies the behavior across all drivers and makes the =
helper
safe to use universally.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 drivers/cpufreq/freq_table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index d5111ee56e38..f4b05dcc479b 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -105,6 +105,7 @@ EXPORT_SYMBOL_GPL(cpufreq_frequency_table_verify);
  */
 int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *p=
olicy)
 {
+	cpufreq_verify_within_cpu_limits(policy);
 	if (!policy->freq_table)
 		return -ENODEV;
=20
--=20
2.25.1


