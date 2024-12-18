Return-Path: <linux-pm+bounces-19443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4013A9F6D59
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5071896BDC
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 18:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1501FD78B;
	Wed, 18 Dec 2024 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhWThzBO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5730A1FCFFB;
	Wed, 18 Dec 2024 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734546562; cv=none; b=EfION8qkfqPIsNJdl7Det0zueCbwTL2F8VLv2MXsrsCPbv75C0oicHjL+BG6dbdWcw5KIDpfhQj7iF7qzH/oZBQbxWfGvcyAWFeOOtDSBeFc6yBvNohNM8q0wgajCqheZ2fP0fuYO+FVl+/4Q1b8ySysY0Y2rU3O1YzUMZzXiQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734546562; c=relaxed/simple;
	bh=eWPZwdEV9Ln6IVIS/IoQBSNEfSr7WTy0vPRSPt8DjpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tuhu877l93wo2eKZSsVd1yCnWuOK+AY3S0qGaQ1fhr5kuIoTOSk4fE6JL2YzdU1Jsh5qQabxJ0Ci3zZgXO9i5vHJGlvZ1+C6tisFFZ6kSjWh1ms/3hlnLfEVdfTe5L6Ylj15XYuiK6k9dcCWY2r6d2wOs4fl8il2rW0sye+J5kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhWThzBO; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21669fd5c7cso60812505ad.3;
        Wed, 18 Dec 2024 10:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734546561; x=1735151361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZBfNBSGDJ0HG4dwJs91dFczJyiFsgvS33RZvYaZjO0=;
        b=LhWThzBOwEmhIqfogKdlbUkGJZ8Mzz4U5zM613yZUgCIm3nZOHXCFE3sQ4GT+dSRZZ
         Hn5DmmZX9Z7pFB5zx7Xwua+dm8RxKHV4y6Fig88LcKL52iOCbbyThxECMcvHGJ67WWfa
         /gv+irAi5dyjKb7spYTFZozluUWCmsonfirDdOKcLVDaX60+7sVD25vYnMeQ0OZBeZ1V
         a8FAuHnVUnKlPU1pJirMVo34rSgpMFNay7MQy24hdGI+aSCjrKjl4R1TkGnwvsuDd7ur
         7B/MnP7UzLk7QkAyQnsHhsry8hRvFelcJATkTb+bfl6wXBRJgs7EStWjaqXze0BwLISk
         jDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734546561; x=1735151361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZBfNBSGDJ0HG4dwJs91dFczJyiFsgvS33RZvYaZjO0=;
        b=bcv4Jc87KbxC0MzDJu6FaEeGR+yK0rkHfYIVTDHx7LY1xdsFgGOTulNWqT0qvr+iWj
         8Vo47P5OJMMmPVx2fkwc7mAqHw4h8azeE0wn0wwbrFJcmLwbfcyas8TF5gO27jQ/a1CC
         75uIRs8MWtMqIJVzIz4QQdWcV21IWCE17Th/Kmnu1FE80gVlKy7npANolr/GhO0C3B3p
         Qu+x/LE7fqu+1ZyvLexN7YPy8xCjq1m3//LxW+8fS45fIib3VgZeZkOr6ON8eaMSxVG5
         knNyjIVj6qg+RodUFNoLQENKncMOyG7QVBimA18YnxF8l1wTaUvwdTj8Uf3JuxR69oaN
         lLGg==
X-Forwarded-Encrypted: i=1; AJvYcCU8rwxItKzjizEi41yyEamqrrApsgNnKIXowCpCJu4qlJLZeAMzG6kJbel2Ym2cnsHO7UYaqpD1eGk=@vger.kernel.org, AJvYcCUSAFQKK3aD+Cplg8oufF18177WIGxW+LUu66HbfFrThLmhRcDbBpGohwun9L2YFBbApDSVMg/dyNCt@vger.kernel.org, AJvYcCWNgjcQLPKTfVxwVehNEcOx+QMzPBQymJ+U6M63XTfRK0Z/JcaqY+2GPMYZSyJUaEXzvCv7TiqgWJTq1zE6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1pnKwzlV+Pr7mIc1ApmQIYOLL6Q5l8Hoh1MI9+gQBroAzmS51
	X/9Yfs3jIEgpjnR2iwsj3BRpJwnSJ2DIGtqREbolRefTWmWdksid
X-Gm-Gg: ASbGncuhs98Q8x5qa0mRKThZ9O7fWgh6h8nPql0AeY+2SUd4J5c8O9h2damzAVsqsiH
	ncDb0Y/bLIeWiGxh7bykqL9ouus9O7Aid/zIcH09tjfLsoz9UBfmFlLJSN5Z7yLMjaiFOAyLbZq
	GAm1pi40WFOzE1h1pIWExOiAtMfQ6pnAoky+1VrhDbzLwhL1BGTfjMVC16o//dEiSvezS8edNE4
	ItEPjU2FGfcUoMoFuslX8gJai74gsf67DqudjLeajQ2GHo18uytZMpcxQ==
X-Google-Smtp-Source: AGHT+IHKE8BBaNkfFDIiYK2d/X+ou/ScQY3k5kP8jILytQsn9xsdpJIG3SmkQVJ4kyDLKQIjDOdCPA==
X-Received: by 2002:a17:902:ec81:b0:216:5568:38c9 with SMTP id d9443c01a7336-218d72349edmr57596245ad.31.1734546560737;
        Wed, 18 Dec 2024 10:29:20 -0800 (PST)
Received: from nick-mbp.. ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-218a1dcb3ffsm79202565ad.75.2024.12.18.10.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 10:29:20 -0800 (PST)
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
Subject: [PATCH v3 7/7] cpufreq: apple-soc: Add Apple A7-A8X SoC cpufreq support
Date: Thu, 19 Dec 2024 02:25:09 +0800
Message-ID: <20241218182834.22334-8-towinchenmi@gmail.com>
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

These SoCs only use 3 bits for p-states, and have a different
APPLE_DVFS_CMD_PS1 mask value.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 30 +++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 879ddec9e557..269b18c62d04 100644
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


