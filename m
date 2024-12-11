Return-Path: <linux-pm+bounces-19003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9543C9ECB06
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 12:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65FB916A2D2
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 11:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D112336BD;
	Wed, 11 Dec 2024 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGvG3Qyo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB662336AC;
	Wed, 11 Dec 2024 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916195; cv=none; b=lhqNUH8ej7vPFaMDRYi2/Y8hEFecMRKABlsBrnsIZmethNBpVYUk20HHK55VUH7SdSqxQ0mn6FWa34abFbgMcpJHWcdPTFrEOVQgzmX+SwotrTsvtLNTOUfGLBe86cgvylEzbXVZkZZiS7zcZT04yPi6Mskqi+2ilspxKkPW95E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916195; c=relaxed/simple;
	bh=RgXy7GQICkh4yaDvFbIaxUPIIfKur6XP15eVhbM+Yts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l21fyjAFuMLItfw75QDl4DWGmAF1cJdwrVRVLlXx6HkH0vudCOAJAKz5t76KwqkrTq5N631kPVKXHHnKJpX9ILGtY6IKPAT1rowZ3YZ7zvNHYv0IXj+3rE3lmj4OEm8p3robGxSv/l0qGRXTVp0V6woBepIi8HQMPRNHbzbHTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGvG3Qyo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21661be2c2dso22785245ad.1;
        Wed, 11 Dec 2024 03:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733916193; x=1734520993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1XYVqROmegnfGFhPLcLWSN8f1mP3yklImJht3PHB8s=;
        b=XGvG3QyoTPhciV4mdgufU3QaNqM0G1bYhnAnmbURv+ya/+c8nMES17R4k3ySd6YQDk
         RTQ8Tmkip9UdUcFWdk1TxknliadN+sMPEetPNgUjkJ7AEZ1p/O4NdczDTI+Td2GCcOdq
         yfqrOA3hDy0BqRLjvmLl0Xd19EX+DoPhhJHaoi45CgGv77JvWKcUZQLe1pxHiN/EpoIk
         kKEKb5yMJYzeajhpgcGLqz5QByE+VqBPn4CoTDy4K7GeIulnBcX58hZySwnUft8+pAQw
         F1fCIz0ttnLe/5Dt7FieW4h0O2B6nyjRIFnU4GPmFiMnlI3BzyjxjFM0Hw2vvpJwmLEc
         OmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733916193; x=1734520993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1XYVqROmegnfGFhPLcLWSN8f1mP3yklImJht3PHB8s=;
        b=AjRjZQgSFeI5MGCgVHOuAiXvwq9Y9eHXAQkz9j8WFuKDWA/G2NxHUXLY7DOVzf0rmJ
         VALw4ujJqd9APzKSi1L+zPwQWd8Q1P17od5eeg2fqdHmea/qGd2CEINNOLK8uKBHjOzI
         9aRBjkxhSZx4M3CDm9D1pxytL/jHX0H3LfaC/fZSlXH7KHVbtGhSX5YmV0as9YBUV8Ng
         cyoZu4Ae+QLVGzYoxrihrwA1V5DbWOO7mAk4YGpjlghLIWyn/bjOj3WQHSusDpM4HK1K
         WhZy9eo2p86rcB8OobwQWRa8OigCzIK+LZmHr6rDpspEp/dSd4WzdLMfbBWEinLLD7WV
         z/2w==
X-Forwarded-Encrypted: i=1; AJvYcCU8z+9ApWFT7fTpcKgln148rleM+k6Nck5qqgFgdotu+TQ/WeUuqivoGe3vH9KEhbD2gKkFfqpJcFc=@vger.kernel.org, AJvYcCULqdNFuzlAtmr5sUM7hRXbOaGvnrSYmMDxxb3jLcaibrUFo7teFPh27Ztm+bLIwkovNm4OybVaRSacIx74@vger.kernel.org, AJvYcCVgcP2SKfxDxW9yi6PiSj0pek8BSomy6xkrBMYsI8lO3x+W5Gh/VeRv2HUvtSk5IDfSUBqKJrQBBod6@vger.kernel.org
X-Gm-Message-State: AOJu0YwyiryOyS0p3QcINj/M6dAI6afni9ha0L08EByOJmsySZAnEzXW
	4WOlJM5SXy2mSwQLGExalb/gwEmktGEDqIjSLxLy7/TiI1wcWZQz
