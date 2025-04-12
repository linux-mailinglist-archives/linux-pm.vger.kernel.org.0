Return-Path: <linux-pm+bounces-25315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE78DA86E09
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 18:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56291899666
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D691FFC50;
	Sat, 12 Apr 2025 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbmG+V4k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C0E77104;
	Sat, 12 Apr 2025 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744473924; cv=none; b=TnXcTMLXQxLgpGxMFkni6hoU/u6y14OKyS3xh6XTtRFRNpaJJpUr+mp6KZcKLDYuDdw9o0XnqRS9tNnngmooaJH22/CMhqx1GMLwZm+3SsVEB6+gw7b1mU44iluYMj4RZm6nXIssJlybHR6xNuheB4uErMfcAHpFJZl1dyxgV+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744473924; c=relaxed/simple;
	bh=pmfOx0ByssuAb79V71tEtlJ1QVhMnmrwa7zyOqEos0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bo1Abi1JY5zKrGg//96MIHIh1Z9Q8JqWF3YcY/JaHfWwY/OcOjeSNS7pErRS7eM+atLrLwBRrY7/7CIR9F8cn08sQf2VkkfIHJL1lVm1xdYL8nFRu6ua4X3c2rXHxRxW+V8FfaMkT72i5vIV4ioETHKZ1iTSJDIPcr+Dym2l/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbmG+V4k; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47680c117fdso5669381cf.2;
        Sat, 12 Apr 2025 09:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744473921; x=1745078721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=18rNRUozuuywP1tNu8idsUvf4lnx4Kb0IvyRGbZ6T3M=;
        b=CbmG+V4ky2rD/qydcEVbrhIZ5weCgHwhSxK8/Unkk8QR0KXElzWmAnMlgbh7AGEb6t
         FsK3lJNyaxPyiV8ltTBtQfTL0/Zijsv5sff9QQ/GucpPJl54S5GTDzGMg3RlP6vNma3h
         hpEtKXnj4DEmG/vUYz8IpJuVM+Mj+EzQ9jxh1RpXRHwtzPpnqCsXtcJn4RS1fyP50zp+
         sO8zsrgqvU2lk6HWAkSjP9l8aSqY8TW2zE6ER4qZW4AWZLLpFch/hctpl6hIdhDybAaD
         GlQnPJNwbnRfANdglh/Nb47BhxpaiTfycf59EgGOwFWMbom2kGDjGbtWgEG/aQtl5bqV
         4I5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744473921; x=1745078721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18rNRUozuuywP1tNu8idsUvf4lnx4Kb0IvyRGbZ6T3M=;
        b=MIj5LicnAz/rQ77HRZYO0E0NtlwGUcL4orFed7oyJzofReGJ1/RVLHnosriDJSVCGf
         wpLf7UBUnVt5Vbw1+3NsQtM8gPPrhYO5QQEzqa7ppSUFUplbi1RJV2tTTxYHvm/OGrd5
         7iNwIe6Ls8WPdkEWN/YW2QbP/62ozPMF4x3lazQcTHCWX6fXkirlSu3piMEoXZV5EuTz
         DfWnQGbtziToS3G8E939YaKYwG3G0EYL4uLFWeSj69U37b+kkOv0jX5h3SgqILuezqdi
         chUrGv/pMbJt0chWLeJmL45Bb/4KOfRRvLy2t8Z/3ufjgzuws8wNtku4nzYYTpdyIncR
         6e0A==
X-Forwarded-Encrypted: i=1; AJvYcCVPcfXzgtZVhkyVuqprwj5BXEP1Gzc4Bmz7A+a9eg1ayKXqRFeoyp2iyT71mJPajxI1r5ENoH8XqtLAkHg=@vger.kernel.org, AJvYcCXkcFVj9InF0VyKXFwWpzG5h5bN2v3l/sqfX0aNV+y/dgUIXV/AFUwbvd07USgpC5yy/BG45C8vll0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyipUl8KEpRsHGbNLEfGZIpAKuJPOyAyGJEYNADfmW2J6hhgDeE
	ccLxt5sLNeaIIhEBmep+dcmU469Rsj/El8LmXhX05VV6wS4Ox7+enjCO
X-Gm-Gg: ASbGnctzbHd0rGTfkYpW0OVyyrDn3+mHOOB8jBfb65DaPHM5M3otGczpauUcf005Stj
	mfSKFvYsL2TZdH5L75UixGwlO2v8kz2gQe/HniMlE42N172lxgZEVl55j2YykFuNKDgrOmP0r8a
	lyRkdLIet0OKQEz+MLZM8EXVPcwD9+YsNpptmbzqUsEDxttZC0/lv8y9YIOxUaoLg9XPHvxgYYw
	40bCwrLEuXkSWVo0VZnxUR6Q22TbFvQQlo9HHA9hqdzq8XsTfn/MbkdZGGeQ6kVvtRjPcp2BPAF
	LNSmlLEApaMmPSOG7fV4Oj5UJb1qJ+uGkXYOdA==
X-Google-Smtp-Source: AGHT+IFiHWb94k652mgAZ/ZDuGpTVK6w5j1J2J86j0VwdFWpYKq46BdH1rfkKZVmctjSl9dXg/cPAw==
X-Received: by 2002:a05:6214:e4a:b0:6ed:2289:6623 with SMTP id 6a1803df08f44-6f23f191ce8mr39928946d6.10.1744473921131;
        Sat, 12 Apr 2025 09:05:21 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea07f3esm51541616d6.76.2025.04.12.09.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 09:05:20 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: sven@svenpeter.dev,
	j@jannau.net,
	alyssa@rosenzweig.io,
	neal@gompa.dev,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	marcan@marcan.st,
	maz@kernel.org
Cc: asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] cpufreq: apple-soc: Fix possible null pointer dereference
Date: Sat, 12 Apr 2025 11:05:18 -0500
Message-Id: <20250412160518.1824538-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if policy is NULL before dereferencing it.

This is similar to the commit cf7de25878a1
("cppc_cpufreq: Fix possible null pointer dereference").

This is found by our static analysis tool KNighter.

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Fixes: 6286bbb40576 ("cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states")
---
 drivers/cpufreq/apple-soc-cpufreq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 4994c86feb57..3de9bb2b0f22 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -135,10 +135,14 @@ static const struct of_device_id apple_soc_cpufreq_of_match[] __maybe_unused = {
 static unsigned int apple_soc_cpufreq_get_rate(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	struct apple_cpu_priv *priv = policy->driver_data;
+	struct apple_cpu_priv *priv;
 	struct cpufreq_frequency_table *p;
 	unsigned int pstate;
 
+	if (!policy)
+		return 0;
+	priv = policy->driver_data;
+
 	if (priv->info->cur_pstate_mask) {
 		u32 reg = readl_relaxed(priv->reg_base + APPLE_DVFS_STATUS);
 
-- 
2.34.1


