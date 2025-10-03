Return-Path: <linux-pm+bounces-35692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AE3BB7476
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 17:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4D9485849
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 15:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6184C28642B;
	Fri,  3 Oct 2025 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UiBgaHat"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F930285058
	for <linux-pm@vger.kernel.org>; Fri,  3 Oct 2025 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503798; cv=none; b=GDBL2YK2ghNkF36BemGeZtCNAxI11LCI2iCs4wHBmK6vUFisJ7iTUIMlGsmIz6vdlKDbyYL4uNRZiAe2wJR6xDchTIQTrk83huRz4DNpC/2sn1GPll3BlQ8RXZp1Q0P0t0I3As8altR2qb27+A/qbwLEysj23tVsgs5fmzBFR4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503798; c=relaxed/simple;
	bh=AXCrGXN9rK3o1GNT7tRiGh1jrV37gWDegzLLQuvmcZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odR7v84crekQ1FfASXsMztVGchZ0nHuddrgTw0dEr7PdudL/ZOk0gI0TihuVxrDoOYpZ2fYpV81N08dNpDPj6GA1Cjzof87W54dVm9bhjz8/ONgXbiSTEdRixaTmQZah1yy8Ur+BB8SVkNlaq/H/Gij1Bpg1zbuYb4oWa9SOOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UiBgaHat; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso3272874e87.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Oct 2025 08:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759503795; x=1760108595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox+4Or53Zo/RT8nK1iXRO8MRcxCOezKN0PgiKGiKSzk=;
        b=UiBgaHatkjU8Ht6zlSG7EWWaPsmAw2mhL3Q27DDasP96smW84UUwAaxX7UMNBLiRMq
         +MVLzAlAwgad+46eRCsCOKrcJ/r2UDfTr3S7V2mEOP579Y+PxeufrrUWPZNXNtwc0TjP
         Kd01AHb7O8/q0YBuvVzsNknZ9EMaiZLa8Tvgcj0I7rMS0B2lpAkxz7fbVh4MMvK9hzC+
         8HiRaLKnWoAUNDHg6D5rkjAbY585FYJvUxSrYwnyNcDT52SzqBCT+jDJU9PlW7tS5oLG
         yp3ddkZnRbOQ0LrI2EHyXJ2o/2EgTzAHFuhhT3KiqxRKf1ke2Tli+YWdNWwE2Zhkp5HO
         j5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759503795; x=1760108595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ox+4Or53Zo/RT8nK1iXRO8MRcxCOezKN0PgiKGiKSzk=;
        b=rQ5qD+wyAXHS5cyj6XamFI7keXxyxJCChY6OeDWyJx8bTCnwzPYyC+fNOFsXpLB3ao
         el2n08421/wE2Sghm44sYa20tFh9Jxdxs9pW/Q+mIAqqgD6lKC7OMBE/X6+6dMR11bJL
         0nttzQL0XHl9I8Bk5Ksr4wfPqDWM4yrW5fvMMxmIjULHq2zy37fSt3IB4l1H/VmWTUd6
         Aq100zrUZRxmu/Oo/ID4tra0DkqUuSWwkUzRePw3udQ6WhHxT8R6Pb6nYMHimz/W6/vF
         hA3I8+F6lPxahJ8KJ0hEwssmu8Z+LAZ4D/KPdlOfBCMlGbQObbsSYlVZlW+G3SiAvJX5
         2nMA==
X-Forwarded-Encrypted: i=1; AJvYcCXpTW5ScdabzylbiFsfzTEhQn3xF4YYQrwI7KWn/Es80lR20FpYpz8ecNeU7f+2qkKR2jNYWaKTKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDcOx28D/k7Pv+Wqbu2a6bbotyM1ATJrJUr+HLlVsBlneo7ld7
	S/XUIpYnMBqW1KIQrXwIRyTmMprAgvLQF+W8xse7f/RJCWiQkGSGZPqM1bHHQ7/WncUUKFFUEPB
	2/RYW
X-Gm-Gg: ASbGncuviAwEw10lJ6hnY5sqfWa/LA8+nQlu9pje/mayTuHXAv7Isuicnx0ngid8DKI
	+93Ur0SEk9qFylF9VlpYERjTD6jM04hQLTkZhoETscqdLXQcz1gU9YTTv/AyMWf0wuT4OePt2up
	Zv4x7cLCrzTqNV0QbXDw6trFLbniSumQNNxURUGJ/0jdOMVNfJZpifMHnZojkLK09mbFTRgsaS4
	l7H7/YifCHU/2huE4jrFntLgFYzHPvT1Q7Nr+qLQBpqrAfDOjFNqTl9Po51FwYQHmgpY0UozhoS
	YyYaqGuO7Yg9Spmz53e2W4vy7WjsGgB0qrW6N07Y0jouWuj58kEWrXrPgzRU9xvIxVxRpQWgQrj
	4Ic2SG9dAOoAmze1G/NxcyVKh9rFupWt/+5QONp9BAsGySMloQqzlQvu46OBIAecdS30wb4uWeC
	A4NT+M2StOG9MQpyLEytPAvRDGxsw9w8qGC4M=
