Return-Path: <linux-pm+bounces-35690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B358BB7465
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 17:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E6E74ECFBE
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD65C28031D;
	Fri,  3 Oct 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wj6siZ0C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23721F1302
	for <linux-pm@vger.kernel.org>; Fri,  3 Oct 2025 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503793; cv=none; b=eiesoTrq/xvm1cLuP6TeOGFmw5GWi7OK7Z9jvqAicSkU9s7TOu1vWNOd6dnf0jZ77kOBEplzWm1Tr42nhT6FQfFgR4uZPTxek9JvciFbiRVkiFAwXF3z5X5Es4QKR54C7EgVRKg4QDIIgCWCArJkefLOolmFAQ3V6gB5oBywOC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503793; c=relaxed/simple;
	bh=XK4CQ3RlnbdYdO+YvNeTusWRbzxZGhvL/oHJx9n5/uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3YL8941cG0+gUM5R0DrpfFsJ0z5MRsC0fUhZnvyh/bau3n+GdCDkFPtCdwmXqEkniv0qTR+TkVhITvTsV9DzOd53cLIoz/+bTjRNa5FgWlXuj+WEJgQoOut0tjAJ0F4hByGW7yU63+2Z21xoXo/+F8MgBQAjelO0pPJ377Wp0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wj6siZ0C; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-579d7104c37so3356192e87.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Oct 2025 08:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759503790; x=1760108590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hihU1RjeShMW+xMGPqIOaGj65BRsX1zPODZiqAoHCE=;
        b=wj6siZ0CQAD2w5j80Q9f69/jhIatYT3zMxq6MTxb9BX0OTUQ4rUf6sgp18TcX5TfDg
         /wjzo651mM8z0VyVD3bDvHunTjodm3dCUjBLi6EwqbJ6aZob5UpvLd72iw73j36mTQJU
         EdH9Hk2Z8OqeRZZz4+aJwIaZpJH7iwJoXlKWcjRKdWfGOoRp/p2G+hYJsdM2g2rqIluJ
         5wG+9pjAObsUrWM1L4DPkX04lPh3j1eBmrau5GROuSGu3RRzaoEM0vf0c/LSlWyYPmOE
         9KF3hG5E/cnxuNGx/8C90jMuxK4YD65Cupx/nmTHEI+a6npzYvWRZrtxMZMaYX0AbXwP
         fKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759503790; x=1760108590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hihU1RjeShMW+xMGPqIOaGj65BRsX1zPODZiqAoHCE=;
        b=H7NVuj9Eclo0S+ZTIJX0sN15ruBuYUDXu1Se9B2FMwb+kQrzLQoCC9/j7KhMhllWLX
         S2ft2t6USAMKWA5oagDfow+qQFJdDy3Pv6o+v39hj8++6LQRpqKW4XJ3V9YjfEbxSDom
         P6fahgHjVHT/0VujOq2xtzEyMSJlgynRNT9yVUuQbi/59JnSXiUVwQHrGN/NfIC/P447
         iIhP4WPJzhtuPrleq/Uu3qnIEUAoEWq5zAG6tT75ZYv8VwYDBVbKQFb5S5My6OdS+rsc
         5Zsc7+yav9LEVgaIWP/sD2rxsi01oYRQ9LcBhY1Dphg/phpxMhZeQZY+/Kma1L79ICU2
         F9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCX67qofyNh1QyzF+zJ4SJfB97EUw6sbpi8Qn+tMyF3awYqEHjYSrqabwEiGaEaCoC8zb43qNrXRSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YztBzVDYgVPpOvmj3lFlmG6e2oQ19zeuX6i/OW8Dldrtpmq0QNN
	5wmHRDexLtORiPUNo38YYaX5VSXZjEPcsBb0ys4hJPQ4P13h5x+40CPO4kcfaKK445efW9tlF3s
	66Pe8
