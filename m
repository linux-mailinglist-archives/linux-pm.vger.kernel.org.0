Return-Path: <linux-pm+bounces-14670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515C6985999
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 13:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFBEB1F21E7A
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 11:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7271A4E73;
	Wed, 25 Sep 2024 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPzMDNH2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF3A1A4E7A;
	Wed, 25 Sep 2024 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264376; cv=none; b=mn5z9Q7X/GypRrbn5B1He+YFFNQwX5WDsWvpOc0PQWtP0eCQASYtu2Ekb7VHdHqnMvBdhxIM7zO4fMXu9h5LivLVhlaObMMpsQydr8IpODvQyY9gfRw+tmmTWwH7jsTBU998H2yddQccI3dXe5Dz1h1/fu2/jIUSZrOgy+1M7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264376; c=relaxed/simple;
	bh=pZfoA7z32V589kbb+75soeo8snYzz0ePiOOWInwpiUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFclCCUv/Wm/DdOzFDom/BdCTVSQomUq0P4W9mrJmvs/dpQOq7Es7m69Q8W/VOJApELMzKh2XYkQ8mj+TMHbt6GDI/g2oOIipLAd9D3yAgVuDTWgFpooOQXy7TIjYRRpi+btCS9Pg3zQ4AWI+E214DVNVHHNhzQgNFL+yjMW1/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPzMDNH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377E2C4CEC3;
	Wed, 25 Sep 2024 11:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264375;
	bh=pZfoA7z32V589kbb+75soeo8snYzz0ePiOOWInwpiUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPzMDNH2K87dK4VzWZOmUQGF/sktVD25vz0iDB1aYocnoKoJD8FE9wJF7wvd5pgKH
	 MZsDxtWEy36CrXd1PIiJoC/I0VZPKlaWUNLvSXo9Sk0AotBg/EJriiKBu1cXrTetXW
	 tC7H3KlfA4frHKF0D+6JlLzJol6jraVPoT9aBvmwMXuIPqcyA9VhAl8XlZGCP/ePYR
	 0LYZ3tZoQ0hgZSz2qaCWSiRwYeh+Fg7pgZryhRM1XNSaMkA+2L0FOTHaZ04aydQP9h
	 qNulqk9v3fPt/ZkltrjY2ROWsKHCFtNDuWtDcKow3AIGCFqQVIbbVzGje1T6r56zly
	 drDupVCqzFYqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Xi Ruoyao <xry111@xry111.site>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	rafael@kernel.org,
	loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 073/244] cpufreq: loongson3: Use raw_smp_processor_id() in do_service_request()
Date: Wed, 25 Sep 2024 07:24:54 -0400
Message-ID: <20240925113641.1297102-73-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 2b7ec33e534f7a10033a5cf07794acf48b182bbe ]

Use raw_smp_processor_id() instead of plain smp_processor_id() in
do_service_request(), otherwise we may get some errors with the driver
enabled:

 BUG: using smp_processor_id() in preemptible [00000000] code: (udev-worker)/208
 caller is loongson3_cpufreq_probe+0x5c/0x250 [loongson3_cpufreq]

Reported-by: Xi Ruoyao <xry111@xry111.site>
Tested-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/loongson3_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
index 5f79b6de127c9..6b5e6798d9a28 100644
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
2.43.0


