Return-Path: <linux-pm+bounces-20855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA100A1A34F
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602353AE48C
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F1721519D;
	Thu, 23 Jan 2025 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4gLGQ7z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6E0215069
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632348; cv=none; b=tPd7wXYD+2cGW+Ym0uj9unblqKo4UFADAYMc9Rrm1ySXsVwCm3YfA2FYmb0NHxA2JCvRZ76Ovy87pb3sITtypoUeAG4Xml+pFbMIjBDK9zxz36PKfCOkyNn1jIlcbsPjFM/HSh2E4yqdGWD9M9BcbUFvf26vVyrnGn9mGv8vZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632348; c=relaxed/simple;
	bh=xnL8tB/+WK4uVjlaFmvG1uac8pUoDIUDIef1HU7CfBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djAAMz5T2Zu7QUV2ty+J2+jf9v/E8QYoQmn5ogbUmhQ69Q3v44DICTr4nbtoxnvb2j8+VbtC6R7hFupqPjaME/KErT+nfo52Gu1LH+jQ/y74/wwtjdk/ib98UYY4sF1YonYyZ0wyauIYF3BxchSl+ubhNMECe1moPOZ+EWFPVWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d4gLGQ7z; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2efb17478adso1485475a91.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632345; x=1738237145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGgL2Pcwn8U3/AjOXI4MB8UyAOlQbSMfePC58mcHPH8=;
        b=d4gLGQ7zRz0LJJmK1Q8R1nnYu4ReOJjCeL92TySARSQkveS/IoQe9srq6AbB4yaAUO
         Jc4Co/EgERZFk/2quQTCAV2Z0pAhrdyPmo8DFiRW2OPWumyvIPA+L9X8kJWNlwb4ZQYi
         LRJ4qgp/x1i8lx0aPJT/Ov/ImjSo8m0emDScbbgiXROO1UhA3o0Epq4thYN8LvKvNMQZ
         u7euJNdZZ8PU+pMEC7YCpFnGJQMKxQhPY80v9T7VBPTenaDIJwE0kX641Empi9W6M/XI
         2jfI32RArqWvOTLY6pl4RFeF0OGKJHaef7vqJeu0cDeZztLn2Jvm+q4gIFqaTGH9jO1H
         Aebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632345; x=1738237145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGgL2Pcwn8U3/AjOXI4MB8UyAOlQbSMfePC58mcHPH8=;
        b=GwVEp5xZM3Qpl86tT5k7AFvQMrO4UTf6MhXK8eeF80E7rb1gkBOWrRmNL+FbItO6Bq
         6zn6dCS6cq65XLGXvbccXp7iMXmOipbcGejW43d9wlcinP8RL9Cp9omKTNRiyf4mUnqe
         EWrF3CmS+6qeBRnb2Jr68xC7zdmR7Gd3MXdljyhMZD+3KuYx4l3xJCQFlTVmuSetYenl
         f9Icam5mRlscqO7BkwkrwtAUPQ/gwJwtKx+AF0vPhq6bNF56YnxgTBnLeWctOY/LYC9d
         mrpvMq2l2IRvhfnDKtCbkpQl0JHa5l8vMcpioNiwJFLFrWrDiNDoAq89+8BxbhWge1LQ
         OzJg==
X-Gm-Message-State: AOJu0YzdKoDCSuSTgEc09lEkTz13HAMgAKHKXlGCL+E3+DNMaQge6sFy
	K+nZQWEWOjUphVALAFBW1bEbYEStp91+zfiywwCbrFt7l17KwaCQF+JTXf2i9nw=
X-Gm-Gg: ASbGnctnkv98KITC0MwlMS/2HdWi6HB5RVGwLWJ/WdUREXn3eGOckHTyEwMwR2AgwI+
	i6qzXrBsR/5tT/1TCBgrXuKbXiebgLGDVDgdk10nq2+XZhSjQHymCPkA1X0uTuejVmx2gvJaj7P
	uSEKdqaicrbZDFiy/qMg5JueQMhfVAsvgHx5uzq1UUo3oo6G3v+XEdQ5ujJ+gEivixHZXkmsIDg
	NDmE6QSqFundfXhs9FTHlMD+fc5fsi5JglcxAjgI3ackDMjcR7gO76pama812ifYj2J+0uGOOar
	1m86e5U=
X-Google-Smtp-Source: AGHT+IFJ5vZUH+XuQOogqVlXtlKr65mibtBaOhKwEW4aPJ2FTjDDoIIe3COQuuBME2eIdCbPXslwsA==
X-Received: by 2002:a05:6a00:1705:b0:72a:aa0f:c86e with SMTP id d2e1a72fcca58-72daf9beb8dmr34127042b3a.4.1737632345704;
        Thu, 23 Jan 2025 03:39:05 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f0693sm13023397b3a.10.2025.01.23.03.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:39:05 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 19/33] cpufreq: powernow: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:05:55 +0530
Message-Id: <99b86ee0b0fccb7cdd77b803140f1227d2d45b52.1737631669.git.viresh.kumar@linaro.org>
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

The cpufreq core handles this for basic attributes now, the driver can skip
setting them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/powernow-k6.c | 1 -
 drivers/cpufreq/powernow-k7.c | 1 -
 drivers/cpufreq/powernow-k8.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/cpufreq/powernow-k6.c b/drivers/cpufreq/powernow-k6.c
index f0a4a6c31204..99d2244e03b0 100644
--- a/drivers/cpufreq/powernow-k6.c
+++ b/drivers/cpufreq/powernow-k6.c
@@ -253,7 +253,6 @@ static struct cpufreq_driver powernow_k6_driver = {
 	.exit		= powernow_k6_cpu_exit,
 	.get		= powernow_k6_get,
 	.name		= "powernow-k6",
-	.attr		= cpufreq_generic_attr,
 };
 
 static const struct x86_cpu_id powernow_k6_ids[] = {
diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index 4271446c8725..fb2197dc170f 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -667,7 +667,6 @@ static struct cpufreq_driver powernow_driver = {
 	.init		= powernow_cpu_init,
 	.exit		= powernow_cpu_exit,
 	.name		= "powernow-k7",
-	.attr		= cpufreq_generic_attr,
 };
 
 static int __init powernow_init(void)
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index a01170f7d01c..4e3ba6e68c32 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1143,7 +1143,6 @@ static struct cpufreq_driver cpufreq_amd64_driver = {
 	.exit		= powernowk8_cpu_exit,
 	.get		= powernowk8_get,
 	.name		= "powernow-k8",
-	.attr		= cpufreq_generic_attr,
 };
 
 static void __request_acpi_cpufreq(void)
-- 
2.31.1.272.g89b43f80a514


