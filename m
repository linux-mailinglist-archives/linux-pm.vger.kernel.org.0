Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD853798D4
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 23:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhEJVM5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 17:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhEJVM4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 17:12:56 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A29C061574;
        Mon, 10 May 2021 14:11:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2so25475030lft.4;
        Mon, 10 May 2021 14:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MQUSqjW26YHvSZZLX6sjqGeSJZocN5wakZ04PONt+mw=;
        b=hxQP71uoxb2W5aa+9TfyM3i9IiniBarTc+TfCnYnOQ4MW8dAZeA4luc22X9XgUzWca
         0LGVMLQU2wU3oTEKY/KKjkhbDotfryM2Tp/tYQxiZeOgbDdw7e9IBG1ui6PlYpJSlxE4
         fw96jr3dhVEDqrZ4OGzfoSeZWITBmhDF2ppzTK30BI/Q2mxiBRG0KRyelImE6EmEpWhj
         gfAB0TW8dHiDnHhcdHEEx12RHztsnHG1krgjRhFKICtBYrvqsIUaMQBn9g6+uM9/m9Gp
         g6OH1WfnzZCKLr0S+5YDDL+BT4kaK4mFjdTFwviOFTi0eVo7a8Gcz1AKej72mr3KPIRE
         EkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MQUSqjW26YHvSZZLX6sjqGeSJZocN5wakZ04PONt+mw=;
        b=lAVaARnO60k1ko1g0FmpIZ6uzIFnNXWN/RL9YWWbDWBuRCj+Da57UpdpYN5ZzSwZGU
         8U1j7wDL9TThOJuJ/0LJGnMnODxfBwicxJDvL/CboGIzAbtIy7MGSIBAAaNmleBbkNvw
         2lZsyOibB97NW2gTvFpbIEwJs2n2UVyUY1ZTjwoez2AWAF8ABu4/95xZAx9YCgXDiRck
         rYNVGREn8Nn9Hqr85iztWHwImPkAhrKA9HDPMGTx4nbnoKXq3ktDrSLcDNPWlKDHVSQo
         y97tIhCyKrKmlpoity9QjLp+IIfQYDYHRmavfsOSX0tvjTMFZT5PyFDKK364vQ6/fj7P
         5Ggw==
X-Gm-Message-State: AOAM53041HF/sVZpL896hrdPrTbwpX369hXbRXmILFmkGPQ2r4vRTX3O
        uDoHkjv5ejdKutIiJLXMH0s=
X-Google-Smtp-Source: ABdhPJxHOLcdb3ItsogI/MjXurZf0Mqori29Ejw6RWeYroNsuuJQTmSTk4ddgIIO2FiDSP6KvoQGPg==
X-Received: by 2002:a19:ac44:: with SMTP id r4mr17663045lfc.438.1620681109109;
        Mon, 10 May 2021 14:11:49 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id x4sm2365339lfa.173.2021.05.10.14.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 14:11:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v1 0/7] Add thermal cooling support to NVIDIA Tegra devfreq
Date:   Tue, 11 May 2021 00:10:01 +0300
Message-Id: <20210510211008.30300-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Some hardware versions of NVIDIA Tegra SoCs support higher freqs and they
are producing much more heat than the other versions. We found that CPU
throttling may be not enough on devices like Asus Transformer TF700T,
which is Tegra30 tablet device. This series adds thermal cooling support
to the NVIDIA Tegra30+ devfreq which cools down SoC by throttling memory
frequency on overheat.

Dmitry Osipenko (7):
  PM / devfreq: tegra30: Support thermal cooling
  ARM: tegra_defconfig: Enable CONFIG_DEVFREQ_THERMAL
  dt-bindings: devfreq: tegra30-actmon: Convert to schema
  dt-bindings: devfreq: tegra30-actmon: Add cooling-cells
  ARM: tegra: Add cooling cells to ACTMON device-tree node
  ARM: tegra: nexus7: Enable memory frequency thermal throttling using
    ACTMON
  ARM: tegra: ouya: Enable memory frequency thermal throttling using
    ACTMON

 .../arm/tegra/nvidia,tegra30-actmon.txt       |  57 --------
 .../devfreq/nvidia,tegra30-actmon.yaml        | 126 ++++++++++++++++++
 arch/arm/boot/dts/tegra124.dtsi               |   3 +-
 .../tegra30-asus-nexus7-grouper-common.dtsi   |   3 +-
 arch/arm/boot/dts/tegra30-ouya.dts            |   3 +-
 arch/arm/boot/dts/tegra30.dtsi                |   3 +-
 arch/arm/configs/tegra_defconfig              |   1 +
 drivers/devfreq/tegra30-devfreq.c             |   1 +
 8 files changed, 136 insertions(+), 61 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
 create mode 100644 Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml

-- 
2.30.2

