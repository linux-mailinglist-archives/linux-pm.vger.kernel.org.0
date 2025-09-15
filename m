Return-Path: <linux-pm+bounces-34623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018DAB570CD
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 09:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF41A178818
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 07:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E21E1448D5;
	Mon, 15 Sep 2025 07:03:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27418524F;
	Mon, 15 Sep 2025 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919794; cv=none; b=PIXvr2MY7s7LKm4Dl6vR56xdWlNXsIwjASVUg+CXhj7eXM4EteQNsIdVQUqoN/Ep82+cR6hpbok5s8rk3ehIufyfM0oWk/GQPuVFa1maHQj8lGjEwny/XtOxFMZkhsXMqS4h/GbnMFiOxRMZqcU9pFztrT9MdQbHsy/CNZRUHAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919794; c=relaxed/simple;
	bh=n9WV5gmKWMnWsr3Z+Pe+uPvOpjFR6LqlTPskCOGV6bo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YsVFJppj74YmG0HoSsM+0U9HSM3RCSYD/kGK3b0RZQAr2LDtjgyQKqkd8HUMbgwQ2GUc+jIg+oCBcWR9lJTnBMcPfjjMhOAEvB8z0WbdDDQ6ZCSd7m1LML6lbnmIpiPt4yHt1U/7d5QwB5aaQywQPBc2DANWQgfX/3G2fALNzfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 012e5f9a920211f0b29709d653e92f7d-20250915
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:03285f4c-24b8-45cb-8b80-e662239d4e59,IP:0,U
	RL:0,TC:0,Content:29,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:29
X-CID-META: VersionHash:6493067,CLOUDID:2a3130dfdfe9b9a9fe1a32862b6c3330,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:4|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 012e5f9a920211f0b29709d653e92f7d-20250915
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1829662885; Mon, 15 Sep 2025 15:02:55 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 5BF6CE009009;
	Mon, 15 Sep 2025 15:02:55 +0800 (CST)
X-ns-mid: postfix-68C7BA1F-10783978
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 886F5E009008;
	Mon, 15 Sep 2025 15:02:54 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "Rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1] cpufreq: Replace pointer subtraction with iteration macros
Date: Mon, 15 Sep 2025 15:02:50 +0800
Message-Id: <20250915070250.416423-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The cpufreq documentation suggests avoiding direct pointer
subtraction when working with entries in driver_freq_table, as
it is relatively costly. Instead, the recommended approach is
to use the provided iteration macros:

  - cpufreq_for_each_valid_entry_idx()

Update freq_table.c accordingly to replace pointer difference
calculations with the proper macros. This improves code clarity
and follows the established cpufreq coding style.

No functional change intended.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 drivers/cpufreq/freq_table.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index d5111ee56e38..ca06a0236e70 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -33,16 +33,17 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_po=
licy *policy)
 	struct cpufreq_frequency_table *pos, *table =3D policy->freq_table;
 	unsigned int min_freq =3D ~0;
 	unsigned int max_freq =3D 0;
+	unsigned int i =3D 0;
 	unsigned int freq;
=20
-	cpufreq_for_each_valid_entry(pos, table) {
+	cpufreq_for_each_valid_entry_idx(pos, table, i) {
 		freq =3D pos->frequency;
=20
 		if ((!cpufreq_boost_enabled() || !policy->boost_enabled)
 		    && (pos->flags & CPUFREQ_BOOST_FREQ))
 			continue;
=20
-		pr_debug("table entry %u: %u kHz\n", (int)(pos - table), freq);
+		pr_debug("table entry %u: %u kHz\n", i, freq);
 		if (freq < min_freq)
 			min_freq =3D freq;
 		if (freq > max_freq)
--=20
2.25.1


