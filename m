Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23507699E1
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 19:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbfGOR37 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 13:29:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43458 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731863AbfGOR37 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2019 13:29:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id 16so17082588ljv.10;
        Mon, 15 Jul 2019 10:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Bk1blV5oQEyQV3BicG+2hmfkOduACJXlcdjcBUfd1g=;
        b=sWQFfx6ybwZg4ljFXMWw4o2jX6LNSL0/W1n31kmg0FMtfIyaMU4C1Egzndl25QsslE
         kC/3dUiDm+ZMFR6g/H8EoL6EipSapfRtvuV8gCk9WIG3RUFvtJEAdlQuaWYXrCy7eomA
         MSnivkTYb8lXi7p8Z2RVY1MyxzmINqnX0lAo1RyljM9YlbMJgypup9wD3OAipwJpUdq+
         TfPBT95d+YBoKB+jM/oQ5S3iG/VXGOoplCHa1RprFlwKQsz7rgNDNRe+WrZTae6Rp/x/
         W0ayR8wh5Oliu2WyWRKNDD8PxmF6YsCTjSR8mz5XNRCWP7PmoFkoEhOzLU8Q8dPIINzp
         1ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Bk1blV5oQEyQV3BicG+2hmfkOduACJXlcdjcBUfd1g=;
        b=b4sVJfG8Et9+va5kfFr1ao0RWir8T5xaUWv5VzgNoInofucTmJHc3Km7jbbvzI1FrW
         UpUeURJRKDxINNoxz2NGmYWQyIr/DDTiGHQJcuvPC8TaxEgdvAXVYJkKx1gThfZaKPK2
         +9S/0mSHgf5g4YAT5d/vSJ+B/dWsnxAhZdPiF0MYKq7ODjmZUTSztNe+tufqkYmOia9J
         xZdbGyI17f7EW8S609Z2vFSqPlg1VsVytfU5yI1DuQTnYj3w9thy69CNNtRegv2VZH+4
         J9W0kyD3bfwQhk+SFxmOgdYdX9mKLkgSfPOUuf7Tq0fanRxJbKYikeI6Nvp/x9pF/2uS
         DGUg==
X-Gm-Message-State: APjAAAUiHXUb5D2DONHFE9+rKJRAOH+GBVNWKhc0x1ESg890r6ScYp0K
        tgByhYGCCmAq9B+o6WO3/r8=
X-Google-Smtp-Source: APXvYqzOUT6VQLLbYkitbj/O7ZOWVmn9kFOcBjnh1ThsbpBMAGKLhgxuIvnkzQbjKrIzTSTXw2BksA==
X-Received: by 2002:a2e:8e90:: with SMTP id z16mr14783618ljk.4.1563211796650;
        Mon, 15 Jul 2019 10:29:56 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id b17sm3248765ljf.34.2019.07.15.10.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 10:29:56 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/13] ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
Date:   Mon, 15 Jul 2019 20:26:28 +0300
Message-Id: <20190715172629.4437-13-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715172629.4437-1-digetx@gmail.com>
References: <20190715172629.4437-1-digetx@gmail.com>
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
index 6a40bc2ef271..2c0fc7968c42 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -107,6 +107,7 @@ CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_ARM_ZYNQ_CPUIDLE=y
 CONFIG_ARM_EXYNOS_CPUIDLE=y
+CONFIG_ARM_TEGRA_CPUIDLE=y
 CONFIG_KERNEL_MODE_NEON=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_TRUSTED_FOUNDATIONS=y
-- 
2.22.0

