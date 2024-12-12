Return-Path: <linux-pm+bounces-19101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 529289EDFD9
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 08:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D07188AFA7
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B105205AB7;
	Thu, 12 Dec 2024 07:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb5i0gH6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2264205AA5;
	Thu, 12 Dec 2024 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987092; cv=none; b=RfpnNljJmNyoA9d2ehrMTh8Ffre9k2laSW1VwraDB4koeSQPGrY0jOnm00SDJmdminPtq2V+4MAEzhKdzWi7uKWZXS4LI9QCh+JPt8YUmyzH3xiDqRSxB+E86+nl3HMmVOw9Q7CvBYfc5Z5cwSv8wycpuAxFL5ienW35O0+4ob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987092; c=relaxed/simple;
	bh=RgXy7GQICkh4yaDvFbIaxUPIIfKur6XP15eVhbM+Yts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmASvf0mHUlPevKa2exVM/jsuX04m4Rj8kvlVbiFwJOdk8yIVCqMs1X0LWR0pgkyUvejxY7uuUrrouVV/y50iR90Zbz5j29WMYNI72Gq6iPg05TUWcwOpXRrYQ9ll1WqsSqaTVybyebBSC3zfyVlbZ8Vlb1mJQa2SWYV7Hf04Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cb5i0gH6; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso195019a12.1;
        Wed, 11 Dec 2024 23:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733987090; x=1734591890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1XYVqROmegnfGFhPLcLWSN8f1mP3yklImJht3PHB8s=;
        b=cb5i0gH687AjCsfRtf9MbTPGwbzcfyYt5zJl3SgkqHlViWOyLdizKoZdTbshNNCT3R
         V/saMAObIc+or2/lXRRvFsVyufNV9X5Zj+P+F/sT5sgP6OxBGYBqY4TNmXgfBaPjVPhf
         bFPcMR43ubkaFpxGBNxm0+dTAqcUkiZt+YSmxIu8wp+f7Ml+9M/gl3yhqh1aNu34C82G
         iH3y3+wibia0oOr+wKa0FtJtG3yfX3ChmYpfGRF7DtV7mqcxYExs6bzd5JmpJWbGR1fd
         O3CkzadWjALDq3s6xRbQdumq+fbPwMTdi2Zc7vsWvSvSd83s2IrWLXXyzKfhSOdRNSnK
         BMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733987090; x=1734591890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1XYVqROmegnfGFhPLcLWSN8f1mP3yklImJht3PHB8s=;
        b=leMuvPllExTxcFblvT/hNglTEvrH2f24Kj8NbE2F8D5KQ7qxl/g+UzBLsIZLKl3wqv
         j7CDFmzPloTN0D0EOVw7zHAOyE0Uch1D153zhPg/aFzP8ox+0yv3j8s2OUxrffrhvvrr
         epYl2OQ9XSweAc8tehTPMLM9YhlEzg+8LGcGuHwx/E9XNSSIZ3E6frVQwEWCRLOq6NKJ
         Uq58iy2hPkJOSBtaOjSyeactoN1ypqcNMJZO2jB5rdJJiWFWmrrwiwWbMeV+5jwMMorw
         MpoZaUYo0QbHAF4QyWflnUZayW97eJnEfJiKOoed+HFWd+dEmwp22/KBjsiPeXsZGug+
         QgiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDoIs7W3VQ2DBzLA4flby+Nj4vpdnCwOZeig5wLoVrMT6QnTKlfcoOJ8nFARnXwnRndgdJsyBOR52wktsM@vger.kernel.org, AJvYcCXAHOUw3XR65JxMTpiw1zxNY8l83l1991g5OkzN7CsF1cHIUXI3Gyv3rNrroIsti9hG7X+s75jlB4Y=@vger.kernel.org, AJvYcCXvDM6MCNgmuAQvXdXv4yG7F5fMFnb6Uyt+lVJqavxdFOPE7kYMhkfy1B56TsNYAl3nNqbEIyLqjrsP@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo/69gz3RNXK0NCjQZ9gkwztSB6PWgidyvxNgCpIfriOQl6fXu
	PCOG4ulTnthi5txFYu5TF+YeegDCFgKl9jPNguCb4DvFw9Qfa5b9ubflMToS
X-Gm-Gg: ASbGncvtJoPqHEio5A/khJCVAHwTwl4Nl7tq0d+xNzGlQpruB69OE0KiIwnjc/uQs5z
	cCHuFDfiqeUQzAhth0IpKaPn352tnQ8EsuWL3JvpjJ1B4luwmPYm6Dqh4UTllizvTgWZew8yItI
	7iTQEZyntk5+Jocbx9NkXpujtYCyQo0lPA1mtLv19OuQD7XdNbrtNDmw73b934rVzFC5l4oAZjJ
	lVrfEpJsbJFV6NLBNu4Q22wM79FWwr5McwML++FQMRyXlAYsGFn67JCZ6RJ+HoL9LnP7OjT
X-Google-Smtp-Source: AGHT+IGD5L0XY10ir8ZWn31kZESh8+9pkRmRaTucZ22hPfqRxTf/NOnmFpSI0fmwVeu1XXmMvpKLow==
X-Received: by 2002:a05:6a20:d98:b0:1e1:b0e8:11dc with SMTP id adf61e73a8af0-1e1cefbb8b9mr3506448637.21.1733987090125;
        Wed, 11 Dec 2024 23:04:50 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-725ee10f928sm6519386b3a.32.2024.12.11.23.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:04:49 -0800 (PST)
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
Subject: [PATCH v2 3/7] cpufreq: apple-soc: Allow per-SoC configuration of APPLE_DVFS_CMD_PS1
Date: Thu, 12 Dec 2024 15:03:02 +0800
Message-ID: <20241212070344.3858-4-towinchenmi@gmail.com>
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


