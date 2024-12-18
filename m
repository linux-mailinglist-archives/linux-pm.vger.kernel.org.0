Return-Path: <linux-pm+bounces-19445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA749F6DAE
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 20:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2CDA16E8A8
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E396F1FBCAF;
	Wed, 18 Dec 2024 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="LilxEyCr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1A41FBEAD
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734548444; cv=none; b=JuYeL8MvALpn03j3GknrPTd3g/phxCbQIPQU3/GSJ3yH1EYxDnT8yNWawYm1AJPUdarBp/kKaX7K0NDjk79cuWDioxiD9pOjhz6nUReGzEUt9lF6kh+rwar56gz0GXuUD9HogspnTJjkMYN18bY5QdWjAzxKmT8DKnYF562SoTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734548444; c=relaxed/simple;
	bh=3JU3D5fdnjeSKWObC68sUxarYkjlw6eTRmEGmmylh/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZZcvUsd6eZYDKQP1o7gGiSGqk/fSqpnUKFsNUn7gBYKbO9c+kR9xQMOh4P8nXXBQKo2lXIgVeOsKREk7zjpbW0vqgvStnSEnZZzgP1IPgxKa9dcMH/KDpmTirJt7ILJX9hqEJFgZQrliltGb++2cFj3dPeKfoVBTZxn1CIEVXrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=LilxEyCr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso28674f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 11:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1734548434; x=1735153234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rf645LdDELIgH57lKsKAlk4JLWzN0a4S9pN6n+iPVOI=;
        b=LilxEyCrq6NX1QGBDsI5YWzczb2UA/nOBi9W6tbz0EjsxjLepBX/1iSyNz+eBXT6g+
         P2PSNhhxH494jhvqvshAsCHo4P574sSWkdTXxl3lL62wIZSWAiG+QNREZQcwoxmTHSMO
         1lhd5oLMLnhyII+/gsuLicpaPLzf1SCZv8hGoPUjJ5nupLBbyykiTKY2nCkDv/3DyCC3
         GMQK90vBokcDPZ5TzA+YP7ggpRLZfdA46gWRGArZeTT1pvM4GYpE9EkQWN7X588c4KRF
         0RULfaMsG5o0jXrXtq31MCC2yJYzNj2kKdwp900aqed8l75J8cVHrI0rNza8m5UvIMg1
         q7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734548434; x=1735153234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rf645LdDELIgH57lKsKAlk4JLWzN0a4S9pN6n+iPVOI=;
        b=CNX4g0UCuJ1kmI9BRFOdJ/8MeO523o/dBRTqH5sthZRtNh/SXU5NkCSMTeqlJInyei
         9JEJtnROKUTFS7XrSfO6N6mNBaujdQDwD2v/wISt+TzNJw1eTJ45JhxaHExzCkXY0sFl
         eKV1TO9ZxROlDkatMiabc8ADyKOMPaw3Zc94jXfcrljR9gh27EvZ05EwDFUglntHT1Vm
         Z0wY9p2YCYuYW9sJGXyTrqMhCR0gsE7szbtH54O90os5r+oGXYAIP0XTopU1c7L2zjhm
         bqizrVn3aSb0VjWscs23FaknOHE0rd5Q78MhBXhMOU6zcFdWnThp2OYivdrFXi0Xq7uN
         Mb6w==
X-Forwarded-Encrypted: i=1; AJvYcCUpuEerpkGnpBndzEPM2OH76fUho0e42I+BWvtcfFmuGhe4sejScJzMjoAVRInuqdLPexge798OBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1S4cnc2Z1jKNWhOSEo1aura2pBCTX3Z53zWP9vlseT5S38MYj
	jnIqaTBWgUoYuBClKp5S7cGq4O9J+j/b1MDQlFGRczEA5PH3YRiZjiqib5F2i70=
X-Gm-Gg: ASbGnctoGghZqXyhQpzAej5Fm2RbqHklrelT1M3bB/3beQAf2f5EhF+hXlwSgzrkJYi
	bas/PZv8+a1MRnLh20DeheXya4hZ51NEASO/f+gWLmRGzkmnSIUl+GFGblC5zWt5nz7EmMFAN4p
	BM8OeEI57e5F0GR5L8V4jZNMdLppcPjqiyQuhg6jk3BI6cG1qxL8jiOTq7yl4MkhwAZtCl99J4Z
	H+VZaVH7qIiafDKGGeHxXK+INK3txFX05rHSt+AchJ9LggF/ZXRlaTsWuuku0nJEkTKFD61i4r4
	0w1vFuNGAR3lqooCcj1Qy8VC4HhLpqQ9L0iKF5E3FM6ZtLxigtI4
X-Google-Smtp-Source: AGHT+IFJDvi2cVPno+bBTgTT8wZuU4yfxnNSv/4LDOA/7earHIAe1dz6Ah+3LuXa1MPkMEP9WSJduQ==
X-Received: by 2002:a5d:47ad:0:b0:385:f66a:4271 with SMTP id ffacd0b85a97d-38a19af8789mr778059f8f.4.1734548434027;
        Wed, 18 Dec 2024 11:00:34 -0800 (PST)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801637esm14661029f8f.28.2024.12.18.11.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 11:00:32 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Naresh Solanki <naresh.solanki@9elements.com>
Subject: [PATCH] cpufreq/amd-pstate: Refactor max frequency calculation
Date: Thu, 19 Dec 2024 00:30:29 +0530
Message-ID: <20241218190030.1228868-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor to calculate max-freq more accurately.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 drivers/cpufreq/amd-pstate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d7630bab2516..78a2cbd14952 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -892,7 +892,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	u64 numerator;
 	u32 nominal_perf, nominal_freq;
 	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
-	u32 boost_ratio, lowest_nonlinear_ratio;
+	u32 lowest_nonlinear_ratio;
 	struct cppc_perf_caps cppc_perf;
 
 	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
@@ -914,8 +914,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
 	if (ret)
 		return ret;
-	boost_ratio = div_u64(numerator << SCHED_CAPACITY_SHIFT, nominal_perf);
-	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT) * 1000;
+	max_freq = div_u64(numerator * nominal_freq * 1000, nominal_perf);
 
 	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
 	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
-- 
2.42.0


