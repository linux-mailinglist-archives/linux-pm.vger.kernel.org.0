Return-Path: <linux-pm+bounces-980-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4079B80EEB7
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 15:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4A71F21114
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5911745C6;
	Tue, 12 Dec 2023 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mrcNinP4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84308F
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 06:27:41 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c2718a768so58380775e9.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 06:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702391260; x=1702996060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Srtyc9L2FmnDVigDPLvZ20bwEGcznbGsIksRkAyk9I=;
        b=mrcNinP4g6TPzc5Rati0xcIGMBZD3RAmYJAoOe/+AK39SMa2YraBCcHfUFfqbP5/d6
         DXBUbbZ0VuYxJo3FdCZ3SMODId/PJw5iPu/jb+KYIQgslErmFtmOfZy8q8vrBBOze9s2
         keR8NHfcgO7PQAKMZP0t4xp+4UAXiN43Glx2nknNA14ThmAJ+pxVr0JDqAdtgAf8eZes
         89uwulqLupoUqPLWDYi6b/M7kcuA9Kz7J+OoAdZDfycLg1BVJjGwAGAmogBJC3/8XjqT
         OC2dfiCsd7Sd87/J43Szv/qEfe7UiVAHuo76+mQW8GUyIhkWox62tpRAHdQ0xIW57il3
         LhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702391260; x=1702996060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Srtyc9L2FmnDVigDPLvZ20bwEGcznbGsIksRkAyk9I=;
        b=FGIQYqxB2lMtcHOvllZcOYNgiGuGAB34BrQ91aPEFwunHfTv1Afr4yV1UcFOVWa9Kw
         woPQ0lHpitzAIDAaG0KFWnDKY14t8qQ5TiTetJk8WLpLgjLkpkxvARp+THF38SZoKyGS
         ktDbCyWOidw9ulhfR62unBCiUy2dc62m0r3zR8hgEpAxF/oGsMlksVcQLNjMm4oN5wiS
         7VaoyW2IbZKSWAmjDowoVI8FW5BZvPAXRU7/YJ2JzIe44SYh2wXMP9c1YwzLWULn8SOh
         1ZGQ/iRaatAvP+vu4Y0BSeaChYf8uUPo+V7FpfN8NXs29erLelqch5xcxLseyLh+kgLV
         uMaA==
X-Gm-Message-State: AOJu0YwOFGw65Vc8oLt6qrgz4bvFBeaeSqow8GRtRCTN+cJw4P2ccJU1
	sjD8laq2L0wicZ/uzEkf4WWMCg==
X-Google-Smtp-Source: AGHT+IEVZYNuESRPJf3SrUdgnSNQA3/D7rxcbHH36IiDkYzOkOFOUBTfqnbL3HQ+Is5iFwmlPLB85w==
X-Received: by 2002:a05:600c:1c09:b0:40b:3645:4671 with SMTP id j9-20020a05600c1c0900b0040b36454671mr3704773wms.10.1702391260249;
        Tue, 12 Dec 2023 06:27:40 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a004:6e24:43ee:dd81])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b0040c44cb251dsm9078291wmb.46.2023.12.12.06.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:27:39 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: catalin.marinas@arm.com,
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
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/4] thermal/cpufreq: Remove arch_update_thermal_pressure()
Date: Tue, 12 Dec 2023 15:27:29 +0100
Message-Id: <20231212142730.998913-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212142730.998913-1-vincent.guittot@linaro.org>
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
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


