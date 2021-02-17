Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7DA31E398
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 01:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhBRA47 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Feb 2021 19:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhBRA46 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2021 19:56:58 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF75C061574;
        Wed, 17 Feb 2021 16:56:18 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 7so812877wrz.0;
        Wed, 17 Feb 2021 16:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FCJCzhNXbsE4bF7PN36Quy90Qz5EMXU0oUIaA6ESrcM=;
        b=YmLXRhQRekT3mB2ptuUP4hRa08NhT5i1HSwvLXJ7ARaRMbgnCa88/DlTVydybrs3kh
         zJRxGQo43U8Cwnxic7D0HJOcquf8iu3/BX7uGjlHrC7vXfVTwOs9j3Ao1uyy9t0S7z23
         FcPlk1mozIQBnV+mGaQOv0RYoNZdFVjvCLVA7gSQ+oKFLAJ0UpN85wM7N82JThViZLM8
         ylnKgQNYuGDSjMH9Q6W9DIajF3VoT4X9w1y11G2P2Y29srbIfVjivsCTYWtfb3Gkisul
         kEJC4n5YvVAY93/e02t0jjGllbKmIaFRrPwUjatsDeqeXluzR/vB6rTT4UcFf4/hva/P
         WJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FCJCzhNXbsE4bF7PN36Quy90Qz5EMXU0oUIaA6ESrcM=;
        b=T947pzpy8/8z4pZcavTHoxaFOIZrnfdHuqsB72eTZO6Q5mc0cghuLrS+WE6tvAiOMg
         HGSCPFYKSM/8DxUdCJP/wJIHSwsLov3CIEsIDZbM0CYryse1cPV40p2krIMnsf5Qh50V
         HASb+vSqmFFhEd+aVYBtrzqLCNKbKEA5vaai1xpUL1fxhtLuJNbElJgLveJCfAqWWVWv
         Mk7DzU9hs+yHuUHsAazv4/Z/bw9Dc2fnR/y2ChcX2kCZERYSjgqkJNzrpo5kFg4jpZKY
         65nq4ZE8RZIOZ8jy+Cfsj2TzdJOKoGEmKrWRBi50OGpWiOWfUfNVOKj0E1r+tBz1sAPE
         BjFw==
X-Gm-Message-State: AOAM532FTPnHwC9mOwCjtuyREyEgVWdnPtPaGFDYgMO2wwutojW3BKzW
        M4CkiHeMQkA2exDXY88HqSE=
X-Google-Smtp-Source: ABdhPJyEVLjnNSU2GQPKOvP97m9VOz2iLdhA5PWONmhpJWv1YDfZedTwSdqq+9mj8EbAt8E+PU9fdA==
X-Received: by 2002:adf:f543:: with SMTP id j3mr1685936wrp.203.1613609776999;
        Wed, 17 Feb 2021 16:56:16 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-87-11-13-110.retail.telecomitalia.it. [87.11.13.110])
        by smtp.googlemail.com with ESMTPSA id t16sm6336079wrp.87.2021.02.17.16.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:56:16 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/8] Add support for ipq8064 tsens
Date:   Wed, 17 Feb 2021 20:40:02 +0100
Message-Id: <20210217194011.22649-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset convert msm8960 to reg_filed, use int_common instead 
of a custom function and fix wrong tsens get_temp function for msm8960.
Ipq8064 SoCs tsens driver is based on 8960 tsens driver. Ipq8064 needs
to be registered as a gcc child as the tsens regs on this platform are
shared with the controller.
This is based on work and code here
https://git.linaro.org/people/amit.kucheria/kernel.git/log/?h=wrk3/tsens-8960-breakage

v10:
* Fix wrong tsens init for ver_0 (crit_trips needs to be set in tsens_register)
v9:
* Fix warning from Documentation bot
v8:
* Drop MIN and MAX THRESH and use CRIT_THRESH instead
* Fix broken documentation patch
v7:
* Rework calibrate function to use get_temp_common
* Fix wrong required in the Documentation for ipq8064
* Fix hardware bug in sensor enable function
v6:
* Fix spelling error (can't find the problem with variable misallignment)
* Rework big if-else
* Remove extra comments
* Add description about different interrupts
v5:
* Conver driver to use reg_fiedl
* Use init_common 
* Drop custom set_trip and set_interrupt
* Use common set_trip and set_interrupt
* Fix bad get_temp function
* Add missing hardcoded slope
v4:
* Fix compilation error and warning reported by the bot
v3:
* Change driver to register as child instead of use phandle
v2:
* Fix dt-bindings problems

Ansuel Smith (8):
  drivers: thermal: tsens: Add VER_0 tsens version
  drivers: thermal: tsens: Don't hardcode sensor slope
  drivers: thermal: tsens: Convert msm8960 to reg_field
  drivers: thermal: tsens: Use init_common for msm8960
  drivers: thermal: tsens: Fix bug in sensor enable for msm8960
  drivers: thermal: tsens: Use get_temp_common for msm8960
  drivers: thermal: tsens: Add support for ipq8064-tsens
  dt-bindings: thermal: tsens: Document ipq8064 bindings

 .../bindings/thermal/qcom-tsens.yaml          |  56 ++++-
 drivers/thermal/qcom/tsens-8960.c             | 203 ++++++++++--------
 drivers/thermal/qcom/tsens.c                  | 181 +++++++++++++---
 drivers/thermal/qcom/tsens.h                  |   4 +-
 4 files changed, 314 insertions(+), 130 deletions(-)

-- 
2.30.0

