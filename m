Return-Path: <linux-pm+bounces-8101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6CE8CE343
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 11:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FB81F2300F
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4301284E07;
	Fri, 24 May 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L4G1pHt0"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3D329422;
	Fri, 24 May 2024 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542451; cv=none; b=IdxlmYF1mLnM66VsKDu4KwtqIVe4lSktvOaQl0qI7Vp9xohWvxkvLVI3x2HdkS/PBkq7R7Umb3infoRROCZsqp6SgTViwpYOwxOuIBehY4kTjOj847RG3zbJwxenWq8kI0h38ZPT38XpIyVABjUVIj8vEQW+z5RKJOVsJQyDaww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542451; c=relaxed/simple;
	bh=4ml7AionnIhmh3oe/VwMHprJFVrZFnKP8w0nKR9bcNI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZIEj0hH5w38itwrjWuE8QTkFDoRrmSNp0whsfxdxzn96dsMnW7uDlQAZGGqvxCl0gQ5vPjgQhITwjJoNp8YSnyAIc6au041vdf/f+7+rRSn8oJlltvBASEZZdk6g8/uq5LyXVLY7bDuPTAH+e9vwIDFrr6hTttUDaqCV/MAKpEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L4G1pHt0; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716542440; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=eI3QrBvl4I9xu8kYZj+jLrX2t8GGLBYAfkGJZqqiA2Y=;
	b=L4G1pHt0L/Edie1l95tnkuE6wtbUXAQIhezcMq52swSa2nON0axL4hfiPHRcd6OTuZR3hc6uuJW5ea7CWRGt6QI/Z29tu9+niarKnx5amLNrIwL0Ar0LPr/Iyo5w8VQEXU3Ag3BNCtVQ+olWE8iPEoF7XtUXFGrmy7SlCxMfVV0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W76QnVO_1716542439;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W76QnVO_1716542439)
          by smtp.aliyun-inc.com;
          Fri, 24 May 2024 17:20:40 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] cpufreq: longhaul: Fix kernel-doc param for longhaul_setstate
Date: Fri, 24 May 2024 17:20:37 +0800
Message-Id: <20240524092037.71666-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch updates the function documentation comment for
longhaul_setstate to adhere to the kernel-doc specification.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/cpufreq/longhaul.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index 4c57c6725c13..bd6fe8638d39 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -236,8 +236,9 @@ static void do_powersaver(int cx_address, unsigned int mults_index,
 }
 
 /**
- * longhaul_set_cpu_frequency()
- * @mults_index : bitpattern of the new multiplier.
+ * longhaul_setstate()
+ * @policy: cpufreq_policy structure containing the current policy.
+ * @table_index: index of the frequency within the cpufreq_frequency_table.
  *
  * Sets a new clock ratio.
  */
-- 
2.20.1.7.g153144c


