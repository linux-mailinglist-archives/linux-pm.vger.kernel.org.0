Return-Path: <linux-pm+bounces-36277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B56BE42E8
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 17:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7DD1A60F41
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 15:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4CF34DCCC;
	Thu, 16 Oct 2025 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x1HrFSVh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AAE34AB1B
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627988; cv=none; b=rZWreXyJfQczpgasrwrhZHhLkHHsnP10HZhnD5BbQaZwRsFV+9t+MYMqYC4ZI1zyBR6pWxerdBCzfNppInhj9ymzydEh7DX6A3qvNy1TNNk/ul7aRhi6/4/E46G1n3ylWw14xpfZpesG1K7Pd77GfhdgV0i/wFu61aRaHIzJrNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627988; c=relaxed/simple;
	bh=p1hkManqbLEmcUPdUEpLpgNeA8lMmi5PhV3KbHSxIjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZuB5ZifFT0i4yHfnuoifJcSv7duT1GffpWNncmTyl5drb+pbql0OIahSvX5D77jIV4MKy6ZbhZgcJcmMs3l8Zx+N3IiXE1D+eox+zptOMxeMmAs5aMtUrjdrUelagWQLjeS7/gDoubxS2aLtBTJ0G11gsr1zcHs4kIsJB/t8bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x1HrFSVh; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57b7c83cc78so818075e87.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760627985; x=1761232785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/XQJbOqKvDoDR3qmpupw7hVZDh6O7Rf47/OK/uAp/8=;
        b=x1HrFSVhkga7SKFre3fy1WLK2mdoiHzjXsvSAgRNYBS9b93JyxEtkGDjd8dCFvxO7M
         RdTbJniLjs8ZAMlzXMef09MD6nNS6S99+aEsicx7jIreA3P0PRcIIdbCPriL8MzYwll0
         3gvxJiKtQjXQLAlIb8UA9yR3CX7DnjdGp/RHLDpLJDO34BADOaslzeN95t+WsINZK3k3
         tv6sDDvCD7EBxU8b93WsC5HzmtqLtKWJLkdXhBK97x45lz32QdGnhbTLD/AfARwHvctc
         aW5nClet29GTPyQ2z5hMVKytfJ98MBdL9sGZ3whzbEKOK9EUwihOBc6z1pz0UPeIzim0
         LN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760627985; x=1761232785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/XQJbOqKvDoDR3qmpupw7hVZDh6O7Rf47/OK/uAp/8=;
        b=IGZRh50YPmfQ2lldFAAh5mV8xV5RoMH9V/ZA5jhgy1mDcT55I7wU4AwWT58TCI2ygX
         gkCbuYlYNHbqtRtVFWcfV3SHLstePIXc+wkcVv3U96lrCV6pmIw9xPJia12nXkHeLP1E
         yXzBWIfRDhCH2oVbR4PTkyUk4al6kOtMuUAMGqNoYsLto0no7nRu+ekEBEQiL9EvzK6Y
         d6iC/zL6fYl5k54nPT5b7npabzqxMVjYzMABvRe3vt2glHe+2yHp6wAK2eeeqekylxLr
         XbeIGs7KxgjO6gUU3JMXXLxAcdtXpwSXZgx5EPHuhAtczYQs2cMsXMbZTk55b1lHircn
         P0YA==
X-Forwarded-Encrypted: i=1; AJvYcCXHjIKogm+AfoGINZfHNO8zzuzBH67IThLqG0ag1FTe08cl/WK97kZFaQmmChKpEUz9o2ckWV2ktA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwFkqQUuoOZpHi2hfM5kRh89X1WOHw23bKlgQtKLNCFNcZ3JD5
	/RI/sg1tBYqPeipxIciFIKxYcN2gj2kPrsFzFSO9mG2l6xUboqpxfmGo1toyX8q/MVE=
