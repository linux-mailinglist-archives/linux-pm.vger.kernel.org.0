Return-Path: <linux-pm+bounces-24842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0F5A7C87D
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 11:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B55188F555
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 09:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152541D07BA;
	Sat,  5 Apr 2025 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6wHf0+Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978131A3AB8;
	Sat,  5 Apr 2025 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743845011; cv=none; b=MBSyFLFCBoxcRWAJhN3OOqyILPjpM4Ehm+OBP7FmvTfvQYfMPLk5WEMELWM0B2Xhyc2zCs3BD9eSwJzw7dXZOemzbpya/s+T6TbH6V9jhwFKMaaQRns+JwtR5x7HEx69/I4QZmRoqCCm0BBDSFH7YhBttC5TApoNRq55J/HMtsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743845011; c=relaxed/simple;
	bh=l3+rGK2EFAZmkTGpdYet06mG0e1irydAi/hOwEmj2Ao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WNs6QymYVSW74ZVt+0tCyiEFXvjpkS4LUTBiUVeQSyKzZqIFDJ6kVe1JlbA58J8hohHey+gn6375sPvP9yp+vv0m3AMrKFNbWA70tE2ubDtHwOYz5o1Pso+5TNVn2bo47TzN8W3dzgZVbRtUK7/Ufd/eGzMrtKyOuu0XUM/7fEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6wHf0+Z; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-ad5236e6fd6so2572456a12.0;
        Sat, 05 Apr 2025 02:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743845009; x=1744449809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wugxhQvHKc30SDsT4EaI/HEENSsFdBpwWD0zIT6tInY=;
        b=N6wHf0+Z3/nBgvtClpWUf25eUpq/AgryuGzTbXdCJ7/kEIINZ/UUrUT0y5KYMFIOn7
         NqI3XKzxl5mLDWM53P5WKj6B+YApZ5McyCZMYiLTltTXjIxrZfqlsslLLpG8+AyFgZfP
         /aqQXCEYV7toZlJfAXKIQYLH1YiI4dP8PSBoRonkPsNf5F7YI/7tL/WyUtfM3MRZSXdk
         PgpXAblCc8aklzqnCAUMMlsePnmsj7fYxPgXTGfrwffJ1kdbNfYYv/1fzwfzSQ6eT16R
         QRgM7xQymncFDVMrAR0/dsTBBuM0mI6qIucWjY0Vb5JdyRP2kJhn5nnhK7lXAQ4CpOAf
         ORXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743845009; x=1744449809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wugxhQvHKc30SDsT4EaI/HEENSsFdBpwWD0zIT6tInY=;
        b=CIi/Jt8KV2IYz9qSOaeZv6RXsp4u5UJy4Hi9yi5t9Uf/F3DfVoQIIpxAAMrswwLI+f
         UHxdjXnUcXy/3wOd5hghohyHoPTK57lP4ns/PMlYiRSwZypLyKJvcRTuZcA4v4S0PSZc
         yWazSCDl02jjPfX6SE+Lq3ISDWrB1ex5g/mkPSbqR13tcUTN3t1UV77LbqzVeSDJ7OMx
         NfNwYonBVhN8EaKU+5UtxungpuOrinbriwkWeH+ORtG4Hn3wZJKoEsZSxYom3gWKtsp6
         M1UBuszv6yqYMWqMXH53zxikZZmNYCNcN86tU9MZkp23HxkTNg/p1F1LefAdWWu3iqG5
         eefw==
X-Forwarded-Encrypted: i=1; AJvYcCXOcT6qquy0ePSBty0IXhxmac0OViRInZdsG5JKwk2/sYwSK6VnjKuMshe0Jly2Sg4rIWnc+lAQUqI=@vger.kernel.org, AJvYcCXdp+P0pOfu+QeqFrv2/vgJqOAN1WtHSWByIogK+IQsvn0lMoJHrtXFLRQg2bkZPJj+T5D7NqHBB+RKdCrp@vger.kernel.org, AJvYcCXzLLuIay9Bn2kDtXY0876CLc61c+SRixL2RoIHgIpMC8LOYSB4KQfjz8SqcFHXnM8Iv8JMu7nSyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzex7qQ6CnpyRIH0RIjNjBaKyjMtn8KLTXwxT7Qhfp2Um3Yv6BV
	mHCQCfxiUrqYHQ82xKWwHEMLRbQ4dLTVO0NVQPpTXbvWlb5AwimJ
X-Gm-Gg: ASbGncugovxnAK9ykNpg80cAk0Xr8Xyn1B14duMgUfm6xzgHoyLm9C35L3k9saOYpLK
	3Ews8XGyHF1Z2jqL0zNlGV/iRktueGYWv9u9TS3YJ/qNBhzahj0ufF419tBR/CTvl0GQJ+LFEGt
	fL3odoX+F7vhwP48Wes2nxcbUXIzjUUMJBeD4Dg8ZUyiLuxOfyBPQzufMFsQDxq8pPKa/jWsYkU
	D6yUdRz4PLISdOQkr9c3u6DZzcHt55FhqwPHNggcNljIgiAUSC2Bu5lVMxoV0/ViWXiQ840Dv9O
	8rpVu4zlduySyeL0dCgZx4uQYHBwCXFRB7w/j3QXQ4r6YfKvW5MwzsSQaCYpp3HBRSQ2
X-Google-Smtp-Source: AGHT+IHkhHsjr2gLT8Ve1Sx3IQ03TqNe2hZ/KEE0KQj7rKla0oR9QG4GMVxeSmrYPKbVJrqgOXLaQg==
X-Received: by 2002:a17:90b:50c4:b0:2ff:6a5f:9b39 with SMTP id 98e67ed59e1d1-306a47f2ca5mr10316513a91.18.1743845008573;
        Sat, 05 Apr 2025 02:23:28 -0700 (PDT)
Received: from henry.localdomain ([223.72.104.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb91b9esm5139782a91.45.2025.04.05.02.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 02:23:28 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: sudeep.holla@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: cristian.marussi@arm.com,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v1] cpufreq: scpi: Fix null-ptr-deref in scpi_cpufreq_get_rate()
Date: Sat,  5 Apr 2025 17:23:14 +0800
Message-Id: <20250405092314.76297-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpufreq_cpu_get_raw() can return NULL when the target CPU is not present
in the policy->cpus mask. scpi_cpufreq_get_rate() does not check for
this case, which results in a NULL pointer dereference.

Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/cpufreq/scpi-cpufreq.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 17cda84f00df..8f0da2a86e4b 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -29,9 +29,16 @@ static struct scpi_ops *scpi_ops;
 
 static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	struct scpi_data *priv = policy->driver_data;
-	unsigned long rate = clk_get_rate(priv->clk);
+	struct cpufreq_policy *policy;
+	struct scpi_data *priv;
+	unsigned long rate;
+
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (!policy)
+		return 0;
+
+	priv = policy->driver_data;
+	rate = clk_get_rate(priv->clk);
 
 	return rate / 1000;
 }
-- 
2.34.1


