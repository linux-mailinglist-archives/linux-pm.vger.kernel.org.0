Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DA3244ABC
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 15:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgHNNmJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Aug 2020 09:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgHNNmE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2020 09:42:04 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC02C061384;
        Fri, 14 Aug 2020 06:42:03 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so9969627eje.7;
        Fri, 14 Aug 2020 06:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7cQQ4WDJLZ/zyyhzDTf2NVjGL+CUR2rrNdCZgGLo0+Y=;
        b=Fnog6K1MdRWWZtiu+ypFiEBOhpVW3EW05Ey5nakDXOk8IAy1f0MCrPzJZuIicFAPcY
         MACz7l0yLcDjDVizhVO21w0pApYX7bfckrzaUn1vMxqP701Ubo0Bc3gMcLDRmEn3G2m/
         4ZytHNfqyvZQVEhYiQMmrMbP7YE70dtGemCcsMUgrlJ3dhlyKIudAEqJc+OM4xTVFMhw
         GOHYkt4Cle7ZWk9waEgvhj6Gbh9EYOSDrYMGFhr3viRptAGiTp+pIJXuhAXE7A2PVgGe
         bRr6sjqeEJXL4JZqFGD2m490RmEqGZYJbZ61qstdpQBxXgiWtkBozzrxbx+ky8ngWb+f
         dSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7cQQ4WDJLZ/zyyhzDTf2NVjGL+CUR2rrNdCZgGLo0+Y=;
        b=IRFrs2qsv0wLHXpdxhsejCWfCCQTz6dIYrVNb1ZoU1LbfguLWIOpzKLgF3SVBNlO+c
         GTBNtfggEjQGQr+vHsJ6nj0pQTyCq8aMdMV6HPkwNEwlu8KJBOJz80M7HXcH/RTpChLi
         sIop98OVgYQVPuptuSJqd7j25NbaM25UyaxOQEbuzqke05Ijm/9SvXW9JzEevlYaX+ct
         A+Eyt+L/vAqc2Ph12uDClWhW9IDA8FI4RRWXyPH7oMlOUbjUm3Nb0tx9XR307VJPo+Wt
         Gq81iN8mx6Q7nXaFKUzirPqN8TEz8E8g4yqM3jK6yp34G9CjXBfS9KCZiAZkFFEksszF
         ypng==
X-Gm-Message-State: AOAM532yUtXozgGH9JOWa9B5J2xlVf2kkMgOFlOxVQh1Pq/Tp//1lA+n
        s5PSmInR20Gu4UDToo9IoV0=
X-Google-Smtp-Source: ABdhPJwmx7QSSyTVXTxqs3pecv1pGcO68Xfu47xoxRvm+0c6cpjsx3ArTyeaxJ2TKDBQiKwMYroClA==
X-Received: by 2002:a17:906:ca5a:: with SMTP id jx26mr2348450ejb.62.1597412522437;
        Fri, 14 Aug 2020 06:42:02 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-0-192-118.retail.telecomitalia.it. [87.0.192.118])
        by smtp.googlemail.com with ESMTPSA id s2sm6767118ejd.17.2020.08.14.06.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 06:42:01 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v6 0/8]  Add support for ipq8064 tsens
Date:   Fri, 14 Aug 2020 15:41:14 +0200
Message-Id: <20200814134123.14566-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
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
  drivers: thermal: tsens: use get_temp for tsens_valid
  drivers: thermal: tsens: Add VER_0 tsens version
  drivers: thermal: tsens: Convert msm8960 to reg_field
  drivers: thermal: tsens: Use init_common for msm8960
  drivers: thermal: tsens: Fix wrong get_temp for msm8960
  drivers: thermal: tsens: Change calib_backup name for msm8960
  drivers: thermal: tsens: Add support for ipq8064-tsens
  dt-bindings: thermal: tsens: Document ipq8064 bindings

 .../bindings/thermal/qcom-tsens.yaml          |  50 ++++-
 drivers/thermal/qcom/tsens-8960.c             | 172 +++++++++++-------
 drivers/thermal/qcom/tsens.c                  | 130 +++++++++++--
 drivers/thermal/qcom/tsens.h                  |   7 +-
 4 files changed, 270 insertions(+), 89 deletions(-)

-- 
2.27.0