X-Gm-Gg: ASbGncvUWFsMstHke0v5FaFDIuT28fAcC+AlkhdEXmBm4SsCFNaPHy7idXlg6YPst4e
	4040i+9UJKh2qH4Fs3bnY8tf2DuNSZ0P68Ip4KXUuIo+4VPtbFrI8yAxhpLEr6f1vs0okTnfIxW
	lf46X9cYGStweUKJU72IPvfNtxhfd14YwtSetqFcGjsCCNRopzEQxB58xLtWp4iEg8REqHXzzbu
	zvytcRdOWNks68nLHK1VzGIiuNFKVpHyV9DtBPq62H3IIMoWLSoREIpe2SabkSUnnqZN9uU2g1W
	VH8uG/xy3Lj4+dfoMYZUm436QXaHWlmI9oEM+tdzKRU7ni4paSbtX30hGDO8O7DxyQPy95h5lC8
	R/KJLxUkPBjoE3JKJbyixPJnONBqngACW2MLJwNpfuvlMy3saFhuyhht38Mw1/CEEUCMCFbDzQp
	F9BqHiFHiGLvF8Jr5smyLj4eSyYCQFWoF2272oYgUwG1kdSzX1TQju6LCAzzoH
X-Google-Smtp-Source: AGHT+IF+GI3D/A2Y8t0ukuJaRK98VfRgBctUREszulCJr3ra3+43QykgtfUE5rGgset7s3mjRIh84Q==
X-Received: by 2002:a05:6512:681:b0:57a:9595:5b24 with SMTP id 2adb3069b0e04-591d839512emr217368e87.7.1760627984819;
        Thu, 16 Oct 2025 08:19:44 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908856397csm7150663e87.75.2025.10.16.08.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:19:44 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Dhruva Gole <d-gole@ti.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 4/4] Documentation: power/cpuidle: Document the CPU system-wakeup latency QoS
Date: Thu, 16 Oct 2025 17:19:24 +0200
Message-ID: <20251016151929.75863-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016151929.75863-1-ulf.hansson@linaro.org>
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's document how the new CPU system-wakeup latency QoS can be used from
user space, along with how the corresponding latency constraint gets
respected during s2idle.

Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- New patch.

---
 Documentation/admin-guide/pm/cpuidle.rst | 7 +++++++
 Documentation/power/pm_qos_interface.rst | 9 +++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
index 0c090b076224..3f6f79a9bc8f 100644
--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -580,6 +580,13 @@ the given CPU as the upper limit for the exit latency of the idle states that
 they are allowed to select for that CPU.  They should never select any idle
 states with exit latency beyond that limit.
 
+While the above CPU QoS constraints applies to a running system, user space may
+also request a CPU system-wakeup latency QoS limit, via the `cpu_wakeup_latency`
+file.  This QoS constraint is respected when selecting a suitable idle state
+for the CPUs, while entering the system-wide suspend-to-idle sleep state.
+
+Note that, in regards how to manage the QoS request from user space for the
+`cpu_wakeup_latency` file, it works according to the `cpu_dma_latency` file.
 
 Idle States Control Via Kernel Command Line
 ===========================================
diff --git a/Documentation/power/pm_qos_interface.rst b/Documentation/power/pm_qos_interface.rst
index 5019c79c7710..723f4714691a 100644
--- a/Documentation/power/pm_qos_interface.rst
+++ b/Documentation/power/pm_qos_interface.rst
@@ -55,7 +55,8 @@ int cpu_latency_qos_request_active(handle):
 
 From user space:
 
-The infrastructure exposes one device node, /dev/cpu_dma_latency, for the CPU
+The infrastructure exposes two separate device nodes, /dev/cpu_dma_latency for
+the CPU latency QoS and /dev/cpu_wakeup_latency for the CPU system-wakeup
 latency QoS.
 
 Only processes can register a PM QoS request.  To provide for automatic
@@ -63,15 +64,15 @@ cleanup of a process, the interface requires the process to register its
 parameter requests as follows.
 
 To register the default PM QoS target for the CPU latency QoS, the process must
-open /dev/cpu_dma_latency.
+open /dev/cpu_dma_latency. To register a CPU system-wakeup QoS limit, the
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


