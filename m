Return-Path: <linux-pm+bounces-25012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 558E1A82532
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 14:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DA0189B100
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 12:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C19125F97B;
	Wed,  9 Apr 2025 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyvYcbr2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CA625DCE9;
	Wed,  9 Apr 2025 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744202905; cv=none; b=Zfln+EeprVCbJ3lAYFIFI0J1DZllCUrp5rZPiby6cRgNj2VnjNowjSjYtIiy5p7yqC/+GHOKQzZPxdQmUpwTRUP0P4bgsw44IW4S0RapDLwyLDCeLiEtxWRFXzOyDvtcGnjyCeh5okBwr3xQQ1DUdlGMFyYXU8Mn+ZuUigexQz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744202905; c=relaxed/simple;
	bh=EY+MCYO6+/Do1rVBG7o49cZhvEu9A77dcSJzw6meaMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IrcN9a33efFBtfw03nwi/t/cDvYIrQLS5RHHr5KqLe06+QEw4D02YzZZbUuAstzUxDgqvx/5Q0J9M4aZFa8MtQYT+2q8kPn+NjDDcdK3FL4V4XT8HHNvNX4vHuhdFlaOH2IZ7PxvT3FggSbNXpo5gIr55a7EDVay5jC3UZX/L5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyvYcbr2; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-ad51f427054so4514424a12.1;
        Wed, 09 Apr 2025 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744202903; x=1744807703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3gcS051l6b/8O+Is0vrcSeaFJGvMI4gz5XJTgTf8jE8=;
        b=NyvYcbr2axzf/tNhZdie40oLFLQLBnamI8puS9xetKMiTPhRzqn46+Cd/5hJIYme08
         eyR6VnWUe+Kr6wxzlGS1zZMSfMpElRzULDREdlrmkFgdOQ6PKLHZTCPu/G267cZ3BZRg
         9xgTBTlqalpiwRYYDDY7R9NOsQQOLKA5XswJ+iCosxehZ5zjfBjj9FD+HiUKhydDwTij
         8Sx8GzERGysNZZQps9Mor2bfXVkClxW/JCPZlAGduPB++pMO6bwateiqw2yVZItDzNAx
         /agPXjiDIhC/tHiFDpXt02EfSuHCZpRFgLN44kNTxBdo8J0ReXKxZGU/+GW8aurGloSS
         YhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744202903; x=1744807703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gcS051l6b/8O+Is0vrcSeaFJGvMI4gz5XJTgTf8jE8=;
        b=r+z8+V1AfSJ6lIeubyP48kNKBWEVDOnXRsAohDmdi+2S3VOvYiaDKvn3LX6VdwF74B
         vB1ePEROQig8wXCzBdaLxEI9wUnQOUluHSiyAAJl0fZ2pHLEvDMEYIvkRUMTufn7SLW4
         hM3Vi8b8DYL7T5egFV2nQZUxNW74wXE8Evd+/H611suxvePSQSf/5jB0O6H6LfJ3/D56
         ldfRPtNQOFC7DEMXHJUG1oGd28l+i5k3w8IOfTO/TZC8Jvy08qlFr5Jk+JWTtQZHcTwZ
         W0W+EOTi9JMfaTl+C4XmpSjSMR1au55qCzWhoW6tJZPWjKz+RJ72PdnAbbolylgV47Gu
         b+eg==
X-Forwarded-Encrypted: i=1; AJvYcCV2+Gs598GIqGuQabZaeF4kmMwIt9anE06P+eW1omqYXYcHX2tRNNlDlyEceyk2/wWjv1PZD57tI5M=@vger.kernel.org, AJvYcCV6RoBWUYfl90paV86w2W+Y+jSz1eC/nz0ekHo03F1Z9BVR98L+x+mqplisSKvoUYvapbv//KONFVtKCb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3EhvI0p8qOyMiJZ1bv0Z1IF+xgtUPys3E+62qJ4q6vfdJllb8
	WKjuzqpYRurX612OGN0g/ToXuFIX82H1HebGeeHFX6ViSh3CJ9jL
X-Gm-Gg: ASbGncsBzzTU1R3COGOF36yJgdEig9uC7+nuzFEEUHg/F8AKOoUZRaDelfEQsTTbZrv
	naUKTptPE0TjlnyX+VmP18F94sleAJvJSktcl0X5v+JSFIq/C6TxoXNvwYOnDQemQpAXqHy4LNA
	J1BLzR97vMZXyQfwjRplVfQiHKEUMNRKsDgOPT6OWk+9nS/Fkmhuys9a8CZErEbrwIFKtfKbG6u
	kGP0MdVw0KbzczBa3Fh5hvFyljAZNIfB+lq5r6CkxGJAaB4dFoQyC/8E83AUrgnkK8hlziBmL5j
	4KpU+QryDN2MghNyps5V0qStkmP7epzrN9V6kK8KBYMC6FjlVgqb8ZzHsRHSQngbqeU=
X-Google-Smtp-Source: AGHT+IFsp1KO7SpkI4Baqzu+PaivIakGq5Ke0rYEIizxnBYl7OLpEKVhaHzNjOfd00JduABwQS6jww==
X-Received: by 2002:a05:6a20:d490:b0:1f0:e3df:fe1 with SMTP id adf61e73a8af0-2015ae8f37amr3086206637.4.1744202902625;
        Wed, 09 Apr 2025 05:48:22 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.133])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a11d2654sm1103588a12.35.2025.04.09.05.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:48:22 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: sven@svenpeter.dev,
	j@jannau.net,
	alyssa@rosenzweig.io,
	neal@gompa.dev,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v2] cpufreq: apple-soc: Fix null-ptr-deref in apple_soc_cpufreq_get_rate()
Date: Wed,  9 Apr 2025 20:48:13 +0800
Message-Id: <20250409124813.47193-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpufreq_cpu_get_raw() can return NULL when the target CPU is not present
in the policy->cpus mask. apple_soc_cpufreq_get_rate() does not check
for this case, which results in a NULL pointer dereference.

Fixes: 6286bbb40576 ("cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V1 -> V2: Use `if (unlikely(!policy))` instead of `if (!policy)`

 drivers/cpufreq/apple-soc-cpufreq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 4994c86feb57..b1d29b7af232 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -134,11 +134,17 @@ static const struct of_device_id apple_soc_cpufreq_of_match[] __maybe_unused = {
 
 static unsigned int apple_soc_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	struct apple_cpu_priv *priv = policy->driver_data;
+	struct cpufreq_policy *policy;
+	struct apple_cpu_priv *priv;
 	struct cpufreq_frequency_table *p;
 	unsigned int pstate;
 
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (unlikely(!policy))
+		return 0;
+
+	priv = policy->driver_data;
+
 	if (priv->info->cur_pstate_mask) {
 		u32 reg = readl_relaxed(priv->reg_base + APPLE_DVFS_STATUS);
 
-- 
2.34.1


