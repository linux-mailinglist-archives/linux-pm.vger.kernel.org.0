Return-Path: <linux-pm+bounces-19105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4AD9EDFE6
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 08:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1353816585B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2105C2063C7;
	Thu, 12 Dec 2024 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amtl6X+q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D6820626E;
	Thu, 12 Dec 2024 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987106; cv=none; b=sYUlVMX7aCZUqSv8hO2yyeQg3y6ixou4Nm8/s2sCfLtccoJ2MmYLm0V6sXGw32W93KynSU8VR7geQvIKX++Cz+bn5MGnqPTWPO2x5feTOaVyRt9+cYNamlHq/Zz3z8GJ/vhuiE1GidbjAAV7icXLjjV2NZoM7yQxbI5WF0UgfJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987106; c=relaxed/simple;
	bh=HOAKg6b0eEPy/zF2EuAgJ4CV33fx/jUkVtp0FziM0gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlSum3fW+H6L5zY9mtMpRC38AeBcpurgHXj+YckUB+5EBiKpXQz5hj7h8jJnRkvZOhLsG5GwuRPT6dORkZrDAFlVaDL98ZuOte8nRPInLT9UUyoJUS28LKwK12MYLrY0lv9Vl4PqR4+v/pY24bY9z2mZDkPtGncL4Vbjin8lN68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amtl6X+q; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7242f559a9fso325581b3a.1;
        Wed, 11 Dec 2024 23:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733987103; x=1734591903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6P537stxvMQqeF6f3roncNxbUVv366ZADaeaxeRSNY=;
        b=amtl6X+ql2p4T7/GpY+OodH2R0Bz4/VzQnJTiy8rQY3r7wv9aqA0etxs62CgllPQlg
         VQvxuYtF1DkLOOjhX3ZsvyB6X/vlLCFJb3rgyVazIGruY3WLAWdIe1VRs6EAgqiyQYRs
         AXFuRhWnkSKfmZj5YiPWQ9glKj3huvo40aPn5DL/WpMOTIBllgZ/5wvKciWXaS+hIUdQ
         n8I35XsybY2153Gw0XPW/reLM/fCv896dBbRQMrvOi3jYSNeeSL1eNoI+72c2C/nZRmn
         7fU/m4BtZR/e1Xb7sN5PB4WDBlEvuxW8RDAZDplLjxM3XnsYwcWL/XL/d6tggfnemfTW
         LF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733987103; x=1734591903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6P537stxvMQqeF6f3roncNxbUVv366ZADaeaxeRSNY=;
        b=hZ7RpED9QJOrytKjNjfQlnfDJR2lWXpFfqd/jEUQ0aMol48sNNuEXgyai7euNSl0iz
         mBSIjz/c2lM6XdewmlaHn+5753kIuUU1vudRVJJfm7y5yAOBWkB7F3g/xynEGc8anyNS
         QOvq84AFMc110oEJ0Th0kjEDW3O+vtqUoC1MHB7/bzjunC7c16J9yVcGNKakOEspV6JT
         ADdzy0rkd/OBSQH0wbwl6K/pP805/Ft3cYLZGmkCnRA05BuxHinm1VeFbEvdRjrc15ty
         c/RpZ2yh3mlyQG/pbGo4GPZNm3B4KykBbi+FHfMH79IgiqbZL2jW5Q3E2SAU5dFLljTW
         r1Ug==
X-Forwarded-Encrypted: i=1; AJvYcCU/+/IkAYjE5dZu8aqS8WNw3UOUlpvPV3ljnS5SAWunMFq3I/897G8FXW7RsZgHU3h84sYRSOW1ai8G@vger.kernel.org, AJvYcCUweeHxo+2jsR0lgUjR1guNHj3LUcTQBoIeL/sn9UF+A2Zi1YL7za7rEEN6FjF7H/cBwU+AakA65Hs=@vger.kernel.org, AJvYcCWwKq+1Kaw4Au7vaM7oyVa5Vdj19AfuqEvPpSjU95+39Bw9BdcowTHbU19PqhgCGBt1qhNyoECoL1y6jr45@vger.kernel.org
X-Gm-Message-State: AOJu0YyWMgTKRKs0ddufnpgK/+uMVP7BYawoFiT6es9S1b7c7Ko5uJCA
	JIXaul1Ok7FRMC/JwXDxJt7bSJloKfIXdHUQMw1L3SeSdg9hOtJc
X-Gm-Gg: ASbGnctS8LmCGahpqL3l5WiazNThiA4LdNGoWoqo6xp+/CByfY+Mp0Zf2RCvZyKeNpJ
	W77rchJWNUOvSC0IfuSScc05qHUb+tlo/JpPr+HCvn3P1LQLaH4bRV/V1Sz8C1FIljOvFSZlBzu
	3/weHxgrBEEzFokUmvWXg4bQ6G3v+fljcTuLp9mvVqy1x0qLsZhoug1+9Zt4p62glYKrZRAanjT
	wy8IQYx87wEaIIJ4hvGH7phH87IRx3Us1vrKibn9dhdMRjPYB/iX8aG3soiBFkn5ODpcpLB
