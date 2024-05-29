Return-Path: <linux-pm+bounces-8322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3468D2ADF
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 04:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B61E1C22993
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 02:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF65433CFC;
	Wed, 29 May 2024 02:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4xysLwa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680112D600;
	Wed, 29 May 2024 02:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716949874; cv=none; b=cYKxCjWoE9iU3Xj5a7fzCdJ2DP4At2O7nAYVO+gDNsQoh9/OaHhLmI6fy+0W7cg4DGVQpaezuzouxj2R6W2qd9l8bzkoUXXG3oKzOK4sCrLR+pB33/XhzuQHccGLAkvEo1r+GeEUtGTVt6RfaDaIE7YRk3ZBNBBjdlkuL01ZUSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716949874; c=relaxed/simple;
	bh=s0JJCoeVh8x5RnIYbaB2H25o/x3dJnPn46ytxptyeVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z7npCgdJ1LOMmuiU/KaCVvGfC5DBfrVuT88c//pSbD5+WwI8THCtgxVGyl/r6Ncfs0e47y+QhkZwQC3Eb6meBfEFBeshXfHjnf6q789ohWDjOo70Bb+Zeekvo+JewGYLhEkZtoJ1qVrKpWOE42WLVw/gfYUJY9mFR9e/1nQe5Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4xysLwa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f347e8f6acso936145ad.1;
        Tue, 28 May 2024 19:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716949873; x=1717554673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e6tzFU+P3Pvz/Mdh7rpOnTlyvAS2od3a+HevUw/HUkY=;
        b=B4xysLwaWcxaliegQjIIRPydG/25lQftGL6rHqX9umu2/nPxMH9KSXZg008tGDR0Rd
         6KyJ4Uazbb/RIo/EzAQFkjc4DqjvS5uijanISeGcLYRc5di7QI76HgfVkVK6+aNZCW93
         XTGtoEdDr8HXbz6FoPzDNtiedu/zJWyhZDaQOAliQ0sEex14w8qHuiELbfbqp4qdashQ
         evWjahY8bG0FvaEhDsAOfrKaQBlkNhbOli3fzLdTrplGYMPZpsPgzZMH6WjG93lJbH6V
         DZoCxinWpuKJ0KCIuuoBZSdt6gq87s4KVkQdI6kZYa1FOl1uYRaCOZMWM829OOp5KntL
         FgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716949873; x=1717554673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6tzFU+P3Pvz/Mdh7rpOnTlyvAS2od3a+HevUw/HUkY=;
        b=tdor4wgiyoruxM6MsDVnfpMWPCmJPJDKceucvX8bjkxH+iCtIi8OdqedctTTn3snm6
         lHN9KWh/AyU5grHN4f9RX9aOr6F/m1Cae7X7NsYA6G6FC5VgsI9PQ02smQAUEd5dMp7r
         Ku6N2KA9wyHaGIpPgUW8fMcSciZATp44DwqUJpUZiWQRzH5YGQNYPTbMX62ojk4MBstT
         M7m2XZDULDLv33BEjwxk7RdbcE6brWDN3Aoshbr33+8K/sjRbT4fqy262JAMcyCDbMIp
         RSV6hv/xyxrMtJn2fsl933jzCkY7Y8NAJEFeyz01VcaQmVKe91qJC62ci5ydy6+FrCvl
         slKw==
X-Forwarded-Encrypted: i=1; AJvYcCWXAbnhTjyCry97eazkdw5fAP1CDCD0KQ5U1Eisd92OMYKHrSaMSzTOTNLKzN6uNwBY5xsiyc0DabhNgh/NCs+aSqGpg35G8awAlj7F
X-Gm-Message-State: AOJu0YzQSMo8MXGRouFF5P9uZkwovz4ZhBNps/Rwq2WbJo62Fof0kAl1
	NfVlSTTmoyF1VA6L+PbRIYHtU2ZiG3E6BrOEtFwgL+1Km3i+YS1h
X-Google-Smtp-Source: AGHT+IHyTZT3Tio93IBUQuQWA42Fl+BjK5I1R17dF2ONQQef+B+lAqQ7sybcI6INskO8W5wkutcBnQ==
X-Received: by 2002:a17:902:cecd:b0:1f2:f70b:80d5 with SMTP id d9443c01a7336-1f4499328bemr155055105ad.6.1716949872411;
        Tue, 28 May 2024 19:31:12 -0700 (PDT)
Received: from localhost.localdomain ([111.48.69.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c967a62sm87825315ad.120.2024.05.28.19.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 19:31:12 -0700 (PDT)
From: luriwen <tgsp002@gmail.com>
X-Google-Original-From: luriwen <luriwen@kylin.cn>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luriwen <luriwen@kylin.cn>
Subject: [PATCH v1] cpufreq/cppc: Take policy->cur into judge when set target
Date: Wed, 29 May 2024 10:30:59 +0800
Message-Id: <20240529023059.2821104-1-luriwen@kylin.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a case that desired_perf is exactly the same with the old perf,
but the actual current freq is not. Add a judgment condition to return
only when the three values are exactly the same.

This happened in S3 while the cpufreq governor is set to powersave.
During resume process, the CPU frequency is adjusted to the highest
perf. For the booting CPU, there's a warning that "CPU frequency out of
sync", because the policy->cur is the lowest_perf while the actual
current frequency is the highest_perf that obtained via
cppc_cpufreq_get_rate(), then set policy->cur to highest_perf. The
governor->limits() intent to configure the CPU frequency to lowest_perf
and the governor->target() returned because the desired_perf is equal to
cpu->perf_ctrls.desired_perf leaving the actual current frequency and
policy->cur are remain the highest_perf. Add the judgement that whether
policy->cur is the same with desired_perf.

Signed-off-by: luriwen <luriwen@kylin.cn>
---
 drivers/cpufreq/cppc_cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 15f1d41920a3..802f7c7c0ad8 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -296,7 +296,8 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 
 	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
 	/* Return if it is exactly the same perf */
-	if (desired_perf == cpu_data->perf_ctrls.desired_perf)
+	if (desired_perf == cpu_data->perf_ctrls.desired_perf &&
+	    desired_perf == policy->cur)
 		return ret;
 
 	cpu_data->perf_ctrls.desired_perf = desired_perf;
-- 
2.25.1