X-Gm-Gg: ASbGncvv3lC3tG4h2bxRjjRRWw2SSMiBlKtSKWZKR9SCZbPTLDj2BbO6vh0n/Z4J1Kl
	skr8ph0ZaNwXQIZYSQqRttF6KM/LtFl8+0NLfIBdlJAjjCxQcBMHX3DVnRSfP5VarDTPXam6kAl
	zs4I8o5P7kvfc/zSl4pg9zSIUwjucVLPVJTYFVJyzZ7dkR1UjgcqjyTaT/1PE62fEPs0Oy6XQwd
	q+r1zcydxWcOQcF0pcDr53KUpNE0wQBh2clO+4LeNbnSovcL88TKRVyIZg5/bN9iPDDLA==
X-Google-Smtp-Source: AGHT+IH3ONBmas7xlrBFZwEBLUlf/D/cSYjNZZPpeQFWgFHm/3eyRH4IxETbO7fyTNvbq/gjEuALFg==
X-Received: by 2002:a17:902:ebc4:b0:216:2a36:5b2e with SMTP id d9443c01a7336-21778536b37mr48738815ad.32.1733916193070;
        Wed, 11 Dec 2024 03:23:13 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21650ccdc7esm48956615ad.133.2024.12.11.03.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 03:23:12 -0800 (PST)
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
Subject: [PATCH 3/7] cpufreq: apple-soc: Allow per-SoC configuration of APPLE_DVFS_CMD_PS1
Date: Wed, 11 Dec 2024 19:19:30 +0800
Message-ID: <20241211112244.18393-4-towinchenmi@gmail.com>
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

Support for SoC that has a different APPLE_DVFS_CMD_PS1 will be added soon,
so modify the driver first to allow it to be configured per-SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index ad6c7b8f290c..90e34105b50b 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -27,6 +27,7 @@
 #define APPLE_DVFS_CMD_SET		BIT(25)
 #define APPLE_DVFS_CMD_PS2		GENMASK(15, 12)
 #define APPLE_DVFS_CMD_PS1		GENMASK(4, 0)
+#define APPLE_DVFS_CMD_PS1_SHIFT	0
 
 /* Same timebase as CPU counter (24MHz) */
 #define APPLE_DVFS_LAST_CHG_TIME	0x38
@@ -59,6 +60,8 @@ struct apple_soc_cpufreq_info {
 	u64 max_pstate;
 	u64 cur_pstate_mask;
 	u64 cur_pstate_shift;
+	u64 ps1_mask;
+	u64 ps1_shift;
 };
 
 struct apple_cpu_priv {
@@ -74,6 +77,8 @@ static const struct apple_soc_cpufreq_info soc_t8103_info = {
 	.max_pstate = 15,
 	.cur_pstate_mask = APPLE_DVFS_STATUS_CUR_PS_T8103,
 	.cur_pstate_shift = APPLE_DVFS_STATUS_CUR_PS_SHIFT_T8103,
+	.ps1_mask = APPLE_DVFS_CMD_PS1,
+	.ps1_shift = APPLE_DVFS_CMD_PS1_SHIFT,
 };
 
 static const struct apple_soc_cpufreq_info soc_t8112_info = {
@@ -81,12 +86,16 @@ static const struct apple_soc_cpufreq_info soc_t8112_info = {
 	.max_pstate = 31,
 	.cur_pstate_mask = APPLE_DVFS_STATUS_CUR_PS_T8112,
 	.cur_pstate_shift = APPLE_DVFS_STATUS_CUR_PS_SHIFT_T8112,
+	.ps1_mask = APPLE_DVFS_CMD_PS1,
+	.ps1_shift = APPLE_DVFS_CMD_PS1_SHIFT,
 };
 
 static const struct apple_soc_cpufreq_info soc_default_info = {
 	.has_ps2 = false,
 	.max_pstate = 15,
 	.cur_pstate_mask = 0, /* fallback */
+	.ps1_mask = APPLE_DVFS_CMD_PS1,
+	.ps1_shift = APPLE_DVFS_CMD_PS1_SHIFT,
 };
 
 static const struct of_device_id apple_soc_cpufreq_of_match[] __maybe_unused = {
@@ -152,8 +161,8 @@ static int apple_soc_cpufreq_set_target(struct cpufreq_policy *policy,
 		return -EIO;
 	}
 
-	reg &= ~APPLE_DVFS_CMD_PS1;
-	reg |= FIELD_PREP(APPLE_DVFS_CMD_PS1, pstate);
+	reg &= ~priv->info->ps1_mask;
+	reg |= pstate << priv->info->ps1_shift;
 	if (priv->info->has_ps2) {
 		reg &= ~APPLE_DVFS_CMD_PS2;
 		reg |= FIELD_PREP(APPLE_DVFS_CMD_PS2, pstate);
-- 
2.47.1


