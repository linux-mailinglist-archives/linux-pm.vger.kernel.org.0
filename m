Return-Path: <linux-pm+bounces-38568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 730D5C84BB3
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 122364E8CCB
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 11:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F07131A545;
	Tue, 25 Nov 2025 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFZiCovK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFCC319852
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070032; cv=none; b=qMSKFvgFyyRjbfDFiZCTdEYFc8fFU19WeB7jI9oV8cHHgUsFhLg5J/XxJX3t7y2fJnhIhV0aAvxyZAwTDbufNafeInaZ1/deiMrQrb4yDRWqlxqXb9650k8F/H9F/4Ip19pHpCyrgfIcGSed1Ipt1Z39Mzl72DenkcxjY1ud4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070032; c=relaxed/simple;
	bh=GrznQtm2Xbu5M36KVvznD5+BJEJ9tpaSNo1aXMTzPYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+mRSfF6upho3sA/q0nE0pQ9WPGU+MnygDd2lncQQb7zVmwU4LSgm3l1M31Zn8AbjmhHG2lMVg6gxv9ovGP5UlCtdGfezRLS9WfSNViF8uWqL50QLCShadGoqEhaZ0OfeLBKVLHB30xXvz//KBtT7hEGBk0c7kKJ6RgjhiPoNHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RFZiCovK; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5957753e0efso5620523e87.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 03:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764070028; x=1764674828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Pe+KUJG6BVKcUJHZJ0mcY6KZ0UWQ2fQ+ADIwlAh+rE=;
        b=RFZiCovK5pZCDLgtV5QtOrfFpjLVd8m/yQdP5hqZEDtjQDIT8VOPvcJgyjPheLdQdP
         NtfAgQ8uKqnAcTExhIkNI7A8A4tqY6aeJ3sEFmFqy0MQa45qsTZ8J9fL8k40Als4IKw0
         SavHk7L6wCpeODkKCF9mr/jypqesz7Owb/bxip+dUIEisi1Lvgd7/xz+ZOopz1859LWJ
         vbQhLAw3oxFvn88FIqgyI587buaicfWhLFAq8O4Te57HGtVxnoxvnGkS3rUGwwmLkKy6
         2/7WdmtlzvClsCJWL68WO7j4p8mmXZgtQ6dESnPju8+XN/CoaWYrYaGfcVX/ie77BJsW
         5tMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764070028; x=1764674828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Pe+KUJG6BVKcUJHZJ0mcY6KZ0UWQ2fQ+ADIwlAh+rE=;
        b=siqNMdqeuBmGknPKAuwLtTPOBNaqcz9iwJGaYCCh4DjeiCFIwrMqOG01Y9KpUlqcg+
         qP8NWBCHhWQJgWlpLCOjHXbOsWUH9KPZ5fDJRD+E22tbD2S4j89+bNplExQVuwpge+vz
         /5ioTVfNqLlZgLTqHx7EKRylNe+JVkev9Jpa2+zsFQE05830tYkpGT8MaSp300VMgU49
         TRM4AqljFI0J00rAr+OsBmTZG1jZfkfT6izgGXvERVHwt+xeGWXIEP8cFrdN8Ggo97S1
         PmxaJgZid9B5L8/qgofjREv24YPf5JQScRnjy/6jIW1LceTRkgdNtloRpUV5JjQr3LBR
         rKZw==
X-Forwarded-Encrypted: i=1; AJvYcCVB8zSUG92v5GxwW54usdHRH5AcLXfKNCG7f5UCC4LFM7EZPd33l9FCGexz3guNaBdnE/rvI7ZEOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaY+jKj6RqnAZ58X+8an0FKTRif19Mw9ism3aXPhbiz/L0SUwS
	kVFjkRMYqaf02G/WCLuqum41gSMRW3IXyGqCxfuIP8tF0w+y13zGc/SRmMBp6CE89K4=
