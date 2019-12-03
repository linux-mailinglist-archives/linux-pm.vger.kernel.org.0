Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D0410F40C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 01:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfLCAmX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 19:42:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38358 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfLCAmW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 19:42:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id k8so1686363ljh.5;
        Mon, 02 Dec 2019 16:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0mK1Z7qoFE2PZhFBqu+ALZHCAnCtCbOKYMTfyLZ6ec=;
        b=KC+5/s44yjC+sGvGgutLBMU6HME7FKCgF+Tezsa0DgIckWH2D5WXBH4REhnM3dKW6O
         WybjWeABQ8PkL58tiYzf5k8F0v4C5KqLiLiXIxU/SsdlcDehxaRuafXhQrDq/imdelt6
         NC6HpZ9Jr8kvlMFXHDhzYauCItMi+dYq1Crba97nMzyGyuNhWt6EjkS0joX4buTTo4EA
         IHqGgfXV/567S3CVvv1J08p8Ivdf8uXZMmcc2CwOu6//Y/g/540ofuVI10/EZuj4cnEs
         YNhfZp/vuZ7Vm0ZlQPVsrLvtGMfoUeP2Xp2kRDrypqqrk9f9PPjNW+dFGOU2vwOIHJsq
         aEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0mK1Z7qoFE2PZhFBqu+ALZHCAnCtCbOKYMTfyLZ6ec=;
        b=nVZmoRQewdscguT6ATuVR1W0tN2EEB/VjxsXFZxcFjv3efr5cnvtwAXrIQ9ibmHX2c
         0i92zwWzDTX6M4WHNgji6jFCY46b9QDzHv6FL5Lf109L8idG+X7LAy7mV/HWrOoEu6FQ
         ahiBhmnAR9Jadj+LfSncnZKOY+cbnEeOVsITGiDj/v/q3kGePO40GkkmE1FUUnfxgo+K
         ZwLjiEjqmthiwDubVsDNDime31UKf689zwTdQ4Bgrv6/SI9+FOTRKxtBywFttdLLsK4O
         3gm01mCWrPgzQxfsGgfpmX4dKoo7h50kIYm6iuch2cS7TfJmVkVwyCUUN3sdzmAn8iuw
         iikg==
X-Gm-Message-State: APjAAAVYZzvSCMtaWVanAd7FIs9k0hvI8q4XxwAq1kwAkx6UkdVidxP4
        QWRWEUZFMWP9rG50HLBowI8=
X-Google-Smtp-Source: APXvYqzuOaDi1w2VYKYtjXSXPnGq/WjZ67cZD2LiTfoJD/V2fG4riQ84gJiNZOska3OXND03onH5uw==
X-Received: by 2002:a2e:978d:: with SMTP id y13mr878257lji.103.1575333740100;
        Mon, 02 Dec 2019 16:42:20 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y21sm456384ljm.25.2019.12.02.16.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 16:42:19 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 18/19] ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
Date:   Tue,  3 Dec 2019 03:41:15 +0300
Message-Id: <20191203004116.11771-19-digetx@gmail.com>
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
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 24962d0e71c7..293f0cea076c 100644
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
2.24.0

