Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CC045EF44
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 14:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377645AbhKZNli (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 08:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243852AbhKZNjh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 08:39:37 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FCEC061D71
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 04:53:33 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so6725789wme.4
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 04:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dlvnTPe3lASdFY+T2t68uKlxKrbSmUU8V1J05NQSw6U=;
        b=vx3JdoCTTR1Vst52bANM/Z7IW0FbzkICR7KmlAK0Oh18SEu6OAw4QJogoVfZi4orf3
         umQwcTF2WSvValr0zxAMw/jP6yiRaf2jAvC9TuHopBlsZfevxuU7svcmVz+nvlvly1B7
         2fbykhH51D7AukLnwsqMn4WDGAQYVkdPU2twltng4xNlNGY7mGxAS4qkDfOyKFxDmD7F
         SJfT0uvmQVcJPY5+TVzawK1jQ3zzb6idY+b2vmMtmvkhGLKE3pH5kPXchytLEh+e2PyK
         EKVdRzhKEJwipsolGkXJjc+5Vw+aFATwVzXNu20JQuPP6LDh11ZcRgZ/jYPkYTV2RTQ1
         oIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dlvnTPe3lASdFY+T2t68uKlxKrbSmUU8V1J05NQSw6U=;
        b=1+31JQpfDvOHUps5kVDdH3a/bm7fI2cuo6GchDsGRFWxHkq24cpdQSjC+E/iSdmFy+
         W0eQ4GYQBW1YZ2SKMFpah0psRjV6ucWXvccYrMnmKfsin+VrNj1RyBFIYri/wEt42L0v
         kumP6x09UQWbrCUkq5xhHmo1+7FiAI8dKy3DljkG5ZhG6zYYjB740mGJ9g5g849fWvuQ
         cF/exdRjwhIcWDmNXc6h+Ff77gkZR1VWlACqMo4hq2dbgOsRGXFGEG/yJ+36nw44U+TL
         8Xpoz/oHRKfW5ZlEWumRptFIvJMZ649x3102JezJJda8oTogq+TlHlWILmusivyBZvNZ
         1XMw==
X-Gm-Message-State: AOAM531HR5aDAvVKRyYK0EuVgbmbiZF5xVyAy9iuH1gdb5h4LwQ5Ga0w
        9r6wiSoTl2dpmWRlycFlO5R15Q==
X-Google-Smtp-Source: ABdhPJzvOAL7myFEAtrbimp/grrwHLS5GERcVMo6S8I6FeG3H8Y9RpNZEQH2gDYC1I6jeiHaHI/tvA==
X-Received: by 2002:a1c:f418:: with SMTP id z24mr15612899wma.95.1637931212030;
        Fri, 26 Nov 2021 04:53:32 -0800 (PST)
Received: from xps-9300.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n15sm11762083wmq.38.2021.11.26.04.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 04:53:31 -0800 (PST)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v4 0/2] Add a generic virtual thermal sensor
Date:   Fri, 26 Nov 2021 13:52:42 +0100
Message-Id: <20211126125244.126300-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series add a virtual thermal sensor.
It could be used to get a temperature using some thermal sensors.
Currently, the supported operations are max, min and avg.
The virtual sensor could be easily extended to support others operations.

Changes in v2:
- Fix some warnings / errors reported by kernel test robot
- rename some struct and functions with a more accurate name
- update the dt bindings: rename type attribute to aggregation-function
- factorize a little bit the aggregation functions
Changes in v3:
- Aggregate thermal zone instead of thermal sensors
- Use try_get_module / put_module to prevent thermal providers to be removed
- Update the bindings, to be more accurate
Changes in v4:
- Fix two warnings reported by kernel test robot

Alexandre Bailon (2):
  dt-bindings: Add DT bindings for the DT-based virtual sensor driver
  thermal: add a virtual sensor to aggregate temperatures

Alexandre Bailon (2):
  dt-bindings: Add DT bindings for the DT-based virtual sensor driver
  thermal: add a virtual sensor to aggregate temperatures

 .../thermal/virtual,thermal-sensor.yaml       |  86 +++++++
 drivers/thermal/Kconfig                       |   8 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/virtual_thermal_sensor.c      | 218 ++++++++++++++++++
 include/dt-bindings/thermal/virtual-sensor.h  |  15 ++
 5 files changed, 328 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
 create mode 100644 drivers/thermal/virtual_thermal_sensor.c
 create mode 100644 include/dt-bindings/thermal/virtual-sensor.h

-- 
2.25.1