X-Gm-Gg: ASbGncv6vUegBc94Qm0qbcg7XiZU/bAIX3y+Gs1pphS9L/Ml0qs2nj8XEWJwvwkToRJ
	R14eHeV0HGOLZeDCNHYZh37aXUbPPWuVYl42nitsoZMN1l4PpyCnScxaFhCn/RwLPKz+vlS/I4E
	Yd2a5UtDeEjPx8p59snD87hixjlD79NKOgccmXpJMFYlSkXyK/219LlQTNQajvBLFAMnJHXGb+u
	YWCl5xPpA+wmNkS6I4oOPrkOA5N9vkbzYjKPpbbkoUD4YzYZNwriUOI0d3srb0m81h9v1tjz+8E
	ZJcihwXkFKOyvEVwoN39uFZjiJ20jbSoG4sH1MusVDHmdPe2avxkBMxxLG9te4SJBT3k+RYbKGh
	Rsr3qrfxYsVsPVDen7Vy+Eg+kZznQWvoeWh0wOHLuIcU0y7s+gVlTt3HIPntecQHZIQD21CPTA6
	lzMLjlCzX5LpBKQuXm3xVMyJZt+Hh2q80n2JC+9Zf7FLYXzPh7AhUPtnPpMh2f
X-Google-Smtp-Source: AGHT+IGRDjKSLOucrdLNEeV+cZDbVrqAyKHDt7qFDXqWVrlCSGciMoBT3mitw8rmyaHgPr8TokqaVA==
X-Received: by 2002:a05:6512:2313:b0:595:9d7d:6ebb with SMTP id 2adb3069b0e04-596a3ebe00fmr4819702e87.15.1764070028280;
        Tue, 25 Nov 2025 03:27:08 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969db7563fsm4993526e87.2.2025.11.25.03.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 03:27:06 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 6/6] Documentation: power/cpuidle: Document the CPU system wakeup latency QoS
Date: Tue, 25 Nov 2025 12:26:47 +0100
Message-ID: <20251125112650.329269-7-ulf.hansson@linaro.org>
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

Let's document how the new CPU system wakeup latency QoS limit can be used
from user space, along with how the constraint is taken into account for
s2idle and cpuidle.

Cc: Jonathan Corbet <corbet@lwn.net>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Kevin Hilman (TI) <khilman@baylibre.com>
Tested-by: Kevin Hilman (TI) <khilman@baylibre.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- Fixed grammar (Dhruva).
	- Added tags.

Changes in v3:
	- Improved documentation.
	- Updated commit message.

Changes in v2:
	- New patch.

---
 Documentation/admin-guide/pm/cpuidle.rst | 9 +++++++++
 Documentation/power/pm_qos_interface.rst | 9 +++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
index 0c090b076224..be4c1120e3f0 100644
--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -580,6 +580,15 @@ the given CPU as the upper limit for the exit latency of the idle states that
 they are allowed to select for that CPU.  They should never select any idle
 states with exit latency beyond that limit.
 
+While the above CPU QoS constraints apply to CPU idle time management, user
+space may also request a CPU system wakeup latency QoS limit, via the
+`cpu_wakeup_latency` file.  This QoS constraint is respected when selecting a
+suitable idle state for the CPUs, while entering the system-wide suspend-to-idle
+sleep state, but also to the regular CPU idle time management.
+
+Note that, the management of the `cpu_wakeup_latency` file works according to
+the 'cpu_dma_latency' file from user space point of view.  Moreover, the unit
+is also microseconds.
 
 Idle States Control Via Kernel Command Line
 ===========================================
diff --git a/Documentation/power/pm_qos_interface.rst b/Documentation/power/pm_qos_interface.rst
index 5019c79c7710..4c008e2202f0 100644
--- a/Documentation/power/pm_qos_interface.rst
+++ b/Documentation/power/pm_qos_interface.rst
@@ -55,7 +55,8 @@ int cpu_latency_qos_request_active(handle):
 
 From user space:
 
-The infrastructure exposes one device node, /dev/cpu_dma_latency, for the CPU
+The infrastructure exposes two separate device nodes, /dev/cpu_dma_latency for
+the CPU latency QoS and /dev/cpu_wakeup_latency for the CPU system wakeup
 latency QoS.
 
 Only processes can register a PM QoS request.  To provide for automatic
@@ -63,15 +64,15 @@ cleanup of a process, the interface requires the process to register its
 parameter requests as follows.
 
 To register the default PM QoS target for the CPU latency QoS, the process must
-open /dev/cpu_dma_latency.
+open /dev/cpu_dma_latency.  To register a CPU system wakeup QoS limit, the
+process must open /dev/cpu_wakeup_latency.
 
 As long as the device node is held open that process has a registered
 request on the parameter.
 
 To change the requested target value, the process needs to write an s32 value to
 the open device node.  Alternatively, it can write a hex string for the value
-using the 10 char long format e.g. "0x12345678".  This translates to a
-cpu_latency_qos_update_request() call.
+using the 10 char long format e.g. "0x12345678".
 
 To remove the user mode request for a target value simply close the device
 node.
-- 
2.43.0


