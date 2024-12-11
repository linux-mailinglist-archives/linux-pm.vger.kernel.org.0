Return-Path: <linux-pm+bounces-19002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59629ECB02
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 12:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A3D2868E9
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 11:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66869233699;
	Wed, 11 Dec 2024 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXil2JL/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9274E233688;
	Wed, 11 Dec 2024 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916192; cv=none; b=fk+3uK7HPowvzB196HtbmG07DcZHnqq5w/uwdXOE1hxBZ/clGOqcB5WbcdJY+isBh/pa5BWzITQGnNTafuHg7RrcX++8wpBzLg4cxPdKAIT2xmicv7g5k2UCub/8cB/B5y2exVVK7yzAz14+lwqTTokYMOKnU3WLu7RANnScg1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916192; c=relaxed/simple;
	bh=BuOxgI2CbOrK9Hxnatsu8Mn/4pRiwpGqt9d6S48h8hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2MyisgunC2FgF9Q/xzm0smYAKCYuvXorPd7z1SrtVwoywpGjLs2GBVR0sSPZxgYOHnAtpfVOA4xf8p3PTKG3wK51JFIpEIfdm3ZLQq1xLMjiOoiKxf06BAzFHapCNl5WGJ+bKk+mHjuGHufxYuMaMXKE93t7PIpeDAqxQhB7/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXil2JL/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21628b3fe7dso39410545ad.3;
        Wed, 11 Dec 2024 03:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733916190; x=1734520990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0xMWNhFbRFrvmQCRSO20OEZKspqHRsl+17s4y7Ifdg=;
        b=OXil2JL/0/f/pDyZ5ejAla+hFeWV1jHC3PCuHt7e6YD09uUMECKWZ/RU/7Ucgbhqll
         IPfozj1UNBB2+qXRMka65STiwcEK3LBTARGTRH2aX1OWiDjXZ3BaSYFrvnnHPE4G9bUU
         RRbdxO45PHIMaBKgIH6Jw+TEVE08ILo/liiDll/Yfh81YuG318Nrmt5fE/xLweeZa8xe
         WWreJv2WAv19B//wM0LtE8Y1Gpettr2j9T8yr17ZIVOUPgIR/VTTcei2mGViKuRDK334
         USlrqGZ+ufYeeujnVDBVrhmWcYypiSzbP4SPCnCnlFw1S+c+HjdQWrI3XjK+RGrOjcVc
         ljYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733916190; x=1734520990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0xMWNhFbRFrvmQCRSO20OEZKspqHRsl+17s4y7Ifdg=;
        b=iGWP+3hQKsqZy1K9S57w/bjFaIMG9UjbpFTpFrGZ7B/yoP+XtjcLbAsKv2EX1Xfkii
         xXyCb+eQPUpyxR4qrVk9nsFh0DkqUPv7Ne2x5vpGRQy1PMl+fL+vVlnvC/CmUX1EVul9
         I7ScDhlKriYoHAXnEuYXEcBoNwTuXLINnuZ60jrd/fXDYfVGuumIj6DFlXUXZNgEGJas
         5Z4pOivmIRFzJgMQ1OCqzGPTfBFDTnrxUTL5+UUq3sfQAdE3/J8y/dHnNAqgE0Xu2E31
         VLKgV4jw9OGsnHuyzIS6mrblOKbJtHOIB2G5ztsXo3xYoqRsR3xzaKOfIHoqRgl5WIqN
         zGpg==
X-Forwarded-Encrypted: i=1; AJvYcCUT7e4bzenn4OLRLVYPQ8KPBnwEY1RmzSCohMOMIo6cSKhT8MnYCXer6r9iQcK+9bRyAkJIT7VHcws=@vger.kernel.org, AJvYcCVvzkq8zU3HMAEnO4IIeQjusfcdkMew/bYB6O2EA0oYO0EhazIq3JnpGfGPQVMkq+9Fk0J/6OtNAUjzxGkk@vger.kernel.org, AJvYcCWGktHTbggAwihryl+zbjMqBVIEramqhiCGZ34sfklDGXLUddnOfep7xCFByxqRJ70esEt98qBzlYBu@vger.kernel.org
X-Gm-Message-State: AOJu0YzNKzPO95rMbGYyL0MG/FS/yqXdhyOJQeQ++5fqXBZ/X7Se4egL
	I7Gro+8U7K5Z052JGJEt++QQ/tAZGOrwI8t1eXvbNEtu9GQydqww
X-Gm-Gg: ASbGncvx5fzPO7kYypokyqA4R+ZBKKuMTbs5ppPCtC7H3Q8Z6njPXn4wR+/eU9kX5r5
	2uoBNNUvYhRCE/Dj6kFdmTmZpntQo70/iJ97BSmKFIBDVv/313mmqf5iwF2I6j24+ZEtY33ud8d
	rSUTwqhmhTnzjciztbFFV37UFU9f1CJPUdU+CkCQudidZIExtl77sGQRVgL7YTVb90aNV7IcEc+
	YdjuXT0eCbTCpLoSAj0QvyZJnMuHNjm/2Vvuef9V/AGJRViuI60lcuLdK9jiRUqsccMLw==
X-Google-Smtp-Source: AGHT+IGg44vKKbajgZGuP1n8MacnuXqDCWExV+Yd5IMtS3xY4Kb7j1HNlaUyN1+xFgSOQQMzckgSjA==
X-Received: by 2002:a17:902:ea07:b0:216:70b6:8723 with SMTP id d9443c01a7336-21778581e83mr41968685ad.44.1733916189869;
        Wed, 11 Dec 2024 03:23:09 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21650ccdc7esm48956615ad.133.2024.12.11.03.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 03:23:09 -0800 (PST)
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
Subject: [PATCH 2/7] cpufreq: apple-soc: Drop setting the PS2 field on M2+
Date: Wed, 11 Dec 2024 19:19:29 +0800
Message-ID: <20241211112244.18393-3-towinchenmi@gmail.com>
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


