Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEEF3539C8
	for <lists+linux-pm@lfdr.de>; Sun,  4 Apr 2021 22:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhDDUfK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Apr 2021 16:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhDDUfK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Apr 2021 16:35:10 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F27C061756;
        Sun,  4 Apr 2021 13:35:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id k8so3224177edn.6;
        Sun, 04 Apr 2021 13:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UJ4YI8jTbRjT93oZpXzu0rxEht9m49x8ffjzUVHKMd0=;
        b=TOi6QzyJa/+moyBghNzkmYHDqNwzXzo3l34ahb8NyCmou9ZAyIcwejyjaHKnGg4hZg
         pWAVw2nF3yf/MWr8wxMzE3eFkhPO6SIhuS3q4eSikbJ95ZzpWWZQewLEGuszWmU5+wPi
         7d95j1acrP1Kh4VXEVVQ8R8SIPdEY4CF8WfjT+76KghwBLFMKiVgtcpISr4xFnsXYc/m
         il8efAj9c4tgvRfOfCQgTT4uxcAyeOy+s4BuHEFFPvmr57LzERM9LS6MnkV5kgQd5bT3
         1/Ji24qM9+ztMfFTgvZknNLvpx6hqyfGZrOeNGOpf1MkGYs1PjCZZTz8i9IWr/Un3o+v
         03GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UJ4YI8jTbRjT93oZpXzu0rxEht9m49x8ffjzUVHKMd0=;
        b=dYPI5WeOfaEhiESXJCGxWCyYMnWYLc5wqZYEMc+TabyDbzxZEBWpKwQOcTULdzaMvP
         dEcwSYX2oHtiC/Fmj4Xs6gX61GNUWsjABHJF5AxqZH8o93bMKuyhjrYBDe/897I0rDJh
         HKRKMjzE9MFPf3dnbaf8XVNiiP+zwQ6sBNnzQAFIlRa1FbvyX5UnLP+1wA9K8Ayxqkho
         HLM0AvVwkBlsOZJ0SA5oquGiGPo0eQfWpD9JbraRQQ2mHlbumYv0I6eRuhk/toxbCggk
         JLTcm676irwOlBnAeL1gymYP7l8aEQsbMnwxurStggYm1CDvvfo2V8Rj95Mv9aq2m8tA
         EhPg==
X-Gm-Message-State: AOAM531oq7TVbNMVoc7w/B0TkB0f6KP/dFXZfmpANwEzGtdfXOkq7YYA
        mq4NM0R5FhqnABWOGsVsm08=
X-Google-Smtp-Source: ABdhPJy4mNatcAeaqDvFLE18F7L7ZJU2Pun3GD+V8yASKiU/CuWFD533Maiiw3cK4sL5ZyvrrB/Bhg==
X-Received: by 2002:aa7:d5c9:: with SMTP id d9mr1238420eds.335.1617568503949;
        Sun, 04 Apr 2021 13:35:03 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-52-251-187.retail.telecomitalia.it. [79.52.251.187])
        by smtp.googlemail.com with ESMTPSA id s4sm7191140ejf.108.2021.04.04.13.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 13:35:03 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v14 0/9] Add support for ipq8064 tsens
Date:   Sun,  4 Apr 2021 16:48:14 +0200
Message-Id: <20210404144823.31867-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
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

v14:
* Fix warning reported by Dan Carpenter
v13:
* Simple reword
v12:
* Even more fix reported by Thara
v11:
* Address comments from Thara (thx)
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

Ansuel Smith (9):
  drivers: thermal: tsens: Add VER_0 tsens version
  drivers: thermal: tsens: Don't hardcode sensor slope
  drivers: thermal: tsens: Convert msm8960 to reg_field
  drivers: thermal: tsens: Use init_common for msm8960
  drivers: thermal: tsens: Fix bug in sensor enable for msm8960
  drivers: thermal: tsens: Replace custom 8960 apis with generic apis
  drivers: thermal: tsens: Drop unused define for msm8960
  drivers: thermal: tsens: Add support for ipq8064-tsens
  dt-bindings: thermal: tsens: Document ipq8064 bindings

 .../bindings/thermal/qcom-tsens.yaml          |  56 ++++-
 drivers/thermal/qcom/tsens-8960.c             | 233 +++++++++---------
 drivers/thermal/qcom/tsens.c                  | 156 +++++++++---
 drivers/thermal/qcom/tsens.h                  |   4 +-
 4 files changed, 292 insertions(+), 157 deletions(-)

-- 
2.30.2

