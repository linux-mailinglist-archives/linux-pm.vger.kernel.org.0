Return-Path: <linux-pm+bounces-11941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC6E94925F
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 15:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FC11C2157D
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 13:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4023E201250;
	Tue,  6 Aug 2024 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHkxk6lC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA951D2F49;
	Tue,  6 Aug 2024 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952718; cv=none; b=iMbC/YzVGR1hw77CfjYAx0yXst4IFhnDdQ86a9YNKXuAdMZXoHW4c2eOiGZITGVJFoBf8NxMd/KfNgr8uwkqhZmZ2B00y3zW01suV6yuI4AxCT5xoANt74tge/T9azTTAo3tLM+za6VupUvL5MNPiRciilM3AT39ApjhLhwKOKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952718; c=relaxed/simple;
	bh=bpFwOW/Idgv4HfSu/INdfs1drz/1nc8HjbwYZGkDWcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BqW6zO48ngPu+arS9A2mjRUvOSGMiawSb7GRXjlLLg8kfrJv/Cx9nejXDArmDAbtAIfYInsqsrErk8m+ljgXTimFbl2y6u/pDOCFCeJc21vaWnO4LgOrfxt0MlWfHKVxYjBCtC1vqq3+2nPM5gujwImvi4p0Edf4PBDjDY0Ukbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHkxk6lC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D57DC32786;
	Tue,  6 Aug 2024 13:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722952717;
	bh=bpFwOW/Idgv4HfSu/INdfs1drz/1nc8HjbwYZGkDWcs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uHkxk6lC5/XZGrJy8/XTdn1Qu/XhDeecfgk2EwXEF+oylzTxjKNPEdTikfDdNXA6b
	 UxkbukVT/mXCMln7LcnLJfJnBT8HtXeEvTzBS1lIRTQFuC0Q7K4jlhsPFpXwNWOLrf
	 p7R9Zivjnf+gIgBskWFDE26A+hCM4El/F8I8CeaVbJD2LYogsBfKa5MXKE2GoLNulZ
	 mZsrN4uWamzkHOcQd+kvx/4yOCgMMmfcbWI/MFkJfoHGOR1FFytq1ZZ/UutUPxG2+P
	 gkQIdoufRAHzEXHb7MnIuCOLDp4UgJIjelm6lJDr60PMYRk1v7cS+6g9pAfBmfurg/
	 zhRqkWu5zPIUA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 06 Aug 2024 07:58:24 -0600
Subject: [PATCH 3/6] cpufreq: armada-8k: Avoid excessive stack usage
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-dt-api-cleanups-v1-3-459e2c840e7d@kernel.org>
References: <20240806-dt-api-cleanups-v1-0-459e2c840e7d@kernel.org>
In-Reply-To: <20240806-dt-api-cleanups-v1-0-459e2c840e7d@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Kevin Hilman <khilman@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev

In some build configurations (e.g. x86 allmodconfig), 2 cpu_mask
variables exceeds the max stack frame size:

drivers/cpufreq/armada-8k-cpufreq.c:203:1: error: the frame size of 2128 bytes is larger than 2048 bytes

Fix it by making "cpus" static which is fine given that module init is
only called once.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/cpufreq/armada-8k-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
index ce5a5641b6dd..7a979db81f09 100644
--- a/drivers/cpufreq/armada-8k-cpufreq.c
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -132,7 +132,7 @@ static int __init armada_8k_cpufreq_init(void)
 	int ret = 0, opps_index = 0, cpu, nb_cpus;
 	struct freq_table *freq_tables;
 	struct device_node *node;
-	struct cpumask cpus;
+	static struct cpumask cpus;
 
 	node = of_find_matching_node_and_match(NULL, armada_8k_cpufreq_of_match,
 					       NULL);

-- 
2.43.0


