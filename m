Return-Path: <linux-pm+bounces-32890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8FCB30FE0
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 09:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22C8607F08
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 07:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A342E7BB1;
	Fri, 22 Aug 2025 07:04:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2285A2236FD;
	Fri, 22 Aug 2025 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755846281; cv=none; b=SH9w0xSTvY56BL0MbveHiTrhKP6484B7bUoWKUIsEwYK3mLlFo1rubsnF/8E460XS9qKvXF7WGI+TF5bzfGk/4Nm4Lp5m6xfmiOi0xm097ktUYogzw/qgvgM8tpulsg4fTH4HyIxswqpVonvGkQGU9emZ9N1NL8M7O17O8gO7CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755846281; c=relaxed/simple;
	bh=ehhLbhqbxhKzX6+8FyEtbA7Degy0+tx80l9fwlwhhvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LrW8YtIb6DszBYsJLMvGSeMMllvsZddftql+nAZdAne222JOIyIULx/ITl6Kd8lmDIfjB39jHxm4pyUdCk9uH3pYhByXoF7jKCBZALw67OIfA1QdOIrDYgimEh3ohOUDyo7hsdK3ciak7cPt3m1X+IV6s7bwnTk4CesLLqman9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3ffa1d2a7f2611f0b29709d653e92f7d-20250822
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:198569ba-f29a-4f0c-86a6-3c03587033fb,IP:0,U
	RL:0,TC:0,Content:40,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:40
X-CID-META: VersionHash:6493067,CLOUDID:8188160459c47c3dc0134ef063ccc672,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:4|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3ffa1d2a7f2611f0b29709d653e92f7d-20250822
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1620805533; Fri, 22 Aug 2025 15:04:30 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id DFB75E008FA3;
	Fri, 22 Aug 2025 15:04:29 +0800 (CST)
X-ns-mid: postfix-68A8167D-760710307
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 21E8CE008FA2;
	Fri, 22 Aug 2025 15:04:29 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v3 1/2] cpufreq: use strlen() for governor name comparison
Date: Fri, 22 Aug 2025 15:04:23 +0800
Message-Id: <20250822070424.166795-2-zhangzihuan@kylinos.cn>
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


