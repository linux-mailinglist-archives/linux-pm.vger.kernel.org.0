Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1DD7C7554
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 19:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347356AbjJLR6q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 13:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347360AbjJLR6p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 13:58:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB9FE1;
        Thu, 12 Oct 2023 10:58:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso514219266b.0;
        Thu, 12 Oct 2023 10:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133521; x=1697738321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0vkuPG5wLH6ih/b2x6DE5PLw4yGHLyLOJVZ0ZmjBXNM=;
        b=gghVbSkEkHGXk7VwU+mKskUhqzYN8L0cjkAqV5nrxVwK97kxdl2aW5NGP+TJc9sFvG
         nYkG7HFnpOVRHxlrf25QpJIhjfh1euN9vYjwogReJR4M2He5i3zwbxO7rnVLRAd+5HM2
         U0aSJohZx8ZPpL2L/T5U4UxJNWlmCVUQsFOf9R9eJxJtzrJlGO7/xwtouOFGRBxksCtJ
         zj7yy+q/K2UprFNHXJBbzVWxO36FxeGxmbf47qTvTCqFVr8y0XAMwCGrmIWHAOOaBRLk
         XfVUvsJhQfVmjBrwz2hNPNCQfavFS8NbJNxXki66wmL72zcAexgLtq9vk+2cuV4ARwv2
         MICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133521; x=1697738321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vkuPG5wLH6ih/b2x6DE5PLw4yGHLyLOJVZ0ZmjBXNM=;
        b=wGc7gCl96SxHR/kTEcfLWvAxz2LEaWqotJwzRD6BTnAV2CNb0trED/W2bmmgvNFQAW
         4E4et0V4rxKHNjz1XKQUEvs+wwT+R/5pCwlX/73YCzeCm66D+x7rQw/gXYdtouHO2yHx
         kvyXYyWgyLFzH1xQqtPQJcxYQxv6hj4lQMkiZyolYCOlwfQ8hibZDfPJc4fAEdjyT+6g
         moGmZOFp8pasqX+A8Nd3wDRitOIQKwedBl50QgtC0aBysN6ys/lEA1WOpp/ThL3e3vJf
         j2FS8+CGUJMIOYzRWmYTs7xRqxD4wWlulrMdVrDBZxVUeMTSyKde2GL4om/NqwBAiie6
         78mw==
X-Gm-Message-State: AOJu0YzwZcbZ0BG/6OnJrAweTMdMdqnz9I2wymtATf2DFhDt8t+kXYdV
        XakD4x0YhDOxQGWRTauFlxg=
X-Google-Smtp-Source: AGHT+IGFBQHJpNSpOc66aUY/iVD12i0ns+Rx9Dk8F7h3mxmD4M8yPmI6SX1diQvIuFdOaNfmN/nfmg==
X-Received: by 2002:a17:907:3da3:b0:9ae:614f:b159 with SMTP id he35-20020a1709073da300b009ae614fb159mr18653699ejc.36.1697133521139;
        Thu, 12 Oct 2023 10:58:41 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id z1-20020a1709064e0100b0099bca8b9a31sm11390295eju.100.2023.10.12.10.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:58:40 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 00/13] thermal: tegra: Do not register cooling device
Date:   Thu, 12 Oct 2023 19:58:21 +0200
Message-ID: <20231012175836.3408077-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes in v2:
- rework the device tree bindings:
  - add nvidia,thermal-zones property to attach throttling to zones
  - use -millicelsius suffix and add hysteresis
- add patch to store thermal zone device tree node for later use
- add patch to enforce self-encapsulation of the thermal core now that
  no drivers need to reach into it anymore

This applies on top of Daniel's self-encapsulation hardening series:

	https://lore.kernel.org/all/20231012102700.2858952-1-daniel.lezcano@linaro.org/

Thierry

Thierry Reding (13):
  thermal: Store device tree node for thermal zone devices
  dt-bindings: thermal: tegra: Document throttle temperature
  dt-bindings: thermal: tegra: Add nvidia,thermal-zones property
  thermal: tegra: Use driver-private data consistently
  thermal: tegra: Constify SoC-specific data
  thermal: tegra: Do not register cooling device
  thermal: tegra: Use unsigned int where appropriate
  thermal: tegra: Avoid over-allocation of temporary array
  thermal: tegra: Remove gratuitous error assignment
  thermal: tegra: Minor stylistic cleanups
  ARM: tegra: Rework SOCTHERM on Tegra124
  arm64: tegra: Rework SOCTHERM on Tegra132 and Tegra210
  thermal: Enforce self-encapsulation

 .../thermal/nvidia,tegra124-soctherm.yaml     |  19 +
 arch/arm/boot/dts/nvidia/tegra124.dtsi        |  68 +--
 arch/arm64/boot/dts/nvidia/tegra132.dtsi      |  66 +--
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  86 +--
 drivers/thermal/tegra/soctherm.c              | 525 ++++++++----------
 drivers/thermal/tegra/soctherm.h              |   1 +
 drivers/thermal/tegra/tegra124-soctherm.c     |   4 +
 drivers/thermal/tegra/tegra132-soctherm.c     |   4 +
 drivers/thermal/tegra/tegra210-soctherm.c     |   4 +
 drivers/thermal/thermal_core.h                |   2 +-
 drivers/thermal/thermal_of.c                  |   3 +
 11 files changed, 329 insertions(+), 453 deletions(-)

-- 
2.42.0

