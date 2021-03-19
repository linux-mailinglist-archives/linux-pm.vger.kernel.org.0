Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FCB342442
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 19:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhCSSPz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 14:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhCSSPY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 14:15:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F087FC06174A;
        Fri, 19 Mar 2021 11:15:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kt15so1722923ejb.12;
        Fri, 19 Mar 2021 11:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rvQymSNd4Qb5Mspdq6AbsSN2FgRpnhG4suLtnPG+1m4=;
        b=d4JxVeLrmEBGRFeGyhtAp6uPjMAnSUwpwax/8enyfl3OyGoFWnfJncHnYz3WrIH/fU
         MHv60DTc/yt5ZAMVy3ykb7XiORYadjPFgx8XFVDuQ30Rg7X1JNc6BzDWZlUcHIFkQidq
         DYheeQMbnnpPkH9ZaWea2d/ytSiSzBMLwvVEGV4a8dYGJiRNxW5jEg9NHFkQLduMAGGX
         c6OeIfgSz/uR/rypO0qkHElM05Z25mJ80+N3Gus9e76JH0QCFPYtzOY5/GnkP88hsc29
         cFPzdiw1RR/RrKmMzGc9Q9r1YwzQlZCKwx7lcG3ddGs/JGco1IbzJ5PtGQYOhHb8Eb1C
         Nl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rvQymSNd4Qb5Mspdq6AbsSN2FgRpnhG4suLtnPG+1m4=;
        b=V+CmxUe3YvT1Y1Bc8NmabkWOW6O5L1pj4+pc9s731yBwUUpmdhqd2p7KTuyFXXfNni
         4lsod0vYYGIsaFY1+oar0MtJISHEtiUanlqJRhxfhDTAGzKZxpvJSTNLPgNsFSPUmYw7
         Xgwyd54KNIbXEgM9yEYHfwEb6LUll1AbNe2PEmyj3qrEtpF3EWa2Vy5+6NKVKA7Qjlji
         jswBfcZES8r71nXouaGNgWjX1SHech3m3niOVFsb2WXRyFLCJRohDkWdy5mD9Uoq4RcB
         /3zqoGLvh543Rg9jZBsX0Arwekrh09d69oaGKF+Vws5+4UPWCy0C6CbPBuPpB3I1iPGe
         IT4w==
X-Gm-Message-State: AOAM531aOocg+RaOvXj7Z6l5/TjBOtoShKjemKYmE0kYe+lz5v6kRIUU
        AEJFihWKSBwtqijxnNv1I4s=
X-Google-Smtp-Source: ABdhPJwJ495ExjLJcBYIIWkyG+zDpXH0U8XmQG+Cvu73mmGzQyhvqvdAV9Kk/p2S7KBDh5mEMTewfA==
X-Received: by 2002:a17:906:3496:: with SMTP id g22mr6030771ejb.143.1616177722597;
        Fri, 19 Mar 2021 11:15:22 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.googlemail.com with ESMTPSA id u13sm4170288ejn.59.2021.03.19.11.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:15:21 -0700 (PDT)
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
Subject: [PATCH v12 0/9] Add support for ipq8064 tsens
Date:   Fri, 19 Mar 2021 19:15:03 +0100
Message-Id: <20210319181512.7757-1-ansuelsmth@gmail.com>
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

