Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7FD40F32F
	for <lists+linux-pm@lfdr.de>; Fri, 17 Sep 2021 09:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbhIQH1H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Sep 2021 03:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbhIQH1G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Sep 2021 03:27:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EADC061764
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 00:25:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q11so13541362wrr.9
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 00:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y4d5OAb4cgWF2zYKyVkgoZXkk7R3WAwmBlyHddfAZBk=;
        b=0PXYxtvF3gigYifimzVnGXkU5t9bm+Nz7pn5cAnGnjUQXZkEZGT5njvCmyFo6jtYON
         fEuF28Yzj+sngIuI7/DpAHcGLnYRhk2i1FMaNIn2OpJIEq95LbgKkIAhimn2THuFckC3
         snrvoq5gOpNIVpsaqGlipeSapbgh3tAUnod+ZVtezDIunpfuOYRUN+IO/aJKoqfCwnBk
         vbc9+OXBW0uq+6TqQ7+TWnRB5ekawkiUfrnyQ8ByaP7tU2THCFnQ6xOmcQX//0xi4Yer
         DnEQE0Vi66JWgy4Oa2Uc9luE06afkFKPSR4uxWSwVQSBwH7iE0ZLdnL054MsJo9Qnx76
         H/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y4d5OAb4cgWF2zYKyVkgoZXkk7R3WAwmBlyHddfAZBk=;
        b=EZ6iawNXtnZLHMqbcZKwyULAntXsxci9YooaM6qROCtbKYOgBIhaqtTJ3ZBmV4bEo5
         fklDfKraRP3UYJacKGjkbhlxVR5rsgrp9ehB4tE75lHa4YLWkZF1rdaNSAiW2DbwOfn5
         lEXwRRJ1SKlHGZRGgZQ+hXwEJXz//VFf+hDL1agQZYaKT+cQvOdTsrMaIweImmSI6rTD
         dMijDWEjbha+mHh4FZHU0aWZDxVLn5utMeNPdvu7nSG+IMGxwSz3zTHr24YVUkJAzDls
         CRBZQu8a+2bO62nakKNElUqmn8Sks5Vz9SQE7RjDXfcCNZGzcNLVAHY9rqRtKasW6Hnn
         e/hA==
X-Gm-Message-State: AOAM530NZL9DkOoRerHyVS/N7dTX/Uf4Oe2wODijtxGvcQCfWfslXl7E
        4Of62kS/bpTYrd5H6eHAYHGZbQ==
X-Google-Smtp-Source: ABdhPJyxlLSj2pj4ulF02mNqOXuSeO9zYOOxqIKrs7UIgmUXfXoCjT/ukJuSl3nb+TbyqV67OT7Gsg==
X-Received: by 2002:a5d:4f06:: with SMTP id c6mr10264482wru.384.1631863543196;
        Fri, 17 Sep 2021 00:25:43 -0700 (PDT)
Received: from localhost.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z19sm11777565wma.0.2021.09.17.00.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:25:42 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v2 0/2]  Add a generic virtual thermal sensor
Date:   Fri, 17 Sep 2021 09:27:30 +0200
Message-Id: <20210917072732.611140-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series add a virtual thermal sensor.
It could be used to get a temperature using some thermal sensors.
Currently, the supported operations are max, min and avg.
The virtual sensor could be easily extended to support others operations.

Note:
Currently, thermal drivers must explicitly register their sensors to make them
available to the virtual sensor.
This doesn't seem a good solution to me and I think it would be preferable to
update the framework to register the list of each available sensors.

Changes in v2:
- Fix some warnings / errors reported by kernel test robot
- rename some struct and functions with a more accurate name
- update the dt bindings: rename type attribute to aggregation-function
- factorize a little bit the aggregation functions

Alexandre Bailon (2):
  dt-bindings: Add bindings for the virtual thermal sensor
  thermal: add a virtual sensor to aggregate temperatures

 .../thermal/virtual,thermal-sensor.yaml       |  67 +++
 drivers/thermal/Kconfig                       |   8 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/virtual-sensor.h              |  51 +++
 drivers/thermal/virtual_sensor.c              | 400 ++++++++++++++++++
 include/dt-bindings/thermal/virtual-sensor.h  |  15 +
 6 files changed, 542 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
 create mode 100644 drivers/thermal/virtual-sensor.h
 create mode 100644 drivers/thermal/virtual_sensor.c
 create mode 100644 include/dt-bindings/thermal/virtual-sensor.h

-- 
2.31.1

