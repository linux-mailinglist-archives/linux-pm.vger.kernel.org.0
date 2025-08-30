Return-Path: <linux-pm+bounces-33463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D33B3CB79
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 16:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90192564240
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 14:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A94424DD17;
	Sat, 30 Aug 2025 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EprN2YXG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA89274BE1;
	Sat, 30 Aug 2025 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756565091; cv=none; b=GMvOqYDNTzl65MaeCaLqdvmagb6T5BeKE9LlUZIlLvok0rKMVvwoMI5/BAHpjWxz0ZMJ1ZNeHrKvewUAqn5r7TUGa+5JTDDDYFgSAKWQ58WhZshuZBifXxKdCkDkysMbWZMFJlDnCZvoXT52kMYxG0pn0XTSwyTr7gLZK90hmao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756565091; c=relaxed/simple;
	bh=MPgVxSoskDbQAvK6hl4JGGD+hsXca6+MVDJ83Ril1t8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DgWHAvi4GU13gSCN/HOvk5CKGlggFz92R6lnILq/xIzTftbtuyJHhbYlaL+Ztvh+//++BC13Q+3+/7dkwgzuSa0amIslMYikL6fKSju21A5xozWptqpJqEL+f5BkFYjVfEniqybbbg+t9z2cOuPmA3J2+zxEFDaui1gs0SwdlrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EprN2YXG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso67598f8f.0;
        Sat, 30 Aug 2025 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756565088; x=1757169888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q6E7g2uOsAn7LyhANHrKJu1DW3W6P8A28ASTexBlNY8=;
        b=EprN2YXGNURmqPOoZJ3TydpGUEd9hMx3v+TTpqMIeMxOIhXskGkIerem3bsa35WK9r
         sFj77PmRn+uzBO1MftHTdmBjAMo/dY9TYDmhatb+9zI2IHWVf9O/pTFM4/9CRDfDnKvK
         XeBbQz9Faatn5DTfM4y2TZsslEOktlehfmJf5CXwnkuYVRngC6duSqXa2XlVWWRaY0it
         pSNts1dxpIo+doFPKOZqZA1I+lFsUrs/fcsqBht3A0eVFPSsL7UrIjIwGyWE+/AvDfoq
         El9dmLmkLzUOcClVpoOiwP838O9ewmmCkXkOqiEAjUltv2RTDfrgo+2FwfcVHA5k7067
         dH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756565088; x=1757169888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6E7g2uOsAn7LyhANHrKJu1DW3W6P8A28ASTexBlNY8=;
        b=mUW9grQIFjrzYgu15EosLpi17Gi1izZqBkhcSNbK9Lauf+h6Y5zzlwDvUo+iAsZc1Y
         J3hz3oo5VWGpt5oPyBsxYsZh4XdznpiPtOKLNa2/0p/Hvkn20jtWbsU4m+FyniFEUqAv
         AHuVRuUWLILgAHu89bmeTTx9KLXtOxNBzaqe+szIbaSXjDiaHiLGS0Q1yOEnaOPPqgUU
         q+1kCZ9rZn7Qvw3u4m3Gy26jzHeyOvshSbICvzQcguVGMiu8Wd+ZbmvO2MeE2sdw9hHS
         s2L2lS6AwNZfpsPv1jYZLphHPUttdo5zaXfZRXWwGhylZpCyF0QWRkMq9en4fSFGX1dC
         IqyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXRePQkN2Ao+x13AkAayUe2PftqCpAox7ckUjrjQovuw5y3D9U+Y/ejGlQseOk7GoZ6DDVM/GeaPj0lfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZkoO7j6yNTZgw1DxKmmzlLPZNqkdlaqMSqR3hQxNw3Q8rZt8
	oLbg8H/EJYDicvRlLSRAyaEESEHR9RjVzYOk9GrSz6vfJKCVaGlPBudZ
X-Gm-Gg: ASbGncvVNldQ2j+gew+SlwX+jMWPPwl4JM18nTX1mLczq+maIppCB3r9/d+Ye3QPHp6
	odmvwgf8nPf4g/armIanRgOoCn0+ysYJWWr8Ha3h3w92wK4mghZ6qYOGWPnofBNl5hA6pYFFPuS
	jh73gzlz/JfwkCOyCbEIjDkTc/1F0Hn9Iye2eLaDF+3mDDjNsW7XFBrV6/3eN4or4z4VC6fkW0/
	YZfBWG/j7c8/DC1pVOMqUPEqnuPb30aZd7BeyjzVc8IJ6fDtrhyUwHKvkCQYHSJr1hLjOsrinad
	gg0M5Ln6z4TmTcEIfQtwRNJZkSUzok6Lw0ymcwvUGvHhe6TX/86eMbJCoA5BBr2Bkoc0peZVBDF
	RLqdRIPxVnYTbGPgmLOr8UJcZOeTXL3T08UsQdK/7OEZzn5WgAUSjJ94i303Srr5IrNnJYyoAHp
	v/wuJlj6Q9GqGk60dmFUHJkNR7gvBJR/5x
X-Google-Smtp-Source: AGHT+IF81SpwzRjpmXLZ7x0IKdwCH4AH1qZCKRXhWesfo99k6WH8RiLVpyLqgST48/i23C03Kqy2/A==
X-Received: by 2002:a05:6000:2204:b0:3cd:9794:cbcf with SMTP id ffacd0b85a97d-3d1df53a1aamr1635045f8f.60.1756565087779;
        Sat, 30 Aug 2025 07:44:47 -0700 (PDT)
Received: from fedora (2a02-8389-2240-6380-b418-985e-6bb5-99d0.cable.dynamic.v6.surfer.at. [2a02:8389:2240:6380:b418:985e:6bb5:99d0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6db6sm172913175e9.2.2025.08.30.07.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 07:44:47 -0700 (PDT)
From: Dennis Beier <nanovim@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dennis Beier <nanovim@gmail.com>
Subject: [PATCH v2] cpufreq/longhaul: handle NULL policy in longhaul_exit
Date: Sat, 30 Aug 2025 16:43:59 +0200
Message-ID: <20250830144431.159893-1-nanovim@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

longhaul_exit() was calling cpufreq_cpu_get(0) without checking
for a NULL policy pointer. On some systems, this could lead to a
NULL dereference and a kernel warning or panic.

This patch adds a check using unlikely() and returns early if the
policy is NULL.

Bugzilla: #219962

Signed-off-by: Dennis Beier <nanovim@gmail.com>
---
 drivers/cpufreq/longhaul.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index ba0e08c8486a..49e76b44468a 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -953,6 +953,9 @@ static void __exit longhaul_exit(void)
 	struct cpufreq_policy *policy = cpufreq_cpu_get(0);
 	int i;
 
+	if (unlikely(!policy))
+		return;
+
 	for (i = 0; i < numscales; i++) {
 		if (mults[i] == maxmult) {
 			struct cpufreq_freqs freqs;
-- 
2.51.0


