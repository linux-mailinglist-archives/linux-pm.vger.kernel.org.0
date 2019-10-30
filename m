Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0EEE9E99
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 16:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfJ3PO5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 11:14:57 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:47949 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfJ3PO4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 11:14:56 -0400
Received: by mail-vk1-f201.google.com with SMTP id h186so1038897vkg.14
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=I6jD1WRmo86OM3bsIakAOe6JbGStvpAqVOoE2BT6rcU=;
        b=Wk6g1uSOgxeYU9rbcErk6qD765qn6dLXwOR9Sy+xNuM+iSx5iBdg5gG2x3a++IBKQb
         84T0d4ucZUMKle4HVIWjA7+kM7liZ+jdSvu5S72G9nLnxC8+IfznBaDiBXd5jfrDbi+V
         GXsmqRHSNni4QTUgb/R1L7M9JJmll/eHRXNOw74/u040fGpS1lY951aQgcwc0xnMV2g9
         KEWuO4+yEdntOCRBrpfM+FlwKXSpi0NsEn1eWPeDnvlTNVkyzpco0VbnwYsrFdOioqp5
         HW5OIhZEVuWMjaDh8dXwKyp/VxgS4svDjrtiFCWiyBDbce+eDtOgoBsIWbRTjaJMsqJo
         fD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=I6jD1WRmo86OM3bsIakAOe6JbGStvpAqVOoE2BT6rcU=;
        b=rHYc/cjaLad+0MVmed87NE9QeMJLftYsyxtSrq0KDsAatbf3FHngzFCxygc1du8Bwp
         KjRDNphkCL7NuSimsXWfJErHKZrYCvISfPuO97tpI1YINyFo7/lUtODm6fhsN8qS8Dwk
         jUuwcP24pZPxh9Agnl3atnwJ8OjhXc6ena/Aj/gl6Qpa5H20+ZW2IBlOuNHzSOgTCWTv
         892twiIfgMYboKp8MKDhrfiS/BPUP7jxTuX8PN4lU7dYav8ii7xUVEwS/FZi0R7NorSS
         I/4SbJEWoGxYbuL8y8vVgOLk5+5ys0Uaui5fHUd5XBslWO3k9IczsYuhAHbc2OmiXbUo
         +JkQ==
X-Gm-Message-State: APjAAAXWlY7qPFVdQa2iZn5yeIVrXfSsQZ7TYuesxiW7amh8l8CE5h8G
        EqDVvjvJsNNOQ5umsSxNp3ZtdGW6LGda
X-Google-Smtp-Source: APXvYqzVXv3phZKJ6kK18tzuCBHmUvTKTyupg+8nDEpD/+f+55XCt8xAN1D0dRe2E3jxVYD4dOA87TGf/mZD
X-Received: by 2002:a67:fe86:: with SMTP id b6mr5198734vsr.162.1572448494253;
 Wed, 30 Oct 2019 08:14:54 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:14:47 +0000
Message-Id: <20191030151451.7961-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v9 0/4] Make IPA use PM_EM
From:   Quentin Perret <qperret@google.com>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, daniel.lezcano@linaro.org
Cc:     dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This removes the IPA-specific energy model code in favor of PM_EM which
does the same thing in a generic way. For more details, please read the
cover letter of the v7:

https://lore.kernel.org/lkml/20190812084235.21440-1-quentin.perret@arm.com/

Changes in v9:
 - Rebased on 5.4-rc5 and fixed conflicts with pm_qos changes

Changes in v8:
 - Fixed checkpatch errors (Rui)

Changes in v7
 - Added patch 02/04 to fix the build error reported by the kbuild bot

Changes in v6
 - Added Daniel's and Viresh's Acked-by to all patches

Changes in v5:
 - Changed patch 02 to guard IPA-specific code in cpu_cooling.c with
   appropriate ifdefery (Daniel)
 - Rebased on 5.2-rc2

Changes in v4:
 - Added Viresh's Acked-by to all 3 patches
 - Improved commit message of patch 3/3 to explain how it has no
   functional impact on existing users (Eduardo)

Changes in v3:
 - Changed warning message for unordered tables to something more
   explicit (Viresh)
 - Changed WARN() into a pr_err() for consistency

Changes in v2:
 - Fixed patch 01/03 to actually enable CONFIG_ENERGY_MODEL
 - Added "depends on ENERGY_MODEL" to IPA (Daniel)
 - Added check to bail out if the freq table is unsorted (Viresh)

Quentin Perret (4):
  arm64: defconfig: Enable CONFIG_ENERGY_MODEL
  PM / EM: Declare EM data types unconditionally
  thermal: cpu_cooling: Make the power-related code depend on IPA
  thermal: cpu_cooling: Migrate to using the EM framework

 arch/arm64/configs/defconfig  |   1 +
 drivers/thermal/Kconfig       |   1 +
 drivers/thermal/cpu_cooling.c | 404 ++++++++++++++--------------------
 include/linux/energy_model.h  |   3 +-
 4 files changed, 167 insertions(+), 242 deletions(-)

-- 
2.24.0.rc0.303.g954a862665-goog

