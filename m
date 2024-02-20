Return-Path: <linux-pm+bounces-4137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AB585BF50
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 16:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46220B23A29
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 15:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB23876058;
	Tue, 20 Feb 2024 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="znmVRaGS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66E776020
	for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441202; cv=none; b=TYuSAgUruZSsk0mDorrEOEu850cXb2ufV6s3aEFgc9kUupMWwzVRfS8HIPrxIA9hsV1+lOJvzKG5+NKXiw8yZT/KV5lvzNpZk7LrIpxRqPY1xe0ioOx9kRSwS9ILCl4XO1WeT1XAjACFSZlf2ZRo+WsJFmIIsmHt2q3JnleW2b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441202; c=relaxed/simple;
	bh=RkjU3Ub4ClpkOSSOEN84+hu/XY6PSH0IWTUar1yt9s8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U8nJz0sM/uQVarsKsIfS1tOg0uqthDjMlKO5wHjtHGElx9SAygMI1SDS6IHkbrPCciQeWMkXsxZ7D4/5bshsVTOomjcg6wLJL64RdwJVMcRQZINbZJ32G0nC9OHIdZMz+x4m4Fiar9k7DPK5y3gMV40PWLrti53jqOeEhdLUanQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=znmVRaGS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4127188dd5cso2363925e9.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 07:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708441199; x=1709045999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJN21V1bop2AoQQK03hl+NSFZtBSAxp4abYemrkmzIE=;
        b=znmVRaGSJ6JJlCDRmvJMD0FoWz4wH7Io0JTJVv1GpGtNarkmgou1jwAvuzZmOo5MCI
         HCd8PBeBjeLbGtcijb43T+SdLsYkQw3q6BcNXCWO9rmQlHHxaUzul+kB/L+84LaS5xBl
         gsvTH1G8EwlkLnA0Af+vFZiILbyuAw1t2WJGmOjsElm6NaJL35wEJMffdMBwYe/SZfEu
         2n29Fq94TWG15u/qBUD/ivGqc3RW/zBAKaslQCHLVQ89+i83h2qu2TpXRjb39a3XE5bD
         W9abNXLuCGLXTP3hJrROU//oxwC0oRBladnYYXehiP+ihZVOxVkhtnHqLSFS+pmB9zUo
         frKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708441199; x=1709045999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJN21V1bop2AoQQK03hl+NSFZtBSAxp4abYemrkmzIE=;
        b=Xbytv7c6BpW8skJz9nJs7TGfKOi/DUs9MzRA/iIyUsmmppwFvl4gGhl69/09SzyuEx
         1sIIdp1ASQFwIFdhGTjm0KwXIQjaDRxP8sU6XFpjyuIseOndsM7wB2Sj30osf5d7QK/D
         VRDeIio/ekcJ0TTqqg7RlxvRn+nN45G6gn42ykUQy42JMUrcS6XgMd/kAo6V4PQ/BjPJ
         dS1CzkWAi35NVe9iCkkQfrzmQ8whyFy3JC5MdfLdSv4tXWOD8gDfZ9r5u1KzYD+S3fzy
         XBRhSdaqFZHorLNYH3q2QPLqCGvtzvuuqBjVYK9ec6w1S41L/RNncBgrBOD0TblLiQb8
         SiuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWmesdLSN8l7rh5tiUfsmJDYpKq561Kq5796gWWgTuoYzs3lNkd9Rrmr5LrBSLe3tRaPaZCPHkSXwPCMyiYWaK920KoN8TX80=
X-Gm-Message-State: AOJu0YzpeJS6wfriXHCjJoHvEHEcu8CtJ/npxtGbYCgdPTBiYKMoZiZU
	26KG2Zw820a8mtV4D/QKOwtmT4ZUismkMmfoYXfQyCPtHbtEv4or+avtUkc1oRI=
X-Google-Smtp-Source: AGHT+IF9tJG6cYo5kMgHAyXSW6LLub4Cy4QdsaVLmULHXyA1+3Ik6b0caALozs4YQUihhJTnKqZHLg==
X-Received: by 2002:a5d:64a7:0:b0:33d:ed4:5c86 with SMTP id m7-20020a5d64a7000000b0033d0ed45c86mr13698111wrp.63.1708441199370;
        Tue, 20 Feb 2024 06:59:59 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:8deb:bfb9:b028:6d5c])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b0033d39626c27sm9304405wru.76.2024.02.20.06.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 06:59:58 -0800 (PST)
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
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 3/5] thermal/cpufreq: Remove arch_update_thermal_pressure()
Date: Tue, 20 Feb 2024 15:59:45 +0100
Message-Id: <20240220145947.1107937-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220145947.1107937-1-vincent.guittot@linaro.org>
References: <20240220145947.1107937-1-vincent.guittot@linaro.org>
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


