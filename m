Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDD02FF42E
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 20:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbhAUTTD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 14:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAUTRC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 14:17:02 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A07C06174A;
        Thu, 21 Jan 2021 11:16:22 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id c132so1995838pga.3;
        Thu, 21 Jan 2021 11:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vyPUGE/jDluUMDwQB9kTEzv7e1ObGuQgvPfavYX545g=;
        b=a8sLi5GOPnGD6SJXctyPqQWuN8VPI9qBuCaEt/d6bZdOvjVPzTe5+w9gQmD60Jot8n
         uGdJBtvReuGDDqenN68MCP/ZrgHzXWELIkNbb6OkHuTC7QhGHj3vw5GO0eC2AWHl/VbF
         DeitB+ESEKwVVID5h7YxjFKRlhN8Vxpi5ARoxACHiqVmDHv5/pKndkF9WGTTbhaApJB/
         BHK7nIIlwzP7y0yaneBUEiS41J8K//baqdrXqBQbiKNjXgUKoA1GRb6qR+VnGKkM3cmK
         PjJ2wN2evoQUJ4dF8cG6XgdiFE1PZ2tOXpHSzVCCoXIhtLANRiTe+tbrWvsLITOU0fAB
         lYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vyPUGE/jDluUMDwQB9kTEzv7e1ObGuQgvPfavYX545g=;
        b=rl+tGVIQAI+fO52BWyf6iNtqzFYthgxCXzPdHJIZRnPp8L+RECxaXtJ+NiMAjoS9H2
         /ldHGu6tw6hoxj3z1UZdgqfGhxG/EMCXCn9bGt7l0BZV9QKk0yV4IMJodYx9e8lgvwEz
         NeD7FXwAHVWaKJ8bd3u0uDcwm1HCOyZFrCAFAs0jp+g/Zdb+MGrfAG1cGT9NO500J8wP
         L8ro0bgv7N0k9+9T5nNAsfnM9uW59MP3Iu7P0wo9IqUxtj3mqAcFVBwRb6HTg9/+PqKU
         cPpBEEgEVgFiqF5gBepzNsWrVpedz74stAdypFeBwtD9PFjC3Gt5daWijT6oqac/15ua
         x8hg==
X-Gm-Message-State: AOAM5314kIxYgzt4zloOzc3xZgsLkucFVG3wVyTTGLJMlQ0OyAeAiP0t
        aoTc4d1w2tge4gLBPKDGSGA=
X-Google-Smtp-Source: ABdhPJzM45jpZM3EhD0U26mloVLuAHBTwJ5vfTv3KU6HhTvmiA+9fmFyPT5uX+vk4reqKe+5gqzDFg==
X-Received: by 2002:a63:d246:: with SMTP id t6mr743446pgi.283.1611256582215;
        Thu, 21 Jan 2021 11:16:22 -0800 (PST)
Received: from ansuel-xps20.localdomain (host-79-41-39-5.retail.telecomitalia.it. [79.41.39.5])
        by smtp.googlemail.com with ESMTPSA id gg6sm11291013pjb.2.2021.01.21.11.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 11:16:21 -0800 (PST)
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
Subject: [PATCH v8 0/8] Add support for ipq8064 tsens
Date:   Thu, 21 Jan 2021 20:15:52 +0100
Message-Id: <20210121191601.14403-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
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

V8:
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

 .../bindings/thermal/qcom-tsens.yaml          |  75 ++++++-
 drivers/thermal/qcom/tsens-8960.c             | 203 ++++++++++--------
 drivers/thermal/qcom/tsens.c                  | 177 ++++++++++++---
 drivers/thermal/qcom/tsens.h                  |   4 +-
 4 files changed, 327 insertions(+), 132 deletions(-)

-- 
2.29.2

