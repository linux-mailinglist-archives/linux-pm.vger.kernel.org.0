Return-Path: <linux-pm+bounces-32787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 049E2B2F31C
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 11:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8930189FADF
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 09:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEBE2BD5B3;
	Thu, 21 Aug 2025 09:00:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C691E32B9;
	Thu, 21 Aug 2025 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766841; cv=none; b=eFWVZvYxmevjKIQDsSoKcxzxJCqoeaYOyMH8HBlLagIw4HqWRicc8RCwooUbT5p9AoDbpnx9jVrs+OMrcTj13cJEQQMNo91zHaBzI9AG1D3C2lVnwfqFDVz3VjqvGGfl8/aVkSbqNMYACvGZxm0JKeiAR7rGLjFJTdzYTWsl6A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766841; c=relaxed/simple;
	bh=ehhLbhqbxhKzX6+8FyEtbA7Degy0+tx80l9fwlwhhvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V07954amBq7QsqLWr/onvbDtTErRwBZWElxeO46Pgg7DMF/pN6urMWNc1AC4lhZIQ7HGPdNDr84pEx3ICSDaX9M0ib8s0ixmQN1rYA2+NnzZ/G3OK7pB1IN0uDIlYsabo/N8C3MGthXq7/yuyKl5Swo3HE+7f9/1FM77HqhX7Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4a3693f47e6d11f0b29709d653e92f7d-20250821
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e0b3b374-3b18-453e-a916-4525ede25e61,IP:0,U
	RL:0,TC:0,Content:40,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:40
X-CID-META: VersionHash:6493067,CLOUDID:6c78b2a72af29761a32fba62c18f3947,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:4|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4a3693f47e6d11f0b29709d653e92f7d-20250821
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1826623977; Thu, 21 Aug 2025 17:00:31 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id D0304E008FA3;
	Thu, 21 Aug 2025 17:00:30 +0800 (CST)
X-ns-mid: postfix-68A6E02E-715900775
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 48D7CE008FA2;
	Thu, 21 Aug 2025 17:00:30 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v2 1/2] cpufreq: use strlen() for governor name comparison
Date: Thu, 21 Aug 2025 17:00:19 +0800
Message-Id: <20250821090020.167786-2-zhangzihuan@kylinos.cn>
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

Most kernel code using strncasecmp()/strncmp() passes strlen("xxx")
as the length argument. cpufreq_parse_policy() previously used
CPUFREQ_NAME_LEN (16), which is longer than the actual strings
("performance" is 11 chars, "powersave" is 9 chars).

This patch switches to strlen() for the comparison, making the
matching slightly more permissive (e.g., "powersavexxx" will now
also match "powersave"). While this is unlikely to cause functional
issues, it aligns cpufreq with common kernel style and makes the
behavior more intuitive.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fc7eace8b65b..a067b5447fe8 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -664,10 +664,10 @@ static struct cpufreq_governor *get_governor(const =
char *str_governor)
=20
 static unsigned int cpufreq_parse_policy(char *str_governor)
 {
-	if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN))
+	if (!strncasecmp(str_governor, "performance", strlen("performance")))
 		return CPUFREQ_POLICY_PERFORMANCE;
=20
-	if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN))
+	if (!strncasecmp(str_governor, "powersave", strlen("powersave")))
 		return CPUFREQ_POLICY_POWERSAVE;
=20
 	return CPUFREQ_POLICY_UNKNOWN;
--=20
2.25.1


