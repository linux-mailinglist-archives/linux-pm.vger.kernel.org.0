Return-Path: <linux-pm+bounces-10297-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ADA91E645
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 19:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281F51C2224F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 17:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4559016EB40;
	Mon,  1 Jul 2024 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaCsXyfm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA5016E880;
	Mon,  1 Jul 2024 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719853877; cv=none; b=fZfKtVOkzTT4RE48vs3mHA76M1Rmp3bNwH7cQR9Mxqkfj+pheHc0VBA4jFi6+VevhS0zCCsKmCnTDLchRlKlxpdveJJEQxRx5mo74gY+mLJWdFCkUdNuaH00Oj5PstAoyi3xB7jOS6CH3LOLfWydl38ZurQy5uArOxSmW0K0i3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719853877; c=relaxed/simple;
	bh=R0NWfF0fDtyeoauyfED8t0eoe2J52bkoikEJUoUb0Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SBcN2tsJsq4A6g7ex/e4qhklVrrUOmUm+mfA8rZHjNxpN/Ap3fsHtoUc6xG6AwnDjQTL4xFYfsHQCa3kSDkDrUacYG3RDq9GBzFqpNB/6cfALALxcVPugfQVtN5uNZfMWDJZQYUAysdElGKabkI7kwprK4cCZLVDjfzVul9u37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaCsXyfm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so19673815e9.1;
        Mon, 01 Jul 2024 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719853874; x=1720458674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RFr8Ofpiwm2nPtOKnS8vgxJYURmMVP4cZnCgpB044ic=;
        b=WaCsXyfmSAUdLIDFnCXlF2N6Xv7PYAUVbmjLbCk8yZSblydZgRFWuLpOL8KiQb+mRY
         kDGrMIb5+oKYwCQdVJbYTVIrgp70mA0zxoHOlyFNlJayYg/jDFxRvHs2xz41e1wuaMi6
         jinbSQvuJzy6yVoy8wNg6E07vH1cVPZUet2gbLUW98YVV6qpupgs89/P9fr9apEeFemK
         QQu2oqjI4bV6rdExuEqF0GrZuvvG9JIYWd0JLZ7wvvfnOZtyKWYfa19GWJn3ypZnSYlS
         2Z6N+a0mHU4s44YbeWFp+1LavBajvRmvIiMhcYblT4YNWWUZesDZVMV1uM7rH8uT+Dyw
         0PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719853874; x=1720458674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFr8Ofpiwm2nPtOKnS8vgxJYURmMVP4cZnCgpB044ic=;
        b=ohaprcwnSNjorvs+mDM/QBmgy65+wRi1LXac8NAlADr9tHcL43+HQvzm7MlCVL3Vjq
         5J8vDaAgOF43aXo3ft4/8/FsmUgCHosU+QABCE/1xoPFioDw7FjvTen4mxMd80ytDGgh
         1iA2Mb6m2bW9wz87G2JneEA00QubejYDFI1dbJXcYkJQ9mHSIaODzJ5pNEc8CDc4Ds5y
         2Gp6Czb1MyXub1Sf1VQcY/naJoguVniUEH6ZU4rZvSpYAn5rUneHhjUohV4pqcDclL7r
         Pij1sck7/acJv3EtheUh0z6Cb2SPY/VDU4RrcvpL/G6sCQbVgh9F+RF9zPOlEqVfEhKD
         +zSg==
X-Forwarded-Encrypted: i=1; AJvYcCXJfZtWr3FHG8LzbVrPt+1aAQhTX02o4RRpMCjPI0ymiGpP/pUOF8UU+R2MDKK+xUUDeyosl9WRvvSJaRD+Cy07fBQ4IUd6sBLmJu3prsfT/2fc8U4XfJRQTlU/J/uxF4q4roePuSVt
X-Gm-Message-State: AOJu0YznAd5ha2fXlhSeJC3YAyr426+coJnRd7erIr0o8pOq4BBS3kTV
	KFY7DxYPIOWa7bs3LhIZ1hKhsTNLrlRYSZPlrRXUFh5IhiZBTMZv
X-Google-Smtp-Source: AGHT+IGj+dj/EQvMf0Xx7lgxXlKS6qpK6UTruNerxqVaDzO91UchOJE4v36wVK4R6I8c1OknxTOwXw==
X-Received: by 2002:a05:600c:3089:b0:424:ab8c:a24e with SMTP id 5b1f17b1804b1-4257986256bmr53666225e9.11.1719853873438;
        Mon, 01 Jul 2024 10:11:13 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a104dbdsm10581949f8f.113.2024.07.01.10.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 10:11:12 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
To: "'Rafael J . Wysocki'" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: docs: Add missing scaling_available_frequencies description
Date: Mon,  1 Jul 2024 19:10:40 +0200
Message-ID: <20240701171040.369030-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a description of the scaling_available_frequencies attribute in
sysfs to the documentation.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 Documentation/admin-guide/pm/cpufreq.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
index 6adb7988e0eb..fe1be4ad88cb 100644
--- a/Documentation/admin-guide/pm/cpufreq.rst
+++ b/Documentation/admin-guide/pm/cpufreq.rst
@@ -267,6 +267,10 @@ are the following:
 ``related_cpus``
 	List of all (online and offline) CPUs belonging to this policy.
 
+``scaling_available_frequencies``
+	List of available frequencies of the CPUs belonging to this policy
+	(in kHz).
+
 ``scaling_available_governors``
 	List of ``CPUFreq`` scaling governors present in the kernel that can
 	be attached to this policy or (if the |intel_pstate| scaling driver is
-- 
2.45.2


