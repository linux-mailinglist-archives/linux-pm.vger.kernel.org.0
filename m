Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2BBF8220
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 22:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKKVQ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 16:16:29 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46696 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfKKVQ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 16:16:29 -0500
Received: by mail-lf1-f65.google.com with SMTP id o65so7309083lff.13;
        Mon, 11 Nov 2019 13:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PAYNs/o0oQ+5oMrw2AY1UO1+THnKmjTd9tnbcB8Y4M0=;
        b=Q2iK21iJtBFjWAaeOaPZqOmSaSe3MEwlmERW6ilxD3hSfoKzMxedVnKiznVsi17Biz
         oC2qAhXpfpGw+JoWIM4mFwyQrQ+jJV1Sh8oM7yiNBINEBdDaqGgAg/qtmFAHz0U8rw6K
         7fQYgpTwg6BQzwmS7mW/OwRJcrjlu7AG3Jv7dM7KIhD/Rl1ENrJF+qXFAawVuciatO9I
         iZn0NVydM8QqSnDsI76ZW7JQbRVcB73xp35uvZAhMjdFnr5RBkA6HbfyY61/XAQbauNK
         sinoTLTtKh5wAUb3kh8rCwvEZKxSDQFcZ/Jvn6wH+8JsKnBOxDNoJPfIxhdsh1A6GeFR
         wyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PAYNs/o0oQ+5oMrw2AY1UO1+THnKmjTd9tnbcB8Y4M0=;
        b=tDVEa4Rzuic9jX62TBlsQ6PRZXAeRLmNj0InJr85mZJsz+cnIo8bvNeroHYj2vCNfh
         TxvNAv8ZWKScfbVU92SfSSKBomK7Z0wm/gSs5OEwlHLP8Kksr9b213RkuLkBzYo6qhDb
         59pt7IoV0WtFX/2yjBY2+8TiYKdqwYysj50Unt6RvGJbcbL5jX6UOgOY/hpn9XV6wAo2
         rfKEMxypECjxWLwc8j8jCt1IBuM4Yh0hA6+nAKHdH6oqwBS0kVrtc/44mNNzsPEpHf1c
         aLfexf/1SyI6PVVM+Z4w6cKSoO9V9Fd7aKyLsCkchAK+dJPNDBl20VomBvRqdFPMnEt1
         pMiw==
X-Gm-Message-State: APjAAAWpC7QSyU7wHbCaVcqlUPdNa0vpz3LAGTvozx76HvNmH0t91he9
        SQooYMEnkL9J4IMcVx1xS3s=
X-Google-Smtp-Source: APXvYqwInkgo9xGt2KGB+I5coaGai3wVBR+4uSRNQnaeGTAmcU2wav8h0Q//umkpsgCjen4XxTYoAw==
X-Received: by 2002:ac2:4c1c:: with SMTP id t28mr2971767lfq.63.1573506986619;
        Mon, 11 Nov 2019 13:16:26 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id n19sm7913150lfl.85.2019.11.11.13.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 13:16:26 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 02/17] ARM: tegra: Add tegra_pm_park_secondary_cpu()
Date:   Tue, 12 Nov 2019 00:15:41 +0300
Message-Id: <20191111211556.20723-3-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111211556.20723-1-digetx@gmail.com>
References: <20191111211556.20723-1-digetx@gmail.com>
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
 arch/arm/mach-tegra/pm.h |  5 +++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 3cab81b82866..f5ff3dd1dd81 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -436,4 +436,18 @@ void __init tegra_init_suspend(void)
 
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
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 569151b3edc0..9a790f00237f 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -31,8 +31,13 @@ extern void (*tegra_tear_down_cpu)(void);
 
 #ifdef CONFIG_PM_SLEEP
 void tegra_init_suspend(void);
+int tegra_pm_park_secondary_cpu(unsigned long cpu);
 #else
 static inline void tegra_init_suspend(void) {}
+static inline int tegra_pm_park_secondary_cpu(unsigned long cpu)
+{
+	return -ENOTSUPP;
+}
 #endif
 
 #endif /* _MACH_TEGRA_PM_H_ */
-- 
2.23.0

