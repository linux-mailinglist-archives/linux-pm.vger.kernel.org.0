Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8733411AA
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 01:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhCSAxG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 20:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbhCSAwr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 20:52:47 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAEAC06174A;
        Thu, 18 Mar 2021 17:52:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id j3so8838596edp.11;
        Thu, 18 Mar 2021 17:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vSbdzBp7qOJIsf9v7dF7qtnitXojs7RoT+m6oFwc0qg=;
        b=NmXYQDiol55pb8/xBBoCGdenFhEPmJHEGf1MSUeSS3YdbHtZCkyAVNvX2pzGcRgmSw
         CzUvu//Zz2cBLEz1tB3hksGgqy5VInvszgtMksh592ZWcnHJuc3CcGjuL7BX5jWx2IL5
         SOc9VhmeFa/94oRUs0nLHKolQjW+P4Y0hzPpTxiD49TY0xU4OiTBOFX3buMftqxSwJDI
         Xwo9VLz8U+v9KhppFT+O6D02bFmuHOSQA/Q2jyOxkZ/203bIvOZhdjJ230Kd+Lf15kc4
         FQFr1YLWXCAAx9ynSkSfqZGht2CAxL1KgQ2iaQ/W886Px5dCjxz6BgAB931N2vsewGJn
         zErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vSbdzBp7qOJIsf9v7dF7qtnitXojs7RoT+m6oFwc0qg=;
        b=XG+qgqBI7sz7QmLzEkyKQG5veUsvHka05OLJmBgnjC+f5wXTKk7qmEXRfsi0InnZLZ
         IHQxgWAjje3vajYzId6O4xsqDKh4/vwW2i/Fuv1Si9ZWMfWlpJ25eqQpAHm8Y6ejAhYH
         kVUP7xOyHluRYxQN6n9U5F+FmfokNw3Bkw5jsYh3M0OJj8XPUa0MvpabZVrS8sURCquW
         UU3ownu1gP97+WoBso71Unyd+IK9wJQXhGOlpLEIL/h1E9Oih/pKn5Mz7te9oiPvETvK
         r5U6X821Z5o7QEftHsSeJYaPn4xPghPWzciYq15tZ0MtChg3K5sLmEFti6vkD34ZDcAG
         ADVg==
X-Gm-Message-State: AOAM531FD4LS3Z3NAi8XY1OjlmHYFYRZx7x1lQb77xFy2Tt148U7FDf2
        JMMGqHXBMTIlIfjKLY68Q3s=
X-Google-Smtp-Source: ABdhPJzArXZJP1cj+GNfpR7aCTEj/VrLxGO10ck8oCCRJNYY7Q75fv7kXS47NPwWlk1UfT8c53cmKA==
X-Received: by 2002:aa7:c398:: with SMTP id k24mr6815686edq.61.1616115163091;
        Thu, 18 Mar 2021 17:52:43 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-95-233-52-6.retail.telecomitalia.it. [95.233.52.6])
        by smtp.googlemail.com with ESMTPSA id q25sm3186976edt.51.2021.03.18.17.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 17:52:42 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 0/9] Add support for ipq8064 tsens
Date:   Fri, 19 Mar 2021 01:52:18 +0100
Message-Id: <20210319005228.1250-1-ansuelsmth@gmail.com>
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
 drivers/thermal/qcom/tsens-8960.c             | 234 +++++++++---------
 drivers/thermal/qcom/tsens.c                  | 147 ++++++++---
 drivers/thermal/qcom/tsens.h                  |   4 +-
 4 files changed, 285 insertions(+), 156 deletions(-)

-- 
2.30.2

