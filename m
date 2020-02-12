Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF8B15B55C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgBLXwo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:52:44 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43284 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbgBLXwb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:52:31 -0500
Received: by mail-lf1-f65.google.com with SMTP id 9so2864727lfq.10;
        Wed, 12 Feb 2020 15:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OX3etwg8UyXmbbSJQLCscVLMHChzcySiKJD4V7kijDA=;
        b=pb0kujSMPSK9w5g/NZnWBfK3adbQLCtsLhaqCVMO1zfTwrmWPfIqE9FfIUTklifwcQ
         EpG+m0tpurnUvzieFdKYgbEdgACJYECFHzlBdD2lP8Roe56xjXoSBuQmgO2gDo/PsvZi
         SFlzdWhQYGZI6EZsLX/fDgvQ0V4V8RgGi0yGYcDpoJXqKm5ZjEdRb2J3c39S7uy3iVta
         6aHw5RcIuYMcWcbj35bIe5BG2v8ci45vzA54VVZy1ik+OqyvwHF4+6+WsH39gMqPVQpT
         bLpYVtgl7JBk5ajwAHpy6FIeenOMRAc+wtA7M6jHtaZ3K6SwXJ5a+fMo7OZ3bSIWIl9o
         LsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OX3etwg8UyXmbbSJQLCscVLMHChzcySiKJD4V7kijDA=;
        b=tGhtz7D2IDZCWDyDv5n/MIvMZNtoA0bF2fWiF3Y60dYn611ZHEjkvBz1E4TFCuTnD+
         D4oHaW+EMc0XRGvpMWpAzPhkgXx9DQafAccpd2zdm25bTvc6Vul550fzuwYO8GnWcjAi
         n1GFl0Bj9gtKuOajK3w7/9bJsiKb798MHiwb8A+IQNJboe6ST+SohzgOU2GEluEDn3M2
         w6WJL5kUr/Zx7g4PNlazhYhj5wQ+Mod/1RPrGxCv/Fo2Zs5DvY/MimTcdX53D7nahiDs
         k/YCAIkKe7cnvDLZxXyXVJv6e4Kko0h9pntZI7XgktcukGzQElQn1WVKr69PsilS1G59
         sZjw==
X-Gm-Message-State: APjAAAVibMkF9phuCNVetTmRmd9cE9483vcXglWs2DMmbSE9FXLOBNkv
        8149uG5OzfHZPOmUoQ9cJl4=
X-Google-Smtp-Source: APXvYqzB2TcbLmdxgpXvaaPhZYtm6jwsllo4cX22rC0BJrqGpeJtyb78eZi0LoL0mfpDNpirtJvZjQ==
X-Received: by 2002:a19:7401:: with SMTP id v1mr7867766lfe.129.1581551547805;
        Wed, 12 Feb 2020 15:52:27 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d5sm251686lfb.20.2020.02.12.15.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:52:27 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 17/17] ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig
Date:   Thu, 13 Feb 2020 02:51:34 +0300
Message-Id: <20200212235134.12638-18-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212235134.12638-1-digetx@gmail.com>
References: <20200212235134.12638-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Tegra CPU Idle driver was moved out into driver/cpuidle/ directory and
it is now a proper platform driver.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
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
2.24.0

