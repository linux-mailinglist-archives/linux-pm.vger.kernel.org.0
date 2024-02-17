Return-Path: <linux-pm+bounces-4039-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D018592F9
	for <lists+linux-pm@lfdr.de>; Sat, 17 Feb 2024 22:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729B02825C3
	for <lists+linux-pm@lfdr.de>; Sat, 17 Feb 2024 21:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF7280021;
	Sat, 17 Feb 2024 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="eI7TuNtg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB71E4A8
	for <linux-pm@vger.kernel.org>; Sat, 17 Feb 2024 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708205418; cv=none; b=cpJJg3J8Yli7t/hEk1x2AKotLFfd3C1fezxyJaAbkTx5KMK4kvc99Ucqi5aunzvMeUCtfttdZdWUtEsGy1ylMmTAJw0WBRADzFpl48bVW6E6ZKeyHNy6nVYh+IGXUaO+2q505hoS54OQETw3XitRkCb3WwKy6+R8sreeQtGlkAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708205418; c=relaxed/simple;
	bh=oHOAKuTy7J71OhteqliHHPUc4sWlt3H4+04j1XqQTGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KlvPuXw3lxFHYCS6B5rViBGcRQMFYufrB1h95LYyxywl4rdArYbGXA8teUiN1AW5fbbY/vDYg8AFWT573hAsHsSsFuM9sKilnN9nDjoQUbOBoT+u6xkdjXsD6WDkSoRjgqRR0s4JWqDNhbuBwuKUDS2bsWx0pXc6GXl/+vGAc5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=eI7TuNtg; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e2edb28554so629224a34.2
        for <linux-pm@vger.kernel.org>; Sat, 17 Feb 2024 13:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1708205415; x=1708810215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O2TjNiYVkyOnt5bo8I4KiLztzjuw78NyYvMLjikMof0=;
        b=eI7TuNtgEx7EeRlZ6+A6ndoN5Rt3ObQbScF+xb2faOkiIkPec17KMIpgOibgKfnb/A
         5OvILmB0I7kRbscJa1/JNPUZshEl4tgyKU7WXDJj21IMEMrPQmFcPsh/G5FDoVaB+FqW
         /YaG2vzeiWUHJu+jOlY+oFAqNVwwIxBbANlJ5QSwRuGZTIbNZLka5NXFsXauISXpU1Kz
         RrHfLCOVG5UyaEhHy4qBybdav1l/nlqPbb4WDZqHIgEl2TfD0AEI+FJhTSFVWC8PJTDE
         HJC//Am+NdlXZJde62EvnbogEOy301ZRn/vIxPn+tCFSLMIgf5uAmjFTZUyXoOhsoSBU
         8Byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708205415; x=1708810215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2TjNiYVkyOnt5bo8I4KiLztzjuw78NyYvMLjikMof0=;
        b=h4OjcIvKyiklki0FJRkNirarWg9jsYYBYwCdwufueMLu1/dUbldfCO13g0OmrtT0IX
         qvjpJ+sn5fzgBdTX600QL8eMsy/IwfO5R0vikHWrbBGvRhJABtjX5AGA4WUE2hBck9s7
         SHg/HuGxYYuo7D/Imvmldpe8YblHxF+Ucck2MTzlf3xoD8QcH5mW8iOz1g66K73l9/dc
         isnFrS6u8AIKD9olkuyzDRNjPy5hpmy2WsxgfxFU1HM2XtdeNlmxtis1aDFyy++KJN6p
         zvOMwsYcVL4WfP0PAFhh5aKuuatKOT00u4faJ0T5plnr9zmbPqQ8gsmSN2ukEYE8FkFi
         qQxg==
X-Forwarded-Encrypted: i=1; AJvYcCXXiLNv78nAgYjduqrh84zyUZiQFnAnDEHE4ujy6TG3u22eI+V9IZbD3Qke5XCfXeuW5wrT25EyNYb5RxyyXQg0H0gune4NRLs=
X-Gm-Message-State: AOJu0YzIsOA+93rB97hmKkriSEwHT6C5CnKpS0vDOLeEs6UTaN3q6YDE
	dQL2e85U9ttqYN7hXr25itwG2a94Q0y1VWCpTZSq5S16lVFj7efuyTO+u97Xy4A=
X-Google-Smtp-Source: AGHT+IGW4XDSRQnU5TqrVNGjd8jmkPOXe9/UfYHAlOzGyGXigM5epRQtoQ/vkhh8yDpNAprzFP48aA==
X-Received: by 2002:a05:6830:1b6d:b0:6e4:41bb:b30 with SMTP id d13-20020a0568301b6d00b006e441bb0b30mr2472025ote.19.1708205414732;
        Sat, 17 Feb 2024 13:30:14 -0800 (PST)
Received: from s19.smythies.com (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id bn16-20020a056a00325000b006e0cfe94fc5sm2090721pfb.107.2024.02.17.13.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 13:30:14 -0800 (PST)
From: Doug Smythies <dsmythies@telus.net>
To: srinivas.pandruvada@linux.intel.com,
	rafael@kernel.org,
	lenb@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	vincent.guittot@linaro.org,
	dsmythies@telus.net
Subject: [PATCH] cpufreq: intel_pstate: fix pstate limits enforcement for adjust_perf call back
Date: Sat, 17 Feb 2024 13:30:10 -0800
Message-Id: <20240217213010.2466-1-dsmythies@telus.net>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a loophole in pstate limit clamping for the intel_cpufreq CPU
frequency scaling driver (intel_pstate in passive mode), schedutil CPU
frequency scaling governor, HWP (HardWare Pstate) control enabled, when
the adjust_perf call back path is used.

Fix it.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpufreq/intel_pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ca94e60e705a..79619227ea51 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2987,6 +2987,9 @@ static void intel_cpufreq_adjust_perf(unsigned int cpunum,
 	if (min_pstate < cpu->min_perf_ratio)
 		min_pstate = cpu->min_perf_ratio;
 
+	if (min_pstate > cpu->max_perf_ratio)
+		min_pstate = cpu->max_perf_ratio;
+
 	max_pstate = min(cap_pstate, cpu->max_perf_ratio);
 	if (max_pstate < min_pstate)
 		max_pstate = min_pstate;
-- 
2.25.1


