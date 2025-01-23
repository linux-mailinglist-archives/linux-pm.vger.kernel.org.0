Return-Path: <linux-pm+bounces-20850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE23A1A33D
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5543ACFF2
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE9E2139C7;
	Thu, 23 Jan 2025 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZTiIwE5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBF02135DD
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632331; cv=none; b=hC581h7YfTphXsa/W+H9lpW4xucq6mIgYOOlUYuurdNiIqEjUgEis3o9IMh3hEyn2PH5QseEYGbHk2dGBw2m32hg9Vepfff1LkB4efOejhlDa+NDHG3ETNbk2RtihmHD2h0DKehTCAGVM1Hlh1hhtmixxWyJQaC98/wqq0hbETQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632331; c=relaxed/simple;
	bh=OuDqbHqGfRysDhKjL9U5QmypsKBYfISLrjDmh0ILSLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uImVDnS4o5pKm1GOcWIAC8e4U23e4KFccgqnyxuWe9757W9m1V/gt+DZ5yjEeB8h1v11DFqBQZGalS/Jg3DNfsV6ZbPZ2EuOTlcg4IIuy3HtcuqL8Y3ikQIVCPuTGXmv7nNnRmsC6s7STh3nUvgAWzhEqQbg1krzGwJ2eFn6Qes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jZTiIwE5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21675fd60feso16129525ad.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632328; x=1738237128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vt1kyyizP9VY8dmYd/NkcYQ7O3bbff4IlhNlXP/VIDI=;
        b=jZTiIwE5N4Pqmvl83iCCEue0h0FWxdLBhyaeYj6Z79M7+KoCHGZcygToW55E7kmJGc
         VXw62j9PCd6WfvThQteDED8nC4W6XGIw4LA7aw866j+08Xbx0D3NNsHMyGcOMQCERBkv
         JnoPOD0LfDS/kvU0ziOWlkJ1aZXNlk/9OLiDMAmZ2JY+FV2qgSzvG11NSaaPtEIMiUar
         yVtKF/RnwFcMI/GxlPCDbZ9Mh7DED4B6V2DNKCkwpQZZmCvXrryvCae2POoxDVDm51GZ
         j8Lc8FQHEUwsrB5aDw0Pqqx8G0xgWfD/tee6H+GMBFux/7hqdhiNcfDnobvBBrGeDFZ6
         zdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632328; x=1738237128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vt1kyyizP9VY8dmYd/NkcYQ7O3bbff4IlhNlXP/VIDI=;
        b=VO6U8PkMqywKIU39gr/wQGhtpWFJi6JZy82UNr/Z/1Xq6ZvY7RMnXkNfEhGnddz+K5
         kHoLbVYxQ2pg6exB63qjbCFLQFldgazpXTmtMgMrcgPXmDkaLbT8a2bLlzX/SJInEoRZ
         zJazs5QOoD/fGUzyN8apJ02fxT7W2hmBtjF+5iIBJmHsIEhl8jahY8xw8Xw+HXf6xEg5
         2y6GOdw+92ei6wkpZZPybuMhSehqnWbYSogTYWiDwBXcD2hbebrvJ3on2ChiipKeSXAA
         qPhw5L8bjEulgdSIROImeClSux3c0UoZwB10j82Yt2rig2ny4+Mh0dozgUJxHa6a+o5e
         ZOpQ==
X-Gm-Message-State: AOJu0YzOquLalsmM1ejgT29YriP7+8SuMi0tiqX5Vbcbx0rqN/HcnGAo
	E0dIS6o8zduQtoj1VvA6D8JUyG1aBWfp8R4jdLxFYUzVXEiW3QZL+ThBcy95CpM=
X-Gm-Gg: ASbGncvZjA4zoVtvyuLMdBZ3N+siC8/MpYZ3z/1V6SV3bU/+AKYKT98AQGZtzuBBV8p
	MEexYzClbuCEE4qdCoC6tTtaxKzZz5D0SrXLcB7rzz54ccYLZaTLPfB8L0zl40bMGHpeOcXOa5T
	jxOV4h27onrv0daGvaKuykRbtmvdNWkIH4G2auo1DoMqTIZkVgDzjXDn74tVm/jx9/NrU2qbMxz
	wUvvdsKa0Zr/75rGMU0ITxR0SQizANQG2dKOyxUj86zp75GXA2NFB8no2lYY3YSmVjF7sHptwtK
	kPDe64o=
X-Google-Smtp-Source: AGHT+IEDImNLEpDbeExd7a/CwLwEpkI62SjufT/nbplsqzlm5l6MTyrbVsJXoZ25z9KBxH8jSJvHqg==
X-Received: by 2002:a17:902:ea03:b0:219:d28a:ca23 with SMTP id d9443c01a7336-21c355eea74mr385862205ad.36.1737632328330;
        Thu, 23 Jan 2025 03:38:48 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3d7d98sm111571915ad.177.2025.01.23.03.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:38:47 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 14/33] cpufreq: mediatek: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:05:50 +0530
Message-Id: <4f57adcf5fa9f3c95d5f86c76a323f0c8bf1a0c9.1737631669.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/mediatek-cpufreq-hw.c | 1 -
 drivers/cpufreq/mediatek-cpufreq.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 9252ebd60373..aa209f5527dc 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -293,7 +293,6 @@ static struct cpufreq_driver cpufreq_mtk_hw_driver = {
 	.register_em	= mtk_cpufreq_register_em,
 	.fast_switch	= mtk_cpufreq_hw_fast_switch,
 	.name		= "mtk-cpufreq-hw",
-	.attr		= cpufreq_generic_attr,
 };
 
 static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 663f61565cf7..2656b88db378 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -618,7 +618,6 @@ static struct cpufreq_driver mtk_cpufreq_driver = {
 	.exit = mtk_cpufreq_exit,
 	.register_em = cpufreq_register_em_with_opp,
 	.name = "mtk-cpufreq",
-	.attr = cpufreq_generic_attr,
 };
 
 static int mtk_cpufreq_probe(struct platform_device *pdev)
-- 
2.31.1.272.g89b43f80a514


