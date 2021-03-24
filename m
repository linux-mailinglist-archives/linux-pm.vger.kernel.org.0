Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468F53483F6
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 22:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbhCXVoh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 17:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbhCXVoJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 17:44:09 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A804C06174A;
        Wed, 24 Mar 2021 14:44:09 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h13so136164eds.5;
        Wed, 24 Mar 2021 14:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KI09jULnQMxaDNbbeoqVbnTxCI/Lhru0LQ39tpImnP0=;
        b=CU7x5ACG0Fur0j7uy6ARJ9w2zKxQ2oLjEej3RjBEe7non01RIKqzw87JYDBGYKC2yd
         aslZ+HjxBLZvr5Oir/SUhZE3Rb1Z+FIxqYo3p/BGjAmWh8IVU1T59RWeg3gRS3FXaOxN
         JHa8t236bFKL3o2Ae+9eZjbQoJzPTtxa6exME1xI6+OswLio6sGB+Jd5ZF+h/4/LTlgK
         TjIqoPeEqC06tQHEuK4gXBbUYxrQr5e9z7ly5nUaJm52/18dr5H+BJ/6zLLhQp7HGZk6
         3T/MTfajZ0Q2l71Ild13h4Uk2cCQgpT+U/mYOhRHgH1K8Gjamd5mGSogwzDWT7O42Cyj
         mDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KI09jULnQMxaDNbbeoqVbnTxCI/Lhru0LQ39tpImnP0=;
        b=MmHPmBqcn/SiyKu6DYaNNBe1lGBTxJaek1ZRvC3JiWUoGoHV9kzz3Ih2Ag+xvI+zZd
         2GJg72DFjlOvhzahMw0Bv1brOQVjyoO0dMCI4oTb42nhck9VEgZb8CPBXSUMrcMnYwg8
         4xfIsZJp4LzVZ40kgJegRfcyx70gT+pbrnUxcBfsKlD4yJFxifB9q7BPDVXjvcgu/qOd
         hsI13mXzjDJGl1AZXUYB3nMIHeqoljHryDjGS6vKUOqsFEcO173fbmx+VQqhnQDIDk9O
         8ceVRmvVhErezNlgNblQ9dWX9hQbDZwiqExKYfijfEvbP6c/OByOc5lgxVbIT/2Z/OKb
         cQDA==
X-Gm-Message-State: AOAM531srDi5AznYifF++FcK4zIhM3D+gt0dTdo8cfqU137HRZorDz3l
        j/zggjzfF7r4JD2iSn6dWC4=
X-Google-Smtp-Source: ABdhPJwQuyvl4aKf5lRW29xfAg47tf4LewQt7l31YnZ3S+t9XkF42yFQtrGxSfDiyUNz8GpTkwoWWA==
X-Received: by 2002:a05:6402:12d5:: with SMTP id k21mr5773832edx.318.1616622247551;
        Wed, 24 Mar 2021 14:44:07 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.googlemail.com with ESMTPSA id z9sm1871211edr.75.2021.03.24.14.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:44:06 -0700 (PDT)
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
Subject: [PATCH v13 0/9] Add support for ipq8064 tsens
Date:   Wed, 24 Mar 2021 22:43:54 +0100
Message-Id: <20210324214404.798-1-ansuelsmth@gmail.com>
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
 drivers/thermal/qcom/tsens.c                  | 151 +++++++++---
 drivers/thermal/qcom/tsens.h                  |   4 +-
 4 files changed, 288 insertions(+), 156 deletions(-)

-- 
2.30.2

