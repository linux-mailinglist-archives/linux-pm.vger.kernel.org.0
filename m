Return-Path: <linux-pm+bounces-35691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88543BB747C
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 17:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F0014ED903
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 15:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F595285CB6;
	Fri,  3 Oct 2025 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3x9rx/E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B2C284885
	for <linux-pm@vger.kernel.org>; Fri,  3 Oct 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503797; cv=none; b=pJELD/1bLCXUdVE3tNfB/HuYCb4VLovoQWfLtDzRS6DAZLOMkHifD8ZrSbUiaEYjiPnqYSbW69ve1scRc0D1EvbHNpG3TnbEVHd7DGVeHPAGDdkLtZpG+CgZbqU4wrFdhF6/M6mpj/0lgovXjdLM4gvBqyA1JTpsmGk94s6x/CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503797; c=relaxed/simple;
	bh=cwH5NZo2bh906tN8MwSEO4J3T9h8Rf5m3rQBSanhKP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f436VuQdfnABwFHTX+TIP0VlZizgMvO7jYyfrGCvOF2DYLNqLzcmO94lyffY0+i3YD87O4xoH8Wf27c+oPoMfQef0qTUhf7X0kDe004ROOTGlAebYvDpyURsVsRPbQurm0yV9wOgZbhuyMIMSSiDafe+2UsXFI1dthaWsKMLI4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C3x9rx/E; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57e36125e8aso2239795e87.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Oct 2025 08:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759503791; x=1760108591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiWd74ZCGfHByAMCCnxU+D58hX3cmoUbDQ+hmZwcLEk=;
        b=C3x9rx/E5KH4CHXMNbzd/GPMRpOS/WeCLtqaiEbbMmhV5cnJI5dOfo0eetk8xdA+dR
         5VWEeL8TA0jhje8hiKSNbtSz94iB5194yAmqARawOlTq73UQwAsYPNS/b7VTWcc0IELj
         8A1/jQ5Sg0saQe5SVAju8scao3sw8Xx1dSpBBs+wLu7vdqHoNKMGLD5CMdGGzKBiZHIs
         qcKDMyySyEnxQm3xHeM1sKpXHHN//NRgWayRguCidkMkRBj7GE0Totj9S77lX/yjQ6tC
         X/DqNOoG5dOlAvejgogmp5VyWvdDu3ANgcLSSMRD/5dcJj8Itui4ZqIP/PJztZRjtoSw
         8dRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759503791; x=1760108591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiWd74ZCGfHByAMCCnxU+D58hX3cmoUbDQ+hmZwcLEk=;
        b=pfSblyAf0wRka1TKwVjjSO9xOfZl2b9XlAjQVTsH1h/SuHTgGl1+F5Z0RwQMOPtvfG
         +RiVz7Bai6deaemAsXz+dyVmIlgjlX1sRBAkl8UvYQOSrApD1lBOXFLS1xUEOttCPYnx
         9OWVSKvCe+P6qYFAy6T8EcfS/mjaMuIKupWoglwdaoZ4zeH8LdFvoSD4iJGhNVErLym/
         ge0T9IrWPAozesfq6zdwdx/KD7DLAcWWyy6mderNfTjHKQAFaXa8+agMbMpeHee/UVK8
         j5DQtaWpTubEhtOhnCc+SMLwwE18hpC2Vezn3I5Qq1AXAo2pzgHyTa9ahe7zTuX0X7E0
         6yHg==
X-Forwarded-Encrypted: i=1; AJvYcCXvc4cTszILD7Z0YaZssvKIJA4eupcOpCkUui2NK6/3sUJWflCKRDgEZ5o8RA5Tn4jHuhmKoYSX8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMXlf3PqIhhKjCzvBZJfnCt9O28zBPux0qLEEDr1vLCQbuvBXd
	8OvftJ3jeajXx4OzYVMjV2tgqnRqYcByBMtyI8gyXFdlTZPz7UYBCUCimabTh3sk7mLh8qNMusd
	PNOsC
