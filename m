Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3C66F8205
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 22:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfKKVRC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 16:17:02 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36867 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbfKKVQm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 16:16:42 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so11000729lfp.4;
        Mon, 11 Nov 2019 13:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qtewG2tFtrOkG6LmK5Q27KrhDGQGO21rKK/v65ssGts=;
        b=Z3jArJre5fk5INNVmmqCp7BIaxt7epTw+3qEgBfJS7To1a6vLzxu4fWsK8SKKlplge
         ZSWyG5p6qR1wIqiq7khn6IzXHYJ2Pedux5JDUrb/sWgLkqICkB9USEYaY3XRvHbgzGpJ
         +JdU8sjY5LudIL+pQCltyVGrrGkxBfcflRC99C7Vz5P2FP8enjMoHwnES4aS6ZSxmbKd
         /2e1g8VPXf03szXAueWz00XirsfzCW3tep5VRx4O0YcOJlIZ2B97STsTL9p1Yfi0RCKT
         zZZxAaWBQJISAtE47pdjxCgOD/EpSbc16aweAigcivKM9KzHg+KrDZhKaU6lUvMoSchk
         X3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qtewG2tFtrOkG6LmK5Q27KrhDGQGO21rKK/v65ssGts=;
        b=enf5YnUQ73/VoDba4iOsgRwrSUZ/5thwoUI2hjUXa9V/vHvWDIJjr3GYAdlbArnQsu
         6LMibUXzJIulgSML3LtJog1fTN4ERL5z57bhPE/xgrP1bwtfcjwBb/jyWkO6cRV3XrZW
         XCgEVtI9LzqyCSwr5qEDU9vpR+oAJQkxbRHB/nW4z3mWYAin780Frn8pntORR0wcI24W
         /Zdqj1I8Hkam702bMqjmzW+cuWScRom29u9e4EfcAXKbVb8saD8nbX9+6IGOP/8FX899
         TzAm/Xaj0QVtZq3E92uz0bzyBsfuA5T8IkPtEUk8I6SvfIKqbMBYcv3XqcngmTkgfONe
         9qMw==
X-Gm-Message-State: APjAAAUGnXS3BK+6XE85Iqd8f3aLMCnLTMSHE8jYaAKdrRdj4CwTYJrW
        VJ3cpOKh8vLPJnGWtCHpDWQ=
X-Google-Smtp-Source: APXvYqxm2OFj3PO18wPjzDtaui7sM+zxTOiPxyR/t/WlF+L+/Mx0w2MUhTYdZZdXOh3MuWHWAAI7aw==
X-Received: by 2002:ac2:55a3:: with SMTP id y3mr17062908lfg.108.1573507000350;
        Mon, 11 Nov 2019 13:16:40 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id n19sm7913150lfl.85.2019.11.11.13.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 13:16:39 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 16/17] ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
Date:   Tue, 12 Nov 2019 00:15:55 +0300
Message-Id: <20191111211556.20723-17-digetx@gmail.com>
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
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 86b37af38952..a341259160c9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -113,6 +113,7 @@ CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_ARM_ZYNQ_CPUIDLE=y
 CONFIG_ARM_EXYNOS_CPUIDLE=y
+CONFIG_ARM_TEGRA_CPUIDLE=y
 CONFIG_KERNEL_MODE_NEON=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_TRUSTED_FOUNDATIONS=y
-- 
2.23.0

