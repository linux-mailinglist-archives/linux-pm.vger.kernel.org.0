Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB84699DA
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 19:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfGOR3z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 13:29:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46936 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731817AbfGOR3z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2019 13:29:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so17113188ljg.13;
        Mon, 15 Jul 2019 10:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2jx9uRBt6JB5ilMndbuQtI4fuwVo1oth3W6XlcI98xo=;
        b=cDT1znoqQWzRJFOuhr0qRvKpnWLvvS4JZtHOJ0pnhS2O4VqXGT2we1djhYEtlUYLtw
         RNpBqAHAKF/FLRHo+2oNA+TrWzuzzqiHAv2XxirbKykExj06nGx0BRhcy4ynrSoI1U2u
         IKj1sdMEyahxMJKA9wlyu7Wgrw2BCgvlivEr3/2iYcqwvapa5ooouf0WwhiOREEA8FIi
         nJBjLtfvmRHnzDAZj8tYyNzHhf34bmGl7mELLt1bgSdx6RsdWfuWoLIm1vJnqiGmhvET
         XDnZQZgcOVaz8Y5GVFFUkQ8vQIa8+9TCgPangt4RfTc6qjf1CO/J6kumoqhMBkVmPqCM
         8cVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2jx9uRBt6JB5ilMndbuQtI4fuwVo1oth3W6XlcI98xo=;
        b=U7QZaUhBlXN/4BPqgsAa1/UFYmKbrD6TP1eWctYb59G6dVl/N88wvj4wdKFsg36eYe
         GANy+LF13pHDqAjPf+CjH4Vh0bn9dDhs8DBaF/Zda/gtCbGLVBTTK8EetkYDUhTHAEK8
         E4+IIbvOrgSHXYBjX5kO3j9rj4Q7kNrs/jYaRtIV071rrMIHxNIXcFE1TpfnBFTajOR/
         ff8v53BorHkB1QoGylm91z809kTmTx5NcRUhmUG4V2QjvGva3JQQVntAT2fEnmv+OO21
         2TfRyncaKhobKFqdNBpK98eYHj1eYCkdZaZEpC1TB7uJ2Tt832mCqcxBKwv8WeQ0Ly05
         fOtg==
X-Gm-Message-State: APjAAAXpaggLKgX2vm/FQ/3w5xdwYw14PSjNk/NXYaV1WsxFXU/q4Tby
        AD5Nums4KszN4/k9P5SRgdA=
X-Google-Smtp-Source: APXvYqze+EZiOztxVZvleQZu2rs5ndgzoFDphhDcPCAcS1ClN92DcBQASC9SZaVqn3r9Bzb3uJXCuA==
X-Received: by 2002:a2e:730d:: with SMTP id o13mr13837571ljc.81.1563211791659;
        Mon, 15 Jul 2019 10:29:51 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id b17sm3248765ljf.34.2019.07.15.10.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 10:29:51 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/13] ARM: tegra: Add tegra_pm_park_secondary_cpu()
Date:   Mon, 15 Jul 2019 20:26:23 +0300
Message-Id: <20190715172629.4437-8-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715172629.4437-1-digetx@gmail.com>
References: <20190715172629.4437-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This function resembles tegra_cpu_die() of the hotplug code, but
this variant is more suitable to be used for CPU PM because it's made
specifically to be used by cpu_suspend(). In short this function puts
secondary CPU offline, it will be used by the new CPUIDLE driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c | 14 ++++++++++++++
 include/soc/tegra/pm.h   |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 4cc64a135a3e..7d9ef26e52a7 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -427,4 +427,18 @@ void __init tegra_init_suspend(void)
 
 	suspend_set_ops(&tegra_suspend_ops);
 }
+
+int tegra_pm_park_secondary_cpu(unsigned long cpu)
+{
+	if (cpu > 0) {
+		tegra_disable_clean_inv_dcache(TEGRA_FLUSH_CACHE_LOUIS);
+
+		if (tegra_get_chip_id() == TEGRA20)
+			tegra20_hotplug_shutdown();
+		else
+			tegra30_hotplug_shutdown();
+	}
+
+	return -EINVAL;
+}
 #endif
diff --git a/include/soc/tegra/pm.h b/include/soc/tegra/pm.h
index 2fbee9efda21..08477d7bfab9 100644
--- a/include/soc/tegra/pm.h
+++ b/include/soc/tegra/pm.h
@@ -27,6 +27,7 @@ int tegra30_pm_secondary_cpu_suspend(unsigned long arg);
 void tegra_pm_clear_cpu_in_lp2(void);
 void tegra_pm_set_cpu_in_lp2(void);
 int tegra_pm_enter_lp2(void);
+int tegra_pm_park_secondary_cpu(unsigned long cpu);
 #else
 static inline enum tegra_suspend_mode
 tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode)
@@ -55,6 +56,11 @@ static inline int tegra_pm_enter_lp2(void)
 {
 	return -ENOTSUPP;
 }
+
+static inline int tegra_pm_park_secondary_cpu(unsigned long cpu)
+{
+	return -ENOTSUPP;
+}
 #endif /* CONFIG_PM_SLEEP */
 
 #endif /* __SOC_TEGRA_PM_H__ */
-- 
2.22.0

