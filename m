Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F23B43FF1A
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 17:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhJ2PMP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 11:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhJ2PMO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Oct 2021 11:12:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBF8C061714
        for <linux-pm@vger.kernel.org>; Fri, 29 Oct 2021 08:09:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d3so16588751wrh.8
        for <linux-pm@vger.kernel.org>; Fri, 29 Oct 2021 08:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rVB6Mape8AZ3GYEGuo0nTCaIun4TlRzMw50e6bL9ymY=;
        b=EMVzMLbWRoMf4OZF/PgsKjgYtOS9kAkDV3iR/xftdDi1YIEVdYiMNgF3uUGSG4ejMI
         brjjvHcbKZLWq60nsW1wt3Kp2xqSMKlMA2JlXtfDuXQo1G+D8iLHxdnVSQvHBu1qzEWa
         rpUOMRsX9HhMcfOWoGp1HOLOReQb2I3SRwpJbXAJr6S2yI9qC/Q6I5TQBRIIHHrwBXr3
         5zt5o2vY7SrkMm0KlmDUXUZk0TaYXvvsKOlz4FqH89IyGeAIr0du1MU2RtcP8vSqA1Ve
         AV4A1Rm9pi1ZesG5fH9XChCNoY0Tvt6IJBxArlfTlp4ykeoG9Fx609FIfpCXdMs9JyqN
         /YQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rVB6Mape8AZ3GYEGuo0nTCaIun4TlRzMw50e6bL9ymY=;
        b=GIDj0NTeICwaxswXScRlslZYHi9wG+5e5Xyba1LzzMt4IShPVIdfyiaQ/G92HV/dWg
         P2HmrLXJAYmG4y6M786rMEeqBKuFRVS3G3G3JCgcR1DtDqKgUdiXgfakzBiuiiOMY4d0
         fvIbFNEEif/vJQDMnU0E10VaREkcTOJ0P5p8dRX5IVXcX+80RRtqFR7iRobr0WtNzyI0
         YFq3Y/hjRcMpDX2Nd/dxURjqn6HmexkOUmO1Bzj2NRXPJginPOUA+WjVqx04o+wdj0RV
         2RzkSs7kYGzJvbfVfHy/gaVGh1wQrFOpJZE9/eR3EYQqTzDqqFb3l6PvGGEDnZWlZL0P
         S+rw==
X-Gm-Message-State: AOAM5313AgRQ6Y8wPtCPLtxHw9akMg8wlCmjnblLEpkjmD+TepZQmoF0
        IMK5VBz4aggtNCKaKb/OiWcb5ulQSsDUiFo0
X-Google-Smtp-Source: ABdhPJxWCDtRa1WRZHbIEGvicZYDAkWdzBxqu6H4aBB+0DGhYUsouJaUQCXEmzjReLHo4UHowFMefg==
X-Received: by 2002:adf:c40f:: with SMTP id v15mr5519721wrf.302.1635520183915;
        Fri, 29 Oct 2021 08:09:43 -0700 (PDT)
Received: from xps-9300.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b7sm7091906wrv.72.2021.10.29.08.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 08:09:43 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v3 0/2] Add a generic virtual thermal sensor
Date:   Fri, 29 Oct 2021 17:08:55 +0200
Message-Id: <20211029150857.504891-1-abailon@baylibre.com>
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

Alexandre Bailon (2):
  dt-bindings: Add DT bindings for the DT-based virtual sensor driver
  thermal: add a virtual sensor to aggregate temperatures

 .../thermal/virtual,thermal-sensor.yaml       |  80 +++++++
 drivers/thermal/Kconfig                       |   8 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/virtual_thermal_sensor.c      | 219 ++++++++++++++++++
 include/dt-bindings/thermal/virtual-sensor.h  |  15 ++
 5 files changed, 323 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
 create mode 100644 drivers/thermal/virtual_thermal_sensor.c
 create mode 100644 include/dt-bindings/thermal/virtual-sensor.h

-- 
2.32.0

