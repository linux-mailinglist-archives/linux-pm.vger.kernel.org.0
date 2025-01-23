Return-Path: <linux-pm+bounces-20865-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A02DA1A36C
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19153AED6D
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E5521771E;
	Thu, 23 Jan 2025 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMWkRTXN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763BB21767D
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632382; cv=none; b=Xr4ZGg7g+h+0Q2QP/YV+ZbjsspY5jIWzMOvR3UaTDzkmCgW1M943YwjBz85rF1Sgj5adrsSJQcVUZ0lFUvNmXEWHiaRtUJdQFHFebP34BuLqFjfRlllgTOUx/enLCO/Iz/Zh2XW0C9fqX7FMrXdmdlcdmXnxFD0ecWuHDg8Xyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632382; c=relaxed/simple;
	bh=/RmPuuk1QBdOp+fFd+3u2pJjkPwx9R+qmj0CkPks3v0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SBzaHQG/AcRg8J7jasKKEU/T9zffOtafXDHrgWS6RznvquiLNGNJKSKkv4ywNSnM85yW39AMYZRjVnfqxc3CingG0yVi3oTHuUiUqzSK23qo/o82foqjV/7aeST5Y6iCwq7wCJYvJ3Ed2ChskdBjPh/O9Us45btvd9ABfcky2Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qMWkRTXN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-216401de828so12362115ad.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632380; x=1738237180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UBx5rEFZg5PgS8nxgdRfkrF65rnIH7pugxuBKI58m0=;
        b=qMWkRTXN3VHUyoPzNC0oOZmBpkit1qy/eQ1amcM29oM5zq0/oRpq2fyBpyJ+64U8Sb
         ftVDcM/J/995U4flbvxGKMMaSzbvuMoBG9MtFLQwx5rg2WzD9isGqG+KzT9So1B/Hxio
         DT338KHL/CfTwPpD/Rz7bC8oJZ4l5TXuRi3gZ0b45ktr8wCxF2qw43eZ0I2jpiiRubRo
         H4symqPgsk7zzaTNRLhV0763VzdDz1jJDgse8d/1/Y4YWrrSOYOCvTNTJTcivAAmfG+4
         dHc0Tr989gVTNr5WuZjlMB6Wy76zjztovqPYYkHizAmwe24TwAfcu9lz/7VTRlkTYHF0
         QnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632380; x=1738237180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UBx5rEFZg5PgS8nxgdRfkrF65rnIH7pugxuBKI58m0=;
        b=bwLs90mUF2BzoqAuJz4yDgkBmVT0kj2tOG9fUOOurNX+yWcNU4mdSgB3bdhEjXj0HK
         ByaOfJSP9tD0cwvfwOCTEFIj1/T26ub8QkHkCtkzgZtLZ29CZITiQGAEX9V/7+jVPR5x
         /2bgh6f5+I4W0UMbHtNlI0wRzbs6w4UkjLw5Gf71CSybRy5BAATk+bJYYaqhM2YbHIet
         KkdEnuegNmE8HLcdoGgyu6F1yNS3lNoObClGR4Zh/CwUtkH+3EN3ruprsUWhhbmtCjAs
         +MRmo09Zxa4Sm3r0gyLykIkHl94/KchOa6UFUwaUds4zBKOw37dkiscBsNefd6lXvHIu
         6tRQ==
X-Gm-Message-State: AOJu0YyyaOg4q2sXydn439H8zhRRQWEeu33uZA7rGVR/SZiP9SQIKOrh
	00/aXw3EYRR4s9QhPbcYDLdo06EgnbKP49NQYmVM5EiolyYt2lMvRs/F9Vy1iBw=
X-Gm-Gg: ASbGnct2eNamKCHs2O11yi1yDWL+N6RNSQRlCfZeGaaLrKoCaUR3Ory9480IdUKpu5q
	3e0nevgScQQkZ40oyKhd3xkNzVJ5hTmj4fb0bYEre5wMX1TMqbzYc9LY2M/aABIuW0MB0D/jkcM
	PQsSwU9m6FTxrcsIF0wxkaoNukYFb/tIFCeLUaiNPjZvRmtf+UaZ/1Cj5xtU+GJvm6rm+MhuDcZ
	p244pvbfot2o5DXx5l4PJi+HBHEvfFAcEYJB8vpeVKxJt3CVRcpCv6gHGMdagCV3mxLDpGrIfkn
	D6KXyJNynI7VLLJqMw==
X-Google-Smtp-Source: AGHT+IGvwGQNvEk20SR8FXwOYBdk/eKLULIdQVMu1dIgz8TqDRTBdFlyeE3AUsqvQwO3DrZBqBulzw==
X-Received: by 2002:a17:903:41c3:b0:216:386e:dca with SMTP id d9443c01a7336-21c3554c994mr378111625ad.30.1737632379733;
        Thu, 23 Jan 2025 03:39:39 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bce3a6157sm12352214a12.39.2025.01.23.03.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:39:39 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 29/33] cpufreq: tegra: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:06:05 +0530
Message-Id: <eb3120d85361e02d6370250a2d06635ed82ea593.1737631669.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737631669.git.viresh.kumar@linaro.org>
References: <cover.1737631669.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpufreq core handles this for basic attributes now, the drivers can
skip setting them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/tegra186-cpufreq.c | 1 -
 drivers/cpufreq/tegra194-cpufreq.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index c7761eb99f3c..b54a77be54e6 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -123,7 +123,6 @@ static struct cpufreq_driver tegra186_cpufreq_driver = {
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = tegra186_cpufreq_set_target,
 	.init = tegra186_cpufreq_init,
-	.attr = cpufreq_generic_attr,
 };
 
 static struct cpufreq_frequency_table *init_vhint_table(
diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 9055dd398e7f..9b4f516f313e 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -589,7 +589,6 @@ static struct cpufreq_driver tegra194_cpufreq_driver = {
 	.exit = tegra194_cpufreq_exit,
 	.online = tegra194_cpufreq_online,
 	.offline = tegra194_cpufreq_offline,
-	.attr = cpufreq_generic_attr,
 };
 
 static struct tegra_cpufreq_ops tegra194_cpufreq_ops = {
-- 
2.31.1.272.g89b43f80a514