X-Gm-Gg: ASbGncvmi1+jTR6Nu2Gm6T3gjVM5xah5WezSnVrYyS1F8nSd1cwWiwRZGM1w4qqWUcy
	8LejcXPHIajdzpod6dYZpEOydNMp2ycAVBvuhy2gfiGQLuz+oFRRQQWLf6m5qgbf39shZLE8VGL
	5k8gQpa/cXMMlFMKFSEK+Ow2UbX5pXLIDqUKARPJSh9w10B2NqHCDu1jUEs0f6FJTWEI6EPa/jH
	GW/y5seWgzFqb1yBzlj551ttOzGhN+g7zxLNU8h2q9rNwJ3wKaZvx9dLqtQJBZAyfW6b14TiOvw
	J6c6N0ZXcjkDrXKXy9tAC/VhAlCPwIuEaZDtdoLimDCeqUKx/ZZ4QUdlryVs5khLATgil5TFGOi
	mE1kP2yqQzWbsulB++1bMLOtA4dvCFklVmMz63jwSRhpJVES4XuoTtaxeL6d5SJjvnlWVwuTjzD
	fZxAn1go44dz9TeJR/8SsRmdpc
X-Google-Smtp-Source: AGHT+IGyJEOVsOGaJivQixkkTNrPfM7QlcKiFG+WBD/H9sXsSIxK6ThXRU5bBxi3vw/zF8JXbdqp6Q==
X-Received: by 2002:a05:6512:6193:b0:55f:43ab:b220 with SMTP id 2adb3069b0e04-58cbb4418e8mr977737e87.34.1759503791304;
        Fri, 03 Oct 2025 08:03:11 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011343b6sm1933369e87.35.2025.10.03.08.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:03:10 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Maulik Shah <quic_mkshah@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] arm64: smp: Implement cpus_has_pending_ipi()
Date: Fri,  3 Oct 2025 17:02:44 +0200
Message-ID: <20251003150251.520624-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003150251.520624-1-ulf.hansson@linaro.org>
References: <20251003150251.520624-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To add support for keeping track of whether there may be a pending IPI
scheduled for a CPU or a group of CPUs, let's implement
cpus_has_pending_ipi() for arm64.

Note, the implementation is intentionally lightweight and doesn't use any
additional lock. This is good enough for cpuidle based decisions.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm64/kernel/smp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 68cea3a4a35c..dd1acfa91d44 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -55,6 +55,8 @@
 
 #include <trace/events/ipi.h>
 
+static DEFINE_PER_CPU(bool, pending_ipi);
+
 /*
  * as from 2.5, kernels no longer have an init_tasks structure
  * so we need some other way of telling a new secondary core
@@ -1012,6 +1014,8 @@ static void do_handle_IPI(int ipinr)
 
 	if ((unsigned)ipinr < NR_IPI)
 		trace_ipi_exit(ipi_types[ipinr]);
+
+	per_cpu(pending_ipi, cpu) = false;
 }
 
 static irqreturn_t ipi_handler(int irq, void *data)
@@ -1024,10 +1028,26 @@ static irqreturn_t ipi_handler(int irq, void *data)
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
+	unsigned int cpu;
+
+	for_each_cpu(cpu, target)
+		per_cpu(pending_ipi, cpu) = true;
+
 	trace_ipi_raise(target, ipi_types[ipinr]);
 	arm64_send_ipi(target, ipinr);
 }
 
+bool cpus_has_pending_ipi(const struct cpumask *mask)
+{
+	unsigned int cpu;
+
+	for_each_cpu(cpu, mask) {
+		if (per_cpu(pending_ipi, cpu))
+			return true;
+	}
+	return false;
+}
+
 static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
 {
 	if (!system_uses_irq_prio_masking())
-- 
2.43.0


