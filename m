Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D6FD7CC2
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 19:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388625AbfJORCb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 13:02:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39263 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388490AbfJORBv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 13:01:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id 195so2117202lfj.6;
        Tue, 15 Oct 2019 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dz3WKDPiIUb4/FxW8Zr/Vd4hYvS9IVQYUuzS70hcV3w=;
        b=rPkfL2mrjxvsc/Uy5m5Kqpy4xiGpkxUs4EGn42b5nPxzpFWMiWSFgoanng8FB26YV1
         f8XHzpG0RTmQkSAytxOh8WWkt37AQSh9Ko19Qo63mwL7n3NNzlMYYBmdBpRJxabiuf4Q
         BvyDWl8Ktn0btvDAkwgR5IPcbtgdrqTMFQXbwk56mIpiH7aBEqLMBKF0lKiUY5BvsPvv
         6w2z9p4FTogPesAocXCtVWajBVbk1GLpZbKqsr9L4JKFxafllKywFFNBayhs2VNdbrIt
         IFVQq4wSFroJlY/N16gBS2/TE4J6yic+eCZwpdmoqmkHyNlFMX5nggYfT9UnAUsv3a+s
         0gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dz3WKDPiIUb4/FxW8Zr/Vd4hYvS9IVQYUuzS70hcV3w=;
        b=Ry5GXbFZ1BYbZrophbUOqJ2fOEt6heT3yAwrrJivPAag2OLECsRaNrK4oR34x3hdYh
         QCfJ2P7bPdNcgn2MBYZXOIuLaqjtPii35ZEffpQ829dxF7CFApXkKtwjzi7l7oHK1HNs
         MpzFAm+B/lk6ymzpXTYMW2ZSISH7OngdgLZXFIjcOqFZfFipgrOLL1YLxv7kQQQjE0M0
         oKm201VsXKIDzSQVixTKEIx6IBbwwTmC0mq5FtnHNPPldMeR65wfvV/VZ7Ne5ALV67Dt
         8Ww4VHW15H/zbff6icuUTTX0MbAUkaxU97mdF83YWVvzxgFw+pB+D6w3itV7HiSz9L4u
         1lag==
X-Gm-Message-State: APjAAAUlIheiyKwkHRimw9SySfgE+AU/nDusO0YaL9e3JtHHuTvH2TNo
        QztRXw8OF+8HNSNoaRLcEBQ=
X-Google-Smtp-Source: APXvYqwD/ObSmMTlkh6dGt9Nz+GxrpgcUOSoy/Xk2r6mRJURV62hkWRaiezWN6MOqvhReDQWNIIQUw==
X-Received: by 2002:a19:f712:: with SMTP id z18mr19746654lfe.166.1571158909238;
        Tue, 15 Oct 2019 10:01:49 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t6sm5144992ljd.102.2019.10.15.10.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:01:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/18] arm: tegra20: cpuidle: Handle case where secondary CPU hangs on entering LP2
Date:   Tue, 15 Oct 2019 20:00:07 +0300
Message-Id: <20191015170015.1135-11-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015170015.1135-1-digetx@gmail.com>
References: <20191015170015.1135-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It is possible that something may go wrong with the secondary CPU, in that
case it is much nicer to get a dump of the flow-controller state before
hanging machine.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c | 46 +++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 77702dd42479..bc5873e92af5 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -83,14 +83,56 @@ static inline void tegra20_wake_cpu1_from_reset(void)
 }
 #endif
 
+static void tegra20_report_cpus_state(void)
+{
+	unsigned int cpu, lcpu;
+
+	pr_err("secondary CPU taking too long to park\n");
+
+	for_each_cpu(lcpu, cpu_possible_mask) {
+		cpu = cpu_logical_map(lcpu);
+
+		pr_err("cpu%u: online=%d flowctrl_csr=0x%08x\n",
+		       cpu, cpu_online(lcpu), flowctrl_read_cpu_csr(cpu));
+	}
+}
+
+static int tegra20_wait_for_secondary_cpu_parking(void)
+{
+	unsigned int retries = 3;
+
+	while (retries--) {
+		ktime_t timeout = ktime_add_ms(ktime_get(), 500);
+
+		/*
+		 * The primary CPU0 core shall wait for the secondaries
+		 * shutdown in order to power-off CPU's cluster safely.
+		 * The timeout value depends on the current CPU frequency,
+		 * it takes about 40-150us  in average and over 1000us in
+		 * a worst case scenario.
+		 */
+		do {
+			if (tegra_cpu_rail_off_ready())
+				return 0;
+
+		} while (ktime_before(ktime_get(), timeout));
+
+		tegra20_report_cpus_state();
+	}
+
+	pr_err("timed out waiting secondaries to park\n");
+
+	return -ETIMEDOUT;
+}
+
 static bool tegra20_cpu_cluster_power_down(struct cpuidle_device *dev,
 					   struct cpuidle_driver *drv,
 					   int index)
 {
 	bool ret;
 
-	while (!tegra_cpu_rail_off_ready())
-		cpu_relax();
+	if (tegra20_wait_for_secondary_cpu_parking())
+		return false;
 
 	ret = !tegra_pm_enter_lp2();
 
-- 
2.23.0

