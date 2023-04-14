Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940AE6E23C3
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 14:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDNM5t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 08:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjDNM5n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 08:57:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4767F1BCE;
        Fri, 14 Apr 2023 05:57:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j12so1153622wrd.2;
        Fri, 14 Apr 2023 05:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681477046; x=1684069046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h4rbfUVik5xRNzue+ouR9/NTw/dvLCy/S+K2ZW8gQYs=;
        b=lGMBduVQqBpHez/cPpTpIfKN+1eIMgYKdu3neYEjptDvnhQwd59NywD2aeHzY0nlml
         2HXftBIIHibxrz047eBJGtpfTJC8OEiOS7EeXIIB88N5Mv87CnIR09r8OZFqn6BSvid5
         n6lwaWLgEuGPM2WrMoXK4Qk/MLuMB1Lpdi+lV6/r4GiPIInFu9zUVFPur7PhbJUxNsDz
         lSkpel2DhnISbOs1pPF7eGK+QnAdf2Mj01Zrc+MoLtT/0+2pWOlECj4aCMmicPA0mAgY
         ud3uyGOwup/pk5JPL4zlSmkSGqFhh65B5rGT8lxQ7gJTJEGMJ/v6C+nuRnlg20ZS7sE2
         wLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681477046; x=1684069046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4rbfUVik5xRNzue+ouR9/NTw/dvLCy/S+K2ZW8gQYs=;
        b=dzmHMKHS1FeOIgoVijwZnf/I9eBgwQgkk1Y0ELN2dnOKRUGorvnhjzd78LCD3MCow2
         1OVRH7c0dIjqQCJefIKKxHdene7HVzBP5Bciad9k8bBLoeHm0qR4mtRGDpEUs6rAjFGl
         O1To32zvwwzMEI/O2zSSAWefmWpD7IRzhnjua2Bl6I+6bXvF44dqSyAsf61a7/0xp7x5
         lkwJwp/+Te/TIartbLIsapei6JrQBXXfL/giAFxi/q/LirYWhW+8duem3oFhc61AGzPo
         k2asrMvYKpwv9lL14MOWOg7LHb/hT99lU99Xo8o49fiK46gl7wdHs5U5/vvnFbxAQYmM
         LN/g==
X-Gm-Message-State: AAQBX9dJD4wYYm1gSfj7vqeGYGI+nZUQIDUT7xM5Q1iPY/yxmqXej9zX
        7jlNX5WJ/F2gZBJknk3SBww=
X-Google-Smtp-Source: AKy350bzIUXHvaV/t+ibljk0ZdXFSjIITDL1SzGtv0Da0ZvBQA3Qxje4BgyVJaAuTBD3NrzLyaKxGw==
X-Received: by 2002:a5d:628e:0:b0:2f4:15f3:271e with SMTP id k14-20020a5d628e000000b002f415f3271emr3435754wru.2.1681477046034;
        Fri, 14 Apr 2023 05:57:26 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d4fcc000000b002f22c44e974sm3494575wrw.102.2023.04.14.05.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:57:25 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 00/10] thermal: tegra: Do not register cooling device
Date:   Fri, 14 Apr 2023 14:57:11 +0200
Message-Id: <20230414125721.1043589-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Hi,

this set of patches removes the registration of the SOCTHERM internal
throttling mechanism as cooling device. Since this throttling starts
automatically once a certain temperature threshold is crossed, it
doesn't make sense to represent it as a cooling device, which are
typically "manually" activated by the thermal framework when thermal
sensors report temperature thresholds being crossed.

Instead of using the cooling device mechanism, this statically programs
the throttling mechanism when it is configured in device tree. In order
to do this, an additional device tree property is needed to replace the
information that was previously contained in trip points.

There's a few preparatory patches to make the removal a bit simpler and
also some follow up cleanups included as well.

Thierry

Thierry Reding (10):
  dt-bindings: thermal: tegra: Document throttle temperature
  thermal: tegra: Use driver-private data consistently
  thermal: tegra: Constify SoC-specific data
  thermal: tegra: Do not register cooling device
  thermal: tegra: Use unsigned int where appropriate
  thermal: tegra: Avoid over-allocation of temporary array
  thermal: tegra: Remove gratuitous error assignment
  thermal: tegra: Minor stylistic cleanups
  arm64: tegra: Rework SOCTHERM on Tegra132 and Tegra210
  ARM: tegra: Rework SOCTHERM on Tegra124

 .../thermal/nvidia,tegra124-soctherm.yaml     |   7 +
 arch/arm/boot/dts/tegra124.dtsi               |  65 +--
 arch/arm64/boot/dts/nvidia/tegra132.dtsi      |  63 +--
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  83 +---
 drivers/thermal/tegra/soctherm.c              | 392 ++++++------------
 drivers/thermal/tegra/soctherm.h              |   1 +
 drivers/thermal/tegra/tegra124-soctherm.c     |   4 +
 drivers/thermal/tegra/tegra132-soctherm.c     |   4 +
 drivers/thermal/tegra/tegra210-soctherm.c     |   4 +
 9 files changed, 208 insertions(+), 415 deletions(-)

-- 
2.40.0

