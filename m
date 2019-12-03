Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5096F10F412
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 01:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfLCAmZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 19:42:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45808 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfLCAmX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 19:42:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id d20so1623172ljc.12;
        Mon, 02 Dec 2019 16:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=imnnqxS4XYlJpcakyQfZSF6VXI+HvHKYNPt5DnEHnHw=;
        b=KQSRPXn4dUWHiByc6z92JVtNZBcewSoNB63v8EpDiJLOctxI+DrD4FdetkFcXfOqNu
         W4440cv7tgGsPwweeDbXinwiJiBZyE5MTWhDcDoegUFWVyz5SERh6Zp6QygmHO5Yswi5
         jEMBlze9I21XWX02tseSd+Jg11a5y+9e1o8JwzbI34EVw84oQ4z3UsiXKhXGKVAN5ZQf
         5mJxI3mATgM/547yGymzdiY/kEm3lbk9suW4asOLeIldUA8mlWjcQZrWb4PDdpMAAv+G
         u4tEGfnPrGG3Ej1pfFHWoDDV5/kACvdwjrtV7FB2v5MZk/H7TerauQg2b9O07jT0Lav8
         O+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=imnnqxS4XYlJpcakyQfZSF6VXI+HvHKYNPt5DnEHnHw=;
        b=M5jmkthkhDhKXsO6qQkqghnGrzXV5cyqA5DcCwpen2ADjlHtFLO6wvobfwCWNmyMLt
         qf2Odn4qYmw6itBG/12FiLUuhRyTKE/n7yZ+pdClxkccQs7HpKnVw0w9gJC8uqqP8U7O
         WdB3xRm1oycr7qtHV2ZpXeWD5WalxxTaOBPbusjpFJVlQzg7dUua2vx39z3ABF+09kvt
         wpnsf3mzr8cUaAzJxkuSILmdxs6nPUWxYr6PJU1BPWDzGdx4V7gw2yjZmtNuiqP4HF8g
         bN6YX0Xup+LcMjxgDiNnA2FmUuprH5N+LWtCG3sFu9aZ4u6aUROcC8evn6OLcQFt+lEM
         rxdw==
X-Gm-Message-State: APjAAAU90JTbxHcWjr0kTnikGr6UUK/dxnfhrIlRJDw/bBocDhTPZ519
        hZXQTYYQHEzOz1Dm2HFfNaE=
X-Google-Smtp-Source: APXvYqzA09wneGnM2Dv67ipc7OMdiZxhpUzqRw2d2tkvqoGdbSFHXer3A6mNASQuRYt6d7rMT6d9SA==
X-Received: by 2002:a2e:89c6:: with SMTP id c6mr892313ljk.113.1575333741038;
        Mon, 02 Dec 2019 16:42:21 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y21sm456384ljm.25.2019.12.02.16.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 16:42:20 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 19/19] ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig
Date:   Tue,  3 Dec 2019 03:41:16 +0300
Message-Id: <20191203004116.11771-20-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203004116.11771-1-digetx@gmail.com>
References: <20191203004116.11771-1-digetx@gmail.com>
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
2.24.0

