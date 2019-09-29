Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8F7C18C9
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2019 20:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfI2SAR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Sep 2019 14:00:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40781 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbfI2SAQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Sep 2019 14:00:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id 7so7090358ljw.7;
        Sun, 29 Sep 2019 11:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F2AFnW6x9cvzEQjUo4TRWgA3pCtU6jhhJW0iMa2pkd8=;
        b=jw4ypUVScE3kXmPntcTE9gv9ox9KDTeOYPvlrwfLUei99640ydywX3WkzuJIDVad0E
         4twMsLXU3XmX20Gar9lBjRwgtKUofMWslNbUl8LW8gno6q24YJ0veiMT8Urme2Jivv5J
         J/6CIR2Ro1UDM0RTBH/jWUD/enZcfunV9YrBEZIoSsFLEt17tIAM5/zQS+OlW+AWT2jk
         bfONU2BrOMiLByIxMxMMGNXXXBaLlFHrhiyN0Y74U9/loeoNDlxDISij4+02dQ141psY
         wGIethPvpQ5dH3XVQkuNBkSeQu8p8oSwwuGjo1OWHBor89dHTl9E6hZo97SLZb2YAvUz
         hchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F2AFnW6x9cvzEQjUo4TRWgA3pCtU6jhhJW0iMa2pkd8=;
        b=rk9ypPKzk6bT6v6PnmVle2QQGvS3nHzasBjRk6Y/ZFe7+GyUGcs7LrutAg3R7jkrvE
         8XGET/cvyiiPMXP6G07iy5SZi7VLCKzIT+zv/0qjNQUTUibNQxcYl1pf9KDvKDUU00dC
         nL9dvDWOZqW/rFW4+AcQL+gXAL41tneRWJAX3YxWVpZ5vWW8Y1MeJy7Q+HS/5strcxLm
         F0iitCNXuq+zimdwZWCaOQWxel4xbvFj9WKo8qnf1feBsR8fSd6BXghxO8TeBnYETn/C
         ySfAseMlf/AZq0oF+CmxdEqsb0rnl0aIua9D1tPXllR4g4Np7shGmZsWpXRHdXiM55Tv
         BG/A==
X-Gm-Message-State: APjAAAUt4P8J7UkPD5CftV8WmL2N9mEPNPvE6OdT8loTADkB8P6ZaIDt
        /U2tqbtGEyT1D4FIYa9AL3A=
X-Google-Smtp-Source: APXvYqxiiwmto4ex4UXmmELa/rRpDKSHPI0vvHLrYdvFh94tbKLrXM9QYLMJd20/UbaO2NBLd6G4cg==
X-Received: by 2002:a2e:7e05:: with SMTP id z5mr9550097ljc.8.1569780014631;
        Sun, 29 Sep 2019 11:00:14 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.gmail.com with ESMTPSA id y3sm2355511lfh.97.2019.09.29.11.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 11:00:14 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/14] ARM: tegra: Add tegra_pm_park_secondary_cpu()
Date:   Sun, 29 Sep 2019 20:59:45 +0300
Message-Id: <20190929175952.22690-8-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929175952.22690-1-digetx@gmail.com>
References: <20190929175952.22690-1-digetx@gmail.com>
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
2.23.0

