Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3ED3331B6A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 01:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhCIAGI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 19:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbhCIAFj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 19:05:39 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A6EC06174A;
        Mon,  8 Mar 2021 16:05:39 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id e10so13265077wro.12;
        Mon, 08 Mar 2021 16:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L5e+Dqx5oV5slrTGbLaugu01HFMhPchgspXa5P+rEow=;
        b=XpqFqGIbkOfY0JP824cDolTDvpGWg0BNFSwq3Tq5jJ+ULj0A+wABLY86aygY4RJe6n
         7XymkthqaIAlDGOIdpmtsI2o1jBS94pwP9UGnl1Zj4BRrMjPSDqHWu073kPth91BN70a
         FWtLm+Kb6dBXLdiyWsK48olJNWFE1A0nQAuNqTvimLIVnUr7XWSUzwyTTRTUSVkdHd/c
         koLMLp/hwxOPD9s6nKITwsV3Rb0Ry7YG2XbGqb4wTnNIzVHHG2lxviz4x+0dCkZAVdgB
         cMSOVfQKbR6CF1xG8BA41DbkNUxVHFCAlpGQeskMuRLMxctKl9CDexVtfRVOWMQFY1L5
         sR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L5e+Dqx5oV5slrTGbLaugu01HFMhPchgspXa5P+rEow=;
        b=itgdPfYTW2gtd40yxLsLvwZ+E1U/gTbQ860EBMnOOZ7/Sp23JNGMyPaXJsxSgsPy97
         7IRbIJcsNN0ArAvfNoZ1FpPffZKy7tCKhmsPkbIH9w8OMupn8Nu8+je+FFwPg2RWlUCH
         Ps4+XJ76bIiTDSxwtkb8cYn8a+My1Y+b3K8o2jLou87EGsXxr3yNtgSKvvCqNFjnBz5c
         B//Tc4nfAMQ7M7OVsxK+kFVLw8O8/aVRMTnaU80HUFjblXrwxEQji4j2ty9uQV0XNI1J
         rwh49MuGIqo1PZoqha/uSaisB51u5XEwUCRqDbPVCtKURAmF2U8ZLgKBiebOdyev9Vcy
         CY5w==
X-Gm-Message-State: AOAM533P2X/28BD3QEeMGpeAHEIjaPWxP3O8lhz+OB1Np129o77Z5dVQ
        RrKUtBpzKzlTSUNkfxoxGfs=
X-Google-Smtp-Source: ABdhPJxIVU8S7grx38ZAx4jAvvdeGXkZjlqvrLk2RZIWG7Wsw0brcv+KWrjiYOADGFYsdvvoiB8ceA==
X-Received: by 2002:a5d:6c66:: with SMTP id r6mr25239962wrz.407.1615248338250;
        Mon, 08 Mar 2021 16:05:38 -0800 (PST)
Received: from xws.localdomain (pd9ea322b.dip0.t-ipconnect.de. [217.234.50.43])
        by smtp.gmail.com with ESMTPSA id 75sm1333623wma.23.2021.03.08.16.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 16:05:37 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] power: supply: Add battery and AC drivers for Surface devices
Date:   Tue,  9 Mar 2021 01:05:28 +0100
Message-Id: <20210309000530.2165752-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.1
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
platform-drivers-x86 tree [1]. The commit in question can be found at
[2].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=for-next&id=fc622b3d36e6d91330fb21506b9ad1e3206a4dde

Maximilian Luz (2):
  power: supply: Add battery driver for Surface Aggregator Module
  power: supply: Add AC driver for Surface Aggregator Module

 MAINTAINERS                            |   8 +
 drivers/power/supply/Kconfig           |  32 +
 drivers/power/supply/Makefile          |   2 +
 drivers/power/supply/surface_battery.c | 901 +++++++++++++++++++++++++
 drivers/power/supply/surface_charger.c | 296 ++++++++
 5 files changed, 1239 insertions(+)
 create mode 100644 drivers/power/supply/surface_battery.c
 create mode 100644 drivers/power/supply/surface_charger.c

-- 
2.30.1

