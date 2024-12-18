Return-Path: <linux-pm+bounces-19439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10139F6D4A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E445316E354
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 18:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404741FC7D1;
	Wed, 18 Dec 2024 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEYG8f1g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34A41FC11D;
	Wed, 18 Dec 2024 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734546551; cv=none; b=k5j33rlkFHEblmJkC0zpxmSmjFXh7Dzcjsl/OEpCnpqT2SIb/4IRSobJSVN6McDL730oBbNWgpWb1tD7cA0UZuLHkeNeWfxDOT/S0lESu+8gVQHvMnbbPBbJwNulzyrc192k8si4tp4hdUv3WxwkNl3p/n1bP19TjwCTv67aszY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734546551; c=relaxed/simple;
	bh=RgXy7GQICkh4yaDvFbIaxUPIIfKur6XP15eVhbM+Yts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMCWyj8x5HvlawX+96bSL1SZQ/39tsRJJwvEOcOjyon82bkBQWmE/+67z+bxeusqI6MU7QnXakbXbkCBMnU2q0xD78O3Q+sA4bfUiBUMk27600O46Sf8FuRW3kjPClZVvdPqQdMi3jlZ1VuTMLvToHAneeDkHKL7fC83alifLrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEYG8f1g; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21661be2c2dso4845ad.1;
        Wed, 18 Dec 2024 10:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734546549; x=1735151349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1XYVqROmegnfGFhPLcLWSN8f1mP3yklImJht3PHB8s=;
        b=LEYG8f1g/qaFQnM0Jnsm3vJQ3FrfUrmPZ/IzY9VVd5mcNXTL7cIstsYePX3iAUlnVN
         F76KSbkHT0ZIsy5wWb5P/n4tLxgs2p2TE/N8HXn3WkF7ZM102gTo/grkhoJp/Kbhu+MU
         iVTTK8dpq6QX8UnbAKWhYXRm59OhjhGStlPiXvrd73GQaUrLlyFMLvefcFzdX4z1Ek8P
         3AXH2VON2LZMEep8yVrUWOZ0dFfqpxF+2mVTDDkG0Azuc9oXYH+j2xXqYf/lbyRAKdEo
         u0t89TTyCL3EHw4SHMR/XK0e8AZt0/vkaTEbQkWLISR/lzgvEbi2COsDpWP67uGj2p98
         +FRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734546549; x=1735151349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1XYVqROmegnfGFhPLcLWSN8f1mP3yklImJht3PHB8s=;
        b=Nl5hmrczKW4wjHn/wkpt47mx1zicK18oxuTXXRrtEPcOSjeyx+5OscJqE2L3H7Uldg
         UTa7t046QCzQ6lLxokTQogMnNAbE4L+F9uTq6fqS772VyFTvqPxQv1jWqvzjo9K5YnBx
         kuKZ/YsfZTkkBtVNd8UfPN5UDo9g9rre4X2MuZcjZBDxsmt7sYhgvIP0Z2jyJYfUt0MR
         gkcL1hV68HxuJxhgo6Eo1LAkuKvGvCIU41VnROvaoiDKGKyW0xiVtzMaZMLddhLsIxPw
         zbvXB56OnXfkDaS3WWZ7VzkWt5aZLEmzj4eJtIlpOM+AT/mgMbTMxvXxaNN+h54h1K+U
         Jg5A==
X-Forwarded-Encrypted: i=1; AJvYcCUEgRr5/ueub1UkHn9NFRLElOEcUSkSwnFYStR5qZZX/fTiN1ZNycA13F0rdrQJ2RilClxflMdZJpidRKj4@vger.kernel.org, AJvYcCVNdp3J2OjIHR4GiDZHwQQtZkoPjBeP1aPN2z9TEslUCAYLZqCBE9uP5ayUuz/jnvjq3GlqQ9D1kLr8@vger.kernel.org, AJvYcCWMkj5BIKFGKEE6c1k9ttZvfwqSSjFH232PbljIdU29tQ3Iw/wp2YSDuhAq43ZhVT0VOVegsl9Sp0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjA8VUEWSxVrNJck2xHQZwTBxqzGN0iV1vQG4JF90BP2BvHrYY
	np2NuuDRthHbVt987oXtcObS/Z1K+RH9x2EgUQE0KZirBeZM5C8U
X-Gm-Gg: ASbGncvgjY/Qd3k4L8uOnARJi023IXR0eDR/nqwbKB/cExWNTlrEXTxwZYXAUf3//n9
	ok2zngopGz6AER0IY/1mtFuqztnxBcv2yOQYvuAJIog+xtB5puJssvj3dvMcbvMJvUgfotsRr+B
	+3Oza9YcpmhQo/XoF/KsIQVv6qUhDiNcTlMy8wvVhKOKl7cOcH1Tic0fTXikfB4uVL0ALY+QoKa
	vkimV5kksdJxdaYIW6jiZpmAoSV8V3rcCZwa4sTH/0gODLAlTfYdGBUtw==
X-Google-Smtp-Source: AGHT+IG1dFfYMmtespCdHUdswr0tOQu/Hh+8bBbhGRfGdZaUlxpJm21y4ELjB1GOE2T3IEgQCtqhaw==
X-Received: by 2002:a17:902:ef08:b0:215:6489:cfb8 with SMTP id d9443c01a7336-219d961571bmr9961945ad.10.1734546549047;
        Wed, 18 Dec 2024 10:29:09 -0800 (PST)
Received: from nick-mbp.. ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-218a1dcb3ffsm79202565ad.75.2024.12.18.10.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 10:29:08 -0800 (PST)
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
Subject: [PATCH v3 3/7] cpufreq: apple-soc: Allow per-SoC configuration of APPLE_DVFS_CMD_PS1
Date: Thu, 19 Dec 2024 02:25:05 +0800
Message-ID: <20241218182834.22334-4-towinchenmi@gmail.com>
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


