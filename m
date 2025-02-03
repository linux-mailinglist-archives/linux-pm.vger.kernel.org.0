Return-Path: <linux-pm+bounces-21291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9F8A2576A
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 11:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DBB166CB9
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 10:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B54220125D;
	Mon,  3 Feb 2025 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fu/SaBch"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E482010E1
	for <linux-pm@vger.kernel.org>; Mon,  3 Feb 2025 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580062; cv=none; b=E/mi1QfVEyzKA+cfCjjO7DbqmjyRKa9gNFtBJb0OYhX2eBJrG/K5MT9esY7oTnk1s5cX42yR35a9vpHOaIHd8YrIpN84PB/Jxj2NDFUQeqKJWPj7OOr7Yp0h4ijcs5KpKXpNVUSfE0m4TAJaCs4p5l/ZtyerBWJklOFpHKXCGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580062; c=relaxed/simple;
	bh=aa1FV4l+STIwrscM9YECQHnEnudQCLxRLs9TbwVG6pE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SSRQZq0wss8pbLA431IMl81T3jRtETOlIGNec7pcoKlLywseJ65TX9IB8O2iWHIdHWJWjUTviP/oTRHs7hEVuje/bsEs1gCe2FwVJjFTErweL4BgHRKFSn2T3Kpz5QNZCeuN8j67GYaznAnQdAiQmvU7MgEVCab01wJe/n3OW8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fu/SaBch; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21ddb406f32so64899835ad.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Feb 2025 02:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738580060; x=1739184860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zgoepmzow92M5TjxAmUfNkYISiNmmdFHKPfzWUElINg=;
        b=Fu/SaBchJNT51MHHPAGUa+cXrPmDFJAmBUixxYtO3uzmp23UrARRFgwgxpjjSusjuS
         Xqz+1FHfOC8hft7SdAQvAmRXJ9NPTnUuiu2eN6byCysQqHXibqb7sWqMoZV11MdKEDYk
         yMO2DsrzEnP9w5ONmlV3g0S41qTHOcYFviN3WvlPefdfmmXLlacDk36ADoSowz3LXE/D
         rm4x/T6lzA0cUhshtDnTTt2XiuZl+GeN0+BNVM147x7hEgJUekdSN4J3Tv8PgwnpVLqJ
         ZneCMP8j2eo2JX7JwJw4jwMa+XkuT5URF1l7ZAUAK3xp9Gg/QMhSsPEVlfujxE+hX5fm
         +dGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738580060; x=1739184860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zgoepmzow92M5TjxAmUfNkYISiNmmdFHKPfzWUElINg=;
        b=jnX5bKf7c0Xn8uEJ4pptjWCK7FKHFoCuwunuiPllCXojMnwdjIt96duFL4QhHnsDXf
         VWRgNfYTBPTPtMNTNiGnnaiEy/VLQhQqIMxsVzSA1rvbb1bjDN3a+wkv3jYGssGXC89a
         lpLkeRyUw335Nj/tIN89mlz8MhF7Z7lmrud5k4jZnDgfXhodbWw0HmtMXvpCLNanLkrA
         psbMhW6KoOGTrIL+0pJDuAMPCdNIjkbyYIFA7at/kMXcvUIS0c6o3Df/QRcn3izwXLiX
         xVcFg4mx1vPHyYGxD46E7nw5vXab305bqjB1SUMuPLc7tVS764WIwasXZF9w3gIq7x9p
         zHWw==
X-Gm-Message-State: AOJu0YyBrYqNowh+Z/WZAeFymr1kMuyuse9KVvo6URc3lDbLKRRrFNKi
	09iWGH5yQL7/wgq8nj1ewaIlhAGIOj4h0PmXMjYditCfoyXYJqZlRrHbGz3uTNs=
X-Gm-Gg: ASbGncsjBP/g7Hon2BSShcJtu/KXl7Owb+//QSHUer9EULB4c8LdNza/3e70L5ihPPX
	KW2UMxENtdYUvPCkbTK/R7+edPH4FP/NC3p8643Mb4r/wnpSvXZqL91Ibihcopf3XA6Ol/Np2Hd
	39Az5nzoqIBlgam3cg/qioxZICL7+wWH1kl4YwWfWdRwIvmJxxWVOkdekhTRzoTC/u5v3KZ4C02
	aIBWvqcKsv0mJlByDqL7X4jPpLFw1mTRE3gFWNDW4ZRsLFRFzJcdwAuwy79jY9NQ5blQ2PLdXLc
	aC7ObThMQarvi0GjzA==
X-Google-Smtp-Source: AGHT+IFqfHSwetvYfA/FzIoXp3I2Mqr/lsbSnyEV3QTlwurazJwiw64SL9y1p/I4Ms3nJKLMSyjBcQ==
X-Received: by 2002:a05:6a00:acc:b0:726:f7c9:7b28 with SMTP id d2e1a72fcca58-72fd0be1799mr37521013b3a.8.1738580060025;
        Mon, 03 Feb 2025 02:54:20 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba3c1sm8364034b3a.108.2025.02.03.02.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 02:54:19 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] cpufreq: airoha: modify CONFIG_OF dependency
Date: Mon,  3 Feb 2025 16:24:15 +0530
Message-Id: <9d51d2710061dfa7f2568287c6ed125b858b7318.1738580005.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Compile-testing without CONFIG_OF leads to a harmless build warning:

drivers/cpufreq/airoha-cpufreq.c:109:34: error: 'airoha_cpufreq_match_list' defined but not used [-Werror=unused-const-variable=]
  109 | static const struct of_device_id airoha_cpufreq_match_list[] __initconst = {
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~

It would be possible to mark the variable as __maybe_unused to shut up
that warning, but a Kconfig dependency seems more appropriate as this still
allows build testing in allmodconfig and randconfig builds on all
architectures.

An earlier commit, b865a8404642 ("cpufreq: airoha: Depends on OF"),
tried to fix it incorrectly. ARCH_AIROHA already requires CONFIG_OF, so
this change does nothing, and the dependency is still missing for the
COMPILE_TEST case.

Fix it properly.

Fixes: 84cf9e541ccc ("cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver")
Fixes: b865a8404642 ("cpufreq: airoha: Depends on OF")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[ Viresh: updated commit log and fixed rebase conflict ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- Fixed rebase conflicts.
- Updated commit log.

 drivers/cpufreq/Kconfig.arm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 0ee5c691fb36..9e46960f6a86 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -17,7 +17,8 @@ config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
 
 config ARM_AIROHA_SOC_CPUFREQ
 	tristate "Airoha EN7581 SoC CPUFreq support"
-	depends on (ARCH_AIROHA && OF) || COMPILE_TEST
+	depends on ARCH_AIROHA || COMPILE_TEST
+	depends on OF
 	select PM_OPP
 	default ARCH_AIROHA
 	help
-- 
2.31.1.272.g89b43f80a514


