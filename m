Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E924DB9F7
	for <lists+linux-pm@lfdr.de>; Wed, 16 Mar 2022 22:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358137AbiCPVLt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Mar 2022 17:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358094AbiCPVLo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2022 17:11:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6140E48E77
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2022 14:10:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b8so3217305pjb.4
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2022 14:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=A6cOxdUaG1A86kAtWaCIf07+aXGBjHiOUH8wcQkHkjE=;
        b=TjOnIiyszh7cP5J8N0RqNG9sx+4l3KYhzHYTAvRuldydNoM5hA7bqJDoN0u8cG8lPS
         xmPxH2lwD4DW466GeuWuezsrVQjQnMuCdy1P3dATg2yFshWYKPLFNwjWH2C0T2z/pO4L
         +F7zv//JFDverjj7xHns6RBHNrf5JIsvbkMMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A6cOxdUaG1A86kAtWaCIf07+aXGBjHiOUH8wcQkHkjE=;
        b=sAzybachj11ZQuyOrQckrnQ/s1oJasOMOzaIbedYpfzj5BkKf3baEuC65ZM+s6EXqP
         P83Hw/ua/X9WvjS92pZJx6bMXlcQwDt9WFqjE92bSYfiXyqoVQAmUDvuJ3Hpl7/faE5b
         WUc8hOptq5JbiCGj3oTLhDeMgfsDvuoDUMvEDOv14lY/2PAfx9maWlE6lTt9e5E6m3At
         FQ8/Tk10iJyvc2sDArXIqV8XJzAd8BkeDzs1vewy7Q6hL0VBn5w+rPHDlXxGgy3uLN1q
         /OUQie6X7TTo2nQTAaCluSWvNJjiMg/nMWgjZSeMYetNa/jMGt7kRwWFRDN8hW4pKUwF
         rluQ==
X-Gm-Message-State: AOAM530MVMWM4xctEOkBqew4AssVJ831nArPbA8CfAcMF3XKdwNr6PXO
        ixB06D9DexmSKVExWDF83ZVQDg==
X-Google-Smtp-Source: ABdhPJzb5vzfkKFyarFdtMtfUhu+EIlpoWuPTm+nXYoeixxrBzfHa8F64Rja2IagUyaJIoRZgNy+TQ==
X-Received: by 2002:a17:902:bd89:b0:14d:93b4:71a9 with SMTP id q9-20020a170902bd8900b0014d93b471a9mr1505304pls.98.1647465024771;
        Wed, 16 Mar 2022 14:10:24 -0700 (PDT)
Received: from localhost ([135.84.132.250])
        by smtp.gmail.com with ESMTPSA id u10-20020a63b54a000000b00380ea901cd2sm3341246pgo.6.2022.03.16.14.10.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Mar 2022 14:10:23 -0700 (PDT)
From:   Benjamin Li <benl@squareup.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zac Crosby <zac@squareup.com>, Benjamin Li <benl@squareup.com>,
        Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] thermal: thermal_of: pass-through change_mode & implement for tsens
Date:   Wed, 16 Mar 2022 14:09:43 -0700
Message-Id: <20220316210946.6935-1-benl@squareup.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Plumb through the change_mode callback from thermal core into thermal_of,
and implement change_mode for the Qualcomm tsens driver.

Supersedes "[PATCH v3] drivers: thermal: tsens: respect thermal_device_mode
in threshold irq reporting". Changelog for that patchset:

Changes in v3:
- Upgraded logging to dev_info_ratelimited and revised log message.
- Remove unrelated hunk.

Some drivers that support thermal zone disabling implement a set_mode
operation and simply disable the sensor or the relevant IRQ(s), so they
actually don't log anything when zones are disabled. These drivers are
imx_thermal.c, intel_quark_dts_thermal.c, and int3400_thermal.c.

For tsens.c, implementing a change_mode would require migrating the driver
from devm_thermal_zone_of_sensor_register to thermal_zone_device_register
(or updating thermal_of.c to add a change_mode operation in thermal_zone_
of_device_ops).

stm_thermal.c seems to use this patch's model of not disabling IRQs when
the zone is disabled (they still perform the thermal_zone_device_update
upon IRQ, but return -EAGAIN from their get_temp).

Changes in v2:
- Reordered sentences in first part of commit message to make sense.

Benjamin Li (2):
  thermal: thermal_of: add pass-through change_mode to ops struct
  drivers: thermal: tsens: implement change_mode to disable sensor IRQs

 drivers/thermal/qcom/tsens.c | 43 ++++++++++++++++++++++++++++++++++--
 drivers/thermal/qcom/tsens.h |  4 ++++
 drivers/thermal/thermal_of.c | 14 ++++++++++++
 include/linux/thermal.h      |  2 ++
 4 files changed, 61 insertions(+), 2 deletions(-)

-- 
2.17.1

