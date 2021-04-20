Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99439365F52
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 20:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhDTSef (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 14:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhDTSef (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 14:34:35 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D195C06174A;
        Tue, 20 Apr 2021 11:34:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id k17so6790078edr.7;
        Tue, 20 Apr 2021 11:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ud/6nSIADQgMKFdabHKRuxpt1Sau0GLHCd2R3Rgi9YE=;
        b=bPWP+3ZvPg7ZAPNIUrM0PjfoMkB9Y0bUv9jUN1M8740heuI5kMokhH5nnFi0v9EhZA
         QVZKG6wgbN6m3jWeTn6QvXmfhC1IdXJ82z7tUnq+NPAGeT6HuHhHAJ3LSPp2cTU/zFZL
         hL/cNupO87WjPFRutzdICBe4RFKGjLY3+4zY6V4mEFsPxgoLULTCs16HByELRUmGCccT
         5CMRAO0kmX3QaRlujORxqKrLXuOgs68shxigeEGZ3hXqLVSKPEqSTGMXcWaqiROBdg8M
         pld3ITU2iPgqA4QxWt1+Y6IEA44RSF1fdJgOchc9C9DWyjutt0thIaE6pOkmob/7oG0Z
         GwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ud/6nSIADQgMKFdabHKRuxpt1Sau0GLHCd2R3Rgi9YE=;
        b=QJuWTd8ckm6VMeltayVnce3zCjzElRwbbueAE2qENaiF7s7PVgEjU8ZH8k06mdSb6u
         +syv4X09I8HKbt1qgZehTwnPZOp5hgiXkXR/8bGIXmyG0xBsAP0rVkuxC06BIrn81se6
         VXwZq81KJVu6ThbinT2NbueboLLZYgQxmZLXt2G0wFjsIgrzOQBvZ1D3yJdUSeiAwabx
         U7vTWnppioaQ/FziINV++HwVyloqHnEFw6gttGV+WWzpVDUmqnNwKMdgY9CnNL/3kcRG
         YJOYfXSIpK9VyfYuThUqzf08AzTIW8gawkM2RVhfH5E1ObRRS9Zl71vD09OaRIZXhRkG
         ia/Q==
X-Gm-Message-State: AOAM532KMuQIdKUcW95NGJx/zy4GaXfqQ9jzi1j/586WUnYgnvVzAAYr
        lVgBb75s2awhOAqpxiPdToeX6ixq4z+lRg==
X-Google-Smtp-Source: ABdhPJxhZ1DrtIpGJ+PZfKA2B8kcWuAnGmU6GpUP0v0W0NLIFD32fD35qcfp3T5XZXP4jY7MrWPy1A==
X-Received: by 2002:a05:6402:51d0:: with SMTP id r16mr30518669edd.52.1618943640016;
        Tue, 20 Apr 2021 11:34:00 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id n10sm13357141ejg.124.2021.04.20.11.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 11:33:59 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [thermal PATCH v15 0/9] Add support for ipq8064 tsens
Date:   Tue, 20 Apr 2021 20:33:34 +0200
Message-Id: <20210420183343.2272-1-ansuelsmth@gmail.com>
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

This series has already been approved but the "kernel test robot" reported
some bisect error.

v15:
* Fix bisect error reported by bot (add feat define in the VER_0 patch)
* Fix static slope table (offset -350 instead of -200 to have a more accurate temp)
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
  drivers: thermal: tsens: Don't hardcode sensor slope
  drivers: thermal: tsens: Convert msm8960 to reg_field
  drivers: thermal: tsens: Add VER_0 tsens version
  drivers: thermal: tsens: Use init_common for msm8960
  drivers: thermal: tsens: Fix bug in sensor enable for msm8960
  drivers: thermal: tsens: Replace custom 8960 apis with generic apis
  drivers: thermal: tsens: Drop unused define for msm8960
  drivers: thermal: tsens: Add support for ipq8064-tsens
  dt-bindings: thermal: tsens: Document ipq8064 bindings

 .../bindings/thermal/qcom-tsens.yaml          |  56 ++++-
 drivers/thermal/qcom/tsens-8960.c             | 235 +++++++++---------
 drivers/thermal/qcom/tsens.c                  | 156 +++++++++---
 drivers/thermal/qcom/tsens.h                  |   4 +-
 4 files changed, 293 insertions(+), 158 deletions(-)

-- 
2.30.2

