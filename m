Return-Path: <linux-pm+bounces-489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D857FD96E
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 15:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68242821A4
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E181E53C;
	Wed, 29 Nov 2023 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axg1o6gJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D54DD;
	Wed, 29 Nov 2023 06:32:17 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-6cddc148285so301638b3a.2;
        Wed, 29 Nov 2023 06:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701268337; x=1701873137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YZXuNEt8EzwdILEA0pIWBrLgHEq+yqwXRZX9rymE92s=;
        b=axg1o6gJdO5RSbip9ZzzmZvO/RtJyOidtFjsJHFn9dqyeQQusrRIwzfv949sG7reim
         Asos7FLW2R23kKYM8KX3pzSqLYIAPs6HOt/tn23Q1u6mUOeDvIeWeLrjhforGcfbWoet
         2TUoS0kcpIjUb41bwJrklhyDer/uermRLClavQ4Q6zBdEg7U3EB1uFkkmV+Ht9D+QQTE
         u7nQ0VOSmTQfujZk+9t2q+lQqnHy0aFtup/KrAHRtkk785LEc+ARHPBejTCb2YImnYo3
         l2AR0g22YV+GTk2HCb5gHrOCytIqDwSVjR4x7HhLyAbxr3fTGzvnssHAa4FEIGiuTnVq
         lAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701268337; x=1701873137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZXuNEt8EzwdILEA0pIWBrLgHEq+yqwXRZX9rymE92s=;
        b=Ykm0p0tTjT83OaRjspwWckswFkF5v3FGCrgo/V54cEdu3KnfAoZV6pJqlW3eOSq7Dh
         LALpoiWgmgeibeZgADuAB4RkI9uofqOVByaZW/yoB+0iPZV2Fb1ciuuYvLqBrZUgGuGt
         Ar5oKOEXBgs7E/7Yyt1vvmNsRRbGlSlbMRgc8DPnO932637SRDb8aLIMfljDeRzhP4dj
         jukmtWTZ2IZdrp5a0FUfNgKOpENwvb7aI+tkaSBFJpip1eywkHWgcOu99yl/zBLwptJ1
         6FuCT23765cTM/30mDYprdy+qY/eZohq3pmcVWXz9kZ9+i2a+3s5M3cCPAVbDGnzMblu
         gwtQ==
X-Gm-Message-State: AOJu0YxnGq5jXiawCEqn74btnCwfDnD/xgCxH10tVQOOJJmruQt3qj7z
	RgjOks3j/TtXDULDv3Be9G+c9TYH4nrXM/3l/sE=
X-Google-Smtp-Source: AGHT+IFnlQjUW0F3T4SUaA+4PC0v/R7FdZScvVhDaiJUWb6qnszmnKFevlpeCWB80mzM2uUg3aciXg==
X-Received: by 2002:a05:6a00:1512:b0:6cb:e3c5:7cb3 with SMTP id q18-20020a056a00151200b006cbe3c57cb3mr26633617pfu.16.1701268337411;
        Wed, 29 Nov 2023 06:32:17 -0800 (PST)
Received: from localhost ([20.205.105.33])
        by smtp.gmail.com with ESMTPSA id i23-20020aa787d7000000b006cb4b7ffe2bsm10666551pfo.195.2023.11.29.06.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:32:17 -0800 (PST)
From: Jiang Yihe <jiangyihe042@gmail.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiang Yihe <jiangyihe042@gmail.com>
Subject: [PATCH] intel_idle: add Cometlake support
Date: Wed, 29 Nov 2023 22:31:32 +0800
Message-ID: <20231129143132.32155-1-jiangyihe042@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the Cometlake C-State is supported, support for Cometlake should
be added to intel_idle. Just use Kabylake C-State table for Cometlake
because they share the same table in intel_cstate.

Signed-off-by: Jiang Yihe <jiangyihe042@gmail.com>
---
 drivers/idle/intel_idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index dcda0afec..f83f78037 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1418,6 +1418,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&idle_cpu_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&idle_cpu_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&idle_cpu_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&idle_cpu_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&idle_cpu_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&idle_cpu_skx),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&idle_cpu_icx),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&idle_cpu_icx),
-- 
2.43.0