X-Gm-Gg: ASbGncvGf31x37tcULbiKHCbjAXqhqLeURh1iRnnKcnrcOvTHP0yi5FKqqnmrYRxLiq
	XnzmIAq6+XmhnytOKHcxAcNxfjLhjQvomXvC0Fk63IU842Dw/+zu2h/wFISF9VQewaLsNO9uuQ0
	H1V8ucwNXi21BmVsGpHPjaBg2WnX7obxEYRX8cQvfounZ6xJwaHKyaUIUbSME3sUPR1oqxRrQH9
	XLPHZQfWdZj9j71cXKoi7z6GVEWpdP+wkg45hLQwLMEvPA9ogvB93eepChUaxN4a8J/YgZQKRNe
	c5iDfOpACdbEi+OfF5BGH9Ywy1xIkpTmYivs664Ui5vwGf8Fg6fW123Atx/NT77XpQJmeL9VDZ4
	gn+pNCOl4Sv90pvaWBLs7Z2ovEXvEEXxOhu1mI3cqsCFEWW4bUVKARa5XfUxdh9Gb1uMbDM25S4
	sSFudxu/b6Jh3WyeMe4y7230dt
X-Google-Smtp-Source: AGHT+IHu4PqHQYTqpy6vc1bGma7aV+0D6GP0m2nkuDc3p3Rnn6+vAHAZZGlxtp7LPL+ZjpY/yp6VSw==
X-Received: by 2002:a05:6512:b23:b0:57f:492:3263 with SMTP id 2adb3069b0e04-58cb9f0b45dmr790708e87.1.1759503789674;
        Fri, 03 Oct 2025 08:03:09 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011343b6sm1933369e87.35.2025.10.03.08.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:03:09 -0700 (PDT)
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
Subject: [PATCH 1/3] smp: Introduce a weak helper function to check for pending IPIs
Date: Fri,  3 Oct 2025 17:02:43 +0200
Message-ID: <20251003150251.520624-2-ulf.hansson@linaro.org>
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

When governors used during cpuidle, tries to find the most optimal
idlestate for a CPU or a group of CPUs, they are known to quite often fail.
One reason for this, is that we are not taking into account whether there
has been an IPI scheduled for any of the CPUs that are affected by the
selected idlestate.

To enable pending IPIs to be taken into account for cpuidle decisions,
let's introduce a new helper function, cpus_has_pending_ipi(). Moreover,
let's use the __weak attribute for the default implementation, to allow
this to be implemented on a per architecture basis.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/smp.h |  5 +++++
 kernel/smp.c        | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 18e9c918325e..476186e5e69c 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -168,6 +168,7 @@ int smp_call_function_any(const struct cpumask *mask,
 
 void kick_all_cpus_sync(void);
 void wake_up_all_idle_cpus(void);
+bool cpus_has_pending_ipi(const struct cpumask *mask);
 
 /*
  * Generic and arch helpers
@@ -216,6 +217,10 @@ smp_call_function_any(const struct cpumask *mask, smp_call_func_t func,
 
 static inline void kick_all_cpus_sync(void) {  }
 static inline void wake_up_all_idle_cpus(void) {  }
+static inline bool cpus_has_pending_ipi(const struct cpumask *mask)
+{
+	return false;
+}
 
 #define setup_max_cpus 0
 
diff --git a/kernel/smp.c b/kernel/smp.c
index 56f83aa58ec8..ec524db501b5 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1088,6 +1088,24 @@ void wake_up_all_idle_cpus(void)
 }
 EXPORT_SYMBOL_GPL(wake_up_all_idle_cpus);
 
+/**
+ * cpus_has_pending_ipi - Check for pending IPIs for CPUs
+ * @mask: The CPU mask for the CPUs to check.
+ *
+ * This function may be overriden by an arch specific implementation, which
+ * should walk through the CPU-mask and check if there are any pending IPIs
+ * being scheduled for any of the CPUs in the CPU-mask.
+ *
+ * Note, the default implementation below doesn't have the capability to check
+ * for IPIs, hence it must return false.
+ *
+ * Returns true if there is a pending IPI scheduled.
+ */
+bool __weak cpus_has_pending_ipi(const struct cpumask *mask)
+{
+	return false;
+}
+
 /**
  * struct smp_call_on_cpu_struct - Call a function on a specific CPU
  * @work: &work_struct
-- 
2.43.0


