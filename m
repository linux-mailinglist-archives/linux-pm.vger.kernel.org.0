Return-Path: <linux-pm+bounces-25681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93256A92F3C
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 03:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18FA8A6102
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 01:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9A338DDB;
	Fri, 18 Apr 2025 01:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="enp313kL"
X-Original-To: linux-pm@vger.kernel.org
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4678B70805;
	Fri, 18 Apr 2025 01:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744939484; cv=none; b=Lelqbx3nXlD4agkyT5yXyJjjLPfUB5PK+dqc9cR9LoViQEQ+O8eAIQzhmpK1Z30l9pxWW/D86+3VFggKxn6j8tNXBHjA0FpVuxBFOdPb9mD/MhuUtkmkO+1W+YDuxsS6O0ov+y6JqiTtop9WKaTja3vBx59sGByb7zbpcV9cMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744939484; c=relaxed/simple;
	bh=0RRFeV42YRV70clRp0vHQ44UuKlvrSdcK+hGHbl8N5I=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Rmqpo9EUzZkRQ0bVaTIlgJpV6d1mwy62MdfbTAc9LzWTfhixG4OssXjbsdmha0aaoz8cobJ4lvSSxjHejkwi0D3s0rj34xVvnqgFPS0C/zUl31LWrt0Nm2nD7b4W4Sc+85xM4k2tLTeQXr7kUaLvyEfp/Zw11oyymcwsS2GEepA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=enp313kL; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744939176; bh=B/nVSkqnOgN017vdo4piNN1T3of1eMH18L/GSCrTckY=;
	h=From:To:Cc:Subject:Date;
	b=enp313kLxRA/bk8wh8KdEo9AMKCxCZUyxseigzWRsOTyuI8rmEfJF/E2khHSbbzde
	 3YKJWdEsup3qcjTKKDTy4s04S6TzKNg1lHD0psPiHNAJ94diPOmmXRZd4uG3Xb5FLt
	 npCBl5gpudThZ43+s3x/7/jl505bZFzFelo+6hG0=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 18E95E91; Fri, 18 Apr 2025 09:06:14 +0800
X-QQ-mid: xmsmtpt1744938374tnuxhjmo1
Message-ID: <tencent_7F99ED4767C1AF7889D0D8AD50F34859CE06@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIed/zbwOGRi+irIKm8agM3wEsTNW/8yM1MlYqZyoTZRpFnDA/51m
	 btWKETvpg1OkugaJ6RxLD/xL8IZcMP3/3VJR+0t2NpwZ7nk/Eqcw6VYai6Qu5YOZ4K1l+kDWWPzF
	 kx0SoPA8Tx/nSu9Wve4BRgwbsezkXXTnTMgkBurhXEUWbr62HjXkc5c/c+RNJe06GklVSavw+XzS
	 80es6q1YaRI+tIP7Uf/ov+CoX3L89vndB6lXJtr4VxVwK7/kfStoSkdeeCYsbvQYhyAMei9KIFX5
	 2RwCxdkRBsvUM2kPs83W1JO1LuH9yWplq3R9RNF9gGkpa/4f3LM8puh2WGttIMSVJ9XkEyaww6yY
	 e52l/Jl/sk4taKphbdOPpbhd+Qd693I7RCPzdI2guu6MnvyCJgGxYGTTajEGJNm2wz2KkHn4mSIx
	 lbZBBGJNPGqF2OMrRM6y9f2ZOVr/BvvMiEvJ0kvfIUivK+LBdeDVdJ08TFxUNTXlX5wg+7jWTBJo
	 YFA98TFaDetSu6jRGrTuLD8e3sMDKtxC3qdYXPcRLiJpvhqiK7GCtlcUyXgDJdeh3vucsksvmI0W
	 Hy2PEEExxb0Sur6A5KwRp2E1NAa7oPLHq/uM4UHi67Mrr9RmO451bbklLJUAeHAiZRrBSXYpEUL1
	 w2uWLiL8fHL7h9YBh0G55QQmD4AOUHEA8aUK66d+Ap1tTXFxF/AB+srn53rB2MtC1i7jazLjJMoY
	 qgJGvu8yyKO+FsdFyyAbp34VL7z1pMmYHaWfkfLBPFvYa0J/j7WO2Z0pRNOob3WZJrrzaxWoPABc
	 N+M0ALVJDsDTPWclFp0e5wG+A+fR0zGEO1TtcngEk093ofNi/NwXUmxPCX3ja6bPtcrn9WWgB0eM
	 40H3yz39IvbcYfcFKNwPbMukUgKdEormhEIODo/KhgEE3Bk/bzGaHc3fQz5FfXhrRSbQFME73Mty
	 fW9mFtXhqDZdY+fIRbw9cLRBwewl8rv8BaXt89pUN/lUE5N0K0vNSrvX0CXGT3tamNQ1yhi+4=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Yaxiong Tian <iambestgod@qq.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v4 RESEND] PM: EM: Fix potential division-by-zero error in em_compute_costs()
Date: Fri, 18 Apr 2025 09:06:13 +0800
X-OQ-MSGID: <20250418010613.38871-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

When the device is of a non-CPU type, table[i].performance won't be
initialized in the previous em_init_performance(), resulting in division
by zero when calculating costs in em_compute_costs().

Since the 'cost' algorithm is only used for EAS energy efficiency
calculations and is currently not utilized by other device drivers, we
should add the _is_cpu_device(dev) check to prevent this division-by-zero
issue.

Fixes: 1b600da51073 ("PM: EM: Optimize em_cpu_energy() and remove division")
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index d9b7e2b38c7a..41606247c277 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -233,6 +233,10 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 	unsigned long prev_cost = ULONG_MAX;
 	int i, ret;
 
+	/* This is needed only for CPUs and EAS skip other devices */
+	if (!_is_cpu_device(dev))
+		return 0;
+
 	/* Compute the cost of each performance state. */
 	for (i = nr_states - 1; i >= 0; i--) {
 		unsigned long power_res, cost;
-- 
2.25.1