X-Google-Smtp-Source: AGHT+IH13UMFUj7Zpgvxqzpadk8FthG6NhdcXG10MwTPwlzbyaOGt0KOWk+7mn3p72gNfh5AfAblSw==
X-Received: by 2002:a05:6512:3e10:b0:57a:de0d:d9ce with SMTP id 2adb3069b0e04-58cbb90df9cmr1031413e87.44.1759503792699;
        Fri, 03 Oct 2025 08:03:12 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011343b6sm1933369e87.35.2025.10.03.08.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:03:12 -0700 (PDT)
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
Subject: [PATCH 3/3] pmdomain: Extend the genpd governor for CPUs to account for IPIs
Date: Fri,  3 Oct 2025 17:02:45 +0200
Message-ID: <20251003150251.520624-4-ulf.hansson@linaro.org>
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

When the genpd governor for CPUs, tries to select the most optimal
idlestate for a group of CPUs managed in a PM domain, it fails far too
often.

On a Dragonboard 410c, which is an arm64 based platform with 4 CPUs
in one cluster that is using PSCI OS-initiated mode, we can observe that we
often fail when trying to enter the selected idlestate. This is certainly a
suboptimal behaviour that leads to many unnecessary requests being sent to
the PSCI FW.

A simple dd operation that reads from the eMMC, to generate some IRQs and
I/O handling helps us to understand the problem, while also monitoring the
rejected counters in debugfs for the corresponding idlestates of the genpd
in question.

 Menu governor:
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             1451           437        91         149        0
S1             65194          558        149        172        0
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=500
524288000 bytes (500.0MB) copied, 3.562698 seconds, 140.3MB/s
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             2694           1073       265        892        1
S1             74567          829        561        790        0

 The dd completed in ~3.6 seconds and rejects increased with 586.

 Teo governor:
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             4976           2096       392        1721       2
S1             160661         1893       1309       1904       0
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=500
524288000 bytes (500.0MB) copied, 3.543225 seconds, 141.1MB/s
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             5192           2194       433        1830       2
S1             167677         2891       3184       4729       0

 The dd completed in ~3.6 seconds and rejects increased with 1916.

The main reason to the above problem is pending IPIs for one of the CPUs
that is affected by the idlestate that the genpd governor selected. This
leads to that the PSCI FW refuses to enter it. To improve the behaviour,
let's start to take into account pending IPIs for CPUs in the genpd
governor, hence we fallback to use the shallower per CPU idlestate.

 Re-testing with this change shows a significant improved behaviour.

 - Menu governor:
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             1994           551        10         24         0
S1             115602         801        4          56         0
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=500
524288000 bytes (500.0MB) copied, 3.622631 seconds, 138.0MB/s
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             2462           766        14         202        0
S1             119559         1031       9          253        0

 The dd completed in ~3.6 seconds and rejects increased with 9.

 - Teo governor
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             3212           990        16         245        0
S1             202442         2459       13         1184       0
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=500
524288000 bytes (500.0MB) copied, 3.284563 seconds, 152.2MB/s
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             3387           1046       16         265        0
S1             206074         2826       19         1524       0

 The dd completed in ~3.3 seconds and rejects increased with 6.

Note that, the rejected counters in genpd are also being accumulated in the
rejected counters that are managed by cpuidle, yet on a per CPU idlestates
basis. Comparing these counters before/after this change, through cpuidle's
sysfs interface shows the similar improvements.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/governor.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index 39359811a930..7e81dc383269 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -404,15 +404,21 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 		if ((idle_duration_ns >= (genpd->states[i].residency_ns +
 		    genpd->states[i].power_off_latency_ns)) &&
 		    (global_constraint >= (genpd->states[i].power_on_latency_ns +
-		    genpd->states[i].power_off_latency_ns))) {
-			genpd->state_idx = i;
-			genpd->gd->last_enter = now;
-			genpd->gd->reflect_residency = true;
-			return true;
-		}
+		    genpd->states[i].power_off_latency_ns)))
+			break;
+
 	} while (--i >= 0);
 
-	return false;
+	if (i < 0)
+		return false;
+
+	if (cpus_has_pending_ipi(genpd->cpus))
+		return false;
+
+	genpd->state_idx = i;
+	genpd->gd->last_enter = now;
+	genpd->gd->reflect_residency = true;
+	return true;
 }
 
 struct dev_power_governor pm_domain_cpu_gov = {
-- 
2.43.0


