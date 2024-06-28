Return-Path: <linux-pm+bounces-10174-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC3A91BB40
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 11:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE221C21081
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 09:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F171514E0;
	Fri, 28 Jun 2024 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vUwcSCP9"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A203A14F98;
	Fri, 28 Jun 2024 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719566103; cv=none; b=QwOm/ZJfYGXgdFAQKb1wi+WfQX55R14kXYcccV/vLIAcWMIHOV3Wh30TQrTnYsntWqUIJ5stXOEvGVhIMLBiDtqkR0Xhy2GdR75nv2OMTc4On4Njd4R1e2f9AyzdxCCuWNpPbOfxAjSO5sClud+42uh3/cB5HCCuO7AHrfIE4Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719566103; c=relaxed/simple;
	bh=r/Th9O2aZMMXbfIiW1waqw9GyrYxm3TKoU3/NIhFZ0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZcYkZwfKPIMH1Geth31FF02ykJ6dt1iZbycfsomjrl7TePhwTIxJpmYE13eBFBiv9eTqO5Ue/ADwEull4XNzOskUXwN+h4CYugQS/8px1NwJeFnls1+bjttzIGNGoY801WSEjgf7WQpejlbRNLh4CgRcBxe0Vb7LTbxHL5ZsNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vUwcSCP9; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719566098; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OtRDW3ZfujA0yUx2njQc+axApfTNdD+9gaRETBCWkEI=;
	b=vUwcSCP9wWg4SsiNUoUQSAzO1VU9mlqags2NfYTy1CDORgkV53TyxgkJAEcEFAPzbj+0BZX8cNxTkJ6zbUxK9gCBy9y4NE4KYuXTPpALE9ZRhvxHDVMEZHtyDoUqqUWomDLswepmsVUy7rFjLRfr30WjVCQnyKHvgg0JB7nA3ys=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W9PrlmV_1719566097;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W9PrlmV_1719566097)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 17:14:57 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: mingo@redhat.com
Cc: rafael@kernel.org,
	tglx@linutronix.de,
	pavel@ucw.cz,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] mm/treewide: Add missing kernel-doc function comments.
Date: Fri, 28 Jun 2024 17:14:56 +0800
Message-Id: <20240628091456.57301-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel-doc style comments for the pfn_is_nosave and
arch_hibernation_header_save functions.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9453
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/x86/power/hibernate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index 5b81d19cd114..90f682ff63b1 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -41,7 +41,8 @@ unsigned long temp_pgt __visible;
 unsigned long relocated_restore_code __visible;
 
 /**
- *	pfn_is_nosave - check if given pfn is in the 'nosave' section
+ * pfn_is_nosave - check if given pfn is in the 'nosave' section
+ * @pfn: The Page Frame Number to check
  */
 int pfn_is_nosave(unsigned long pfn)
 {
@@ -84,9 +85,11 @@ static inline u32 compute_e820_crc32(struct e820_table *table)
 #endif
 
 /**
- *	arch_hibernation_header_save - populate the architecture specific part
- *		of a hibernation image header
- *	@addr: address to save the data at
+ * arch_hibernation_header_save - populate the architecture specific part
+ * of a hibernation image header
+ * @addr: address to save the data at
+ * @max_size: the maximum size of the data to save
+ *
  */
 int arch_hibernation_header_save(void *addr, unsigned int max_size)
 {
-- 
2.20.1.7.g153144c


