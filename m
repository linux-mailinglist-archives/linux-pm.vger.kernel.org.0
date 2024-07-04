Return-Path: <linux-pm+bounces-10578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E41CE927018
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 08:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997B61F240E6
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 06:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29CB1A257F;
	Thu,  4 Jul 2024 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEHGGDgX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5669B1A2C03
	for <linux-pm@vger.kernel.org>; Thu,  4 Jul 2024 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720076062; cv=none; b=H7M9s8WlEcpFU/cg8gTRoUtPrHVGx8XNsBYEOX8vZA2J6hNjMiKjbC14ZcACNTDSXXjZuO7ftr0sOzIsaC8p2TcBS94ByKnO09VfySNbHw9/h6YBcjLe4C+6KK7SCjZm6L8tmiaDlYwW3MYrSRt7rTuVSE0m6d474g0EqwhT2gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720076062; c=relaxed/simple;
	bh=p3g4yOXFGrC+1v+U9pGXCG8xiA5NUBZG/HMlE2fajnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=te3R338CKFEbLM4tgB5aj96boX4TD5zTLWQSxKUkEN0e+PuZBBEqKXvWep2JJPw8FRkBVB4Por54/CNbAN9sx5QxSa4G1kGv5Gxz7wgCXd76R3WlcEvFmHA3QjUQ028nMdmcM2c26y+M/54kP32IwseAk1N+nPB/CjeWh13tUMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gEHGGDgX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-701b0b0be38so257927b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 23:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720076061; x=1720680861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6xrWhuQO/F2V4yv6AaPs7D8YwIWXmiw86tXq5hUOyc=;
        b=gEHGGDgXeN9uRQ5mQw8cfJZXr8+lNd+O50G9phLkH7cV6VUefbWGzTnZzw8SMiPj/h
         haHP+74LUYBFYjrbSRqTB8X2sevpShKRfg9O4yNS3ljN25xpXnK782YUiyPmQ6LLnWKg
         JYFmMgwU80Ako40+PKnfCvTLHMKSLMkrSQ6ED1Po4DZ0nTUWJ1RC63/FyCCjn9KapZjU
         +VmnmJ4AQ3gSbiDe49qtTcS3lk4kEJ4GFaSE61DFYFoAuDBD/XGFmpVk68mD+Jpj/QQW
         eQ9ZX0avPtt0/XVYuCrXmOmJxJDqae++fub3eo6mWONPs+FArLda2GZ7BkZchegEuUcw
         nrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720076061; x=1720680861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6xrWhuQO/F2V4yv6AaPs7D8YwIWXmiw86tXq5hUOyc=;
        b=DBqbgz2fyxbVbEgFlYDw7TIgMbcsW5Xc0kFHaoFq+8G2tKiI8LMBQ5zUaWSaFoVqUT
         MTa3SATwG1NhGCJdSrVrg8fBISoo74zUl94dpqIaYMMd8TWL/clBFyInqFirDu+ZsgYN
         pJwncw4z+ucIcDY9l4h8wZrJlhdX3DulkeXsme/vo2LDOvsRh/WlyfolZKJ2O7ZjNgsf
         tMqytA9JxPahZ7Fhx8Lxqn8/s18I4IH8ZJEElx7iTHEfrng+9g8IiaCxR7LEJhfkR1nB
         tz3GCpqpffUb55GfyMEIl3b06/THRdn9mgvdUquog9vt7WewVUlfFe5ZiNK6AuclWcqf
         PU8Q==
X-Gm-Message-State: AOJu0YzjBv4Tq4A1KqSYAiHfD2jtePXLrEPD0q4dke0ap4WLs+MAsU4l
	WxmcnpStWO5EZaDgf7Q2dZn1lANwx9Y3fJgvc062gF7cvDun1G3UCD8lvFJ+uv56xEfUCHkjqjP
	n
X-Google-Smtp-Source: AGHT+IGnPnbN5hoDog45bSFXx983A7/UJMbl0GjEfYUbedd3XUIpEPJwHqdYZ6FsK+nT7KO4hY8SRw==
X-Received: by 2002:a05:6a00:1784:b0:708:11f:d151 with SMTP id d2e1a72fcca58-70b009695cbmr851143b3a.16.1720076060590;
        Wed, 03 Jul 2024 23:54:20 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b03a9d996sm245894b3a.96.2024.07.03.23.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:54:20 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] cpufreq: pcc: Remove empty exit() callback
Date: Thu,  4 Jul 2024 12:23:54 +0530
Message-Id: <02fbaba9bfee5814b2446a747785746fc242e92a.1720075640.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1720075640.git.viresh.kumar@linaro.org>
References: <cover.1720075640.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exit() callback is optional, remove the empty one.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pcc-cpufreq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 6f8b5ea7aeae..771efbf51a48 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -562,18 +562,12 @@ static int pcc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return result;
 }
 
-static int pcc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
-{
-	return 0;
-}
-
 static struct cpufreq_driver pcc_cpufreq_driver = {
 	.flags = CPUFREQ_CONST_LOOPS,
 	.get = pcc_get_freq,
 	.verify = pcc_cpufreq_verify,
 	.target = pcc_cpufreq_target,
 	.init = pcc_cpufreq_cpu_init,
-	.exit = pcc_cpufreq_cpu_exit,
 	.name = "pcc-cpufreq",
 };
 
-- 
2.31.1.272.g89b43f80a514


