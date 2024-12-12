Return-Path: <linux-pm+bounces-19100-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 960A79EDFD6
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 08:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4AA188A838
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85515204F79;
	Thu, 12 Dec 2024 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQs9Thfp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F232E205510;
	Thu, 12 Dec 2024 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987089; cv=none; b=G9l0SBjKg/seFgX+wPgUWmm7Wq9CpFpH1M5stL81z2wFFSl8K48jU8U0W8jNsMk1TpqrDtQ6xzSy7eSHF6+ttDXQjeoLfuXtuxOob6UkDl1iiA+ArBLAkyBgxd5ionqlnyRJ2puhfSX6r+qsYgaufJvpASUZHfTL1AWLVbRPGws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987089; c=relaxed/simple;
	bh=BuOxgI2CbOrK9Hxnatsu8Mn/4pRiwpGqt9d6S48h8hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFsoKh959l86ElTBlnGrNDOTLEqvmJF2qw0/bpYfqh8xLPwkaYkq+7Q4rOxO3RGVeykWidSl/3Lfl8sti+w6wCQMkMA21V78yxiDYlwohA+tkTZlWLXFxwcZIhBAEVT7SL/rNHgPeuLbokX3XvkNgAQLfB+LMmVbyF/mkEd1dMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQs9Thfp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-728e1799d95so327185b3a.2;
        Wed, 11 Dec 2024 23:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733987087; x=1734591887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0xMWNhFbRFrvmQCRSO20OEZKspqHRsl+17s4y7Ifdg=;
        b=cQs9ThfpdPkEn4kolxgp+dIRgFztCbOBUR+hcyWOYdiczJNvPhQbQQG1lp2gCpt+uy
         1+MMTgfhDH/NtJxxJql4Z+bjbsKu+qV096fAcnU/HaYvGNqIuN1aIE2Dx2AKcdbmHHU7
         WmQWUExHwRtJkNcjzZFuiOZ4+b0bnZ5UJEZZfycn9BlX8/Nh0h2kuWcOsu4UhsakjEx1
         SdFystBIaJx0D/WBn8NVesPBfGuII2tTVmbobC/JL81rljlTFF2QEX063FzR5YHyQhdF
         SFIZSt3uA9Q75HQhVPRb8ZYufeoFLuPjfvqeVc8PnoBdTkmstvufNJx0KWsAgL0JNdt9
         5wBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733987087; x=1734591887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0xMWNhFbRFrvmQCRSO20OEZKspqHRsl+17s4y7Ifdg=;
        b=i/Ho7bS3wjoFZGuZ7OS+uAgtfr1CQH+nzpc7+IBomn2K1w58g+NV1hpDh07yseuc7e
         nwQEGkdKB3qVZYdp2lO7X2mswogy/8dsiECCfb0t7pBAXZ9kvDQ2BA0s/kBj1YvN5jlc
         wHeeSunLrcHFfvLEsT5zG1BJChfBfect0cCX5W5fSjyU3aVz8fQDajOlTv+76STB3WH/
         3/CrTu5eJQJGXayleB+tV4d8Ao0LlwFp+u1UIXWfzFiimnMgSeBuenaB5f6SoVxPgHSv
         hXDlgumXpSJHFf6HmbrgpIW3W3sB/CrLvDtn5+j6A/jD5WKWobKJfhkwnxt6K5mxUyx7
         SNyA==
X-Forwarded-Encrypted: i=1; AJvYcCWXGW4ytWAmue40C22B50iNZWour/EsM1Kfv/fsqvv7ApiE8eG0/jdPUQJ5K0vxqecZXszEZhm0baeMpZDO@vger.kernel.org, AJvYcCX0oV5sprUKdM3Dfbz2Fdfx+BGwmOg3dBrz7azTqqKysKFG5F7qucBuUMCL0LHd4mRR+coU5tFuhKI=@vger.kernel.org, AJvYcCXW3QytMlJeTCJ2xEUDuZnwm74EAvlV4w0qlLjz4+Cz+OsWlWL1devELKS5/NeHRzqnjdeBgaPTC07/@vger.kernel.org
X-Gm-Message-State: AOJu0YzOO9DQFKdSGC/oZoBxXoBLVD8GrPxAYoOfgO9COaOwpGRRDuEw
	jORW2NVVtI1Tz/FVEM66RT/if8FKh+sJT87tYKnbqKWSuviUjiiR
