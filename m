Return-Path: <linux-pm+bounces-19005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2676D9ECB0C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 12:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08A518896A9
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 11:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D3E236918;
	Wed, 11 Dec 2024 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMT9rPcP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EEF236907;
	Wed, 11 Dec 2024 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916201; cv=none; b=fRO2DuVhIWSuImIfWgUDHJrHpAd78jvs/U4eQnZjGqhRquK4Yh4F2CdHKVDbw2aJ1huokL0Py2bFlEapQ4+OJJ8SKmNl7TAlqU4G56iIi03sxGzj1At2oZod6DhOFMw4JzCDnupwFmWMyp7K7MaUwnO3n+t5iPL3YBSocgX5CQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916201; c=relaxed/simple;
	bh=lSmc5lpStkRdh6T2UaHkJlaMrEahYyD8GNIRGOk35wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBtWG0n6AJwm2cCgXeB0eYdojg4QNg3TU0LlsqUo3Po05jQK/fUVQUwvBWXs3athHp0etnq2mhqrOKZ56DDrqs+BLugk2b4j3YaHD5kyCYGB3+g5zaaSGB3KyTQL4MnMaHHGd+G8j1LOYmuth/HVMgjAi8hL8LxwwIKbfMMPjP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMT9rPcP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216634dd574so19627275ad.2;
        Wed, 11 Dec 2024 03:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733916199; x=1734520999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11W4ToO5h1HZTorB4p+IfX/arkj3h4R3MbzsYg+yGqg=;
        b=LMT9rPcPKygud+KsMONRhw2mdB86YHjFPQH2g6snq7z6OY7hbMKEvXkH9NiODkXk0E
         fL0pX2bdWSshbsxiLL0H3lNBYFxPNo4jFDCC6MswgxGJWiNIhIEhxSE+cnKM/Z76bIKg
         VgECuyoNJ0DLy4XuNjCWWdQeDM5eK/1WOiAVuRvldxRmJT+QJvmo/As6RhNZn8WqJ1dG
         5hX6eO+tDbndM4ImpsvPGJ3aluLg2kSe4dKsJY9LLQSc1A+S2iUdRAuy9HX7093TaJt0
         os9w9twpOhPEL+zJ1s7WVGehOQTUqey0Kk4ghTF+rsYvK7cM6Xjaax1XLwqY+b8jmEEO
         M+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733916199; x=1734520999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11W4ToO5h1HZTorB4p+IfX/arkj3h4R3MbzsYg+yGqg=;
        b=AN7B7s0Q8HDNWwDEhXmF5JbxInnenruEh7BOHhb2DSDboVB3sLYlmFOd+4EXkApnsf
         8Y/GmguARtZchnQ0AUmn7C5EdaSyRCMwso+a7ENg0Xzob7Qjoo9OO0OvdR0kmS7pSaI3
         TSw5THYanMwL6lpucxEcAYMhQgIE6MJL+lVF/CIjxxBHaHFypt57qxizKSgkilFJyYSH
         Zk//45OY5hsmPt700Ucn+xGbECaRTr8OLgqqJ7xC2bAfQzmfTWFkn7NYUjqSQJRXsQTa
         5693jP/5M/rx6D1juFsK4bSTpN8ynt2QskZLzZPvCa7q3e8jq38ISp+CQ5oFTxg06oim
         xzWw==
X-Forwarded-Encrypted: i=1; AJvYcCUALgPPyUxOAav/a+KdZifFXNRlXntXqcCMWypk+kbj1z3SsWC9rHYZseWVC7XLVj6aD1U17mby94U46ixI@vger.kernel.org, AJvYcCWAIlWeup484uWzV7D7MjVCzOXVzNPeOrjf1VUOAtlKsyzPX74+vl9p4lYf93PWh/GnPgvNx534wjB3@vger.kernel.org, AJvYcCWa0HUGozOiyQA/n4T/GDYTH335iZrRYMkZsj4Fdr1PtatMhRFwwvvVmuR6sQAXUkK6z9zRWpg0aCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPsdrFN6QczSsW5V5dMqE7Yuu+MsbTKh10JD4k0MnN4rSakfyN
	LiC/4OTOaN6NLqVJZHU1ZkCKjnFcCcBLRGvc1n1t/YiEdXy7jYkC
X-Gm-Gg: ASbGncvW05hpd7t744LA3YFTH4hx3q7iTO/uANFakYEK4EXlIaEXS3YVOXfdXiuRNb8
	BV3hLc7IKpHMW04PVnCApzkSLsPCgouW6/wH/kwgu9D8ctzFuvjt9xkv4uPWcbxNST7VLpYFJ2Z
	AO73YOe4wgE3vcDuRTrbOlQCf1ZMqr0P2IvMWjYBOKeAi4FDs3ljHcHTJn8IStIm3n+HfLB4V44
	weO3W+HMOTMhLzbdtjoLPa2e2obnMDRRrIE0tmgTO/xgucxvDnqHL47f32Gx7gjsMdD1g==
X-Google-Smtp-Source: AGHT+IHo+Kzzu1G9jRKGQEFBse9aRUgQJuEW2pdF7vw9TKlIsPyr1dSWpP9Ey4Q+GR2YFuS1mJUrIg==
X-Received: by 2002:a17:902:c946:b0:215:3849:9275 with SMTP id d9443c01a7336-21778562d49mr36068865ad.49.1733916199490;
        Wed, 11 Dec 2024 03:23:19 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21650ccdc7esm48956615ad.133.2024.12.11.03.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 03:23:19 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 5/7] cpufreq: apple-soc: Increase cluster switch timeout to 400us
Date: Wed, 11 Dec 2024 19:19:32 +0800
Message-ID: <20241211112244.18393-6-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211112244.18393-1-towinchenmi@gmail.com>
References: <20241211112244.18393-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apple A11 SoC takes a long time to switch. Maximum switch time
observed is 345us, so increase the cluster switch timeout to 400us
to be safe.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index b27d261fe5a6..94e57f055a5f 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -53,7 +53,7 @@
 #define APPLE_DVFS_PLL_FACTOR_MULT	GENMASK(31, 16)
 #define APPLE_DVFS_PLL_FACTOR_DIV	GENMASK(15, 0)
 
-#define APPLE_DVFS_TRANSITION_TIMEOUT 100
+#define APPLE_DVFS_TRANSITION_TIMEOUT 400
 
 struct apple_soc_cpufreq_info {
 	bool has_ps2;
-- 
2.47.1


