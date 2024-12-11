Return-Path: <linux-pm+bounces-19004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 683BA9ECB08
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 12:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D47416A106
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 11:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C0F2368FB;
	Wed, 11 Dec 2024 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz0ojCv5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209A82368EF;
	Wed, 11 Dec 2024 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916198; cv=none; b=B8vxUZiXO68jlA3SBdYRuKfy3D3zXrnD5Tph0byzyEC7R7xmhnk1nG5aTOluOtfbho0VcTArMjwx/oLK9aRotylmG/ER8wC7fFcqVVrO6SNJaYfaQPcCfATQQj2wgDp//8+zrq7CHyMvU8pTm/OV2J8eushrxr0VWhfcf3MUUf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916198; c=relaxed/simple;
	bh=xZAYewJHUZWNR4AiiFT7ZCFsiAmElXgtdpZlXkHdURc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twQzR29Mu6KP+grINHrO69QXgQprZUsN1h88ZUqjcwcECLpUV1qAQJUh40ujO/oEnnT+2gBFFbTh61x/nVU0zGpjmpQEnjX1TOImSswyFcOr7uO8Q5l1u66ykiK+5sEIcdTHBcYQi92HtyURhQpJuN1wJ43aPK/jB2TD3cRA840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hz0ojCv5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2163b0c09afso35131965ad.0;
        Wed, 11 Dec 2024 03:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733916196; x=1734520996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbzFAeUuXXanJwe/RhcZGcox5IaVXp9hGHM//yffMwQ=;
        b=hz0ojCv5WC13GdjzAjvmO3yQaONh9w+yNLyV60BrIG84+uj8CZR6gEnnxhyV+hSYvM
         +FAMJDOkYLCsbXC9wek4aedeMIcps/xMKsr/+/lieZCDUyW+gvppOm5IW31TW1kgCvN5
         NrCFOvoXI52Ukc9vzjn68nwT3/iiIUOluM/8ZlR7qp5QNPKcjbDQSe/liuSxMa1rGNlG
         Grgw3pGqqLuj7JuwG4rlYKNAmF0uJjXPEqhq5e6/q5GBrH81zBOKJKZF/Acs6bGOB156
         8bYetmuNuEAFLGYvVVEnoefsbKquXzp4TiCuShx932h+KJxKy41YfKDzrPdljZj0Rixu
         vv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733916196; x=1734520996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbzFAeUuXXanJwe/RhcZGcox5IaVXp9hGHM//yffMwQ=;
        b=UTLXKJSDgtghbdojY89cAsa2wC8kHv1lQRzf81oacv6kQ1TzlaQm1jYEGvPzboAWkn
         4OLSW0yskKXeqvnlJHl51ALBUB0bDqqL2/q/qVRkpQgkvVJfFIWsXeklJhaK8+g1+QdO
         n/caKUqB3k2Z434UjqrxtzD4Bi9sBtKCj6dMtCHmeYIQLQmfhrcjcDxKWnxbBVoTy3f7
         yQIGDGkFLsUAdMiAJunhH3ATFFafe3ysSMRqOeXUP6EQYOsCZpzBZti+o11ZnS+j2tSq
         l7+kd6byEmDbu2+FgZ7uyFY3mZtq/oKMDmsQhaG0K4KvUTAjJJIGcMJn4k2ZMCOxXxha
         FShA==
X-Forwarded-Encrypted: i=1; AJvYcCUHbwz+hy/DMw3NtjNj2wUh89c7hBQpWkRuv8EYMf5s0sma+EWSL7zBE8txiAyRbFu2VMdPuLqlYTivyuE6@vger.kernel.org, AJvYcCXg0D9keZluhhwmoFNWiIl3lHl97USSM/QG05+jdTVzqThn+IYjdDcJIJ+rKP/CwvC9GJSPLmDmZNI=@vger.kernel.org, AJvYcCXwiTnoNRACgSJLRdmfdM+F49yrMYbxxK8ot1b1FJAJxJryojumdl0YfRw0XaR/CkRVDMG5DRky7I/Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7444pEsDDPYGhB9dWRs+UgEP5oYikUlKAi6D1IVZ+wtWJRWrl
	4H46BxJbCPEe3oZnZmujhEeEwZtp3YI0pdDTaIHUvZXEQYPts9+9
X-Gm-Gg: ASbGncu9gSc18+UOiKbmvYcD+JZIVv4yOK2VsCk02Eh6dMAJx8b/g6I5XttD7MX3Y/W
	ETTkOdxHQWETQ2e0UDosud8mItCC2R3sgXQ1mnS4CBNBrABYo6rH6uWg08t2uDMwW9TeGlqIexI
	ac+Hfkippug3aSeZwieqGeCjsNVIwPYJCqxU8rp/kV9KFKKB1rkwLIh4gaVDstO4UQfg1ji2X1a
	mIoFDEoWDb9zCMUs7xQnz0oVWFc9B4oZreVEF1rBKo4XPc3srWLMT/VVMM/N3O9pjrseQ==
X-Google-Smtp-Source: AGHT+IH1hLAgeQvAxnVwe+D4VMDsSZTriCt++kQ7emPExGGKhpzABy5H4MFcc6Iy+zePAn8dZNzF/Q==
X-Received: by 2002:a17:902:d503:b0:216:6c88:efd9 with SMTP id d9443c01a7336-2177851dec4mr41331435ad.15.1733916196279;
        Wed, 11 Dec 2024 03:23:16 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21650ccdc7esm48956615ad.133.2024.12.11.03.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 03:23:15 -0800 (PST)
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
Subject: [PATCH 4/7] cpufreq: apple-soc: Use 32-bit read for status register
Date: Wed, 11 Dec 2024 19:19:31 +0800
Message-ID: <20241211112244.18393-5-towinchenmi@gmail.com>
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

Apple A7-A9(X) SoCs requires 32-bit reads on the status register. Newer
SoCs accepts 32-bit reads on the status register as well.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 90e34105b50b..b27d261fe5a6 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -122,7 +122,7 @@ static unsigned int apple_soc_cpufreq_get_rate(unsigned int cpu)
 	unsigned int pstate;
 
 	if (priv->info->cur_pstate_mask) {
-		u64 reg = readq_relaxed(priv->reg_base + APPLE_DVFS_STATUS);
+		u32 reg = readl_relaxed(priv->reg_base + APPLE_DVFS_STATUS);
 
 		pstate = (reg & priv->info->cur_pstate_mask) >>  priv->info->cur_pstate_shift;
 	} else {
-- 
2.47.1


