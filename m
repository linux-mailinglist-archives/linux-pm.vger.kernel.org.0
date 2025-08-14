Return-Path: <linux-pm+bounces-32385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154DFB25F94
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 10:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A00C3BCAE7
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 08:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD57F27FD5A;
	Thu, 14 Aug 2025 08:52:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99752FF662;
	Thu, 14 Aug 2025 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161556; cv=none; b=eoPV2TTw+3o9zQlHnkz+uIgvD60ZvO9Bet1d4Wx8icCeYFYW5VmGCt0QrX1f+MSYqj8c3l5YIgJDI3IuhyerOOdZBx4K42xXp/Iz0gsjh+N7+j5CEdJ3+2WRTnw2VtzGiTqPZIUn8xLKJP18jbPZu8QDIKjx5DdAao1VbqU5Shg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161556; c=relaxed/simple;
	bh=yJi9FyXTcF/XdHPTjitXGKYUavAEw2k5Tu8rMnuUZHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BdhSxLzyVdHFyM6NyDBp1l9SiM4eV2dPjGvrgJorjjy3uXNTAAUfkCsHqwh9E3LUUc2KLRKa7VTdS4btheLm+A0XliFr1LaMMKNBfiC4WNaFMummBjeGCQ+yrWU/uPW8VDjGrJ+wgP8iynU2YoJbpFicD5BUn5a+ismINyFzf1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fcbdde7e78eb11f0b29709d653e92f7d-20250814
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:29c4cb33-7be3-4a74-821f-6c6c9986d71c,IP:0,U
	RL:0,TC:0,Content:32,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:32
X-CID-META: VersionHash:6493067,CLOUDID:7c5d88dfdf35d33e11fee4ddc84ba7f7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fcbdde7e78eb11f0b29709d653e92f7d-20250814
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 962377151; Thu, 14 Aug 2025 16:52:20 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id E2F26E008FA5;
	Thu, 14 Aug 2025 16:52:19 +0800 (CST)
X-ns-mid: postfix-689DA3C3-747392603
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id C8EABE008FA3;
	Thu, 14 Aug 2025 16:52:18 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1] cpufreq: Return current frequency when frequency table is unavailable
Date: Thu, 14 Aug 2025 16:52:16 +0800
Message-Id: <20250814085216.358207-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In cases where the CPU frequency table (freq_table) is not available,
the __resolve_freq() function will now return the current frequency
(policy->cur) instead of the requested target frequency. This ensures
that the system doesn't return an invalid or uninitialized frequency
value when frequency scaling is not supported or not initialized.

This change improves the stability of the frequency scaling logic when
the CPU frequency table is not populated, preventing errors related
to unavailable frequency tables.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fc7eace8b65b..ca9b7807a288 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -502,7 +502,7 @@ static unsigned int __resolve_freq(struct cpufreq_pol=
icy *policy,
 	target_freq =3D clamp_val(target_freq, min, max);
=20
 	if (!policy->freq_table)
-		return target_freq;
+		return policy->cur;
=20
 	idx =3D cpufreq_frequency_table_target(policy, target_freq, min, max, r=
elation);
 	policy->cached_resolved_idx =3D idx;
--=20
2.25.1


