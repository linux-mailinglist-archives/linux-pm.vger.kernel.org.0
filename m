Return-Path: <linux-pm+bounces-37441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA286C34FB5
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 10:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD63E466DB0
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 09:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D22930C350;
	Wed,  5 Nov 2025 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IAIq58x/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290B8309EE8
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336464; cv=none; b=S+f2TK5H5FvPKfKwzygkFNfEqGhw7vQ6pZqR3m1T+qU5gszDxvKQbOzI4Zd03+Xk5JMdk4OxnaQ12NN9wEl6V8ajYGfdN6oTbRZmFuqfT4FtJKXG1OFpYB9DE7gtGPa6JhPrte9DbTm1KZzBtPwz2HqTi5OPSRLfVzfX7qXpOdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336464; c=relaxed/simple;
	bh=yhN+fmTKSMV1wig4sJn0im3lxImBaULqtYspQSfhWcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsuuC6mGxAy4iBfWUFYtDBg7Ekqw5e1O/L2N44RyPwTpXhJz03RuIthBkS7yztKBqS72OgoIE+mRq/M61k5pedc62891PpQiP7XDlG+uqlGwLOpoiUL4+o/YzaRQLVeSsZ/Bg8LbZKiiIf5z1C2ltlIwK9WeHR94Wf9n2betvJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IAIq58x/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso1027044066b.3
        for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2025 01:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762336460; x=1762941260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBOXj6ZoRN4JEjEYRQfoLq6weWa6pU54gR5QKGP+lBY=;
        b=IAIq58x/tJgjdeEdra4ox1U8R9d6GMmayhkJjG+AaKq8TP+ednhmXvJU1Ptwguk74w
         W7PGueh61xpfZTtMG+uynTfrMj0hab1lDo18i7PVk2r2U3uKMLuG8LTkaFh5IKrhkIS0
         4deN96AmOrSJVT/00Q7bQEFcbbANoF1YQe4SRs4E/oRo2bbkJ2E50+8UQV1FFQOH0GWx
         JX1EEsoKn9N3W5S4h0n8RZlT1aLuEQPAwGKi0PDTMU84Kh3PTY6T5ECBz552Y4WpbzqW
         skAqO+07CMc9hIUgozq/qHfQZ1DehAPoUQ5euKjc0Ny3XV8FuZp9zFjz/tXuPeT5JSKY
         fGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762336460; x=1762941260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBOXj6ZoRN4JEjEYRQfoLq6weWa6pU54gR5QKGP+lBY=;
        b=NIwI8tMZPOElbkynCIm1876VpCozr/cIXNs75aATYrTzIBjvetbfNX2hx2RdHo2DMQ
         bpDx68uMin+7sgRKsftCBKqXXyJBG2nHlxhptSeLlL5nFMl4hUMonAtsIqkkOOhV99jN
         fowzQNpaQV2iEsIBftDDpbHENYwbAy3RxxqKVXkTAURg5JrEVCmJc035F/bPt88G3zxp
         ULVjzpBh1Og1CMWxUTlKQdBIIpPUVpxvXn3kBr95LKiqonvR9CjBOLaTMAIGWuP9edsy
         t73JPgkzVfoCex3wusyZ1/jUt7KwVICZjOipFETTBmqlm7Fs75Nz4z9eqAEUSPQzlu7V
         F0dQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4DzNWVlYxQiGzrgX2eKHN6SJ4rBb1P1KtmYTNTVGETOhaYeQZ4j+aGLI7664J6c88jOA3OGxiMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMxHpkZ2Jt3FegPWynA9Sz4m2qE7gmOdRhnxd8yUl5A51brrvu
	rl1kymPnV8F+VXyZlcEnHddJYgcmFT0YoY0XVhhDw48pOiqCTmU0/5cd2RuLehw3eS0=
