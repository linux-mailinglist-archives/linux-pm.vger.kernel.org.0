Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26E2565084
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 05:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfGKDNo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 23:13:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35771 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfGKDNn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 23:13:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id x25so4209558ljh.2;
        Wed, 10 Jul 2019 20:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9sbsaF7E0TrDeiv6pReKgq+pMBX4p8SmM9uYJr655g4=;
        b=aGB/SVa7WbWVgBBhBM6vgu7gzzlo+d7rfMzVsbKQmdZWNq/r+dT3/N90zCR2S4c7pr
         vjsI4+fHMkxdw5mw6P6W0BmGQyh6b7CgkqGs/UYiZThpRxq7msqe5cOrzJX0u1bsq7yr
         NQmNBsyB8MGGyvXzDlEcXYRZG4MPg1LBgKxUuBUdwtquUT3e0I7lpRQPCUQ5B2A21Ird
         3hzJQ36qBJryKrjSktP0eCNh01PAUCWbtE4+jysmRLrSkjYPD/BbVV/U0EJ95vfFj4q4
         P0VSYLvafwjnDO395Sy/yiK+OS/EHP8CmGRWj9GYPmVYkRts/2a4Iu4pXjFNtbHJoUTz
         OrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9sbsaF7E0TrDeiv6pReKgq+pMBX4p8SmM9uYJr655g4=;
        b=o9VGGZaC0P4G/dHj/2dYuhHCXvUf6dF30J75Ab8oSVt+0ExNd+/glSugpXOwhS30St
         5ud2/GzvQNmG6n7xv+VFeOMiRPp58Yzt5bEUiZxqtq5GzSJn9xN9/33eglnuJkX/qV3h
         gHTDMUUue1N6DoCBUlUri02QlGEUXcMCaX/7vVcj4aDpzUliN1wSy8h+a/ShEtdkcLYz
         Y4Gvh/wOQHAXPHd2b/fGfMZXDvU346b2Ymxzqc1xIpnxZIYYa5hthWPc6hvxSoU/m3sr
         PK2X9I+oBR6XON8JRYcmWav6HipkeLqVBDSVXOJw/bYsIjgoi3BJFXLDsgZIw+6k8dN5
         M4GQ==
X-Gm-Message-State: APjAAAXyQxpvTjdUQe9IiPFuhiPtyGMyddTiPxQAc2fcnAXSZU9ZBcCO
        mEOcoCQnGrMUynjjprd1Z9eGuxFZ
X-Google-Smtp-Source: APXvYqyMqIcyVX6+e7hHIYbQpeLQ/U8rBaUVrLDaRq102Byqy/BB1OiBE3ibqp6e0uVdyiIN+5Gwsw==
X-Received: by 2002:a2e:b009:: with SMTP id y9mr864326ljk.152.1562814821269;
        Wed, 10 Jul 2019 20:13:41 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id h84sm753915ljf.42.2019.07.10.20.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 20:13:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig
Date:   Thu, 11 Jul 2019 06:13:12 +0300
Message-Id: <20190711031312.10038-7-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190711031312.10038-1-digetx@gmail.com>
References: <20190711031312.10038-1-digetx@gmail.com>
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
index 8f5c6a5b444c..9a2f11a780a8 100644
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
2.22.0

