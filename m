Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC9DF8200
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 22:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfKKVQo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 16:16:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33406 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfKKVQn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 16:16:43 -0500
Received: by mail-lj1-f194.google.com with SMTP id t5so15393939ljk.0;
        Mon, 11 Nov 2019 13:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HzU4Em/jAGZPIDjIbLxQtLRkI9MSE1QrI5BazFDeU+g=;
        b=LIpkEbMUel9UPxujxayC9reONTyWYPFNh9mFHg5noiWUpH9n12BAfoh5mTxv8JMXGG
         gISRHA+W8XBKj0QuO2FIkHB3jJviaMUPJ/0U8yLq7Wl3Vhla5OncNfdbccfyBK6pIjkC
         Tx1j/n/nW2+58p9Oyl94Z87qoAyYKARClWM9LQimFPhSiKbW0jNUMquNZD7CMmtMfDyl
         LwMpsyLqmVgQNL7kh1Aa+jDerymGKrf6rShbF5p1ybe16F5Rq77za2hMpvF65AlCszLm
         JEPc1/EayKYIVvHWt5VzgxI31FMhkXy8Yu+dVy/+oLWO0Sg6dMX8qa+dGbWZFwIGVtkb
         ZvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HzU4Em/jAGZPIDjIbLxQtLRkI9MSE1QrI5BazFDeU+g=;
        b=V5Y+HkG5m35N366C3Yl279Z9NqHnVDpPzy7mgGSL91/7WHZtru/QLqoxuOIL6Zp926
         OkL5vGI7f+aDHAcUyjwfyLHUaF+spCNfCX6/LHR8Gsvo4m+ap+7sxLAXiMRSPIppzo9t
         HEE89DyD3KZVYdeEhjXL/NfsQbdSuKnHq+NINIhRQe0QxVy84VIASvicdDRgnMIQpvAO
         VVWopmrJ1YBZ0sm67qN/komzbPFh+ppr82cTUpb3sv3Zs/fMwwlCevaMK+xp9N47akU3
         0ES22d3UGL6+omwUdp8x1Hsnow1AG2YWlpOhYSFP2YJD5hCB68WSWNkgnLU2d3U7NxQ5
         ePxQ==
X-Gm-Message-State: APjAAAWbzQG6ckDncr8ekwaenaj5RdSZwsk2J3emePhxYgO6nWfPBgg/
        acTHI1cOoATYK+MFwqtfPM0=
X-Google-Smtp-Source: APXvYqxHXuW0ui2OCx/3DMvtAgxaM0zGFqKl5bAN8SNMT3vs9cWXLqGG9IBn1FShX5OC31J9C7xJvA==
X-Received: by 2002:a2e:9a12:: with SMTP id o18mr17625625lji.191.1573507001338;
        Mon, 11 Nov 2019 13:16:41 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id n19sm7913150lfl.85.2019.11.11.13.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 13:16:40 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 17/17] ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig
Date:   Tue, 12 Nov 2019 00:15:56 +0300
Message-Id: <20191111211556.20723-18-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111211556.20723-1-digetx@gmail.com>
References: <20191111211556.20723-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Tegra CPU Idle driver was moved out into driver/cpuidle/ directory and
it is now a proper platform driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index a27592d3b1fa..aa94369bdd0f 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -25,6 +25,7 @@ CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_CPU_IDLE=y
+CONFIG_ARM_TEGRA_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_TRUSTED_FOUNDATIONS=y
-- 
2.23.0