X-Gm-Gg: ASbGncsvp4nnMPvv7PR8E6bFaBXQU/Lu+5mBT5OJMwBk4s/oeIocOZLrn3v9QdthyQJ
	ShewdBi6RkPEju83M7UBx0IsA2/ktxTKdIeJopH/V3Owbd6kdlC/14OMR7BO3/5BEbBeczMdO4l
	svV1Lv8igweQD1+Edp7l279vkIjCB537Ahb4OiM785PqOUT9U3m0zPUoHxa5U1pMwTsdxrBNm6J
	hhU4WvLu5px2MUWpkVsorRbnqbVLArsvjXwrkB9XzCZ2jYiooH6oT81R9LtkuHVggm0pdnREd87
	FHVqIB91GJJjP0r15Z6pYVanxuVkk/x/ZBdRx8myCyYqQWTCV9pxjenbXpxU5t9TjW0dIJzD/DX
	10S7GRvwDn2/KpX7UUEkN3846wyo4Y/h/2MTS9FYz07nKWh9brqZ5oLv59s5a4J77F2Tkd54bCT
	nRAMtWbN/sbfwzVGN00QPOogUsWn5y
X-Google-Smtp-Source: AGHT+IHp4c9KbYsoS0hxUKU9/CE02Blmb8ma0MooZ5efB9d/kZmNsLVjvvcNZeCgcm6J7Atz+j6iyg==
X-Received: by 2002:a17:906:794c:b0:aff:c306:de51 with SMTP id a640c23a62f3a-b72651558famr253914266b.4.1762336460211;
        Wed, 05 Nov 2025 01:54:20 -0800 (PST)
Received: from uffe-tuxpro14.. ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fe37cb9sm442571066b.61.2025.11.05.01.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:54:19 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ben Horgan <ben.horgan@arm.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v4 2/2] pmdomain: Extend the genpd governor for CPUs to account for IPIs
Date: Wed,  5 Nov 2025 10:54:08 +0100
Message-ID: <20251105095415.17269-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105095415.17269-1-ulf.hansson@linaro.org>
References: <20251105095415.17269-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the genpd governor for CPUs, tries to select the most optimal idle
state for a group of CPUs managed in a PM domain, it fails far too often.

On a Dragonboard 410c, which is an arm64 based platform with 4 CPUs in one
cluster that is using PSCI OS-initiated mode, we can observe that we often
fail when trying to enter the selected idle state. This is certainly a
suboptimal behaviour that leads to many unnecessary requests being sent to
the PSCI FW.

A simple dd operation that reads from the eMMC, to generate some IRQs and
I/O handling helps us to understand the problem, while also monitoring the
rejected counters in debugfs for the corresponding idle states of the genpd
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
that is affected by the idle state that the genpd governor selected. This
leads to that the PSCI FW refuses to enter it. To improve the behaviour,
let's start to take into account pending IPIs for CPUs in the genpd
governor, hence we fallback to use the shallower per CPU idle state.

 Re-testing with this change shows a significant improved behaviour.

 - Menu governor:
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             2556           878        19         368        1
S1             69974          596        10         152        0
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=500
524288000 bytes (500.0MB) copied, 3.522010 seconds, 142.0MB/s
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             3360           1320       28         819        1
S1             70168          710        11         267        0

 The dd completed in ~3.5 seconds and rejects increased with 10.

 - Teo governor
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             5145           1861       39         938        1
S1             188887         3117       51         1975       0
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=500
524288000 bytes (500.0MB) copied, 3.653100 seconds, 136.9MB/s
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             5260           1923       42         1002       1
S1             190849         4033       52         2892       0

 The dd completed in ~3.7 seconds and rejects increased with 4.

Note that, the rejected counters in genpd are also being accumulated in the
rejected counters that are managed by cpuidle, yet on a per CPU idle states
basis. Comparing these counters before/after this change, through cpuidle's
sysfs interface shows the similar improvements.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- None.

Changes in v3:
	- Use the new name of the helper function.
	- Minor updates to the commit message.

Changes in v2:
	- Use the new name of the helper function.
	- Re-test and update the statistics in the commit message.

---
 drivers/pmdomain/governor.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index 39359811a930..a46470f2261a 100644
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
+	if (cpus_peek_for_pending_ipi(genpd->cpus))
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


