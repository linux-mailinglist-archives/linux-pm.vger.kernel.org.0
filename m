Return-Path: <linux-pm+bounces-19441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB3A9F6D50
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567D618956B6
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 18:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3971FCF45;
	Wed, 18 Dec 2024 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqPImXtA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E31FCD06;
	Wed, 18 Dec 2024 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734546556; cv=none; b=iWAKRx7Ao8drwYIGQTFpM/IhuODpfJXGnGEDYV2XIRg/ivkSvvlIpU3Z2NMxG1KDgDSJpcSxtKodeGR7sS67Z1OYBvhyJY2lfgVXQRPvfaTckjvK+DIc5JYVHyZr2wO12FFUOavfSZHA/YgOvr6OaLZN7ujH4HHGVwJoltTFmZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734546556; c=relaxed/simple;
	bh=lSmc5lpStkRdh6T2UaHkJlaMrEahYyD8GNIRGOk35wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EV6S+ZWzG6Jf7ujxUG+VRvMdMGJ9b4h3SDxYd6VDasq96TPgIxhWf6CBSfvL4puTzauA5eoBTBIi/5ENWgnIaA8kD53mZ2LFjDZFbD9NMi3yqQTzC796ykSnlPc/ilwhrtuh4Tg4unBoFf+PtMNQbdP1RaiTdGy6d3fQVYmHeqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqPImXtA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21644aca3a0so82122185ad.3;
        Wed, 18 Dec 2024 10:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734546555; x=1735151355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11W4ToO5h1HZTorB4p+IfX/arkj3h4R3MbzsYg+yGqg=;
        b=LqPImXtAQXyarzKcdffoxVQT+8Ki68jz9OXEW/A9Nnv9plDz2f4Gskn26gqK38OZgt
         zbpbuvx/1m+/ieKiJxFRDIa4u7Ynf5ds/fDwEVzvnDhBid7Ox0Ux1M6//8OGctaS1mdJ
         +RZU48tXLbNfHrb6XKOx6iph1C+3+FIoA9aKKrSfi6Ee8kgHKcINOxP0qkGV97SYv01z
         PmE02Ps94rbGXIK9KryCWdXBIyvekRpD2lnOiR5g5KVPw5oA0h8CBjkRxAoELL9X0uLy
         7kTQF3YilmekqkfYlt5qZ60yzX0DgzloI1m3BIfKqW1us3wXAP2GPWQsbiLW1x+jU03r
         KiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734546555; x=1735151355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11W4ToO5h1HZTorB4p+IfX/arkj3h4R3MbzsYg+yGqg=;
        b=TjYuOCKQ355P8KPveUpPHlOixgxXjv3FZPKMFoGeo1i5MMl2jHr5Qe9F9tsiToXG4p
         NDTnJT6/NCtNuFVfhlkCzIxdmXViKY8dUq7Wv27Jc8s+aI7S+nsATVwqR5A2nKgHZ8pW
         zKaOyWQDHLx2+ec/Gge0lqPAFCGEaP2dmznY1YVUZF34aCgivad3+GOLYZ4ycMHOSOtG
         34E74SofsOUU8iwtj0lw5EnzRQj6qd+oL1h5aLk0O+bcIPUkkjD70pAr1XRJmMB0ZJOB
         Wzo0+TJVKJL9UD4Y79qpEgOBE9MMtBWB/kyOBKvBXftK78DaauENIJncXGKuky7kMfS4
         A+hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh5Jd/7NMvfZLpbIWvrl05ZiRAqAIVDz99cjb4cGOGAqp6S0MXKxDPpNkqUE0QXnjU7PU9q/f08+j0@vger.kernel.org, AJvYcCWJMRvlEhjKxFZPGhQ6tnYRVecgAnuY4ARBKGyQlaGOlHoC/NFcz5UegTMD2jBu6NQ6+Jut86P4WJo=@vger.kernel.org, AJvYcCXiIn7t8h56BsBUGS1KjJBu1wFEKXtShxOtMW2yGXdI4Cnf9olKpvX12rt7A43CleNF7m4Wy92ueuRGK8Q5@vger.kernel.org
X-Gm-Message-State: AOJu0YyMECdDx5es7X232UA5aPB7n28bYHs4ghmVDU6bkqcyTpBHqorp
	x3ocD9BAtHjVwAlUhrx9ltODfyNOhvCydczV7Lkx5G18bMKovWxo
X-Gm-Gg: ASbGncs73+aiFEMSYI+y3Biqvd6tcX9ehP9vKcHUPEZy1DIiNXGxPl7FTiboVukQ0Og
	Um75qrFbeHFUXkCL/Z9GATwgO4VDj/Kx8oAyB5+00wStSwXQDmoNjveClyWKL5hUiZ8mBpsNxlf
	TKURyXYGwebcxeXcNMWafQk2xG7B63D4ZDIWfdlSLbtrdpOQPKRi5NWVhxcxVaNAbxFtoe17jiQ
	z9oKgsjE5UHKwZqWvao4QMLC4ixXjU+eEY2Igg8ygTpdBr3OCmcFbTuGw==
X-Google-Smtp-Source: AGHT+IGGkzD5I1MEo0iKpf3ViMZnzuOuLHWt5lenYWuouWbqfIDA4yXHbjCexInJBE+6e0MeVf9ggQ==
X-Received: by 2002:a17:902:c410:b0:216:56c7:98a7 with SMTP id d9443c01a7336-219d97f7eb5mr9892435ad.53.1734546554836;
        Wed, 18 Dec 2024 10:29:14 -0800 (PST)
Received: from nick-mbp.. ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-218a1dcb3ffsm79202565ad.75.2024.12.18.10.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 10:29:14 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Asahi Linux <asahi@lists.linux.dev>,
	Linux ARM Kernel Architecture <linux-arm-kernel@lists.infradead.org>,
	Linux power management <linux-pm@vger.kernel.org>,
	Devicetree <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v3 5/7] cpufreq: apple-soc: Increase cluster switch timeout to 400us
Date: Thu, 19 Dec 2024 02:25:07 +0800
Message-ID: <20241218182834.22334-6-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218182834.22334-1-towinchenmi@gmail.com>
References: <20241218182834.22334-1-towinchenmi@gmail.com>
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


