Return-Path: <linux-pm+bounces-20847-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E784A1A334
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42BC4188402C
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F063212F86;
	Thu, 23 Jan 2025 11:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NWHY3iM/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9765920F07B
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632320; cv=none; b=sOouq+9aNoXPoJpcNa/nt8cpbZaxueGg3bHYgLMuq2K5KjNCrniNQzmiijoqIC3QJ9VHH1JVCpXliOm8AwAJsgYmObRs7QjTnjvHTv1Ezp1eEZyBtrntfvD1/V6KaSkE/lZURBxtSUxhFINKK3GIfxfUs/Fgit44Otc1jpkwZpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632320; c=relaxed/simple;
	bh=6DtFcJYmLtS0XPomO373HL7zqfxc6DRv2DtbO6xIpbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DhhZOqB8Tv7GgmCJkPI1aLl04j+amilpL1x792RQrzeab3Hi/GYRevzjrQ+fUb94F0ZKLza3XbwcuIJKGXVUYthaR2Zgl0r7tCQi0S7qeC9/S+FdEGSKvYjAWPu9pKGJEK2XWuF1615LQsFR8Xvr3e0qG1zxbhSFBUrexgsU7fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NWHY3iM/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21644aca3a0so15670185ad.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632318; x=1738237118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C//8xYSNLR6Oizw+j6lSO/S2euOwsVxZ7R8vVZI1QW0=;
        b=NWHY3iM/CeaNj5wiJe2rhoPnLG5dUTHY5soPYe05hWGjIFuOzMnQ8xdksr1x6udsDS
         kWWNdareBx2w9rBltpPtAztiDBS8BKF8nnN4ZAMfJ3TNGNfMRBcxKy+7eweJObXfDsc1
         0rDHcLebtCGUAgh76fZpuqgkeqx0DqAzWDNEUUqf83jMlinvfcmTh5bmCviGF3klpJYr
         0JSu7uZI4IIcjjWbIpoQK1mHwKsGf5lLxQYAGxBv8O/ZpRNZM8TzcdxRYVQAOD2uu31J
         S1BngBtCnMagxf3n5+xzksFE+MvajMWNiJGy6vfJbSkycZgA87jYQhG3UifM2Iqs1uuf
         h7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632318; x=1738237118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C//8xYSNLR6Oizw+j6lSO/S2euOwsVxZ7R8vVZI1QW0=;
        b=u1EdzvoSUkGepQ5Q/M+E0E8zNZMl96ToiwNd4gzbEv3ft3mOYG31ly2R6Imtu3U9PJ
         v7XnC+worNoxWH9x7ufxQvO2YSi7g2JAXdnNPBgDig5TJoUPD7YJjKPYA00R58skVbu5
         M+sAEmg5HL+57rc+IKuNUm+E4aL2p4ZMULUqXLeQwmSvDTwtVc05pg1Fcdx66is15uPB
         cBC4EA3/5xQZfaYqlTfI+6DVs+5fMfMEokNgR/P1rF9A4JX7+q+/megDm81ljYQt8bcW
         zRCliRdo7PDvjAsh2snHZ9Z6USSCbja0R1ZgxLm9XWfvYXsbriK9jAo2Mfa0azO9qNJI
         GJqg==
X-Gm-Message-State: AOJu0YxNBJJKufFu6ET7mHxEPmI2AyohMjUsLpyh4Mj6FFEHi9apSxpu
	K0UJf4JoNt1ESegcl/XdOvupc8PVWbsXOTfPNIf3GlnU0qWPTVcYM6W4HBDOEqg=
X-Gm-Gg: ASbGncvEX2n5MnezkVMVAQlOOnTQcfx2ihFQyom2eflRZxF6rRqvW5XY1+/v5UjVmua
	EnisSzwszKO/D8AXYOXTsRhqxEX/yFCm5CgKD3kVBGU1P6w/TV/PfT1RdNbO5Xvymku/j3ewGsE
	ZIRCIaF8J7bUGHg24at2CB/S4o5gbjkw9gLtqJ+5dxXYt2LTSiFyml5hhXHq51DYuGFv+sHMtjC
	uy8JmKQTQ2G8un8Dx3z01WWO7PW3E630devh8yaLtv/s971kMx0c52NLm8xTvC45qyUqv36DyFB
	wt49WbI=
X-Google-Smtp-Source: AGHT+IGKhVdwKWlFQhhgZxT0fvm4HefE1GFmObSRKUGf2wcrJhga758g56vgLwzrjCe1dxxNLU26Hw==
X-Received: by 2002:a17:903:22ca:b0:215:603e:2141 with SMTP id d9443c01a7336-21c35511d01mr416669115ad.19.1737632317985;
        Thu, 23 Jan 2025 03:38:37 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3e09d5sm111215965ad.170.2025.01.23.03.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:38:37 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/33] cpufreq: kirkwood: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:05:47 +0530
Message-Id: <f97bd07af6905cf4fa5460af53d061c22000ef27.1737631669.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/kirkwood-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index 312f2654d1d5..24b285cbeb8d 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -96,7 +96,6 @@ static struct cpufreq_driver kirkwood_cpufreq_driver = {
 	.target_index = kirkwood_cpufreq_target,
 	.init	= kirkwood_cpufreq_cpu_init,
 	.name	= "kirkwood-cpufreq",
-	.attr	= cpufreq_generic_attr,
 };
 
 static int kirkwood_cpufreq_probe(struct platform_device *pdev)
-- 
2.31.1.272.g89b43f80a514


