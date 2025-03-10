Return-Path: <linux-pm+bounces-23724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAE7A58ABF
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 03:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7773D3AC536
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 02:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A681AA7A6;
	Mon, 10 Mar 2025 02:59:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBC117C225
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 02:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741575558; cv=none; b=i8QGaz/ehVt/aijm8ZzwDGu7rn0FuhLXInQXgf0uJ7aHohLnvuyyx+5hOofneCFrBOe5GPnnv/ZbecZPB6Y+x2swGX3z3VqV1y4l+im1AYkSz75XgpAisk5/AvVKSD6NKgkYnUJ7EX1dyLxo+tfZrOx6nqeltxX243n2C38ZWJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741575558; c=relaxed/simple;
	bh=GSNZxhA8Oh6wTTIEAqfSBZW5X5jGalcRCqrjPIanACw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUGgvhmvk9t3zN1FVt3MtLSdwi42tY2lmN9k32ZqXv/KfsXGTi8MVwYpiUfTQj32ppy8gnVHcFUknMA4NG+tDitUn665tNYqBwC/ubRY8nrNZ3oEukC5MvPtP2S4sf4WW9KTFPAm9V/DKCZqPKxS5HB3gFq9PgLv9bKYIbuh0v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 52A2xCbo030834
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 10:59:12 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 52A2v5Oe012412;
	Mon, 10 Mar 2025 10:57:05 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4ZB1dK6rR1z2KFyXP;
	Mon, 10 Mar 2025 10:52:05 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 10 Mar 2025 10:57:02 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <lkp@intel.com>, <rjw@rjwysocki.net>, <daniel.lezcano@kernel.org>
CC: <devel@acpica.org>, <jeson.gao@unisoc.com>, <linux-acpi@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <llvm@lists.linux.dev>,
        <lukasz.luba@arm.com>, <oe-kbuild-all@lists.linux.dev>,
        <rafael@kernel.org>, <ke.wang@unisoc.com>, <di.shen@unisoc.com>,
        <xuewen.yan94@gmail.com>
Subject: [RFC PATCH] drivers/powercap: fix build error when CONFIG_SMP is not set
Date: Mon, 10 Mar 2025 10:56:55 +0800
Message-ID: <20250310025655.576-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202503070326.9hEUez42-lkp@intel.com>
References: <202503070326.9hEUez42-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 52A2v5Oe012412

When CONFIG_ENERGY_MODEL=y and CONFIG_SMP=n, there is build error:

>> drivers/powercap/dtpm_cpu.c:83:15: error: call to undeclared function 'sched_cpu_util';
ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      83 |                 sum_util += sched_cpu_util(cpu);
         |                             ^
   1 error generated.

This is because the sched_cpu_util depends on CONFIG_SMP,
so using the #ifdef to guarantee the dependence.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503070326.9hEUez42-lkp@intel.com/
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 drivers/powercap/dtpm_cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 6b6f51b21550..b935e8c38b45 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -68,6 +68,7 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 	return power_limit;
 }
 
+#ifdef CONFIG_SMP
 static u64 scale_pd_power_uw(struct cpumask *pd_mask, u64 power)
 {
 	unsigned long max, sum_util = 0;
@@ -84,6 +85,12 @@ static u64 scale_pd_power_uw(struct cpumask *pd_mask, u64 power)
 
 	return (power * ((sum_util << 10) / max)) >> 10;
 }
+#else /* !CONFIG_SMP */
+static inline u64 scale_pd_power_uw(struct cpumask *pd_mask, u64 power)
+{
+	return power;
+}
+#endif
 
 static u64 get_pd_power_uw(struct dtpm *dtpm)
 {
-- 
2.25.1


