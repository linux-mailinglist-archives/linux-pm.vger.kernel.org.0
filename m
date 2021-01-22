Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E966F30065B
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 16:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbhAVO54 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 09:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbhAVO4s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 09:56:48 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65616C061786;
        Fri, 22 Jan 2021 06:56:07 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m4so5356419wrx.9;
        Fri, 22 Jan 2021 06:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IeU9N1+PvJFQlir86x5mSJncGP+EaY71IhjDM6vbRwo=;
        b=nK0bCyISuNsAizA8Ye+PBkal6kg8DM0D7jwL45N0h8443BeeVgk6Dq1743Fr3OLE7Q
         0bprRW4uEJVAEumWgTJLgGkbCPnwKvj+Fr3KDUcf7CI3wDnv+7GSZJLL+FL/fvCehymY
         zHK+p9IYZGFGJXfsinQM/OIdanSCVzC4dgPP0J1lD/KIYNfKSLMuoidzZuE/MR56IiQQ
         4IrJHcMm4DqQiPgJjOObJM46uL9v317ymj1Apuhy70g1lah2h75fo22MYFnQc4Mx8KLY
         zG5RUizIcDKg0s6b3eKy1FZJ7svKonIsTNs85haGie8FTrdhOIBseUlnOI39SCkAkDQq
         +zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IeU9N1+PvJFQlir86x5mSJncGP+EaY71IhjDM6vbRwo=;
        b=mYeLevKsnjPn1Iznw7K1KifLJ/5B5rykH4g86vTbXK8R2U8QtANKBjM3b9r81kr1Br
         roEs2tc9iMligO6ReacYBwRZ2505Re5qNApnJ+O88iLEalX5EgC+tkGGlmJm6KAg2yAv
         XtJ10UiXTAgdZzY5QSNoA+Kx60yXVkSykto4aLtQA03IzVIt8YhdtqnS8+8GI40GTQxK
         r81TX6qcG0eLouz8ErtZI6Lu7IQo44cVl5rDPEE0ET8Ae7/riBnv3bd1f3oWp0VpsmFm
         zlYy8xQvs/36ZqqACwVhvoxiMyeLDhgJxVw9AI7SioPDQ/v+jhZNFGVrDZf+wjX1CIo6
         hf0g==
X-Gm-Message-State: AOAM530mAT8mTzuqTCxpaKnn42FMFDdpDUA/+IEF95XGKR8M762KKwLn
        A0c0d8qzpvOIHIH025+cWpHL7bK+Mxs=
X-Google-Smtp-Source: ABdhPJwvczQy5sNoFJbMQterwF3P6HgWIYjGzyPF4MQILDGYkQU7+0S/BWcdJydrOJsgOpjcSsMyEA==
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr4849360wrj.325.1611327366018;
        Fri, 22 Jan 2021 06:56:06 -0800 (PST)
Received: from ansuel-xps20.localdomain (host-79-45-3-77.retail.telecomitalia.it. [79.45.3.77])
        by smtp.googlemail.com with ESMTPSA id t67sm12061106wmt.28.2021.01.22.06.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:56:05 -0800 (PST)
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
Subject: [PATCH v9 0/8] Add support for ipq8064 tsens
Date:   Fri, 22 Jan 2021 15:55:49 +0100
Message-Id: <20210122145558.4982-1-ansuelsmth@gmail.com>
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
 drivers/thermal/qcom/tsens.c                  | 177 ++++++++++++---
 drivers/thermal/qcom/tsens.h                  |   4 +-
 4 files changed, 310 insertions(+), 130 deletions(-)

-- 
2.29.2

