Return-Path: <linux-pm+bounces-38565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E268C84BA4
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F5F534FD35
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 11:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB17318135;
	Tue, 25 Nov 2025 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ozy0T/E3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB9E3164B5
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070024; cv=none; b=EbUlx0HZPe+H3bSFPHx/eK/z5cdq2k7LS1PPQTYeJgWO6LiGiHuqOAOyicdwKgk2JAuFn+jzIof3apzcFjnSleXKUqysI5yKxwa35tJeCV0t7GgGHnA8fO1vLN8gw860772gHK6wX0ZOnVTnc43/ObjOGZrMtVruGJJFt+cXXPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070024; c=relaxed/simple;
	bh=0ObsQzJ1S8aelaCoYcrZLP2G/ftVmS6hZ0U7EyZsDXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoSgyLrTyRZjD1DCPZhSOcbWtRIYcnetBvjr7Ky3QXx9JdESigV2mnZhIJSu9+R1qJ/cCEXPk3EP/b+cvV+k0v1p6quj7jxXNvUnp8suo7mmxdO6bGsEPnlB71wJeiDmpLpz2BdzmDr/RytIF8YrDVHUaiYxkxLKhloFPTTM2Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ozy0T/E3; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59431f57bf6so5763703e87.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 03:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764070020; x=1764674820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AN6dvpy0YMflZKUplqB9lPyC8X+L5QXrs3PpGRd9+i4=;
        b=Ozy0T/E3L9xE8Tc4aGvNiOgyu3oECFsqVHGctY3/t9a6VRxNGp1fWHgpURig6BfC30
         oGrVb3IO0+QTOYxcHR4mU3m3Tf1oTFJ/Soghw7ZR87tnKLKC9tuc3NbvHaR6BsZJAEGh
         +9whh5RJ/bZXQ3XRIwVeP03z0jND22M3NKHuXqcnninPN+L11ILj4DbasSJ+19+WITrI
         cw6LFn7WtGXNku2cwBSrHHWMKgR9/T9Rmni+mUV7H57w3lPhPY5571cfM18jvYw58/4Y
         9aaxtAhyVrnkyNcvXkmS3qxOk10UUTecHSjLuD5SBwQOlsbul1NCoeitMG6YR/8i4gBT
         KBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764070020; x=1764674820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AN6dvpy0YMflZKUplqB9lPyC8X+L5QXrs3PpGRd9+i4=;
        b=FuJ3qlBLBAm6pf/c9e1rpTZ0JsBuIzjZfE7NwDeJe1Z9WL52MRpyA60tTbM0EI+gQC
         ojydn6inm4JF34Dct3Bn39FmWCgshtjZgpcmMPUZ110mYEH6/vkP6kjmmd5pcj6n2hc1
         h11xL95o/+TZw4JTWDJ8nT0Dx1Dc39voi+AudS+m4stfO5km9GrjaF3o0P+IPCOqFy8g
         CsRDsFdO9CCAI21gYqQ0zsK8QSGOp7WKF9dmkJJCm2Mk424IyTI9ZbpoaCd6I33lduvn
         Xbk86y/88c3esycgk1tIWSTfr225e5LnVrGGl5zIPqOnSLBz9SHCSCnhdCE15YenpGCp
         kZNw==
X-Forwarded-Encrypted: i=1; AJvYcCVdRAZwBvfcMdtKt8toU3XbX4IWHzsyNjZbRbi13KJyclPBc6uZaQ8T9nHwz6hHdkSJsy2EdmmrAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx79koPZSvoOuFjox0MPS9dOnHvcienhbWTiFaLueBGJyluScCR
	YZQEABjlZWJk2804o4+12q/Zg++l00NJDpxHi/+PIOto1AOZSiXU5PR+Gt7pjxFwQXE=
X-Gm-Gg: ASbGncvWYCpkgEBXlHXBZ38yg2vsbuQhMIIh6fA/xblrQYvLJG7UhbBEdCsAmr440Pt
	OjBGTEoVdCcCN2YbFGVp5AEEie7OcpU+xBAm040WY57tXSTRgiL15zDo2B0jMSFKMLpHTYKPzSQ
	EM4aSmlMxavBifH9gdhr0VfGuxvrKo0E5sG6e7KhjbVrS3PE/bYZysfFAh4oAFDr4GB605VdU2f
	tuV7oOfdn4HFYJ3Stil/hDLo5iMgArAUV2KzeafbUkjWl7oow7roaPWtopHMoD7yfD0wgKHBgwi
	4m/xCLw1cEC4b69ua4i1tfnEqcRcTgUAaMR2HvRokDQvFwYituwZegCTTcrgiQXgYv486jHHs+U
	Qij6Q8MlablMXTeID+H7Qc/PX9kllpJ650swqkf/vOVABn0utUeuYdW/sYV2ZHzkizU6QmIETIR
	GpTrTV6CoNJajKxJ9Hm+Ih+AJ8OOA7lw4dd7vSp71kr1WNqJwlrhaLodg0CEEc
X-Google-Smtp-Source: AGHT+IGxFbAVgLhFkE94TlbZzTA30uW9uPeS6eJKhZuh9qvjSZm3x7Z35cTuGkrMp5RHYfZTfiLMSA==
X-Received: by 2002:a05:6512:3a82:b0:594:27dd:2701 with SMTP id 2adb3069b0e04-596b529d662mr891695e87.49.1764070020428;
        Tue, 25 Nov 2025 03:27:00 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969db7563fsm4993526e87.2.2025.11.25.03.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 03:26:58 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Dhruva Gole <d-gole@ti.com>,
	Deepti Jaggi <quic_djaggi@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/6] pmdomain: Respect the CPU system wakeup QoS limit for cpuidle
Date: Tue, 25 Nov 2025 12:26:44 +0100
Message-ID: <20251125112650.329269-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125112650.329269-1-ulf.hansson@linaro.org>
References: <20251125112650.329269-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CPU system wakeup QoS limit must be respected for the regular cpuidle
state selection. Therefore, let's extend the genpd governor for CPUs to
take the constraint into account when it selects a domain idle state for
the corresponding PM domain.

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Kevin Hilman (TI) <khilman@baylibre.com>
Tested-by: Kevin Hilman (TI) <khilman@baylibre.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- Added tags.

Changes in v3:
	- New patch.

---
 drivers/pmdomain/governor.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index bd1b9d66d4a5..05e68680f34b 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -351,7 +351,7 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	ktime_t domain_wakeup, next_hrtimer;
 	ktime_t now = ktime_get();
 	struct device *cpu_dev;
-	s64 cpu_constraint, global_constraint;
+	s64 cpu_constraint, global_constraint, wakeup_constraint;
 	s64 idle_duration_ns;
 	int cpu, i;
 
@@ -362,7 +362,11 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
 		return true;
 
+	wakeup_constraint = cpu_wakeup_latency_qos_limit();
 	global_constraint = cpu_latency_qos_limit();
+	if (global_constraint > wakeup_constraint)
+		global_constraint = wakeup_constraint;
+
 	/*
 	 * Find the next wakeup for any of the online CPUs within the PM domain
 	 * and its subdomains. Note, we only need the genpd->cpus, as it already
-- 
2.43.0