X-Google-Smtp-Source: AGHT+IGrdOYxBGn8CzjzAjnMQjSdYYWqQKbTysuxC6esT4QB5BXv4xEumBLxne4E9WmA5a4aAN8WoA==
X-Received: by 2002:a05:6a00:1803:b0:725:eb85:f7ef with SMTP id d2e1a72fcca58-728faa62ae1mr3631124b3a.14.1733987102674;
        Wed, 11 Dec 2024 23:05:02 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-725ee10f928sm6519386b3a.32.2024.12.11.23.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:05:02 -0800 (PST)
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
Subject: [PATCH v2 7/7] cpufreq: apple-soc: Add Apple A7-A8X SoC cpufreq support
Date: Thu, 12 Dec 2024 15:03:06 +0800
Message-ID: <20241212070344.3858-8-towinchenmi@gmail.com>
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

These SoCs only use 3 bits for p-states, and have a different
APPLE_DVFS_CMD_PS1 mask value.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 30 +++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index c9f31a3653e2..c3a6dd8ae22a 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -22,12 +22,14 @@
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
 
-#define APPLE_DVFS_CMD			0x20
-#define APPLE_DVFS_CMD_BUSY		BIT(31)
-#define APPLE_DVFS_CMD_SET		BIT(25)
-#define APPLE_DVFS_CMD_PS2		GENMASK(15, 12)
-#define APPLE_DVFS_CMD_PS1		GENMASK(4, 0)
-#define APPLE_DVFS_CMD_PS1_SHIFT	0
+#define APPLE_DVFS_CMD				0x20
+#define APPLE_DVFS_CMD_BUSY			BIT(31)
+#define APPLE_DVFS_CMD_SET			BIT(25)
+#define APPLE_DVFS_CMD_PS1_S5L8960X		GENMASK(24, 22)
+#define APPLE_DVFS_CMD_PS1_S5L8960X_SHIFT	22
+#define APPLE_DVFS_CMD_PS2			GENMASK(15, 12)
+#define APPLE_DVFS_CMD_PS1			GENMASK(4, 0)
+#define APPLE_DVFS_CMD_PS1_SHIFT		0
 
 /* Same timebase as CPU counter (24MHz) */
 #define APPLE_DVFS_LAST_CHG_TIME	0x38
@@ -36,6 +38,9 @@
  * Apple ran out of bits and had to shift this in T8112...
  */
 #define APPLE_DVFS_STATUS			0x50
+#define APPLE_DVFS_STATUS_CUR_PS_S5L8960X	GENMASK(5, 3)
+#define APPLE_DVFS_STATUS_CUR_PS_SHIFT_S5L8960X	3
+#define APPLE_DVFS_STATUS_TGT_PS_S5L8960X	GENMASK(2, 0)
 #define APPLE_DVFS_STATUS_CUR_PS_T8103		GENMASK(7, 4)
 #define APPLE_DVFS_STATUS_CUR_PS_SHIFT_T8103	4
 #define APPLE_DVFS_STATUS_TGT_PS_T8103		GENMASK(3, 0)
@@ -72,6 +77,15 @@ struct apple_cpu_priv {
 
 static struct cpufreq_driver apple_soc_cpufreq_driver;
 
+static const struct apple_soc_cpufreq_info soc_s5l8960x_info = {
+	.has_ps2 = false,
+	.max_pstate = 7,
+	.cur_pstate_mask = APPLE_DVFS_STATUS_CUR_PS_S5L8960X,
+	.cur_pstate_shift = APPLE_DVFS_STATUS_CUR_PS_SHIFT_S5L8960X,
+	.ps1_mask = APPLE_DVFS_CMD_PS1_S5L8960X,
+	.ps1_shift = APPLE_DVFS_CMD_PS1_S5L8960X_SHIFT,
+};
+
 static const struct apple_soc_cpufreq_info soc_t8103_info = {
 	.has_ps2 = true,
 	.max_pstate = 15,
@@ -99,6 +113,10 @@ static const struct apple_soc_cpufreq_info soc_default_info = {
 };
 
 static const struct of_device_id apple_soc_cpufreq_of_match[] __maybe_unused = {
+	{
+		.compatible = "apple,s5l8960x-cluster-cpufreq",
+		.data = &soc_s5l8960x_info,
+	},
 	{
 		.compatible = "apple,t8103-cluster-cpufreq",
 		.data = &soc_t8103_info,
-- 
2.47.1