X-Gm-Gg: ASbGncs+PHKXXEOXZvuK9mVhDspmHKy84dl+u+OkLee3swJib+oVbZOzGVXtqtPCnIi
	tS96G/YXDIfIZ45/07WrDQRiSfotSeoaDIJpqb1inUbB3CI82YPJUBJSRn/pfP8dohmoNRVSm9P
	trHf2El1c9sKovPc/JbOM3oB8yKn/A9O+kd4DCjM1kKEzk0tKXUDtaQJvCMIkXGUDbp4SyAuMXq
	t/vNi2VBVjnWPYz6ff7CXy0tviZA9ksnSy2uXCkV07csp8cJpRm3tAiNx+awnfyA6f8r+Ab
X-Google-Smtp-Source: AGHT+IGvBAQXtMRTleyDW6x3HzSYF2eqnBC5Rmkc6964KlaHxGxL1kuAEnMzaZToFmlebupGFAzwyQ==
X-Received: by 2002:a05:6a00:999:b0:727:3cd0:112b with SMTP id d2e1a72fcca58-728fa9e5e39mr3210909b3a.9.1733987087085;
        Wed, 11 Dec 2024 23:04:47 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-725ee10f928sm6519386b3a.32.2024.12.11.23.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:04:46 -0800 (PST)
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
Subject: [PATCH v2 2/7] cpufreq: apple-soc: Drop setting the PS2 field on M2+
Date: Thu, 12 Dec 2024 15:03:01 +0800
Message-ID: <20241212070344.3858-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212070344.3858-1-towinchenmi@gmail.com>
References: <20241212070344.3858-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

Newer device do not use this. It is not known what this field does,
but change the behavior to be same as macOS to be safe.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 4dcacab9b4bf..ad6c7b8f290c 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -25,7 +25,7 @@
 #define APPLE_DVFS_CMD			0x20
 #define APPLE_DVFS_CMD_BUSY		BIT(31)
 #define APPLE_DVFS_CMD_SET		BIT(25)
-#define APPLE_DVFS_CMD_PS2		GENMASK(16, 12)
+#define APPLE_DVFS_CMD_PS2		GENMASK(15, 12)
 #define APPLE_DVFS_CMD_PS1		GENMASK(4, 0)
 
 /* Same timebase as CPU counter (24MHz) */
@@ -55,6 +55,7 @@
 #define APPLE_DVFS_TRANSITION_TIMEOUT 100
 
 struct apple_soc_cpufreq_info {
+	bool has_ps2;
 	u64 max_pstate;
 	u64 cur_pstate_mask;
 	u64 cur_pstate_shift;
@@ -69,18 +70,21 @@ struct apple_cpu_priv {
 static struct cpufreq_driver apple_soc_cpufreq_driver;
 
 static const struct apple_soc_cpufreq_info soc_t8103_info = {
+	.has_ps2 = true,
 	.max_pstate = 15,
 	.cur_pstate_mask = APPLE_DVFS_STATUS_CUR_PS_T8103,
 	.cur_pstate_shift = APPLE_DVFS_STATUS_CUR_PS_SHIFT_T8103,
 };
 
 static const struct apple_soc_cpufreq_info soc_t8112_info = {
+	.has_ps2 = false,
 	.max_pstate = 31,
 	.cur_pstate_mask = APPLE_DVFS_STATUS_CUR_PS_T8112,
 	.cur_pstate_shift = APPLE_DVFS_STATUS_CUR_PS_SHIFT_T8112,
 };
 
 static const struct apple_soc_cpufreq_info soc_default_info = {
+	.has_ps2 = false,
 	.max_pstate = 15,
 	.cur_pstate_mask = 0, /* fallback */
 };
@@ -148,9 +152,12 @@ static int apple_soc_cpufreq_set_target(struct cpufreq_policy *policy,
 		return -EIO;
 	}
 
-	reg &= ~(APPLE_DVFS_CMD_PS1 | APPLE_DVFS_CMD_PS2);
+	reg &= ~APPLE_DVFS_CMD_PS1;
 	reg |= FIELD_PREP(APPLE_DVFS_CMD_PS1, pstate);
-	reg |= FIELD_PREP(APPLE_DVFS_CMD_PS2, pstate);
+	if (priv->info->has_ps2) {
+		reg &= ~APPLE_DVFS_CMD_PS2;
+		reg |= FIELD_PREP(APPLE_DVFS_CMD_PS2, pstate);
+	}
 	reg |= APPLE_DVFS_CMD_SET;
 
 	writeq_relaxed(reg, priv->reg_base + APPLE_DVFS_CMD);
-- 
2.47.1


