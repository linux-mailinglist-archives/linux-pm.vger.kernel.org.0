Return-Path: <linux-pm+bounces-32619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFD4B2BF1E
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 12:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276FC4E1218
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 10:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD98322C68;
	Tue, 19 Aug 2025 10:40:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B9275863;
	Tue, 19 Aug 2025 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600004; cv=none; b=HvHuRYTZ6h1yeG4+1H7mpKjJ3b0x4tM47qZ2DDwMlBZYgO7rHk+H0dPdeUgAPdggoH1PE9SuxBYt83v3Tt9H6eGcihd5F7SYLGocM6mUya6aFNaNct0uyjilLiF7FonZQxVqqdNzeA73pcBdUxceX/asjIb6xGdjAj+2NkQiZK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600004; c=relaxed/simple;
	bh=hzxKZ7hvLtod/wNlXJ7lWJSA852t2pbSPwctvFM2MHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mmpMpT6OEK/zscxCQpfPp85fShnhJ0OLx5opX1z0z8uu9F24c3HCbL4aiG/bHF9H5Sl35JdrXk+1tI2HVHG+AbbhKVAMlK4MzbqSTaYAIky5Z9P8HqamAKhplUm/bFPMr/ujLvjFWigLmAdHEvYBpGCJoLvYn3AW1ko52nBhYNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d3b17ecc7ce811f0b29709d653e92f7d-20250819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:baec5688-b912-4127-9579-6871d3bb48b4,IP:0,U
	RL:0,TC:0,Content:41,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:41
X-CID-META: VersionHash:6493067,CLOUDID:9db6955d62577974b77890fd1bf21c83,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:4|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d3b17ecc7ce811f0b29709d653e92f7d-20250819
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 862119795; Tue, 19 Aug 2025 18:39:47 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 4673BE008FA3;
	Tue, 19 Aug 2025 18:39:47 +0800 (CST)
X-ns-mid: postfix-68A45473-13948120
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 44F7DE008FA2;
	Tue, 19 Aug 2025 18:39:46 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH 1/2] cpufreq: use strlen() for governor name comparison
Date: Tue, 19 Aug 2025 18:39:39 +0800
Message-Id: <20250819103940.342774-2-zhangzihuan@kylinos.cn>
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


