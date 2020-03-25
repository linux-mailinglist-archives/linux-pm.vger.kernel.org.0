Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF89192127
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 07:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgCYGfD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 02:35:03 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:35149 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgCYGfD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 02:35:03 -0400
Received: by mail-pg1-f172.google.com with SMTP id 7so685463pgr.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2020 23:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XDUtIM4paHW0qOUeTkKt8AFyM+VSRp0AScAk260LK2s=;
        b=CKVkfHoj/nZYW3irz1TY3+48Q6839881dDZMIU45L1EzcFqwV35P6C6D5VXZbnAfkI
         tu5oq99VfrqvYMrRTwHB+ffrmsUeO73kq5AywG8YIxrLJCU2JQ/m4mjDnhLIzlbXAzG5
         SRjKCWBaMUvDV2WOmQ4X6Q+w+Y9osPekTs/ID/BqAvIoLpSOxc4HnScud9yLgNY22BV3
         XhTQUN0ixUIwXaFqK8DGM6gfhGPLErBzVqy3pfNHNisbhISiExCGQI7vp9FMuVZt4C0C
         1SSrq1Tf/01TtmFIebam6DXTtX0/R7oIq+0/GGSm9kuQOxGawvfTylFbGYn01s8Kc9fv
         mqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XDUtIM4paHW0qOUeTkKt8AFyM+VSRp0AScAk260LK2s=;
        b=MrHnBpnhb6zRTgPMq/H2YlaKoyqscqQJDEIwPD8Vvel9hza9V4l4xUwSy5xKCIcgv6
         qDOCGpHO1kqaQIoDxOSyuBIDW6ywBZ5+G9v9qV+j9qciprXrPNQZkv/2gT7kXtLcFv+P
         70lUuqsHZgM5oalpsdxMzxuYcnQdgQ8afVpgrO0swI6VSWKmFs7NOnvrpaA7czsXv7la
         N0OnNlWfBvWuQq1GAB97tM8n1mjkZRXZP1k0hgdhuASd0LqpGcpI7tRUHVUrw0JkfnFz
         v+DYu2oy8GlL1v2tqAMJzOQznGUQd9gwEsy6mCU4WagJjmelSClMS9j8PSCa4Uyypgn3
         Wp6w==
X-Gm-Message-State: ANhLgQ2VG+d3ebCBZZrjLJmxA5sClqFdvEwY0O2BSc2c4StmP5TnuNOk
        Au0U/SesNie4Y1hxvO+gxMrB1g==
X-Google-Smtp-Source: ADFU+vvN3H7QGlUvfXSacv91SL0XLSkc7dVACoE1ob84EaxILfcJuRko4ery4B/XIUxIwrAPyWlDqQ==
X-Received: by 2002:a63:da4d:: with SMTP id l13mr1705064pgj.216.1585118100212;
        Tue, 24 Mar 2020 23:35:00 -0700 (PDT)
Received: from localhost ([103.195.202.71])
        by smtp.gmail.com with ESMTPSA id d26sm4059263pfo.37.2020.03.24.23.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 23:34:58 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 0/3] Convert thermal bindings to yaml
Date:   Wed, 25 Mar 2020 12:04:51 +0530
Message-Id: <cover.1585117436.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

Here is a series splitting up the thermal bindings into 3 separate bindings
in YAML, one each of the sensor, cooling-device and the thermal zones.

A series to remove thermal.txt and change over all references to it will
follow shortly. Another series to fixup problems found by enforcing this
yaml definition across dts files will also follow.

Changes since v2:
- Addressed review comment from Rob
- Added required properties for thermal-zones node
- Added select: true to thermal-cooling-devices.yaml
- Fixed up example to pass dt_binding_check

Changes since v1:
- Addressed review comments from Rob
- Moved the license back to GPLv2, waiting for other authors to give
  permission to relicense to BSD-2-Clause as well
- Fixed up warnings thrown by dt_binding_check

I have to add that the bindings as they exist today, don't really follow
the "describe the hardware" model of devicetree. e.g. the entire
thermal-zone binding is a software abstraction to tie arbitrary,
board-specific trip points to cooling strategies. This doesn't fit well
into the model where the same SoC in two different form-factor devices e.g.
mobile and laptop, will have fairly different thermal profiles and might
benefit from different trip points and mitigation heuristics. I've started
some experiments with moving the thermal zone data to a board-specific
platform data that is used to initialise a "thermal zone driver".

In any case, if we ever move down that path, it'll probably end up being v2
of the binding, so this series is still relevant.

Please help review.

Regards,
Amit

Amit Kucheria (3):
  dt-bindings: thermal: Add yaml bindings for thermal sensors
  dt-bindings: thermal: Add yaml bindings for thermal cooling-devices
  dt-bindings: thermal: Add yaml bindings for thermal zones

 .../thermal/thermal-cooling-devices.yaml      | 116 +++++++
 .../bindings/thermal/thermal-sensor.yaml      |  72 ++++
 .../bindings/thermal/thermal-zones.yaml       | 324 ++++++++++++++++++
 3 files changed, 512 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml

-- 
2.20.1

