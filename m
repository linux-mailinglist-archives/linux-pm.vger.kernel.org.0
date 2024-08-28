Return-Path: <linux-pm+bounces-13016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC08C961FA9
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 08:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795362861A3
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 06:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8A11448E6;
	Wed, 28 Aug 2024 06:25:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC171BC2F;
	Wed, 28 Aug 2024 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724826319; cv=none; b=UXhGF3WoeZ1AKwX1opLIzezqMjWxZsGlmnkm9p0+1ZDgjGPcO0H5m7CRW3Rj+9G4yrYzm6B1RlFv2p0eRbRkqtBirGJaWp37qb/OKgvzvrEL8s1MtLs9uMfHefux+HAa0avTroonZH9x29NIgfETeCnCW/LxVu9OrCqY1WY2b9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724826319; c=relaxed/simple;
	bh=MEuMtdmGcnCXCBbyeF3r94mGLyQW7MccMHMw4Wd22i4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTpj7RQbWXq4hg5gXBC6laiPxKEzCznW+4e9P4rpzuK1qKgzW0YoQDJg84hMtuAYhV7ktyPdl1l/C7v5WBsa3kBAARYYVIGTbjS4TcjBwm3O4HJMHj4EqyiAdXrQvBRF7izjwYd+iRlLVin6BIQkCumrDyCICJi/taDhUAgZ3nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92576C5813C;
	Wed, 28 Aug 2024 06:25:16 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Xi Ruoyao <xry111@xry111.site>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH] cpufreq: loongson3: Use raw_smp_processor_id() in do_service_request()
Date: Wed, 28 Aug 2024 14:24:59 +0800
Message-ID: <20240828062459.1853837-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use raw_smp_processor_id() instead of plain smp_processor_id() in
do_service_request(), otherwise we may get some errors with the driver
enabled:

 BUG: using smp_processor_id() in preemptible [00000000] code: (udev-worker)/208
 caller is loongson3_cpufreq_probe+0x5c/0x250 [loongson3_cpufreq]

Reported-by: Xi Ruoyao <xry111@xry111.site>
Tested-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/cpufreq/loongson3_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
index 5f79b6de127c..6b5e6798d9a2 100644
--- a/drivers/cpufreq/loongson3_cpufreq.c
+++ b/drivers/cpufreq/loongson3_cpufreq.c
@@ -176,7 +176,7 @@ static DEFINE_PER_CPU(struct loongson3_freq_data *, freq_data);
 static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 extra)
 {
 	int retries;
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu = raw_smp_processor_id();
 	unsigned int package = cpu_data[cpu].package;
 	union smc_message msg, last;
 
-- 
2.43.5


