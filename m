Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B668F25F106
	for <lists+linux-pm@lfdr.de>; Mon,  7 Sep 2020 01:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIFXKH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Sep 2020 19:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgIFXKD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Sep 2020 19:10:03 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB233C061573;
        Sun,  6 Sep 2020 16:10:02 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y4so13930402ljk.8;
        Sun, 06 Sep 2020 16:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y/VuS+WEWq6WlqEUQXf1nqdiTpeCGfHiQU7o7A2icY4=;
        b=cJAmzQ39wDBgbxuZxueEjgV8QVTHcMeXnmx3OudE85UX9W3ry0V5R672kQwFgDXJ5W
         PR3q6pq4t5ZebwjcS9EuE/7+XHypAbNjgNUmJU24/cg9mrxOrWWKLZjU725L38O8OwTp
         u9drca/TuRDQZq+Xk+ZyN71XBQ8pyRCY45jadCrTYfexOa8JMKvK7GRhm8Qc7eXUkn26
         i77GUdW53jk+Oc5UqwApkaarAH9Hdv4SU9tNAONDSzaT+/FeBr5KW+OFI2UEe+YzWRUq
         3LhIn+MK6NScuuT2fcsO6HUhbdaUOTh1z4006pyu/HiKmGQd/uh4VlLDfToITyObI1Am
         uWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y/VuS+WEWq6WlqEUQXf1nqdiTpeCGfHiQU7o7A2icY4=;
        b=LHoIZy7lBoB49oskmV8m5emtfHXLlZJ+aDrP/jgDm/C/Zbz/cWoves3J1Sq0bkkFdz
         h1KeB8nHVwpokgIifl/g4AlRKxBWaY37nMJ08KVBUbbSGqu/ZbrXwGBo2iyRNLUzbMnT
         kayGdAz1xzxAHdM1AJ9reyGhZDKV4IAkc6LzcCp9mQ2QxFVxFz+SxWKCSGag022geMx8
         BJK7Y5g5f7ZCeAukiROO0WDtG6j8IWLQDn8XFuyI/5Sf+OhYigYTVq5OvMZ6axQlhyvT
         gIxyrReuoyPXHvyy1ddVnpxKkjzjOnESRbqk9j4LLdabGsYiyHXNnbSORnxDuSoKZZCI
         vIUQ==
X-Gm-Message-State: AOAM530bNQ3afWFKVCmqtyQmCBwnXTD9offsxlsq1dxQycqQT1Q7efeU
        e+SaSU6GrTZnKcwlxYWdmd8=
X-Google-Smtp-Source: ABdhPJwNyce+VA5wGrCXOf+PqHoSye1C4DUgMCkd14tq6Y7v739twOpNPpuL74h/6NdwijCcQIePMw==
X-Received: by 2002:a05:651c:1193:: with SMTP id w19mr8453804ljo.89.1599433801002;
        Sun, 06 Sep 2020 16:10:01 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r17sm1325984ljp.117.2020.09.06.16.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 16:10:00 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/3] arm_scmi: Constify ops pointers in struct scmi_handle
Date:   Mon,  7 Sep 2020 01:04:49 +0200
Message-Id: <20200906230452.33410-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A small patch series aiming to constify static scmi_*_ops structs in
drivers/firmware/arm_scmi. Since these are not modified, constify them
to allow the compiler to put them in read-only memory.

Rikard Falkeborn (3):
  cpufreq: arm_scmi: Constify scmi_perf_ops pointers
  firmware: arm_scmi: Constify ops pointers in scmi_handle
  firmware: arm_scmi: Constify static scmi-ops

 drivers/cpufreq/scmi-cpufreq.c      |  6 +++---
 drivers/firmware/arm_scmi/clock.c   |  2 +-
 drivers/firmware/arm_scmi/common.h  |  2 +-
 drivers/firmware/arm_scmi/mailbox.c |  2 +-
 drivers/firmware/arm_scmi/notify.c  |  2 +-
 drivers/firmware/arm_scmi/perf.c    |  2 +-
 drivers/firmware/arm_scmi/power.c   |  2 +-
 drivers/firmware/arm_scmi/reset.c   |  2 +-
 drivers/firmware/arm_scmi/sensors.c |  2 +-
 drivers/firmware/arm_scmi/smc.c     |  2 +-
 include/linux/scmi_protocol.h       | 12 ++++++------
 11 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.28.0

