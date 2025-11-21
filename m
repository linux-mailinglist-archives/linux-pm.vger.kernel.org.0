Return-Path: <linux-pm+bounces-38349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B82BC785A0
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 11:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1543F2CE8B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 10:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF2F346A0C;
	Fri, 21 Nov 2025 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hEjr5oQl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214DE345CD3
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719431; cv=none; b=sqJ0BeRUJXunENMmGbkzElDwMmapeAZ6ISox6HZN7nJ9/hLHUFn9FRf0GzFOS24Y8MXREpT+jLuKtAWQvTuEDOQ+HrI1lnd3LUjNcibtzCf+DbV6RfGUvRkEpz9XpzQTs6jCZ2slw4+9MzJdQ1meaMrx4ChSE+rnAMMu4of2/WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719431; c=relaxed/simple;
	bh=x+e7y/pvYnxiFBlQnOJXkaitWecU5Du5bsfUUw5U7PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSdzdMvmtwXFM7VO6BeDB1LKJbjv1TD07TdLFYQguf6q8gegm7M07kfAJaY3IGDSp33tgJHS5riHc1pPoSRIIObfr740PoGSxElfEv2XUEGSGLsujsmZ/6vzgCGxDeJn0WNNIGG+KNWr4H2YvkKedukyV1OUEYZwzuya03rBR74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hEjr5oQl; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37b983fbd45so14596291fa.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 02:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763719425; x=1764324225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pC4XiP3l8Ew8D/XkZDyv3rIKzQexxvvUyzQqhlG1XiY=;
        b=hEjr5oQl8g8sTWpX9WKE6QYoy6k0kzBgMKIZQh6oH9vnzf6vSg8vxLXDYBcjHiWsjc
         os55PYPbJ8QlAnAfzbQBCovLmhWUKSzkO/Z53cRyRWH2WVMYG9p2rstzq1Qz3aZSCzGz
         6cQbqAyP/x8e97FQUDVsccBeZKTbmDzf/V57j7K6/wbQDqAi/tLuCN6fGtwbcCVJrCCy
         avG7x8GR8/eUV5L5VKZwToG9hBEWCYmh5wQFtGvlxwSHvGkMGcMKWH5Hl1Lt67mP6MZP
         6vj1AzfmiHon1qEbzBycuQvx9IqmvBEdzqcQ6IGART+BYYnjj5l3B8qghxLf4O61l6K9
         6EUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763719425; x=1764324225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pC4XiP3l8Ew8D/XkZDyv3rIKzQexxvvUyzQqhlG1XiY=;
        b=p9WRQOk99nlIoaza4EngezCgnfU5qGL0MQpkdV5wP7IWxNFsmOmWdUkvfPXX8fNI13
         VtLzbY+wF9dPrTj0uOob2SUg6CKQ31WB2uckT7gCQWExdwI2xGEmHednskjNtzQqdzom
         7m6qYKjXi6htqpHaevifshuGr5ni8MWKcidERbwaXH7Q5j0autV8FNN/oEqZSAsjDp4M
         gp+Si1iPMgdyLKbJ/P+tmJzZcx6fxbE6udlxD7kjixRyD3FMczbTA1s0Bm+6mrVLGPOE
         hTo50gtd8napU5PI6bRO0VL5K6tb72HHooWPX+r0Rwsg84IOK+VIqG0RNneySK9aLvfJ
         f0ew==
X-Forwarded-Encrypted: i=1; AJvYcCXHxwB/AT0l8Bb8QnrLADf8CgElfV6t5+GYzMbnZ83vDYwYq5UUeMPC6PlSDoNjT5K0BvkGb/PFBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJtiqeorF8seMs1yex7mjd8zfmXhVgG6beZ9qiRajQyzKHTfbZ
	UpcH5w7lN35PwUHCNELVJI+KXSi/BECiy5XtNmgl/tAI02KWLYrm2q615KbhfgLpQZo=
X-Gm-Gg: ASbGncs6kc5+sS8wc8kJSn8bEGXr04JAVZp6ye9nKMXMbd/TfF1UksLPhGqRUUD4c1C
	aRJiP17bOG1pE4FAFbUFDSjy3GwRGXDAVAlQN/O5V4V8X36ilPsPRUexwWC/IXMuXPd/7+PoT67
	YLsvB1Ct2CeFK8Z7F38seVy+KUMuc3u9f6YAJlDyL+XLxN2b5T+AIBzL7yKCPd+0NUx8JWR71rH
	cFHdNqoHMxSTROmSMDq13wzv8Go0Azcc85J4RwiPl/Ub6wjmWF+QOqDCpqFN9Epn5o9gowuH0tW
	09WQZAx0pCd8pM/Wia5B4XoUMo7YVz9qn6fNO3FznTRg9V16uDOS6uygxn25jC+XJJ+yTx7/OG3
	T3f6OloO7H8zJRLoR9bpw6UqC7Lzr15ZxGP/FRPxVj5IGt44+FrFujz/lJXTKedp/QWHDPxawbv
	6s6HviL7kwjKlpMY0xf3TRnxh/vvh0nOw0NEptRv8edrUg7aA/eFe97noMgKy2
X-Google-Smtp-Source: AGHT+IE1QBDl25thXOykf99W0hmO2fID/AbQq/E1G/iDg+8zCCoVv/kRzbF75XHT2jFRieRUjU039g==
X-Received: by 2002:a05:651c:4207:b0:37a:846c:3484 with SMTP id 38308e7fff4ca-37cd9164042mr3913491fa.4.1763719425337;
        Fri, 21 Nov 2025 02:03:45 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37cc6b597b2sm11056181fa.12.2025.11.21.02.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 02:03:44 -0800 (PST)
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
Subject: [PATCH v3 6/6] Documentation: power/cpuidle: Document the CPU system wakeup latency QoS
Date: Fri, 21 Nov 2025 11:03:12 +0100
Message-ID: <20251121100315.316300-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121100315.316300-1-ulf.hansson@linaro.org>
References: <20251121100315.316300-1-ulf.hansson@linaro.org>
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
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

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
index 0c090b076224..c39ad6ab99d9 100644
--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -580,6 +580,15 @@ the given CPU as the upper limit for the exit latency of the idle states that
 they are allowed to select for that CPU.  They should never select any idle
 states with exit latency beyond that limit.
 
+While the above CPU QoS constraints applies to CPU idle time management, user
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


