Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0630B354954
	for <lists+linux-pm@lfdr.de>; Tue,  6 Apr 2021 01:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbhDEXmA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Apr 2021 19:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbhDEXl7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Apr 2021 19:41:59 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01661C06174A;
        Mon,  5 Apr 2021 16:41:51 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e7so14290341edu.10;
        Mon, 05 Apr 2021 16:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B35rLoHmGQZLUMghM7yXpUEqwEattMshTSUNBkk8ekI=;
        b=EJe8ieHqHTtUPoTrMsRzrepU1dBfY0166Z0ooZeyGWUuRQV0w53Q6UqSE2FPPL3EKs
         62+Apa+4PlcN9NB4LAtMfnYVNHJnEsIpF5X9Rr1Vo79oCICfiGAz6ifF/dTKm5bbSHSR
         zPdpddnxaVTM5BvYfJxHVSoLtMIAMMwsYfTAhgEl4lN1eMJs2otPhzcfRsrQXZaZkTyI
         07azUgr2Av5kddzqzKWPyujtXETMEygQtOlhPL1nth4fWBdJ+uI4aTLWnhIBuaXx8QRp
         P7Fi6AEn+VVUdZsb3XUwRBVKWqdYzst4+DXDyeykBseD+6mYxi9UitmUkD6hjI0SFgsO
         GkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B35rLoHmGQZLUMghM7yXpUEqwEattMshTSUNBkk8ekI=;
        b=SDGa6Mp5EfFkizLMPIm5ru9zCBNaODfb0ZGYEAAKSuf1YyFsyeZ/Avy+aBGMBKLHip
         aKvdZlN7lJBzqx8he2jXyVc50DE90WDPpFmGfaCFP/erR+cOb0jLDYLo9bivYB6CQ0dM
         sjcLigzRO31qx1GSubYFGEC1CYsaqIyR2VVsQgQZ5ny03tctotsre1k7/pbrs0D147kG
         f++iADXIjGmMqN+rsahkD5TwzqVR91n0uS0Igxi0/+fVmL2z0iH116w5pIhYr7Zf8xgs
         q1p5TGreuMjjikwB43b0SkoGXlQoF0kkUQtaEaStHUpy4s85Rz5SVJkfzVP8hdpNjngR
         ZR/g==
X-Gm-Message-State: AOAM533vJbT1ee5ICdiOcVmFvoNnduIxudEUTCXsW7i0MU7o2YeYuqRj
        vlOU/fbcOGmq4RuC7tdoses=
X-Google-Smtp-Source: ABdhPJzIIsI2v+IDIEqVU2n4+uXqO4tuIzwG2MNMCPSAseBCM/PDOMjxAvEURORC8/vxFGSnmNxwNw==
X-Received: by 2002:a05:6402:441:: with SMTP id p1mr21112671edw.298.1617666109821;
        Mon, 05 Apr 2021 16:41:49 -0700 (PDT)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id h21sm4747963ejb.31.2021.04.05.16.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 16:41:49 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] power: supply: Add battery and AC drivers for Surface devices
Date:   Tue,  6 Apr 2021 01:41:24 +0200
Message-Id: <20210405234126.667532-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series provides battery and AC drivers for Microsoft Surface
devices, where this information is provided via an embedded controller
(the Surface System Aggregator Module, SSAM) instead of the usual ACPI
interface.

Specifically, 7th generation Surface devices, i.e. Surface Pro 7,
Surface Book 3, Surface Laptop 3, as well as the Surface Laptop Go use
this new interface.

Note: This series depends on the

    platform/surface: Add Surface Aggregator device registry

series. More specifically patch

    platform/surface: Set up Surface Aggregator device registry

The full series has been merged into the for-next branch of the
platform-drivers-x86 tree and is available as immutable tag at

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-surface-aggregator-v5.13-1

Maximilian Luz (2):
  power: supply: Add battery driver for Surface Aggregator Module
  power: supply: Add AC driver for Surface Aggregator Module

 .../ABI/testing/sysfs-class-power-surface     |  15 +
 MAINTAINERS                                   |   8 +
 drivers/power/supply/Kconfig                  |  32 +
 drivers/power/supply/Makefile                 |   2 +
 drivers/power/supply/surface_battery.c        | 865 ++++++++++++++++++
 drivers/power/supply/surface_charger.c        | 282 ++++++
 6 files changed, 1204 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-surface
 create mode 100644 drivers/power/supply/surface_battery.c
 create mode 100644 drivers/power/supply/surface_charger.c

-- 
2.31.1

