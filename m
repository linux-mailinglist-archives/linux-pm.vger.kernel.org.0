Return-Path: <linux-pm+bounces-2010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEEA828A5A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 17:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03C21C24B08
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 16:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5C33B799;
	Tue,  9 Jan 2024 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKiRaur4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332FD3B293
	for <linux-pm@vger.kernel.org>; Tue,  9 Jan 2024 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3373a30af67so3014343f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Jan 2024 08:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704818824; x=1705423624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJN21V1bop2AoQQK03hl+NSFZtBSAxp4abYemrkmzIE=;
        b=wKiRaur4B5Zh8VTv5woArDyYLSojDNZoLTgfHX1p7rrRdC6SkE23PuQmkLA/rbaFaV
         PFTfG0764exOzbOPx6zLhrP9aTB1JV2hKnoGaNpC9pY2SECe3f46ikE3vVzhsBzcuct8
         mfz68HZODSpGOV5Q7oYw/jX+BJUFliu4HywyB5iJqGG0s1eS9JEFOGvl8LcRCewjkUNi
         FF0+kCGTbRQGTTawnkRXMjarBYJNWnLsOJ4RynZqH3IPN2C0KRbSOHXjbsJYqj3k1sIo
         szfMi4eMRn2eS0uVjiu7Z98GeUrbh92cktEnSGXrpEpUz86S8BDyNUgZTZ8GuTk7O2M6
         FeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704818824; x=1705423624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJN21V1bop2AoQQK03hl+NSFZtBSAxp4abYemrkmzIE=;
        b=PknLwzSCCIHAL6Tthis83pp7tvDHluhTRMHC/U1hxrAzu2cbDdxceSC5LFPW7JoIdY
         U+PvopzvaOkPkkNszS8x2P5B+FrwEAB/tFQ60xBizzEVHluspxb/JWGBNZbhWCzzs7FZ
         6U2dB7KgEQAkxxtcEudXjdntZYLxSW9mIQYTFyzNfbOidx/vMwecNx6/BZlQg1ZiiuLd
         gjdqACmm77LsFYNYExRXLL+r1uFZvf3P/0AQcjmyJ8M5yq5vHmoXC+ypMl2+khXYUhhJ
         ycLaZV7eJC9PbJb3ArILfK2rEKn7RLpkfp/rI2wtsvuklJ6Y7zh30OMLimQh+i8een3S
         mt7A==
X-Gm-Message-State: AOJu0YxykOP7dtQV0468GayODdbaW2E/S1Stv8iNV7d/llQAK0xB6o0E
	BmkUW6jZERRq/Qlx2RtedBJXGFIS7ja31w==
X-Google-Smtp-Source: AGHT+IEvlNytvVJlvTPpPwPO+qKiZL8zyQNEs4mDtfVfHwEckXosl+y6Ud/itCsffCbRJB9ZysRO4g==
X-Received: by 2002:a5d:6b02:0:b0:336:c403:56dd with SMTP id v2-20020a5d6b02000000b00336c40356ddmr399099wrw.150.1704818824462;
        Tue, 09 Jan 2024 08:47:04 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:378:51f6:d46e:8457])
        by smtp.gmail.com with ESMTPSA id r4-20020adff104000000b00336a0c083easm2847845wro.53.2024.01.09.08.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 08:47:03 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	agross@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	lukasz.luba@arm.com,
	rui.zhang@intel.com,
	mhiramat@kernel.org,
	daniel.lezcano@linaro.org,
	amit.kachhap@gmail.com,
	corbet@lwn.net,
	gregkh@linuxfoundation.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: qyousef@layalina.io,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 3/5] thermal/cpufreq: Remove arch_update_thermal_pressure()
Date: Tue,  9 Jan 2024 17:46:53 +0100
Message-Id: <20240109164655.626085-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240109164655.626085-1-vincent.guittot@linaro.org>
References: <20240109164655.626085-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_update_thermal_pressure() aims to update fast changing signal which
should be averaged using PELT filtering before being provided to the
scheduler which can't make smart use of fast changing signal.
cpufreq now provides the maximum freq_qos pressure on the capacity to the
scheduler, which includes cpufreq cooling device. Remove the call to
arch_update_thermal_pressure() in cpufreq cooling device as this is
handled by cpufreq_get_pressure().

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpufreq_cooling.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index e2cc7bd30862..e77d3b44903e 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -448,7 +448,6 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long state)
 {
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
-	struct cpumask *cpus;
 	unsigned int frequency;
 	int ret;
 
@@ -465,8 +464,6 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	ret = freq_qos_update_request(&cpufreq_cdev->qos_req, frequency);
 	if (ret >= 0) {
 		cpufreq_cdev->cpufreq_state = state;
-		cpus = cpufreq_cdev->policy->related_cpus;
-		arch_update_thermal_pressure(cpus, frequency);
 		ret = 0;
 	}
 
-- 
2.34.1


