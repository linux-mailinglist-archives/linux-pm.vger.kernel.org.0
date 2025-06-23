Return-Path: <linux-pm+bounces-29272-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE459AE3D82
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A06162B19
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 10:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CD123AB81;
	Mon, 23 Jun 2025 10:56:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DF01F2BAD;
	Mon, 23 Jun 2025 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676217; cv=none; b=flhzL0RWNQI0iY7joe+dESepByOw/kgxfDKFvoRuao1kN6rIF7iXvGMlQnwWGBGssJItZz2Am2XuTag2OaxjnvkjzgddWz1oq6brp3UVuvgMGn7mLizEWc+Z890fEC81lTdA+nU2DBzApi3kElkqYCfnhPOcfahFn/Pfs26ZW9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676217; c=relaxed/simple;
	bh=P6NKvTcVlSSY3r3Sj7VJerrLXakYKLSnm6s/5mq+PK0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ru07n6t1KcWx2xwgH1uKOArxOK1nfYavAWi9Niv/fwXWKVYWV7hdV2RIHx5jfFM9nGNNuXXYRgSuN4DKazC1yZ1IfmYcsjEMSdlnzmdS/PJVEiN5NCbPRKugiIelxgj5r6+Bclgt/3sGHOfXEdSWb4tkUhQMFH4mOCpYEtsDFvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <srinivas.pandruvada@linux.intel.com>, <lenb@kernel.org>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] cpufreq: intel_pstate: Add Granite Rapids support in no-HWP mode
Date: Mon, 23 Jun 2025 18:56:01 +0800
Message-ID: <20250623105601.3924-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc7.internal.baidu.com (172.31.3.17) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.42
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Users may disable HWP in firmware, in which case intel_pstate
wouldn't load unless the CPU model is explicitly supported.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/cpufreq/intel_pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 64587d3..1782b29 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2775,6 +2775,8 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	X86_MATCH(INTEL_TIGERLAKE,		core_funcs),
 	X86_MATCH(INTEL_SAPPHIRERAPIDS_X,	core_funcs),
 	X86_MATCH(INTEL_EMERALDRAPIDS_X,	core_funcs),
+	X86_MATCH(INTEL_GRANITERAPIDS_D,	core_funcs),
+	X86_MATCH(INTEL_GRANITERAPIDS_X,	core_funcs),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
-- 
2.9.4


